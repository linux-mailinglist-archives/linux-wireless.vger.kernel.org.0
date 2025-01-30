Return-Path: <linux-wireless+bounces-18226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87B4A2341C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 19:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242A81663E2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6F81F0E57;
	Thu, 30 Jan 2025 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqlcGmlj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C171F0E4F;
	Thu, 30 Jan 2025 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263028; cv=none; b=WGrsZGVGFzdAERUIhzphxx7FDTkmMqm6VOfSytbH99yMWwYQ85PBfmJe/IhFF3U92CeuteTo/tGFG9Xqgk0hOuQlXnLVpZVikvL63nlWnFL1QVirtUv91xFFKA9qnheTyUXqFzkyCHUvjEK7bXmMkX4b5u5GJuDTDcLXcf2YDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263028; c=relaxed/simple;
	bh=MYg3AsTcSXQARcbaugNsK02PwWByaCjobZg5rK43YCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEhWyyYEfq6pV/FI47MdZJWpWJPOgL6KNYWXkhfjyX83Bl7jZGPU5jFZHdCz9iMLFQrJt0fkQLvY+UPder7Irk9gtrV9ipQiX7kv4ON+/WdoLiP/7ZsTdyS2rDZK7cGaVlrk3gmqaNaGcUO07h4f1tgCKVMP3OY4B5klHqJ92Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqlcGmlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DACC4CEE1;
	Thu, 30 Jan 2025 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263028;
	bh=MYg3AsTcSXQARcbaugNsK02PwWByaCjobZg5rK43YCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqlcGmljoIX90woxDCJs9LO3Foqri2WOlX++4D/mrtPJr8vdkcBPm9joJ5Y6ASSGI
	 Yqbt0VTLnPPPx2RNwG8J9gpCMvb8Kq0HPTo0HsUcwH/A/zFMNypNnT7BIHTHnuYKTA
	 +GEiawgn4yhmo0F3heRsmYAbxF76+YeOQBBPHfQjYAJbj94i+qQ1TcaTjx1x52LtbM
	 AuCrw/HTqov5+UxTKDupe+f55Qzej5Yy/wCnk3p7cEyrGo+ixSljZNQny1V5DUvqvV
	 QdnSf46yHfoSmWLJOHJAtIEn9Q9Qt8tQcvWU2tbmZ5Crysjmoj77htbIBlUi8eJrVo
	 tGCpF74tXX6Lw==
Date: Thu, 30 Jan 2025 18:50:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] dt-bindings: net: wireless: describe the ath12k
 wifi device IPQ5424
Message-ID: <20250130-divisible-chrome-3f9c5d1aff11@spud>
References: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
 <20250130051838.1924079-2-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oqfI5O9GKaxgpMRo"
Content-Disposition: inline
In-Reply-To: <20250130051838.1924079-2-quic_rajkbhag@quicinc.com>


--oqfI5O9GKaxgpMRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 10:48:34AM +0530, Raj Kumar Bhagat wrote:
> Describe and add the device-tree bindings for the ATH12K AHB wifi device
> IPQ5424.
>=20
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  .../net/wireless/qcom,ath12k-ahb.yaml         | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-a=
hb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.ya=
ml
> index bd953a028dc3..1d24389a0ab3 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,ipq5332-wifi
> +      - qcom,ipq5424-wifi

Patch should end here, another example for something that doesn't have
different properties etc is pointless.

Thanks,
Conor.

> =20
>    reg:
>      maxItems: 1
> @@ -317,3 +318,121 @@ examples:
>                                  "stop",
>                                  "spawn";
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    wifi1: wifi@c000000 {
> +        compatible =3D "qcom,ipq5424-wifi";
> +        reg =3D <0x0c000000 0x1000000>;
> +        clocks =3D <&gcc GCC_XO_CLK_SRC>;
> +        clock-names =3D "xo";
> +        interrupts-extended =3D <&wcss_smp2p_in 8 IRQ_TYPE_NONE>,
> +                              <&wcss_smp2p_in 9 IRQ_TYPE_NONE>,
> +                              <&wcss_smp2p_in 12 IRQ_TYPE_NONE>,
> +                              <&wcss_smp2p_in 11 IRQ_TYPE_NONE>,
> +                              <&intc GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 518 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 519 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 520 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 521 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 522 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 523 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 524 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 525 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 526 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 527 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 528 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 529 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 574 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 576 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 627 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 540 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 580 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 537 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 536 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 535 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 534 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 571 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 571 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 567 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 637 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 637 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 632 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 590 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 583 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 582 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 581 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 533 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 532 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 531 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 530 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 626 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 569 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 569 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 565 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 502 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names =3D "fatal",
> +                          "ready",
> +                          "spawn",
> +                          "stop-ack",
> +                          "misc-pulse1",
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
> +                          "umac-reset";
> +
> +        memory-region =3D <&q6_region>, <&m3_dump>, <&q6_caldb>, <&mlo_m=
em>;
> +        memory-region-names =3D "q6-region", "m3-dump", "q6-caldb", "mlo=
-global-mem";
> +        qcom,ath12k-calibration-variant =3D "RDP466_1";
> +        qcom,rproc =3D <&q6v5_wcss>;
> +        qcom,smem-states =3D <&wcss_smp2p_out 8>,
> +                           <&wcss_smp2p_out 9>,
> +                           <&wcss_smp2p_out 10>;
> +        qcom,smem-state-names =3D "shutdown",
> +                                "stop",
> +                                "spawn";
> +    };
> --=20
> 2.34.1
>=20

--oqfI5O9GKaxgpMRo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5vJ7wAKCRB4tDGHoIJi
0tT8AP97QJzy4JYDX4rqfgSWMw5o6OfXPhgOwTkxo8ugz0H54gEAztVHnmEb6L26
S46P8pMtTxhSsdieGy9hKR/y+xjWggw=
=yj6F
-----END PGP SIGNATURE-----

--oqfI5O9GKaxgpMRo--

