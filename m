Return-Path: <linux-wireless+bounces-35008-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HASArug5WlMmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35008-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E903426996
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA8E83015717
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3762FD1B1;
	Mon, 20 Apr 2026 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Rf/lHT/f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255482BDC0F
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656553; cv=none; b=Mg+k8UX9u0eFqc3XsvoVdT/GBcFPtvYnh+b5UeXe+JPHRPRU33+4zXnJy3LVQ4s2fOw5jEuC1qekgBuf3syc79bktgpFbnqFlf1CazcVkKIe7eOmJ6BFBOgMNDnjYqiJFqmW3TQowwXxaxOqRz7V8jzlCp+OW8GP1P/p1yKlkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656553; c=relaxed/simple;
	bh=0tcrDxQUp5F4aGZjoxT0bhntlaASU6Dzf601TVdWkOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtJ6jInf24xN0tfE7V+glAiUyaSzKNxoJv4T+w6SfKuEKHiMIViUoJdxaaio1hz9T3bIGKxLK6gMalZfFPK9azuNsqhRXvkIoPprsp5ItI9zHKco9M/ZOhnH2wAaBMjZIjVm8fdl2S/BhnMUV0C8izGedHganAOcdrQR66cEVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Rf/lHT/f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3gSUK1428293, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656548; bh=P7/Ocabo9+ZcRRMBP7aec2adTXIQ7nm3yD+gYbORUxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Rf/lHT/fJxiC4IAZuzjA/u/RSdLNnjDPnCTG0byC4YbLR8/RZMtTFBL9uKKU2xtrH
	 E135YHWf/gMFBjHgBMB7R18Z4ZGaGbhzUGoKccE8CY6OvZp77gpMxhc1fBPkq3THGh
	 0sBKy5nz9oT9E15WiB/oXTP+QU2EdR+VYlK5+ncAw4RyjrbZ684ILhh8WQ5WVNJyel
	 ix4pMD2CYMVUA6dkXINiTLpUY5iWGhHLTeR3pRFy+jot+OIMYfe6BJladGacaMbdOu
	 4QWe2NVEr+gPpdL6ysUb6Tn8YDd5xg+T3G2VA0q8OwmE3uUZ3AxaaAxr91zfDIpMbD
	 sRejvsz9Shz+w==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3gSUK1428293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:42:28 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:42:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Apr 2026 11:42:28 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:42:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 15/16] wifi: rtw89: chan: introduce new helper to get entity current configuration
Date: Mon, 20 Apr 2026 11:40:50 +0800
Message-ID: <20260420034051.17666-16-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-35008-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E903426996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The original helper can only queries target channel, but cannot determine
current role's status, e.g. is it MLD or not. These things should be a set.
Adding more and more helpers to query them individually without synchronous
doesn't seem right. Introduce a new helper to query current channel set and
role status.

Besides, when single channel, e.g. MLO_2_PLUS_0_1RF and MLO_0_PLUS_2_1RF,
the target channel pointer will be duplicated to fill the returned channel
set. So, some callers can save trivial things for these cases. The returned
channels will be non-NULL, so callers don't need trivial NULL check either.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 90 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/chan.h     | 21 ++---
 drivers/net/wireless/realtek/rtw89/core.c     | 20 ++---
 drivers/net/wireless/realtek/rtw89/phy.c      | 12 ++-
 drivers/net/wireless/realtek/rtw89/phy_be.c   |  8 +-
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |  6 +-
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    |  6 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 17 +---
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 22 +----
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 30 +++++--
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.c | 22 +----
 11 files changed, 129 insertions(+), 125 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index ceb399fc2b94..cd846cb81f0c 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -398,43 +398,6 @@ static u8 rtw89_entity_role_get_index(struct rtw89_dev *rtwdev)
 	}
 }
 
-const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
-					       const char *caller_message,
-					       u8 link_index, bool nullchk)
-{
-	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
-	enum rtw89_chanctx_idx chanctx_idx;
-	u8 role_index;
-
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
-
-	if (unlikely(link_index >= __RTW89_MLD_MAX_LINK_NUM)) {
-		WARN(1, "link index %u is invalid (max link inst num: %d)\n",
-		     link_index, __RTW89_MLD_MAX_LINK_NUM);
-		goto dflt;
-	}
-
-	role_index = rtw89_entity_role_get_index(rtwdev);
-
-	chanctx_idx = mgnt->chanctx_tbl[role_index][link_index];
-	if (chanctx_idx == RTW89_CHANCTX_IDLE)
-		goto dflt;
-
-	return rtw89_chan_get(rtwdev, chanctx_idx);
-
-dflt:
-	if (unlikely(nullchk))
-		return NULL;
-
-	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
-		    "%s (%s): prefetch NULL on link index %u\n",
-		    __func__, caller_message ?: "", link_index);
-
-	return rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
-}
-EXPORT_SYMBOL(__rtw89_mgnt_chan_get);
-
 bool rtw89_entity_check_hw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	switch (rtwdev->mlo_dbcc_mode) {
@@ -457,6 +420,59 @@ void rtw89_entity_force_hw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN, "%s: (none)\n", __func__);
 }
 
