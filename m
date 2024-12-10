Return-Path: <linux-wireless+bounces-16162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAB29EB3DE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 15:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A44169C61
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5F1A0BD1;
	Tue, 10 Dec 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc1zlZSL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5578F23;
	Tue, 10 Dec 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842074; cv=none; b=kibZh5cpn6Uub4eCKBzd1sBButKFJKXcOHwlKKtz43WQ9A3flGaOtKRZY/5Q46/YoS0mEIupZ7NaTImmMiJc2uX0PQfQDX23253z/RonfF2UV92K5eXNSb7nrk4+ayA7TSJjgNt/bviVMlNLOTXu6kd8beQ7wZmVekk31AaNevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842074; c=relaxed/simple;
	bh=4lW9XNfX+kbAu7CsKaD1PDODoyAj2Ev0VkALIieRNuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSqI58vvvtmkA6umaKedK5OGhvLn4Nk+tAFWhyHrWoQQdzNuQOWiHeWPC3l8flWCXfoxf6AKkyDPT9n2sKO49j+d5R3xRdNbvTYcydRrw1p129l3bthj9jhp6FYsW65lwnMfqbdCamMc8slEmRgFhGHXRt7IbB60tIeN7aGm40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc1zlZSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DE5C4CED6;
	Tue, 10 Dec 2024 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842074;
	bh=4lW9XNfX+kbAu7CsKaD1PDODoyAj2Ev0VkALIieRNuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lc1zlZSLQ2TgvZbhxgYixVtpBW+y5s3izYCsIWhjtMaTsZMhtfEPL02LPnUnn/0W6
	 k4+GfsuO82jOIAi0SdII9H20ykIe2KAty7Nj320as4nW7o43REwbbaEtjSxoK5Vect
	 QIER7PzGvP+pf3//p8oTZhpkt4Q+BC139eGzXFvKRSZp4pJInuo1MrQgphoX/d+ySj
	 aeaxS9hr5VsrFOpMO6s73vIR1jKTb8WEOxQHdVbWlKoJZpSc87oCl2CEFsWCf8Qf7E
	 pb58dqYeRc5N6yQROcB3qY745PVF+97ZyMclfd7pZEulMC03g4LgmXCVhFzVf+Nn+u
	 Kmy+F37gsATPg==
Message-ID: <42feceb8-512a-4be3-aefa-116bbde000c1@kernel.org>
Date: Tue, 10 Dec 2024 15:47:49 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/13] wifi: ath12k: add AHB driver support for IPQ5332
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Balamurugan S <quic_bselvara@quicinc.com>,
 P Praneesh <quic_ppranees@quicinc.com>
References: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
 <20241210074159.2637933-9-quic_rajkbhag@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241210074159.2637933-9-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2024 08:41, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Add Initial Ath12k AHB driver support for IPQ5332. IPQ5332 is AHB
> based IEEE802.11be 2 GHz 2x2 WiFi device.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/ahb.c  | 878 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/ahb.h  |  37 ++
>  drivers/net/wireless/ath/ath12k/core.h |   4 +
>  drivers/net/wireless/ath/ath12k/hal.h  |   1 +
>  drivers/net/wireless/ath/ath12k/hw.h   |   1 +
>  5 files changed, 921 insertions(+)
>  create mode 100644 drivers/net/wireless/ath/ath12k/ahb.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/ahb.h
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
> new file mode 100644
> index 000000000000..fcd949faea9f
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -0,0 +1,878 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>

You don't use this header.

> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>

More headers here look unused.

> +#include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/smem_state.h>
> +#include "ahb.h"
> +#include "debug.h"
> +#include "hif.h"
> +
> +static const struct of_device_id ath12k_ahb_of_match[] = {
> +	{ .compatible = "qcom,ipq5332-wifi",
> +	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
> +	},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, ath12k_ahb_of_match);

This goes to driver struct declaration. It is really unusual to see it
in some other places.


> +
> +#define ATH12K_IRQ_CE0_OFFSET 4
> +


...

> +
> +static int ath12k_ahb_probe(struct platform_device *pdev)
> +{
> +	struct ath12k_base *ab;
> +	const struct ath12k_hif_ops *hif_ops;
> +	struct device_node *mem_node;
> +	enum ath12k_hw_rev hw_rev;
> +	u32 addr;
> +	int ret;
> +
> +	hw_rev = ath12k_ahb_get_hw_rev(pdev);
> +	switch (hw_rev) {
> +	case ATH12K_HW_IPQ5332_HW10:
> +		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Unsupported device type %d\n", hw_rev);

You already print once in ath12k_ahb_get_hw_rev() and none of these can
happen. No need to print impossible conditions at all. No need to print
impossible things twice.

> +		return -EOPNOTSUPP;
> +	}
> +

> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set 32-bit coherent dma\n");
> +		return ret;
> +	}
> +
> +	ab = ath12k_core_alloc(&pdev->dev, sizeof(struct ath12k_ahb),
> +			       ATH12K_BUS_AHB);
> +	if (!ab) {
> +		dev_err(&pdev->dev, "failed to allocate ath12k base\n");
> +		return -ENOMEM;
> +	}
> +
> +	ab->hif.ops = hif_ops;
> +	ab->pdev = pdev;
> +	ab->hw_rev = hw_rev;
> +	platform_set_drvdata(pdev, ab);
> +
> +	/* Set fixed_mem_region to true for platforms that support fixed memory
> +	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
> +	 * need not to allocate memory.
> +	 */
> +	if (!of_property_read_u32(ab->dev->of_node, "memory-region", &addr)) {
> +		set_bit(ATH12K_FLAG_FIXED_MEM_REGION, &ab->dev_flags);
> +
> +		/* If the platform supports fixed memory, then it should define/
> +		 * reserve MLO global memory in DT to support Multi Link Operation
> +		 * (IEEE 802.11be).
> +		 * If MLO global memory is not reserved in fixed memory mode, then
> +		 * MLO cannot be supported.
> +		 */
> +		mem_node = of_find_node_by_name(NULL, "mlo_global_mem_0");

NAK. Incorrect name, not conforming to coding style. Undocumented ABI.

Drop all calls to of_find_node_by_name() or any other stuff like this.

> +		if (!mem_node)
> +			ab->single_chip_mlo_supp = false;
> +	}
> +
> +	ret = ath12k_core_pre_init(ab);
> +	if (ret)
> +		goto err_core_free;

Best regards,
Krzysztof

