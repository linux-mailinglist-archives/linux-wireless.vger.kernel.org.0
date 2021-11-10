Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF244C379
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 15:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhKJPAc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 10:00:32 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:40260 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhKJPA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 10:00:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636556260; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dmIHW85tjPyxELq9nBNqjGH0mPhL4e4EOmNfAyJp0cs=; b=c+MTui/krbmzHbPtt3iHfLSFCyNHYJ2mWgnXgYl7YnYsWcw3Rd46LsEd6fxZqvdsepximL2G
 xcGjSMCO8PVTBwmLS0irX+r3iNhMeLky8mjFwxORLlLUUiqTPxx50vdZM39Nipi2L/3Lc/Ww
 B8fs2wrQFlz0oVi01ot2eig6B1Y=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 618bddbca4b510b38f197fe8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Nov 2021 14:57:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7573C43616; Wed, 10 Nov 2021 14:56:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32A49C4338F;
        Wed, 10 Nov 2021 14:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 32A49C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Zekun Shen <bruceshenzk@gmail.com>
Cc:     Pontus Fuchs <pontus.fuchs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ar5523: Fix null-ptr-deref with unexpected WDCMSG_TARGET_START  =?ISO-8859-1?Q?=20r?=
        =?ISO-8859-1?Q?eply=1B?=
References: <YXsmPQ3awHFLuAj2@10-18-43-117.dynapool.wireless.nyu.edu>
        <87tuh0xz9h.fsf@tynnyri.adurom.net>
        <YXv82KfKCW3eHhE6@Zekuns-MBP-16.fios-router.home>
Date:   Wed, 10 Nov 2021 16:56:52 +0200
In-Reply-To: <YXv82KfKCW3eHhE6@Zekuns-MBP-16.fios-router.home> (Zekun Shen's
        message of "Fri, 29 Oct 2021 09:53:28 -0400")
Message-ID: <87czn8m53f.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zekun Shen <bruceshenzk@gmail.com> writes:

> On Fri, Oct 29, 2021 at 06:53:30AM +0300, Kalle Valo wrote:
>> Zekun Shen <bruceshenzk@gmail.com> writes:
>> 
>> > Unexpected WDCMSG_TARGET_START replay can lead to null-ptr-deref
>> > when ar->tx_cmd->odata is NULL. The patch adds a null check to
>> > prevent such case.
>> >
>> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>> >  ar5523_cmd+0x46a/0x581 [ar5523]
>> >  ar5523_probe.cold+0x1b7/0x18da [ar5523]
>> >  ? ar5523_cmd_rx_cb+0x7a0/0x7a0 [ar5523]
>> >  ? __pm_runtime_set_status+0x54a/0x8f0
>> >  ? _raw_spin_trylock_bh+0x120/0x120
>> >  ? pm_runtime_barrier+0x220/0x220
>> >  ? __pm_runtime_resume+0xb1/0xf0
>> >  usb_probe_interface+0x25b/0x710
>> >  really_probe+0x209/0x5d0
>> >  driver_probe_device+0xc6/0x1b0
>> >  device_driver_attach+0xe2/0x120
>> >
>> > Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>
>> 
>> How did you test this?
>
> I found the bug using a custome USBFuzz port. It's a research work
> to fuzz USB stack/drivers. I modified it to fuzz ath9k driver only,
> providing hand-crafted usb descriptors to QEMU.
>
> After fixing the code (fourth byte in usb packet) to WDCMSG_TARGET_START, 
> I got the null-ptr-deref bug. I believe the bug is triggerable whenever
> cmd->odata is NULL. After patching, I tested with the same input and no
> longer see the KASAN report.

Ok, so you didn't test this on a real device at all. I'll mention that
in the commit log and also copy what you wrote above.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
