Return-Path: <linux-wireless+bounces-493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D880701F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 13:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31D91C20A2C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971337162;
	Wed,  6 Dec 2023 12:46:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2EED5B
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 04:46:17 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B6Ck9OT13602916, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B6Ck9OT13602916
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 20:46:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 6 Dec 2023 20:46:10 +0800
Received: from [127.0.1.1] (172.16.20.124) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 6 Dec 2023
 20:46:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: parse and print out RFK log from C2H events
Date: Wed, 6 Dec 2023 20:44:47 +0800
Message-ID: <20231206124448.10537-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206124448.10537-1-pkshih@realtek.com>
References: <20231206124448.10537-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

RFK log events contains two types. One called RUN log is to reflect state
during RFK is running, and it replies on formatted string loaded from
firmware file, but print this type as plain hexadecimal only in this patch.
The other is REPORT log that reflects the final result of a RFK, and
each calibration has its own struct to carry many specific information.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  |  66 +++++++++
 drivers/net/wireless/realtek/rtw89/phy.c | 175 +++++++++++++++++++++++
 2 files changed, 241 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 1d909d684ed9..e2dc9e1604d1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3722,6 +3722,72 @@ struct rtw89_fw_h2c_rf_get_mccch {
 	__le32 current_band_type;
 } __packed;
 
+enum rtw89_rf_log_type {
+	RTW89_RF_RUN_LOG = 0,
+	RTW89_RF_RPT_LOG = 1,
+};
+
+struct rtw89_c2h_rf_log_hdr {
+	u8 type; /* enum rtw89_rf_log_type */
+	__le16 len;
+	u8 content[];
+} __packed;
+
+struct rtw89_c2h_rf_dpk_rpt_log {
+	u8 ver;
+	u8 idx[2];
+	u8 band[2];
+	u8 bw[2];
+	u8 ch[2];
+	u8 path_ok[2];
+	u8 txagc[2];
+	u8 ther[2];
+	u8 gs[2];
+	u8 dc_i[4];
+	u8 dc_q[4];
+	u8 corr_val[2];
+	u8 corr_idx[2];
+	u8 is_timeout[2];
+	u8 rxbb_ov[2];
+	u8 rsvd;
+} __packed;
+
+struct rtw89_c2h_rf_dack_rpt_log {
+	u8 fwdack_ver;
+	u8 fwdack_rpt_ver;
+	u8 msbk_d[2][2][16];
+	u8 dadck_d[2][2];
+	u8 cdack_d[2][2][2];
+	__le16 addck2_d[2][2][2];
+	u8 adgaink_d[2][2];
+	__le16 biask_d[2][2];
+	u8 addck_timeout;
+	u8 cdack_timeout;
+	u8 dadck_timeout;
+	u8 msbk_timeout;
+	u8 adgaink_timeout;
+	u8 dack_fail;
+} __packed;
+
+struct rtw89_c2h_rf_rxdck_rpt_log {
+	u8 ver;
+	u8 band[2];
+	u8 bw[2];
+	u8 ch[2];
+	u8 timeout[2];
+} __packed;
+
+struct rtw89_c2h_rf_txgapk_rpt_log {
+	__le32 r0x8010[2];
+	__le32 chk_cnt;
+	u8 track_d[2][17];
+	u8 power_d[2][17];
+	u8 is_txgapk_ok;
+	u8 chk_id;
+	u8 ver;
+	u8 rsv1;
+} __packed;
+
 #define RTW89_FW_RSVD_PLE_SIZE 0x800
 
 #define RTW89_WCPU_BASE_MASK GENMASK(27, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 8a4a72b00340..496160f72755 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2445,34 +2445,209 @@ void (* const rtw89_phy_c2h_ra_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_FUNC_TXSTS] = NULL,
 };
 
