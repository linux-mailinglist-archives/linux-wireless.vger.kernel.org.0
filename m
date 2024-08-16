Return-Path: <linux-wireless+bounces-11510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA2C954145
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 07:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB0A1F248EA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7FF7F460;
	Fri, 16 Aug 2024 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtipbV1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA47DA98
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786970; cv=none; b=o2glHicc8FCL1q0HckfxTZn8VXtaOutJGBuuAefjIucAqwW+U30Vrc5KFsmqpoMqg715VTNN9tOmYASmsuKbR24ogfgRJLVgA8h9SCXU6oL+xgSbUlp7X6/z2vdAjRiBBkpmUpeSt068DeOWzQU6BJwT2UfoE0GTTj5mygWJ3tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786970; c=relaxed/simple;
	bh=ZUJ9OQpZMNZejBqmlBPk7iYU5SODnrxPnx8msjf4TdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hqjj2Y3yAnhFoU9g/YzhjYdunypgcC/37Z+5X0A5Q0udUZql3MmoWLrOpV8ASYkB9NT6m8FpeYniZKZY0gJxI3P6F8R/cL/I520XlaOTUtNZwSk8npORVtAllIALyrfg24hbKJ7VkdTy53B41hWg10a993fkFWHR5z5BZdiXDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtipbV1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A7BC32782;
	Fri, 16 Aug 2024 05:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723786969;
	bh=ZUJ9OQpZMNZejBqmlBPk7iYU5SODnrxPnx8msjf4TdI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OtipbV1F+4zlq2SCNVqMIygSbQgD4sb2BwfrGPMzQk9jCf43E6nQ29FfLcZ92H9to
	 mKoWO70ke2MLnwMqpFbn48y7uPiQALHACTkf0QOhuvpA7l5Jjq5F0ao+0UlNtEuJ3Y
	 I5KtLyRk4atxWP3qzqafq5w3tGmhKmd/1hwNAIjYHL4iiRD6A566VH0pIP3yQD62hC
	 +616zdqlzpd3Ly7iZ52ixm8SebAny6eT8gURWjYLemQplDsVlKNzJbmD33zHZ/z5Fo
	 Vqgr8Q3s7wVo9hEdbE5G7Z/vdQpHnHMzJXRr8fyS/jtHc/K6t1omCABm1PYCNA2GtY
	 a/tx011suKivw==
Message-ID: <6a740dee-464a-4a10-9c25-ee6f0d22b279@kernel.org>
Date: Fri, 16 Aug 2024 07:42:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/18] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
 <20240814094323.3927603-2-quic_rajkbhag@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240814094323.3927603-2-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 11:43, Raj Kumar Bhagat wrote:
> Add device-tree bindings for the ATH12K module found in the IPQ5332
> device.
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.
</form letter>

> ---
>  .../net/wireless/qcom,ath12k-ahb.yaml         | 325 ++++++++++++++++++
>  1 file changed, 325 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> new file mode 100644
> index 000000000000..8cecc50b6341
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> @@ -0,0 +1,325 @@
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
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    minItems: 32
> +    maxItems: 56
> +
> +  interrupt-names:
> +    minItems: 32
> +    maxItems: 56
> +
> +  memory-region:
> +    minItems: 1
> +    description:
> +      phandle to a node describing reserved memory (System RAM memory)
> +      used by ath12k firmware (see bindings/reserved-memory/reserved-memory.txt)
> +
> +  qcom,bdf-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      System RAM memory address reserved for board data.
> +
> +  qcom,board_id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Board id value, it identifies the variant of ath12k WiFi device.

Please do not upstream whatever you have in your vendor tree... You even
copied its style! There is no such property in upstream.

NAK, you are duplicating compatibles.



> +
> +  qcom,rproc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      DT entry of a WCSS node. WCSS node is the child node of q6 remoteproc driver.
> +      (see bindings/remoteproc/qcom,multipd-pil.yaml)
> +
> +required:
> +  - compatible
> +  - reg
> +  - memory-region
> +  - qcom,board_id
> +  - qcom,rproc
> +
> +additionalProperties: false
> +
> +allOf:
> +  - $ref: ieee80211.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq5332-wifi

