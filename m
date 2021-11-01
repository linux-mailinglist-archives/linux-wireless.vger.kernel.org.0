Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB53441A59
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Nov 2021 12:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhKALEU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 07:04:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15136 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbhKALEU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 07:04:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635764507; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=q5+g+Fpr9ojaic/Ns1gbfTcZexvkJSORFNk1aokovgQ=; b=bDvOmFbXIzJ7y7PdU6DYvTMbIysQ05RorbjhfN7ZvfNguuhXE8H54rVIdrcI92Ao3iYtttN4
 iisaY5gW7eWhXd8F6AcdgQ7xSz/Mkxxr8RzV11pBnXoMf5C4KnUZw7rKNjZmVntShGSdxYCi
 k7l8Sm429n5JH3+k5LeeOhzH+0c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 617fc8e0c8c1b282a5fef57a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Nov 2021 11:00:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D9599C4338F; Mon,  1 Nov 2021 11:00:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87538C4338F;
        Mon,  1 Nov 2021 11:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 87538C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, tony0620emma@gmail.com,
        linux-wireless@vger.kernel.org, steventing@realtek.com
Subject: Re: [PATCH v2 2/2] rtw88: add debugfs to force lowest basic rate
References: <20210422030413.9738-1-pkshih@realtek.com>
        <20210422030413.9738-2-pkshih@realtek.com>
        <YMPqT8VH5alHQXXA@google.com>
Date:   Mon, 01 Nov 2021 13:00:41 +0200
In-Reply-To: <YMPqT8VH5alHQXXA@google.com> (Brian Norris's message of "Fri, 11
        Jun 2021 15:57:19 -0700")
Message-ID: <87k0hs2l9i.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(replying to an old thread:

https://patchwork.kernel.org/project/linux-wireless/patch/20210422030413.9738-2-pkshih@realtek.com/ )


Brian Norris <briannorris@chromium.org> writes:

> On Thu, Apr 22, 2021 at 11:04:13AM +0800, Ping-Ke Shih wrote:
>> From: Yu-Yen Ting <steventing@realtek.com>
>> 
>> The management frame with high rate e.g. 24M may not be transmitted
>> smoothly in long range environment.
>> Add a debugfs to force to use the lowest basic rate
>> in order to debug the reachability of transmitting management frame.
>> 
>> obtain current setting
>> cat /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
>> 
>> force lowest rate:
>> echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
>> 
>> Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>
> I believe some initial objection to this was because it was unclear if
> this is for "production" use (e.g., recommending distros to play with
> this) or for debugging. I'll admit, I requested the feature for patch 1,
> because I've seen that for those networks where people *do* configure
> odd Basic Rates, they intend for stations to follow those, and not use
> the lowest (and most airtime-hogging) rates.
>
> And I can say, I don't see why distributions should be turning that back
> off. If the Basic Rates setting is wrong, then the that's up to the
> network admin to fix.
>
> All that is to say: I agree that this patch is purely for debugging, as
> stated, and that it belongs in debugfs. I also maintain a distribution,
> and I don't plan on using this beyond debugging.
>
> Therefore:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Ok, fair enough as long as this will not end up normal users using it. I
still would prefer to have extensive bitrate handling via nl80211 but
clearly it's not going anywhere.

But could the debugfs filename be more descriptive, for example
force_basic_rates or something like that?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