+static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_c2h_rfk_log_func func,
+				      void *content, u16 len)
+{
+	struct rtw89_c2h_rf_txgapk_rpt_log *txgapk;
+	struct rtw89_c2h_rf_rxdck_rpt_log *rxdck;
+	struct rtw89_c2h_rf_dack_rpt_log *dack;
+	struct rtw89_c2h_rf_dpk_rpt_log *dpk;
+
+	switch (func) {
+	case RTW89_PHY_C2H_RFK_LOG_FUNC_DPK:
+		if (len != sizeof(*dpk))
+			goto out;
+
+		dpk = content;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "DPK ver:%d idx:%2ph band:%2ph bw:%2ph ch:%2ph path:%2ph\n",
+			    dpk->ver, dpk->idx, dpk->band, dpk->bw, dpk->ch, dpk->path_ok);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "DPK txagc:%2ph ther:%2ph gs:%2ph dc_i:%4ph dc_q:%4ph\n",
+			    dpk->txagc, dpk->ther, dpk->gs, dpk->dc_i, dpk->dc_q);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "DPK corr_v:%2ph corr_i:%2ph to:%2ph ov:%2ph\n",
+			    dpk->corr_val, dpk->corr_idx, dpk->is_timeout, dpk->rxbb_ov);
+		return;
+	case RTW89_PHY_C2H_RFK_LOG_FUNC_DACK:
+		if (len != sizeof(*dack))
+			goto out;
+
+		dack = content;
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]ver=0x%x 0x%x\n",
+			    dack->fwdack_ver, dack->fwdack_rpt_ver);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 CDACK ic = [0x%x, 0x%x]\n",
+			    dack->cdack_d[0][0][0], dack->cdack_d[0][0][1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 CDACK qc = [0x%x, 0x%x]\n",
+			    dack->cdack_d[0][1][0], dack->cdack_d[0][1][1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 CDACK ic = [0x%x, 0x%x]\n",
+			    dack->cdack_d[1][0][0], dack->cdack_d[1][0][1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 CDACK qc = [0x%x, 0x%x]\n",
+			    dack->cdack_d[1][1][0], dack->cdack_d[1][1][1]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADC_DCK ic = [0x%x, 0x%x]\n",
+			    dack->addck2_d[0][0][0], dack->addck2_d[0][0][1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADC_DCK qc = [0x%x, 0x%x]\n",
+			    dack->addck2_d[0][1][0], dack->addck2_d[0][1][1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 ADC_DCK ic = [0x%x, 0x%x]\n",
+			    dack->addck2_d[1][0][0], dack->addck2_d[1][0][1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 ADC_DCK qc = [0x%x, 0x%x]\n",
+			    dack->addck2_d[1][1][0], dack->addck2_d[1][1][1]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADC_GAINK ic = 0x%x, qc = 0x%x\n",
+			    dack->adgaink_d[0][0], dack->adgaink_d[0][1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 ADC_GAINK ic = 0x%x, qc = 0x%x\n",
+			    dack->adgaink_d[1][0], dack->adgaink_d[1][1]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 DAC_DCK ic = 0x%x, qc = 0x%x\n",
+			    dack->dadck_d[0][0], dack->dadck_d[0][1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 DAC_DCK ic = 0x%x, qc = 0x%x\n",
+			    dack->dadck_d[1][0], dack->dadck_d[1][1]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 biask iqc = 0x%x\n",
+			    dack->biask_d[0][0]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 biask iqc = 0x%x\n",
+			    dack->biask_d[1][0]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK ic: %*ph\n",
+			    (int)sizeof(dack->msbk_d[0][0]), dack->msbk_d[0][0]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK qc: %*ph\n",
+			    (int)sizeof(dack->msbk_d[0][1]), dack->msbk_d[0][1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK ic: %*ph\n",
+			    (int)sizeof(dack->msbk_d[1][0]), dack->msbk_d[1][0]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK qc: %*ph\n",
+			    (int)sizeof(dack->msbk_d[1][1]), dack->msbk_d[1][1]);
+		return;
+	case RTW89_PHY_C2H_RFK_LOG_FUNC_RXDCK:
+		if (len != sizeof(*rxdck))
+			goto out;
+
+		rxdck = content;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "RXDCK ver:%d band:%2ph bw:%2ph ch:%2ph to:%2ph\n",
+			    rxdck->ver, rxdck->band, rxdck->bw, rxdck->ch,
+			    rxdck->timeout);
+		return;
+	case RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK:
+		if (len != sizeof(*txgapk))
+			goto out;
+
+		txgapk = content;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TXGAPK]rpt r0x8010[0]=0x%x, r0x8010[1]=0x%x\n",
+			    le32_to_cpu(txgapk->r0x8010[0]),
+			    le32_to_cpu(txgapk->r0x8010[1]));
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt chk_id = %d\n",
+			    txgapk->chk_id);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt chk_cnt = %d\n",
+			    le32_to_cpu(txgapk->chk_cnt));
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt ver = 0x%x\n",
+			    txgapk->ver);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt rsv1 = %d\n",
+			    txgapk->rsv1);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt track_d[0] = %*ph\n",
+			    (int)sizeof(txgapk->track_d[0]), txgapk->track_d[0]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt power_d[0] = %*ph\n",
+			    (int)sizeof(txgapk->power_d[0]), txgapk->power_d[0]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt track_d[1] = %*ph\n",
+			    (int)sizeof(txgapk->track_d[1]), txgapk->track_d[1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt power_d[1] = %*ph\n",
+			    (int)sizeof(txgapk->power_d[1]), txgapk->power_d[1]);
+		return;
+	default:
+		break;
+	}
+
+out:
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "unexpected RFK func %d report log with length %d\n", func, len);
+}
+
+static void rtw89_phy_c2h_rfk_log(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
+				  u32 len, enum rtw89_phy_c2h_rfk_log_func func,
+				  const char *rfk_name)
+{
+	struct rtw89_c2h_hdr *c2h_hdr = (struct rtw89_c2h_hdr *)c2h->data;
+	struct rtw89_c2h_rf_log_hdr *log_hdr;
+	void *log_ptr = c2h_hdr;
+	u16 content_len;
+	u16 chunk_len;
+
+	if (!rtw89_debug_is_enabled(rtwdev, RTW89_DBG_RFK))
+		return;
+
+	log_ptr += sizeof(*c2h_hdr);
+	len -= sizeof(*c2h_hdr);
+
+	while (len > sizeof(*log_hdr)) {
+		log_hdr = log_ptr;
+		content_len = le16_to_cpu(log_hdr->len);
+		chunk_len = content_len + sizeof(*log_hdr);
+
+		if (chunk_len > len)
+			break;
+
+		switch (log_hdr->type) {
+		case RTW89_RF_RUN_LOG:
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "%s run: %*ph\n",
+				    rfk_name, content_len, log_hdr->content);
+			break;
+		case RTW89_RF_RPT_LOG:
+			rtw89_phy_c2h_rfk_rpt_log(rtwdev, func,
+						  log_hdr->content, content_len);
+			break;
+		default:
+			return;
+		}
+
+		log_ptr += chunk_len;
+		len -= chunk_len;
+	}
+}
+
 static void
 rtw89_phy_c2h_rfk_log_iqk(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	rtw89_phy_c2h_rfk_log(rtwdev, c2h, len,
+			      RTW89_PHY_C2H_RFK_LOG_FUNC_IQK, "IQK");
 }
 
 static void
 rtw89_phy_c2h_rfk_log_dpk(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	rtw89_phy_c2h_rfk_log(rtwdev, c2h, len,
+			      RTW89_PHY_C2H_RFK_LOG_FUNC_DPK, "DPK");
 }
 
 static void
 rtw89_phy_c2h_rfk_log_dack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	rtw89_phy_c2h_rfk_log(rtwdev, c2h, len,
+			      RTW89_PHY_C2H_RFK_LOG_FUNC_DACK, "DACK");
 }
 
 static void
 rtw89_phy_c2h_rfk_log_rxdck(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	rtw89_phy_c2h_rfk_log(rtwdev, c2h, len,
+			      RTW89_PHY_C2H_RFK_LOG_FUNC_RXDCK, "RX_DCK");
 }
 
 static void
 rtw89_phy_c2h_rfk_log_tssi(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	rtw89_phy_c2h_rfk_log(rtwdev, c2h, len,
+			      RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI, "TSSI");
 }
 
 static void
 rtw89_phy_c2h_rfk_log_txgapk(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	rtw89_phy_c2h_rfk_log(rtwdev, c2h, len,
+			      RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK, "TXGAPK");
 }
 
 static
-- 
2.25.1


