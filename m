Return-Path: <linux-wireless+bounces-30217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58152CEBA0E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42952300C8EA
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948163112C2;
	Wed, 31 Dec 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IDq1Saez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5CE2D660E
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172050; cv=none; b=gOJOVA7dxPDfOOcsytc512B65LUDlDI2S8jcXU4bBicU3A8B532tCAHrFYadLDrOjrOd47SGVjoTLNuW9ANSxKcoPF245u0HT5gsKgArXK41ej3as0LGhFVkCml0MHN/fteqKYeViACgJXdyglQM6G8+06Sbb1LObDPDmNyf1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172050; c=relaxed/simple;
	bh=38beMgswdQtiP2EClro92mJU6NL0UVpwtPhbTyg1I/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+chnzM2TFyM0/eUcF1MB6IEbmjFZNUdXnOf+yY0S1AYt0Dm+AhPcfu0y6ypSCe5cHANUuCF7RfErH1YMMecUzWt2i00eQek1p1vDOVNYYSk4k6v7YaFDhk/8f39OlNsWLltF/mDH+fvSSfedL4+a9c9zqbSTthfe8XrvXTbj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IDq1Saez; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97QXp8881229, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172046; bh=OyBhieGM9+YxgkJ2RDqzgoa8O6zW8YTQnRdELa2WVu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IDq1SaezNxgfuZsZ0v/zXKA2/k0Etuh64mngMD4Zg6SfGJpvFj66xoViafDIXIvms
	 V/iF5MVAUJL0s+CiT7GhZR6CFg+3cI1gLMIcpuiEZs1JBbm2cSv2NOql9IOeqLXjuZ
	 +5hwhti8iQphMP3GZJo1iG4kOwUpryMwTIqnpFR/nP9O2Y2CU4iMGm96S1qwfVhq14
	 2ez+IMFHHnhW3x3IqxUm0ps8NlsiEuKfNIRP2UGCZ1GKsRquQw6NWFAfhSEoW+67To
	 OA7adxr+vxzJix4G3xyAsEceo4559ez6mO0OKrs/iyJ5qW+WVjj6JcnwIiP5l3bryR
	 fQkiC8ccVPyOw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97QXp8881229
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:26 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:26 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/11] wifi: rtw89: fw: change FW feature map to a BITMAP
Date: Wed, 31 Dec 2025 17:06:40 +0800
Message-ID: <20251231090647.56407-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231090647.56407-1-pkshih@realtek.com>
References: <20251231090647.56407-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, FW feature map was declared as a u32. But, the number of FW
feature flags is going to be over than 32. So, change it to a BITMAP and
update the corresponding macros.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 52d6e5683d63..7b6dfab8e56c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4702,6 +4702,8 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_ADDR_CAM_V0,
 	RTW89_FW_FEATURE_SER_L1_BY_EVENT,
 	RTW89_FW_FEATURE_SIM_SER_L0L1_BY_HALT_H2C,
+
+	NUM_OF_RTW89_FW_FEATURES,
 };
 
 struct rtw89_fw_suit {
@@ -4793,20 +4795,25 @@ struct rtw89_fw_info {
 	struct rtw89_fw_suit bbmcu0;
 	struct rtw89_fw_suit bbmcu1;
 	struct rtw89_fw_log log;
-	u32 feature_map;
 	struct rtw89_fw_elm_info elm_info;
 	struct rtw89_fw_secure sec;
+
+	DECLARE_BITMAP(feature_map, NUM_OF_RTW89_FW_FEATURES);
 };
 
 #define RTW89_CHK_FW_FEATURE(_feat, _fw) \
-	(!!((_fw)->feature_map & BIT(RTW89_FW_FEATURE_ ## _feat)))
+	test_bit(RTW89_FW_FEATURE_ ## _feat, (_fw)->feature_map)
 
 #define RTW89_CHK_FW_FEATURE_GROUP(_grp, _fw) \
-	(!!((_fw)->feature_map & GENMASK(RTW89_FW_FEATURE_ ## _grp ## _MAX, \
-					 RTW89_FW_FEATURE_ ## _grp ## _MIN)))
+({ \
+	unsigned int bit = find_next_bit((_fw)->feature_map, \
+					 NUM_OF_RTW89_FW_FEATURES, \
+					 RTW89_FW_FEATURE_ ## _grp ## _MIN); \
+	bit <= RTW89_FW_FEATURE_ ## _grp ## _MAX; \
+})
 
 #define RTW89_SET_FW_FEATURE(_fw_feature, _fw) \
-	((_fw)->feature_map |= BIT(_fw_feature))
+	set_bit(_fw_feature, (_fw)->feature_map)
 
 struct rtw89_cam_info {
 	DECLARE_BITMAP(addr_cam_map, RTW89_MAX_ADDR_CAM_NUM);
-- 
2.25.1


