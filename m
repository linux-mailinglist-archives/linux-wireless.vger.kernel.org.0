Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A60313A95
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 18:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhBHRO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 12:14:29 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:51634 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233142AbhBHROR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 12:14:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612804433; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=O6ofAG6NyOeRkj9Z+F82du1IZa7Q0kHkjFxEMa4Ueuc=; b=o4z4d0mOGk/P77kfTwKpMawgJAIVIposRbr+JHde1uu4WOp26BzKiRRoXLPuazkvco5D9quW
 oLIXAz0JEGCfcGawV8N8IpfNeAgSJoUbLSqq7qAt7SJ6mql7ouLrENfeQnF++5RspAtp+hi6
 sf70Q9rJy/soKSm1s+GTxfYMzfk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 602171338e43a988b72c77fb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 17:13:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15DB4C43461; Mon,  8 Feb 2021 17:13:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F49DC433ED;
        Mon,  8 Feb 2021 17:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F49DC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-01-29
References: <3eba5570-7cff-f51e-4050-aa0054f98f81@nbd.name>
        <20210208102728.BBBE3C433CA@smtp.codeaurora.org>
        <20210208110931.GC2593@lore-desk>
Date:   Mon, 08 Feb 2021 19:13:19 +0200
In-Reply-To: <20210208110931.GC2593@lore-desk> (Lorenzo Bianconi's message of
        "Mon, 8 Feb 2021 12:09:31 +0100")
Message-ID: <87h7mm4h5c.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> [...]
>> b8135057988e mt76: mt7915: simplify mt7915_mcu_send_message routine
>> c203dd621780 mt76: mt7915: rework mcu API
>> 
>> This was not easy to fix. Felix & Lorenzo, please carefully check my resolution
>> in the pending branch:
>
> Hi Kalle,
>
> it is not easy to check a patch of a patch :) one comment inline.

Tell me about it, fixing conflicts is an art form in it's own right :)
This is exactly why I'm keeping the bar high for fixes going
wireless-drivers, I just don't want to deal with the conflicts.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
