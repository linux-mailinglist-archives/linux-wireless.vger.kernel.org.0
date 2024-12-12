Return-Path: <linux-wireless+bounces-16289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3139EDF02
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 06:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E17282A61
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 05:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1E31632F2;
	Thu, 12 Dec 2024 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="e1ZzP5Q+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278A748A
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733982145; cv=none; b=Kc/lyUU5VrobAEMgAM0IZqw23R71cxuwj9Hdmu2+yeZlQ9Ss+D0/wC8/xnPH3gNJPfWrK3w7YOpmlnkFd+r6+rATClG4cDhaVIPbwhAhlK8IaeP+lX8LbrwtsvKN67Bkzqv8OWrGmRJyy8apQgCUr0k8OHyYzkAlRYPboW8w0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733982145; c=relaxed/simple;
	bh=/7wL5CjnfAHfOVyZCfkWbZI61ZQAX1Af+77On/UUlnE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s7wQnnIfDEc8KOQyG0gXP43BhBt6U7b1EcLOhzvm76Evg+uhUJhM3i0KUvTexKBwymCfc9VWQNJ+2C91mfTg1HgOIEqeLhADF47oZu/6AAOFXzu5lc50RyW3847gaudU9pNcaMuHtMSbLj7X3g7QlvrljLiZUgjr61B7QvsrL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=e1ZzP5Q+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BC5gJWD1683257, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733982139; bh=/7wL5CjnfAHfOVyZCfkWbZI61ZQAX1Af+77On/UUlnE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=e1ZzP5Q+P4zECcxJyOeP3FIkf22/gS7paF/27yNZi5pu4the1sVd8OFLwaQNZe9Gf
	 CE9w99C5Maa2dsT7ln++Ob4iI/AVsqlpe8k4bOQjIn1yKi6xZd2lwWwihswBLX/101
	 vagTFGOmGpG8/s0sv+ahODlO1TcE7JKDhkY9Gy86IbQ/1Gh33YgRYedFmtKdBpUAJ7
	 JnhhpCn/orspsoorCM6EvDrrbdZtymKUxCbrgRTDjJ0yZXtQGt3UngMbcS7i+TvwfK
	 DDNHB34ovriHNN74iDVwI73m7d1/FAd4vV22+UHHEQheJwFhqCPb0C1ahjSjjS/5U5
	 ZnC+q2ba5OViA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BC5gJWD1683257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 13:42:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 13:42:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 12 Dec
 2024 13:42:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw88: add __packed attribute to efuse layout struct
Date: Thu, 12 Dec 2024 13:42:03 +0800
Message-ID: <20241212054203.135046-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Compiler should not do address alignment on layout struct of efuse.
Otherwise it leads unexpected layout and size for certain arch suc as arm.
In x86-64, the results are identical before and after this patch.

