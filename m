Return-Path: <linux-wireless+bounces-22493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E370AAA23F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03893A56F0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C78B2D818F;
	Mon,  5 May 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTqYKxTG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9652D8186;
	Mon,  5 May 2025 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483666; cv=none; b=CKNrO3hSM3UCrVFDTD3aDfiDw8Ze0o4XT/qN5P3fLErMlLT83hsFSVlplkyRYB08sMDDJ+6zgtuOeYIZ5QTYEIoavyTP8LR0LIsycMPO6erdenGIRcAjANS8gFQXNAqY3nlXa2KVV9EavtR4lzmZqems8eq5gYLpELQvhT5DA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483666; c=relaxed/simple;
	bh=/HxQlX9rFz5sUK4mnyBOiOth6mV0uUW/Kd8/8kA/8AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbHp8fWg5lAPfedz9kC3IS0G7RO85vmMHcOTRXSHIYXPZqm/C1FA1krx5K3F2AMc1KOfXMLqGxWDVqd/9/kKG3WBR1aFT21YJYEuYDTp4t1FS+mm31CJvhwPNFKCrlWlkDWcV7+6oMebvsVlRWgN+Ci5wG4hjtJ9N+2w8g4zR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTqYKxTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F003DC4CEED;
	Mon,  5 May 2025 22:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483665;
	bh=/HxQlX9rFz5sUK4mnyBOiOth6mV0uUW/Kd8/8kA/8AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTqYKxTG4AjspALmk8CSOlR85LMXFLZwAGh8OqaqcxH6KS8nzgvUgUfEypjGXH2P5
	 5HBOGOS2E3GPIWX2YVz4Zou+l2IwrA8UCIBARbCj0hZROACiPFw8cqN8c69rd/UKwV
	 AkfhwwIlsP0LAAO7sBO9DwOGqy/STe0hbI/tkLqdfKhb+9QPIWOhLwv23Z1SqKKQkq
	 wh5apcOGKOxQZq1PeWzfAWUKm9NZDZPs7glsSeFFSDYoDR4UAgG+NSctJmYIPsUz40
	 8TalKA72KYYwov8gnqSAG00wudGxl1dHUoE80tLeHjPvFsjz45ChiPbp7PgRfC2X0A
	 Bt0PmOKVuxMLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dian-Syuan Yang <dian_syuan0116@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 168/642] wifi: rtw89: set force HE TB mode when connecting to 11ax AP
Date: Mon,  5 May 2025 18:06:24 -0400
Message-Id: <20250505221419.2672473-168-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

[ Upstream commit a9b56f219a0fa550f92e65ac58443a7892380e09 ]

Some of 11ax AP set the UL HE-SIG-A2 reserved subfield to all 0s, which
will cause the 11be chip to recognize trigger frame as EHT. We propose
a method to bypass the "UL HE-SIG-A2 reserved subfield" and always uses
HE TB in response to the AP's trigger frame.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250306021144.12854-6-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 26 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  2 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 +++
 4 files changed, 33 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a37c6d525d6f0..2c74d7781bd40 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4826,6 +4826,32 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 		rtw89_write32_set(rtwdev, reg, mac->narrow_bw_ru_dis.mask);
 }
 
+void rtw89_mac_set_he_tb(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link)
+{
+	struct ieee80211_bss_conf *bss_conf;
+	bool set;
+	u32 reg;
+
+	if (rtwdev->chip->chip_gen != RTW89_CHIP_BE)
+		return;
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	set = bss_conf->he_support && !bss_conf->eht_support;
+
+	rcu_read_unlock();
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CLIENT_OM_CTRL,
+				   rtwvif_link->mac_idx);
+
+	if (set)
+		rtw89_write32_set(rtwdev, reg, B_BE_TRIG_DIS_EHTTB);
+	else
+		rtw89_write32_clr(rtwdev, reg, B_BE_TRIG_DIS_EHTTB);
+}
+
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
 	rtw89_mac_port_cfg_func_sw(rtwdev, rtwvif_link);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8edea96d037f6..373366a602e0b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1185,6 +1185,8 @@ void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
 				struct rtw89_vif_link *rtwvif_link, bool en);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct rtw89_vif_link *rtwvif_link);
+void rtw89_mac_set_he_tb(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index b3669e0074df9..7c9b53a9ba3b7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -670,6 +670,7 @@ static void __rtw89_ops_bss_link_assoc(struct rtw89_dev *rtwdev,
 	rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, rtwvif_link);
 	rtw89_mac_port_update(rtwdev, rtwvif_link);
 	rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, rtwvif_link);
+	rtw89_mac_set_he_tb(rtwdev, rtwvif_link);
 }
 
 static void __rtw89_ops_bss_assoc(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 10d0efa7a58ef..850ae5bf50ef3 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7095,6 +7095,10 @@
 #define B_BE_MACLBK_RDY_NUM_MASK GENMASK(7, 3)
 #define B_BE_MACLBK_EN BIT(0)
 
+#define R_BE_CLIENT_OM_CTRL 0x11040
+#define R_BE_CLIENT_OM_CTRL_C1 0x15040
+#define B_BE_TRIG_DIS_EHTTB BIT(24)
+
 #define R_BE_WMAC_NAV_CTL 0x11080
 #define R_BE_WMAC_NAV_CTL_C1 0x15080
 #define B_BE_WMAC_NAV_UPPER_EN BIT(26)
-- 
2.39.5


