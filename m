Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D947A8FE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 12:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhLTLvD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 06:51:03 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:41202 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhLTLvC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 06:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1640001061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GA8JQx/SRdXWNyvRJZI6IgUTJdC3q/GraShMOvVmfQ4=;
        b=ZRQSKezfVOiLgW7MUCRZZmZohakFTPrZonMte0j0tV4ixtpxbP2Yd9D4cFyBRRbMlFpS6J
        0zkOBG+/IXt/X0GJW1oFvTVaYBzfwib59FPEZjXbUqVyPPWpACHdjMi+z+fPhcqG3/kS6K
        he7fiFu5k9iej7lRUfMb6Nyc0xQrDcw=
From:   Sven Eckelmann <sven@narfation.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date:   Mon, 20 Dec 2021 12:50:55 +0100
Message-ID: <1934542.dmet8VCoWv@sven-l14>
In-Reply-To: <871r27bnkz.fsf@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <2102838.219ycuhFCz@sven-l14> <871r27bnkz.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3309310.PNGyNpqY9y"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3309310.PNGyNpqY9y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date: Mon, 20 Dec 2021 12:50:55 +0100
Message-ID: <1934542.dmet8VCoWv@sven-l14>
In-Reply-To: <871r27bnkz.fsf@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <2102838.219ycuhFCz@sven-l14> <871r27bnkz.fsf@codeaurora.org>

On Monday, 20 December 2021 11:03:08 CET Kalle Valo wrote:
[...]

Thanks for all the explanation and pointers. I will try to use this to more 
clearly formulate my concern.

If I understood it correctly then ev->replay_counter is:

* __le64 on little endian systems
* __be64 on big endian systems

Or in short: it is just an u64.

> Yeah, if the host does the conversion we would use __le64. But at the
> moment the firmware does the conversion so I think we should use
> ath11k_ce_byte_swap():
> 
> /* For Big Endian Host, Copy Engine byte_swap is enabled
>  * When Copy Engine does byte_swap, need to byte swap again for the
>  * Host to get/put buffer content in the correct byte order
>  */
> void ath11k_ce_byte_swap(void *mem, u32 len)
> {
> 	int i;
> 
> 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
> 		if (!mem)
> 			return;
> 
> 		for (i = 0; i < (len / 4); i++) {
> 			*(u32 *)mem = swab32(*(u32 *)mem);
> 			mem += 4;
> 		}
> 	}
> }

This function doesn't work for 64 bit values (if they are actually in big 
endian). It just rearranges (len / 4) u32s to host byte order - so the upper 
and lower 32 bit values for an u64 would still be swapped.

Unless I misunderstood what CE_ATTR_BYTE_SWAP_DATA is supposed to do. Maybe it 
is not causing returned data to be in big/little endian but causes for one of 
the host endianess' that the data for 64-bit values in mixed endianness.

And if the function would operate on a struct with 16 bit or 8 bit values then 
we have something which we call here Kuddelmuddel [1].



But if the value is an u64, then the code in the patch is wrong:

> /* supplicant expects big-endian replay counter */
> replay_ctr = cpu_to_be64(le64_to_cpup((__le64 *)ev->replay_counter));

This would break on big endian architectures because ev->replay_counter is a 
__be64 and not a __le64 on these systems. Just from the way the byte ordering 
is supposed to look like - not the data type for the C-compiler).

If you have a look at what the code does (beside 64 bit load by _cpup), is 
just to add a single swap64 - either by cpu_to_be64 or by le64_to_cpup - 
depending on whether the host system is little endian or big endian.

So for a __le64, it would (besides the incorrectly aligned 64 bit load from 
struct wmi_gtk_offload_status_event),  do a single swap64 to __be64. This 
swap64 is from cpu_to_be64 and le64_to_cpup doesn't swap anything.

But on a big endian system, the __be64 would also be sent through a swap64 
(from le64_to_cpup) and cpu_to_be64 wouldn't swap anything. So at the end, it 
would be a __le64. So something which conflicts with the comment above this 
code line.


There are now various ways to correctly implement it:

* change replay_counter to an u64 in the (packed) struct and:

      replay_ctr = cpu_to_be64(ev->replay_counter);

* keep it as u8[8] in the struct and make sure yourself that an unaligned-safe
  64 bit load is used:

      replay_ctr = cpu_to_be64(get_unaligned((u64 *)ev->replay_counter));


Kind regards,
	Sven


[1] It is something like "jumble" or "mess"
--nextPart3309310.PNGyNpqY9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHAbh8ACgkQXYcKB8Em
e0boxg/+O3G/C7Y2sJlXwM4w2HUfyLc70l1j5N9ltzUMjSsa65knAMU7xm9QIyh3
pZWDAjdX6es5v6eK0G43otA00oTK0H9tSKidBi+wa/pLmhBBA9NB0W7j0Q43Lryo
othZOf01mTjdNCB7CIsm7x8gToLWn5zsq9kvW/Nmj7DnuC7C+Js4eJEWZzaOcsnX
bTkrmb8H1zQnfk5CQo2cjC4oMK660IUjUYAw853ETyZz4E3hv97N99/9zcKvXkmk
rPEOWOCTYisKwpDeokMDbk+FHYHXLkcjku30o2vtQqY/EBb0LyT51sFejQOBZryL
N5K8AJuoTjZAT/s5JxCm44EFGF7+lpUCjK8uv7olwwNacEpYFQNtzD52riXN+lEh
kR7OSuOIdY+HjjkwkmeJbdZ0T6p84rwFrX9RMi/eu33y9oIx0rzegTNsVrglSIh/
3xOHUYWHSl4usKAGKiF8BUwKvPrGzPfFIU6W3My5JFBiNUbXEmXoEYH5bq8UN0Wd
MXupMkTl9Frnx8/mxnrcJSM34qDdAPC5kBHkzFxsSZ7Whn6FtGTJtvPPgoPcqCsV
MvXwnTWjXcv7cHDVIgmRV3DtDY1PBFZx+57z2L/c2Mj/dDNIpfMb9VMFd/pq0e99
UJ6BVkOheo3CDL1tTysyai82qJvgRtDwVwDDU1z5zOsneiGR8JY=
=8lrz
-----END PGP SIGNATURE-----

--nextPart3309310.PNGyNpqY9y--



