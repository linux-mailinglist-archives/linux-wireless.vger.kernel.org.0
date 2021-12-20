Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2DA47A78D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 11:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhLTKDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 05:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLTKDT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 05:03:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E84C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 02:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05DDBB80E05
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 10:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8EAC36AE8;
        Mon, 20 Dec 2021 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639994596;
        bh=7q960TtBQtLEjZcEsfDLduz3/FfWr8tXOE3lKEdXX1M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kuhhWJpb0b72RY1yt4eRHsBdWpf0jg2+81JpEB3EE4gMc/zov0YyuFsYEmlEQO8DT
         leZU1W08uJJwH3gQdPflKmq0ppwnaTDuDhtlV9zDlEG5UDwcPKoPzwxQsTXa8MbXym
         U4GnikOUrgpLacSKbe1KUnbqbDHF0TNzaLkiv3VvV5iWrTwrJLQPqAH4xu8ZzSJ9dy
         QCE6dG+BFuoJ6Z3SSCDDQaNHDRRrjVtbrF5BuIIUhDoi79meuu1yfEgAxmiJJmMG7u
         F0oVn1hPkdXsKT4Omu5ts7dHGGs5QF6fLIkf26UOFDeYL2yy7ZW1pQeuloxsi2cj5p
         PagMjsMJf588A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <87lf0tydad.fsf@codeaurora.org>
        <4f28496abae7743ab2a9fa7150c5d64c@codeaurora.org>
        <2102838.219ycuhFCz@sven-l14>
Date:   Mon, 20 Dec 2021 12:03:08 +0200
In-Reply-To: <2102838.219ycuhFCz@sven-l14> (Sven Eckelmann's message of "Sat,
        18 Dec 2021 09:37:02 +0100")
Message-ID: <871r27bnkz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

>> On Thursday, 9 December 2021 17:05:14 CET Kalle Valo wrote:
>>> Isn't ath11k WMI commands and events supposed to be in CPU
>>> endian and the firmware automatically translates them if CPU is little
>>> or big endian? 
> [...]
> On Friday, 17 December 2021 12:04:45 CET Carl Huang wrote:
>> Both cpu and firmware are supposed to be little endian in ath11k.
>
> I hope this statement is incorrect. But if it isn't:
>
> You cannot limit a non-architecture dependent driver to be only used by little 
> endian CPUs. This would be grave bug in ath11k.
>
> If your firmware requires wmi messages and similar things in little endian 
> then you have to mark types correctly as big/little endian. E.g. __le32 
> instead of u32. And then you have to convert everything manually with 
> cpu_to_le32 and so on. See the ath10k code for examples.
>
> Tools like sparse can assist you in your search for problematic places when 
> your kernel has the __CHECK_ENDIAN__ related code activated. This is the 
> default for kernels >= 4.10.

This is what I would have preferred to do in ath11k as well but a lot of
people preferred the firmware conversion method as the proprietary
driver uses the same, so I yielded. ath11k should work on big endian
cpus, but to my knowledge nobody has tested it so I do not know if it
really works or not. If someone can test please do let me know, I am
very curious to know if it really works.

ath11k enables the firmware swap feature like this:

/* Host software's Copy Engine configuration. */
#ifdef __BIG_ENDIAN
#define CE_ATTR_FLAGS CE_ATTR_BYTE_SWAP_DATA
#else
#define CE_ATTR_FLAGS 0
#endif

Also grep for BIG_ENDIAN, few functions have that.

> If Kalle' statement is true that the firmware takes care of endianness 
> translation of WMI messages to host endianness, then your code would still be 
> questionable:
>
>>> +       /* supplicant expects big-endian replay counter */
>>> +       replay_ctr = cpu_to_be64(le64_to_cpup((__le64 
>>> *)ev->replay_counter));
>
> Why isn't the firmware taking care of the conversion at that place?
>
> Why are you defining it as `u8 replay_counter[GTK_REPLAY_COUNTER_BYTES];` in 
> the struct instead of using `__le64 replay_counter;`?
>
> What ensures that this is value is 64 bit aligned in memory? Wouldn't it be 
> more correct to (see above) use
>
>     replay_ctr = cpu_to_be64(get_unaligned_le64(ev->replay_counter));

Yeah, if the host does the conversion we would use __le64. But at the
moment the firmware does the conversion so I think we should use
ath11k_ce_byte_swap():

/* For Big Endian Host, Copy Engine byte_swap is enabled
 * When Copy Engine does byte_swap, need to byte swap again for the
 * Host to get/put buffer content in the correct byte order
 */
void ath11k_ce_byte_swap(void *mem, u32 len)
{
	int i;

	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
		if (!mem)
			return;

		for (i = 0; i < (len / 4); i++) {
			*(u32 *)mem = swab32(*(u32 *)mem);
			mem += 4;
		}
	}
}

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
