Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E62745893B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 07:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhKVGPf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 01:15:35 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:38162 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKVGPe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 01:15:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637561549; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZheBse8ZEvGihMnRn4T6pwI87eiedwVxJmdP9hEilRo=;
 b=B6Vl7a2JgoLcfnbfPQJYRh9rh5Ek7A4Mryx/5wrW7e4iu+cEtkxG+yn5MK7jBIMUQb+LxggD
 wSLVWgn9qhUhHtLXr33oHaECwnpGqgBmzPDY0qcYzPQIE59JwxkwsrySyLzVjEMo4HkHLz+e
 hb4TxKg5drXJkHPKfFddgE7EUts=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 619b34cc4db4233966189cba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 06:12:28
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55079C4360D; Mon, 22 Nov 2021 06:12:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B240C4338F;
        Mon, 22 Nov 2021 06:12:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Nov 2021 11:42:27 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v4 2/2] ath11k: Use reserved host DDR addresses from DT
 for PCI devices
In-Reply-To: <1724585.GBsqGgcNsD@sven-l14>
References: <1637504521-30997-1-git-send-email-akolli@codeaurora.org>
 <1637504521-30997-2-git-send-email-akolli@codeaurora.org>
 <1724585.GBsqGgcNsD@sven-l14>
Message-ID: <a6f4fd77b1f8729368fee13a435fe652@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-21 20:15, Sven Eckelmann wrote:
> On Sunday, 21 November 2021 15:22:01 CET Anilkumar Kolli wrote:
> [...]
>> +static int ath11k_mhi_read_addr_from_dt(struct mhi_controller 
>> *mhi_ctrl)
>> +{
>> +	struct device_node *np;
>> +	dma_addr_t start;
>> +	u32 reg[4];
>> +	int ret;
>> +
>> +	np = of_find_node_by_type(NULL, "memory");
>> +	if (!np)
>> +		return -ENOENT;
>> +
>> +	ret = of_property_read_u32_array(np, "reg", reg, 4);
>> +	if (ret)
>> +		return ret;
>> +
>> +	start = reg[0] + reg[1];
>> +	mhi_ctrl->iova_start = start + 0x1000000;
>> +	mhi_ctrl->iova_stop = start + reg[2] + reg[3];
>> +
>> +	return 0;
>> +}
>> +
> [...]
>> +			ret = of_property_read_u32(dev->of_node, "memory-region",
>> +						   &hremote_phandle);
>> +			if (ret) {
>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>> +					   "qmi fail to get hremote phandle\n");
>> +				return ret;
>> +			}
>> +
>> +			hremote_node = of_find_node_by_phandle(hremote_phandle);
>> +			if (!hremote_node) {
>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>> +					   "qmi fail to get hremote_node\n");
>> +				return ret;
>> +			}
>> +
>> +			ret = of_property_read_u32_array(hremote_node, "reg", reg, 4);
>> +			if (ret) {
>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>> +					   "qmi fail to get reg from hremote\n");
>> +				return ret;
>> +			}
>> +
>> +			start = reg[0] + reg[1];
>> +			size = reg[2] + reg[3];
> 
> See my messages for v2 [1] and v3 [2]
> 
> 
Thanks for the review,

Here addresses are always within 32-bit.
so I will change the API to read only 2 integers and update start 
addresss and size.

> [1]
> https://patchwork.kernel.org/project/linux-wireless/patch/1637082058-6398-2-git-send-email-akolli@codeaurora.org/#24605391
> [2]
> https://patchwork.kernel.org/project/linux-wireless/patch/1637244892-27267-2-git-send-email-akolli@codeaurora.org/#24605417


- Anil.
