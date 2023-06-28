Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B1740AEA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjF1INw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 04:13:52 -0400
Received: from forward203a.mail.yandex.net ([178.154.239.90]:57330 "EHLO
        forward203a.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233410AbjF1ILt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 04:11:49 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by forward203a.mail.yandex.net (Yandex) with ESMTP id 7C1D447F5C
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jun 2023 10:24:07 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id AE54E46D28;
        Wed, 28 Jun 2023 10:24:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uNGuVj7DSKo0-PKBqK195;
        Wed, 28 Jun 2023 10:24:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687937044;
        bh=+QkQHSSaQqWvRhh1EIG13aSRbHW8RnMvACBu9vM6rpk=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=bnnUgi1mOEW4K6SBVrcVkkDjNE2mKst7EdVF5y0ByfxgBqoGlGr/24dM5wKEFWDN0
         vlfKnSxwgPIbRDDIbN5dv9CcsSNBgT1KbwWkmY2Ubqk294EPLYLJZXDEqXhTM2vks+
         c/+8WZrieDlBP+EGEeiixJMbB/AAP4iqMaXyPf2M=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Po-Hao Huang <phhuang@realtek.com>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 4/4] [v6] wifi: rtw88: simplify vif iterators
Date:   Wed, 28 Jun 2023 10:23:18 +0300
Message-ID: <20230628072327.167196-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628072327.167196-1-dmantipov@yandex.ru>
References: <20230628072327.167196-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since all iterators called by 'rtw_iterate_vifs()' never uses
'mac' argument, it may be omitted, and 'struct rtw_vifs_entry'
may be simplified accordingly.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v6: adjust to match series
---
 drivers/net/wireless/realtek/rtw88/fw.c   | 2 +-
 drivers/net/wireless/realtek/rtw88/main.c | 8 +++-----
 drivers/net/wireless/realtek/rtw88/ps.c   | 6 ++----
 drivers/net/wireless/realtek/rtw88/util.c | 7 ++-----
 drivers/net/wireless/realtek/rtw88/util.h | 3 +--
 5 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 567bbedd8ee0..a1b674e3caaa 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -140,7 +140,7 @@ struct rtw_beacon_filter_iter_data {
 	u8 *payload;
 };
 
-static void rtw_fw_bcn_filter_notify_vif_iter(void *data, u8 *mac,
+static void rtw_fw_bcn_filter_notify_vif_iter(void *data,
 					      struct ieee80211_vif *vif)
 {
 	struct rtw_beacon_filter_iter_data *iter_data = data;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 935022246fd4..4a33d2e47f33 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -185,8 +185,7 @@ static void rtw_dynamic_csi_rate(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
 		bf_info->cur_csi_rpt_rate = new_csi_rate_idx;
 }
 
-static void rtw_vif_watch_dog_iter(void *data, u8 *mac,
-				   struct ieee80211_vif *vif)
+static void rtw_vif_watch_dog_iter(void *data, struct ieee80211_vif *vif)
 {
 	struct rtw_watch_dog_iter_data *iter_data = data;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
@@ -2330,7 +2329,7 @@ struct rtw_iter_port_switch_data {
 	struct rtw_vif *rtwvif_ap;
 };
 
-static void rtw_port_switch_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+static void rtw_port_switch_iter(void *data, struct ieee80211_vif *vif)
 {
 	struct rtw_iter_port_switch_data *iter_data = data;
 	struct rtw_dev *rtwdev = iter_data->rtwdev;
@@ -2382,8 +2381,7 @@ void rtw_core_port_switch(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
 	rtw_iterate_vifs(rtwdev, rtw_port_switch_iter, &iter_data);
 }
 
-static void rtw_check_sta_active_iter(void *data, u8 *mac,
-				      struct ieee80211_vif *vif)
+static void rtw_check_sta_active_iter(void *data, struct ieee80211_vif *vif)
 {
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	bool *active = data;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 43e80a3a8136..07e8cbd436cd 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -37,8 +37,7 @@ int rtw_enter_ips(struct rtw_dev *rtwdev)
 	return 0;
 }
 
-static void rtw_restore_port_cfg_iter(void *data, u8 *mac,
-				      struct ieee80211_vif *vif)
+static void rtw_restore_port_cfg_iter(void *data, struct ieee80211_vif *vif)
 {
 	struct rtw_dev *rtwdev = data;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
@@ -320,8 +319,7 @@ static void __rtw_vif_recalc_lps(struct rtw_vif_recalc_lps_iter_data *data,
 	data->found_vif = vif;
 }
 
-static void rtw_vif_recalc_lps_iter(void *data, u8 *mac,
-				    struct ieee80211_vif *vif)
+static void rtw_vif_recalc_lps_iter(void *data, struct ieee80211_vif *vif)
 {
 	__rtw_vif_recalc_lps(data, vif);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index ff3c269fb1a7..e222d3c01a77 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -159,7 +159,6 @@ void rtw_iterate_stas(struct rtw_dev *rtwdev,
 struct rtw_vifs_entry {
 	struct list_head list;
 	struct ieee80211_vif *vif;
-	u8 mac[ETH_ALEN];
 };
 
 struct rtw_iter_vifs_data {
@@ -177,13 +176,11 @@ static void rtw_collect_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 		return;
 
 	vifs_entry->vif = vif;
-	ether_addr_copy(vifs_entry->mac, mac);
 	list_add_tail(&vifs_entry->list, &iter_stas->list);
 }
 
 void rtw_iterate_vifs(struct rtw_dev *rtwdev,
-		      void (*iterator)(void *data, u8 *mac,
-				       struct ieee80211_vif *vif),
+		      void (*iterator)(void *data, struct ieee80211_vif *vif),
 		      void *data)
 {
 	struct rtw_iter_vifs_data iter_data;
@@ -204,7 +201,7 @@ void rtw_iterate_vifs(struct rtw_dev *rtwdev,
 	list_for_each_entry_safe(vif_entry, tmp, &iter_data.list,
 				 list) {
 		list_del_init(&vif_entry->list);
-		iterator(data, vif_entry->mac, vif_entry->vif);
+		iterator(data, vif_entry->vif);
 		kfree(vif_entry);
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtw88/util.h b/drivers/net/wireless/realtek/rtw88/util.h
index dc8965525400..f8399128a9a3 100644
--- a/drivers/net/wireless/realtek/rtw88/util.h
+++ b/drivers/net/wireless/realtek/rtw88/util.h
@@ -18,8 +18,7 @@ struct rtw_dev;
 	ieee80211_iter_keys_rcu((rtwdev)->hw, vif, iterator, data)
 
 void rtw_iterate_vifs(struct rtw_dev *rtwdev,
-		      void (*iterator)(void *data, u8 *mac,
-				       struct ieee80211_vif *vif),
+		      void (*iterator)(void *data, struct ieee80211_vif *vif),
 		      void *data);
 void rtw_iterate_stas(struct rtw_dev *rtwdev,
 		      void (*iterator)(void *data,
-- 
2.41.0

