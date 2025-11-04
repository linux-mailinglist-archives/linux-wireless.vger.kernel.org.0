Return-Path: <linux-wireless+bounces-28529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3FC30324
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 10:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EAEF4F7DC8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 09:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB9312825;
	Tue,  4 Nov 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JW43UKFI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB63128AC
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247485; cv=none; b=uOQuuGFI16grEttd8U8p7UhkrSizE55qFDh0BWtl8ruT9+1RRzxXy2kBgExbhFe+LDOFJKeoe01cWaRySFLr4Z/KySC9TieoWbUOCfEfcVv95j1LmamSCEqMrhvgOgo09O4HNMK1D81Fbf4YqtVN/aBNchLsKuSRyPSWQEIr85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247485; c=relaxed/simple;
	bh=UlWZ5aCof7+hlBkF7XV9knPLnpoSGtpYe0drAOjlErA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOM24Dmfim8Sy+OKNRawj96orx6R9U3VFYqpIbh3ZyFx+35csz3IwytNaGahizNdv/UFYWZpu2/9aJdTLO/NWOkpC1CoCoxGVpZ6sUKy6s/dSY0YYzwLt9300hfCTkPCL3PR7GlubbBSHqns8ULJFgwjjCnoGOQkJeoaLjsuQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JW43UKFI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A49BKDs83073573, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762247480; bh=GTaGu9JLmddUZ809OsY0kiNXgNSuqWA4ChJE/lCDe80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=JW43UKFI09vt5CtpeRqb0VfaedDkw9E1+TANPf4GTUdgZdWhSU3xXAVzU0Ap4xdII
	 Ixzy1juECtuRydN/8PFE60hgRcYvSb3kFMoxGNGWdtcBG7PL9+tJ5eno7jlHpCFkqt
	 KdXbQt4aa/OJcjipkpBmSQqhHGaKM324J8l8WnYx6bLDtqXzy45gVZHmXi0SGN8rBY
	 Gn/aa9xFamz+lXf0KRi9rfDYO7D65WdkMEpiKTjokTUAuygkHe5xGQMSDCrVQ2SlCL
	 Vdb+A9CObjWzZypOyJR8dTWv9uRR60xNQfX/Kcs4J71KDc8H0Lr9cVFPY/ewL6T66u
	 B/N3RRAomUgZQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A49BKDs83073573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 17:11:20 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 17:11:21 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 17:11:20 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 17:11:20 +0800
From: <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 7/8] wifi: rtw89: do RF calibration once setting channel when running pure monitor mode
Date: Tue, 4 Nov 2025 17:14:12 +0800
Message-ID: <1762247653-26864-8-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
References: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ping-Ke Shih <pkshih@realtek.com>

To be able to capture and inject packets in monitor mode, do RF calibration
once setting certain channel. Since calibration costs time, do not change
behavior of normal usage, which do calibration only when starting as AP
or going to connect AP.

Since driver declares IEEE80211_HW_WANT_MONITOR_VIF, the pure monitor vif
must be only one when adding interface with type NL80211_IFTYPE_MONITOR.
Otherwise, monitor vif must be NULL.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 9bb3c05bb738..9cc0e681ef47 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -470,6 +470,22 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	__rtw89_core_set_chip_txpwr(rtwdev, chan, RTW89_PHY_1);
 }
 
+static void rtw89_chip_rfk_channel_for_pure_mon_vif(struct rtw89_dev *rtwdev,
+						    enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_vif *rtwvif = rtwdev->pure_monitor_mode_vif;
+	struct rtw89_vif_link *rtwvif_link;
+
+	if (!rtwvif)
+		return;
+
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, phy_idx);
+	if (!rtwvif_link)
+		return;
+
+	rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
+}
+
 static void __rtw89_set_channel(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
 				enum rtw89_mac_idx mac_idx,
@@ -498,6 +514,8 @@ static void __rtw89_set_channel(struct rtw89_dev *rtwdev,
 	}
 
 	rtw89_set_entity_state(rtwdev, phy_idx, true);
+
+	rtw89_chip_rfk_channel_for_pure_mon_vif(rtwdev, phy_idx);
 }
 
 int rtw89_set_channel(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 02d9d42cdbb5..e6a45e1e7b7c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6102,6 +6102,7 @@ struct rtw89_dev {
 	int napi_budget_countdown;
 
 	struct rtw89_debugfs *debugfs;
+	struct rtw89_vif *pure_monitor_mode_vif;
 
 	/* HCI related data, keep last */
 	u8 priv[] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a19304ff8306..14c8864bd201 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -220,6 +220,8 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto unset_link;
 
+	rtwdev->pure_monitor_mode_vif = vif->type == NL80211_IFTYPE_MONITOR ?
+					rtwvif : NULL;
 	rtw89_recalc_lps(rtwdev);
 	return 0;
 
@@ -267,6 +269,8 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 	rtw89_core_release_bit_map(rtwdev->hw_port, port);
 	rtw89_release_mac_id(rtwdev, macid);
 
+	rtwdev->pure_monitor_mode_vif = NULL;
+
 	rtw89_recalc_lps(rtwdev);
 	rtw89_enter_ips_by_hwflags(rtwdev);
 }
-- 
2.25.1


