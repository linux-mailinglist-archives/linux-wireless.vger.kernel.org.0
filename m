Return-Path: <linux-wireless+bounces-30149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E64CE5C61
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE79530062C8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5EC230D35;
	Mon, 29 Dec 2025 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ki74bf0u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C731204C36
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977797; cv=none; b=fUReo2oXQB3hjEDnYWk5xL0HUr2p245OxzGGRzj/zKWnkgf3YHRgEAI79b8WlqaoM/tKziGaC9mJLfk/gBMRH2i9yA+Iu7SdZPfjoD926Xs6FTNpwV6eoWuWviI031viHKXH/64DjD6nH5+k0pcmmzN1rR5RJc5DdgedAhWfH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977797; c=relaxed/simple;
	bh=YX6imRrDDIXKqbFMBb/LZw5omGv3ClrfcCEbSSkUaVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCJ8ADA+J368Pb4k8TH3ADWehL0fHraWUTsnvwjnFwWpg9gqHrWeG2B7ESPWEkEPuvtNqXWLeiqdjBj0VDoXWyfLqDFpPzA9GJOp7oBagpTdprlMHAhBSwZUz5RO/MiTyyMHb5SHtioWPYymGRVfQuCsgZzUZFX00JW6Bhh+IpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ki74bf0u; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT39rcD6282535, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977793; bh=2F8WI16ZteNkRgTMONapTtNW5/dIOgqUtzs+LgUVSEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ki74bf0u/qvjkMaNJ/8B4GLc2s7NGWJHWpnUoOu/8ma4frH9G29r8dvuAogzGhxbM
	 xavt3xbEDKHyQ7XGWQsT4B3peuXFM1gUNga5HFDMB///Tj2A9ayU0mx/eoZadvx60s
	 K/fX5gxYT7STl51izh1Zv3PXn3P638oHKXb+5ZgeOJ5DCdfrTRC5Dn4xOBqii1IOeO
	 CdoYsI4tRTIey0BN3J7G2yUU+LyRUYQDQy0KEM7yyuovNVVCVmXTpVE+OJOT9VGEM9
	 KbILeGI+cDTodWC4/PBHArme4I8BiALFjij2HNWaMliWeUZs3QctxUwUK68b9IVHTP
	 MOQ2GIrzSoSrg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT39rcD6282535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:09:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:09:53 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:09:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:09:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 02/12] wifi: rtw89: wow: change type of WoWLAN pattern mask to __le32
Date: Mon, 29 Dec 2025 11:09:16 +0800
Message-ID: <20251229030926.27004-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229030926.27004-1-pkshih@realtek.com>
References: <20251229030926.27004-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The WoWLAN pattern mask is generated in byte stream, and actually firmware
expects to see the same byte stream too. Since these byte stream is sent
to firmware with 32-bit stream in little-endian order. Change to mask
to __le32, and just do assignment instead of le32 conversion to wkfm fields
of H2C command.

For little-endian machine, it doesn't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 2 +-
 drivers/net/wireless/realtek/rtw89/fw.c   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 64e7b241074b..6c4dbab999cd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5797,7 +5797,7 @@ struct rtw89_phy_efuse_gain {
 struct rtw89_wow_cam_info {
 	bool r_w;
 	u8 idx;
-	u32 mask[RTW89_MAX_PATTERN_MASK_SIZE];
+	__le32 mask[RTW89_MAX_PATTERN_MASK_SIZE];
 	u16 crc;
 	bool negative_pattern_match;
 	bool skip_mac_hdr;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index bb6f2802446e..c8ea4a9f24e0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8739,10 +8739,10 @@ int rtw89_fw_h2c_wow_cam_update(struct rtw89_dev *rtwdev,
 	if (!cam_info->valid)
 		goto fill_valid;
 
-	h2c->wkfm0 = le32_encode_bits(cam_info->mask[0], RTW89_H2C_WOW_CAM_UPD_WKFM0);
-	h2c->wkfm1 = le32_encode_bits(cam_info->mask[1], RTW89_H2C_WOW_CAM_UPD_WKFM1);
-	h2c->wkfm2 = le32_encode_bits(cam_info->mask[2], RTW89_H2C_WOW_CAM_UPD_WKFM2);
-	h2c->wkfm3 = le32_encode_bits(cam_info->mask[3], RTW89_H2C_WOW_CAM_UPD_WKFM3);
+	h2c->wkfm0 = cam_info->mask[0];
+	h2c->wkfm1 = cam_info->mask[1];
+	h2c->wkfm2 = cam_info->mask[2];
+	h2c->wkfm3 = cam_info->mask[3];
 	h2c->w5 = le32_encode_bits(cam_info->crc, RTW89_H2C_WOW_CAM_UPD_W5_CRC) |
 		  le32_encode_bits(cam_info->negative_pattern_match,
 				   RTW89_H2C_WOW_CAM_UPD_W5_NEGATIVE_PATTERN_MATCH) |
-- 
2.25.1


