Return-Path: <linux-wireless+bounces-17821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C88A18BA2
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61474169547
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683F21537CB;
	Wed, 22 Jan 2025 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HwBpqn3C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F018E361
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525857; cv=none; b=VpOEfmFZ2ZMhEtySPlAA9ITi4+A4787LJZuXFR0+NFMpkNVLcK2hlx0jaNMx4a7f7dM1lRQGZ0PktLdzueIwv4rGwpuxvl6kKQdBtxjc2pDgod1oVJJ9LPbEyegwEk7ywYlq8CUK+5/UcPRfhqhV7YHkwWzU1OgKpYvh8vAcp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525857; c=relaxed/simple;
	bh=ZkNNiIBHIXLT/OiwnlQEhDwsRrw9T45hlAuHg19ApTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7T2KpRJAKr94ZifW3Ke7A1BVcKOJy6TcHfbQIUgUCyat8xIYhinT2H+K5zyrumBoGnyljbwpxgvOOtknyvGMFQVhLT/f/IZnClyEQQCznWL8UOmxNA4puAdSiKqDemK7CyUXFJrigH2Q0vraW6hbTAFHxBtP+FSR2mQkZobPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HwBpqn3C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M64ChK42495227, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525852; bh=ZkNNiIBHIXLT/OiwnlQEhDwsRrw9T45hlAuHg19ApTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HwBpqn3C47t+iXdKBbztA0unKqfb1rfmJQ8iLCVEA8R/6npDMhkxiMtzglpDquq5E
	 66Il/CD4zqg6Br0Ui+am6dQOOIhAwptj+jwaYr9/JwSSTkXuLYtNCdNCEhF7V9fkq8
	 fLqY9FmGcQyiiQddIStGywGUWlETpjvear3eyAiXUc+WEH4E+KE8njnGd5G5cBV3Yb
	 weuAev8kNM6qSptJKDxF8LUyu3QWpgvs1xOpQC/qkXvnqxa6grZDqOMK2bDZP+7JRz
	 zJv1yX1WTG3SUdnN4EVmfI5pkUH119L0yTtGPmQqL7MPScUEpCSSevnTAp3x1y/7W0
	 KW2AIBF2Pr1eg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M64ChK42495227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:04:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:04:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:04:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 08/10] wifi: rtw89: manual cosmetic along lockdep_assert_wiphy()
Date: Wed, 22 Jan 2025 14:03:08 +0800
Message-ID: <20250122060310.31976-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122060310.31976-1-pkshih@realtek.com>
References: <20250122060310.31976-1-pkshih@realtek.com>
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

With spatch script, already remove most driver mutex and generate
lockdep_assert_wiphy(), and some are needed to refine manually further to
be expected:

- lockdep_assert_wiphy() always be the first statement in function
- return directly rather than unnecessary goto
- change assert from mutex to wiphy lock, which script can't convert
  automatically.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     |   3 +-
 drivers/net/wireless/realtek/rtw89/coex.c     |   7 +
 drivers/net/wireless/realtek/rtw89/core.c     |  23 ++-
 drivers/net/wireless/realtek/rtw89/debug.c    |  30 ++--
 drivers/net/wireless/realtek/rtw89/fw.c       |   7 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 157 +++++++-----------
 drivers/net/wireless/realtek/rtw89/phy.c      |   4 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |   1 -
 drivers/net/wireless/realtek/rtw89/sar.c      |  11 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |   2 -
 drivers/net/wireless/realtek/rtw89/util.h     |   2 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |   6 +-
 12 files changed, 112 insertions(+), 141 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 98f420208632..be6d73273910 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2403,9 +2403,8 @@ void rtw89_chanctx_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	lockdep_assert_wiphy(wiphy);
 
-	if (hal->entity_pause) {
+	if (hal->entity_pause)
 		return;
-	}
 
 	for (i = 0; i < NUM_OF_RTW89_CHANCTX_CHANGES; i++) {
 		if (test_and_clear_bit(i, hal->changes))
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index a7b7675dca97..2c0ccf2f8bd9 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6722,6 +6722,7 @@ void rtw89_coex_act1_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 
 	lockdep_assert_wiphy(wiphy);
+
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): enter\n", __func__);
 	dm->cnt_notify[BTC_NCNT_TIMER]++;
 	if (wl->status.map._4way)
