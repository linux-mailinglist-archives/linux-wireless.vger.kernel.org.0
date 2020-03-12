Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A2F182A93
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 09:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCLIJD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 04:09:03 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59242 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCLIJC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 04:09:02 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02C88tVI006441, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02C88tVI006441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 16:08:55 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 3/5] rtw88: associate reserved pages with each vif
Date:   Thu, 12 Mar 2020 16:08:50 +0800
Message-ID: <20200312080852.16684-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312080852.16684-1-yhchuang@realtek.com>
References: <20200312080852.16684-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Each device has only one reserved page shared with all of the
vifs, so it seems not reasonable to pass vif as one of the
arguments to rtw_fw_download_rsvd_page(). If driver is going
to run more than one vif, the content of reserved page could
not be built for all of the vifs.

To fix it, let each vif maintain its own reserved page list,
and build the final reserved page to download to the firmware
from all of the vifs. Hence driver should add reserved pages
to each vif according to the vif->type when adding the vif.

For station mode, add reserved page with rtw_add_rsvd_page_sta().
If the station mode is going to suspend in PNO (net-detect)
mode, remove the reserved pages used for normal mode, and add
new one for wowlan mode with rtw_add_rsvd_page_pno().

For beacon mode, only beacon is required to be added using
rtw_add_rsvd_page_bcn().

This would make the code flow simpler as we don't need to
add reserved pages when vif is running, just add/remove them
when ieee80211_ops::[add|remove]_interface.

When driver is going to download the reserved page, it will
collect pages from all of the vifs, this list is maintained
by rtwdev, with build_list as the pages' member. That way, we
can still build a list of reserved pages to be downloaded.
Also we can get the location of the pages from the list that
is maintained by rtwdev.

The biggest problem is that the first page should always be
beacon, if other type of reserved page is put in the first
page, the tx descriptor and offset could be wrong.
But station mode vif does not add beacon into its list, so
we need to add a dummy page in front of the list, to make
sure other pages will not be put in the first page. As the
dummy page is allocated when building the list, we must free
it before building a new list of reserved pages to firmware.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 265 ++++++++++++++----
 drivers/net/wireless/realtek/rtw88/fw.h       |  25 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  22 +-
 drivers/net/wireless/realtek/rtw88/main.c     |   9 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   1 +
 drivers/net/wireless/realtek/rtw88/wow.c      |  39 +--
 6 files changed, 258 insertions(+), 103 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 6867bf29d4c8..05c430b3489c 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -583,7 +583,7 @@ static u8 rtw_get_rsvd_page_location(struct rtw_dev *rtwdev,
 	struct rtw_rsvd_page *rsvd_pkt;
 	u8 location = 0;
 
-	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
+	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, build_list) {
 		if (type == rsvd_pkt->type)
 			location = rsvd_pkt->page;
 	}