+void rtw89_entity_get_conf(struct rtw89_dev *rtwdev, struct rtw89_entity_conf *conf)
+{
+	struct rtw89_entity_mgnt *mgnt = &rtwdev->hal.entity_mgnt;
+	enum rtw89_chanctx_idx idxes[ARRAY_SIZE(conf->chans)];
+	struct rtw89_vif *role;
+	u8 ridx;
+	int i;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	memset(conf, 0, sizeof(*conf));
+
+	ridx = rtw89_entity_role_get_index(rtwdev);
+	role = mgnt->active_roles[ridx];
+	if (role) {
+		struct ieee80211_vif *vif = rtwvif_to_vif(role);
+
+		conf->is_mld = ieee80211_vif_is_mld(vif);
+		conf->en_emlsr = role->mlo_mode == RTW89_MLO_MODE_EMLSR;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(idxes); i++)
+		idxes[i] = RTW89_CHANCTX_IDLE;
+
+	switch (rtwdev->mlo_dbcc_mode) {
+	default:
+	case MLO_2_PLUS_0_1RF:
+		set_bit(0, conf->hw_bitmap);
+		idxes[0] = mgnt->chanctx_tbl[ridx][0];
+		idxes[1] = idxes[0];
+		break;
+	case MLO_0_PLUS_2_1RF:
+		set_bit(1, conf->hw_bitmap);
+		idxes[1] = mgnt->chanctx_tbl[ridx][1];
+		idxes[0] = idxes[1];
+		break;
+	case MLO_1_PLUS_1_1RF:
+		set_bit(0, conf->hw_bitmap);
+		set_bit(1, conf->hw_bitmap);
+		idxes[0] = mgnt->chanctx_tbl[ridx][0];
+		idxes[1] = mgnt->chanctx_tbl[ridx][1];
+		break;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(idxes); i++) {
+		if (idxes[i] == RTW89_CHANCTX_IDLE)
+			idxes[i] = RTW89_CHANCTX_0;
+
+		conf->chans[i] = rtw89_chan_get(rtwdev, idxes[i]);
+	}
+}
+EXPORT_SYMBOL(rtw89_entity_get_conf);
+
 static enum rtw89_mlo_dbcc_mode
 rtw89_entity_sel_mlo_dbcc_mode(struct rtw89_dev *rtwdev, u8 active_hws)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index c797cda2e763..a9a5f1b307a2 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -116,6 +116,13 @@ struct rtw89_entity_weight {
 	unsigned int active_roles;
 };
 
+struct rtw89_entity_conf {
+	bool is_mld;
+	bool en_emlsr;
+	DECLARE_BITMAP(hw_bitmap, __RTW89_MLD_MAX_LINK_NUM);
+	const struct rtw89_chan *chans[__RTW89_MLD_MAX_LINK_NUM];
+};
+
 static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev,
 					  enum rtw89_phy_idx phy_idx)
 {
@@ -168,6 +175,7 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev);
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
 bool rtw89_entity_check_hw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw89_entity_force_hw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw89_entity_get_conf(struct rtw89_dev *rtwdev, struct rtw89_entity_conf *conf);
 void rtw89_chanctx_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev);
 void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
@@ -180,19 +188,6 @@ void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
 void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev,
 			   const struct rtw89_chanctx_cb_parm *cb_parm);
 
-const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
-					       const char *caller_message,
-					       u8 link_index, bool nullchk);
-
-#define rtw89_mgnt_chan_get(rtwdev, link_index) \
-	__rtw89_mgnt_chan_get(rtwdev, __func__, link_index, false)
-
-static inline const struct rtw89_chan *
-rtw89_mgnt_chan_get_or_null(struct rtw89_dev *rtwdev, u8 link_index)
-{
-	return __rtw89_mgnt_chan_get(rtwdev, NULL, link_index, true);
-}
-
 struct rtw89_mcc_links_info {
 	struct rtw89_vif_link *links[NUM_OF_RTW89_MCC_ROLES];
 };
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 41eefe901ab2..aeeba52b8c5e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -474,16 +474,16 @@ static void __rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev,
 
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chan *chan;
+	struct rtw89_entity_conf conf;
+
+	rtw89_entity_get_conf(rtwdev, &conf);
 
