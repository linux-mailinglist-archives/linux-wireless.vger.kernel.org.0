Return-Path: <linux-wireless+bounces-19834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D1A54061
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 03:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACAD18917E5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 02:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E50BE46;
	Thu,  6 Mar 2025 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QbGIrmnV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC0D18DB1D
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227143; cv=none; b=M/0jpg9Rk0ueB0GZ7LKBmDIQEP3ymGO2fItUZ58XSodO+Klm1dpcxHHLb47pWq3rZs+QVmyJt8ymUVg0mkHLjSd8UPid9FswSYEhYBrdP2zUBPrerNVID5aQH38KTPAig+t5XSyVaHM33rfrtDzVdSUdCos8p0UBkgv1ks7oyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227143; c=relaxed/simple;
	bh=STcdnDx4fLEy8iuMBLRaKtzoDqitYpFoR6I9WfPq7j8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2IvrB46OOqpLQgGM5xywC0yel7scBD2YoslVsSBe//EIvTySOgDhyFDtxtHRa4aL52nlItenY3h8GA5ZVY29VgVX1I/wOigfcMPjDr7fA0sCEq7yvexp4moMA03VOqFr3RkExBQJxDUpvK4sEfNmN1ZZbh6blw9zmgyvV0p9FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QbGIrmnV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5262CJQN02495429, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741227139; bh=STcdnDx4fLEy8iuMBLRaKtzoDqitYpFoR6I9WfPq7j8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QbGIrmnVu7AbMNAAfYYhJW4pqfhUYBaLZeo2KN84BLFjz41NxKacmsmaTGd8O6/rC
	 4PU3G6ahhM45llWB0CRJ4vh9RUejAbdVjiB0iB/FaxyUhhI7fVuNaLTt1Spwakhthe
	 0kuT3zNNKkQ3UqUUqzl8jpXxBHfEoNY9RI2rKenXd/Jos6Cgfovjzk/9LzbHClFFO5
	 gSg5mrDhiqqF5LFWxkCXCRNpg/qQCpSyxJx4aTGueVn0+RfzUcLWWpQJrtnW57IfVd
	 Qnaw7lyGQ5cVPTG4GmqjAtUtBeQrd1E241pzVcqMuy3VDx4+sSinEgd6HwO9IBxHuf
	 MQwKZqamu7USg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5262CJQN02495429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 10:12:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 10:12:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 6 Mar
 2025 10:12:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>
Subject: [PATCH rtw-next 5/5] wifi: rtw89: set force HE TB mode when connecting to 11ax AP
Date: Thu, 6 Mar 2025 10:11:44 +0800
Message-ID: <20250306021144.12854-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306021144.12854-1-pkshih@realtek.com>
References: <20250306021144.12854-1-pkshih@realtek.com>
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

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

Some of 11ax AP set the UL HE-SIG-A2 reserved subfield to all 0s, which
will cause the 11be chip to recognize trigger frame as EHT. We propose
a method to bypass the "UL HE-SIG-A2 reserved subfield" and always uses
HE TB in response to the AP's trigger frame.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 26 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  2 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 +++
 4 files changed, 33 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 513c317b286c..b4841f948ec1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4837,6 +4837,32 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
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
index 4d5a06a2fe9b..fd7935d24501 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1188,6 +1188,8 @@ void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
 				struct rtw89_vif_link *rtwvif_link, bool en);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct rtw89_vif_link *rtwvif_link);
+void rtw89_mac_set_he_tb(struct rtw89_dev *rtwdev,
+			 struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 778ca8589284..4fded07d0bee 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -656,6 +656,7 @@ static void __rtw89_ops_bss_link_assoc(struct rtw89_dev *rtwdev,
 	rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, rtwvif_link);
 	rtw89_mac_port_update(rtwdev, rtwvif_link);
 	rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, rtwvif_link);
+	rtw89_mac_set_he_tb(rtwdev, rtwvif_link);
 }
 
 static void __rtw89_ops_bss_assoc(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 44201efee01c..c776954ad360 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7102,6 +7102,10 @@
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
2.25.1