@@ -636,7 +636,7 @@ u8 rtw_get_rsvd_page_probe_req_location(struct rtw_dev *rtwdev,
 	struct rtw_rsvd_page *rsvd_pkt;
 	u8 location = 0;
 
-	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
+	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, build_list) {
 		if (rsvd_pkt->type != RSVD_PROBE_REQ)
 			continue;
 		if ((!ssid && !rsvd_pkt->ssid) ||
@@ -653,7 +653,7 @@ u16 rtw_get_rsvd_page_probe_req_size(struct rtw_dev *rtwdev,
 	struct rtw_rsvd_page *rsvd_pkt;
 	u16 size = 0;
 
-	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
+	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, build_list) {
 		if (rsvd_pkt->type != RSVD_PROBE_REQ)
 			continue;
 		if ((!ssid && !rsvd_pkt->ssid) ||
@@ -690,25 +690,6 @@ void rtw_send_rsvd_page_h2c(struct rtw_dev *rtwdev)
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
-static struct sk_buff *
-rtw_beacon_get(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
-{
-	struct sk_buff *skb_new;
-
-	if (vif->type != NL80211_IFTYPE_AP &&
-	    vif->type != NL80211_IFTYPE_ADHOC &&
-	    !ieee80211_vif_is_mesh(vif)) {
-		skb_new = alloc_skb(1, GFP_KERNEL);
-		if (!skb_new)
-			return NULL;
-		skb_put(skb_new, 1);
-	} else {
-		skb_new = ieee80211_beacon_get(hw, vif);
-	}
-
-	return skb_new;
-}
-
 static struct sk_buff *rtw_nlo_info_get(struct ieee80211_hw *hw)
 {
 	struct rtw_dev *rtwdev = hw->priv;
@@ -853,15 +834,31 @@ static struct sk_buff *rtw_lps_pg_info_get(struct ieee80211_hw *hw)
 }
 
 static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
-					     struct ieee80211_vif *vif,
 					     struct rtw_rsvd_page *rsvd_pkt)
 {
+	struct ieee80211_vif *vif;
+	struct rtw_vif *rtwvif;
 	struct sk_buff *skb_new;
 	struct cfg80211_ssid *ssid;
 
+	if (rsvd_pkt->type == RSVD_DUMMY) {
+		skb_new = alloc_skb(1, GFP_KERNEL);
+		if (!skb_new)
+			return NULL;
+
+		skb_put(skb_new, 1);
+		return skb_new;
+	}
+
+	rtwvif = rsvd_pkt->rtwvif;
+	if (!rtwvif)
+		return NULL;
+
+	vif = rtwvif_to_vif(rtwvif);
+
 	switch (rsvd_pkt->type) {
 	case RSVD_BEACON:
-		skb_new = rtw_beacon_get(hw, vif);
+		skb_new = ieee80211_beacon_get(hw, vif);
 		break;
 	case RSVD_PS_POLL:
 		skb_new = ieee80211_pspoll_get(hw, vif);
@@ -948,6 +945,8 @@ static struct rtw_rsvd_page *rtw_alloc_rsvd_page(struct rtw_dev *rtwdev,
 	if (!rsvd_pkt)
 		return NULL;
 
+	INIT_LIST_HEAD(&rsvd_pkt->vif_list);
+	INIT_LIST_HEAD(&rsvd_pkt->build_list);
 	rsvd_pkt->type = type;
 	rsvd_pkt->add_txdesc = txdesc;
 
@@ -955,51 +954,124 @@ static struct rtw_rsvd_page *rtw_alloc_rsvd_page(struct rtw_dev *rtwdev,
 }
 
 static void rtw_insert_rsvd_page(struct rtw_dev *rtwdev,
+				 struct rtw_vif *rtwvif,
 				 struct rtw_rsvd_page *rsvd_pkt)
 {
 	lockdep_assert_held(&rtwdev->mutex);
-	list_add_tail(&rsvd_pkt->list, &rtwdev->rsvd_page_list);
+
+	list_add_tail(&rsvd_pkt->vif_list, &rtwvif->rsvd_page_list);
 }
 
-void rtw_add_rsvd_page(struct rtw_dev *rtwdev, enum rtw_rsvd_packet_type type,
-		       bool txdesc)
+static void rtw_add_rsvd_page(struct rtw_dev *rtwdev,
+			      struct rtw_vif *rtwvif,
+			      enum rtw_rsvd_packet_type type,
+			      bool txdesc)
 {
 	struct rtw_rsvd_page *rsvd_pkt;
 
 	rsvd_pkt = rtw_alloc_rsvd_page(rtwdev, type, txdesc);
-	if (!rsvd_pkt)
+	if (!rsvd_pkt) {
+		rtw_err(rtwdev, "failed to alloc rsvd page %d\n", type);
 		return;
+	}
 
-	rtw_insert_rsvd_page(rtwdev, rsvd_pkt);
+	rsvd_pkt->rtwvif = rtwvif;
+	rtw_insert_rsvd_page(rtwdev, rtwvif, rsvd_pkt);
 }
 
-void rtw_add_rsvd_page_probe_req(struct rtw_dev *rtwdev,
-				 struct cfg80211_ssid *ssid)
+static void rtw_add_rsvd_page_probe_req(struct rtw_dev *rtwdev,
+					struct rtw_vif *rtwvif,
+					struct cfg80211_ssid *ssid)
 {
 	struct rtw_rsvd_page *rsvd_pkt;
 
 	rsvd_pkt = rtw_alloc_rsvd_page(rtwdev, RSVD_PROBE_REQ, true);
-	if (!rsvd_pkt)
+	if (!rsvd_pkt) {
+		rtw_err(rtwdev, "failed to alloc probe req rsvd page\n");
 		return;
+	}
 
+	rsvd_pkt->rtwvif = rtwvif;
 	rsvd_pkt->ssid = ssid;
-	rtw_insert_rsvd_page(rtwdev, rsvd_pkt);
+	rtw_insert_rsvd_page(rtwdev, rtwvif, rsvd_pkt);
 }
 
-void rtw_reset_rsvd_page(struct rtw_dev *rtwdev)
+void rtw_remove_rsvd_page(struct rtw_dev *rtwdev,
+			  struct rtw_vif *rtwvif)
 {
 	struct rtw_rsvd_page *rsvd_pkt, *tmp;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
-	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list, list) {
-		if (rsvd_pkt->type == RSVD_BEACON)
-			continue;
-		list_del(&rsvd_pkt->list);
+	/* remove all of the rsvd pages for vif */
+	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwvif->rsvd_page_list,
+				 vif_list) {
+		list_del(&rsvd_pkt->vif_list);
+		if (!list_empty(&rsvd_pkt->build_list))
+			list_del(&rsvd_pkt->build_list);
 		kfree(rsvd_pkt);
 	}
 }
 
+void rtw_add_rsvd_page_bcn(struct rtw_dev *rtwdev,
+			   struct rtw_vif *rtwvif)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+
+	if (vif->type != NL80211_IFTYPE_AP &&
+	    vif->type != NL80211_IFTYPE_ADHOC &&
+	    vif->type != NL80211_IFTYPE_MESH_POINT) {
+		rtw_warn(rtwdev, "Cannot add beacon rsvd page for %d\n",
+			 vif->type);
+		return;
+	}
+
+	rtw_add_rsvd_page(rtwdev, rtwvif, RSVD_BEACON, false);
+}
+
+void rtw_add_rsvd_page_pno(struct rtw_dev *rtwdev,
+			   struct rtw_vif *rtwvif)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw_pno_request *rtw_pno_req = &rtw_wow->pno_req;
+	struct cfg80211_ssid *ssid;
+	int i;
+
+	if (vif->type != NL80211_IFTYPE_STATION) {
+		rtw_warn(rtwdev, "Cannot add PNO rsvd page for %d\n",
+			 vif->type);
+		return;
+	}
+
+	for (i = 0 ; i < rtw_pno_req->match_set_cnt; i++) {
+		ssid = &rtw_pno_req->match_sets[i].ssid;
+		rtw_add_rsvd_page_probe_req(rtwdev, rtwvif, ssid);
+	}
+
+	rtw_add_rsvd_page_probe_req(rtwdev, rtwvif, NULL);
+	rtw_add_rsvd_page(rtwdev, rtwvif, RSVD_NLO_INFO, false);
+	rtw_add_rsvd_page(rtwdev, rtwvif, RSVD_CH_INFO, true);
+}
+
+void rtw_add_rsvd_page_sta(struct rtw_dev *rtwdev,
+			   struct rtw_vif *rtwvif)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+
+	if (vif->type != NL80211_IFTYPE_STATION) {
+		rtw_warn(rtwdev, "Cannot add sta rsvd page for %d\n",
+			 vif->type);
+		return;
+	}
+
+	rtw_add_rsvd_page(rtwdev, rtwvif, RSVD_PS_POLL, true);
+	rtw_add_rsvd_page(rtwdev, rtwvif, RSVD_QOS_NULL, true);
+	rtw_add_rsvd_page(rtwdev, rtwvif, RSVD_NULL, true);
+	rtw_add_rsvd_page(rtwdev, rtwvif, RSVD_LPS_PG_DPK, true);
+	rtw_add_rsvd_page(rtwdev, rtwvif, RSVD_LPS_PG_INFO, true);
+}
+
 int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 				u8 *buf, u32 size)
 {
@@ -1063,8 +1135,72 @@ static int rtw_download_drv_rsvd_page(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 	return rtw_fw_write_data_rsvd_page(rtwdev, pg_addr, buf, size);
 }
 
-static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
-			       struct ieee80211_vif *vif, u32 *size)
+static void __rtw_build_rsvd_page_reset(struct rtw_dev *rtwdev)
+{
+	struct rtw_rsvd_page *rsvd_pkt, *tmp;
+
+	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list,
+				 build_list) {
+		list_del_init(&rsvd_pkt->build_list);
+
+		/* Don't free except for the dummy rsvd page,
+		 * others will be freed when removing vif
+		 */
+		if (rsvd_pkt->type == RSVD_DUMMY)
+			kfree(rsvd_pkt);
+	}
+}
+
+static void rtw_build_rsvd_page_iter(void *data, u8 *mac,
+				     struct ieee80211_vif *vif)
+{
+	struct rtw_dev *rtwdev = data;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_rsvd_page *rsvd_pkt;
+
+	list_for_each_entry(rsvd_pkt, &rtwvif->rsvd_page_list, vif_list) {
+		if (rsvd_pkt->type == RSVD_BEACON)
+			list_add(&rsvd_pkt->build_list,
+				 &rtwdev->rsvd_page_list);
+		else
+			list_add_tail(&rsvd_pkt->build_list,
+				      &rtwdev->rsvd_page_list);
+	}
+}
+
+static int  __rtw_build_rsvd_page_from_vifs(struct rtw_dev *rtwdev)
+{
+	struct rtw_rsvd_page *rsvd_pkt;
+
+	__rtw_build_rsvd_page_reset(rtwdev);
+
+	/* gather rsvd page from vifs */
+	rtw_iterate_vifs_atomic(rtwdev, rtw_build_rsvd_page_iter, rtwdev);
+
+	rsvd_pkt = list_first_entry_or_null(&rtwdev->rsvd_page_list,
+					    struct rtw_rsvd_page, build_list);
+	if (!rsvd_pkt) {
+		WARN(1, "Should not have an empty reserved page\n");
+		return -EINVAL;
+	}
+
+	/* the first rsvd should be beacon, otherwise add a dummy one */
+	if (rsvd_pkt->type != RSVD_BEACON) {
+		struct rtw_rsvd_page *dummy_pkt;
+
+		dummy_pkt = rtw_alloc_rsvd_page(rtwdev, RSVD_DUMMY, false);
+		if (!dummy_pkt) {
+			rtw_err(rtwdev, "failed to alloc dummy rsvd page\n");
+			return -ENOMEM;
+		}
+
+		list_add(&dummy_pkt->build_list, &rtwdev->rsvd_page_list);
+	}
+
+	return 0;
+}
+
+static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev, u32 *size)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -1074,13 +1210,21 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
 	u8 total_page = 0;
 	u8 page_size, page_margin, tx_desc_sz;
 	u8 *buf;
