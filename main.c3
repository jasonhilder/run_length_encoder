module rle_enc;
import std::io;
import std::io::file;

const uint BUFFER_SIZE = 100;

fn char[]! file_reader(String filename, char[] buffer)
{   
	File file = file::open(filename, "r")!;
	defer (void)file.close();
	file.read(buffer)!;
	return buffer;
}

fn void file_writer(String filename, char[] buffer)
{   
	io::printn("todo...");
}


fn void! rle_encoder(char[] read_buffer) {
	DString ds = dstring::temp_new();

	char tmp_c;
	uint count = 0;
	foreach(c : read_buffer) 
	{
		if(c != ' ' && c != 0) 
		{

			if(c != tmp_c) 
			{
				if( count > 0 ) 
				{
					ds.appendf("%d", count);
					ds.append_char(tmp_c);
				}

				tmp_c = c;
				count = 0;
			}

			count++;
		}
	}

	File o_file = file::open("out.txt", "w")!;
	defer (void)o_file.close();

	String txt = ds.copy_str();
	defer (void)free(txt);
	o_file.write(txt)!;

	return;
}

fn void rle_decoder() {
	io::printn("todo...");
}

fn void! main(String[] args)
{
	String filename = "test_file.txt";

	char[]! buffer = mem::new_array(char, BUFFER_SIZE);
	defer (void)free(buffer);

	char[]! read_buffer = file_reader(filename, buffer);
	if (catch excuse = read_buffer)
    {
        io::printfn("Excuse found: %s", excuse);
		// Returning `Excuse` using `?` suffix
        return excuse?; 
    }

	rle_encoder(read_buffer)!;
}
