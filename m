Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8EC428703
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 08:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhJKGuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 02:50:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:42558 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbhJKGuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 02:50:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633934890; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=X2IEGRiQjcWMuTqGKpeI/0QKhJdKCtBxxC+Br55StdU=; b=guAYGGB6w+9CDlEwYv9QPbdreokw+RBmB44JufN9rnsWPxXIq9Hc5k+p5BBqa388XTkvsu1g
 8LAcYtN9RORZ4nPw90dzJBGgHcZgmc8WvAZzVx4NdfIZ+Stj9tMQOQMN6ThlbZ6nsUciutRo
 v2B7b0ceBsF+ZkKY1wLr07ZZi2U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6163de1f0605239689a7b3b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 06:47:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38FAFC43460; Mon, 11 Oct 2021 06:47:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA389C4338F;
        Mon, 11 Oct 2021 06:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AA389C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>
Subject: Re: [PATCH 5/5] ath11k: Handle MSI enablement during rmmod and SSR
References: <20210913180246.193388-1-jouni@codeaurora.org>
        <20210913180246.193388-5-jouni@codeaurora.org>
Date:   Mon, 11 Oct 2021 09:47:50 +0300
In-Reply-To: <20210913180246.193388-5-jouni@codeaurora.org> (Jouni Malinen's
        message of "Mon, 13 Sep 2021 21:02:46 +0300")
Message-ID: <87r1cs3vmx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Baochen Qiang <bqiang@codeaurora.org>
>
> When doing "rmmod ath11k_pci", ath11k performs global SOC reset
> and MHI reset, where 0 address access is captured by IOMMU. See
> log below:
>
> ...
> [  133.953860] ath11k_pci 0000:02:00.0: setting mhi state: DEINIT(1)
> [  133.959714] ath11k_pci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000a address=0x0 flags=0x0020]
> [  133.973854] ath11k_pci 0000:02:00.0: MHISTATUS 0xff04
> [  133.974095] ath11k_pci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000a address=0x0 flags=0x0020]
> ...
>
> This issue is also observed in SSR process, cause a similar
> sequence as above is performed.
>
> Such an invalid access occurs because, during rmmod or SSR, MSI
> address is cleared but HW MSI functionality not disabled, thus HW
> target is able to raise an MSI transaction with 0 as MSI address.
>
> So it can be fixed by simply disabling MSI before reset. For SSR,
> since MSI functionality is still needed after target is brought
> back, we need to reenable it.
>
> Also change naming of some interfaces related.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index 7b3bce0ba76e..1094b53465bc 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -855,7 +855,18 @@ static void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
>  	}
>  }
>  
> -static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
> +static void ath11k_pci_enable_msi(struct pci_dev *dev, bool enable)
> +{
> +	u16 control;
> +
> +	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
> +	control &= ~PCI_MSI_FLAGS_ENABLE;
> +	if (enable)
> +		control |= PCI_MSI_FLAGS_ENABLE;
> +	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
> +}

To make the function cleaner I renamed this to ath11k_pci_msi_config(),
added an else branch and changed it to take structh ath11k_pci. I also
added helpers ath11k_pci_msi_enable() and ath11k_pci_msi_disable().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