Why? You have only one variant, why this if?
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: gcc_xo_clk used for copy engine
> +            - description: gcc_im_sleep_clk used for q6.
> +
> +        clock-names:
> +          items:
> +            - const: gcc_xo_clk
> +            - const: gcc_im_sleep_clk
> +
> +        interrupts:
> +          items:
> +            - description: misc-pulse1 interrupt events
> +            - description: misc-latch interrupt events
> +            - description: sw exception interrupt events
> +            - description: interrupt event for ring CE0
> +            - description: interrupt event for ring CE1
> +            - description: interrupt event for ring CE2
> +            - description: interrupt event for ring CE3
> +            - description: interrupt event for ring CE4
> +            - description: interrupt event for ring CE5
> +            - description: interrupt event for ring CE6
> +            - description: interrupt event for ring CE7
> +            - description: interrupt event for ring CE8
> +            - description: interrupt event for ring CE9
> +            - description: interrupt event for ring CE10
> +            - description: interrupt event for ring CE11
> +            - description: interrupt event for ring host2wbm-desc-feed
> +            - description: interrupt event for ring host2reo-re-injection
> +            - description: interrupt event for ring host2reo-command
> +            - description: interrupt event for ring host2rxdma-monitor-ring1
> +            - description: interrupt event for ring reo2ost-exception
> +            - description: interrupt event for ring wbm2host-rx-release
> +            - description: interrupt event for ring reo2host-status
> +            - description: interrupt event for ring reo2host-destination-ring4
> +            - description: interrupt event for ring reo2host-destination-ring3
> +            - description: interrupt event for ring reo2host-destination-ring2
> +            - description: interrupt event for ring reo2host-destination-ring1
> +            - description: interrupt event for ring rxdma2host-monitor-destination-mac3
> +            - description: interrupt event for ring rxdma2host-monitor-destination-mac2
> +            - description: interrupt event for ring rxdma2host-monitor-destination-mac1
> +            - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
> +            - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
> +            - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
> +            - description: interrupt event for ring host2tcl-input-ring4
> +            - description: interrupt event for ring host2tcl-input-ring3
> +            - description: interrupt event for ring host2tcl-input-ring2
> +            - description: interrupt event for ring host2tcl-input-ring1
> +            - description: interrupt event for ring wbm2host-tx-completions-ring4
> +            - description: interrupt event for ring wbm2host-tx-completions-ring3
> +            - description: interrupt event for ring wbm2host-tx-completions-ring2
> +            - description: interrupt event for ring wbm2host-tx-completions-ring1
> +            - description: interrupt event for ring host2tx-monitor-ring1
> +            - description: interrupt event for ring txmon2host-monitor-destination-mac3
> +            - description: interrupt event for ring txmon2host-monitor-destination-mac2
> +            - description: interrupt event for ring txmon2host-monitor-destination-mac1
> +            - description: interrupt event for umac_reset
> +        interrupt-names:
> +          items:
> +            - const: misc-pulse1
> +            - const: misc-latch
> +            - const: sw-exception
> +            - const: ce0
> +            - const: ce1
> +            - const: ce2
> +            - const: ce3
> +            - const: ce4
> +            - const: ce5
> +            - const: ce6
> +            - const: ce7
> +            - const: ce8
> +            - const: ce9
> +            - const: ce10
> +            - const: ce11
> +            - const: host2wbm-desc-feed
> +            - const: host2reo-re-injection
> +            - const: host2reo-command
> +            - const: host2rxdma-monitor-ring1
> +            - const: reo2ost-exception
> +            - const: wbm2host-rx-release
> +            - const: reo2host-status
> +            - const: reo2host-destination-ring4
> +            - const: reo2host-destination-ring3
> +            - const: reo2host-destination-ring2
> +            - const: reo2host-destination-ring1
> +            - const: rxdma2host-monitor-destination-mac3
> +            - const: rxdma2host-monitor-destination-mac2
> +            - const: rxdma2host-monitor-destination-mac1
> +            - const: host2rxdma-host-buf-ring-mac3
> +            - const: host2rxdma-host-buf-ring-mac2
> +            - const: host2rxdma-host-buf-ring-mac1
> +            - const: host2tcl-input-ring4
> +            - const: host2tcl-input-ring3
> +            - const: host2tcl-input-ring2
> +            - const: host2tcl-input-ring1
> +            - const: wbm2host-tx-completions-ring4
> +            - const: wbm2host-tx-completions-ring3
> +            - const: wbm2host-tx-completions-ring2
> +            - const: wbm2host-tx-completions-ring1
> +            - const: host2tx-monitor-ring1
> +            - const: txmon2host-monitor-destination-mac3
> +            - const: txmon2host-monitor-destination-mac2
> +            - const: txmon2host-monitor-destination-mac1
> +            - const: umac_reset
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq5332-wifi
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +        - interrupts
> +        - interrupt-names
> +        - qcom,bdf-addr
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> +
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        q6_region: wcnss@4a900000 {
> +            no-map;
> +            reg = <0x0 0x4a900000 0x0 0x02300000>;
> +        };
> +
> +        m3_dump: m3_dump@4cc00000 {
> +            no-map;
> +            reg = <0x0 0x4CC00000 0x0 0x100000>;
> +        };
> +    };

