Return-Path: <linux-wireless+bounces-29854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 989BCCC9D44
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 00:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6468300D558
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 23:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE682FFDDC;
	Wed, 17 Dec 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uESTHdcw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BA26E173;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015817; cv=none; b=BW03i7B7RDceGa1P9y7PbCCbxTq66vu3CyCQjoOJx94g+RZThP2wGOCMrTI+JO6rOj2CB9jchwSR7kVsAVrDDTO4QwSmcpwM4bY7HigpKjnEhSkd20wDNdh5h7n0E41G6WJatCCmaj9KvyyLY91yZZm8nb3NM8PhxwCxxH5J8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015817; c=relaxed/simple;
	bh=HR4qrmI9rceCWt7faPX8zYQtAYw4yuTbacR2hZ8jKj8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nns9oYqa/nDjvrvAi7QqHJLDMXIZvE5w/e4evMAQZtdVdtPAz3/skdr4U3/hCnQocMccrXD5rU9NNPKPZHlknKvJ2/ucwDDvSp59I2VsqpY+0/YwCypIXvz7JKW4TQnzjE3BpGtQOO1yeJqsksdSem6fFqJASeYjiW7K5n/JdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uESTHdcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 627DEC4CEF5;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766015817;
	bh=HR4qrmI9rceCWt7faPX8zYQtAYw4yuTbacR2hZ8jKj8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uESTHdcwFrTGhtuhgh2hLadO1b7dyJ3t5WtA2vwIW3da4rDQFVPqB3LMD0v/7XwrK
	 bPXPKH+430cMfrdkbzdVwXNWohgfNi1vSIGpSooy2BsxB5L3q8s8wBgKWlQka2i2wC
	 L6PIfizKciS19/QTZkDOZwSXNL8ve/thr20NrXQBgVG7cn4OGEbdCWuG1sqpwqFW5f
	 ljfwYXfLoYZVU4s8kVcWENINkdaAq9oyDMsk5L/6992+OdcKKOWwWsY5D3YfHfk59K
	 UcXzOsC0K5wAOCYsLOjKT0+ZKK0y3K57YjLbP3Z0zafhJhdWSir9QQTvARRpUnijZy
	 X8/eZfoqCAJSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505F8D65C7F;
	Wed, 17 Dec 2025 23:56:57 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Subject: [PATCH v3 0/6] Microsoft Surface Pro 11 support
Date: Thu, 18 Dec 2025 00:56:36 +0100
Message-Id: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADRDQ2kC/x3MOQqAQAxA0atIagNOBhe8ili4ZDTNKImKIN7dw
 fIV/z9grMIGbfaA8iUmW0zweQbTOsSFUeZkoIJKR65BOzUME6PtzmHYFCPfB1ZUsac61KP3kNp
 dOcj9f7v+fT8DnBloZwAAAA==
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
 Dale Whinham <daleyo@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766015815; l=3060;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=HR4qrmI9rceCWt7faPX8zYQtAYw4yuTbacR2hZ8jKj8=;
 b=t3BXpsJPHxSIlZjyA76+9GhmhP27qDDVarnKi/muuVipdCyPhGDLIzBzk4DJgGDFXkbCTKtLn
 vi5tRO1d+2BAlPqAqU/Gr8ilzjdiSp01/l7J36E32dkICd8KlD/Ss11
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
Dale Whinham (4):
      firmware: qcom: scm: allow QSEECOM on Surface Pro 11
      platform/surface: aggregator_registry: Add Surface Pro 11
      arm64: dts: qcom: Add support for Surface Pro 11
      wifi: ath12k: Add support for disabling rfkill via devicetree

Jérôme de Bretagne (2):
      dt-bindings: arm: qcom: Document Microsoft Surface Pro 11
      dt-bindings: wireless: ieee80211: Add disable-rfkill property

 Documentation/devicetree/bindings/arm/qcom.yaml    |    8 +
 .../bindings/net/wireless/ieee80211.yaml           |    6 +
 arch/arm64/boot/dts/qcom/Makefile                  |    4 +
 arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi  | 1326 ++++++++++++++++++++
 .../dts/qcom/x1e80100-microsoft-denali-oled.dts    |   20 +
 .../boot/dts/qcom/x1p64100-microsoft-denali.dts    |   16 +
 drivers/firmware/qcom/qcom_scm.c                   |    1 +
 drivers/net/wireless/ath/ath12k/core.c             |    3 +
 .../platform/surface/surface_aggregator_registry.c |   18 +
 9 files changed, 1402 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251218-surface-sp11-for-next-626e327f7b33

Best regards,
-- 
Jérôme de Bretagne <jerome.debretagne@gmail.com>