@@ -6741,6 +6742,7 @@ void rtw89_coex_bt_devinfo_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
 
 	lockdep_assert_wiphy(wiphy);
+
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): enter\n", __func__);
 	dm->cnt_notify[BTC_NCNT_TIMER]++;
 	a2dp->play_latency = 0;
@@ -6757,6 +6759,7 @@ void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 
 	lockdep_assert_wiphy(wiphy);
+
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): enter\n", __func__);
 	dm->cnt_notify[BTC_NCNT_TIMER]++;
 	if (wl->rfk_info.state != BTC_WRFK_STOP) {
@@ -7309,6 +7312,7 @@ void rtw89_btc_ntfy_eapol_packet_work(struct wiphy *wiphy, struct wiphy_work *wo
 						btc.eapol_notify_work);
 
 	lockdep_assert_wiphy(wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 	rtw89_btc_ntfy_specific_packet(rtwdev, PACKET_EAPOL);
 }
@@ -7319,6 +7323,7 @@ void rtw89_btc_ntfy_arp_packet_work(struct wiphy *wiphy, struct wiphy_work *work
 						btc.arp_notify_work);
 
 	lockdep_assert_wiphy(wiphy);
+
 	rtw89_btc_ntfy_specific_packet(rtwdev, PACKET_ARP);
 }
 
@@ -7328,6 +7333,7 @@ void rtw89_btc_ntfy_dhcp_packet_work(struct wiphy *wiphy, struct wiphy_work *wor
 						btc.dhcp_notify_work);
 
 	lockdep_assert_wiphy(wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 	rtw89_btc_ntfy_specific_packet(rtwdev, PACKET_DHCP);
 }
@@ -7338,6 +7344,7 @@ void rtw89_btc_ntfy_icmp_packet_work(struct wiphy *wiphy, struct wiphy_work *wor
 						btc.icmp_notify_work);
 
 	lockdep_assert_wiphy(wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 	rtw89_btc_ntfy_specific_packet(rtwdev, PACKET_ICMP);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index db5aeca64606..60bb53b53f46 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2082,7 +2082,7 @@ static void rtw89_cancel_6ghz_probe_work(struct wiphy *wiphy, struct wiphy_work
 	lockdep_assert_wiphy(wiphy);
 
 	if (!rtwdev->scanning)
-		goto out;
+		return;
 
 	list_for_each_entry(info, &pkt_list[NL80211_BAND_6GHZ], list) {
 		if (!info->cancel || !test_bit(info->id, rtwdev->pkt_offload))
@@ -2095,8 +2095,6 @@ static void rtw89_cancel_6ghz_probe_work(struct wiphy *wiphy, struct wiphy_work
 		 * since if during scanning, pkt_list is accessed in bottom half.
 		 */
 	}
-
-out:
 }
 
 static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
@@ -3147,7 +3145,9 @@ static void rtw89_ips_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						ips_work);
+
 	lockdep_assert_wiphy(wiphy);
+
 	rtw89_enter_ips_by_hwflags(rtwdev);
 }
 
@@ -3536,20 +3536,20 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 						track_work.work);
 	bool tfc_changed;
 
+	lockdep_assert_wiphy(wiphy);
+
 	if (test_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags))
 		return;
 
-	lockdep_assert_wiphy(wiphy);
-
 	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
-		goto out;
+		return;
 
 	wiphy_delayed_work_queue(wiphy, &rtwdev->track_work,
 				 RTW89_TRACK_WORK_PERIOD);
 
 	tfc_changed = rtw89_traffic_stats_track(rtwdev);
 	if (rtwdev->scanning)
-		goto out;
+		return;
 
 	rtw89_leave_lps(rtwdev);
 
@@ -3574,8 +3574,6 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
 		rtw89_enter_lps_track(rtwdev);
-
-out:
 }
 
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size)
@@ -4440,12 +4438,13 @@ void rtw89_core_update_beacon_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_vif_link *rtwvif_link = container_of(work, struct rtw89_vif_link,
 							  update_beacon_work);
 
