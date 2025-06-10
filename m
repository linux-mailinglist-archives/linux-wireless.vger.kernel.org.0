Return-Path: <linux-wireless+bounces-23931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68FFAD3881
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D3216E752
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67F2E62A5;
	Tue, 10 Jun 2025 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="b0OKU0ot"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427582E338B
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560479; cv=none; b=VUBCQ5sCl5fopnvbMECqLvv7Mx0pWMkBHNkeJ64j2C9g+30DPjtwByTfw4Ctkov0Q4PwambLyWSbwyE75WdE28djwFKmhek0MMBcOFv3isBfqzuzf7ddUL5tTXAYa58k9ckNtqIxgxs1AekVD2PsX0nOC3NcZjzIwzbMYzxnd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560479; c=relaxed/simple;
	bh=dtuo9kSzOf+zC02IIs3HyN10fJ1YcZeXmcEsSwrk9gM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWtSKd1q0xhcUsCJrj7f7AumOorWbi34q7MJMBFYP4bJeTZWWGRaRvEIVTNOaFVr4DKBZCk6SwAN7k2BhNoDqri68QVIQhh7iZAUXNP/SFaeekdo0PLR0rev5BRBM6dNrqZUkeJoDmfcg0wh8HndRS6OKPn0zpleTqpc2Yq3dkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=b0OKU0ot; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1DyD42995468, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560473; bh=pvd6nIkX7CXZ5n6CPu2KZUHWPQXvTwSVzT/Q7YSPRJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=b0OKU0ot11hS/6hI2oBMlP9tCDTZGiM2LCr9/c815SfQRPjmqI4VMenhksVh0TJeH
	 tZvSwlnU0moeUdNN7a59j1NIs8LdEjbm4mZjB9QGu5FEDb1nDdMfxAkhRwMJaoUAsL
	 hce+2pzV0hF/KCnUidL3gHiiHJ8J0zbVOh7aGv5gvTyJdTsK6nZ5XXEJtr0HJOppgZ
	 6TJh4NiPk5VNANlHUJgT/9CahXyVDGrgZkm7yc+Q7aCo0NGHSkixNprA8ObpskhmQ9
	 Y8neJC5wH8p8+QGTMNDKU0ZVn12Wmgjpb68oMHwmcz5LUwE5lZfMtm/yLI7gB56p4a
	 Q0042UhO1ZzFw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1DyD42995468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:14 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/12] wifi: rtw89: mcc: adjust beacon filter when MCC and detect connection
Date: Tue, 10 Jun 2025 21:00:26 +0800
Message-ID: <20250610130034.14692-5-pkshih@realtek.com>
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

MCC needs to wait at most 300ms to start. Additionally, if
scanning happens before MCC starts, it will miss some beacons,
which might cause beacon loss. Therefore, we reset beacon
filter when MCC start to let hardware reset beacon loss counter.
Additionally, GO is forbid to enter courtesy mode might cause
STA beacon loss. Therefore, disable beacon filter when GO+STA.

However, In WiFi 7 chip, even when GC+STA enable courtesy mode, the
beacon might loss because switching to courtesy timeslot will disable
TX/RX. If the TOB(time offset behind) or TOA(time offset ahead) is
too close to the edge of timeslot, the beacon might not be received.
Therefore, disable beacon filter when GC+STA in WiFi 7 chip.

Because disabling the beacon filter might prevent disconnection
when the AP power-off without sending a deauth. Therefore, driver
TX QOS nulldata periodically to detect the AP status, and the
connection is terminated if no ACK is received for 6 seconds.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 50 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |  3 ++
 drivers/net/wireless/realtek/rtw89/core.c | 12 +++---
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index b2bc650a911b..2575aa174b05 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2184,6 +2184,18 @@ static void rtw89_mcc_stop_beacon_noa(struct rtw89_dev *rtwdev)
 	rtw89_mcc_handle_beacon_noa(rtwdev, false);
 }
 
+static bool rtw89_mcc_ignore_bcn(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *role)
+{
+	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
+
+	if (role->is_go)
+		return true;
+	else if (chip_gen == RTW89_CHIP_BE && role->is_gc)
+		return true;
+	else
+		return false;
+}
+
 static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -2207,6 +2219,15 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	else
 		mcc->mode = RTW89_MCC_MODE_GC_STA;
 
