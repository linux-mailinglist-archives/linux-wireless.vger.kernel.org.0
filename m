Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C3295169
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Oct 2020 19:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440662AbgJURTQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Oct 2020 13:19:16 -0400
Received: from z5.mailgun.us ([104.130.96.5]:32123 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389946AbgJURTP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Oct 2020 13:19:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603300755; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+5J1vw93ArN4paGHCB0AcS75hdbPJlG794YspOJT+9U=; b=Q2TySX33cdPP2euLCSHTsRZNJbslIjxoo38G6QDHVanqAUKp9WlD/ze+BFgTGaQdLiKjaP7q
 8VfOv/4sQecd35+2BrF9D0uBzqOSPv/3mKGKUcEYg1oYUACJZf/TNSTMNCD3XYmTy9IlMpF0
 gemA/2svcX+pqg82zW1yvDWyAsg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f906d92f9168450ea5a4876 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Oct 2020 17:19:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 705E7C43382; Wed, 21 Oct 2020 17:19:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B338C433C9;
        Wed, 21 Oct 2020 17:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B338C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     vnaralas@codeaurora.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap power save
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
        <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
        <871rilf2th.fsf@codeaurora.org>
        <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
Date:   Wed, 21 Oct 2020 20:19:10 +0300
In-Reply-To: <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
        (vnaralas@codeaurora.org's message of "Tue, 29 Sep 2020 18:09:44
        +0530")
Message-ID: <87eelr1oq9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

vnaralas@codeaurora.org writes:

> On 2020-09-29 13:10, Kalle Valo wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>>
>>> On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
>>>> AP power save feature is to save power in AP mode, where AP goes
>>>> to power save mode when no stations associate to it and comes out
>>>> of power save when any station associate to AP.
>>>
>>> Why do you think this requires a vendor command? I mean, that seems
>>> like
>>> fairly reasonable - even by default - behaviour?
>>
>> I have not studied the details, but doesn't AP power save break normal
>> functionality? For example, I would guess probe requests from clients
>> would be lost. So there's a major drawback when enabling this, right?
>
> This AP power save feature will not break any functionality, Since one
> chain is always active and all other chains will be disabled when this
> feature is enabled. AP can still be able to beacon and receive probe
> request from the clients. The only drawback is reduced network range
> when this feature is enabled. Hence, we don't want to enable it by
> default.

Yeah, we really would not want to enable that by default. But what
should be the path forward, a vendor command or a proper nl80211
command? Any opinions?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
