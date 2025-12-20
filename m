Return-Path: <linux-wireless+bounces-30030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F2CD31F0
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 16:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAAD5302AE0B
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6992DC332;
	Sat, 20 Dec 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onuPDWkI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196C2D8DCA;
	Sat, 20 Dec 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244475; cv=none; b=B0nRRPXZzKAmxXDqehdryxIOIAszP4PedF8jt8YjYZg25do9zbRINgHlE4anezUxaJFucRjFEnp3mmKF2Q6RXHhRrgpDSDizheR1UxGCEwrrbguhBL1OFXs4n/HM7HDNQ+H88GM6wCOF8TlAb+4IDVhrc3Wu8OI3eql0bs1tJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244475; c=relaxed/simple;
	bh=DPZHoH7vOJ/r2CeJeriCWNUsS83oy/VS5P0MpcoRIXQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D01BTC3K5WD/duMInb1tUXEKW/3Q+FpEyQUJqt2GAj9GDTsZl4FYimpK0VdiE6qVcheU3BdwWCmLcvPQ5XRAQ4yOH9oSOipb44NZiOXT3CifyJco/09xh6pQ9xm9jxnn047T8JdZv1u3VoJsGmwFJUrlBj4jWYy/VVUKfzh5DBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onuPDWkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CD8DC16AAE;
	Sat, 20 Dec 2025 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766244474;
	bh=DPZHoH7vOJ/r2CeJeriCWNUsS83oy/VS5P0MpcoRIXQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=onuPDWkImOyETCS/cs/8YjX53N9v4iTewrp1zpWoitZ3uu6T1qfhrGQa5dtvGsnJF
	 zS9NhM8IFj6cySgN+Z2710Psoym3sjMATSIs/V/GKTUpXilIY4UgEEed1yMhHRhDaB
	 mYhrwYtYrzKXpH/q39OuqP8t7ePlwn0sv4gJ+4cN+kEgy75ENvaX3ptRiAozKNCZxj
	 c39wEr2myeF8TSnr+avXBlb5Gbm5VndrvYbygrSg/bHxtjNavOgpwFK++CVWqAyIVK
	 JLfPSKUr8v4nSRnhVHbHuacr+R08nzzAAD+reQNnZTe478AAEnndUkcPUkSA97mtfp
	 ZcoVqG/7exoZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E6E668BB;
	Sat, 20 Dec 2025 15:27:53 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Subject: [PATCH v6 0/4] Microsoft Surface Pro 11 support
Date: Sat, 20 Dec 2025 16:26:28 +0100
Message-Id: <20251220-surface-sp11-for-next-v6-0-81f7451edb77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACTARmkC/43NSwrDIBSF4a0Ex7X4iBo66j5KB2quidA80FRSQ
 vZek1EolHb4H7jfXVCE4CGiS7GgAMlHP/Q55KlAttV9A9jXuREjTFBGKxyfwWkLOI6UYjcE3MM
 8YckkcKacMpyjfDsGcH7e3ds9d+vjNITX/ibxbf0lJo4JrpTQzipTc6OuTaf942yHDm1iKv9Sy
 qwoY13FLRWk1J+KOCiMfFNEVqgkUhhwFTh+VNZ1fQN9AHowRgEAAA==
X-Change-ID: 20251218-surface-sp11-for-next-626e327f7b33
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Dale Whinham <daleyo@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766244471; l=4231;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=DPZHoH7vOJ/r2CeJeriCWNUsS83oy/VS5P0MpcoRIXQ=;
 b=QKadjW+4PC8FotW4AvCCGOY4/QyN7Ug8REPTA1QxIbDM8a2bs4972VohIFWuqLsQROKZ+l/uv
 Cyl7ERHj3fdCsLltxURtkIhvNtUAObFU/92jjm1F6IXUPrRzHJFIdV8
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=DcPD9n3oDMsPkt+12tU96swmGb5H86cxt+yiEVcUEGk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20251217
 with auth_id=580
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
Reply-To: jerome.debretagne@gmail.com

This series brings support for the Qualcomm-based Microsoft Surface
Pro 11 covering both the OLED and LCD variants.

