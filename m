Return-Path: <linux-wireless+bounces-19419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14999A43BD9
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED33163743
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC8242938;
	Tue, 25 Feb 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D1LUvCjJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598024EF9D;
	Tue, 25 Feb 2025 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479545; cv=none; b=QnykZHf8CYZrJFljtzIlR75zLVquJk0D1n5Gb3YUhSkAI9Wu1uhtFPnGwCFs3K2uDG3h02/k37OQ6G1FwNDrYOgk9WMb7eFtIByR2wKDZ66a8LLAcO4rdk8e3d3pf1AY/v0Hj4EIoyqdmqnxvsYFpBJI+E7KaVHJ2tCwVlUrpo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479545; c=relaxed/simple;
	bh=+OCR+GIe5xLZeikUC6PfXnk5joRi3BkvxLM8KgsPD/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4y7i/HIIjFfgUWK8N2F0nTXdzxecPYXeVpnASy6oIZeQn3vxUm/XEBpd4cfE3FyFiqzE3J7KvriPdtspVR4w4d46qPLJyGI9qmug/TviDFMRa0W8sv9DVpKt+YNTVMfdliVkmE+9uN1+x5xGifRWwjWyhMoLUrv436lzWSDArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D1LUvCjJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740479535;
	bh=+OCR+GIe5xLZeikUC6PfXnk5joRi3BkvxLM8KgsPD/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D1LUvCjJ/Lp9/MzZCTPHnFDrM/RaVCl63na+WpzXRc258xsAnex+V63/K8eHEI9AZ
	 S07lTsMu1yM1M7uoFWiTkDQPHXgvb0L8Zf9gs5NUCWOxrz0ukXyAR9xqEGDJdBt/9B
	 KyHuEc5Hsfoiy2d3Iuk52Ns0Fr9tMh5G2gJCFMkd4sHRPgR8vOi3P6QX8xWHOArICs
	 8AQ4dbE3VSVzfoqGqYG3C5W1R2kI/sVsT3wJLYqUrya5tiO/phtTFyC0CWuSLl3flo
	 Ul8m6a1ivzYJ6wVyaaXEskD9gTVokV0snqchY1o+eeu6fPQhEzwpb3awOlo2uhh2xO
	 EHSLXkmPxIEbA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0881917E0B64;
	Tue, 25 Feb 2025 11:32:14 +0100 (CET)
Message-ID: <184de5d2-ad02-4387-b850-b45b615cf164@collabora.com>
Date: Tue, 25 Feb 2025 11:32:14 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] wifi: ath10k/ath11k/ath12k: Strip device prefix from
 calibration properties
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/25 10:05, Krzysztof Kozlowski ha scritto:
> Devicetree properties describing exactly the same thing should be
> reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
> certain calibration data, so properties should not be prefixed with
> device family (ath10k).
> 
> Deprecate qcom,ath10k-calibration-variant and alike, so we gradually
> switch to a common property.  This will also allow moving these
> properties to common schema, if desired.
> 
> Why? Because people add qcom,ath12k-calibration-data and probably they
> will add qcom,ath13k-calibration-data, qcom,ath14k-calibration-data and
> so on.
> 
> I will fix DTS in separate series.
> 

For the whole series

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (5):
>        dt-bindings: wireless: ath10k: Strip ath10k prefix from calibration properties
>        dt-bindings: wireless: ath11k: Strip ath11k prefix from calibration property
>        dt-bindings: wireless: ath12k: Strip ath12k prefix from calibration property
>        wifi: ath10k: Deprecate qcom,ath10k-calibration-variant properties
>        wifi: ath11k: Deprecate qcom,ath11k-calibration-variant properties
> 
>   .../bindings/net/wireless/qcom,ath10k.yaml         | 25 ++++++++++++++++++++--
>   .../bindings/net/wireless/qcom,ath11k-pci.yaml     |  9 +++++++-
>   .../bindings/net/wireless/qcom,ath11k.yaml         |  7 ++++++
>   .../bindings/net/wireless/qcom,ath12k-wsi.yaml     | 13 ++++++++---
>   drivers/net/wireless/ath/ath10k/core.c             | 13 ++++++++---
>   drivers/net/wireless/ath/ath11k/core.c             |  5 ++++-
>   6 files changed, 62 insertions(+), 10 deletions(-)
> ---
> base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
> change-id: 20250225-b-wifi-qcom-calibration-variant-92a02995e996
> 
> Best regards,


