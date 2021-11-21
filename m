Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7125645842C
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Nov 2021 15:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbhKUOsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 09:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbhKUOsk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 09:48:40 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7580C061574
        for <linux-wireless@vger.kernel.org>; Sun, 21 Nov 2021 06:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1637505932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4ovVeGWykiyQqLdOt+pg9u4rBbCXU8KwSKQ8XinB3A=;
        b=vsUBEawYM4Gp8jWqxtG3NKpkZcXp94og/56/aGYt+t9cNleA3gadxoAoqywr3kzp/TYUUl
        JL2MuoAWC/AhwSCmXjAX4qyzSLWdOOcoFoT4bLbgpSdc7nOEc7I/vqOMqQeBD5Zv22sJ1l
        Gq5piBcC56JZ88615JgZzp06qIUppYc=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATCH v4 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date:   Sun, 21 Nov 2021 15:45:29 +0100
Message-ID: <1724585.GBsqGgcNsD@sven-l14>
In-Reply-To: <1637504521-30997-2-git-send-email-akolli@codeaurora.org>
References: <1637504521-30997-1-git-send-email-akolli@codeaurora.org> <1637504521-30997-2-git-send-email-akolli@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sunday, 21 November 2021 15:22:01 CET Anilkumar Kolli wrote:
[...]
> +static int ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)
> +{
> +	struct device_node *np;
> +	dma_addr_t start;
> +	u32 reg[4];
> +	int ret;
> +
> +	np = of_find_node_by_type(NULL, "memory");
> +	if (!np)
> +		return -ENOENT;
> +
> +	ret = of_property_read_u32_array(np, "reg", reg, 4);
> +	if (ret)
> +		return ret;
> +
> +	start = reg[0] + reg[1];
> +	mhi_ctrl->iova_start = start + 0x1000000;
> +	mhi_ctrl->iova_stop = start + reg[2] + reg[3];
> +
> +	return 0;
> +}
> +
[...]
> +			ret = of_property_read_u32(dev->of_node, "memory-region",
> +						   &hremote_phandle);
> +			if (ret) {
> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
> +					   "qmi fail to get hremote phandle\n");
> +				return ret;
> +			}
> +
> +			hremote_node = of_find_node_by_phandle(hremote_phandle);
> +			if (!hremote_node) {
> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
> +					   "qmi fail to get hremote_node\n");
> +				return ret;
> +			}
> +
> +			ret = of_property_read_u32_array(hremote_node, "reg", reg, 4);
> +			if (ret) {
> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
> +					   "qmi fail to get reg from hremote\n");
> +				return ret;
> +			}
> +
> +			start = reg[0] + reg[1];
> +			size = reg[2] + reg[3];

See my messages for v2 [1] and v3 [2]

Kind regards,
	Sven

[1] https://patchwork.kernel.org/project/linux-wireless/patch/1637082058-6398-2-git-send-email-akolli@codeaurora.org/#24605391
[2] https://patchwork.kernel.org/project/linux-wireless/patch/1637244892-27267-2-git-send-email-akolli@codeaurora.org/#24605417


