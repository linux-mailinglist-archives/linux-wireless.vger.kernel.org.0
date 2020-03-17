Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20F0187A32
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 08:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgCQHKW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 03:10:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:51094 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgCQHKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 03:10:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584429022; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=pnwrk9E0bFamJOgD4/zr8C1ohgKv4+eH4lSkqaUdyBA=; b=PTWt1iqEmyVoloHgyMFzl006ED7zaHuG2VLj3AQAOWZbPy+MrIY692Rvl3JyNBzSes5ARGqE
 cAJvVQuD578WMerUpM/mhEijXHnZmWcfLB0bO6Dwc8hNDjKr/kIs5mh5eaCK+j+lYT1wEJsD
 Trwe4YBkBpBiAmlTBJxj9jADRyc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7077dd.7f8acaa62068-smtp-out-n01;
 Tue, 17 Mar 2020 07:10:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67B30C432C2; Tue, 17 Mar 2020 07:10:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85009C433CB;
        Tue, 17 Mar 2020 07:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85009C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris\@chromium.org" <briannorris@chromium.org>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
References: <20200313065114.23433-1-yhchuang@realtek.com>
        <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
        <2e492e530d744713871f885e324106ef@realtek.com>
Date:   Tue, 17 Mar 2020 09:10:16 +0200
In-Reply-To: <2e492e530d744713871f885e324106ef@realtek.com> (Tony Chuang's
        message of "Mon, 16 Mar 2020 02:28:05 +0000")
Message-ID: <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> <yhchuang@realtek.com> writes:
>> 
>> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >
>> > It is useful to fix the bit rate of TX packets. For example, if
>> > someone is measuring the TX power, or debugging with the issues
>> > of the TX throughput on the field.
>> >
>> > To set the value of fixed rate, one should input corresponding
>> > desc rate index (ex, 0x0b for DESC_RATE54M to fix at 54 Mbps).
>> > Set a value larger than DESC_RATE_MAX will disable fix rate, so
>> > the rate adaptive mechanism can resume to work.
>> >
>> > Example,
>> >   To fix rate at MCS 1:
>> >   echo 0x0d > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>> >
>> >   To not to fix rate:
>> >   echo 0xff > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>> >
>> >   To know which rate was fixed at:
>> >   cat /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>> >
>> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> 
>> No way, debugfs is not a method for working around nl80211 and doing
>> whatever idea you come up with. The goal is that we have a generic
>> nl80211 command for all generic actions, like this one. And I think we
>> already have an nl80211 command for fixing the tx rate, right?
>> 
>
> No, as I can see, there's no suitable nl80211 command that can achieve
> what I want. If you are saying about NL80211_CMD_SET_TX_BITRATE_MASK,
> it's used to allow some rates. But actually the firmware has its own rate
> adaptive mechanism, so mask out the other rates does not mean the rate
> left will be chosen. Moreover, the hardware will choose a lower bit rate
> when retry, then the TX rate is not fixed at all. So the debugfs can disable
> the firmware's RA mechanism, also disable the TX rate fall back when retry.
> Both of them cannot be done by setting TX bitrate mask.

I'm confused, here you talk about firmware implementation etc but I'm
just talking about replacing the fix_rate debugfs file to an nl80211
command (for providing the fix_rate value). Can you clarify more why you
think nl80211 is not suitable?

> I am sorry I need to add another debugfs for it, but to actually fix the TX
> bitrate, we really need another debugfs or module parameter. Because
> according to the design of the device there is not a good enough general
> command I can use to fix the TX rate. If there is a command that can fix
> the TX bitrate for me, please let me know, I can switch to it.

Sorry, but I'm not yet convinced that a debugfs file is justified.
Fixing a transmit bitrate sounds like a very generic command, not
something which should be in debugfs.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