Drop

> +
> +    wifi0: wifi@c0000000 {
> +        compatible = "qcom,ipq5332-wifi";
> +        reg = <0xc000000 0x1000000>;
> +        clocks = <&gcc GCC_XO_CLK>,
> +                 <&gcc GCC_IM_SLEEP_CLK>;
> +        clock-names = "gcc_xo_clk",
> +                      "gcc_im_sleep_clk";
> +        interrupts = <GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 422 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 423 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 424 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 425 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 426 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 427 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 428 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 429 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 430 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 431 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 491 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 495 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 493 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 544 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 457 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 497 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 454 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 453 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 484 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 507 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 500 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 499 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 498 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 450 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 447 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 543 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 482 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 419 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "misc-pulse1",
> +                          "misc-latch",
> +                          "sw-exception",
> +                          "ce0",
> +                          "ce1",
> +                          "ce2",
> +                          "ce3",
> +                          "ce4",
> +                          "ce5",
> +                          "ce6",
> +                          "ce7",
> +                          "ce8",
> +                          "ce9",
> +                          "ce10",
> +                          "ce11",
> +                          "host2wbm-desc-feed",
> +                          "host2reo-re-injection",
> +                          "host2reo-command",
> +                          "host2rxdma-monitor-ring1",
> +                          "reo2ost-exception",
> +                          "wbm2host-rx-release",
> +                          "reo2host-status",
> +                          "reo2host-destination-ring4",
> +                          "reo2host-destination-ring3",
> +                          "reo2host-destination-ring2",
> +                          "reo2host-destination-ring1",
> +                          "rxdma2host-monitor-destination-mac3",
> +                          "rxdma2host-monitor-destination-mac2",
> +                          "rxdma2host-monitor-destination-mac1",
> +                          "host2rxdma-host-buf-ring-mac3",
> +                          "host2rxdma-host-buf-ring-mac2",
> +                          "host2rxdma-host-buf-ring-mac1",
> +                          "host2tcl-input-ring4",
> +                          "host2tcl-input-ring3",
> +                          "host2tcl-input-ring2",
> +                          "host2tcl-input-ring1",
> +                          "wbm2host-tx-completions-ring4",
> +                          "wbm2host-tx-completions-ring3",
> +                          "wbm2host-tx-completions-ring2",
> +                          "wbm2host-tx-completions-ring1",
> +                          "host2tx-monitor-ring1",
> +                          "txmon2host-monitor-destination-mac3",
> +                          "txmon2host-monitor-destination-mac2",
> +                          "txmon2host-monitor-destination-mac1",
> +                          "umac_reset";
> +
> +        memory-region = <&q6_region>;
> +        qcom,bdf-addr = <0x4B500000>;
> +        qcom,board_id = <0x12>;
> +        qcom,rproc = <&q6_wcss_pd1>;
> +        status = "okay";

Drop

> +    };

Best regards,
Krzysztof