Signed-off-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
Changes in v6:
- Remove the disable-rfkill property and patches entirely from this patchset [Bryan, Krzysztof]
- Add the R-b: tag from Krzysztof for the denali compatibles
- Link to v5: https://lore.kernel.org/r/20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com

Changes in v5:
- Move the OLED variant description to keep the logical order [Krzysztof]
- Remove a T-b: tag as not applicable for a binding [Krzysztof]
- Remove another T-b: tag already covered by authorship [Krzysztof]
- Reference disable-rfkill in qcom,ath12k.yaml to fix dtbs_check failure [Krzysztof]
- Remove erroneously copied Copyright lines [Krzysztof]
- Add the R-b: tag from Dmitry for the aggregator_registry patch
- Link to v4: https://lore.kernel.org/r/20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com

Changes in v4:
- Re-order the denali entry in the aggregator_registry acpi_match table [Dmitry]
- Improve the bindings by splitting the LCD and OLED variants into 2 entries [Konrad]
- Enable i2c4 to make it accessible through i2c-tools [Konrad]
- Document the addresses for i2c0 and i2c4 like in romulus.dtsi [Konrad]
- Fix the clock-frequency for i2c0 based on DSDT/SSDT
- Drop i2c5 which is not found in the DSDT after double-checking
- Add the R-b: tag from Konrad for the SP11 device trees
- Link to v3: https://lore.kernel.org/r/20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com

Changes in v3:
- Update the compatible strings to document both the OLED and LCD variants
- Move the disable-rfkill property into ieee80211.yaml [Rob,Krzysztof]
- Reference commit c6a7c0b09d5f and detail the disable-rfkill patch description [Rob,Krzysztof]
- Switch to the renamed hamoa.dtsi and hamoa-pmics.dtsi [Dale]
- Improve the comments describing the 2 USB Type-C port location
- Update the speaker definition to describe only 2-speakers [Konrad]
- Drop output-low from the speaker definition [Konrad]
- Enable i2c0 to make it accessible through i2c-tools [Konrad]
- Delete a non-applicable comment about removable WLAN card [Konrad]
- Re-order a few nodes and fix indentation issues [Konrad]
- Squash one of the patches as suggested [Krzysztof]
- Drop the NAKed patch patch about a dpcd link rate quirk [Dmitry]
- Include the Reviewed-by: tags
- Link to v2: https://lore.kernel.org/all/20251201011457.17422-1-daleyo@gmail.com/

Changes in v2:
  - Dropped ATNA30DW01 patch as it was merged.
  - Split device tree into x1e (OLED)/x1p (LCD) specific *.dts files and move common code into x1-microsoft-denali.dtsi (patch 4).
  - Device tree now enables higher external monitor refresh rates/resolutions (patch 4).
  - Device tree now enables partially working audio output; requires alsa-ucm-conf and audioreach-topology definitions in userspace (patch 4).
  - Replaced 'Work around bogus maximum link rate' with a quirk-based approach (patch 5).
  - Improve the commit message about the disable-rfkill property in response to feedback (patch 6).

---
Dale Whinham (3):
      firmware: qcom: scm: allow QSEECOM on Surface Pro 11
      platform/surface: aggregator_registry: Add Surface Pro 11 (QCOM)
      arm64: dts: qcom: Add support for X1-based Surface Pro 11

Jérôme de Bretagne (1):
      dt-bindings: arm: qcom: Document Microsoft Surface Pro 11

 Documentation/devicetree/bindings/arm/qcom.yaml    |   11 +
 arch/arm64/boot/dts/qcom/Makefile                  |    4 +
 arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi  | 1322 ++++++++++++++++++++
 .../dts/qcom/x1e80100-microsoft-denali-oled.dts    |   19 +
 .../boot/dts/qcom/x1p64100-microsoft-denali.dts    |   15 +
 drivers/firmware/qcom/qcom_scm.c                   |    1 +
 .../platform/surface/surface_aggregator_registry.c |   18 +
 7 files changed, 1390 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251218-surface-sp11-for-next-626e327f7b33

Best regards,
-- 
Jérôme de Bretagne <jerome.debretagne@gmail.com>



