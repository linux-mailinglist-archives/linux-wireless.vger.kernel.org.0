Return-Path: <linux-wireless+bounces-17954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90027A1CACF
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EECB188A917
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576620AF86;
	Sun, 26 Jan 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkzWP4Ag"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BB1A239A;
	Sun, 26 Jan 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903748; cv=none; b=l2rQCvVHfo1pp5F5GZQC3n53NfxbiJRHw60mGqDsZzHOKyhcUUOXChX8fzuP7kHLfuVp4aKj6c56J83SDlM8Ez7pz9oJBOfd4euKqocsNGVOx6ViuUim9qNm59c3eLhpePuh/3AXeFfOeoYTrDYAB6zfu9NrarXL7e279knneBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903748; c=relaxed/simple;
	bh=8I9/E0irgYbNfyyTOjPgkL3wjad0epD08VeuXFUTCNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWhJ8VnPASrbnCuS0iaAYQbv2OLYwhl2LT3sacBXo3dmKpQiZBxGmBZ46xGkQtF21PgllsUJyWvxhi0IZ5L8/XYf6vr1OgTVf8zMnxA1EgmXIARyD81bUqNjP0fyITNZK6vUvV3AgjhitHXo3wgBgx9Dd1fiW22LD+AqIq4+nZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkzWP4Ag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F299C4CED3;
	Sun, 26 Jan 2025 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903748;
	bh=8I9/E0irgYbNfyyTOjPgkL3wjad0epD08VeuXFUTCNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kkzWP4AgQCaiHIPkxm72v9ZfUMQEbkTy7ht9k1Tgt8U80eH2kq49lBR1fokxBGFaN
	 oXWuFDVYhLWOVKsLXelpMCNvsYq1jiqotl1CMEcUT0uh+93ubMjJSIzE7SNHu7Nad1
	 b+rHHK76IhMfMd/imu6OI7XFrqbNdRniXlbP0qV0AViUHX7zm0uWzPlatVVU6ngjhz
	 SY3U70DHh2afE24TKsdswfc91u7cKLJK1NKtpSEIQeHVMTIlS6yOO1E0y3UL0BgaVj
	 5Mk5xz4IGiRWxFwJzNH4794ykdlt64FLxXFUta38DGgEqtLlXP5+p1GrQCYcDnpCoo
	 mnjNxGqLLbaRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 09/29] wifi: rtw88: add __packed attribute to efuse layout struct
Date: Sun, 26 Jan 2025 10:01:50 -0500
Message-Id: <20250126150210.955385-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150210.955385-1-sashal@kernel.org>
References: <20250126150210.955385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 0daa521a1c8c29ffbefe6530f0d276e74e2749d0 ]

The layout struct of efuse should not do address alignment by compiler.
Otherwise it leads unexpected layout and size for certain arch suc as arm.
In x86-64, the results are identical before and after this patch.

Also adjust bit-field to prevent over adjacent byte to avoid warning:
  rtw88/rtw8822b.h:66:1: note: offset of packed bit-field `res2` has changed in GCC 4.4
   66 | } __packed;
      | ^

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412120131.qk0x6OhE-lkp@intel.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241212054203.135046-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.h     | 4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8723x.h | 8 ++++----
 drivers/net/wireless/realtek/rtw88/rtw8821c.h | 9 +++++----
 drivers/net/wireless/realtek/rtw88/rtw8822b.h | 9 +++++----
 drivers/net/wireless/realtek/rtw88/rtw8822c.h | 9 +++++----
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 945117afe1438..c808bb271e9d0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -508,12 +508,12 @@ struct rtw_5g_txpwr_idx {
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
index e93bfce994bf8..a99af527c92cf 100644
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
index 91ed921407bbe..10172f4d74bf2 100644
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
index cf85e63966a1c..e815bc97c218a 100644
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
index e2b383d633cd2..fc62b67a15f21 100644
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
2.39.5


