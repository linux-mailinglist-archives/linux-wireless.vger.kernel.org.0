Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545D62A347A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 20:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgKBToI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 14:44:08 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:43663 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgKBToH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 14:44:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604346247; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=CdbmqCH9v1XdkBgHkDiw+toW1JeEUkqa+B8F//oqyDw=; b=LSZ4gPdDLpe+3MM8k8WXCNOzRlazct4XGJnkl/zFay8Uyqy1xgKEaib6U1OL6SafxdxEnKjr
 o1Kcrtn06nAWL7H1gbXvWzd4u3Pmv5YwLqz16J2yEVkyqiAud04v8yaIq/smh8Zw0U58wWHJ
 900RFDFMEQWU1Vpe4rSYaiaqXqE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fa06186978460d05bc58ecf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 19:44:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97F1AC433FF; Mon,  2 Nov 2020 19:44:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE0CCC433C8;
        Mon,  2 Nov 2020 19:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE0CCC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     vnaralas@codeaurora.org
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap power save
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
        <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
        <871rilf2th.fsf@codeaurora.org>
        <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
        <87eelr1oq9.fsf@codeaurora.org>
        <f6c148a3-73de-1481-5f63-2deecb599468@broadcom.com>
        <81ced18ac5b87a17cf31797cf91669bc@codeaurora.org>
Date:   Mon, 02 Nov 2020 21:44:01 +0200
In-Reply-To: <81ced18ac5b87a17cf31797cf91669bc@codeaurora.org>
        (vnaralas@codeaurora.org's message of "Fri, 23 Oct 2020 09:17:09
        +0530")
Message-ID: <87sg9rtugu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

vnaralas@codeaurora.org writes:

> On 2020-10-22 13:30, Arend Van Spriel wrote:
>> On 10/21/2020 7:19 PM, Kalle Valo wrote:
>>> vnaralas@codeaurora.org writes:
>>>
>>>> On 2020-09-29 13:10, Kalle Valo wrote:
>>>>> Johannes Berg <johannes@sipsolutions.net> writes:
>>>>>
>>>>>> On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
>>>>>>> AP power save feature is to save power in AP mode, where AP goes
>>>>>>> to power save mode when no stations associate to it and comes out
>>>>>>> of power save when any station associate to AP.
>>>>>>
>>>>>> Why do you think this requires a vendor command? I mean, that seems
>>>>>> like
>>>>>> fairly reasonable - even by default - behaviour?
>>>>>
>>>>> I have not studied the details, but doesn't AP power save break
>>>>> normal
>>>>> functionality? For example, I would guess probe requests from
>>>>> clients
>>>>> would be lost. So there's a major drawback when enabling this,
>>>>> right?
>>>>
>>>> This AP power save feature will not break any functionality, Since
>>>> one
>>>> chain is always active and all other chains will be disabled when
>>>> this
>>>> feature is enabled. AP can still be able to beacon and receive probe
>>>> request from the clients. The only drawback is reduced network range
>>>> when this feature is enabled. Hence, we don't want to enable it by
>>>> default.
>>>
>>> Yeah, we really would not want to enable that by default. But what
>>> should be the path forward, a vendor command or a proper nl80211
>>> command? Any opinions?
>>
>> I would go for a proper nl80211 command or just add an attribute for
>> use in NL80211_CMD_START_AP or deal with NL80211_CMD_SET_POWERSAVE
>> when operating in AP mode.
>>
> Sure, I will go with the existing NL80211_CMD_SET_POWERSAVE and I will
> send next version.

Better to wait first so that we have concensus on this. And need to
check if NL80211_CMD_SET_POWERSAVE is even suitable for AP mode.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
