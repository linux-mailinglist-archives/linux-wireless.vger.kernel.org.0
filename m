Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CEF478204
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 02:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhLQBZI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 20:25:08 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40932 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhLQBZI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 20:25:08 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1BH1P18t8026796, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1BH1P18t8026796
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Dec 2021 09:25:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 09:25:01 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 17 Dec
 2021 09:25:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: [PATCH] rtw88: don't check CRC of VHT-SIG-B in 802.11ac signal
Date:   Fri, 17 Dec 2021 09:24:21 +0800
Message-ID: <20211217012421.7859-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/17/2021 01:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzE2IKRVpMggMTE6Mjg6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Currently all realtek wifi chip is set to check CRC of VHT-SIG-B
in 802.11ac signal, but some AP don't calculate the CRC and packets
from these AP can't be received and lead to disconnection.
We disable the check defaultly to avoid this case.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/bf.c       | 14 +++++++++-----
 drivers/net/wireless/realtek/rtw88/bf.h       |  7 +++++--
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  2 ++
 5 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index aff70e4ae0288..df750b3a35e9d 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -130,7 +130,8 @@ void rtw_bf_cfg_sounding(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 		  BIT_WMAC_USE_NDPARATE |
 		  (csi_rsc << 13);
 
-	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, RTW_SND_CTRL_SOUNDING);
+	rtw_write8_mask(rtwdev, REG_SND_PTCL_CTRL, BIT_MASK_BEAMFORM,
+			RTW_SND_CTRL_SOUNDING);
 	rtw_write8(rtwdev, REG_SND_PTCL_CTRL + 3, 0x26);
 	rtw_write8_clr(rtwdev, REG_RXFLTMAP1, BIT_RXFLTMAP1_BF_REPORT_POLL);
 	rtw_write8_clr(rtwdev, REG_RXFLTMAP4, BIT_RXFLTMAP4_BF_REPORT_POLL);
@@ -177,7 +178,7 @@ void rtw_bf_del_bfer_entry_mu(struct rtw_dev *rtwdev)
 
 void rtw_bf_del_sounding(struct rtw_dev *rtwdev)
 {
-	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, 0);
+	rtw_write8_mask(rtwdev, REG_SND_PTCL_CTRL, BIT_MASK_BEAMFORM, 0);
 }
 
 void rtw_bf_enable_bfee_su(struct rtw_dev *rtwdev, struct rtw_vif *vif,
@@ -204,7 +205,8 @@ void rtw_bf_enable_bfee_su(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 	}
 
 	/* Sounding protocol control */
-	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, RTW_SND_CTRL_SOUNDING);
+	rtw_write8_mask(rtwdev, REG_SND_PTCL_CTRL, BIT_MASK_BEAMFORM,
+			RTW_SND_CTRL_SOUNDING);
 
 	/* MAC address/Partial AID of Beamformer */
 	for (i = 0; i < ETH_ALEN; i++)