+	lockdep_assert_wiphy(wiphy);
+
 	if (rtwvif_link->net_type != RTW89_NET_TYPE_AP_MODE)
 		return;
 
 	rtwdev = rtwvif_link->rtwvif->rtwdev;
 
-	lockdep_assert_wiphy(wiphy);
 	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_link);
 }
 
@@ -4581,6 +4580,8 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	struct wiphy *wiphy = rtwdev->hw->wiphy;
 	struct rtw89_btc *btc = &rtwdev->btc;
 
+	lockdep_assert_wiphy(wiphy);
+
 	/* Prvent to stop twice; enter_ips and ops_stop */
 	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
 		return;
@@ -4589,8 +4590,6 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 
 	clear_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
 
-	lockdep_assert_wiphy(wiphy);
-
 	wiphy_work_cancel(wiphy, &rtwdev->c2h_work);
 	wiphy_work_cancel(wiphy, &rtwdev->cancel_6ghz_probe_work);
 	wiphy_work_cancel(wiphy, &btc->eapol_notify_work);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 56be6705e9ea..885a5ebeb6cd 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -955,6 +955,7 @@ ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
 	ssize_t n;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 	chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
@@ -970,34 +971,28 @@ ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
 	p += rtw89_print_ant_gain(rtwdev, p, end - p, chan);
 
 	tbl = dbgfs_txpwr_tables[chip_gen];
-	if (!tbl) {
-		n = -EOPNOTSUPP;
-		goto err;
-	}
+	if (!tbl)
+		return -EOPNOTSUPP;
 
 	p += scnprintf(p, end - p, "\n[TX power byrate]\n");
 	n = __print_txpwr_map(rtwdev, p, end - p, tbl->byr);
 	if (n < 0)
-		goto err;
+		return n;
 	p += n;
 
 	p += scnprintf(p, end - p, "\n[TX power limit]\n");
 	n = __print_txpwr_map(rtwdev, p, end - p, tbl->lmt);
 	if (n < 0)
-		goto err;
+		return n;
 	p += n;
 
 	p += scnprintf(p, end - p, "\n[TX power limit_ru]\n");
 	n = __print_txpwr_map(rtwdev, p, end - p, tbl->lmt_ru);
 	if (n < 0)
-		goto err;
+		return n;
 	p += n;
 
 	return p - buf;
-
-err:
-
-	return n;
 }
 
 static ssize_t
@@ -1182,6 +1177,8 @@ rtw89_debug_priv_mac_mem_dump_get(struct rtw89_dev *rtwdev,
 	char *p = buf, *end = buf + bufsz;
 	bool grant_read = false;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	if (debugfs_priv->mac_mem.sel >= RTW89_MAC_MEM_NUM)
 		return -ENOENT;
 
@@ -1198,7 +1195,6 @@ rtw89_debug_priv_mac_mem_dump_get(struct rtw89_dev *rtwdev,
 		}
 	}
 
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 	if (grant_read)
 		rtw89_write32_set(rtwdev, R_AX_TCR1, B_AX_TCR_FORCE_READ_TXDFIFO);
