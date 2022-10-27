Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3560EF7E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 07:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiJ0F2L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 01:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiJ0F1z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 01:27:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E29C15A8ED
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 22:27:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29R5RCG70019992, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29R5RCG70019992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Oct 2022 13:27:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 27 Oct 2022 13:27:45 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 27 Oct
 2022 13:27:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/7] wifi: rtw89: add drop tx packet function
Date:   Thu, 27 Oct 2022 13:27:04 +0800
Message-ID: <20221027052707.14605-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027052707.14605-1-pkshih@realtek.com>
References: <20221027052707.14605-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/27/2022 05:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI2IKRVpMggMTE6MzI6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

When entering WoWLAN mode, we need to drop all transmit packets,
including those in mac buffer, to avoid memory leakage, so implement
the drop_tx function.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  9 +++
 drivers/net/wireless/realtek/rtw89/fw.h       | 20 +++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 75 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      | 13 ++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 13 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +
 8 files changed, 137 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 10ccb047d6a06..6b6bb3260fff4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2624,6 +2624,8 @@ struct rtw89_chip_info {
 	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini;
 	const struct rtw89_dle_mem *dle_mem;
+	u8 wde_qempty_acq_num;
+	u8 wde_qempty_mgq_sel;
 	u32 rf_base_addr[2];
 	u8 support_chanctx_num;
 	u8 support_bands;
@@ -2949,6 +2951,7 @@ struct rtw89_pkt_drop_params {
 	u8 port;
 	u8 mbssid;
 	bool tf_trs;
+	u32 macid_band_sel[4];
 };
 
 struct rtw89_pkt_stat {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index df0af5e0d49a5..545b06bbde6c2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2884,6 +2884,7 @@ int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 	case RTW89_PKT_DROP_SEL_MACID_BK_ONCE:
 	case RTW89_PKT_DROP_SEL_MACID_VI_ONCE:
 	case RTW89_PKT_DROP_SEL_MACID_VO_ONCE:
+	case RTW89_PKT_DROP_SEL_BAND_ONCE:
 		break;
 	default:
 		rtw89_debug(rtwdev, RTW89_DBG_FW,
@@ -2899,6 +2900,14 @@ int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 	RTW89_SET_FWCMD_PKT_DROP_PORT(skb->data, params->port);
 	RTW89_SET_FWCMD_PKT_DROP_MBSSID(skb->data, params->mbssid);
 	RTW89_SET_FWCMD_PKT_DROP_ROLE_A_INFO_TF_TRS(skb->data, params->tf_trs);
+	RTW89_SET_FWCMD_PKT_DROP_MACID_BAND_SEL_0(skb->data,
+						  params->macid_band_sel[0]);
+	RTW89_SET_FWCMD_PKT_DROP_MACID_BAND_SEL_1(skb->data,
+						  params->macid_band_sel[1]);
+	RTW89_SET_FWCMD_PKT_DROP_MACID_BAND_SEL_2(skb->data,
+						  params->macid_band_sel[2]);
+	RTW89_SET_FWCMD_PKT_DROP_MACID_BAND_SEL_3(skb->data,
+						  params->macid_band_sel[3]);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 6ef392ef9c6fb..10a9ca4da0df0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1861,6 +1861,26 @@ static inline void RTW89_SET_FWCMD_PKT_DROP_ROLE_A_INFO_TF_TRS(void *cmd, u32 va
 	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(15, 8));
 }
 
+static inline void RTW89_SET_FWCMD_PKT_DROP_MACID_BAND_SEL_0(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 2, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_PKT_DROP_MACID_BAND_SEL_1(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 3, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_PKT_DROP_MACID_BAND_SEL_2(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 4, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_PKT_DROP_MACID_BAND_SEL_3(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 5, val, GENMASK(31, 0));
+}
+
 enum rtw89_btc_btf_h2c_class {
 	BTFC_SET = 0x10,
 	BTFC_GET = 0x11,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 061244a28f4b4..5b706611d5334 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1335,6 +1335,60 @@ static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 	return cfg;
 }
 
+static bool mac_is_txq_empty(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mac_dle_dfi_qempty qempty;
+	u32 qnum, qtmp, val32, msk32;
+	int i, j, ret;
+
+	qnum = rtwdev->chip->wde_qempty_acq_num;
+	qempty.dle_type = DLE_CTRL_TYPE_WDE;
+
+	for (i = 0; i < qnum; i++) {
+		qempty.grpsel = i;
+		ret = dle_dfi_qempty(rtwdev, &qempty);
+		if (ret) {
+			rtw89_warn(rtwdev, "dle dfi acq empty %d\n", ret);
+			return false;
+		}
+		qtmp = qempty.qempty;
+		for (j = 0 ; j < QEMP_ACQ_GRP_MACID_NUM; j++) {
+			val32 = FIELD_GET(QEMP_ACQ_GRP_QSEL_MASK, qtmp);
+			if (val32 != QEMP_ACQ_GRP_QSEL_MASK)
+				return false;
+			qtmp >>= QEMP_ACQ_GRP_QSEL_SH;
+		}
+	}
+
+	qempty.grpsel = rtwdev->chip->wde_qempty_mgq_sel;
+	ret = dle_dfi_qempty(rtwdev, &qempty);
+	if (ret) {
+		rtw89_warn(rtwdev, "dle dfi mgq empty %d\n", ret);
+		return false;
+	}
+	msk32 = B_CMAC0_MGQ_NORMAL | B_CMAC0_MGQ_NO_PWRSAV | B_CMAC0_CPUMGQ;
+	if ((qempty.qempty & msk32) != msk32)
+		return false;
+
+	if (rtwdev->dbcc_en) {
+		msk32 |= B_CMAC1_MGQ_NORMAL | B_CMAC1_MGQ_NO_PWRSAV | B_CMAC1_CPUMGQ;
+		if ((qempty.qempty & msk32) != msk32)
+			return false;
+	}
+
+	msk32 = B_AX_WDE_EMPTY_QTA_DMAC_WLAN_CPU | B_AX_WDE_EMPTY_QTA_DMAC_DATA_CPU |
+		B_AX_PLE_EMPTY_QTA_DMAC_WLAN_CPU | B_AX_PLE_EMPTY_QTA_DMAC_H2C |
+		B_AX_WDE_EMPTY_QUE_OTHERS | B_AX_PLE_EMPTY_QUE_DMAC_MPDU_TX |
+		B_AX_WDE_EMPTY_QTA_DMAC_CPUIO | B_AX_PLE_EMPTY_QTA_DMAC_CPUIO |
+		B_AX_WDE_EMPTY_QUE_DMAC_PKTIN | B_AX_WDE_EMPTY_QTA_DMAC_HIF |
+		B_AX_PLE_EMPTY_QUE_DMAC_SEC_TX | B_AX_WDE_EMPTY_QTA_DMAC_PKTIN |
+		B_AX_PLE_EMPTY_QTA_DMAC_B0_TXPL | B_AX_PLE_EMPTY_QTA_DMAC_B1_TXPL |
+		B_AX_PLE_EMPTY_QTA_DMAC_MPDU_TX;
+	val32 = rtw89_read32(rtwdev, R_AX_DLE_EMPTY0);
+
+	return (val32 & msk32) == msk32;
+}
+
 static inline u32 dle_used_size(const struct rtw89_dle_size *wde,
 				const struct rtw89_dle_size *ple)
 {
@@ -4893,3 +4947,24 @@ void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 					  rtw89_mac_pkt_drop_vif_iter,
 					  rtwvif);
 }
+
+int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
+					enum rtw89_mac_idx band)
+{
+	struct rtw89_pkt_drop_params params = {0};
+	bool empty;
+	int i, ret = 0, try_cnt = 3;
+
+	params.mac_band = band;
+	params.sel = RTW89_PKT_DROP_SEL_BAND_ONCE;
+
+	for (i = 0; i < try_cnt; i++) {
+		ret = read_poll_timeout(mac_is_txq_empty, empty, empty, 50,
+					50000, false, rtwdev);
+		if (ret)
+			rtw89_fw_h2c_pkt_drop(rtwdev, &params);
+		else
+			return 0;
+	}
+	return ret;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 20211c4e62db5..e3b4c7830f440 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -420,6 +420,17 @@ enum rtw89_mac_bf_rrsc_rate {
 #define S_AX_PLE_PAGE_SEL_128	1
 #define S_AX_PLE_PAGE_SEL_256	2
 
+#define B_CMAC0_MGQ_NORMAL	BIT(2)
+#define B_CMAC0_MGQ_NO_PWRSAV	BIT(3)
+#define B_CMAC0_CPUMGQ		BIT(4)
+#define B_CMAC1_MGQ_NORMAL	BIT(10)
+#define B_CMAC1_MGQ_NO_PWRSAV	BIT(11)
+#define B_CMAC1_CPUMGQ		BIT(12)
+
+#define QEMP_ACQ_GRP_MACID_NUM	8
+#define QEMP_ACQ_GRP_QSEL_SH	4
+#define QEMP_ACQ_GRP_QSEL_MASK	0xF
+
 #define SDIO_LOCAL_BASE_ADDR    0x80000000
 
 #define	PWR_CMD_WRITE		0
@@ -1028,5 +1039,7 @@ u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd);
 int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
 			struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
 int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
+int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
+					enum rtw89_mac_idx band);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 2b938d11d2381..33f2b67bfca37 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -545,6 +545,19 @@
 #define B_AX_WDE_EMPTY_QUE_CMAC0_MBH BIT(1)
 #define B_AX_WDE_EMPTY_QUE_CMAC0_ALL_AC BIT(0)
 
+#define R_AX_DLE_EMPTY1 0x8434
+#define B_AX_PLE_EMPTY_QTA_DMAC_WDRLS BIT(20)
+#define B_AX_PLE_EMPTY_QTA_CMAC1_DMA_BBRPT BIT(19)
+#define B_AX_PLE_EMPTY_QTA_CMAC1_DMA_RX BIT(18)
+#define B_AX_PLE_EMPTY_QTA_CMAC0_DMA_RX BIT(17)
+#define B_AX_PLE_EMPTY_QTA_DMAC_C2H BIT(16)
+#define B_AX_PLE_EMPTY_QUE_DMAC_PLRLS BIT(5)
+#define B_AX_PLE_EMPTY_QUE_DMAC_CPUIO BIT(4)
+#define B_AX_PLE_EMPTY_QUE_DMAC_SEC_RX BIT(3)
+#define B_AX_PLE_EMPTY_QUE_DMAC_MPDU_RX BIT(2)
+#define B_AX_PLE_EMPTY_QUE_DMAC_HDP BIT(1)
+#define B_AX_WDE_EMPTY_QUE_DMAC_WDRLS BIT(0)
+
 #define R_AX_DMAC_ERR_IMR 0x8520
 #define B_AX_DLE_CPUIO_ERR_INT_EN BIT(10)
 #define B_AX_APB_BRIDGE_ERR_INT_EN BIT(9)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 375e84f5fe5c1..7995d720dc921 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2049,6 +2049,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852a_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852a_dle_mem_pcie,
+	.wde_qempty_acq_num	= 16,
+	.wde_qempty_mgq_sel	= 16,
 	.rf_base_addr		= {0xc000, 0xd000},
 	.pwr_on_seq		= pwr_on_seq_8852a,
 	.pwr_off_seq		= pwr_off_seq_8852a,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index f6bcac8268166..470e9e9cfafd6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2855,6 +2855,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852c_dle_mem_pcie,
+	.wde_qempty_acq_num     = 16,
+	.wde_qempty_mgq_sel     = 16,
 	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
-- 
2.25.1

