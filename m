Return-Path: <linux-wireless+bounces-28490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF338C2AE7C
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 11:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F0664E24EC
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6A2F3C02;
	Mon,  3 Nov 2025 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpgeSmLe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4B14A60F;
	Mon,  3 Nov 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164198; cv=none; b=M4Kjv7ESpTdLgcYFd8DFGCnjZu3ykgDbrrRTxAsMJqj13jP0zffAbKQxYkf9nlAwGlOaPSZNpnHPBV/s4qAIsU78MQao3FBoLPn0YvrDD4TBTNzsuo4zoJT9GNE/k69j8g2wnDVzKaehWEMEue+HbNo8khzgjx4KYYcWuvFTPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164198; c=relaxed/simple;
	bh=UzkBsO1Y6JmHR8J5My8to9G4+ZIVEdHd2vQql21wdVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hy2QKiOJvqQYKjJJdDyMeJKfXIBenKfzlhLvFxsJ6v56UNofY+uIYNKQyh9C+TLlrlHFOM+beagvYOKOuq3zk0Lvn7GtTfasSgmoRApDZsTrriL+XrYpyPpzcY+LZIPTnIX3G9ABT+qR7eSwElbGjZEi2EHvHqp2G0Y7KXqTJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpgeSmLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55196C4CEE7;
	Mon,  3 Nov 2025 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762164197;
	bh=UzkBsO1Y6JmHR8J5My8to9G4+ZIVEdHd2vQql21wdVk=;
	h=From:To:Cc:Subject:Date:From;
	b=cpgeSmLeZHC+zNiAXJ8U0rOWzm61pxEuHfCI32kk2JeXeyEj7zYjfTjZ74onOjl8X
	 Ti2iDDvNtYt+60iepio3yw45FgtHh7QHDayZgFlaftZYEThn2fak9xSayhPbibYI8Q
	 SRArtPSpZT7ekrLucz6vKm/jqEnJWPNaWwJUhh1tYlpS4keYTYZ1y84RvKv0qLWZLb
	 shBZ34ihFlmGbC2XBWheSMrABJrZ5SjoLq8YpepERKvYQqORmmDsddEgDdVibgVtWf
	 HdGp+AOwLM8xE4HOoa6rhGi1UT9fKxPdU/zs9k8a0DbBGr1UCuwDsA0FR3Ak8PH1vi
	 H/jJVUhqS5HRA==
From: Hans de Goede <hansg@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH v2] wifi: brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet
Date: Mon,  3 Nov 2025 11:03:14 +0100
Message-ID: <20251103100314.353826-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.1
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

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v2:
- Add wifi: prefix to subject
- Add Arend's Acked-by
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
2.51.1


