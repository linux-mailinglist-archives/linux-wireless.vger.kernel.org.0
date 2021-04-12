Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1685635C592
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbhDLLsS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 07:48:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40862 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237705AbhDLLsR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 07:48:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618228080; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=gXejlg1r8Ab01RQyReAwfye/Qzht/FnTfXT5Xx0mq+s=; b=JIxwmxyQ7a/BL8cL4YRH3+kNRMjR99yPxHPm2k975neobmWTj52sKxJddiVeuJlXxmqONURX
 /fLxJPmuOMC9y/6LvfYuHMoKsrF9oO+69/2f/xqA+/68uIHGltplfbGdhXBjAsulR9BThnrv
 pp2W/BZQ1N0fgDVrr/ahSCg4eno=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6074336a8166b7eff752196e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Apr 2021 11:47:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 57618C433ED; Mon, 12 Apr 2021 11:47:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D84F9C433C6;
        Mon, 12 Apr 2021 11:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D84F9C433C6
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
Subject: Re: [PATCH 6/7] rtw88: 8822c: add CFO tracking
References: <20210319054218.3319-7-pkshih@realtek.com>
        <20210411091951.2B01AC433CA@smtp.codeaurora.org>
        <6ea1eb17f2a64fd0954b9d4060da12f0@realtek.com>
Date:   Mon, 12 Apr 2021 14:47:49 +0300
In-Reply-To: <6ea1eb17f2a64fd0954b9d4060da12f0@realtek.com>
        (pkshih@realtek.com's message of "Mon, 12 Apr 2021 08:11:09 +0000")
Message-ID: <87mtu3lo62.fsf@codeaurora.org>
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
>> Sent: Sunday, April 11, 2021 5:20 PM
>> To: Pkshih
>> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org; DeanKu;
>> Bernie Huang; Shaofu; Steven Ting;
>> Kevin Yang
>> Subject: Re: [PATCH 6/7] rtw88: 8822c: add CFO tracking
>> 
>> Ping-Ke Shih <pkshih@realtek.com> wrote:
>> 
>> > From: Po-Hao Huang <phhuang@realtek.com>
>> >
>> > Add CFO tracking mechanism to mitigate the effect of oscillator
>> > frequency discrepancy.
>> >
>> > Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> What's CFO? I need to understand the commit log, so please write it so that any
>> engineer working with wireless understands it.
>> 
>
> CFO tracking, which stands for central frequency offset tracking, is used to
> adjust oscillator to align central frequency of connected AP. Then, we can
> have better performance.
>
> Should I resend this patch to explain CFO?

Yes, please send a new version with an updated commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
