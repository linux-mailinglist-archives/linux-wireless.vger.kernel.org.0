Return-Path: <linux-wireless+bounces-28112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B0EBF274C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 18:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033BF4E5C87
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 16:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58728D8FD;
	Mon, 20 Oct 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdJMPSEC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C3288CA3;
	Mon, 20 Oct 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978064; cv=none; b=o1H3S1pn6OMGt04eMxYxR4+iJeAiZrHo8Q8mrcwVZPu9DJu4RXF9QABxR8joI81HPblGgCNvgwe+9TCU4CyY7RqjO7Th5aUWHsuSro1ZKfdkj3H36pD+JaIKzd2kVgkraM2Q/JIABapfKaOGtupkbgNpSnPOVACMXq+/ZoJUE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978064; c=relaxed/simple;
	bh=VhIh4Q9nE2926f1t1WUZQdFcbnf/3iNjycL1TzsS5lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJ2ccaOBkVSSS/KRaJiEDSfwR93+z/C/1DHEr5SIG3X68PWk2zXDOTy1WyVkwLmwU6KHFwy7dAiW23+Ldg754zbzFWO5CsKLPqCLyPszdfVqLyyQL7QYEkCGXPYktB3UH0dWyekevXsP6g/ij2qf5Ynt4HhQNu9Jdy+by0pd7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdJMPSEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13339C113D0;
	Mon, 20 Oct 2025 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760978064;
	bh=VhIh4Q9nE2926f1t1WUZQdFcbnf/3iNjycL1TzsS5lU=;
	h=From:To:Cc:Subject:Date:From;
	b=EdJMPSECrrY5w9VnOtAQvwk9sYczmTkPJVU0xgxm3AptxFB5OL/27qcCECMDOV9+2
	 iFHxNNiSFpz4S5McDHCkoGG5DmHmrGkZHw5t0OIn8k9B/l9u1fc+QpjCicufwHzFz7
	 evmzg5CNf+zPxbKkZVCzWBKUTTybIqVEaETU7bSkwrsV+YAaL7Sbz2X1KUK2buHqO7
	 1ODpxPSBIgiqYXpYgORpsK2N6/5GbvQgyhOgRqPHgzmfiGePMr460wDSTHNvicFJLh
	 6GhUNctI1weCIkyoMrKq8e1A7D/I0KhmfNQKe7U5Q1nzXLz5CBV3irg8BN1Avf4rP7
	 whf8WgMdYScgw==
From: Hans de Goede <hansg@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH] brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet
Date: Mon, 20 Oct 2025 18:34:21 +0200
Message-ID: <20251020163421.68717-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Acer A1 840 tablet contains quite generic names in the sys_vendor and
product_name DMI strings, without this patch brcmfmac will try to load:
brcmfmac43340-sdio.Insyde-BayTrail.txt as nvram file which is a bit
too generic.

Add a DMI quirk so that a unique and clearly identifiable nvram file name
is used on the Acer A1 840 tablet.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index c3a602197662..abe7f6501e5e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -24,6 +24,10 @@ static const struct brcmf_dmi_data acepc_t8_data = {
 	BRCM_CC_4345_CHIP_ID, 6, "acepc-t8"
 };
 
+static const struct brcmf_dmi_data acer_a1_840_data = {
+	BRCM_CC_43340_CHIP_ID, 2, "acer-a1-840"
+};
+
 /* The Chuwi Hi8 Pro uses the same Ampak AP6212 module as the Chuwi Vi8 Plus
  * and the nvram for the Vi8 Plus is already in linux-firmware, so use that.
  */
@@ -91,6 +95,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&acepc_t8_data,
 	},
+	{
+		/* Acer Iconia One 8 A1-840 (non FHD version) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
+			/* Above strings are too generic also match BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "04/01/2014"),
+		},
+		.driver_data = (void *)&acer_a1_840_data,
+	},
 	{
 		/* Chuwi Hi8 Pro with D2D3_Hi8Pro.233 BIOS */
 		.matches = {
-- 
2.51.0


