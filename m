Return-Path: <linux-wireless+bounces-29913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F20CCDCAE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 23:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E19A5304809F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE230C61F;
	Thu, 18 Dec 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHkAvMRn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A002F6560;
	Thu, 18 Dec 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096534; cv=none; b=tJmKaJy9JfvUBfgoOxDJxDuco2AuCsAp7dzjru73EOwX3pbP9xtj+hAnCzslvIY99n8/lwqbMxvlFwjowryCCXx6otSGDs86dCTeN2e4mH5TzpON3qoUh1xomgHU2ULFUKc1gSkCJHJ9doJhMvKUxo/kbNnfPxcHQa6YmKwB/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096534; c=relaxed/simple;
	bh=ecT55mQ5jQmLe4fJOJS5l3F4aXRDMocOV0oybZ4c0f4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYOti/FNQomcUTTW5CfmhSrBOyFPXlK5QZPYglthSo3YCxRpgghIIAc5wYC/acLIM1s+64Zu0c0sTvaY6cE2paRQoAijt3yBTyS2qcjq6WBEgDvqXiWRossviVRhNwGwpArcKVo2I7OOEISXlSGrM/azRIy+Ycn2YM72xiJlNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHkAvMRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3FB1C19424;
	Thu, 18 Dec 2025 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766096533;
	bh=ecT55mQ5jQmLe4fJOJS5l3F4aXRDMocOV0oybZ4c0f4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vHkAvMRnQEcFvHLz+s/EFtzHw7xknpnY6wxYZdL+VRDfmSAIdjK8pCwdBi8KPE4Nj
	 9G8q8+vv9SE2YZH6uGpwDN3tc/ijj9nhLjnK914KhtSFmtSRAWC0WL+mNmMkDhWFno
	 BKGp0TKZueSrYFCgOrBRhguyVAeSQEKVwd3TLrQkHYLZ1WQRJsSImldZIJ0I4GYGX6
	 pTxIO2UFW/MVgO9JAvd84ACwCEQY9PYxFNcZ2euetqELNqwALCgDp5Y5mOZl2f3N5C
	 PfHIDZ3gaGaF7fiLsKNCbuf2zaXWO7d5uSMZhFSud6ugFh7VlIKFu4w3XXKkTlIrFE
	 Z00ygPjqeQC2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D5D711CC;
	Thu, 18 Dec 2025 22:22:13 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?= <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Thu, 18 Dec 2025 23:22:10 +0100
Subject: [PATCH v4 4/6] platform/surface: aggregator_registry: Add Surface
 Pro 11 (QCOM)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-surface-sp11-for-next-v4-4-7bcf83c1504a@gmail.com>
References: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
In-Reply-To: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
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
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766096532; l=1960;
 i=jerome.debretagne@gmail.com; s=20251217; h=from:subject:message-id;
 bh=FteUVMAtphVq5N5dkiQ2DoFR0a2YpxFiVZJ5hRoKyAA=;
 b=oIkktteIQegddQqC+po2fGnJ5mS9LHU3QtetinS9rUK5SIBxwWC96p69L0TcV2FhqNvRyAF84
 9yL2elYAD4oCqFoAG84AyGYVFVuwSFkCbmdFfehmvGLV7guITNju975
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



