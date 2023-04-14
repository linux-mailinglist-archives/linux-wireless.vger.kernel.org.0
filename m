Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E046E2522
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDNOGm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDNOGj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 10:06:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1DB1717
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 07:06:17 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33EE3QJJ0020248, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33EE3QJJ0020248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 14 Apr 2023 22:03:26 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 14 Apr 2023 22:03:48 +0800
Received: from localhost (172.16.20.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Apr
 2023 22:03:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: update statistics to FW for fine-tuning performance
Date:   Fri, 14 Apr 2023 22:03:14 +0800
Message-ID: <20230414140316.27656-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414140316.27656-1-pkshih@realtek.com>
References: <20230414140316.27656-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.53]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Since firmware can't have proper statistics, driver update the
statistics periodically to firmware to assist in tuning performance.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  4 ++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 41 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 10 ++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e213140a6f3a7..b21fa1721edd7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2494,8 +2494,10 @@ static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 	bool tfc_changed;
 
 	tfc_changed = rtw89_traffic_stats_calc(rtwdev, &rtwdev->stats);
-	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		rtw89_traffic_stats_calc(rtwdev, &rtwvif->stats);
+		rtw89_fw_h2c_tp_offload(rtwdev, rtwvif);
+	}
 
 	return tfc_changed;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8a8d166ef04fb..b070505eb9654 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1855,6 +1855,47 @@ int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	struct rtw89_traffic_stats *stats = &rtwvif->stats;
+	struct rtw89_h2c_ofld *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	if (rtwvif->net_type != RTW89_NET_TYPE_INFRA)
+		return -EINVAL;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c tp\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ofld *)skb->data;
+
+	h2c->w0 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_OFLD_W0_MAC_ID) |
+		  le32_encode_bits(stats->tx_throughput, RTW89_H2C_OFLD_W0_TX_TP) |
+		  le32_encode_bits(stats->rx_throughput, RTW89_H2C_OFLD_W0_RX_TP);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_OFLD_TP, 0, 1, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define H2C_RA_LEN 16
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5f73b86f54d93..299b3c58fe295 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3466,6 +3466,14 @@ struct rtw89_h2c_ofld_rssi {
 #define RTW89_H2C_OFLD_RSSI_W0_NUM GENMASK(15, 8)
 #define RTW89_H2C_OFLD_RSSI_W1_VAL GENMASK(7, 0)
 
+struct rtw89_h2c_ofld {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_OFLD_W0_MAC_ID GENMASK(7, 0)
+#define RTW89_H2C_OFLD_W0_TX_TP GENMASK(17, 8)
+#define RTW89_H2C_OFLD_W0_RX_TP GENMASK(27, 18)
+
 #define RTW89_FW_HDR_SIZE 32
 #define RTW89_FW_SECTION_HDR_SIZE 16
 
@@ -3604,6 +3612,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_FUNC_PKT_DROP		0x1b
 #define H2C_FUNC_CFG_BCNFLTR		0x1e
 #define H2C_FUNC_OFLD_RSSI		0x1f
+#define H2C_FUNC_OFLD_TP		0x20
 
 /* CLASS 10 - Security CAM */
 #define H2C_CL_MAC_SEC_CAM		0xa
@@ -3710,6 +3719,7 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 				  bool connect);
 int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_rx_phy_ppdu *phy_ppdu);
+int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi);
 int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev);
-- 
2.25.1

