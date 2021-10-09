Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D87B42781F
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Oct 2021 10:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhJIIal (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Oct 2021 04:30:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32256 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJIIak (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Oct 2021 04:30:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633768124; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Y7livkD6rfk5CsmmmClyXsF2sTrVmM04iMdxXpFTwYU=; b=KqQi9MeubaD7Oa1BgLO8STLIG1iNHkhG5dDVqTw/FkdkMDuasCD96DcDZYCzWkRuqZANfon7
 QzcvuvTa/Pc3TXevDK80EeaHTPsRjJN5z1VXdCbx3/fKZP9Msbbv8pCRAoJJVXQyvg/lk88q
 Ysq5siwHJNCFYnQfFsqypJxZ+OM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 616152b0ab9da96e64e48934 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 09 Oct 2021 08:28:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10D0DC4360C; Sat,  9 Oct 2021 08:28:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E19EEC4338F;
        Sat,  9 Oct 2021 08:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E19EEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
References: <20210820043538.12424-1-pkshih@realtek.com>
        <8735pkiu0t.fsf@codeaurora.org>
        <9b54e3c321a4414cbae62616d8a913f4@realtek.com>
        <877desggrm.fsf@codeaurora.org>
        <b59b709da12e4c938745eddd73efeec7@realtek.com>
Date:   Sat, 09 Oct 2021 11:28:26 +0300
In-Reply-To: <b59b709da12e4c938745eddd73efeec7@realtek.com> (Pkshih's message
        of "Fri, 8 Oct 2021 04:11:03 +0000")
Message-ID: <87h7dq61qt.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: kvalo=codeaurora.org@mg.codeaurora.org <kvalo=codeaurora.org@mg.codeaurora.org> On
>> Behalf Of Kalle Valo
>> Sent: Tuesday, October 5, 2021 1:52 PM
>> To: Pkshih <pkshih@realtek.com>
>> Cc: linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
>> 
>> Pkshih <pkshih@realtek.com> writes:
>> 
>> >> The community has been testing this driver already, right?
>> >
>> > As Larry mentioned, end users use this driver. Since bugs found in v6,
>> > we have fixed them and driver is under QA. I plan to have that fixes in v7
>> > released this week.
>> >
>> > This version will also include fixes of your comments.
>> > Does it work to you?
>> 
>> Sounds good to me. I hope the changes in v7 will be small in size,
>> bigger changes (especially new features) is better to do after the
>> driver is applied to wireless-drivers-next.
>> 
>
> I have fixed this driver according to all of your comments, so I
> don't reply the comments one by one. If this doesn't work to you,
> please let me know.

That's good, no need to reply to every comment. But please do reply to
the comments you did not agree on.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