+	int ret;
 
 	page_size = chip->page_size;
 	tx_desc_sz = chip->tx_pkt_desc_sz;
 	page_margin = page_size - tx_desc_sz;
 
-	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
-		iter = rtw_get_rsvd_page_skb(hw, vif, rsvd_pkt);
+	ret = __rtw_build_rsvd_page_from_vifs(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev,
+			"failed to build rsvd page from vifs, ret %d\n", ret);
+		return NULL;
+	}
+
+	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, build_list) {
+		iter = rtw_get_rsvd_page_skb(hw, rsvd_pkt);
 		if (!iter) {
 			rtw_err(rtwdev, "failed to build rsvd packet\n");
 			goto release_skb;
@@ -1104,7 +1248,8 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
 		 * is smaller than the actual size of the whole rsvd_page
 		 */
 		if (total_page == 0) {
-			if (rsvd_pkt->type != RSVD_BEACON) {
+			if (rsvd_pkt->type != RSVD_BEACON &&
+			    rsvd_pkt->type != RSVD_DUMMY) {
 				rtw_err(rtwdev, "first page should be a beacon\n");
 				goto release_skb;
 			}
@@ -1132,7 +1277,7 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
 	 * And that rsvd_pkt does not require tx_desc because when it goes
 	 * through TX path, the TX path will generate one for it.
 	 */
-	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
+	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, build_list) {
 		rtw_rsvd_page_list_to_buf(rtwdev, page_size, page_margin,
 					  page, buf, rsvd_pkt);
 		if (page == 0)
@@ -1148,7 +1293,7 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
 	return buf;
 
 release_skb:
-	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
+	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, build_list) {
 		kfree_skb(rsvd_pkt->skb);
 		rsvd_pkt->skb = NULL;
 	}
@@ -1156,18 +1301,31 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
 	return NULL;
 }
 
-static int
-rtw_download_beacon(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
+static int rtw_download_beacon(struct rtw_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
+	struct rtw_rsvd_page *rsvd_pkt;
 	struct sk_buff *skb;
 	int ret = 0;
 
-	skb = rtw_beacon_get(hw, vif);
+	rsvd_pkt = list_first_entry_or_null(&rtwdev->rsvd_page_list,
+					    struct rtw_rsvd_page, build_list);
+	if (!rsvd_pkt) {
+		rtw_err(rtwdev, "failed to get rsvd page from build list\n");
+		return -ENOENT;
+	}
+
+	if (rsvd_pkt->type != RSVD_BEACON &&
+	    rsvd_pkt->type != RSVD_DUMMY) {
+		rtw_err(rtwdev, "invalid rsvd page type %d, should be beacon or dummy\n",
+			rsvd_pkt->type);
+		return -EINVAL;
+	}
+
+	skb = rtw_get_rsvd_page_skb(hw, rsvd_pkt);
 	if (!skb) {
 		rtw_err(rtwdev, "failed to get beacon skb\n");
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	ret = rtw_download_drv_rsvd_page(rtwdev, skb->data, skb->len);
@@ -1176,17 +1334,16 @@ rtw_download_beacon(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
 
 	dev_kfree_skb(skb);
 
-out:
 	return ret;
 }
 
-int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
+int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev)
 {
 	u8 *buf;
 	u32 size;
 	int ret;
 
-	buf = rtw_build_rsvd_page(rtwdev, vif, &size);
+	buf = rtw_build_rsvd_page(rtwdev, &size);
 	if (!buf) {
 		rtw_err(rtwdev, "failed to build rsvd page pkt\n");
 		return -ENOMEM;
@@ -1203,7 +1360,7 @@ int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
 	 * the beacon again to replace the TX desc header, and we will get
 	 * a correct tx_desc for the beacon in the rsvd page.
 	 */
-	ret = rtw_download_beacon(rtwdev, vif);
+	ret = rtw_download_beacon(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to download beacon\n");
 		goto free;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index ccd27bd45775..d507a954e701 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -41,6 +41,7 @@ struct rtw_c2h_cmd {
 
 enum rtw_rsvd_packet_type {
 	RSVD_BEACON,
+	RSVD_DUMMY,
 	RSVD_PS_POLL,
 	RSVD_PROBE_RESP,
 	RSVD_NULL,
@@ -98,7 +99,13 @@ struct rtw_lps_pg_info_hdr {
 } __packed;
 
 struct rtw_rsvd_page {
-	struct list_head list;
+	/* associated with each vif */
+	struct list_head vif_list;
+	struct rtw_vif *rtwvif;
+
+	/* associated when build rsvd page */
+	struct list_head build_list;
+
 	struct sk_buff *skb;
 	enum rtw_rsvd_packet_type type;
 	u8 page;
@@ -502,15 +509,17 @@ void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data);
 void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool conn);
-void rtw_add_rsvd_page(struct rtw_dev *rtwdev, enum rtw_rsvd_packet_type type,
-		       bool txdesc);
-void rtw_add_rsvd_page_probe_req(struct rtw_dev *rtwdev,
-				 struct cfg80211_ssid *ssid);
 int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 				u8 *buf, u32 size);
-void rtw_reset_rsvd_page(struct rtw_dev *rtwdev);
-int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev,
-			      struct ieee80211_vif *vif);
+void rtw_remove_rsvd_page(struct rtw_dev *rtwdev,
+			  struct rtw_vif *rtwvif);
+void rtw_add_rsvd_page_bcn(struct rtw_dev *rtwdev,
+			   struct rtw_vif *rtwvif);
+void rtw_add_rsvd_page_pno(struct rtw_dev *rtwdev,
+			   struct rtw_vif *rtwvif);
+void rtw_add_rsvd_page_sta(struct rtw_dev *rtwdev,
+			   struct rtw_vif *rtwvif);
+int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev);
 void rtw_send_rsvd_page_h2c(struct rtw_dev *rtwdev);
 int rtw_dump_drv_rsvd_page(struct rtw_dev *rtwdev,
 			   u32 offset, u32 size, u32 *buf);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index b3125e311fa2..d7d02e4c0184 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -161,6 +161,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	memset(&rtwvif->bfee, 0, sizeof(struct rtw_bfee));
 	rtwvif->conf = &rtw_vif_port[port];
 	rtw_txq_init(rtwdev, vif->txq);
+	INIT_LIST_HEAD(&rtwvif->rsvd_page_list);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -169,18 +170,24 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
+		rtw_add_rsvd_page_bcn(rtwdev, rtwvif);
 		net_type = RTW_NET_AP_MODE;
 		bcn_ctrl = BIT_EN_BCN_FUNCTION | BIT_DIS_TSF_UDT;
 		break;
 	case NL80211_IFTYPE_ADHOC:
+		rtw_add_rsvd_page_bcn(rtwdev, rtwvif);
 		net_type = RTW_NET_AD_HOC;
 		bcn_ctrl = BIT_EN_BCN_FUNCTION | BIT_DIS_TSF_UDT;
 		break;
 	case NL80211_IFTYPE_STATION:
-	default:
+		rtw_add_rsvd_page_sta(rtwdev, rtwvif);
 		net_type = RTW_NET_NO_LINK;
 		bcn_ctrl = BIT_EN_BCN_FUNCTION;
 		break;
+	default:
+		WARN_ON(1);
+		mutex_unlock(&rtwdev->mutex);
+		return -EINVAL;
 	}
 
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
@@ -211,6 +218,7 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	rtw_leave_lps_deep(rtwdev);
 
 	rtw_txq_cleanup(rtwdev, vif->txq);
+	rtw_remove_rsvd_page(rtwdev, rtwvif);
 
 	eth_zero_addr(rtwvif->mac_addr);
 	config |= PORT_SET_MAC_ADDR;
@@ -342,12 +350,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			chip->ops->phy_calibration(rtwdev);
 
 			rtwvif->aid = conf->aid;
-			rtw_add_rsvd_page(rtwdev, RSVD_PS_POLL, true);
-			rtw_add_rsvd_page(rtwdev, RSVD_QOS_NULL, true);
-			rtw_add_rsvd_page(rtwdev, RSVD_NULL, true);
-			rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_DPK, true);
-			rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_INFO, true);
-			rtw_fw_download_rsvd_page(rtwdev, vif);
+			rtw_fw_download_rsvd_page(rtwdev);
 			rtw_send_rsvd_page_h2c(rtwdev);
 			rtw_coex_media_status_notify(rtwdev, conf->assoc);
 			if (rtw_bf_support)
@@ -356,7 +359,6 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw_leave_lps(rtwdev);
 			net_type = RTW_NET_NO_LINK;
 			rtwvif->aid = 0;
-			rtw_reset_rsvd_page(rtwdev);
 			rtw_bf_disassoc(rtwdev, vif, conf);
 		}
 
@@ -371,7 +373,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_BEACON)
-		rtw_fw_download_rsvd_page(rtwdev, vif);
+		rtw_fw_download_rsvd_page(rtwdev);
 
 	if (changed & BSS_CHANGED_MU_GROUPS) {
 		struct rtw_chip_info *chip = rtwdev->chip;
@@ -556,7 +558,7 @@ static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	/* download new cam settings for PG to backup */
 	if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
-		rtw_fw_download_rsvd_page(rtwdev, vif);
+		rtw_fw_download_rsvd_page(rtwdev);
 
 out:
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 2f73820cd9ba..d8c012bd2112 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1400,10 +1400,6 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	else
 		rtwdev->lps_conf.deep_mode = rtw_fw_lps_deep_mode;
 
-	mutex_lock(&rtwdev->mutex);
-	rtw_add_rsvd_page(rtwdev, RSVD_BEACON, false);
-	mutex_unlock(&rtwdev->mutex);
-
 	rtw_stats_init(rtwdev);
 
 	/* default rx filter setting */
@@ -1446,8 +1442,9 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	skb_queue_purge(&rtwdev->tx_report.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
 
-	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list, list) {
-		list_del(&rsvd_pkt->list);
+	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list,
+				 build_list) {
+		list_del(&rsvd_pkt->build_list);
 		kfree(rsvd_pkt);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c074cef22120..367dc6b92d4f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -752,6 +752,7 @@ struct rtw_vif {
 	u8 bssid[ETH_ALEN];
 	u8 port;
 	u8 bcn_ctrl;
+	struct list_head rsvd_page_list;
 	struct ieee80211_tx_queue_params tx_params[IEEE80211_NUM_ACS];
 	const struct rtw_vif_port *conf;
 
diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index 4820dca958dd..2fcdf70a3a77 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -431,50 +431,39 @@ static void rtw_wow_fw_media_status(struct rtw_dev *rtwdev, bool connect)
 	rtw_iterate_stas_atomic(rtwdev, rtw_wow_fw_media_status_iter, &data);
 }
 
-static void rtw_wow_config_pno_rsvd_page(struct rtw_dev *rtwdev)
+static void rtw_wow_config_pno_rsvd_page(struct rtw_dev *rtwdev,
+					 struct rtw_vif *rtwvif)
 {
-	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
-	struct rtw_pno_request *rtw_pno_req = &rtw_wow->pno_req;
-	struct cfg80211_ssid *ssid;
-	int i;
-
-	for (i = 0 ; i < rtw_pno_req->match_set_cnt; i++) {
-		ssid = &rtw_pno_req->match_sets[i].ssid;
-		rtw_add_rsvd_page_probe_req(rtwdev, ssid);
-	}
-	rtw_add_rsvd_page_probe_req(rtwdev, NULL);
-	rtw_add_rsvd_page(rtwdev, RSVD_NLO_INFO, false);
-	rtw_add_rsvd_page(rtwdev, RSVD_CH_INFO, true);
+	rtw_add_rsvd_page_pno(rtwdev, rtwvif);
 }
 
-static void rtw_wow_config_linked_rsvd_page(struct rtw_dev *rtwdev)
+static void rtw_wow_config_linked_rsvd_page(struct rtw_dev *rtwdev,
+					   struct rtw_vif *rtwvif)
 {
-	rtw_add_rsvd_page(rtwdev, RSVD_PS_POLL, true);
-	rtw_add_rsvd_page(rtwdev, RSVD_QOS_NULL, true);
-	rtw_add_rsvd_page(rtwdev, RSVD_NULL, true);
-	rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_DPK, true);
-	rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_INFO, true);
+	rtw_add_rsvd_page_sta(rtwdev, rtwvif);
 }
 
