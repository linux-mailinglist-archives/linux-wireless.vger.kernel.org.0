Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBAA461091
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 09:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbhK2I51 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 03:57:27 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:34864 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240317AbhK2Iz1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 03:55:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638175929; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=k3jH3l8sLpskbp9Wdg8eLxBQoUgyVEtWpmo4gVfU8C4=; b=QczPTsKOKjECo9SFYtRfmMDv/c7BZW/tR6hwrrP5u2OMn9PIMDSOCxvT6pY+7dr8mYqHB1r8
 eUAht0Yz1tEOsYyXWCLG1xHNPeEOhUtOdCRN6awmLHb3sD5A8N/iVpqtiV1U4/Pr9t8/RvUg
 5K5jzzJ/GDBiUw1SrUei7FUZSyU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61a494b9465c4a723b63d5c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 08:52:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E478C43618; Mon, 29 Nov 2021 08:52:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F5F2C4338F;
        Mon, 29 Nov 2021 08:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0F5F2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     sean.wang@mediatek.com, nbd@nbd.name,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: fix possible pktid leak
References: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
        <163777451567.4686.3609119971518562275.kvalo@codeaurora.org>
        <YaDo21+/MBeeuTDN@lore-desk> <87fsrj3qxo.fsf@codeaurora.org>
        <YaD8lT5csiLvmBzS@lore-desk> <87sfvij4eh.fsf@codeaurora.org>
        <YaEJ6hQ0uC32+Mts@lore-desk> <YaJAUOkLoQ3mOjcQ@lore-desk>
Date:   Mon, 29 Nov 2021 10:52:04 +0200
In-Reply-To: <YaJAUOkLoQ3mOjcQ@lore-desk> (Lorenzo Bianconi's message of "Sat,
        27 Nov 2021 15:27:28 +0100")
Message-ID: <874k7vgx8r.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> > Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> > 
>> > >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> > >> 
>> > >> >> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>> > >> >> 
>> > >> >> > Fix a possible idr pkt-id leak if the packet is dropped on tx side
>> > >> >> > 
>> > >> >> > Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
>> > >> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > >> >> > Acked-by: Felix Fietkau <nbd@nbd.name>
>> > >> >> 
>> > >> >> Patch applied to wireless-drivers.git, thanks.
>> > >> >> 
>> > >> >> 2a9e9857473b mt76: fix possible pktid leak
>> > >> >
>> > >> > Hi Kalle,
>> > >> >
>> > >> > Unfortunately I found a regression introduced by this patch
>> > >> > for mt7663u (and I
>> > >> > guess for mt7921s as well). Do you want me to post a fix or just a v2?
>> > >> 
>> > >> I don't rebase my trees, so please post a fix. I was planning to submit
>> > >> a pull request to net tree today, but is this so serious that I should
>> > >> skip that?
>> > >
>> > > I have already tested mt7663u but I do not have mt7921s hw for testing (but the
>> > > behaviour should be the same). I guess we can split the patch, just post the
>> > > fix for mt7663u and let Sean the time to test it on mt7921s (I am not sure
>> > > mt7921s is already available on the market). In this way you can send the PR
>> > > today. What do you think?
>> > 
>> > I think it's best to wait, I prefer to have proper build testing on my
>> > tree before I submit the pull request.
>> 
>> ack, fine to me. Let's wait for Sean in this case.
>
> @Sean: if you want to test the code the patch is available here:
> https://github.com/LorenzoBianconi/wireless-drivers/commit/1ffda36c7cbe3a6cfc31868895417d0cd6755306

And if we can't find a quick fix let's just revert 2a9e9857473b. I can't
wait too long.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
