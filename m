Return-Path: <linux-wireless+bounces-22836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE8AB2667
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 05:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D701899CB4
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 03:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4072318BBB9;
	Sun, 11 May 2025 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="b6wqEwUq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F3188713
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746935571; cv=none; b=iv4fi60rpT4OEoHvkGflcsZJha0aAKsXc4UPJ+Wd8dAk1+3+gtdaAuDILFLjrsMPT66lfwJIjMGR94f80rLBV99eubdkeC/uTVsmklXdJYqFybKugpw6sNHbbcyVHokCKrrkY20LBk3iK6HrK7Y9J4om80m4btadav7pqm7HVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746935571; c=relaxed/simple;
	bh=VkE38b71Mqck9ZEd9WogzSIhy09ORekYKVxrQOFEHB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8zuQspPCbImaI8YxIZg2uACtfFZFJyLKV+PCQtssDyPGjDplUAYxWcgkSco8IY8dhvOegN7db+RLV9h+RNru9UxHWVZoPf3NrFwHE9o95HFx0ixbc2ImxBYxBJ0//jhmz5CAlWUG0WJAQSKHBxK7DiQrxsAGLoKoKdSfGT0058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=b6wqEwUq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54B3qkYnB3302902, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746935566; bh=VkE38b71Mqck9ZEd9WogzSIhy09ORekYKVxrQOFEHB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=b6wqEwUqalrHb16fhV5vEgS4EouE/kDgisDqMDtGlNknfBznJFCsrBlBL/CPFqC8R
	 bWJLwjKRTK0Qp+Esf/iHVhJ8w1K9hfAQ0lQ26+6mdCAbV3Be+AoZOsWLMMaS6piUHi
	 8MA9ksffgZviyKFv5bfIdLUlZXrqTjrcUBW/VD8u6e6zEv4z1DUTxW6xdv725k4iJP
	 FoNZI9ktPQPatE+xCnRiSOko/5BQ7tWA2SsdKOzEe1iZ6C51tT2WObIjghaegFXDEx
	 QHvndR0Vlp5oCBUBu38TDRwYZx0n5zFLjG4Z7B1hKR54Zq+yH+dOpoWhK7GgQflHo7
	 HEqBtpjfKYlRA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54B3qkYnB3302902
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 11:52:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 May 2025 11:52:47 +0800
Received: from [127.0.1.1] (10.22.224.86) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 11 May
 2025 11:52:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 5/6] wifi: rtw89: mcc: deal with non-periodic NoA
Date: Sun, 11 May 2025 11:52:16 +0800
Message-ID: <20250511035217.10410-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250511035217.10410-1-pkshih@realtek.com>
References: <20250511035217.10410-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, MCC just took periodic NoA into account. When the connected GO
announces non-periodic NoA and GC side is during MCC, sometimes GC cannot
receive beacons well if the MCC scheduling conflicts with the non-periodic
NoA planning. After the loss exceeds the tolerable amount, beacon filter
will report connection loss. However, in this case, the loss is acceptable.
So now, MCC will calculate the range of non-periodic NoA. And then, don't
care beacon loss during the range.

Besides, rtw89_mcc_fill_role_limit() only makes sense for GC. Remove the
redundant check of GO.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.c     |   3 +
 drivers/net/wireless/realtek/rtw89/core.h     |   9 ++
 drivers/net/wireless/realtek/rtw89/mac.c      |   3 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +
 drivers/net/wireless/realtek/rtw89/ps.c       | 147 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/ps.h       |   3 +
 drivers/net/wireless/realtek/rtw89/ser.c      |   2 +
 8 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 67acdcc1f535..b7593c7465b9 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -776,9 +776,11 @@ static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 	int ret;
 	int i;
 
-	if (!mcc_role->is_go && !mcc_role->is_gc)
+	if (!mcc_role->is_gc)
 		return;
 
+	rtw89_p2p_noa_once_recalc(rtwvif_link);
+
 	rcu_read_lock();
 
 	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3b2a2c6b9a44..49447668cbf3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4004,6 +4004,9 @@ int rtw89_core_sta_link_disassoc(struct rtw89_dev *rtwdev,
 	if (vif->type == NL80211_IFTYPE_STATION)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, false);
 