@@ -3515,6 +3511,7 @@ rtw89_debug_priv_early_h2c_get(struct rtw89_dev *rtwdev,
 	int seq = 0;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	list_for_each_entry(early_h2c, &rtwdev->early_h2c_list, list)
 		p += scnprintf(p, end - p, "%d: %*ph\n", ++seq,
 			       early_h2c->h2c_len, early_h2c->h2c);
@@ -3531,6 +3528,8 @@ rtw89_debug_priv_early_h2c_set(struct rtw89_dev *rtwdev,
 	u8 *h2c;
 	u16 h2c_len = count / 2;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	h2c = rtw89_hex2bin(rtwdev, buf, count);
 	if (IS_ERR(h2c))
 		return -EFAULT;
@@ -3550,7 +3549,6 @@ rtw89_debug_priv_early_h2c_set(struct rtw89_dev *rtwdev,
 	early_h2c->h2c = h2c;
 	early_h2c->h2c_len = h2c_len;
 
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	list_add_tail(&early_h2c->list, &rtwdev->early_h2c_list);
 
 out:
@@ -3610,6 +3608,8 @@ rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
 	u8 crash_type;
 	int ret;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	ret = kstrtou8(buf, 0, &crash_type);
 	if (ret)
 		return -EINVAL;
@@ -3627,7 +3627,6 @@ rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
 		return -EINVAL;
 	}
 
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	set_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags);
 	ret = sim(rtwdev);
 
@@ -3671,10 +3670,11 @@ static ssize_t rtw89_debug_priv_fw_log_manual_set(struct rtw89_dev *rtwdev,
 	struct rtw89_fw_log *log = &rtwdev->fw.log;
 	bool fw_log_manual;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	if (kstrtobool(buf, &fw_log_manual))
 		goto out;
 
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	log->enable = fw_log_manual;
 	if (log->enable)
 		rtw89_fw_log_prepare(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c8843349b5e6..dedfd153207f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6009,13 +6009,13 @@ void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_early_h2c *early_h2c, *tmp;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	list_for_each_entry_safe(early_h2c, tmp, &rtwdev->early_h2c_list, list) {
 		list_del(&early_h2c->list);
 		kfree(early_h2c->h2c);
 		kfree(early_h2c);
 	}
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw89_fw_c2h_parse_attr(struct sk_buff *c2h)
@@ -6103,9 +6103,10 @@ void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work)
 						c2h_work);
 	struct sk_buff *skb, *tmp;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	skb_queue_walk_safe(&rtwdev->c2h_queue, skb, tmp) {
 		skb_unlink(skb, &rtwdev->c2h_queue);
-		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		rtw89_fw_c2h_cmd_handle(rtwdev, skb);
 		dev_kfree_skb_any(skb);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 11516ede13e4..778ca8589284 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -57,12 +57,10 @@ static void rtw89_ops_wake_tx_queue(struct ieee80211_hw *hw,
 static int rtw89_ops_start(struct ieee80211_hw *hw)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
-	ret = rtw89_core_start(rtwdev);
 
-	return ret;
+	return rtw89_core_start(rtwdev);
 }
 
 static void rtw89_ops_stop(struct ieee80211_hw *hw, bool suspend)
@@ -70,6 +68,7 @@ static void rtw89_ops_stop(struct ieee80211_hw *hw, bool suspend)
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_core_stop(rtwdev);
 }
 
@@ -77,10 +76,11 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	/* let previous ips work finish to ensure we don't leave ips twice */
 	wiphy_work_cancel(hw->wiphy, &rtwdev->ips_work);
 
-	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
 	if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
@@ -139,6 +139,7 @@ static void __rtw89_ops_remove_iface_link(struct rtw89_dev *rtwdev,
 					  struct rtw89_vif_link *rtwvif_link)
 {
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	wiphy_work_cancel(rtwdev->hw->wiphy, &rtwvif_link->update_beacon_work);
 
 	rtw89_leave_ps_mode(rtwdev);
@@ -157,11 +158,11 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	u8 mac_id, port;
 	int ret = 0;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "add vif %pM type %d, p2p %d\n",
 		    vif->addr, vif->type, vif->p2p);
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	rtw89_leave_ips_by_hwflags(rtwdev);
 
 	if (RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
@@ -169,10 +170,8 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 
 	mac_id = rtw89_acquire_mac_id(rtwdev);
-	if (mac_id == RTW89_MAX_MAC_ID_NUM) {
-		ret = -ENOSPC;
-		goto err;
-	}
+	if (mac_id == RTW89_MAX_MAC_ID_NUM)
+		return -ENOSPC;
 
 	port = rtw89_core_acquire_bit_map(rtwdev->hw_port, RTW89_PORT_NUM);
 	if (port == RTW89_PORT_NUM) {
@@ -217,7 +216,6 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtw89_core_release_bit_map(rtwdev->hw_port, port);
 release_macid:
 	rtw89_release_mac_id(rtwdev, mac_id);
-err:
 
 	return ret;
 }
@@ -231,13 +229,13 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 	u8 port = rtw89_vif_get_main_port(rtwvif);
 	struct rtw89_vif_link *rtwvif_link;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "remove vif %pM type %d p2p %d\n",
 		    vif->addr, vif->type, vif->p2p);
 
 	wiphy_delayed_work_cancel(hw->wiphy, &rtwvif->roc.roc_work);
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	rtwvif_link = rtwvif->links[RTW89_VIF_IDLE_LINK_ID];
 	if (unlikely(!rtwvif_link)) {
 		rtw89_err(rtwdev,
@@ -295,6 +293,7 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 	u32 rx_fltr;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 
 	*new_flags &= FIF_ALLMULTI | FIF_OTHER_BSS | FIF_FCSFAIL |
@@ -357,13 +356,11 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rx_fltr);
 	if (!rtwdev->dbcc_en)
-		goto out;
+		return;
 	rtw89_write32_mask(rtwdev,
 			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_1),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rx_fltr);
-
-out:
 }
 
 static const u8 ac_to_fw_idx[IEEE80211_NUM_ACS] = {
@@ -679,6 +676,7 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 
 	if (changed & BSS_CHANGED_ASSOC) {
@@ -713,6 +711,7 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 	struct rtw89_vif_link *rtwvif_link;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 
 	rtwvif_link = rtwvif->links[conf->link_id];
@@ -720,7 +719,7 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
 			  __func__, conf->link_id);
-		goto out;
+		return;
 	}
 
 	if (changed & BSS_CHANGED_BSSID) {
@@ -750,8 +749,6 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_TPE)
 		rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, true);
