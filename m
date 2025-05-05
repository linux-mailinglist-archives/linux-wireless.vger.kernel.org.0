Return-Path: <linux-wireless+bounces-22557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A1AAAE00
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9C01BC1416
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8109D2D1653;
	Mon,  5 May 2025 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhUmf0m3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58929A3E7;
	Mon,  5 May 2025 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485036; cv=none; b=epUVEOzupa35Vec74wp1N5uNgsbfcRycG4rXR1zjhNr4QoahUwGDWf/2eGpTqQAQQDXNmWtcgLBowvT5tribOGarn2Gb2/yHS29LPStguQXPtA/b+7Y7QF6RhZwsyUSgmOm/NxhDd5vLZIXKV9Qv2P3gTNxAIAXHOHatYRem26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485036; c=relaxed/simple;
	bh=GsP06vD4FZjWpPqVY18NFfEH22WzUTrRhGkODqRlXqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgSb/Mp3P/717aI5j+KQkOvP/+M0DqyQJcQTQ8iXc8kNPHJm14D46SeR34JFqYXkJ5tRWdeXTKfXyIbPu1KNbbHmLhCIEKrZB30X8nNI/eqEJJTAJ3NMekl9vfWOa5XW/KBEX5/Q08MYurTadDN1FkI5RkdodZWD+5yaN42uFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhUmf0m3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0453C4CEE4;
	Mon,  5 May 2025 22:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485036;
	bh=GsP06vD4FZjWpPqVY18NFfEH22WzUTrRhGkODqRlXqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhUmf0m3XhXxNDx2J4cvZOSIne6URzlpb1TjesM1a7dlnnNZDdFRn02mgiD9+fNSB
	 XvbItWbOk1Ma6/J+Kc1scpkCn/uses9POCKQo9Ef4IGAR9nSlov+YKbRQ8SGOtQ8yO
	 etJEOYa4BqdfY6QrHdV/4SvIjZ2+ej/0/X3IBAY33ox9udB1S0OMkk4AcEp/HTpxBr
	 IWDHsoz8X2jagEMKdED43R7U4RFs7yAv6yaK1DTvApalkmp7rNGLD/9UGW8ph9CecI
	 50EiYdPSUS9PZNMNoW8n6V1znVGuE0cG6qr5Fu3dZS05wEdXLbYKWxkk8vYYl0MQh3
	 oO6PwKNLrQscA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dian-Syuan Yang <dian_syuan0116@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 134/486] wifi: rtw89: set force HE TB mode when connecting to 11ax AP
Date: Mon,  5 May 2025 18:33:30 -0400
Message-Id: <20250505223922.2682012-134-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 4574aa62839b0..04e254bd6b17f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4745,6 +4745,32 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
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
index 0c269961a5731..5ba1133b79d64 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1160,6 +1160,8 @@ void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
 				struct rtw89_vif_link *rtwvif_link, bool en);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct rtw89_vif_link *rtwvif_link);
+void rtw89_mac_set_he_tb(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 8351a70d325d4..3a1a2b243adf0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -669,6 +669,7 @@ static void __rtw89_ops_bss_link_assoc(struct rtw89_dev *rtwdev,
 	rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, rtwvif_link);
 	rtw89_mac_port_update(rtwdev, rtwvif_link);
 	rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, rtwvif_link);
+	rtw89_mac_set_he_tb(rtwdev, rtwvif_link);
 }
 
 static void __rtw89_ops_bss_assoc(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 69678eab23093..9fbcc7fee290f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7093,6 +7093,10 @@
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