-static void rtw_wow_config_rsvd_page(struct rtw_dev *rtwdev)
+static void rtw_wow_config_rsvd_page(struct rtw_dev *rtwdev,
+				     struct rtw_vif *rtwvif)
 {
-	rtw_reset_rsvd_page(rtwdev);
+	rtw_remove_rsvd_page(rtwdev, rtwvif);
 
 	if (rtw_wow_mgd_linked(rtwdev)) {
-		rtw_wow_config_linked_rsvd_page(rtwdev);
+		rtw_wow_config_linked_rsvd_page(rtwdev, rtwvif);
 	} else if (test_bit(RTW_FLAG_WOWLAN, rtwdev->flags) &&
 		   rtw_wow_no_link(rtwdev)) {
-		rtw_wow_config_pno_rsvd_page(rtwdev);
+		rtw_wow_config_pno_rsvd_page(rtwdev, rtwvif);
 	}
 }
 
 static int rtw_wow_dl_fw_rsvd_page(struct rtw_dev *rtwdev)
 {
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)wow_vif->drv_priv;
 
-	rtw_wow_config_rsvd_page(rtwdev);
+	rtw_wow_config_rsvd_page(rtwdev, rtwvif);
 
-	return rtw_fw_download_rsvd_page(rtwdev, wow_vif);
+	return rtw_fw_download_rsvd_page(rtwdev);
 }
 
 static int rtw_wow_swap_fw(struct rtw_dev *rtwdev, enum rtw_fw_type type)
-- 
2.17.1

