Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA5A35C58E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 13:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbhDLLrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 07:47:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14338 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbhDLLrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 07:47:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618228025; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=msZebtXA9b05z7Tg+4Cc4dpEOZJ6TV8Pe6pM1Rj/WN0=; b=RUecQXu1Rsm1X+6W/qJpIypX5Vew4Eiznfu3XFq3NW9yVT1havXdQRoMbTL21jzB/9q9+w3j
 HGAik2FXImt56CJekwVie8Ak8n1Mur0cN5dBe382KvbkmFmBpVjnZT1p93brD2qCLj25ZEQU
 BYG1K3OyUhK4Eoy7gaplFh2k1XQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6074332fe0e9c9a6b686e470 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Apr 2021 11:46:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1A0DC433C6; Mon, 12 Apr 2021 11:46:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0720FC433ED;
        Mon, 12 Apr 2021 11:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0720FC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "tony0620emma\@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        DeanKu <ku920601@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: Re: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
References: <20210319054218.3319-3-pkshih@realtek.com>
        <20210411092102.40EE7C43461@smtp.codeaurora.org>
        <632d2ab7679145eab8e1f498b9b12ceb@realtek.com>
Date:   Mon, 12 Apr 2021 14:46:50 +0300
In-Reply-To: <632d2ab7679145eab8e1f498b9b12ceb@realtek.com>
        (pkshih@realtek.com's message of "Mon, 12 Apr 2021 08:11:05 +0000")
Message-ID: <87r1jflo7p.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: kvalo=codeaurora.org@mg.codeaurora.org
>> [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
>> Behalf Of Kalle Valo
>> Sent: Sunday, April 11, 2021 5:21 PM
>> To: Pkshih
>> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org; DeanKu;
>> Bernie Huang; Shaofu; Steven Ting;
>> Kevin Yang
>> Subject: Re: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
>> 
>> Ping-Ke Shih <pkshih@realtek.com> wrote:
>> 
>> > From: Shao-Fu Cheng <shaofu@realtek.com>
>> >
>> > By default the driver uses the 1M and 6M rate for managemnt frames
>> > in 2G and 5G bands respectively. But when the basic rates is configured
>> > from the mac80211, we need to send the management frames according the
>> > basic rates.
>> >
>> > This commit makes the driver use the lowest basic rates to send
>> > the management frames and a debufs entry to enable/disable force to use
>> > the lowest rate 1M/6M for 2.4G/5G bands.
>> >
>> > obtain current setting
>> > cat /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
>> >
>> > force lowest rate:
>> > echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
>> >
>> > Signed-off-by: Shao-Fu Cheng <shaofu@realtek.com>
>> > Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> Why is a debugfs interface needed?
>> 
>
> By default, driver follows AP's basic rates that may be 24M and above, and
> does association with 24M rate. If AP is far away, it may be hard to communicate
> with 24M rate. Therefore, we add a debugfs to allow driver to send management
> frames with low rate 6M or 1M.

debugfs is for R&D level testing and debugging, not normal user
configuration. To me it looks like something like that should be in
nl80211.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
