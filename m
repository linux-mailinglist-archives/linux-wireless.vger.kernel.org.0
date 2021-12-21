Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993CA47C1DC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhLUOtA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 09:49:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40270 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbhLUOs7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 09:48:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441A061570
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 14:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAFEC36AE8;
        Tue, 21 Dec 2021 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098138;
        bh=8vHGnwhKlFVmRTByj0rA81VBFGKYpqyMdpDcm9Krgow=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iTjRExKZJszmd3s+uyw0aSdNb189ohkoxTeopT8//nCa9iFxToY6IcyWsRKgiRWZs
         uQlrskmzbQttFoOK8RWWogY01YxOJ0mP06WjeNBoXovw3NyN3V554DPaCxD8gmpGaA
         2vB/mVjORhbd8IppkYrtRLni2nQ8+Fo+yKo2KCb5NyFCwEh7U2uozgz/xpB5/0V0L9
         BG7oWVlSIoywzi6YvNU5Z78za73beWH+DbSLvpsks4gYQUi6IM+csYmC0f2kO7vz6w
         JLQJ2RaFDVi9CVPsplXXaik0mQ+zXPEZU3QKWH57VO+UKmsHFE6kzeIHs2r7KksUS9
         fkW94aXL+Mrkg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <2102838.219ycuhFCz@sven-l14> <871r27bnkz.fsf@codeaurora.org>
        <1934542.dmet8VCoWv@sven-l14>
Date:   Tue, 21 Dec 2021 16:48:53 +0200
In-Reply-To: <1934542.dmet8VCoWv@sven-l14> (Sven Eckelmann's message of "Mon,
        20 Dec 2021 12:50:55 +0100")
Message-ID: <87r1a66mju.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> On Monday, 20 December 2021 11:03:08 CET Kalle Valo wrote:
> [...]
>
> Thanks for all the explanation and pointers. I will try to use this to more 
> clearly formulate my concern.

Good idea, this is too complex.

> If I understood it correctly then ev->replay_counter is:
>
> * __le64 on little endian systems
> * __be64 on big endian systems
>
> Or in short: it is just an u64.

My understanding is that on little endian host it's (the number representing
the byte index):

1 2 3 4 5 6 7 8

And on big endian host it's (as the firmware automatically swapped the
values):

4 3 2 1 8 7 6 5

So for on big endian we need to use ath11k_ce_byte_swap() to get them
back to correct order. (Or to be exact we need to use
ath11k_ce_byte_swap() every time as it does nothing on a little endian
host.)

Completely untested, of course. I don't have a big endian system.

>> Yeah, if the host does the conversion we would use __le64. But at the
>> moment the firmware does the conversion so I think we should use
>> ath11k_ce_byte_swap():
>> 
>> /* For Big Endian Host, Copy Engine byte_swap is enabled
>>  * When Copy Engine does byte_swap, need to byte swap again for the
>>  * Host to get/put buffer content in the correct byte order
>>  */
>> void ath11k_ce_byte_swap(void *mem, u32 len)
>> {
>> 	int i;
>> 
>> 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
>> 		if (!mem)
>> 			return;
>> 
>> 		for (i = 0; i < (len / 4); i++) {
>> 			*(u32 *)mem = swab32(*(u32 *)mem);
>> 			mem += 4;
>> 		}
>> 	}
>> }
>
> This function doesn't work for 64 bit values (if they are actually in big 
> endian). It just rearranges (len / 4) u32s to host byte order - so the upper 
> and lower 32 bit values for an u64 would still be swapped.
>
> Unless I misunderstood what CE_ATTR_BYTE_SWAP_DATA is supposed to do. Maybe it 
> is not causing returned data to be in big/little endian but causes for one of 
> the host endianess' that the data for 64-bit values in mixed
> endianness.

So my understanding is that when CE_ATTR_BYTE_SWAP_DATA is enabled the
firmware automatically swaps the packets per every four bytes. That's
why all the fields in WMI commands and events are u32.

> And if the function would operate on a struct with 16 bit or 8 bit values then 
> we have something which we call here Kuddelmuddel [1].

Heh, need to remember that word :)

> But if the value is an u64, then the code in the patch is wrong:

The firmware interface should not have u16 or u8 fields. And for
anything larger ath11k_ce_byte_swap() should be used. Again, this is
just my recollection from discussions years back and I have not tested
this myself.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
