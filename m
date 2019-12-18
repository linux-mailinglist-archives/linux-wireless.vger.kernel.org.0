Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180F6125101
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLRSwA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 13:52:00 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:11172 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727197AbfLRSv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 13:51:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576695119; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=PVtbnDwUenhfbm4f2fSogQ42wTWIVeF28Wl2Ndp7ZAk=;
 b=uO5J2GUpy0Xrr1h/WvmwnCk44eL2Skyh0XGyXIQuklxTYDCoLz4AwtXuJzAgOohrXlRQOQyN
 1mEo2gTwRLorjoWuBlyWaMOhu1immEO8PoelCP+jEvAFvJD/fJG+uffTPwxcUaaW9SNmpv+V
 dOX5rzm++M7SqaHnkWWcRYX0TCI=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa754a.7f9173f85998-smtp-out-n01;
 Wed, 18 Dec 2019 18:51:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B16F6C447A3; Wed, 18 Dec 2019 18:51:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 270E0C43383;
        Wed, 18 Dec 2019 18:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 270E0C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt76: Off by one in mt76_calc_rx_airtime()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain>
References: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218185154.B16F6C447A3@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 18:51:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The sband->bitrates[] array has "sband->n_bitrates" elements so this
> check needs to be >= instead of > or we could read beyond the end of the
> array.
> 
> These values come from when we call mt76_register_device():
> 
> 	ret = mt76_register_device(&dev->mt76, true, mt7603_rates,
> 				   ARRAY_SIZE(mt7603_rates));
> 
> Here sband->bitrates[] is mt7603_rates[] and ->n_bitrates is the
> ARRAY_SIZE()
> 
> Fixes: 5ce09c1a7907 ("mt76: track rx airtime for airtime fairness and survey")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied to wireless-drivers.git, thanks.

b43e36d75e87 mt76: Off by one in mt76_calc_rx_airtime()

-- 
https://patchwork.kernel.org/patch/11261391/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