+	if (rtw89_mcc_ignore_bcn(rtwdev, ref)) {
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, aux->rtwvif_link, false);
+	} else if (rtw89_mcc_ignore_bcn(rtwdev, aux)) {
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, ref->rtwvif_link, false);
+	} else {
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, ref->rtwvif_link, true);
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, aux->rtwvif_link, true);
+	}
+
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC sel mode: %d\n", mcc->mode);
 
 	mcc->group = RTW89_MCC_DFLT_GROUP;
@@ -2369,15 +2390,44 @@ static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw89_mcc_detect_connection(struct rtw89_dev *rtwdev,
+					struct rtw89_mcc_role *role)
+{
+	struct ieee80211_vif *vif;
+	int ret;
+
+	ret = rtw89_core_send_nullfunc(rtwdev, role->rtwvif_link, true, false,
+				       RTW89_MCC_PROBE_TIMEOUT);
+	if (ret)
+		role->probe_count++;
+	else
+		role->probe_count = 0;
+
+	if (role->probe_count < RTW89_MCC_PROBE_MAX_TRIES)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC <macid %d> can not detect AP\n", role->rtwvif_link->mac_id);
+	vif = rtwvif_link_to_vif(role->rtwvif_link);
+	ieee80211_connection_loss(vif);
+}
+
 static void rtw89_mcc_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_config *config = &mcc->config;
 	struct rtw89_mcc_pattern *pattern = &config->pattern;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	u16 tolerance;
 	u16 bcn_ofst;
 	u16 diff;
 
+	if (rtw89_mcc_ignore_bcn(rtwdev, ref))
+		rtw89_mcc_detect_connection(rtwdev, aux);
+	else if (rtw89_mcc_ignore_bcn(rtwdev, aux))
+		rtw89_mcc_detect_connection(rtwdev, ref);
+
 	if (mcc->mode != RTW89_MCC_MODE_GC_STA)
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 9c5e61ccab88..6036f3ca6f67 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -19,6 +19,9 @@
 #define RTW89_MCC_MIN_RX_BCN_TIME 10
 #define RTW89_MCC_DFLT_BCN_OFST_TIME 40
 
+#define RTW89_MCC_PROBE_TIMEOUT 100
+#define RTW89_MCC_PROBE_MAX_TRIES 3
+
 #define RTW89_MCC_MIN_GO_DURATION \
 	(RTW89_MCC_EARLY_TX_BCN_TIME + RTW89_MCC_MIN_RX_BCN_TIME)
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4252717b1584..e7e2315d1867 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3367,8 +3367,8 @@ static void rtw89_core_handle_sta_pending_tx(struct rtw89_dev *rtwdev,
 					  rtwvif_link);
 }
 
-static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif_link *rtwvif_link, bool qos, bool ps)
+int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
+			     bool qos, bool ps, int timeout)
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	int link_id = ieee80211_vif_is_mld(vif) ? rtwvif_link->link_id : -1;
@@ -3416,7 +3416,7 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 	rcu_read_unlock();
 
 	return rtw89_core_tx_kick_off_and_wait(rtwdev, skb, qsel,
-					       RTW89_ROC_TX_TIMEOUT);
+					       timeout);
 out:
 	rcu_read_unlock();
 
@@ -3453,7 +3453,8 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	pause_parm.trigger = rtwvif_link;
 	rtw89_chanctx_pause(rtwdev, &pause_parm);
 
-	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, true);
+	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, true,
+				       RTW89_ROC_TX_TIMEOUT);
 	if (ret)
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "roc send null-1 failed: %d\n", ret);
@@ -3513,7 +3514,8 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	roc->state = RTW89_ROC_IDLE;
 	rtw89_config_roc_chandef(rtwdev, rtwvif_link, NULL);
 	rtw89_chanctx_proceed(rtwdev, NULL);
-	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, false);
+	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, false,
+				       RTW89_ROC_TX_TIMEOUT);
 	if (ret)
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "roc send null-0 failed: %d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8c2a71ecfc0d..84c0d5814747 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5685,6 +5685,7 @@ struct rtw89_mcc_role {
 
 	/* byte-array in LE order for FW */
 	u8 macid_bitmap[BITS_TO_BYTES(RTW89_MAX_MAC_ID_NUM)];
+	u8 probe_count;
 
 	u16 duration; /* TU */
 	u16 beacon_interval; /* TU */
@@ -7342,6 +7343,8 @@ int rtw89_core_start(struct rtw89_dev *rtwdev);
 void rtw89_core_stop(struct rtw89_dev *rtwdev);
 void rtw89_core_update_beacon_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_core_csa_beacon_work(struct wiphy *wiphy, struct wiphy_work *work);
+int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
+			     bool qos, bool ps, int timeout);
 void rtw89_roc_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-- 
2.25.1


