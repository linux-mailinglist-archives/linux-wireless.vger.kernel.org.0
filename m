Return-Path: <linux-wireless+bounces-23936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF78AD388C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D3A1729D4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A38B246BA8;
	Tue, 10 Jun 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rF12LAZb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AF246BA7
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560501; cv=none; b=hAi7qGVnTmulVOvBwjrdAIF8cLtSffLzwAc8IHilaZOJciWjzVeLS9avvdGI8d9p85TRSBzzhty0pWD8ZOyVk8gwxgXzPtERE5sYMr3BGpaA1qhcjHBX2Eui2WIdWhWRS2sug4jph3tm4/9dSkwAYPjZTUkdRjmfm5PnoGT5aMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560501; c=relaxed/simple;
	bh=pemMPr2QrWLxxKXUurbvWcPpNcOcVjAkC2uNsJ43eXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZS+ta7LJhBlirkpmXVq+57jPB+AHTozb1abJSLdyETrzUwdjUT75KQqm66+K7Pbad6F3tJfEPekQ9c4fBYeVQEWWe2ofA+oKWAmjbJ3YMjjuhDCT0ArEpqpUZmwcbCLnoH/1mk5UD9PgUXNasPCveKf0Uke0h0FC9DqAm7GbZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rF12LAZb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1aB122995714, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560496; bh=7x3xsrOn+zFZJ4o89U6A3A7B4hcoYznVV+BreGdfJ7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rF12LAZbyMCv0qKrEHN8r90Etus5X27qWQAodcyzrdsm816fs/csLjqWs3TNNtq8m
	 63a5myoHFHyS/H6Gf8yt83LpBwL1snuETKmMBz1VeXNNAj8QMwaq5+sdUpPCTpfIni
	 topGPC5lpBM48eoeh2zhs1v2Tj3YUVR3eZoub5YE7WujAuhTnkjYvr0JaTitI37jUj
	 4bYsZaRIvArM4tzX6YgPFSGRBRf0EblaCV3UOe55I5eLV4F892QX+C6UtqfqRC3c9y
	 ta1GSYy2WjbxbeKbI3INXQs7ZblO1YnN7Y+nXepcuO50jz59z3tWux/0vR9kJaHDHn
	 GWGRO3N2dFp4w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1aB122995714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:37 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/12] wifi: rtw89: mcc: clear normal flow NoA when MCC start
Date: Tue, 10 Jun 2025 21:00:31 +0800
Message-ID: <20250610130034.14692-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

Clear NoA setting before MCC starts. Otherwise, nulldata will be
blocked to TX because firmware use the normal flow NoA to calculate
timing.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   |  4 +---
 drivers/net/wireless/realtek/rtw89/fw.h   |  3 +--
 drivers/net/wireless/realtek/rtw89/ps.c   | 24 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/ps.h   |  3 +++
 5 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 7539bba2e094..c83c4036151d 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -960,6 +960,7 @@ static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 		}
 
 		sel.bind_vif[i] = rtwvif_link;
+		rtw89_p2p_disable_all_noa(rtwdev, rtwvif_link, NULL);
 	}
 
 	ret = rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_fill_role_iterator, &sel);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 608159d31e08..2d649186b700 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3033,12 +3033,10 @@ int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
 #define H2C_P2P_ACT_LEN 20
 int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev,
 			 struct rtw89_vif_link *rtwvif_link,
-			 struct ieee80211_bss_conf *bss_conf,
 			 struct ieee80211_p2p_noa_desc *desc,
-			 u8 act, u8 noa_id)
+			 u8 act, u8 noa_id, u8 ctwindow_oppps)
 {
 	bool p2p_type_gc = rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT;
-	u8 ctwindow_oppps = bss_conf->p2p_noa_attr.oppps_ctwindow;
 	struct sk_buff *skb;
 	u8 *cmd;
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d66333321de2..116a17f7dfc6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4849,9 +4849,8 @@ int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 			  const struct rtw89_pkt_drop_params *params);
 int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev,
 			 struct rtw89_vif_link *rtwvif_link,
-			 struct ieee80211_bss_conf *bss_conf,
 			 struct ieee80211_p2p_noa_desc *desc,
-			 u8 act, u8 noa_id);
+			 u8 act, u8 noa_id, u8 ctwindow_oppps);
 int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
 			      bool en);
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index c255c2f9b945..3411d642c84a 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -238,13 +238,23 @@ static void rtw89_tsf32_toggle(struct rtw89_dev *rtwdev,
 		rtw89_fw_h2c_tsf32_toggle(rtwdev, rtwvif_link, false);
 }
 
-static void rtw89_p2p_disable_all_noa(struct rtw89_dev *rtwdev,
-				      struct rtw89_vif_link *rtwvif_link,
-				      struct ieee80211_bss_conf *bss_conf)
+void rtw89_p2p_disable_all_noa(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif_link *rtwvif_link,
+			       struct ieee80211_bss_conf *bss_conf)
 {
 	enum rtw89_p2pps_action act;
+	u8 oppps_ctwindow;
 	u8 noa_id;
 
+	rcu_read_lock();
+
+	if (!bss_conf)
+		bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+
+	oppps_ctwindow = bss_conf->p2p_noa_attr.oppps_ctwindow;
+
+	rcu_read_unlock();
+
 	if (rtwvif_link->last_noa_nr == 0)
 		return;
 
@@ -254,8 +264,8 @@ static void rtw89_p2p_disable_all_noa(struct rtw89_dev *rtwdev,
 		else
 			act = RTW89_P2P_ACT_REMOVE;
 		rtw89_tsf32_toggle(rtwdev, rtwvif_link, act);
-		rtw89_fw_h2c_p2p_act(rtwdev, rtwvif_link, bss_conf,
-				     NULL, act, noa_id);
+		rtw89_fw_h2c_p2p_act(rtwdev, rtwvif_link, NULL,
+				     act, noa_id, oppps_ctwindow);
 	}
 }
 
@@ -277,8 +287,8 @@ static void rtw89_p2p_update_noa(struct rtw89_dev *rtwdev,
 		else
 			act = RTW89_P2P_ACT_UPDATE;
 		rtw89_tsf32_toggle(rtwdev, rtwvif_link, act);
-		rtw89_fw_h2c_p2p_act(rtwdev, rtwvif_link, bss_conf,
-				     desc, act, noa_id);
+		rtw89_fw_h2c_p2p_act(rtwdev, rtwvif_link, desc, act, noa_id,
+				     bss_conf->p2p_noa_attr.oppps_ctwindow);
 	}
 	rtwvif_link->last_noa_nr = noa_id;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index b2c43d44820d..729477153de6 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -25,6 +25,9 @@ u8 rtw89_p2p_noa_fetch(struct rtw89_vif_link *rtwvif_link, void **data);
 void rtw89_p2p_noa_once_init(struct rtw89_vif_link *rtwvif_link);
 void rtw89_p2p_noa_once_deinit(struct rtw89_vif_link *rtwvif_link);
 void rtw89_p2p_noa_once_recalc(struct rtw89_vif_link *rtwvif_link);
+void rtw89_p2p_disable_all_noa(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif_link *rtwvif_link,
+			       struct ieee80211_bss_conf *bss_conf);
 
 static inline void rtw89_leave_ips_by_hwflags(struct rtw89_dev *rtwdev)
 {
-- 
2.25.1