-
-out:
 }
 
 static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
@@ -771,14 +768,12 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
 			  __func__, link_conf->link_id);
-		ret = -ENOLINK;
-		goto out;
+		return -ENOLINK;
 	}
 
 	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
-	if (chan->band_type == RTW89_BAND_6G) {
+	if (chan->band_type == RTW89_BAND_6G)
 		return -EOPNOTSUPP;
-	}
 
 	if (rtwdev->scanning)
 		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
@@ -795,14 +790,12 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	if (RTW89_CHK_FW_FEATURE(NOTIFY_AP_INFO, &rtwdev->fw)) {
 		ret = rtw89_fw_h2c_ap_info_refcount(rtwdev, true);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	rtw89_queue_chanctx_work(rtwdev);
 
-out:
-
-	return ret;
+	return 0;
 }
 
 static
@@ -820,7 +813,7 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
 			  __func__, link_conf->link_id);
-		goto out;
+		return;
 	}
 
 	if (RTW89_CHK_FW_FEATURE(NOTIFY_AP_INFO, &rtwdev->fw))
@@ -829,8 +822,6 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	rtw89_mac_stop_ap(rtwdev, rtwvif_link);
 	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, NULL);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
-
-out:
 }
 
 static int rtw89_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -855,9 +846,9 @@ static int rtw89_ops_conf_tx(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
-	int ret = 0;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 
 	rtwvif_link = rtwvif->links[link_id];
@@ -865,16 +856,13 @@ static int rtw89_ops_conf_tx(struct ieee80211_hw *hw,
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
 			  __func__, link_id);
-		ret = -ENOLINK;
-		goto out;
+		return -ENOLINK;
 	}
 
 	rtwvif_link->tx_params[ac] = *params;
 	__rtw89_conf_tx(rtwdev, rtwvif_link, ac);
 
-out:
-
-	return ret;
+	return 0;
 }
 
 static int __rtw89_ops_sta_state(struct ieee80211_hw *hw,
@@ -918,13 +906,11 @@ static int rtw89_ops_sta_state(struct ieee80211_hw *hw,
 			       enum ieee80211_sta_state new_state)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
-	rtw89_leave_ps_mode(rtwdev);
-	ret = __rtw89_ops_sta_state(hw, vif, sta, old_state, new_state);
 
-	return ret;
+	rtw89_leave_ps_mode(rtwdev);
+	return __rtw89_ops_sta_state(hw, vif, sta, old_state, new_state);
 }
 
 static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
@@ -933,9 +919,10 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			     struct ieee80211_key_conf *key)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	int ret = 0;
+	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 
 	switch (cmd) {
@@ -944,7 +931,7 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		ret = rtw89_cam_sec_key_add(rtwdev, vif, sta, key);
 		if (ret && ret != -EOPNOTSUPP) {
 			rtw89_err(rtwdev, "failed to add key to sec cam\n");
-			goto out;
+			return ret;
 		}
 		break;
 	case DISABLE_KEY:
@@ -954,13 +941,11 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		ret = rtw89_cam_sec_key_del(rtwdev, vif, sta, key, true);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to remove key from sec cam\n");
-			goto out;
+			return ret;
 		}
 		break;
 	}
 
