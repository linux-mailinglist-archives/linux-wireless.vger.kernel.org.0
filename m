Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45932456EFD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 13:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhKSMsl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 07:48:41 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:42783 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhKSMsl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 07:48:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637325939; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=EZi/zCgJPm2leshsjL14mSS1st5upvHCP4b2z58YjGk=; b=aOPHGbOMjQNJu16A753wVX86TnzsdNn/O98b2Yf0cYUfJ1DLbCIwwnWco55uK07GBo/cGsUR
 V5MYmgyUP4uF48RyM8R65gdXr+uS013tRyOQu21vD4exU1czuLdo4+wKQnduhz0U7Z3fIoN9
 0U+GTgnLewNA6cW9xFoD/jDOOYo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61979c6ff5c956d49e3b20d0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 12:45:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0A7A2C4338F; Fri, 19 Nov 2021 12:45:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA7D8C43616;
        Fri, 19 Nov 2021 12:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AA7D8C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 7/7] ath11k: Set IRQ affinity to CPU0 in case of one MSI vector
References: <20211026041732.5323-1-bqiang@codeaurora.org>
Date:   Fri, 19 Nov 2021 14:45:31 +0200
In-Reply-To: <20211026041732.5323-1-bqiang@codeaurora.org> (Baochen Qiang's
        message of "Tue, 26 Oct 2021 12:17:32 +0800")
Message-ID: <87h7c8co0k.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> writes:

> With VT-d disabled on Intel platform, ath11k gets only one MSI
> vector. In that case, ath11k does not free IRQ when doing suspend,
> hence the kernel has to migrate it to CPU0 (if it was affine to
> other CPUs) and allocates a new MSI vector. However, ath11k has
> no chance to reconfig it to HW srngs during this phase, thus
> ath11k fails to resume.
>
> This issue can be fixed by setting IRQ affinity to CPU0 before
> request_irq is called. With such affinity, migration will not
> happen and thus the vector keeps unchanged during suspend/resume.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index b450b4ed35d1..1cad7545ceb9 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -840,6 +840,14 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
>  	return 0;
>  }
>  
> +static int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci, const struct cpumask *m)
> +{
> +	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
> +		return irq_set_affinity_hint(ab_pci->pdev->irq, m);
> +
> +	return 0;
> +}

I reversed the order here:

static int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
					    const struct cpumask *m)
{
	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
		return 0;

	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
}

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
