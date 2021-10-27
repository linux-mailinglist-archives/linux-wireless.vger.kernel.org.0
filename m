Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95C543C40C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhJ0HjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 03:39:21 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:55375 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhJ0HjU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 03:39:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635320216; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=AHgORtjOWZQucqmr10ER2Ox4ei97UJC4119/63rmrNw=;
 b=w7GTBeqpl/cKy4u/QzPVOrkVG4FWplXq0EiuOD4RBUzU5MXfw7Vk53WJoAA2OqbCVgDmx2Ny
 TBPXOXeCb5RAS7EJJkEPRI34eyhXLYSgyH9ozbZYceM51mh4TenrZoA5awAT3OvSzg7M+vQ1
 /YFOVHPMmO9GHWbpm2J4rPlEEc0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61790189fd91319f0f8b3ec3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 07:36:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AE631C4360D; Wed, 27 Oct 2021 07:36:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79AF6C4338F;
        Wed, 27 Oct 2021 07:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 79AF6C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers-next] rtw89: remove duplicate register
 definitions
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <YXD+KL+xzFsnGShb@ns.kevlo.org>
References: <YXD+KL+xzFsnGShb@ns.kevlo.org>
To:     Kevin Lo <kevlo@kevlo.org>
Cc:     linux-wireless@vger.kernel.org, Pkshih <pkshih@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163532019874.30745.13443556634734678476.kvalo@codeaurora.org>
Date:   Wed, 27 Oct 2021 07:36:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kevin Lo <kevlo@kevlo.org> wrote:

> Remove duplicate register definitions.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
> index 34333c441aea..20e6767ea5c4 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.h
> +++ b/drivers/net/wireless/realtek/rtw89/pci.h
> @@ -276,11 +276,6 @@
>  #define B_AX_CH10_BUSY			BIT(0)
>  
>  /* Configure */
> -#define R_AX_PCIE_INIT_CFG1	0x1000
> -#define B_AX_PCIE_RXRST_KEEP_REG	BIT(23)
> -#define B_AX_PCIE_TXRST_KEEP_REG	BIT(22)
> -#define B_AX_DIS_RXDMA_PRE		BIT(2)
> -
>  #define R_AX_PCIE_INIT_CFG2		0x1004
>  #define B_AX_WD_ITVL_IDLE		GENMASK(27, 24)
>  #define B_AX_WD_ITVL_ACT		GENMASK(19, 16)

Patch applied to wireless-drivers-next.git, thanks.

090f8a2f7b38 rtw89: remove duplicate register definitions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YXD+KL+xzFsnGShb@ns.kevlo.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

