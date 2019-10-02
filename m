Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774C0C47D4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfJBGfp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:45 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57708 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJBGfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:44 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZdEq013068, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZdEq013068
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:39 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:39 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 07/14] rtw88: flush hardware tx queues
Date:   Wed, 2 Oct 2019 14:35:24 +0800
Message-ID: <20191002063531.18135-8-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Sometimes mac80211 will ask us to flush the hardware queues.
To flush them, first we need to get the corresponding priority queues
from the RQPN mapping table.

Then we can check the available pages are equal to the originally
reserved pages, which means the hardware has returned all of the pages
it used to transmit.

Note that now we only check for 100 ms for the priority queue, but
sometimes if we have a lot of traffic (ex. 100Mbps up), some of the
packets could be dropped.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c      | 88 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c | 14 +++
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +-
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index d8c5da342b11..f40877bc9c9a 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -719,6 +719,93 @@ int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 	return ret;
 }
 
+static u32 get_priority_queues(struct rtw_dev *rtwdev, u32 queues)
+{
+	struct rtw_rqpn *rqpn = rtwdev->fifo.rqpn;
+	u32 prio_queues = 0;
+
+	if (queues & BIT(IEEE80211_AC_VO))
+		prio_queues |= BIT(rqpn->dma_map_vo);
+	if (queues & BIT(IEEE80211_AC_VI))
+		prio_queues |= BIT(rqpn->dma_map_vi);
+	if (queues & BIT(IEEE80211_AC_BE))
+		prio_queues |= BIT(rqpn->dma_map_be);
+	if (queues & BIT(IEEE80211_AC_BK))
+		prio_queues |= BIT(rqpn->dma_map_bk);
+
+	return prio_queues;
+}
+
+static void __rtw_mac_flush_prio_queue(struct rtw_dev *rtwdev,
+				       u32 prio_queue, bool drop)
+{
+	u32 addr;
+	u16 avail_page, rsvd_page;
+	int i;
+
+	switch (prio_queue) {
+	case RTW_DMA_MAPPING_EXTRA:
+		addr = REG_FIFOPAGE_INFO_4;
+		break;
+	case RTW_DMA_MAPPING_LOW:
+		addr = REG_FIFOPAGE_INFO_2;
+		break;
+	case RTW_DMA_MAPPING_NORMAL:
+		addr = REG_FIFOPAGE_INFO_3;
+		break;
+	case RTW_DMA_MAPPING_HIGH:
+		addr = REG_FIFOPAGE_INFO_1;
+		break;
+	default:
+		return;
+	}
+
+	/* check if all of the reserved pages are available for 100 msecs */
+	for (i = 0; i < 5; i++) {
+		rsvd_page = rtw_read16(rtwdev, addr);
+		avail_page = rtw_read16(rtwdev, addr + 2);
+		if (rsvd_page == avail_page)
+			return;
+
+		msleep(20);
+	}
+
+	/* priority queue is still not empty, throw a warning,
+	 *
+	 * Note that if we want to flush the tx queue when having a lot of
+	 * traffic (ex, 100Mbps up), some of the packets could be dropped.
+	 * And it requires like ~2secs to flush the full priority queue.
+	 */
+	if (!drop)
+		rtw_warn(rtwdev, "timed out to flush queue %d\n", prio_queue);
+}
+
+static void rtw_mac_flush_prio_queues(struct rtw_dev *rtwdev,
+				      u32 prio_queues, bool drop)
+{
+	u32 q;
+
+	for (q = 0; q < RTW_DMA_MAPPING_MAX; q++)
+		if (prio_queues & BIT(q))
+			__rtw_mac_flush_prio_queue(rtwdev, q, drop);
+}
+
+void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop)
+{
+	u32 prio_queues = 0;
+
+	/* If all of the hardware queues are requested to flush,
+	 * or the priority queues are not mapped yet,
+	 * flush all of the priority queues
+	 */
+	if (queues == BIT(rtwdev->hw->queues) - 1 || !rtwdev->fifo.rqpn)
+		prio_queues = BIT(RTW_DMA_MAPPING_MAX) - 1;
+	else
+		prio_queues = get_priority_queues(rtwdev, queues);
+
+	rtw_mac_flush_prio_queues(rtwdev, prio_queues, drop);
+}
+
 static int txdma_queue_mapping(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -743,6 +830,7 @@ static int txdma_queue_mapping(struct rtw_dev *rtwdev)
 		return -EINVAL;
 	}
 
+	rtwdev->fifo.rqpn = rqpn;
 	txdma_pq_map |= BIT_TXDMA_HIQ_MAP(rqpn->dma_map_hi);
 	txdma_pq_map |= BIT_TXDMA_MGQ_MAP(rqpn->dma_map_mg);
 	txdma_pq_map |= BIT_TXDMA_BKQ_MAP(rqpn->dma_map_bk);
diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index efe6f731f240..a67fa82973e4 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -31,5 +31,6 @@ int rtw_mac_power_on(struct rtw_dev *rtwdev);
 void rtw_mac_power_off(struct rtw_dev *rtwdev);
 int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
+void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 9c77c86d3021..cb7436949ff6 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -589,6 +589,19 @@ static void rtw_ops_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 }
 
+static void rtw_ops_flush(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  u32 queues, bool drop)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw_leave_lps_deep(rtwdev);
+
+	rtw_mac_flush_queues(rtwdev, queues, drop);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
 	.wake_tx_queue		= rtw_ops_wake_tx_queue,
@@ -608,5 +621,6 @@ const struct ieee80211_ops rtw_ops = {
 	.mgd_prepare_tx		= rtw_ops_mgd_prepare_tx,
 	.set_rts_threshold	= rtw_ops_set_rts_threshold,
 	.sta_statistics		= rtw_ops_sta_statistics,
+	.flush			= rtw_ops_flush,
 };
 EXPORT_SYMBOL(rtw_ops);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index cd34d4d77b52..00d2cf07a176 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -780,6 +780,7 @@ enum rtw_dma_mapping {
 	RTW_DMA_MAPPING_NORMAL	= 2,
 	RTW_DMA_MAPPING_HIGH	= 3,
 
+	RTW_DMA_MAPPING_MAX,
 	RTW_DMA_MAPPING_UNDEF,
 };
 
@@ -1286,7 +1287,7 @@ struct rtw_fifo_conf {
 	u16 rsvd_cpu_instr_addr;
 	u16 rsvd_fw_txbuf_addr;
 	u16 rsvd_csibuf_addr;
-	enum rtw_dma_mapping pq_map[RTW_PQ_MAP_NUM];
+	struct rtw_rqpn *rqpn;
 };
 
 struct rtw_fw_state {
-- 
2.17.1

