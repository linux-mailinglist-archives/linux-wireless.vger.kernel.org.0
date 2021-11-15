Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E845028F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 11:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhKOKeZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 05:34:25 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:55868 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhKOKeU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 05:34:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636972285; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=/D4U2pti7GugSxYQtVmprvM+xoTx1CIFzT5P6ydhkFg=; b=TeHCP1suFUElxL+2V3eJSqWGTgfNX+MZUIVmNH7mvFoGVwoTFAdOIitu2MLQWwVAldvpgE81
 kOhOQ/LIqwqZZOoT1McP6hjOdOoDiSxZlxEXYCojF8VA9Koyz+iFiaqrSt4dT0GH+DD8C7q6
 ZiN5eLJhMwF5s1ybjGBbloUtZus=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 619236fdb3d5cb1f55db91bb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 10:31:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8E99C43460; Mon, 15 Nov 2021 10:31:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59CA6C4338F;
        Mon, 15 Nov 2021 10:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 59CA6C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/7] ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for DP IRQ
References: <20211026041655.5112-1-bqiang@codeaurora.org>
Date:   Mon, 15 Nov 2021 12:31:21 +0200
In-Reply-To: <20211026041655.5112-1-bqiang@codeaurora.org> (Baochen Qiang's
        message of "Tue, 26 Oct 2021 12:16:55 +0800")
Message-ID: <874k8diubq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> writes:

> From: Carl Huang <cjhuang@codeaurora.org>
>
> Like ATH11K_PCI_IRQ_CE0_OFFSET, define ATH11K_PCI_IRQ_DP_OFFSET for
> DP to save the IRQ instead of base_vector from MSI config.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index bf8d34bc5afa..ed610e56c160 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -16,7 +16,8 @@
>  #define ATH11K_PCI_BAR_NUM		0
>  #define ATH11K_PCI_DMA_MASK		32
>  
> -#define ATH11K_PCI_IRQ_CE0_OFFSET		3
> +#define ATH11K_PCI_IRQ_CE0_OFFSET	3
> +#define ATH11K_PCI_IRQ_DP_OFFSET	14
>  
>  #define WINDOW_ENABLE_BIT		0x40000000
>  #define WINDOW_REG_ADDRESS		0x310c
> @@ -764,7 +765,7 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
>  		}
>  
>  		irq_grp->num_irq = num_irq;
> -		irq_grp->irqs[0] = base_idx + i;
> +		irq_grp->irqs[0] = ATH11K_PCI_IRQ_DP_OFFSET + i;

This broke the build, I fixed it in the pending branch:

drivers/net/wireless/ath/ath11k/pci.c: In function 'ath11k_pci_ext_irq_config':
drivers/net/wireless/ath/ath11k/pci.c:740:50: error: variable 'base_idx' set but not used [-Werror=unused-but-set-variable]

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
