Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680DF456F3A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 14:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhKSNDz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 08:03:55 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:59601 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhKSNDz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 08:03:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637326853; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=9P1+GeW+iMG520eXm/L61/BwyPJU0q/p6N4rHT+ye9c=; b=LPp3f035e1K7iG/nNr4CAP7tj67adIL+wQYTHZNpxbCqlsydz5zLybzqGo6HUwx9tczUno/j
 H3nA+WbwR+Inz0gkI1GOxyZRi8MShcRq6kStSfHKw9IRPCcIbnI8MTTQxawXo5TDaKvHMuh9
 NJNuB/6dPa+1APzdxRjjhphrtGg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6197a005ed14d5980f01a3ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 13:00:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6341FC4360D; Fri, 19 Nov 2021 13:00:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29A41C4360D;
        Fri, 19 Nov 2021 13:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 29A41C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATH v3 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
References: <1637244892-27267-1-git-send-email-akolli@codeaurora.org>
        <1637244892-27267-2-git-send-email-akolli@codeaurora.org>
Date:   Fri, 19 Nov 2021 15:00:44 +0200
In-Reply-To: <1637244892-27267-2-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Thu, 18 Nov 2021 19:44:52 +0530")
Message-ID: <87czmwcnb7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> Host DDR memory (contiguous 45 MB in mode-0 or 15 MB in mode-2)
> is reserved through DT entries for firmware usage. Send the base
> address from DT entries.
> If DT entry is available, PCI device will work with
> fixed_mem_region else host allocates multiple segments.
>
> IPQ8074 on HK10 board supports multiple PCI devices.
> IPQ8074 + QCN9074 is tested with this patch.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

Not sure how I missed these in the last round:

> +static bool ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)

static int ....

> +{
> +	struct device_node *np;
> +	u32 reg[4];
> +	dma_addr_t start;
> +
> +	np = of_find_node_by_type(NULL, "memory");
> +	if (!np)
> +		return false;
> +
> +	if (of_property_read_u32_array(np, "reg", reg, 4))
> +		return false;

ret = of_property_read_u32_array(np, "reg", reg, 4);
if (ret)
	return ret;

> +	start = reg[0] + reg[1];
> +	mhi_ctrl->iova_start = start + 0x1000000;
> +	mhi_ctrl->iova_stop = start + reg[2] + reg[3];
> +
> +	return true;

return 0;

> +}
> +
>  int ath11k_mhi_register(struct ath11k_pci *ab_pci)
>  {
>  	struct ath11k_base *ab = ab_pci->ab;
> @@ -339,8 +360,14 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
>  		return ret;
>  	}
>  
> -	mhi_ctrl->iova_start = 0;
> -	mhi_ctrl->iova_stop = 0xffffffff;
> +	if ((test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags))) {
> +		if (!ath11k_mhi_read_addr_from_dt(mhi_ctrl))
> +			return -ENODATA;

                ret = ath11k_mhi_read_addr_from_dt(mhi_ctrl);
		if (ret)
			return ret;

> @@ -1245,6 +1246,13 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>  	pci_set_drvdata(pdev, ab);
>  	spin_lock_init(&ab_pci->window_lock);
>  
> +	/* Set fixed_mem_region to true for platforms support reserved memory
> +	 * from DT. If memory is reserved from DT for FW, ath11k driver need not
> +	 * allocate memory.
> +	 */
> +	if (!of_property_read_u32(ab->dev->of_node, "memory-region", &addr))
> +		set_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags);

ret = of_property_read_u32(ab->dev->of_node, "memory-region", &addr);
if (!ret)
	set_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags);

>  static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>  {
> +	struct device *dev = ab->dev;
> +	struct device_node *hremote_node = NULL;
> +	phandle hremote_phandle;
> +	dma_addr_t start;
> +	u32 reg[4], size, host_ddr_sz;
>  	int i, idx;
>  
>  	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
>  		switch (ab->qmi.target_mem[i].type) {
> +		case HOST_DDR_REGION_TYPE:
> +			if (of_property_read_u32(dev->of_node, "memory-region",
> +						 &hremote_phandle)) {
> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
> +					   "qmi fail to get hremote phandle\n");
> +				return 0;
> +			}
> +
> +			hremote_node = of_find_node_by_phandle(hremote_phandle);
> +			if (!hremote_node) {
> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
> +					   "qmi fail to get hremote_node\n");
> +				return 0;
> +			}
> +
> +			if (of_property_read_u32_array(hremote_node, "reg", reg, 4)) {
> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
> +					   "qmi fail to get reg from hremote\n");
> +				return 0;
> +			}

ret = of_property_read_u32_array(hremote_node, "reg", reg, 4);
if (ret) {
	ath11k_dbg(ab, ATH11K_DBG_QMI,
		   "qmi fail to get reg from hremote\n");
	return 0;
}

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
