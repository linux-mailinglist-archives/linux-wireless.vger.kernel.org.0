Return-Path: <linux-wireless+bounces-8614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926A8FE7E4
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C781C20E20
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 13:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B23195F07;
	Thu,  6 Jun 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+0eQwGU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88502A1C2;
	Thu,  6 Jun 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680855; cv=none; b=idiaybcG2iWzre2SWmHXR8i40zM34PYhsTEuSoI/c59e8FyUJn4o+4V+ESTWHf+cztNjvqh8bWGaZxmbLp2W1+GwPT3QZkSf5e8bRCQxrBkZgLV7+pFtUogONijFdvNhHH87nj0tpjZC/YYkd4b9fdnZJjmsCqzyXUB+oqzRATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680855; c=relaxed/simple;
	bh=eL/g/oUrAWm5JIaMO5q18too/EUOHHxjbv/SpSpADl4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FMxuT9pO27zjt6yJ1T62mTAP/hAblgEN9LK/WpAOsLzO7t7bYnTxE3u9b+y2FEV4OYy7gMVzKREAY9H0OD/E6Ejig8b6gGON1QLeoQXkwlikDdU9NmkefCjP8JRfdzmCu/LhwnU1f5ImFm1eEuFkTJpo8/M0KYJTzx4bMEM40fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+0eQwGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6A4C2BD10;
	Thu,  6 Jun 2024 13:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717680855;
	bh=eL/g/oUrAWm5JIaMO5q18too/EUOHHxjbv/SpSpADl4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=d+0eQwGUhHjyuIv5Un2Kh5AgnrMQxrjp3vUm9yQhUzbUSVggC7KM2eO1isMz0+ZH4
	 h3SIDih8zMffIuN2H18ywEP4xtBpk9vTIqznukx66KVy1625U51Yeb/+DjJie3M4DG
	 wfPHlv1XcQt1cP3FMg1OVQe4NVtTq5zUhzMVt9RLxe8z0HbYQyUcUHNOPLumi8JHjh
	 TXzj0Fjhlz50HXH4a7wAnh4DKp/DHvB9YLI8Ie7xJ/HmI2g/LFK4J/2aORABAIj916
	 I3EcTwiBBVAUHnSs/HVfsKdz8TVHD/w3k/PjHtoRhqFRjgmrt2DXDPuiml9Ys53+CU
	 w+11WNBwY7kiQ==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Jeff Johnson
 <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  ath11k@lists.infradead.org,  linux-kernel@vger.kernel.org,
  ath12k@lists.infradead.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 2/2] dt-bindings: net: wireless: describe the ath12k
 PCI module
References: <20240605122106.23818-1-brgl@bgdev.pl>
	<20240605122106.23818-3-brgl@bgdev.pl>
Date: Thu, 06 Jun 2024 16:34:09 +0300
In-Reply-To: <20240605122106.23818-3-brgl@bgdev.pl> (Bartosz Golaszewski's
	message of "Wed, 5 Jun 2024 14:21:05 +0200")
Message-ID: <87cyouqjou.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add device-tree bindings for the ATH12K module found in the WCN7850
> package.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../bindings/net/wireless/qcom,ath12k.yaml    | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> new file mode 100644
> index 000000000000..1b5884015b15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024 Linaro Limited
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies ath12k wireless devices (PCIe)
> +
> +maintainers:
> +  - Jeff Johnson <quic_jjohnson@quicinc.com>
> +  - Kalle Valo <kvalo@kernel.org>
> +
> +description:
> +  Qualcomm Technologies IEEE 802.11be PCIe devices.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci17cb,1107  # WCN7850
> +
> +  reg:
> +    maxItems: 1
> +
> +  vddaon-supply:
> +    description: VDD_AON supply regulator handle
> +
> +  vddwlcx-supply:
> +    description: VDD_WLCX supply regulator handle
> +
> +  vddwlmx-supply:
> +    description: VDD_WLMX supply regulator handle
> +
> +  vddrfacmn-supply:
> +    description: VDD_RFA_CMN supply regulator handle
> +
> +  vddrfa0p8-supply:
> +    description: VDD_RFA_0P8 supply regulator handle
> +
> +  vddrfa1p2-supply:
> +    description: VDD_RFA_1P2 supply regulator handle
> +
> +  vddrfa1p8-supply:
> +    description: VDD_RFA_1P8 supply regulator handle
> +
> +  vddpcie0p9-supply:
> +    description: VDD_PCIE_0P9 supply regulator handle
> +
> +  vddpcie1p8-supply:
> +    description: VDD_PCIE_1P8 supply regulator handle
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddaon-supply
> +  - vddwlcx-supply
> +  - vddwlmx-supply
> +  - vddrfacmn-supply
> +  - vddrfa0p8-supply
> +  - vddrfa1p2-supply
> +  - vddrfa1p8-supply
> +  - vddpcie0p9-supply
> +  - vddpcie1p8-supply

Same comment here. To my understanding there are ath12k PCI devices
which do not need the supplies. But I guess we change this to optional
later?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

