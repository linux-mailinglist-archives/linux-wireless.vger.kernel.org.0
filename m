Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672C318894F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 16:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCQPlK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 11:41:10 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:55808 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbgCQPlK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 11:41:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584459669; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=hAa5aOWrpzLjwmuDQMB+B+98TXjJAZrESYN3V9rFPWs=; b=GGPTrBkSgSwavc+4pz9bDblCdOJz/IIlEsR0+6YGXYjwajuIHPgvRCNn5+H9PTsyu/m0K8ah
 VgK0Za5T+7NOsIwzvzQwPLzUt1riNWvcgW9/RRS2A8yGSANTVuSdONWcjf7s3qIj7NvqfvV9
 LckmR/fxSHUffJVE2qALn1SSrP8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e70ef8f.7f4410cb7180-smtp-out-n03;
 Tue, 17 Mar 2020 15:41:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5C0CC433BA; Tue, 17 Mar 2020 15:41:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11387C433CB;
        Tue, 17 Mar 2020 15:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11387C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris\@chromium.org" <briannorris@chromium.org>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
References: <20200313065114.23433-1-yhchuang@realtek.com>
        <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
        <2e492e530d744713871f885e324106ef@realtek.com>
        <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
        <ce990869ebf0478d98cd7e8416b36289@realtek.com>
Date:   Tue, 17 Mar 2020 17:40:58 +0200
In-Reply-To: <ce990869ebf0478d98cd7e8416b36289@realtek.com> (Tony Chuang's
        message of "Tue, 17 Mar 2020 10:32:58 +0000")
Message-ID: <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

> // Add Johannes for commenting on adding another nl80211 commands
>
> Kalle Valo <kvalo@codeaurora.org> writes:> 
>
>> Tony Chuang <yhchuang@realtek.com> writes:
>> 
>> > Kalle Valo <kvalo@codeaurora.org> writes:
>> >
>> >> <yhchuang@realtek.com> writes:
>> >>
>> >> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >> >
>> >> > It is useful to fix the bit rate of TX packets. For example, if
>> >> > someone is measuring the TX power, or debugging with the issues
>> >> > of the TX throughput on the field.
>> >> >
>> >> > To set the value of fixed rate, one should input corresponding
>> >> > desc rate index (ex, 0x0b for DESC_RATE54M to fix at 54 Mbps).
>> >> > Set a value larger than DESC_RATE_MAX will disable fix rate, so
>> >> > the rate adaptive mechanism can resume to work.
>> >> >
>> >> > Example,
>> >> >   To fix rate at MCS 1:
>> >> >   echo 0x0d > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>> >> >
>> >> >   To not to fix rate:
>> >> >   echo 0xff > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>> >> >
>> >> >   To know which rate was fixed at:
>> >> >   cat /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>> >> >
>> >> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >>
>> >> No way, debugfs is not a method for working around nl80211 and doing
>> >> whatever idea you come up with. The goal is that we have a generic
>> >> nl80211 command for all generic actions, like this one. And I think we
>> >> already have an nl80211 command for fixing the tx rate, right?
>> >>
>> >
>> > No, as I can see, there's no suitable nl80211 command that can achieve
>> > what I want. If you are saying about
>> NL80211_CMD_SET_TX_BITRATE_MASK,
>> > it's used to allow some rates. But actually the firmware has its own rate
>> > adaptive mechanism, so mask out the other rates does not mean the rate
>> > left will be chosen. Moreover, the hardware will choose a lower bit rate
>> > when retry, then the TX rate is not fixed at all. So the debugfs can disable
>> > the firmware's RA mechanism, also disable the TX rate fall back when retry.
>> > Both of them cannot be done by setting TX bitrate mask.
>> 
>> I'm confused, here you talk about firmware implementation etc but I'm
>> just talking about replacing the fix_rate debugfs file to an nl80211
>> command (for providing the fix_rate value). Can you clarify more why you
>> think nl80211 is not suitable?
>
> Oops, I thought that you wanted me to use the existing nl80211
> command.

Either use an existing nl80211 command or add a new one if needed. For
me most important is that we don't add hacks to debugfs just for
avoiding using nl80211.

> Now I know that you think we can add a new nl80211 command to help
> drivers to fix the TX bitrate if necessary. If adding another nl80211
> command for that is acceptable, I can work on this. But I need
> Johannes's comment if it's better to add a new nl80211 command or to
> expand the existing command (ex. NL80211_CMD_SET_TX_BITRATE_MASK).

_Why_ is NL80211_CMD_SET_TX_BITRATE_MASK not suitable for you? You keep
saying that but I have still figured out why exactly you think so.
Please clarify this in detail. 

> It looks like that adding a new nl80211 command will be better for me
> as expanding the existing one would have great impact on the already
> distributed drivers/user-tools.

What kind of great impact are you talking about? Please be specific so
that we don't need to guess.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
