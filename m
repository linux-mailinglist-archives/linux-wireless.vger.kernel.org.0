Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D361D08FA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 08:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgEMGuZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 02:50:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13235 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729410AbgEMGuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 02:50:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589352624; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=RWGNo+h1F7wmSA2OG3rwpi2qn7Oa+PH+QB/t0CyZYE4=; b=M8op78x5nWcP54PpD9fslXNkrMpNtwfsiLijEzimy3T9RekOcmng6n1IWTaISSDzJXMSIc6g
 mi4faGtbHosO1ZJs204K9JEjVsKY2v2HtpaxhS/wfbdTb/01WcmhjX70y+QFGrAVNHI5f2xc
 sdpaEYO9cw8UxiOc2Iyo6c6vkAI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebb98a0.7fbb800a6ea0-smtp-out-n04;
 Wed, 13 May 2020 06:50:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A2DFC433D2; Wed, 13 May 2020 06:50:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87360C433F2;
        Wed, 13 May 2020 06:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87360C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: gcc-10: kernel stack is corrupted and fails to boot
References: <20200509120707.188595-1-arnd@arndb.de>
        <20200509120707.188595-2-arnd@arndb.de>
        <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
        <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
Date:   Wed, 13 May 2020 09:50:03 +0300
In-Reply-To: <87r1vq4qev.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Mon, 11 May 2020 15:17:12 +0300")
Message-ID: <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(trimming CC, changing title)

Kalle Valo <kvalo@codeaurora.org> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>>> gcc-10 correctly points out a bug with a zero-length array in
>>> struct ath10k_pci:
>>>
>>> drivers/net/wireless/ath/ath10k/ahb.c: In function 'ath10k_ahb_remove':
>>> drivers/net/wireless/ath/ath10k/ahb.c:30:9: error: array subscript 0
>>> is outside the bounds of an interior zero-length array 'struct
>>> ath10k_ahb[0]' [-Werror=zero-length-bounds]
>>>    30 |  return &((struct ath10k_pci *)ar->drv_priv)->ahb[0];
>>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> In file included from drivers/net/wireless/ath/ath10k/ahb.c:13:
>>> drivers/net/wireless/ath/ath10k/pci.h:185:20: note: while referencing 'ahb'
>>>   185 |  struct ath10k_ahb ahb[0];
>>>       |                    ^~~
>>>
>>> The last addition to the struct ignored the comments and added
>>> new members behind the array that must remain last.
>>>
>>> Change it to a flexible-array member and move it last again to
>>> make it work correctly, prevent the same thing from happening
>>> again (all compilers warn about flexible-array members in the
>>> middle of a struct) and get it to build without warnings.
>>
>> Very good find, thanks! This bug would cause all sort of strange memory
>> corruption issues.
>
> This motivated me to switch to using GCC 10.x and I noticed that you had
> already upgraded crosstool so it was a trivial thing to do, awesome :)
>
> https://mirrors.edge.kernel.org/pub/tools/crosstool/

And now I have a problem :) I first noticed that my x86 testbox is not
booting when I compile the kernel with GCC 10.1.0 from crosstool. I
didn't get any error messages so I just downgraded the compiler and the
kernel was booting fine again. Next I decided to try GCC 10.1 with my
x86 laptop and it also failed to boot, but this time I got kernel logs
and saw this:

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_secodary+0x178/0x180

Call Trace:
dump_stack
panic
? _raw_spin_unlock_irqrestore
? start_secondary
__stack_chk_fail
start_secondary
secondary_startup

(I wrote the above messages manually from a picture so expect typos)

Then also on my x86 laptop I downgraded the compiler to GCC 8.1.0 (from
crosstool), rebuilt the exactly same kernel version and the kernel
booted without issues.

I'm using 5.7.0-rc4-wt-ath+ which is basically v5.7-rc4 plus latest
wireless patches, and I doubt the wireless patches are making any
difference this early in the boot. All compilers I use are prebuilt
binaries from kernel.org crosstool repo[1] with addition of ccache
v3.4.1 to speed up my builds.

Any ideas? How should I debug this further?

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
