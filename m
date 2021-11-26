Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A51845F03C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 15:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351363AbhKZPDD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 10:03:03 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:34533 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354044AbhKZPBB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 10:01:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637938667; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=YxbPY2U7JLHPz0US+wB12/ZOa0P5IrVnOVlXWVfBYK8=; b=Nbx3r+v5s9QElFtWF/CGEf5lTHaCR4ifws3YtHIehYFESPPp8eU9loxSU5P/9eQhF2/XTEda
 SGF/LuzqzRbVun9ATOeQDAWzuFUS5ISyAxKIOXoFnUxwKLZkHF58k9idO7ZB2GsvESOot7Jc
 WVmuvUbvkjCrVFIDu6ifAuHYkkA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61a0f5e9db3ac5552a2c7c67 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 14:57:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 694A1C43618; Fri, 26 Nov 2021 14:57:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1757CC4338F;
        Fri, 26 Nov 2021 14:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1757CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: fix possible pktid leak
References: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
        <163777451567.4686.3609119971518562275.kvalo@codeaurora.org>
        <YaDo21+/MBeeuTDN@lore-desk>
Date:   Fri, 26 Nov 2021 16:57:39 +0200
In-Reply-To: <YaDo21+/MBeeuTDN@lore-desk> (Lorenzo Bianconi's message of "Fri,
        26 Nov 2021 15:02:03 +0100")
Message-ID: <87fsrj3qxo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>> 
>> > Fix a possible idr pkt-id leak if the packet is dropped on tx side
>> > 
>> > Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > Acked-by: Felix Fietkau <nbd@nbd.name>
>> 
>> Patch applied to wireless-drivers.git, thanks.
>> 
>> 2a9e9857473b mt76: fix possible pktid leak
>
> Hi Kalle,
>
> Unfortunately I found a regression introduced by this patch for mt7663u (and I
> guess for mt7921s as well). Do you want me to post a fix or just a v2?

I don't rebase my trees, so please post a fix. I was planning to submit
a pull request to net tree today, but is this so serious that I should
skip that?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
