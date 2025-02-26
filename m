Return-Path: <linux-wireless+bounces-19460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D644A4542B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 04:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF491754F1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49246266F08;
	Wed, 26 Feb 2025 03:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpNcZV1R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15593218821;
	Wed, 26 Feb 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541956; cv=none; b=go6eEIwLYgH7HLl8TM8s9BJLHHes3+C5HHCSQJHPqPpiDV5O53ivZNeOQ7drwJrKuExLC+EwWRyBYwrry94cCStc92xHxpNudXvd2ksAuMbt4tc5tXraAw0ELJSLJ4gQVVxNItm8Eulm/Ugw5HmsKunL3YEZoMT174C3Cq+gp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541956; c=relaxed/simple;
	bh=OBm/ktjRULhvR+Dl6u2sMQDmw8mJ6M9OwWXPNkjttKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce/IevglD+tAZrHtOf0pMzTUn/qTKbOzrrwD9KJz9FMagEFCd68f0Wh3plQaCpJpKHonmct3y+V9xJDhrXkdyom6kQ4pA4GhJVBAHA1f69guZvPl4CGnAd+lL0sszfAQ7NR1ohE6p8lFSPYPOdp7MGBqUXvgIpoMoA1TPL1ecxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpNcZV1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82F3C4CED6;
	Wed, 26 Feb 2025 03:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740541955;
	bh=OBm/ktjRULhvR+Dl6u2sMQDmw8mJ6M9OwWXPNkjttKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpNcZV1Rx9gCAbniiVBT3niX4lja3lc8UTa7H47JHlJBFiNXUXSHXWlgymTeEuiIn
	 mq5KH0gkYQS5EhsSAI8WnlOz8OD7lcyGxWyKlI1aWwBQzwoIn0gcg71Au2tWECwoDG
	 8SS/PmWsOHdqJ3gDEIJICkDfJlQlpu4iJJphJswatwHMHIqwrD1ywVURsYvAaqkDcG
	 M7cKR3abiwhPZ0fCOYd0Hcpe084ltQnlVRqe54EJHve4r1mr4Y/Kbe33AKTd1fvibb
	 BPYfzE7NUagOdqcX22BkDWSw7nCw/kbHH3Zb/9TqIyP5T4AYa/P0odlH6KmSZMIeH1
	 KtGlScGkVX8tw==
Date: Tue, 25 Feb 2025 21:52:32 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: add wifi node for IPQ5332 based
 RDP441
Message-ID: <3iwfhcl5gmpwfiatsawwkm5qns4pmzvhcrroq236y45kklw244@6rngcplttabx>
References: <20250130045900.1903927-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130045900.1903927-1-quic_rajkbhag@quicinc.com>

On Thu, Jan 30, 2025 at 10:29:00AM +0530, Raj Kumar Bhagat wrote:
> RDP441 is based on IPQ5332. It has inbuilt AHB bus based IPQ5332 WiFi
> device.
> 
> Describe and add WiFi node for RDP441. Also, reserve the memory
> required by IPQ5332 firmware.
> 
> Depends-On: [PATCH V2 0/2] mailbox: tmel-qmp: Introduce QCOM TMEL QMP mailbox driver
> Depends-On: [PATCH V3 0/8] Add new driver for WCSS secure PIL loading
> Link: https://lore.kernel.org/lkml/20241231054900.2144961-1-quic_srichara@quicinc.com/
> Link: https://lore.kernel.org/lkml/20250107101647.2087358-1-quic_gokulsri@quicinc.com/

Please run "git log --grep 'Depends-on'" to see how this tag is expected
to be used. As you can see, dependencies on other patches in flight does
not go into the git history, and should as such be mentioned only below
the --- line below.

Please wait for these dependencies to be accepted before resubmitting
this Devicetree change.

> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
> NOTE:
> The DT binding changes for this patch has been posted along with the
> driver ath12k AHB series.
> Link: https://lore.kernel.org/all/20250130043508.1885026-1-quic_rajkbhag@quicinc.com/
> 
> v2:
> - Dropped 'dt-bindings: net: wireless: describe the ath12k AHB module'.
>   This DT binding is posted along with the ath12k AHB driver changes.
> - Reserved four memory regions required by IPQ5332 ath12k firmware in DTS.
>   These memory regions are also referenced in the WiFi node.
> - Moved 'qcom,smem-states' and 'qcom,smem-states' to the ipq5332.dtsi file.
> - Used lowercase hex values for the reg property.
> 
> v1: https://lore.kernel.org/all/20250128091012.2574478-1-quic_rajkbhag@quicinc.com/
> ---
>  arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts |  64 ++++++++++-
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 113 ++++++++++++++++++++
>  2 files changed, 176 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> index 846413817e9a..4b7a75e450ca 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> @@ -2,7 +2,7 @@
>  /*
>   * IPQ5332 AP-MI01.2 board device tree source
>   *
> - * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
> @@ -12,6 +12,61 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.2";
>  	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
> +
> +	/*                 Default Profile

Why is the title "Default Profile", is this expected to be changed by
someone? At what point?

> +	 * +============+==============+=====================+
> +	 * |            |              |                     |
> +	 * | Region     | Start Offset |       Size          |

"Start Offset" relative to address 0 is typically called "base address".

> +	 * |            |              |                     |
> +	 * +------------+--------------+---------------------+
> +	 * |            |              |                     |
> +	 * |            |              |                     |
> +	 * |            |              |                     |
> +	 * | WLAN Q6    |  0x4A900000  |       43MB          |
> +	 * |            |              |                     |
> +	 * |            |              |                     |
> +	 * +------------+--------------+---------------------+
> +	 * | M3 Dump    |  0x4D400000  |       1MB           |
> +	 * +------------+--------------+---------------------+
> +	 * | Q6 caldb   |  0x4D500000  |       5MB           |
> +	 * +------------+--------------+---------------------+
> +	 * | MLO        |  0x4DB00000  |       18MB          |

18MB is the same size in your graph as the 1MB segment, but somehow the
43MB segment is 5 times the size of the 18MB segment. So the graph isn't
to scale...

> +	 * +============+==============+=====================+
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * |            Rest of memory for Linux             |
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * +=================================================+

Doesn't DDR start on a more even address, such as 0x40000000? I presume
the purpose of your picture was to give a good overview of the memory
layout of this system, but the only thing it added to the table below is
a curious question about what happened to the first 169MB of DDR.


Please omit the graph, it doesn't add value beyond what's provided by
the below text form of the "same" data.

> +	 */
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		q6_region: wcss@4a900000 {
> +			reg = <0x0 0x4a900000 0x0 0x02b00000>;
> +			no-map;
> +		};
> +
> +		m3_dump: m3-dump@4d400000 {
> +			reg = <0x0 0x4d400000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		q6_caldb: q6-caldb@4d500000 {
> +			reg = <0x0 0x4d500000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		mlo_mem: mlo-global-mem@4db00000 {
> +			reg = <0x0 0x4db00000 0x0 0x01200000>;
> +			no-map;
> +		};
> +	};
>  };
>  
>  &blsp1_i2c1 {
> @@ -63,3 +118,10 @@ data-pins {
>  		};
>  	};
>  };
> +
> +&wifi0 {
> +	memory-region = <&q6_region>, <&m3_dump>, <&q6_caldb>, <&mlo_mem>;
> +	memory-region-names = "q6-region", "m3-dump", "q6-caldb", "mlo-global-mem";

As you are resubmitting this, it would be nice to have these two
properties wrapped (one entry per line), to increase readability...

Regards,
Bjorn

> +	qcom,rproc = <&q6v5_wcss>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 85e10b20342a..1653da89d413 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -485,6 +485,119 @@ frame@b128000 {
>  			};
>  		};
>  
> +		wifi0: wifi@c000000 {
> +			compatible = "qcom,ipq5332-wifi";
> +			reg = <0x0c000000 0x1000000>;
> +			clocks = <&gcc GCC_XO_CLK>;
> +			clock-names = "xo";
> +			interrupts-extended = <&wcss_smp2p_in 8 IRQ_TYPE_NONE>,
> +					      <&wcss_smp2p_in 9 IRQ_TYPE_NONE>,
> +					      <&wcss_smp2p_in 12 IRQ_TYPE_NONE>,
> +					      <&wcss_smp2p_in 11 IRQ_TYPE_NONE>,
> +					      <&intc GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 422 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 423 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 424 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 425 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 426 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 427 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 428 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 429 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 430 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 431 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 491 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 495 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 493 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 544 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 457 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 497 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 454 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 453 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 452 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 451 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 484 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 507 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 500 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 499 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 498 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 450 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 449 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 447 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 543 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 482 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 419 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "fatal",
> +					  "ready",
> +					  "spawn",
> +					  "stop-ack",
> +					  "misc-pulse1",
> +					  "misc-latch",
> +					  "sw-exception",
> +					  "ce0",
> +					  "ce1",
> +					  "ce2",
> +					  "ce3",
> +					  "ce4",
> +					  "ce5",
> +					  "ce6",
> +					  "ce7",
> +					  "ce8",
> +					  "ce9",
> +					  "ce10",
> +					  "ce11",
> +					  "host2wbm-desc-feed",
> +					  "host2reo-re-injection",
> +					  "host2reo-command",
> +					  "host2rxdma-monitor-ring1",
> +					  "reo2ost-exception",
> +					  "wbm2host-rx-release",
> +					  "reo2host-status",
> +					  "reo2host-destination-ring4",
> +					  "reo2host-destination-ring3",
> +					  "reo2host-destination-ring2",
> +					  "reo2host-destination-ring1",
> +					  "rxdma2host-monitor-destination-mac3",
> +					  "rxdma2host-monitor-destination-mac2",
> +					  "rxdma2host-monitor-destination-mac1",
> +					  "host2rxdma-host-buf-ring-mac3",
> +					  "host2rxdma-host-buf-ring-mac2",
> +					  "host2rxdma-host-buf-ring-mac1",
> +					  "host2tcl-input-ring4",
> +					  "host2tcl-input-ring3",
> +					  "host2tcl-input-ring2",
> +					  "host2tcl-input-ring1",
> +					  "wbm2host-tx-completions-ring4",
> +					  "wbm2host-tx-completions-ring3",
> +					  "wbm2host-tx-completions-ring2",
> +					  "wbm2host-tx-completions-ring1",
> +					  "host2tx-monitor-ring1",
> +					  "txmon2host-monitor-destination-mac3",
> +					  "txmon2host-monitor-destination-mac2",
> +					  "txmon2host-monitor-destination-mac1",
> +					  "umac-reset";
> +
> +			qcom,smem-states = <&wcss_smp2p_out 8>,
> +					   <&wcss_smp2p_out 9>,
> +					   <&wcss_smp2p_out 10>;
> +			qcom,smem-state-names = "shutdown",
> +						"stop",
> +						"spawn";
> +			status = "disabled";
> +		};
> +
>  		q6v5_wcss: remoteproc@d100000 {
>  			compatible = "qcom,ipq5332-wcss-sec-pil";
>  			reg = <0xd100000 0x4040>;
> -- 
> 2.34.1
> 

