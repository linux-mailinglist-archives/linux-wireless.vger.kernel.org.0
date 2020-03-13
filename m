Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3241845CB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 12:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCMLR2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 07:17:28 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:32823 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbgCMLR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 07:17:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584098247; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Xc4FB3oznvugEjbpM7jT0IwIOwJrVRzNrb8L75b626k=; b=FmVcnmAus4M/HCGaitjtTIh1d4FjnmxoT60taDJNV+ThIQYjTDEU4q4zDO1/yHN00xQ10T6g
 //pysHI4W4GGg6YWjHbZOUVk3TK8vdagrw1sH0dm7PwGFBFKPm73ZpytF5z3VP+gGWs8XxrV
 EzogiaLjUAeGKshl9a2yZndFHdI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6b6bbb.7f8aca725810-smtp-out-n01;
 Fri, 13 Mar 2020 11:17:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44A4CC432C2; Fri, 13 Mar 2020 11:17:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D55EC433D2;
        Fri, 13 Mar 2020 11:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D55EC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris\@chromium.org" <briannorris@chromium.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "tamizhr\@codeaurora.org" <tamizhr@codeaurora.org>
Subject: Re: [PATCH v2 2/2] rtw88: add a debugfs entry to enable/disable coex mechanism
References: <20200309075852.11454-1-yhchuang@realtek.com>
        <20200309075852.11454-3-yhchuang@realtek.com>
        <877dzpu2lt.fsf@tynnyri.adurom.net>
        <33d4904b71a04ed8b0226ce07b037e05@realtek.com>
Date:   Fri, 13 Mar 2020 13:17:09 +0200
In-Reply-To: <33d4904b71a04ed8b0226ce07b037e05@realtek.com> (Tony Chuang's
        message of "Fri, 13 Mar 2020 02:23:38 +0000")
Message-ID: <87a74ko66i.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

> Kalle Valo <kvalo@codeaurora.org> :
>
>> <yhchuang@realtek.com> writes:
>> 
>> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >
>> > Sometimes we need to stop the coex mechanism to debug, so that we
>> > can manually control the device through various outer commands.
>> > Hence, add a new debugfs coex_enable to allow us to enable/disable
>> > the coex mechanism when driver is running.
>> >
>> > To disable coex
>> > echo 0 > /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable
>> >
>> > To enable coex
>> > echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable
>> >
>> > To check coex dm is enabled or not
>> > cat /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable
>> 
>> I forgot, did we add a command to nl80211 for managing btcoex? At least
>> we have talking about that for years. Please check that first before
>> adding a debugfs interface for this.
>> 
>
> Yes, I found there was a thread [1] talking about adding a callback to
> enable/disable btcoex, but it seems not get applied eventually.

Too bad, I really think we should have at least enable/disable
functionality in nl80211. But if it's not there, I guess it's ok to have
yet another driver custom debugfs file :/

> And there's another thread [2] talking about add a btcoex subsystem.
> But seems like nobody can implement it cleanly in the host.
>
> I think adding btcoex subsystem could have a lot of pain since each
> vendor is using different mechanism controlling the btcoex, and it
> usually comes with RF related design which is difficult to write a common
> function to deal with all kinds of them.

Yeah, btcoex subsystem is a big challenge.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