Also adjust bit-field to prevent over adjacent byte to avoid warning:
  rtw88/rtw8822b.h:66:1: note: offset of packed bit-field `res2` has changed in GCC 4.4
   66 | } __packed;
      | ^

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412120131.qk0x6OhE-lkp@intel.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     | 4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8723x.h | 8 ++++----
 drivers/net/wireless/realtek/rtw88/rtw8821c.h | 9 +++++----
 drivers/net/wireless/realtek/rtw88/rtw8822b.h | 9 +++++----
 drivers/net/wireless/realtek/rtw88/rtw8822c.h | 9 +++++----
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index cd09fb6f7b8b..65c7acea41af 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -510,12 +510,12 @@ struct rtw_5g_txpwr_idx {
 	struct rtw_5g_vht_ns_pwr_idx_diff vht_2s_diff;
 	struct rtw_5g_vht_ns_pwr_idx_diff vht_3s_diff;
 	struct rtw_5g_vht_ns_pwr_idx_diff vht_4s_diff;
-};
+} __packed;
 
 struct rtw_txpwr_idx {
 	struct rtw_2g_txpwr_idx pwr_idx_2g;
 	struct rtw_5g_txpwr_idx pwr_idx_5g;
-};
+} __packed;
 
 struct rtw_channel_params {
 	u8 center_chan;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.h b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
index e93bfce994bf..a99af527c92c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
@@ -47,7 +47,7 @@ struct rtw8723xe_efuse {
 	u8 device_id[2];
 	u8 sub_vendor_id[2];
 	u8 sub_device_id[2];
-};
+} __packed;
 
 struct rtw8723xu_efuse {
 	u8 res4[48];                    /* 0xd0 */
@@ -56,12 +56,12 @@ struct rtw8723xu_efuse {
 	u8 usb_option;                  /* 0x104 */
 	u8 res5[2];			/* 0x105 */
 	u8 mac_addr[ETH_ALEN];          /* 0x107 */
-};
+} __packed;
 
 struct rtw8723xs_efuse {
 	u8 res4[0x4a];			/* 0xd0 */
 	u8 mac_addr[ETH_ALEN];		/* 0x11a */
-};
+} __packed;
 
 struct rtw8723x_efuse {
 	__le16 rtl_id;
@@ -96,7 +96,7 @@ struct rtw8723x_efuse {
 		struct rtw8723xu_efuse u;
 		struct rtw8723xs_efuse s;
 	};
-};
+} __packed;
 
 #define RTW8723X_IQK_ADDA_REG_NUM	16
 #define RTW8723X_IQK_MAC8_REG_NUM	3
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 7a33ebd612ed..954e93c8020d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -27,7 +27,7 @@ struct rtw8821cu_efuse {
 	u8 res11[0xcf];
 	u8 package_type;		/* 0x1fb */
 	u8 res12[0x4];
-};
+} __packed;
 
 struct rtw8821ce_efuse {
 	u8 mac_addr[ETH_ALEN];		/* 0xd0 */
@@ -47,7 +47,8 @@ struct rtw8821ce_efuse {
 	u8 ltr_en:1;
 	u8 res1:2;
 	u8 obff:2;
-	u8 res2:3;
+	u8 res2_1:1;
+	u8 res2_2:2;
 	u8 obff_cap:2;
 	u8 res3:4;
 	u8 res4[3];
@@ -63,7 +64,7 @@ struct rtw8821ce_efuse {
 	u8 res6:1;
 	u8 port_t_power_on_value:5;
 	u8 res7;
-};
+} __packed;
 
 struct rtw8821cs_efuse {
 	u8 res4[0x4a];			/* 0xd0 */
@@ -101,7 +102,7 @@ struct rtw8821c_efuse {
 		struct rtw8821cu_efuse u;
 		struct rtw8821cs_efuse s;
 	};
-};
+} __packed;
 
 static inline void
 _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.h b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
index 0514958fb57c..9fca9ba67c90 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
@@ -27,7 +27,7 @@ struct rtw8822bu_efuse {
 	u8 res11[0xcf];
 	u8 package_type;		/* 0x1fb */
 	u8 res12[0x4];
-};
+} __packed;
 
 struct rtw8822be_efuse {
 	u8 mac_addr[ETH_ALEN];		/* 0xd0 */
@@ -47,7 +47,8 @@ struct rtw8822be_efuse {
 	u8 ltr_en:1;
 	u8 res1:2;
 	u8 obff:2;
-	u8 res2:3;
+	u8 res2_1:1;
+	u8 res2_2:2;
 	u8 obff_cap:2;
 	u8 res3:4;
 	u8 res4[3];
@@ -63,7 +64,7 @@ struct rtw8822be_efuse {
 	u8 res6:1;
 	u8 port_t_power_on_value:5;
 	u8 res7;
-};
+} __packed;
 
 struct rtw8822bs_efuse {
 	u8 res4[0x4a];			/* 0xd0 */
@@ -103,7 +104,7 @@ struct rtw8822b_efuse {
 		struct rtw8822bu_efuse u;
 		struct rtw8822bs_efuse s;
 	};
-};
+} __packed;
 
 static inline void
 _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index e2b383d633cd..fc62b67a15f2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -14,7 +14,7 @@ struct rtw8822cu_efuse {
 	u8 res1[3];
 	u8 mac_addr[ETH_ALEN];		/* 0x157 */
 	u8 res2[0x3d];
-};
+} __packed;
 
 struct rtw8822cs_efuse {
 	u8 res0[0x4a];			/* 0x120 */
@@ -39,7 +39,8 @@ struct rtw8822ce_efuse {
 	u8 ltr_en:1;
 	u8 res1:2;
 	u8 obff:2;
-	u8 res2:3;
+	u8 res2_1:1;
+	u8 res2_2:2;
 	u8 obff_cap:2;
 	u8 res3:4;
 	u8 class_code[3];
@@ -55,7 +56,7 @@ struct rtw8822ce_efuse {
 	u8 res6:1;
 	u8 port_t_power_on_value:5;
 	u8 res7;
-};
+} __packed;
 
 struct rtw8822c_efuse {
 	__le16 rtl_id;
@@ -102,7 +103,7 @@ struct rtw8822c_efuse {
 		struct rtw8822cu_efuse u;
 		struct rtw8822cs_efuse s;
 	};
-};
+} __packed;
 
 enum rtw8822c_dpk_agc_phase {
 	RTW_DPK_GAIN_CHECK,
-- 
2.25.1


