Return-Path: <linux-wireless+bounces-5551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0943891946
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 13:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BD21C249A4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EDC145B3C;
	Fri, 29 Mar 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrvnGDH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF3145FEF;
	Fri, 29 Mar 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715295; cv=none; b=Bs3ozsSpCN5OhfL30I7fHFMK5bmnLeBwc++mChsVYm5e9at6S4hS+Xcxf2Bd+O1Ijs/H3IlgfWGwWBcy+HDhGbr1NjCETylThIf1zhYf3dVu9vhsc5/SZG8YaF9MgqSVnXwyk5gdFulg5kOel2omd2Naz4wRdFbYl3kI5iBMm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715295; c=relaxed/simple;
	bh=9KaPcBd2w3GO4IWPKE/D0ZVEMbN7tvs/SHcXt8jm7UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtqN+Occ006IY3CgkjHVRY5KocR1xwshheZOGNMQ9mumrtF7d7wtj01KgSWAv3/ezMT8xCPGoheMoEpxi7RSb4cY4n/v3b7tIzrkwopUOXUoG/8dP7m5DJX5EC85cZyJl71TLO3uE3URVErVFFC7J2uGGQmFNUpo8tdVrnJprLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrvnGDH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47C8C433F1;
	Fri, 29 Mar 2024 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715294;
	bh=9KaPcBd2w3GO4IWPKE/D0ZVEMbN7tvs/SHcXt8jm7UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrvnGDH/eUS3ZhGujIgt1y8i9wM4mbxHoSfFJFILp6W/LqB2g9gz60bdrYzH9LUIF
	 iHZXExgTh6usIokMOy2YrxTrbPXZf+/y1FL3YdPyJHSqdrM218rNCG3t0si7V6nVSm
	 7ZlWoe5Uz9jD3EmwCgcqvIEpmajrcORcVMAb00foCnIoB3CKZPiPPDZE1HlKumh4md
	 xOXqBFWRKoqSTbBC6eSwK1YViWxiZW7s4Z5fBxuXY4B4dH6rEL6r2eVAqU62fyB6Xt
	 yrZiWVyfMfYEL9mHCswGBDaY+J9af9LcC9IV5Dz12VFC839R4XScaK+pjAd3Z1vcCP
	 5o8+AgFYpA0Dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH AUTOSEL 6.8 41/68] wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro
Date: Fri, 29 Mar 2024 08:25:37 -0400
Message-ID: <20240329122652.3082296-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 32167707aa5e7ae4b160c18be79d85a7b4fdfcfb ]

The ACEPC W5 Pro HDMI stick contains quite generic names in the sys_vendor
and product_name DMI strings, without this patch brcmfmac will try to load:
"brcmfmac43455-sdio.$(DEFAULT_STRING)-$(DEFAULT_STRING).txt" as nvram file
which is both too generic and messy with the $ symbols in the name.

The ACEPC W5 Pro uses the same Ampak AP6255 module as the ACEPC T8
and the nvram for the T8 is already in linux-firmware, so point the new
DMI nvram filename quirk to the T8 nvram file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240216213649.251718-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 86ff174936a9a..c3a602197662b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -82,6 +82,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&acepc_t8_data,
 	},
+	{
+		/* ACEPC W5 Pro Cherry Trail Z8350 HDMI stick, same wifi as the T8 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+		},
+		.driver_data = (void *)&acepc_t8_data,
+	},
 	{
 		/* Chuwi Hi8 Pro with D2D3_Hi8Pro.233 BIOS */
 		.matches = {
-- 
2.43.0