+	if (rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
+		rtw89_p2p_noa_once_deinit(rtwvif_link);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c0f2b62bc43b..1c8f3b9b7c4c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3485,6 +3485,14 @@ struct rtw89_p2p_noa_setter {
 	u8 noa_index;
 };
 
+struct rtw89_ps_noa_once_handler {
+	bool in_duration;
+	u64 tsf_begin;
+	u64 tsf_end;
+	struct wiphy_delayed_work set_work;
+	struct wiphy_delayed_work clr_work;
+};
+
 struct rtw89_vif_link {
 	struct rtw89_vif *rtwvif;
 	struct list_head dlink_schd;
@@ -3531,6 +3539,7 @@ struct rtw89_vif_link {
 	struct rtw89_phy_rate_pattern rate_pattern;
 	struct list_head general_pkt_list;
 	struct rtw89_p2p_noa_setter p2p_noa;
+	struct rtw89_ps_noa_once_handler noa_once;
 };
 
 enum rtw89_lv1_rcvy_step {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e3976ba6dda2..9f0e30e75009 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5025,7 +5025,8 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 
 	switch (type) {
 	case RTW89_BCN_FLTR_BEACON_LOSS:
-		if (!rtwdev->scanning && !rtwvif->offchan)
+		if (!rtwdev->scanning && !rtwvif->offchan &&
+		    !rtwvif_link->noa_once.in_duration)
 			ieee80211_connection_loss(vif);
 		else
 			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 22d13a0d5b8a..a47971003bd4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -114,6 +114,8 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 	wiphy_work_init(&rtwvif_link->update_beacon_work, rtw89_core_update_beacon_work);
 	INIT_LIST_HEAD(&rtwvif_link->general_pkt_list);
 
+	rtw89_p2p_noa_once_init(rtwvif_link);
+
 	rtwvif_link->hit_rule = 0;
 	rtwvif_link->bcn_hit_cond = 0;
 	rtwvif_link->chanctx_assigned = false;
@@ -143,6 +145,8 @@ static void __rtw89_ops_remove_iface_link(struct rtw89_dev *rtwdev,
 
 	wiphy_work_cancel(rtwdev->hw->wiphy, &rtwvif_link->update_beacon_work);
 
+	rtw89_p2p_noa_once_deinit(rtwvif_link);
+
 	rtw89_leave_ps_mode(rtwdev);
 
 	rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, NULL, BTC_ROLE_STOP);
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index ac46a7baa00d..8e4fe73e7d77 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -382,3 +382,150 @@ u8 rtw89_p2p_noa_fetch(struct rtw89_vif_link *rtwvif_link, void **data)
 	tail = ie->noa_desc + setter->noa_count;
 	return tail - *data;
 }
+
+static void rtw89_ps_noa_once_set_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_ps_noa_once_handler *noa_once =
+		container_of(work, struct rtw89_ps_noa_once_handler, set_work.work);
+
+	lockdep_assert_wiphy(wiphy);
+
+	noa_once->in_duration = true;
+}
+
+static void rtw89_ps_noa_once_clr_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_ps_noa_once_handler *noa_once =
+		container_of(work, struct rtw89_ps_noa_once_handler, clr_work.work);
+	struct rtw89_vif_link *rtwvif_link =
+		container_of(noa_once, struct rtw89_vif_link, noa_once);
+	struct rtw89_dev *rtwdev = rtwvif_link->rtwvif->rtwdev;
+
+	lockdep_assert_wiphy(wiphy);
+
+	rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
+	noa_once->in_duration = false;
+}
+
+void rtw89_p2p_noa_once_init(struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_ps_noa_once_handler *noa_once = &rtwvif_link->noa_once;
+
+	noa_once->in_duration = false;
+	noa_once->tsf_begin = 0;
+	noa_once->tsf_end = 0;
+
+	wiphy_delayed_work_init(&noa_once->set_work, rtw89_ps_noa_once_set_work);
+	wiphy_delayed_work_init(&noa_once->clr_work, rtw89_ps_noa_once_clr_work);
+}
+
+static void rtw89_p2p_noa_once_cancel(struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_ps_noa_once_handler *noa_once = &rtwvif_link->noa_once;
+	struct rtw89_dev *rtwdev = rtwvif_link->rtwvif->rtwdev;
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
+
+	wiphy_delayed_work_cancel(wiphy, &noa_once->set_work);
+	wiphy_delayed_work_cancel(wiphy, &noa_once->clr_work);
+}
+
+void rtw89_p2p_noa_once_deinit(struct rtw89_vif_link *rtwvif_link)
+{
+	rtw89_p2p_noa_once_cancel(rtwvif_link);
+	rtw89_p2p_noa_once_init(rtwvif_link);
+}
+
+void rtw89_p2p_noa_once_recalc(struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_ps_noa_once_handler *noa_once = &rtwvif_link->noa_once;
+	struct rtw89_dev *rtwdev = rtwvif_link->rtwvif->rtwdev;
+	const struct ieee80211_p2p_noa_desc *noa_desc;
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
+	struct ieee80211_bss_conf *bss_conf;
+	u64 tsf_begin = U64_MAX, tsf_end;
+	u64 set_delay_us = 0;
+	u64 clr_delay_us = 0;
+	u32 start_time;
+	u32 interval;
+	u32 duration;
+	u64 tsf;
+	int ret;
+	int i;
+
+	lockdep_assert_wiphy(wiphy);
+
+	ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif_link, &tsf);
+	if (ret) {
+		rtw89_warn(rtwdev, "%s: failed to get tsf\n", __func__);
+		return;
+	}
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+
+	for (i = 0; i < ARRAY_SIZE(bss_conf->p2p_noa_attr.desc); i++) {
+		bool first = tsf_begin == U64_MAX;
+		u64 tmp;
+
+		noa_desc = &bss_conf->p2p_noa_attr.desc[i];
+		if (noa_desc->count == 0 || noa_desc->count == 255)
+			continue;
+
+		start_time = le32_to_cpu(noa_desc->start_time);
+		interval = le32_to_cpu(noa_desc->interval);
+		duration = le32_to_cpu(noa_desc->duration);
+
+		if (unlikely(duration == 0 ||
+			     (noa_desc->count > 1 && interval == 0)))
+			continue;
+
+		tmp = start_time + interval * (noa_desc->count - 1) + duration;
+		tmp = (tsf & GENMASK_ULL(63, 32)) + tmp;
+		if (unlikely(tmp <= tsf))
+			continue;
+		tsf_end = first ? tmp : max(tsf_end, tmp);
+
+		tmp = (tsf & GENMASK_ULL(63, 32)) | start_time;
+		tsf_begin = first ? tmp : min(tsf_begin, tmp);
+	}
+
+	rcu_read_unlock();
+
+	if (tsf_begin == U64_MAX)
+		return;
+
+	rtw89_p2p_noa_once_cancel(rtwvif_link);
+
+	if (noa_once->tsf_end > tsf) {
+		tsf_begin = min(tsf_begin, noa_once->tsf_begin);
+		tsf_end = max(tsf_end, noa_once->tsf_end);
+	}
+
+	clr_delay_us = min_t(u64, tsf_end - tsf, UINT_MAX);
+
+	if (tsf_begin <= tsf) {
+		noa_once->in_duration = true;
+		goto out;
+	}
+
+	set_delay_us = tsf_begin - tsf;
+	if (unlikely(set_delay_us > UINT_MAX)) {
+		rtw89_warn(rtwdev, "%s: unhandled begin\n", __func__);
+		set_delay_us = 0;
+		clr_delay_us = 0;
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
+		noa_once->in_duration = false;
+	}
+
+out:
+	if (set_delay_us)
+		wiphy_delayed_work_queue(wiphy, &noa_once->set_work,
+					 usecs_to_jiffies(set_delay_us));
+	if (clr_delay_us)
+		wiphy_delayed_work_queue(wiphy, &noa_once->clr_work,
+					 usecs_to_jiffies(clr_delay_us));
+
+	noa_once->tsf_begin = tsf_begin;
+	noa_once->tsf_end = tsf_end;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 2b88f254a32d..b2c43d44820d 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -22,6 +22,9 @@ void rtw89_p2p_noa_renew(struct rtw89_vif_link *rtwvif_link);
 void rtw89_p2p_noa_append(struct rtw89_vif_link *rtwvif_link,
 			  const struct ieee80211_p2p_noa_desc *desc);
 u8 rtw89_p2p_noa_fetch(struct rtw89_vif_link *rtwvif_link, void **data);
+void rtw89_p2p_noa_once_init(struct rtw89_vif_link *rtwvif_link);
+void rtw89_p2p_noa_once_deinit(struct rtw89_vif_link *rtwvif_link);
+void rtw89_p2p_noa_once_recalc(struct rtw89_vif_link *rtwvif_link);
 
 static inline void rtw89_leave_ips_by_hwflags(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 6ab25d71b050..811c91481441 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -310,6 +310,8 @@ static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 		rtwvif_link->net_type = RTW89_NET_TYPE_NO_LINK;
 		rtwvif_link->trigger = false;
 		rtwvif_link->rand_tsf_done = false;
+
+		rtw89_p2p_noa_once_deinit(rtwvif_link);
 	}
 }
 
-- 
2.25.1


