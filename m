Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ADD456EF7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 13:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhKSMqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 07:46:35 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:53215 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhKSMqf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 07:46:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637325813; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=z2cl02GQZDYpTZwOec3Fcl0cW+j42ZSVUTXNUs2skYw=; b=OxMni64Lf69Y/JKN+B84d7kMZNtKOKzk3wfxlK80w8+wtv6hEwsxFulBdJ3VU1Ak0clzEafG
 g42bL+V83J2Cm3yW023nofp3qPuLQX+vNe0xc501v/X2P6Ybu5hfQpMKLopePsC/YsJ7qt2A
 Q8eoJS1WHGhRoZ1uFq9NxVLg6KI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61979bf5665450d43a9aa5d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 12:43:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A025C4360C; Fri, 19 Nov 2021 12:43:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 881D6C4338F;
        Fri, 19 Nov 2021 12:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 881D6C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/7] ath11k: refactor multiple MSI vector implementation
References: <20211026041705.5167-1-bqiang@codeaurora.org>
Date:   Fri, 19 Nov 2021 14:43:25 +0200
In-Reply-To: <20211026041705.5167-1-bqiang@codeaurora.org> (Baochen Qiang's
        message of "Tue, 26 Oct 2021 12:17:05 +0800")
Message-ID: <87lf1kco42.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> writes:

> From: Carl Huang <cjhuang@codeaurora.org>
>
> This is to prepare for one MSI vector support. IRQ enable and disable
> of CE and DP are done only in case of multiple MSI vectors.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>

[...]

> @@ -558,6 +558,13 @@ static void ath11k_pci_free_irq(struct ath11k_base *ab)
>  static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
>  {
>  	u32 irq_idx;
> +	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);

ab_pci should be before irq_idx to follow the reverse xmas tree style, I
fixed it in the pending branch.

> +
> +	/*In case of one MSI vector, we handle irq enable/disable
> +	 *in a uniform way since we only have one irq
> +	 */

There should be a space after '*', fixed now.

> +	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
> +		return;
>  
>  	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
>  	enable_irq(ab->irq_num[irq_idx]);
> @@ -566,6 +573,13 @@ static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
>  static void ath11k_pci_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
>  {
>  	u32 irq_idx;
> +	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
> +
> +	/*In case of one MSI vector, we handle irq enable/disable
> +	 *in a uniform way since we only have one irq
> +	 */
> +	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
> +		return;

Both style issues fixed here as well.

>  static void ath11k_pci_ext_grp_disable(struct ath11k_ext_irq_grp *irq_grp)
>  {
>  	int i;
> +	struct ath11k_pci *ab_pci = ath11k_pci_priv(irq_grp->ab);
> +
> +	/*In case of one MSI vector, we handle irq enable/disable
> +	 *in a uniform way since we only have one irq
> +	 */
> +	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
> +		return;

And here.

>  
>  	for (i = 0; i < irq_grp->num_irq; i++)
>  		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
> @@ -651,6 +672,13 @@ static void __ath11k_pci_ext_irq_disable(struct ath11k_base *sc)
>  static void ath11k_pci_ext_grp_enable(struct ath11k_ext_irq_grp *irq_grp)
>  {
>  	int i;
> +	struct ath11k_pci *ab_pci = ath11k_pci_priv(irq_grp->ab);
> +
> +	/*In case of one MSI vector, we handle irq enable/disable
> +	 *in a uniform way since we only have one irq
> +	 */
> +	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
> +		return;

And here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
