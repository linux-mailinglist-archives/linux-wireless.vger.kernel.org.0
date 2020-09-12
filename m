Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A2A267821
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Sep 2020 08:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgILGQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Sep 2020 02:16:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55717 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgILGQ5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Sep 2020 02:16:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599891415; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8cNsweGNzwXC6JGq44ACepZmdsIt6d6D7mF1Rzi6Wec=; b=YOql4YsopLbLqyxA8BYauipEsKpD8kNHW9uLemCnAcsbMm1SF7wvVD5B2T/xD7Zn/mGOCcrb
 cpe6TK8xNH3BKdn9z1kbksvv9UjsIXuP9iFPeFAWC/0buSU7BN1hy7MATVBdU2CbSxJHFDal
 qLkQiDB1FOozzXjNAgmIMydznLo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f5c67d77f21d51b307f64ec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Sep 2020 06:16:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEE36C433CA; Sat, 12 Sep 2020 06:16:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CBC2C433C6;
        Sat, 12 Sep 2020 06:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CBC2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC] mac80211: Add radiotap channel flag option for 6GHz band
References: <010101747ee4b985-86863ec8-33e2-4f78-9d9b-93110bfa29fc-000000@us-west-2.amazonses.com>
        <5225561f9f5c104bc84ab6e7f183de0ab5e0ea6d.camel@sipsolutions.net>
        <010101747eea64fa-83d17384-b161-40d6-8b9d-9dd3bbbe89b4-000000@us-west-2.amazonses.com>
Date:   Sat, 12 Sep 2020 09:16:47 +0300
In-Reply-To: <010101747eea64fa-83d17384-b161-40d6-8b9d-9dd3bbbe89b4-000000@us-west-2.amazonses.com>
        (Aloka Dixit's message of "Fri, 11 Sep 2020 20:45:24 +0000")
Message-ID: <87zh5v1pv4.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> writes:

> On 2020-09-11 13:39, Johannes Berg wrote:
>> On Fri, 2020-09-11 at 20:39 +0000, Aloka Dixit wrote:
>>> Radiotap header needs a new channel flag for 6GHz packets.
>>> This change uses value 0x200 for new enum balue for 6GHz which was
>>> previously used for passsive scan flag but has since been removed.
>>
>> You can't just add to radiotap in a kernel patch ...
>>
>> But also, just today I replied elsewhere saying that we don't really
>> need a flag at all?
>>
>> johannes
>
> Somehow your reply to other patch didn't show up on the patchwork,
> don't know why :-)

Oh, this is making me worry. I do see Johannes' reply on the list:

https://lore.kernel.org/linux-wireless/1cc7242cd00cd5141a56f17a7f5c80700485aa39.camel@sipsolutions.net/

But like you said, there's still nothing on the patchwork (even after 23h):

https://patchwork.kernel.org/patch/11769643/

I hope this is just a temporary glitch, but if this happens again please
do let me know about any patchwork problems. It will create major
problems for us if patchwork starts losing mail.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
