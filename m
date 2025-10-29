Return-Path: <linux-wireless+bounces-28369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D2C1B671
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 15:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A4FC349CF8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D6F34405B;
	Wed, 29 Oct 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUCG2dgA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11433F388;
	Wed, 29 Oct 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749022; cv=none; b=TKZQyAPh1+1Ua0HWGbGp8ZTnpnDZzZ83OFd9z+if7g+INVHv9j0NzIFA5JryKtmdx5Hbc/QJNXfVlHtiyOypoS+gqzGkKRyArWyXg6zt0mgl5JuBaGwCcMqBDkIl7/k0qkooaaLHEcb97a/g0BHNTbn8Xc7uRzW1CE9lRLU2GEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749022; c=relaxed/simple;
	bh=7aIwRuIOpA2NvB46ZJFZlfxwwf5CrcEct874eSGcgUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MeHbIi50/Kkh6Oz+6E01yUZxOy+zXb6REEKD6dNKH2xAaZ/i3SOcrx5BHFVg9KU1U3NucQlLMzGh7xQf6Ycpb3mUl+AWssNACFjxBzhjOj0s+YF59Mq+iqD6Takyose0maU7BNomhEpP+OJ/qBc8SsziPnJm1veAqnQPRYzpjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUCG2dgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F0FC116C6;
	Wed, 29 Oct 2025 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761749021;
	bh=7aIwRuIOpA2NvB46ZJFZlfxwwf5CrcEct874eSGcgUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nUCG2dgAAGxavtrh6AFskbiNPy7Opyv54fNrY/+gU0ZaTvBrd+ZtUjFEd4lc5Qbk/
	 srjLlCZcD6v3yy00NaOnMM6kO85tayYB85zgXeLHHSpevQ6O2DGvXlTZcGF+ktUVor
	 G0oJOc1gayru+VczSM4ZiddijK6BzGtNWVQ5cxsRUBBCvQgzVaswHsRgcDYtOKLawP
	 at5sw+sOWuAecSORYOvFAW4sokeUujaDbydmhkXBgd33S7RBrbM2DgiSBbVNPSePhZ
	 OnukuKbisUVQxThAKHPJxURwRslfcZUKDhTxzc0zF6/DUihlPrLIr5qeFFcPt3CXjz
	 R9KUmZIa60r5g==
Message-ID: <5137cd11-004c-43ed-8bbb-646beb105844@kernel.org>
Date: Wed, 29 Oct 2025 15:43:37 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] wifi: ath11k: add multipd support for QCN6122
To: george.moussalem@outlook.com, Johannes Berg <johannes@sipsolutions.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
 <20251029-ath11k-qcn6122-v1-5-58ed68eba333@outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251029-ath11k-qcn6122-v1-5-58ed68eba333@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2025 15:26, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> IPQ5018/QCN6122 platforms use multi PD (protection domains) to avoid
> having one instance of the running Q6 firmware crashing resulting in
> crashing the others.
> 
> The IPQ5018 platform can have up to two QCN6122 wifi chips.
> To differentiate the two, the PD instance number (1 or 2) is added to
> the QMI service instance ID, which the QCN6122 firmware also expects.
> IPQ5018 internal wifi is always the first PD while QCN6122 cards must be
> second or third.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
> See below patch for more info:
> https://lore.kernel.org/all/20231110091939.3025413-1-quic_mmanikan@quicinc.com/

I don't see any common part with that. Your bindings are completely
different and while PD was justified there, there is no such
justification here. Neither in the bindings.

> ---
>  drivers/net/wireless/ath/ath11k/ahb.c  | 31 +++++++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h |  4 ++++
>  drivers/net/wireless/ath/ath11k/pci.c  |  1 +
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 7b267dd62e964b2c4d6c3bbe016abd1ad0297219..820a383e88caf125892176e421b0121fed7e7055 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -429,6 +429,7 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
>  	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
>  	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
>  	ab->qmi.service_ins_id = ab->hw_params.qmi_service_ins_id;
> +	ab->qmi.service_ins_id += ab->userpd_id;
>  }
>  
>  static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
> @@ -1101,6 +1102,28 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
>  	return ret;
>  }
>  
> +static int ath11k_get_userpd_id(struct device *dev, int *userpd)
> +{
> +	int ret, userpd_id;
> +
> +	ret = of_property_read_u32(dev->of_node, "qcom,userpd", &userpd_id);
> +
> +	if (ret)
> +		return ret;
> +
> +	switch (userpd_id) {
> +	case 2:
> +		*userpd = ATH11K_QCN6122_USERPD_2;
> +		break;
> +	case 3:
> +		*userpd = ATH11K_QCN6122_USERPD_3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
>  {
>  	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
> @@ -1142,6 +1165,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>  	const struct ath11k_hif_ops *hif_ops;
>  	const struct ath11k_pci_ops *pci_ops;
>  	enum ath11k_hw_rev hw_rev;
> +	int userpd_id = 0;
>  	int ret;
>  
>  	hw_rev = (uintptr_t)device_get_match_data(&pdev->dev);
> @@ -1160,6 +1184,12 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>  	case ATH11K_HW_QCN6122_HW10:
>  		hif_ops = &ath11k_ahb_hif_ops_qcn6122;
>  		pci_ops = &ath11k_ahb_pci_ops_wcn6750;
> +		ret = ath11k_get_userpd_id(&pdev->dev, &userpd_id);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to get userpd: %d\n", ret);
> +			return ret;
> +		}
> +		dev_info(&pdev->dev, "multi-pd architecture - userpd: %d\n", userpd_id);

This does not look like useful printk message. Drivers should be silent
on success:
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79

>  		break;
>  	default:

Best regards,
Krzysztof

