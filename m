Return-Path: <linux-wireless+bounces-14057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4469A020E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 09:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233BF284F68
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 07:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B3190073;
	Wed, 16 Oct 2024 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxALo9Co"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33107171E65;
	Wed, 16 Oct 2024 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062163; cv=none; b=uGA1l9xRoD2kHFQt9szOEkcpzKHOy53otCJGD16SatKzdT1oVl+hFtUAzeT/GJcf3FwdraJba3yDP/LRtLPR6h1XmSlbaZUqd7CBJPqWcWtGHWL5lbbxi5qbPZjzmK0D81OvkVtEn2jHIqQGlIlVmGo0Ki9HddKIPHpzAEZ7nkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062163; c=relaxed/simple;
	bh=FO++GEsxPTwtTYO2+B2x5EpogYd56XYIlW753Uemkjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dButncanJHL6opDp2leyFjyplAwlSOj8x3Jrpgh9GiV9Gpjs6hReaenjJkFGQ+KLZqCRLWcc7F5NJICFyMYW+xfxWYobHX+rjL4+0AQ+RZSgw/c3sOUbx7ktoICpHvhEs9JAFCBkFY7yaUFc2V7/xgZIjv/jsdgdB0U1SSNjoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxALo9Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5EC4CEC5;
	Wed, 16 Oct 2024 07:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729062162;
	bh=FO++GEsxPTwtTYO2+B2x5EpogYd56XYIlW753Uemkjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxALo9CoTDMhR2C6l/31YgfkBr9tvxnZJOfvbKhBqVWGgc4EZPqGeF0pKjWPPoks7
	 Ec0kI50lm8RJIQD6TyIDM3GgpB0x9kgXsBSllaCEfiqz7Sn1uoqtjDZj86S3YAnW9q
	 LaX8X6augSmPhDI8jIs5hUnjgOI3Fu4ItUYVk3EbQST584kvtNjknzr5Q2tcxxmfRo
	 1Hx+thWG40NyHbB55SQDE4DNGoejXkKx/ZgtQOf745UXDJUWh4YQgwFau6vDl/+u6t
	 HdgvtTMYRJALi2oWvTibI7mhfMxR1+9Db2U/XbbvHaFdClcmtIWnqfDdU4gZV6hmla
	 GY8PUOC6nq3Zg==
Date: Wed, 16 Oct 2024 09:02:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 01/22] dt-bindings: net: wireless: describe the ath12k
 AHB module
Message-ID: <h4xel7xh3vyljxi7jn2afqasfmbsiqjtgpvqthrviovode6cxt@ey5nnzi4dwtv>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-2-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015182637.955753-2-quic_rajkbhag@quicinc.com>

On Tue, Oct 15, 2024 at 11:56:16PM +0530, Raj Kumar Bhagat wrote:
> Add device-tree bindings for the ATH12K module found in the IPQ5332
> device.
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---

That's a v2, what changed?

Did you ignore entire review? Limited review follows because of that (I
am not going to do the same work twice).

>  .../net/wireless/qcom,ath12k-ahb.yaml         | 293 ++++++++++++++++++
>  1 file changed, 293 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> new file mode 100644
> index 000000000000..54784e396d7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> @@ -0,0 +1,293 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-ahb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies ath12k wireless devices (AHB)
> +
> +maintainers:
> +  - Kalle Valo <kvalo@kernel.org>
> +  - Jeff Johnson <jjohnson@kernel.org>
> +
> +description:
> +  Qualcomm Technologies IEEE 802.11be AHB devices.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5332-wifi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XO clock used for copy engine
> +
> +  clock-names:
> +    items:
> +      - const: gcc_xo_clk

Drop _clk, drop gcc_. Look how this clock is called *everywhere* else.