-	chan = rtw89_mgnt_chan_get(rtwdev, 0);
-	__rtw89_core_set_chip_txpwr(rtwdev, chan, RTW89_PHY_0);
+	__rtw89_core_set_chip_txpwr(rtwdev, conf.chans[0], RTW89_PHY_0);
 
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
 		return;
 
-	chan = rtw89_mgnt_chan_get(rtwdev, 1);
-	__rtw89_core_set_chip_txpwr(rtwdev, chan, RTW89_PHY_1);
+	__rtw89_core_set_chip_txpwr(rtwdev, conf.chans[1], RTW89_PHY_1);
 }
 
 void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
@@ -562,7 +562,7 @@ static void __rtw89_set_channel(struct rtw89_dev *rtwdev,
 
 int rtw89_set_channel(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chan *chan;
+	struct rtw89_entity_conf conf;
 	enum rtw89_entity_mode mode;
 
 	mode = rtw89_entity_recalc(rtwdev);
@@ -571,14 +571,14 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 		return -EINVAL;
 	}
 
-	chan = rtw89_mgnt_chan_get(rtwdev, 0);
-	__rtw89_set_channel(rtwdev, chan, RTW89_MAC_0, RTW89_PHY_0);
+	rtw89_entity_get_conf(rtwdev, &conf);
+
+	__rtw89_set_channel(rtwdev, conf.chans[0], RTW89_MAC_0, RTW89_PHY_0);
 
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
 		return 0;
 
-	chan = rtw89_mgnt_chan_get(rtwdev, 1);
-	__rtw89_set_channel(rtwdev, chan, RTW89_MAC_1, RTW89_PHY_1);
+	__rtw89_set_channel(rtwdev, conf.chans[1], RTW89_MAC_1, RTW89_PHY_1);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 5065326d8c53..45c31ef45198 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6839,11 +6839,15 @@ static void rtw89_phy_dig_update_rssi_info(struct rtw89_dev *rtwdev,
 static void rtw89_phy_dig_update_para(struct rtw89_dev *rtwdev,
 				      struct rtw89_bb_ctx *bb)
 {
-	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, bb->phy_idx);
 	struct rtw89_dig_info *dig = &bb->dig;
 	bool is_linked = rtwdev->total_sta_assoc > 0;
+	struct rtw89_entity_conf conf;
+	const struct rtw89_chan *chan;
 	const u16 *fa_th_src = NULL;
 
+	rtw89_entity_get_conf(rtwdev, &conf);
+	chan = conf.chans[bb->phy_idx];
+
 	switch (chan->band_type) {
 	case RTW89_BAND_2G:
 		dig->lna_gain = dig->lna_gain_g;
@@ -7173,14 +7177,18 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
 				    struct rtw89_bb_ctx *bb,
 				    u8 rssi, bool enable)
 {
-	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, bb->phy_idx);
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 	struct rtw89_dig_info *dig = &bb->dig;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 final_rssi, under_region = dig->pd_low_th_ofst;
+	struct rtw89_entity_conf conf;
+	const struct rtw89_chan *chan;
 	s8 cck_cca_th;
 	u32 pd_val;
 
+	rtw89_entity_get_conf(rtwdev, &conf);
+	chan = conf.chans[bb->phy_idx];
+
 	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_DIG_PD)) {
 		pd_val = hal->fixed_dig_pd_th;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 929fac1b10d2..25f1b068daa2 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -865,6 +865,7 @@ static void rtw89_phy_bb_wrap_tx_rfsi_ctrl_init(struct rtw89_dev *rtwdev,
 {
 	enum rtw89_phy_idx phy_idx = mac_idx != RTW89_MAC_0 ? RTW89_PHY_1 : RTW89_PHY_0;
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	struct rtw89_entity_conf conf;
 	const struct rtw89_chan *chan;
 
 	if (chip_id != RTL8922D)
@@ -879,9 +880,10 @@ static void rtw89_phy_bb_wrap_tx_rfsi_ctrl_init(struct rtw89_dev *rtwdev,
 
 	rtw89_phy_bb_wrap_set_rfsi_ct_opt(rtwdev, phy_idx);
 
-	chan = rtw89_mgnt_chan_get(rtwdev, phy_idx);
-	if (chan)
-		rtw89_phy_bb_wrap_set_rfsi_bandedge_ch(rtwdev, chan, phy_idx);
+	rtw89_entity_get_conf(rtwdev, &conf);
+	chan = conf.chans[phy_idx];
+
+	rtw89_phy_bb_wrap_set_rfsi_bandedge_ch(rtwdev, chan, phy_idx);
 }
 
 static void rtw89_phy_bb_wrap_ul_pwr(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 70b1515c00fa..0d443edfe259 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -4167,11 +4167,15 @@ void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
 
 void rtw8852b_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, 0);
 	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
 	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V0] = {};
+	struct rtw89_entity_conf conf;
+	const struct rtw89_chan *chan;
 	u8 idx;
 
+	rtw89_entity_get_conf(rtwdev, &conf);
+	chan = conf.chans[0];
+
 	for (idx = 0; idx < ARRAY_SIZE(desc); idx++) {
 		struct rtw89_rfk_chan_desc *p = &desc[idx];
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 961b26ba2d3c..433807e712e4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -4234,11 +4234,15 @@ void rtw8852bt_set_channel_rf(struct rtw89_dev *rtwdev,
 
 void rtw8852bt_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, 0);
 	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
 	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V0] = {};
+	struct rtw89_entity_conf conf;
+	const struct rtw89_chan *chan;
 	u8 idx;
 
+	rtw89_entity_get_conf(rtwdev, &conf);
+	chan = conf.chans[0];
+
 	for (idx = 0; idx < ARRAY_SIZE(desc); idx++) {
 		struct rtw89_rfk_chan_desc *p = &desc[idx];
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index d2ff55b23f95..ca6c24c6a153 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1860,7 +1860,7 @@ static void rtw8922a_digital_pwr_comp(struct rtw89_dev *rtwdev,
 
 static int rtw8922a_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode)
 {
-	const struct rtw89_chan *chan0, *chan1;
+	struct rtw89_entity_conf conf;
 
 	if (mode == MLO_1_PLUS_1_1RF || mode == DBCC_LEGACY) {
 		rtw89_phy_write32_mask(rtwdev, R_DBCC, B_DBCC_EN, 0x1);
@@ -1873,19 +1873,10 @@ static int rtw8922a_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode
 		return -EOPNOTSUPP;
 	}
 
-	if (mode == MLO_1_PLUS_1_1RF) {
-		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
-		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
-	} else if (mode == MLO_0_PLUS_2_1RF) {
-		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
-		chan0 = chan1;
-	} else {
-		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
-		chan1 = chan0;
-	}
+	rtw89_entity_get_conf(rtwdev, &conf);
 
-	rtw8922a_ctrl_afe_dac(rtwdev, chan0->band_width, RF_PATH_A);
-	rtw8922a_ctrl_afe_dac(rtwdev, chan1->band_width, RF_PATH_B);
+	rtw8922a_ctrl_afe_dac(rtwdev, conf.chans[0]->band_width, RF_PATH_A);
+	rtw8922a_ctrl_afe_dac(rtwdev, conf.chans[1]->band_width, RF_PATH_B);
 
 	rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0x6180);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index 98f14b31cf52..1e2b563f2bca 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -278,27 +278,13 @@ static u8 rtw8922a_chlk_reload_sel_tbl(struct rtw89_dev *rtwdev,
 
 static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chan *chan0, *chan1;
+	struct rtw89_entity_conf conf;
 	u8 s0_tbl, s1_tbl;
 
-	switch (rtwdev->mlo_dbcc_mode) {
-	default:
-	case MLO_2_PLUS_0_1RF:
-		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
-		chan1 = chan0;
-		break;
-	case MLO_0_PLUS_2_1RF:
-		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
-		chan0 = chan1;
-		break;
-	case MLO_1_PLUS_1_1RF:
-		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
-		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
-		break;
-	}
+	rtw89_entity_get_conf(rtwdev, &conf);
 
-	s0_tbl = rtw8922a_chlk_reload_sel_tbl(rtwdev, chan0, 0);
-	s1_tbl = rtw8922a_chlk_reload_sel_tbl(rtwdev, chan1, 1);
+	s0_tbl = rtw8922a_chlk_reload_sel_tbl(rtwdev, conf.chans[0], 0);
+	s1_tbl = rtw8922a_chlk_reload_sel_tbl(rtwdev, conf.chans[1], 1);
 
 	rtw8922a_chlk_ktbl_sel(rtwdev, RF_A, s0_tbl);
 	rtw8922a_chlk_ktbl_sel(rtwdev, RF_B, s1_tbl);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 564d4baa59e7..f0c9d8661e57 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -1943,10 +1943,19 @@ static void rtw8922d_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
 static void rtw8922d_digital_pwr_comp(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
-	const struct rtw89_chan *chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
-
-	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
+	const struct rtw89_chan *chan0, *chan1;
+	struct rtw89_entity_conf conf;
+
+	rtw89_entity_get_conf(rtwdev, &conf);
+	chan0 = conf.chans[0];
+	chan1 = conf.chans[1];
+
+	if (conf.en_emlsr) {
+		rtw8922d_set_digital_pwr_comp(rtwdev, chan0, 1, RF_PATH_A, RTW89_PHY_0);
+		rtw8922d_set_digital_pwr_comp(rtwdev, chan0, 1, RF_PATH_B, RTW89_PHY_0);
+		rtw8922d_set_digital_pwr_comp(rtwdev, chan1, 1, RF_PATH_A, RTW89_PHY_1);
+		rtw8922d_set_digital_pwr_comp(rtwdev, chan1, 1, RF_PATH_B, RTW89_PHY_1);
+	} else if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
 		rtw8922d_set_digital_pwr_comp(rtwdev, chan0, 0, RF_PATH_A, RTW89_PHY_0);
 		rtw8922d_set_digital_pwr_comp(rtwdev, chan1, 0, RF_PATH_B, RTW89_PHY_1);
 	} else {
@@ -1958,7 +1967,6 @@ static void rtw8922d_digital_pwr_comp(struct rtw89_dev *rtwdev,
 static int rtw8922d_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode,
 			     bool pwr_comp)
 {
-	const struct rtw89_chan *chan1;
 	u32 reg0, reg1;
 	u8 cck_phy_idx;
 
@@ -2016,8 +2024,10 @@ static int rtw8922d_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode
 		rtw89_write32_mask(rtwdev, reg0, B_BBWRAP_ELMSR_EN_BE4, 0);
 		rtw89_write32_mask(rtwdev, reg1, B_BBWRAP_ELMSR_EN_BE4, 0);
 	} else if ((mode == MLO_1_PLUS_1_1RF) || (mode == DBCC_LEGACY)) {
-		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
-		cck_phy_idx = chan1->band_type == RTW89_BAND_2G ?
+		struct rtw89_entity_conf conf;
+
+		rtw89_entity_get_conf(rtwdev, &conf);
+		cck_phy_idx = conf.chans[1]->band_type == RTW89_BAND_2G ?
 			      RTW89_PHY_1 : RTW89_PHY_0;
 
 		rtw89_phy_write32_mask(rtwdev, R_SYS_DBCC_BE4,
@@ -2475,9 +2485,11 @@ static void rtw8922d_set_txpwr(struct rtw89_dev *rtwdev,
 static void rtw8922d_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
 				    enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, phy_idx);
+	struct rtw89_entity_conf conf;
 
-	rtw8922d_set_txpwr_ref(rtwdev, chan, phy_idx);
+	rtw89_entity_get_conf(rtwdev, &conf);
+
+	rtw8922d_set_txpwr_ref(rtwdev, conf.chans[phy_idx], phy_idx);
 }
 
 static void rtw8922d_ctrl_trx_path(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
index 4e6a8e88a71e..7957f7b2d8e5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
@@ -187,27 +187,13 @@ static u8 rtw8922d_chlk_reload_sel_tbl(struct rtw89_dev *rtwdev,
 
 static void rtw8922d_chlk_reload(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chan *chan0, *chan1;
+	struct rtw89_entity_conf conf;
 	u8 s0_tbl, s1_tbl;
 
-	switch (rtwdev->mlo_dbcc_mode) {
-	default:
-	case MLO_2_PLUS_0_1RF:
-		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
-		chan1 = chan0;
-		break;
-	case MLO_0_PLUS_2_1RF:
-		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
-		chan0 = chan1;
-		break;
-	case MLO_1_PLUS_1_1RF:
-		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
-		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
-		break;
-	}
+	rtw89_entity_get_conf(rtwdev, &conf);
 
-	s0_tbl = rtw8922d_chlk_reload_sel_tbl(rtwdev, chan0, 0);
-	s1_tbl = rtw8922d_chlk_reload_sel_tbl(rtwdev, chan1, 1);
+	s0_tbl = rtw8922d_chlk_reload_sel_tbl(rtwdev, conf.chans[0], 0);
+	s1_tbl = rtw8922d_chlk_reload_sel_tbl(rtwdev, conf.chans[1], 1);
 
 	rtw8922d_chlk_ktbl_sel(rtwdev, RF_A, s0_tbl);
 	rtw8922d_chlk_ktbl_sel(rtwdev, RF_B, s1_tbl);
-- 
2.25.1


