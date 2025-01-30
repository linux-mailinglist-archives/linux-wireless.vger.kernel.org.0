Return-Path: <linux-wireless+bounces-18209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D11A22991
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 09:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629F01664F7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3DC1AF0A7;
	Thu, 30 Jan 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kdk4+Os4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF583145B27;
	Thu, 30 Jan 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225700; cv=none; b=Lg1jRybyK5lmh6QaWdcHkyjHxfYYltHBQD7iljBU53DOxXUDPODs0yOzFnWf4D8Y2RHFepJIBnPrcwd+Szn35wco2Yr0w1Qcotx0TK6P7Tposhn7A++aU1Q0K4q0DSSJsOnFAIMKSk7c/cjwkAgZmI00GlShMmolWR/wKthrt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225700; c=relaxed/simple;
	bh=IsoMpdDBx+byAmxT3k6y9t2ZP5/v4grlO+yHnBpVvPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdN1FOoz3Yd+Hkt/cLnYNkq7oZE4GA4i1lU4rQ1BbLamKOE3jOHKiVi0QLFyf/kDdpRo0rSIGJQEAbgezqkMAo8UFyQnkCxP5OP1gx3wY1p11DUaQYQXj+wFZ3Mur4H8osgetMKxO9sCVw8PYyUrqeXAN5/Q7TbPoOxWQCnh/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kdk4+Os4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA33C4CED2;
	Thu, 30 Jan 2025 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738225700;
	bh=IsoMpdDBx+byAmxT3k6y9t2ZP5/v4grlO+yHnBpVvPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kdk4+Os46KBumfKAnPZcx06v/7laVPm7Ge95CDXpTUgnuTWp372r65aJyWcEhbows
	 NsUcxjnO8eRtcuF4+ULfgP1pAkMyJXf5IgP0XWtm8XXRzqCF/KBMLcmfUSk6GsSbtd
	 Ui1W1XeOZJiuPqtufGkjxVnT2cgV87CJ4ekZJgGyJkfzuuEoIDMXt4EynOqDbmOUmc
	 vh7wkjbs+7UKA3bdCO5EbG91YgPLCEqnDLfW4hmz6MxmikVPBu5mP0hLujCFwqvQbb
	 PNezRr0uVV6BTOxaP/66Ga6yWtyiYlhXQ8JBi5dWVVCPHB8O3C2GyOG20FJbz4Mdj8
	 b2diw9O+Z1aGw==
Date: Thu, 30 Jan 2025 09:28:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/13] dt-bindings: net: wireless: describe the ath12k
 AHB module
Message-ID: <20250130-cunning-quail-of-opportunity-76d0ad@krzk-bin>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-2-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130043508.1885026-2-quic_rajkbhag@quicinc.com>

On Thu, Jan 30, 2025 at 10:04:56AM +0530, Raj Kumar Bhagat wrote:
> Add device-tree bindings for the ATH12K module found in the IPQ5332
> device.
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  .../net/wireless/qcom,ath12k-ahb.yaml         | 319 ++++++++++++++++++
>  1 file changed, 319 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> new file mode 100644
> index 000000000000..bd953a028dc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml

Filename should match compatible. This binding does not look like
supporting more devices, so there is no much benefit calling it by generic name.


> @@ -0,0 +1,319 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
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
> +      - const: xo
> +
> +  interrupts:
> +    items:
> +      - description: Fatal interrupt
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
> +      - description: interrupt event for umac-reset
> +
> +  interrupt-names:
> +    items:
> +      - const: fatal
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
> +      - const: umac-reset
> +
> +  memory-region:
> +    description:
> +      phandle to a node describing reserved memory (System RAM memory)
> +      used by ath12k firmware (see bindings/reserved-memory/reserved-memory.txt)

Do not say what DT syntax is, so "phandle to a node" is redundant,
reserved-memory.txt is redundant. The only useful part here is "used by
ath12k firmware", so based on this none of below are used by the driver
and driver just passes them to the firmware?

> +    items:
> +      - description: Q6 memory region
> +      - description: m3 dump memory region
> +      - description: Q6 caldata memory region
> +      - description: Multi Link Operation (MLO) Global memory region
> +
> +  memory-region-names:
> +    description:
> +      Name of the reserved memory region used by ath12k firmware

Drop description.

> +    items:
> +      - const: q6-region
> +      - const: m3-dump
> +      - const: q6-caldb
> +      - const: mlo-global-mem
> +
> +  qcom,ath12k-calibration-variant:
> +    $ref: /schemas/types.yaml#/definitions/string

Why this is named after ath12k? Why this is just not
"qcom,calibration-variant"? None of the other properties have ath12k in
their names, so why this one in the WSI schema was named like that?

> +    description:
> +      String to uniquely identify variant of the calibration data for designs
> +      with colliding bus and device ids

I don't think this property is here possible. How could you have on the
same SoC different devices?

Best regards,
Krzysztof


