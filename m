Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D9E2968E3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 05:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369882AbgJWDrM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 23:47:12 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:21559 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369875AbgJWDrL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 23:47:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603424831; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XwM41VNeKE5mkEGNGqtGGVFv5LCXJKJIl8qc1GETrcw=;
 b=OWoeLSo2+ZS23oTIiaMol1Igiddqv6iWR2CofUBmH2Qim2XJRToUtOiy+MNVWptXfEXIFmZP
 Fmak1M4KXm3k4JagJuJqcPyMulCjDH9K0C8ndmueFjZmDSH++7wgzN1Hc5LsoemwfArQHVKo
 WAUi0nwDuKQ2t17eVFhEe3N/8qA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f92523e42f9861fb1c843a7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Oct 2020 03:47:10
 GMT
Sender: vnaralas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7965FC433FE; Fri, 23 Oct 2020 03:47:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9ACC2C433CB;
        Fri, 23 Oct 2020 03:47:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 23 Oct 2020 09:17:09 +0530
From:   vnaralas@codeaurora.org
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap power
 save
In-Reply-To: <f6c148a3-73de-1481-5f63-2deecb599468@broadcom.com>
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
 <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
 <871rilf2th.fsf@codeaurora.org>
 <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
 <87eelr1oq9.fsf@codeaurora.org>
 <f6c148a3-73de-1481-5f63-2deecb599468@broadcom.com>
Message-ID: <81ced18ac5b87a17cf31797cf91669bc@codeaurora.org>
X-Sender: vnaralas@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-10-22 13:30, Arend Van Spriel wrote:
> On 10/21/2020 7:19 PM, Kalle Valo wrote:
>> vnaralas@codeaurora.org writes:
>> 
>>> On 2020-09-29 13:10, Kalle Valo wrote:
>>>> Johannes Berg <johannes@sipsolutions.net> writes:
>>>> 
>>>>> On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
>>>>>> AP power save feature is to save power in AP mode, where AP goes
>>>>>> to power save mode when no stations associate to it and comes out
>>>>>> of power save when any station associate to AP.
>>>>> 
>>>>> Why do you think this requires a vendor command? I mean, that seems
>>>>> like
>>>>> fairly reasonable - even by default - behaviour?
>>>> 
>>>> I have not studied the details, but doesn't AP power save break 
>>>> normal
>>>> functionality? For example, I would guess probe requests from 
>>>> clients
>>>> would be lost. So there's a major drawback when enabling this, 
>>>> right?
>>> 
>>> This AP power save feature will not break any functionality, Since 
>>> one
>>> chain is always active and all other chains will be disabled when 
>>> this
>>> feature is enabled. AP can still be able to beacon and receive probe
>>> request from the clients. The only drawback is reduced network range
>>> when this feature is enabled. Hence, we don't want to enable it by
>>> default.
>> 
>> Yeah, we really would not want to enable that by default. But what
>> should be the path forward, a vendor command or a proper nl80211
>> command? Any opinions?
> 
> I would go for a proper nl80211 command or just add an attribute for
> use in NL80211_CMD_START_AP or deal with NL80211_CMD_SET_POWERSAVE
> when operating in AP mode.
> 
Sure, I will go with the existing NL80211_CMD_SET_POWERSAVE and I will 
send next version.

> Regards,
> Arend