-out:
-
 	return ret;
 }
 
@@ -976,20 +961,20 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	struct ieee80211_txq *txq = sta->txq[tid];
 	struct rtw89_txq *rtwtxq = (struct rtw89_txq *)txq->drv_priv;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	switch (params->action) {
 	case IEEE80211_AMPDU_TX_START:
 		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
-		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		clear_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
 		clear_bit(tid, rtwsta->ampdu_map);
 		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, rtwvif, rtwsta);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
-		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		set_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
 		rtwsta->ampdu_params[tid].agg_num = params->buf_size;
 		rtwsta->ampdu_params[tid].amsdu = params->amsdu;
@@ -998,11 +983,9 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, rtwvif, rtwsta);
 		break;
 	case IEEE80211_AMPDU_RX_START:
-		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, true, params);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
-		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, false, params);
 		break;
 	default:
@@ -1018,6 +1001,7 @@ static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_leave_ps_mode(rtwdev);
 	if (test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
 		rtw89_mac_update_rts_threshold(rtwdev);
@@ -1061,6 +1045,7 @@ static void rtw89_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_leave_lps(rtwdev);
 	rtw89_hci_flush_queues(rtwdev, queues, drop);
 
@@ -1115,6 +1100,7 @@ static int rtw89_ops_set_bitrate_mask(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_phy_rate_pattern_vif(rtwdev, vif, mask);
 	rtw89_ra_mask_info_update(rtwdev, vif, mask);
 
@@ -1127,6 +1113,8 @@ int rtw89_ops_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (hal->ant_diversity) {
 		if (tx_ant != rx_ant || hweight32(tx_ant) != 1)
 			return -EINVAL;
@@ -1134,7 +1122,6 @@ int rtw89_ops_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 		return -EINVAL;
 	}
 
-	lockdep_assert_wiphy(hw->wiphy);
 	hal->antenna_tx = tx_ant;
 	hal->antenna_rx = rx_ant;
 	hal->tx_path_diversity = false;
@@ -1168,12 +1155,10 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 	if (unlikely(!rtwvif_link)) {
 		rtw89_err(rtwdev, "sw scan start: find no link on HW-0\n");
-		goto out;
+		return;
 	}
 
 	rtw89_core_scan_start(rtwdev, rtwvif_link, mac_addr, false);
-
-out:
 }
 
 static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
@@ -1188,12 +1173,10 @@ static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
 	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 	if (unlikely(!rtwvif_link)) {
 		rtw89_err(rtwdev, "sw scan complete: find no link on HW-0\n");
-		goto out;
+		return;
 	}
 
 	rtw89_core_scan_complete(rtwdev, rtwvif_link, false);
-
-out:
 }
 
 static void rtw89_ops_reconfig_complete(struct ieee80211_hw *hw,
@@ -1213,21 +1196,18 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct rtw89_vif_link *rtwvif_link;
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return 1;
 
-	lockdep_assert_wiphy(hw->wiphy);
-
-	if (rtwdev->scanning || rtwvif->offchan) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (rtwdev->scanning || rtwvif->offchan)
+		return -EBUSY;
 
 	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 	if (unlikely(!rtwvif_link)) {
 		rtw89_err(rtwdev, "hw scan: find no link on HW-0\n");
-		ret = -ENOLINK;
-		goto out;
+		return -ENOLINK;
 	}
 
 	rtw89_hw_scan_start(rtwdev, rtwvif_link, req);
@@ -1237,8 +1217,6 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		rtw89_err(rtwdev, "HW scan failed with status: %d\n", ret);
 	}
 
-out:
-
 	return ret;
 }
 
@@ -1249,23 +1227,21 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return;
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	if (!rtwdev->scanning)
-		goto out;
+		return;
 
 	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 	if (unlikely(!rtwvif_link)) {
 		rtw89_err(rtwdev, "cancel hw scan: find no link on HW-0\n");
-		goto out;
+		return;
 	}
 
 	rtw89_hw_scan_abort(rtwdev, rtwvif_link);
