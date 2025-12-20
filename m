Return-Path: <linux-wireless+bounces-30028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79581CD31CC
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 16:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B250300D4BB
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706B2D837C;
	Sat, 20 Dec 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StWMbfbQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3CB29E0E7;
	Sat, 20 Dec 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244474; cv=none; b=Q4OyMqamaN+/1XaQA50v6PejsiRoB8XS2VTXaOPFO6kQ3ENLfY92ky2fXlHN7BBL9SF+lRpsGc4liwLgcVSwayQRn8m73FPXEh+++4we0vpKL9pG5iik19sb76LU6SYFdgeFZG7HcULVeNwle2GbiXnW4OM3xdIxe8PNTPTAMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244474; c=relaxed/simple;
	bh=T/d6LTvfqaL3MG852gJg4nPx0ZgexNqll6MZ+I8JFhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfQCijSvBDTr+khc56VKrXjlJjjhQtYWp9Kx2pYtuNYKc+fB0eTuKLEg7XTDDlxkfN9pmu6pG4QMivPRmU/iN74IA/lX2wCLw/eUGfCVE5oYIm4xSRDfqwnF6VCRTuyOcdibqlOJ3e/Gxuv+HuBpXX0d4dyrCcjLCK4+LjkPE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StWMbfbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D539C116D0;
	Sat, 20 Dec 2025 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766244473;
	bh=T/d6LTvfqaL3MG852gJg4nPx0ZgexNqll6MZ+I8JFhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=StWMbfbQqkDAtk+t5aAWY3MXwGOhcEKW8WUTkIl2UNxy+fLktR6TB5Ru7yXsxGOIh
	 Sg/26H2LrfQRMKzoslqYo1xVtuG2nqlh2m2wJTtTIF/DtD9P16qUM+yHFCinwhkSyz
	 pzAV52FEk0Iq7PqNtAYvFXBlpK0fu7sgbe487lkxQ/baxCsuLDdbCpYeWGkASb1j8z
	 vtH56NLNKXRotOit1XJqMXjaLnpmVds5CR90He14FxFZ0HpnAVe90zS4VMJQM2pisd
	 2rkLuq6rnMcj1rSCDJRBcb6Xwk80LNsqgM/TZAhzsOl4Pev4q2rsaNfjXEFi2V49GR
	 ZEBlhi99YZBDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F434E67480;
	Sat, 20 Dec 2025 15:27:53 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Sat, 20 Dec 2025 16:26:31 +0100
Subject: [PATCH v6 3/4] platform/surface: aggregator_registry: Add Surface
 Pro 11 (QCOM)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-surface-sp11-for-next-v6-3-81f7451edb77@gmail.com>
References: <20251220-surface-sp11-for-next-v6-0-81f7451edb77@gmail.com>
In-Reply-To: <20251220-surface-sp11-for-next-v6-0-81f7451edb77@gmail.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766244472; l=2027;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=T3FVcCFZemvYy2B2tfWs5X5U9WEV1cgBV3QQZBYuEGE=;
 b=yGgnk7WT0PhLT7Kz1WPWzhTkpz50FfTMIYW9V3oNbOHzBVBrf/zIa4Yq3PgeYUBZJ8pCL2cWi
 zxFRd+mElrWA+KP9reQ1fvPvM5BMSiNzU/JCufIoUrTExmS6g//6goY
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=DcPD9n3oDMsPkt+12tU96swmGb5H86cxt+yiEVcUEGk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20251217
 with auth_id=580
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
Reply-To: jerome.debretagne@gmail.com

From: Dale Whinham <daleyo@gmail.com>

This enables support for the Qualcomm-based Surface Pro 11.

Signed-off-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 78ac3a8fbb736384f7e50f1888a71297a892a7c3..0599d5adf02e61583cf3e1fc11000070f51f7be3 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -406,6 +406,22 @@ static const struct software_node *ssam_node_group_sp9_5g[] = {
 	NULL,
 };
 
+/* Devices for Surface Pro 11 (ARM/QCOM) */
+static const struct software_node *ssam_node_group_sp11[] = {
+	&ssam_node_root,
+	&ssam_node_hub_kip,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_sensors,
+	&ssam_node_hid_kip_keyboard,
+	&ssam_node_hid_kip_penstash,
+	&ssam_node_hid_kip_touchpad,
+	&ssam_node_hid_kip_fwupd,
+	&ssam_node_hid_sam_sensors,
+	&ssam_node_kip_tablet_switch,
+	NULL,
+};
+
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
 static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
@@ -482,6 +498,8 @@ MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_acpi_match);
 static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
 	/* Surface Pro 9 5G (ARM/QCOM) */
 	{ .compatible = "microsoft,arcata", (void *)ssam_node_group_sp9_5g },
+	/* Surface Pro 11 (ARM/QCOM) */
+	{ .compatible = "microsoft,denali", (void *)ssam_node_group_sp11 },
 	/* Surface Laptop 7 */
 	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
 	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },

-- 
2.47.3



