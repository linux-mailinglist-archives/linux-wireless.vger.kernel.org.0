Return-Path: <linux-wireless+bounces-29968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066CCD0F92
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21B9B3028F52
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1D2366571;
	Fri, 19 Dec 2025 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUYbiruI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A5366569;
	Fri, 19 Dec 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766162950; cv=none; b=HPNAblX7klE17LIbCIIUoQO6SW8LNyEGKEssGmA4GJ13NtW+vSmn5CL1gnPxfsLOp8j7v2dlflYBgYgF7LvMur6/uwm966Ow0NJmgVM/4dMDogr6lFj9rliqw6Kl+1VqUWeL/jKB46FI3K22Q1WfWFMabZyg9ypDT0kQwhEksdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766162950; c=relaxed/simple;
	bh=gU/Spk635yGSmiL/m1EMeZ4emx6QYD9+JLagft52vcs=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=WFeaYy4glv3mb80eYES+EZSNGG91WzHYxUSbGNzTdb8VadwUY/IseckAW0A+9NGX35Gd8LfJiXRCnvtoMNcer95iZ/lD6nzpiOtNoyK6apb7uWiAfXVe5at62p5BOp4PIwKfCC2VNZ2aX0Mom9VHpV+jtUJVA4MQ4iq0OrB1Rno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUYbiruI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C59C116D0;
	Fri, 19 Dec 2025 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766162948;
	bh=gU/Spk635yGSmiL/m1EMeZ4emx6QYD9+JLagft52vcs=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=kUYbiruIk0KQIvLCn3b0/Y/uX1d6dGlovgCtUnooFBg/BQ8bwIIWe8AKgSK5TcBfq
	 9ZxFO4O5sRrW1PtXvKgH/KK7/YMGNRUCV9lXneSGToB2DHS8Z45yW6KfzaA1hZkQlU
	 ZpG5kk4tVHcAVabmrrYDkuMOOn+O8h/ZZiIHuQkHLM4TM+zR1j83rPD/QlZHP5/HiE
	 cg+POSQsIDcdqxV3SOKiGObha/fUIcBmgYggt3CLnG6pAVfWNLjUoR+kOo1MF4HnHQ
	 tjCYCSSprwqYkYViBTsBbbzbh70hXHQR178Mm3Njq79aRdQ5QL4TQf2uezgw/J86J2
	 Df+lCZ1ZZfxPw==
From: Rob Herring <robh@kernel.org>
Date: Fri, 19 Dec 2025 10:49:06 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dale Whinham <daleyo@gmail.com>, 
 linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 ath12k@lists.infradead.org, Maximilian Luz <luzmaximilian@gmail.com>, 
 linux-wireless@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
In-Reply-To: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
References: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
Message-Id: <176616243275.3584198.6534106165888918555.robh@kernel.org>
Subject: Re: [PATCH v4 0/6] Microsoft Surface Pro 11 support


On Thu, 18 Dec 2025 23:22:06 +0100, Jérôme de Bretagne wrote:
> This series brings support for the Qualcomm-based Microsoft Surface
> Pro 11 covering both the OLED and LCD variants.
> 
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---
> Changes in v4:
> - Re-order the denali entry in the aggregator_registry acpi_match table [Dmitry]
> - Improve the bindings by splitting the LCD and OLED variants into 2 entries [Konrad]
> - Enable i2c4 to make it accessible through i2c-tools [Konrad]
> - Document the addresses for i2c0 and i2c4 like in romulus.dtsi [Konrad]
> - Fix the clock-frequency for i2c0 based on DSDT/SSDT
> - Drop i2c5 which is not found in the DSDT after double-checking
> - Add the R-b: tag from Konrad for the SP11 device trees
> - Link to v3: https://lore.kernel.org/r/20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com
> 
> Changes in v3:
> - Update the compatible strings to document both the OLED and LCD variants
> - Move the disable-rfkill property into ieee80211.yaml [Rob,Krzysztof]
> - Reference commit c6a7c0b09d5f and detail the disable-rfkill patch description [Rob,Krzysztof]
> - Switch to the renamed hamoa.dtsi and hamoa-pmics.dtsi [Dale]
> - Improve the comments describing the 2 USB Type-C port location
> - Update the speaker definition to describe only 2-speakers [Konrad]
> - Drop output-low from the speaker definition [Konrad]
> - Enable i2c0 to make it accessible through i2c-tools [Konrad]
> - Delete a non-applicable comment about removable WLAN card [Konrad]
> - Re-order a few nodes and fix indentation issues [Konrad]
> - Squash one of the patches as suggested [Krzysztof]
> - Drop the NAKed patch patch about a dpcd link rate quirk [Dmitry]
> - Include the Reviewed-by: tags
> - Link to v2: https://lore.kernel.org/all/20251201011457.17422-1-daleyo@gmail.com/
> 
> Changes in v2:
>   - Dropped ATNA30DW01 patch as it was merged.
>   - Split device tree into x1e (OLED)/x1p (LCD) specific *.dts files and move common code into x1-microsoft-denali.dtsi (patch 4).
>   - Device tree now enables higher external monitor refresh rates/resolutions (patch 4).
>   - Device tree now enables partially working audio output; requires alsa-ucm-conf and audioreach-topology definitions in userspace (patch 4).
>   - Replaced 'Work around bogus maximum link rate' with a quirk-based approach (patch 5).
>   - Improve the commit message about the disable-rfkill property in response to feedback (patch 6).
> 
> ---
> Dale Whinham (4):
>       firmware: qcom: scm: allow QSEECOM on Surface Pro 11
>       platform/surface: aggregator_registry: Add Surface Pro 11 (QCOM)
>       arm64: dts: qcom: Add support for Surface Pro 11
>       wifi: ath12k: Add support for disabling rfkill via devicetree
> 
> Jérôme de Bretagne (2):
>       dt-bindings: arm: qcom: Document Microsoft Surface Pro 11
>       dt-bindings: wireless: ieee80211: Add disable-rfkill property
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   11 +
>  .../bindings/net/wireless/ieee80211.yaml           |    6 +
>  arch/arm64/boot/dts/qcom/Makefile                  |    4 +
>  arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi  | 1324 ++++++++++++++++++++
>  .../dts/qcom/x1e80100-microsoft-denali-oled.dts    |   20 +
>  .../boot/dts/qcom/x1p64100-microsoft-denali.dts    |   16 +
>  drivers/firmware/qcom/qcom_scm.c                   |    1 +
>  drivers/net/wireless/ath/ath12k/core.c             |    3 +
>  .../platform/surface/surface_aggregator_registry.c |   18 +
>  9 files changed, 1403 insertions(+)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251218-surface-sp11-for-next-626e327f7b33
> 
> Best regards,
> --
> Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: 8f0b4cce4481fb22653697cced8d0d04027cb1e8 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com:

arch/arm64/boot/dts/qcom/x1e80100-microsoft-denali-oled.dtb: wifi@0 (pci17cb,1107): 'disable-rfkill' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml
arch/arm64/boot/dts/qcom/x1p64100-microsoft-denali.dtb: wifi@0 (pci17cb,1107): 'disable-rfkill' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml






