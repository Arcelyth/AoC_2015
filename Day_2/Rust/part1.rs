use std::fs::File;
use std::io::{BufRead, BufReader, Error};
use std::collections::HashSet;

fn main() -> Result<(), Error>{
    let path = "../input";
    let file = File::open(path)?;
    let reader = BufReader::new(file);
    let mut sum: i64 = 0;
    for line in reader.lines() {
        let nums: Vec<i64> = line?.split('x').collect::<Vec<_>>().iter()
            .map(|x| x.parse::<i64>().unwrap()).collect();
        let products: Vec<i64> = nums
            .iter()
            .enumerate()
            .flat_map(|(i, &x)| {
                nums[i + 1..].iter().map(move |&y| x * y)
            })
            .collect();
        let small = products.iter().fold(products[0], |cur , &x| if (x < cur) {x } else { cur});
        sum += products.iter().fold(0, |acc, &x | 2 * x + acc) + small;
    }
    println!("{}", sum);
    Ok(())
}
