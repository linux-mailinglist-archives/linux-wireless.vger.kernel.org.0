Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3F4130B5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhIUJX2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 05:23:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52381 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhIUJX1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 05:23:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632216119; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4+hmr8MTsYxhUBoWgTtkqGJCxvrcnZSiRDUtwqYe5xU=; b=DY3uom4+OkD+YmW8xieyd/bQrsAejroD0lPLIIDyBiFTGRPSOhBL87nqbeq4qmZhs/NyGFlL
 nqNSDjSVF60tnX7MMSfNAJJTCBKxL6Zcw0N9pfKOQrCDX63mlpLVuaZre4Eap1Cmo0cjuISA
 5kAG8K+OMy5s9b/ndvHfa+nwIdM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6149a413b585cc7d24fd89e8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 09:21:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E829EC43616; Tue, 21 Sep 2021 09:21:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5083BC4338F;
        Tue, 21 Sep 2021 09:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5083BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Francesco Magliocca <franciman12@gmail.com>
Cc:     ath10k@lists.infradead.org,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "regressions\@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Bug in Memory Layout of rx_desc for QCA6174
References: <CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com>
Date:   Tue, 21 Sep 2021 12:21:20 +0300
In-Reply-To: <CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com>
        (Francesco Magliocca's message of "Fri, 18 Jun 2021 09:28:51 +0200")
Message-ID: <87o88muvvz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(adding linux-wireless and regression lists)

Francesco Magliocca <franciman12@gmail.com> writes:

> Hello everyone,
> I have a QCA6174 PCIe board, I am using linux kernel 5.12.10.
> The firmware loaded is:
>> [ 4.483131] ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000
>> chip_id 0x00340aff sub 1a56:143a
>> [ 4.483136] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1
>> tracing 0 dfs 0 testmode 0
>> [ 4.483567] ath10k_pci 0000:02:00.0: firmware ver
>> WLAN.RM.4.4.1-00157-QCARMSWPZ-1 api 6 features wowlan,ignore-otp,mfp
>> crc32 90eebefb
>> [    4.572730] ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 318825bf
>> [ 4.665592] ath10k_pci 0000:02:00.0: htt-ver 3.60 wmi-op 4 htt-op 3
>> cal otp max-sta 32 raw 0 hwcrypto 1
>
> around six months ago I reported a bug which is still haunting me:
> When I am connected to my home's Wi-Fi network and my father's Huawei
> smartphone is connected too
> my Wi-Fi card hangs and gets stuck, I have to force restart of the device.
>
> Note that this problem does not happen if my pc and the smartphone are
> connected to different networks (for example
> I tried connecting my pc to the 2.4GHz network and the smartphone to
> the 5GHz network, and the bug does not appear).
>
> Now, I tried bisecting driver changes, and I found the faulty one,
> it is the commit: e3def6f7ddf88636febb12e1e3e86387a4ce5452

Ok, so this is the commit:

commit e3def6f7ddf88636febb12e1e3e86387a4ce5452
Author:     Govind Singh <govinds@qti.qualcomm.com>
AuthorDate: Thu Dec 21 14:30:51 2017 +0530
Commit:     Kalle Valo <kvalo@qca.qualcomm.com>
CommitDate: Wed Dec 27 12:05:35 2017 +0200

    ath10k: Update rx descriptor for WCN3990 target
    
    WCN3990 rx descriptor uses different offset of msdu start, msdu end,
    ppdu end, rx pkt end and rx frag info.
    To accommodate different offsets, define respective fields in
    rx descriptor of WCN3990 target.
    
    Signed-off-by: Govind Singh <govinds@qti.qualcomm.com>
    Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>

> It adds some fields to structures like rx_msdu_start, rx_frag_info, etc..
> The changes modify the size of these structures!
>
> If I revert this commit changes, the bug does not happen
> (I tested it for two weeks, while the bug happens at least once in 2-3 hours
> from when the smartphone is connected to the wifi network).

Good, I was just about to ask about that.

> Also, if I selectively remove some of the changes introduced by the
> faulty commit, the bug does not go away, so it looks like the problem
> is in the change of size of the data structures.

Heh, I was also about to ask about that as well :) The firmware is
supposed to handle length differences but clearly it's not.

> Now, I'd like to ask you what we can do to fix this problem... Is
> there something I am doing wrong? Or is there a bug in the firmware?
>
> If the firmware can't be easily fixed, I was thinking that we can
> abstract the htt_rx_desc (in the same way we do with ops in other
> parts of the driver) to have two versions: one for 32-bit descriptors
> (like my QCA6174) and one for 64-bit descriptors (i.e. WCN3990, which
> was the cause of this change).
>
> I'd be really happy to help, but I am not sure I fully understand what
> is going on, so what do you think is happening and what should we do?

Getting the firmware fixed is difficult. I would first try abstracting
the htt_rx_desc, can you send a patch?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
