Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1979747C852
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 21:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhLUUjX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 15:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhLUUjX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 15:39:23 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A08C061574
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 12:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1640119159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSM7HImYG6ODZB2Np83t2NXA/n8bA1WPtvKygXCkFbg=;
        b=Lb+C/3L2aPfkg1XXQxknf4p4TCiiDZRxozsv+dhNW9jy71c1CFwhXjUE5W4toizAy1ISsF
        qpS7nymcOk4EEjqwGJo783ccw6gdSlO6D3K2xK4prn7ClH0qO8FNlenj2UxTbHTstu31wa
        LYjM7lrj6+pAoLyW0CatnibTqoX1Pts=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, quic_cjhuang@quicinc.com,
        Carl Huang <cjhuang@codeaurora.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date:   Tue, 21 Dec 2021 21:39:12 +0100
Message-ID: <2860207.IQqrrufrRN@sven-l14>
In-Reply-To: <87r1a66mju.fsf@kernel.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <1934542.dmet8VCoWv@sven-l14> <87r1a66mju.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13446456.hxzVf8W2Rg"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart13446456.hxzVf8W2Rg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date: Tue, 21 Dec 2021 21:39:12 +0100
Message-ID: <2860207.IQqrrufrRN@sven-l14>
In-Reply-To: <87r1a66mju.fsf@kernel.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <1934542.dmet8VCoWv@sven-l14> <87r1a66mju.fsf@kernel.org>

On Tuesday, 21 December 2021 15:48:53 CET Kalle Valo wrote:
> My understanding is that on little endian host it's (the number representing
> the byte index):
> 
> 1 2 3 4 5 6 7 8
> 
> And on big endian host it's (as the firmware automatically swapped the
> values):
> 
> 4 3 2 1 8 7 6 5
> 
> So for on big endian we need to use ath11k_ce_byte_swap() to get them
> back to correct order. (Or to be exact we need to use
> ath11k_ce_byte_swap() every time as it does nothing on a little endian
> host.)
> 
> Completely untested, of course. I don't have a big endian system.

Ok, just to summarize: the value is 0x0807060504030201 -> which is is 
correctly stored in memory as 0102030405060708 for little endian systems. Fine 
with this part. So if there would only be little endian systems than following 
code would be fine:

     replay_ctr = cpu_to_be64(get_unaligned((u64 *)ev->replay_counter));

According to the info from here, the memory from the firmware on big endian 
systems is 0403020108070605. So after switching it with the ath11k swap 
function, it is back to 0102030405060708 -> which is little endian again (and 
not aligned in memory). We must take care of it by converting in from __le64 
to a u64 before converting it to __be64. So we would end up with:

    __le64 replay_ctr_le;
    __be64 replay_ctr_be;
    u64 replay_ctr;

    /* TODO also swap bytes for (i)gt_key* back to little endian */
    ath11k_ce_byte_swap(ev->replay_counter, sizeof(ev->replay_counter));

    replay_ctr_le = get_unaligned((__le64 *)ev->replay_counter);
    replay_ctr = le64_to_cpu(replay_ctr_le);
    arvif->rekey_data.replay_ctr = replay_ctr;
    replay_ctr_be = cpu_to_be64(replay_ctr);

Of course, completely untested.


Another idea would be to change wmi_gtk_offload_status_event->replay_counter 
into two u32. In that case, it would be enough to do:

   __be64 replay_ctr_be;
    u64 replay_ctr;

    replay_ctr = ev->replay_counter[1];
    replay_ctr <<= 32;
    replay_ctr |= ev->replay_counter[0];

    arvif->rekey_data.replay_ctr = replay_ctr;
    replay_ctr_be = cpu_to_be64(replay_ctr);

replay_counter[1] could also be called replay_counter_upper - and 
replay_counter[0] just replay_counter_lower.


Which reminds me of that the memcpy from a u64 to
wmi_gtk_rekey_offload_cmd->replay_ctrl in ath11k_wmi_gtk_rekey_offload. This 
is of course also wrong. It must first be converted into a __le64 and the 
bytes must be pre-swapped (see below).


> So my understanding is that when CE_ATTR_BYTE_SWAP_DATA is enabled the
> firmware automatically swaps the packets per every four bytes. That's
> why all the fields in WMI commands and events are u32.
[...]
> The firmware interface should not have u16 or u8 fields. And for
> anything larger ath11k_ce_byte_swap() should be used. Again, this is
> just my recollection from discussions years back and I have not tested
> this myself.

Ok, so wmi_gtk_offload_status_event and wmi_gtk_rekey_offload_cmd are breaking 
this assertion because they are full of u8's. :(

Especially wmi_gtk_offload_status_event is problematic here because there are 
now a lot of single u8's in it. The original code must therefore use 
ath11k_ce_byte_swap on everything after
wmi_gtk_offload_status_event->refresh_cnt before accessing any of the members.

And ath11k_wmi_gtk_rekey_offload must perform the ath11k_ce_byte_swap on

* wmi_gtk_rekey_offload_cmd->kek
* wmi_gtk_rekey_offload_cmd->kck
* wmi_gtk_rekey_offload_cmd->replay_ctr

See also above why the memcpy to wmi_gtk_rekey_offload_cmd->replay_ctr is 
wrong in this function.


And it seems like wmi_obss_color_collision_event->obss_color_bitmap (see 
ath11k_wmi_obss_color_collision_event) could suffer from a similar problem.
Maybe key_rsc_counter in ath11k_wmi_vdev_install_key too - but this doesn't 
have any producers yet.

Kind regards,
	Sven


--nextPart13446456.hxzVf8W2Rg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHCO3AACgkQXYcKB8Em
e0ZCLA//b2jwPHDfjNe7G4Q7ZG3uEjiBju+tMLw4KDQvRPIRhGmDUd6ziEK2wGaa
H7cKhz9cXqr6PHYkuRLEYT4853R/v9mv0IeiMlOoX2BmmGMCGfKcvMc5+/8oEAor
L2C8VLjs8MPnBqFwxzqPqT1grO7Piai/TOt1S/PJK3lOi43OCO61Ns9ip1tvFLv1
zLh74sgHA7oMho5RGWwWA0reggkhHabxfsiHjyczcnV0TkoMJbyqd0L10dpw4gl7
fFiF3x9YWTBu00C2kqRu41EMVqJ/tSEJCzWGdxkMPVj3hvERYtsduDm1GZgXZrDp
xvDJffBXf1H2fo8grdG55BHOc59vF8vTj1391FZs9v65tEkD52PQDGJHSbQ2uH8R
CYc9iTbW52Td1Ro2e7wbUE4Pg6CcJxDXT8PsFZ39PuMPfERTj0ULNZ9dTc+d0rSv
lOjXmq0zp/PpVos7P2XnkPmbOaZw1h7DlKZNKpwD8indkn+L02EEKFNwBex/WEIm
hCGOvpry+AjwFQTCDgawpRhFGWKJmIFvmvbXWj0fs4W9GVO422xzQK5i2G+Wr2cd
j5rwS+QooU1QpPY6z+rsLOLYqBLJdfeIT4w0B4jrHeu8XZlCbIploHEOsD9N0/8F
kFp8bupzpY8OW2EbwsHNeyBVsQeGpwVcRLgmoS3u19TfFe9iLO8=
=F+GF
-----END PGP SIGNATURE-----

--nextPart13446456.hxzVf8W2Rg--