@@ -273,7 +275,8 @@ void rtw_bf_remove_bfee_su(struct rtw_dev *rtwdev,
 	struct rtw_bf_info *bfinfo = &rtwdev->bf_info;
 
 	rtw_dbg(rtwdev, RTW_DBG_BF, "remove as a su bfee\n");
-	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, RTW_SND_CTRL_REMOVE);
+	rtw_write8_mask(rtwdev, REG_SND_PTCL_CTRL, BIT_MASK_BEAMFORM,
+			RTW_SND_CTRL_REMOVE);
 
 	switch (bfee->su_reg_index) {
 	case 0:
@@ -298,7 +301,8 @@ void rtw_bf_remove_bfee_mu(struct rtw_dev *rtwdev,
 {
 	struct rtw_bf_info *bfinfo = &rtwdev->bf_info;
 
-	rtw_write8(rtwdev, REG_SND_PTCL_CTRL, RTW_SND_CTRL_REMOVE);
+	rtw_write8_mask(rtwdev, REG_SND_PTCL_CTRL, BIT_MASK_BEAMFORM,
+			RTW_SND_CTRL_REMOVE);
 
 	rtw_bf_del_bfer_entry_mu(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/bf.h b/drivers/net/wireless/realtek/rtw88/bf.h
index 17855edb5006a..7b40c2c038560 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.h
+++ b/drivers/net/wireless/realtek/rtw88/bf.h
@@ -13,6 +13,9 @@
 #define REG_ASSOCIATED_BFMER1_INFO	0x06EC
 #define REG_TX_CSI_RPT_PARAM_BW20	0x06F4
 #define REG_SND_PTCL_CTRL		0x0718
+#define BIT_DIS_CHK_VHTSIGB_CRC		BIT(6)
+#define BIT_DIS_CHK_VHTSIGA_CRC		BIT(5)
+#define BIT_MASK_BEAMFORM		(GENMASK(4, 0) | BIT(7))
 #define REG_MU_TX_CTL			0x14C0
 #define REG_MU_STA_GID_VLD		0x14C4
 #define REG_MU_STA_USER_POS_INFO	0x14C8
@@ -42,8 +45,8 @@
 #define BIT_RXFLTMAP4_BF_REPORT_POLL	BIT(4)
 
 #define RTW_NDP_RX_STANDBY_TIME	0x70
-#define RTW_SND_CTRL_REMOVE	0xD8
-#define RTW_SND_CTRL_SOUNDING	0xDB
+#define RTW_SND_CTRL_REMOVE	0x98
+#define RTW_SND_CTRL_SOUNDING	0x9B
 
 enum csi_seg_len {
 	HAL_CSI_SEG_4K = 0,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 80a6f4da6acd9..db078df63f855 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -223,7 +223,8 @@ static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
 	rtw_write8(rtwdev, REG_TCR + 1, WLAN_TX_FUNC_CFG1);
 	rtw_write8(rtwdev, REG_ACKTO_CCK, 0x40);
 	rtw_write8_set(rtwdev, REG_WMAC_TRXPTCL_CTL_H, BIT(1));
-	rtw_write8_set(rtwdev, REG_SND_PTCL_CTRL, BIT(6));
+	rtw_write8_set(rtwdev, REG_SND_PTCL_CTRL,
+		       BIT_DIS_CHK_VHTSIGB_CRC);
 	rtw_write32(rtwdev, REG_WMAC_OPTION_FUNCTION + 8, WLAN_MAC_OPT_FUNC2);
 	rtw_write8(rtwdev, REG_WMAC_OPTION_FUNCTION + 4, WLAN_MAC_OPT_NORM_FUNC1);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index c409c8c29ec8b..a4cbcc6bdcd14 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -262,6 +262,8 @@ static int rtw8822b_mac_init(struct rtw_dev *rtwdev)
 	rtw_write8(rtwdev, REG_TCR + 1, WLAN_TX_FUNC_CFG1);
 	rtw_write32(rtwdev, REG_WMAC_OPTION_FUNCTION + 8, WLAN_MAC_OPT_FUNC2);
 	rtw_write8(rtwdev, REG_WMAC_OPTION_FUNCTION + 4, WLAN_MAC_OPT_NORM_FUNC1);
+	rtw_write8_set(rtwdev, REG_SND_PTCL_CTRL,
+		       BIT_DIS_CHK_VHTSIGB_CRC);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 46b881e8e4feb..a8b95dcdb8e90 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2102,6 +2102,8 @@ static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
 		     BIT_RXPSF_CONT_ERRCHKEN);
 	value16 = BIT_SET_RXPSF_ERRTHR(value16, 0x07);
 	rtw_write16(rtwdev, REG_RXPSF_CTRL, value16);
+	rtw_write8_set(rtwdev, REG_SND_PTCL_CTRL,
+		       BIT_DIS_CHK_VHTSIGB_CRC);
 
 	/* Interrupt migration configuration */
 	rtw_write32(rtwdev, REG_INT_MIG, WLAN_MAC_INT_MIG_CFG);
-- 
2.25.1