> +
> +  interrupts:
> +    items:
> +      - description: Ready interrupt
> +      - description: Spawn acknowledge interrupt
> +      - description: Stop acknowledge interrupt
> +      - description: misc-pulse1 interrupt events
> +      - description: misc-latch interrupt events
> +      - description: sw exception interrupt events
> +      - description: interrupt event for ring CE0
> +      - description: interrupt event for ring CE1
> +      - description: interrupt event for ring CE2
> +      - description: interrupt event for ring CE3
> +      - description: interrupt event for ring CE4
> +      - description: interrupt event for ring CE5
> +      - description: interrupt event for ring CE6
> +      - description: interrupt event for ring CE7
> +      - description: interrupt event for ring CE8
> +      - description: interrupt event for ring CE9
> +      - description: interrupt event for ring CE10
> +      - description: interrupt event for ring CE11
> +      - description: interrupt event for ring host2wbm-desc-feed
> +      - description: interrupt event for ring host2reo-re-injection
> +      - description: interrupt event for ring host2reo-command
> +      - description: interrupt event for ring host2rxdma-monitor-ring1
> +      - description: interrupt event for ring reo2ost-exception
> +      - description: interrupt event for ring wbm2host-rx-release
> +      - description: interrupt event for ring reo2host-status
> +      - description: interrupt event for ring reo2host-destination-ring4
> +      - description: interrupt event for ring reo2host-destination-ring3
> +      - description: interrupt event for ring reo2host-destination-ring2
> +      - description: interrupt event for ring reo2host-destination-ring1
> +      - description: interrupt event for ring rxdma2host-monitor-destination-mac3
> +      - description: interrupt event for ring rxdma2host-monitor-destination-mac2
> +      - description: interrupt event for ring rxdma2host-monitor-destination-mac1
> +      - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
> +      - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
> +      - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
> +      - description: interrupt event for ring host2tcl-input-ring4
> +      - description: interrupt event for ring host2tcl-input-ring3
> +      - description: interrupt event for ring host2tcl-input-ring2
> +      - description: interrupt event for ring host2tcl-input-ring1
> +      - description: interrupt event for ring wbm2host-tx-completions-ring4
> +      - description: interrupt event for ring wbm2host-tx-completions-ring3
> +      - description: interrupt event for ring wbm2host-tx-completions-ring2
> +      - description: interrupt event for ring wbm2host-tx-completions-ring1
> +      - description: interrupt event for ring host2tx-monitor-ring1
> +      - description: interrupt event for ring txmon2host-monitor-destination-mac3
> +      - description: interrupt event for ring txmon2host-monitor-destination-mac2
> +      - description: interrupt event for ring txmon2host-monitor-destination-mac1
> +      - description: interrupt event for umac_reset
> +
> +  interrupt-names:
> +    items:
> +      - const: ready
> +      - const: spawn
> +      - const: stop-ack
> +      - const: misc-pulse1
> +      - const: misc-latch
> +      - const: sw-exception
> +      - const: ce0
> +      - const: ce1
> +      - const: ce2
> +      - const: ce3
> +      - const: ce4
> +      - const: ce5
> +      - const: ce6
> +      - const: ce7
> +      - const: ce8
> +      - const: ce9
> +      - const: ce10
> +      - const: ce11
> +      - const: host2wbm-desc-feed
> +      - const: host2reo-re-injection
> +      - const: host2reo-command
> +      - const: host2rxdma-monitor-ring1
> +      - const: reo2ost-exception
> +      - const: wbm2host-rx-release
> +      - const: reo2host-status
> +      - const: reo2host-destination-ring4
> +      - const: reo2host-destination-ring3
> +      - const: reo2host-destination-ring2
> +      - const: reo2host-destination-ring1
> +      - const: rxdma2host-monitor-destination-mac3
> +      - const: rxdma2host-monitor-destination-mac2
> +      - const: rxdma2host-monitor-destination-mac1
> +      - const: host2rxdma-host-buf-ring-mac3
> +      - const: host2rxdma-host-buf-ring-mac2
> +      - const: host2rxdma-host-buf-ring-mac1
> +      - const: host2tcl-input-ring4
> +      - const: host2tcl-input-ring3
> +      - const: host2tcl-input-ring2
> +      - const: host2tcl-input-ring1
> +      - const: wbm2host-tx-completions-ring4
> +      - const: wbm2host-tx-completions-ring3
> +      - const: wbm2host-tx-completions-ring2
> +      - const: wbm2host-tx-completions-ring1
> +      - const: host2tx-monitor-ring1
> +      - const: txmon2host-monitor-destination-mac3
> +      - const: txmon2host-monitor-destination-mac2
> +      - const: txmon2host-monitor-destination-mac1
> +      - const: umac_reset
> +
> +  memory-region:
> +    minItems: 1

upper constraint

> +    description:
> +      phandle to a node describing reserved memory (System RAM memory)
> +      used by ath12k firmware (see bindings/reserved-memory/reserved-memory.txt)
> +
> +  qcom,rproc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      DT entry of a WCSS node. WCSS node is the child node of q6 remoteproc driver.
> +      (see bindings/remoteproc/qcom,multipd-pil.yaml)

DT nodes are not children of drivers. But other DT nodes. Explain why
this phandle is needed, what is it for.

To me it looks like you incorrectly organized your nodes.

> +
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: States used by the AP to signal the remote processor
> +    items:
> +      - description: Shutdown WCSS pd
> +      - description: Stop WCSS pd
> +      - description: Spawn WCSS pd
> +
> +  qcom,smem-state-names:
> +    description:
> +      Names of the states used by the AP to signal the remote processor
> +    items:
> +      - const: shutdown
> +      - const: stop
> +      - const: spawn
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - memory-region
> +  - qcom,rproc
> +  - qcom,smem-states
> +  - qcom,smem-state-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

Stray blank line

Best regards,
Krzysztof