-
-out:
 }
 
 static void rtw89_ops_sta_rc_update(struct ieee80211_hw *hw,
@@ -1288,12 +1264,10 @@ static int rtw89_ops_add_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
-	ret = rtw89_chanctx_ops_add(rtwdev, ctx);
 
-	return ret;
+	return rtw89_chanctx_ops_add(rtwdev, ctx);
 }
 
 static void rtw89_ops_remove_chanctx(struct ieee80211_hw *hw,
@@ -1302,6 +1276,7 @@ static void rtw89_ops_remove_chanctx(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_chanctx_ops_remove(rtwdev, ctx);
 }
 
@@ -1312,6 +1287,7 @@ static void rtw89_ops_change_chanctx(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	rtw89_chanctx_ops_change(rtwdev, ctx, changed);
 }
 
@@ -1323,7 +1299,6 @@ static int rtw89_ops_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
-	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
@@ -1332,15 +1307,10 @@ static int rtw89_ops_assign_vif_chanctx(struct ieee80211_hw *hw,
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
 			  __func__, link_conf->link_id);
-		ret = -ENOLINK;
-		goto out;
+		return -ENOLINK;
 	}
 
-	ret = rtw89_chanctx_ops_assign_vif(rtwdev, rtwvif_link, ctx);
-
-out:
-
-	return ret;
+	return rtw89_chanctx_ops_assign_vif(rtwdev, rtwvif_link, ctx);
 }
 
 static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
@@ -1375,11 +1345,11 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 	struct rtw89_roc *roc = &rtwvif->roc;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (!rtwvif)
 		return -EINVAL;
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	if (roc->state != RTW89_ROC_IDLE) {
 		return -EBUSY;
 	}
@@ -1407,12 +1377,13 @@ static int rtw89_ops_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (!rtwvif)
 		return -EINVAL;
 
 	wiphy_delayed_work_cancel(hw->wiphy, &rtwvif->roc.roc_work);
 
-	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_roc_end(rtwdev, rtwvif);
 
 	return 0;
