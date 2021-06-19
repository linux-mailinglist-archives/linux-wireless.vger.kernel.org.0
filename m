Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B73AD9BC
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhFSLJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 07:09:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38723 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhFSLJK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 07:09:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624100819; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=O5T/Cbcb8DSpBcvMfr32sTZZ6HdAT24NRUIKNzd+LSw=; b=Lek8oiNrhRCG6aY+eK9fMrHtPzJ40NQz0lUX1pAkRgVxYD+16VJLNQLcCwLlyrWAzd/FPMtw
 5I2/qPKRQKVMKIatecTs/qGE+bVxM3HTFtkOXMInySfV0vxi82oKa0xBV8K/CdPCL+nvwi+f
 5OAcgZ9SobnE43b7Fsgaji8IeYU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60cdcfb86ddc3305c418bceb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 19 Jun 2021 11:06:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FBF8C433D3; Sat, 19 Jun 2021 11:06:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70FA3C433F1;
        Sat, 19 Jun 2021 11:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70FA3C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: allow chip reset during device restart
References: <96d84ef577cb558969a56ed42e68769eac0d3a1c.1624012209.git.lorenzo@kernel.org>
Date:   Sat, 19 Jun 2021 14:06:23 +0300
In-Reply-To: <96d84ef577cb558969a56ed42e68769eac0d3a1c.1624012209.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Fri, 18 Jun 2021 12:30:47 +0200")
Message-ID: <874kduktao.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Disable chip full reset just during device probing but allow
> it during hw restart.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

[...]

> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -160,7 +160,8 @@ struct mt7921_dev {
>  	u16 chainmask;
>  
>  	struct work_struct reset_work;
> -	bool hw_full_reset;
> +	bool hw_full_reset:1;
> +	bool hw_init_done:1;

Is there a specific reason why you use bitfields in a boolean? Looks
strange to me.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
