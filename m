Return-Path: <linux-wireless+bounces-28826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E53A2C4B35A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1ABF4E6003
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1B347BCA;
	Tue, 11 Nov 2025 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bvolosWq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D52BCF43
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827966; cv=none; b=rYcFuFL5XFGnePB2a7MuykZ7AVeBZkRLhDcRoI+o9I/Uqgjpf8Oep7rvIFuHh796M3Em9T/6KpdOE9WjiK5zTrAj75k71gfSJB1IM7jGXLdi39++TGeGuMZdta/XQAuFcIbe065Pu3qkuDzYMVQnTvcWd0ez1Nxgdil64ZKSKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827966; c=relaxed/simple;
	bh=LH7V7IswrWiLkymfKIXEz4NNPw6XFo7p4+GAZfAKPPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1gIDvKDElVWM4IJ5JyEln6z9Vz6sCaeNOjzy5AX+1sDz0op5XjshEk7EZ1xReB1xqCvKlU/154Wjz/GNHhSW9Y9iCa0HBQYanDD9brPRaHSRJGggx/ERGsrpw/s7IPzu0dMsRXKSbHVUlsUS1sBbfvYwYpjRNUQizICPKqsr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bvolosWq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB2Q2Gx82922238, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762827962; bh=KxBbRAD9cE+Aar2K0GFPOxXUTLthda9A7/hdlJ+Q1rA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bvolosWqiBOybMM/qAyBhzip80mWY+8B8M+b/8B31oGbtTq1Tu7j9DZXoFKR4QDUs
	 93JtKNkNtZf/nytVbs7JOoUoTkjIweN78e2FCsBzKKg9uun3GaKcfJOaH7AnhdnAnj
	 sE8D7Wk9Aofk4FPiXHk6fouMk9Qz5m3FATv/ZSjntbpukrFFALsjOpCqSGNBV0sGJZ
	 HkcZoI64MZMNV/U574t9t4DQoDCGtZWx8/OYe+8C15NoP85SzkxAUqPQIngxJo+Ou5
	 zxQUmNPvyuCC+EuTV0AvucZqwet6Z70Q0If2wdGh7zTbcJHmnxKUkepone98zISIJV
	 Ixx+/XTj4v7Bw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB2Q2Gx82922238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:26:02 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:26:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:26:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH v2 rtw-next 7/8] wifi: rtw89: do RF calibration once setting channel when running pure monitor mode
Date: Tue, 11 Nov 2025 10:24:51 +0800
Message-ID: <20251111022452.28093-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251111022452.28093-1-pkshih@realtek.com>
References: <20251111022452.28093-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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
index a5c451eed5a7..a15a911484bb 100644
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
index 4da73153513a..f63857b389d7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6125,6 +6125,7 @@ struct rtw89_dev {
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