@@ -1435,6 +1406,7 @@ static int rtw89_ops_set_tid_config(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	if (sta)
 		rtw89_core_set_tid_config(rtwdev, sta, tid_config);
 	else
@@ -1705,12 +1677,12 @@ static int rtw89_ops_suspend(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	set_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
 	wiphy_delayed_work_cancel(hw->wiphy, &rtwdev->track_work);
 
-	lockdep_assert_wiphy(hw->wiphy);
 	ret = rtw89_wow_suspend(rtwdev, wowlan);
-
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to suspend for wow %d\n", ret);
 		clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
@@ -1726,6 +1698,7 @@ static int rtw89_ops_resume(struct ieee80211_hw *hw)
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
+
 	ret = rtw89_wow_resume(rtwdev);
 	if (ret)
 		rtw89_warn(rtwdev, "failed to resume for wow %d\n", ret);
@@ -1752,14 +1725,14 @@ static void rtw89_set_rekey_data(struct ieee80211_hw *hw,
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_gtk_info *gtk_info = &rtw_wow->gtk_info;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (data->kek_len > sizeof(gtk_info->kek) ||
 	    data->kck_len > sizeof(gtk_info->kck)) {
 		rtw89_warn(rtwdev, "kek or kck length over fw limit\n");
 		return;
 	}
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	memcpy(gtk_info->kek, data->kek, data->kek_len);
 	memcpy(gtk_info->kck, data->kck, data->kck_len);
 }
@@ -1773,11 +1746,9 @@ static void rtw89_ops_rfkill_poll(struct ieee80211_hw *hw)
 
 	/* wl_disable GPIO get floating when entering LPS */
 	if (test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
-		goto out;
+		return;
 
 	rtw89_core_rfkill_poll(rtwdev, false);
-
-out:
 }
 
 const struct ieee80211_ops rtw89_ops = {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 26370eadf77f..e4b690a5febc 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4662,13 +4662,13 @@ void rtw89_phy_cfo_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
 
 	lockdep_assert_wiphy(wiphy);
+
 	if (!cfo->cfo_trig_by_timer_en)
-		goto out;
+		return;
 	rtw89_leave_ps_mode(rtwdev);
 	rtw89_phy_cfo_dm(rtwdev);
 	wiphy_delayed_work_queue(wiphy, &rtwdev->cfo_track_work,
 				 msecs_to_jiffies(cfo->cfo_timer_ms));
-out:
 }
 
 static void rtw89_phy_cfo_start_work(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index ccac7eb1bd0f..d6fb06ec4ecc 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -721,7 +721,6 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	wiphy_lock(wiphy);
-	lockdep_assert_wiphy(wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
 	if (wiphy->regd) {
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 949edb4bd4df..24a32dc4e67d 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -99,7 +99,7 @@ struct rtw89_sar_handler rtw89_sar_handlers[RTW89_SAR_SOURCE_NR] = {
 		typeof(_dev) _d = (_dev);				\
 		BUILD_BUG_ON(!rtw89_sar_handlers[_s].descr_sar_source);	\
 		BUILD_BUG_ON(!rtw89_sar_handlers[_s].query_sar_config);	\
-		lockdep_assert_held(&_d->mutex);			\
+		lockdep_assert_wiphy(_d->hw->wiphy);			\
 		_d->sar._cfg_name = *(_cfg_data);			\
 		_d->sar.src = _s;					\
 	} while (0)
@@ -239,22 +239,19 @@ static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
 				  const struct rtw89_sar_cfg_common *sar)
 {
 	enum rtw89_sar_sources src;
-	int ret = 0;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	src = rtwdev->sar.src;
 	if (src != RTW89_SAR_SOURCE_NONE && src != RTW89_SAR_SOURCE_COMMON) {
 		rtw89_warn(rtwdev, "SAR source: %d is in use", src);
-		ret = -EBUSY;
-		goto exit;
+		return -EBUSY;
 	}
 
 	rtw89_sar_set_src(rtwdev, RTW89_SAR_SOURCE_COMMON, cfg_common, sar);
 	rtw89_core_set_chip_txpwr(rtwdev);
 
-exit:
-	return ret;
+	return 0;
 }
 
 static const struct cfg80211_sar_freq_ranges rtw89_common_sar_freq_ranges[] = {
@@ -290,6 +287,8 @@ int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 	s32 power;
 	u32 i, idx;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	if (sar->type != NL80211_SAR_TYPE_POWER)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index b9607bdca6c8..0740e303680c 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -157,7 +157,6 @@ static void ser_state_run(struct rtw89_ser *ser, u8 evt)
 		    ser_st_name(ser), ser_ev_name(ser, evt));
 
 	wiphy_lock(rtwdev->hw->wiphy);
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	rtw89_leave_lps(rtwdev);
 	wiphy_unlock(rtwdev->hw->wiphy);
 
@@ -713,7 +712,6 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 	switch (evt) {
 	case SER_EV_STATE_IN:
 		wiphy_lock(rtwdev->hw->wiphy);
-		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		ser_l2_reset_st_pre_hdl(ser);
 		wiphy_unlock(rtwdev->hw->wiphy);
 
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index df283a858046..80441e8da60b 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -12,7 +12,7 @@
 	ieee80211_iterate_active_interfaces_atomic((rtwdev)->hw,               \
 			IEEE80211_IFACE_ITER_NORMAL, iterator, data)
 
-/* call this function with rtwdev->mutex is held */
+/* call this function with wiphy mutex is held */
 #define rtw89_for_each_rtwvif(rtwdev, rtwvif)				       \
 	list_for_each_entry(rtwvif, &(rtwdev)->rtwvifs_list, list)
 
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 6031633b2709..17eee58503cb 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -604,6 +604,8 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
 	struct ieee80211_key_conf *key;
 	u8 sz;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	cipher_info = rtw89_cipher_alg_recognize(cipher);
 	sz = struct_size(rekey_conf, key, cipher_info->len);
 	rekey_conf = kmalloc(sz, GFP_KERNEL);
@@ -616,10 +618,6 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
 	memcpy(rekey_conf->key, gtk,
 	       flex_array_size(rekey_conf, key, cipher_info->len));
 
-	/* ieee80211_gtk_rekey_add() will call set_key(), therefore we
-	 * need to unlock mutex
-	 */
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	if (ieee80211_vif_is_mld(wow_vif))
 		key = ieee80211_gtk_rekey_add(wow_vif, rekey_conf, rtwvif_link->link_id);
 	else
-- 
2.25.1


