Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2532364F935
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiLQOSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiLQOSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:18:14 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96CE86438
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BHEHEeP4024829, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BHEHEeP4024829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 17 Dec 2022 22:17:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Sat, 17 Dec 2022 22:18:04 +0800
Received: from localhost (172.16.16.141) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 17 Dec
 2022 22:18:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/7] wifi: rtw89: coex: refactor _chk_btc_report() to extend more features
Date:   Sat, 17 Dec 2022 22:17:44 +0800
Message-ID: <20221217141745.43291-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221217141745.43291-1-pkshih@realtek.com>
References: <20221217141745.43291-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.141]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/17/2022 14:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE3IKRXpMggMTE6MjQ6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Change the checking logic to switch case. Make the code more readable.
There are more feature including to common code, in order to commit the
following version of the features, switch case will make the logic more
clearly. This patch did not change logic.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 365 +++++++++-------------
 1 file changed, 143 insertions(+), 222 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 13764bfdd0bea..db0c694c4f92b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1006,7 +1006,6 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_fbtc_cysta_v1 *pcysta_v1 = NULL;
 	struct rtw89_btc_fbtc_cysta_cpu pcysta[1];
 	struct rtw89_btc_prpt *btc_prpt = NULL;
-	struct rtw89_btc_fbtc_slot *rtp_slot = NULL;
 	void *rpt_content = NULL, *pfinfo = NULL;
 	u8 rpt_type = 0;
 	u16 wl_slot_set = 0, wl_slot_real = 0;
@@ -1043,8 +1042,6 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo_v1);
 		}
 		pcinfo->req_fver = ver->fcxbtcrpt;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_TDMA:
 		pcinfo = &pfwinfo->rpt_fbtc_tdma.cinfo;
@@ -1056,16 +1053,12 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo_v1);
 		}
 		pcinfo->req_fver = ver->fcxtdma;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_SLOT:
 		pcinfo = &pfwinfo->rpt_fbtc_slots.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_slots.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_slots.finfo);
 		pcinfo->req_fver = ver->fcxslots;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_CYSTA:
 		pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
@@ -1080,8 +1073,6 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo_v1);
 		}
 		pcinfo->req_fver = ver->fcxcysta;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_STEP:
 		pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
@@ -1097,8 +1088,6 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 					  offsetof(struct rtw89_btc_fbtc_steps_v1, step);
 		}
 		pcinfo->req_fver = ver->fcxstep;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_NULLSTA:
 		pcinfo = &pfwinfo->rpt_fbtc_nullsta.cinfo;
@@ -1110,40 +1099,30 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo_v1);
 		}
 		pcinfo->req_fver = ver->fcxnullsta;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_MREG:
 		pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo);
 		pcinfo->req_fver = ver->fcxmreg;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_GPIO_DBG:
 		pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_gpio_dbg.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_gpio_dbg.finfo);
 		pcinfo->req_fver = ver->fcxgpiodbg;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_BT_VER:
 		pcinfo = &pfwinfo->rpt_fbtc_btver.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_btver.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btver.finfo);
 		pcinfo->req_fver = ver->fcxbtver;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_BT_SCAN:
 		pcinfo = &pfwinfo->rpt_fbtc_btscan.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo);
 		pcinfo->req_fver = ver->fcxbtscan;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_BT_AFH:
 		pcinfo = &pfwinfo->rpt_fbtc_btafh.cinfo;
@@ -1157,22 +1136,21 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			goto err;
 		}
 		pcinfo->req_fver = ver->fcxbtafh;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	case BTC_RPT_TYPE_BT_DEVICE:
 		pcinfo = &pfwinfo->rpt_fbtc_btdev.cinfo;
 		pfinfo = &pfwinfo->rpt_fbtc_btdev.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btdev.finfo);
 		pcinfo->req_fver = ver->fcxbtdevinfo;
-		pcinfo->rx_len = rpt_len;
-		pcinfo->rx_cnt++;
 		break;
 	default:
 		pfwinfo->err[BTFRE_UNDEF_TYPE]++;
 		return 0;
 	}
 
+	pcinfo->rx_len = rpt_len;
+	pcinfo->rx_cnt++;
+
 	if (rpt_len != pcinfo->req_len) {
 		if (rpt_type < BTC_RPT_TYPE_MAX)
 			pfwinfo->len_mismch |= (0x1 << rpt_type);
@@ -1193,227 +1171,170 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	memcpy(pfinfo, rpt_content, pcinfo->req_len);
 	pcinfo->valid = 1;
 
-	if (rpt_type == BTC_RPT_TYPE_TDMA && chip->chip_id == RTL8852A) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): check %d %zu\n", __func__,
-			    BTC_DCNT_TDMA_NONSYNC, sizeof(dm->tdma_now));
-
-		if (memcmp(&dm->tdma_now, &pfwinfo->rpt_fbtc_tdma.finfo,
-			   sizeof(dm->tdma_now)) != 0) {
-			rtw89_debug(rtwdev, RTW89_DBG_BTC,
-				    "[BTC], %s(): %d tdma_now %x %x %x %x %x %x %x %x\n",
-				    __func__, BTC_DCNT_TDMA_NONSYNC,
-				    dm->tdma_now.type, dm->tdma_now.rxflctrl,
-				    dm->tdma_now.txpause, dm->tdma_now.wtgle_n,
-				    dm->tdma_now.leak_n, dm->tdma_now.ext_ctrl,
-				    dm->tdma_now.rxflctrl_role,
-				    dm->tdma_now.option_ctrl);
-
-			rtw89_debug(rtwdev, RTW89_DBG_BTC,
-				    "[BTC], %s(): %d rpt_fbtc_tdma %x %x %x %x %x %x %x %x\n",
-				    __func__, BTC_DCNT_TDMA_NONSYNC,
-				    pfwinfo->rpt_fbtc_tdma.finfo.type,
-				    pfwinfo->rpt_fbtc_tdma.finfo.rxflctrl,
-				    pfwinfo->rpt_fbtc_tdma.finfo.txpause,
-				    pfwinfo->rpt_fbtc_tdma.finfo.wtgle_n,
-				    pfwinfo->rpt_fbtc_tdma.finfo.leak_n,
-				    pfwinfo->rpt_fbtc_tdma.finfo.ext_ctrl,
-				    pfwinfo->rpt_fbtc_tdma.finfo.rxflctrl_role,
-				    pfwinfo->rpt_fbtc_tdma.finfo.option_ctrl);
-		}
+	switch (rpt_type) {
+	case BTC_RPT_TYPE_CTRL:
+		if (chip->chip_id == RTL8852A) {
+			prpt = &pfwinfo->rpt_ctrl.finfo;
+			btc->fwinfo.rpt_en_map = prpt->rpt_enable;
+			wl->ver_info.fw_coex = prpt->wl_fw_coex_ver;
+			wl->ver_info.fw = prpt->wl_fw_ver;
+			dm->wl_fw_cx_offload = !!prpt->wl_fw_cx_offload;
+
+			_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
+				     pfwinfo->event[BTF_EVNT_RPT]);
+
+			/* To avoid I/O if WL LPS or power-off */
+			if (wl->status.map.lps != BTC_LPS_RF_OFF &&
+			    !wl->status.map.rf_off) {
+				rtwdev->chip->ops->btc_update_bt_cnt(rtwdev);
+				_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
+
+				btc->cx.cnt_bt[BTC_BCNT_POLUT] =
+					rtw89_mac_get_plt_cnt(rtwdev,
+							      RTW89_MAC_0);
+			}
+		} else {
+			prpt_v1 = &pfwinfo->rpt_ctrl.finfo_v1;
+			btc->fwinfo.rpt_en_map = le32_to_cpu(prpt_v1->rpt_info.en);
+			wl->ver_info.fw_coex = le32_to_cpu(prpt_v1->wl_fw_info.cx_ver);
+			wl->ver_info.fw = le32_to_cpu(prpt_v1->wl_fw_info.fw_ver);
+			dm->wl_fw_cx_offload = !!le32_to_cpu(prpt_v1->wl_fw_info.cx_offload);
+
+			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+				memcpy(&dm->gnt.band[i], &prpt_v1->gnt_val[i],
+				       sizeof(dm->gnt.band[i]));
+
+			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
+				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_HI_TX]);
+			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
+				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_HI_RX]);
+			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
+				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_LO_TX]);
+			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
+				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_LO_RX]);
+			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
+				le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_POLLUTED]);
 
-		_chk_btc_err(rtwdev, BTC_DCNT_TDMA_NONSYNC,
-			     memcmp(&dm->tdma_now,
-				    &pfwinfo->rpt_fbtc_tdma.finfo,
-				    sizeof(dm->tdma_now)));
-	} else if (rpt_type == BTC_RPT_TYPE_TDMA) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): check %d %zu\n", __func__,
-			    BTC_DCNT_TDMA_NONSYNC, sizeof(dm->tdma_now));
-
-		if (memcmp(&dm->tdma_now, &pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma,
-			   sizeof(dm->tdma_now)) != 0) {
-			rtw89_debug(rtwdev, RTW89_DBG_BTC,
-				    "[BTC], %s(): %d tdma_now %x %x %x %x %x %x %x %x\n",
-				    __func__, BTC_DCNT_TDMA_NONSYNC,
-				    dm->tdma_now.type, dm->tdma_now.rxflctrl,
-				    dm->tdma_now.txpause, dm->tdma_now.wtgle_n,
-				    dm->tdma_now.leak_n, dm->tdma_now.ext_ctrl,
-				    dm->tdma_now.rxflctrl_role,
-				    dm->tdma_now.option_ctrl);
-			rtw89_debug(rtwdev, RTW89_DBG_BTC,
-				    "[BTC], %s(): %d rpt_fbtc_tdma %x %x %x %x %x %x %x %x\n",
-				    __func__, BTC_DCNT_TDMA_NONSYNC,
-				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.type,
-				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.rxflctrl,
-				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.txpause,
-				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.wtgle_n,
-				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.leak_n,
-				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.ext_ctrl,
-				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.rxflctrl_role,
-				    pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma.option_ctrl);
-		}
+			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
+			_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
+				     pfwinfo->event[BTF_EVNT_RPT]);
 
-		_chk_btc_err(rtwdev, BTC_DCNT_TDMA_NONSYNC,
-			     memcmp(&dm->tdma_now,
-				    &pfwinfo->rpt_fbtc_tdma.finfo_v1.tdma,
-				    sizeof(dm->tdma_now)));
-	}
+			if (le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_RFK_TIMEOUT]) > 0)
+				bt->rfk_info.map.timeout = 1;
+			else
+				bt->rfk_info.map.timeout = 0;
 
-	if (rpt_type == BTC_RPT_TYPE_SLOT) {
+			dm->error.map.bt_rfk_timeout = bt->rfk_info.map.timeout;
+		}
+		break;
+	case BTC_RPT_TYPE_TDMA:
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): check %d %zu\n", __func__,
+			    BTC_DCNT_TDMA_NONSYNC,
+			    sizeof(dm->tdma_now));
+		if (chip->chip_id == RTL8852A)
+			_chk_btc_err(rtwdev, BTC_DCNT_TDMA_NONSYNC,
+				     memcmp(&dm->tdma_now,
+					    &pfwinfo->rpt_fbtc_tdma.finfo_v1,
+					    sizeof(dm->tdma_now)));
+		else
+			_chk_btc_err(rtwdev, BTC_DCNT_TDMA_NONSYNC,
+				     memcmp(&dm->tdma_now,
+					    &pfwinfo->rpt_fbtc_tdma.finfo,
+					    sizeof(dm->tdma_now)));
+		break;
+	case BTC_RPT_TYPE_SLOT:
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): check %d %zu\n",
 			    __func__, BTC_DCNT_SLOT_NONSYNC,
 			    sizeof(dm->slot_now));
-
-		if (memcmp(dm->slot_now, pfwinfo->rpt_fbtc_slots.finfo.slot,
-			   sizeof(dm->slot_now)) != 0) {
-			for (i = 0; i < CXST_MAX; i++) {
-				rtp_slot =
-				&pfwinfo->rpt_fbtc_slots.finfo.slot[i];
-				if (memcmp(&dm->slot_now[i], rtp_slot,
-					   sizeof(dm->slot_now[i])) != 0) {
-					rtw89_debug(rtwdev, RTW89_DBG_BTC,
-						    "[BTC], %s(): %d slot_now[%d] dur=0x%04x tbl=%08x type=0x%04x\n",
-						    __func__,
-						    BTC_DCNT_SLOT_NONSYNC, i,
-						    dm->slot_now[i].dur,
-						    dm->slot_now[i].cxtbl,
-						    dm->slot_now[i].cxtype);
-
-					rtw89_debug(rtwdev, RTW89_DBG_BTC,
-						    "[BTC], %s(): %d rpt_fbtc_slots[%d] dur=0x%04x tbl=%08x type=0x%04x\n",
-						    __func__,
-						    BTC_DCNT_SLOT_NONSYNC, i,
-						    rtp_slot->dur,
-						    rtp_slot->cxtbl,
-						    rtp_slot->cxtype);
-				}
-			}
-		}
 		_chk_btc_err(rtwdev, BTC_DCNT_SLOT_NONSYNC,
 			     memcmp(dm->slot_now,
 				    pfwinfo->rpt_fbtc_slots.finfo.slot,
 				    sizeof(dm->slot_now)));
-	}
+		break;
+	case BTC_RPT_TYPE_CYSTA:
+		if (chip->chip_id == RTL8852A) {
+			if (pcysta->cycles < BTC_CYSTA_CHK_PERIOD)
+				break;
+			/* Check Leak-AP */
+			if (pcysta->slot_cnt[CXST_LK] != 0 &&
+			    pcysta->leakrx_cnt != 0 && dm->tdma_now.rxflctrl) {
+				if (pcysta->slot_cnt[CXST_LK] <
+				    BTC_LEAK_AP_TH * pcysta->leakrx_cnt)
+					dm->leak_ap = 1;
+			}
 
-	if (rpt_type == BTC_RPT_TYPE_CYSTA && chip->chip_id == RTL8852A &&
-	    pcysta->cycles >= BTC_CYSTA_CHK_PERIOD) {
-		/* Check Leak-AP */
-		if (pcysta->slot_cnt[CXST_LK] != 0 &&
-		    pcysta->leakrx_cnt != 0 && dm->tdma_now.rxflctrl) {
-			if (pcysta->slot_cnt[CXST_LK] <
-			    BTC_LEAK_AP_TH * pcysta->leakrx_cnt)
-				dm->leak_ap = 1;
-		}
+			/* Check diff time between WL slot and W1/E2G slot */
+			if (dm->tdma_now.type == CXTDMA_OFF &&
+			    dm->tdma_now.ext_ctrl == CXECTL_EXT)
+				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_E2G].dur);
+			else
+				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
 
-		/* Check diff time between WL slot and W1/E2G slot */
-		if (dm->tdma_now.type == CXTDMA_OFF &&
-		    dm->tdma_now.ext_ctrl == CXECTL_EXT)
-			wl_slot_set = le16_to_cpu(dm->slot_now[CXST_E2G].dur);
-		else
-			wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
+			if (pcysta->tavg_cycle[CXT_WL] > wl_slot_set) {
+				diff_t = pcysta->tavg_cycle[CXT_WL] - wl_slot_set;
+				_chk_btc_err(rtwdev,
+					     BTC_DCNT_WL_SLOT_DRIFT, diff_t);
+			}
 
-		if (pcysta->tavg_cycle[CXT_WL] > wl_slot_set) {
-			diff_t = pcysta->tavg_cycle[CXT_WL] - wl_slot_set;
-			_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, diff_t);
-		}
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
+				     pcysta->slot_cnt[CXST_W1]);
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
+				     pcysta->slot_cnt[CXST_B1]);
+			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
+				     (u32)pcysta->cycles);
+		} else {
+			if (le16_to_cpu(pcysta_v1->cycles) < BTC_CYSTA_CHK_PERIOD)
+				break;
 
-		_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE, pcysta->slot_cnt[CXST_W1]);
-		_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE, pcysta->slot_cnt[CXST_B1]);
-		_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE, (u32)pcysta->cycles);
-	} else if (rpt_type == BTC_RPT_TYPE_CYSTA && pcysta_v1 &&
-		   le16_to_cpu(pcysta_v1->cycles) >= BTC_CYSTA_CHK_PERIOD) {
-		cnt_leak_slot = le32_to_cpu(pcysta_v1->slot_cnt[CXST_LK]);
-		cnt_rx_imr = le32_to_cpu(pcysta_v1->leak_slot.cnt_rximr);
-		/* Check Leak-AP */
-		if (cnt_leak_slot != 0 && cnt_rx_imr != 0 &&
-		    dm->tdma_now.rxflctrl) {
-			if (cnt_leak_slot < BTC_LEAK_AP_TH * cnt_rx_imr)
-				dm->leak_ap = 1;
-		}
+			cnt_leak_slot = le32_to_cpu(pcysta_v1->slot_cnt[CXST_LK]);
+			cnt_rx_imr = le32_to_cpu(pcysta_v1->leak_slot.cnt_rximr);
 
-		/* Check diff time between real WL slot and W1 slot */
-		if (dm->tdma_now.type == CXTDMA_OFF) {
-			wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
-			wl_slot_real = le16_to_cpu(pcysta_v1->cycle_time.tavg[CXT_WL]);
-			if (wl_slot_real > wl_slot_set) {
-				diff_t = wl_slot_real - wl_slot_set;
-				_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, diff_t);
+			/* Check Leak-AP */
+			if (cnt_leak_slot != 0 && cnt_rx_imr != 0 &&
+			    dm->tdma_now.rxflctrl) {
+				if (cnt_leak_slot < BTC_LEAK_AP_TH * cnt_rx_imr)
+					dm->leak_ap = 1;
 			}
-		}
-
-		/* Check diff time between real BT slot and EBT/E5G slot */
-		if (dm->tdma_now.type == CXTDMA_OFF &&
-		    dm->tdma_now.ext_ctrl == CXECTL_EXT &&
-		    btc->bt_req_len != 0) {
-			bt_slot_real = le16_to_cpu(pcysta_v1->cycle_time.tavg[CXT_BT]);
 
-			if (btc->bt_req_len > bt_slot_real) {
-				diff_t = btc->bt_req_len - bt_slot_real;
-				_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_DRIFT, diff_t);
+			/* Check diff time between real WL slot and W1 slot */
+			if (dm->tdma_now.type == CXTDMA_OFF) {
+				wl_slot_set = le16_to_cpu(dm->slot_now[CXST_W1].dur);
+				wl_slot_real = le16_to_cpu(pcysta_v1->cycle_time.tavg[CXT_WL]);
+				if (wl_slot_real > wl_slot_set) {
+					diff_t = wl_slot_real - wl_slot_set;
+					_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, diff_t);
+				}
 			}
-		}
 
-		_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
-			     le32_to_cpu(pcysta_v1->slot_cnt[CXST_W1]));
-		_chk_btc_err(rtwdev, BTC_DCNT_B1_FREEZE,
-			     le32_to_cpu(pcysta_v1->slot_cnt[CXST_B1]));
-		_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
-			     (u32)le16_to_cpu(pcysta_v1->cycles));
-	}
-
-	if (rpt_type == BTC_RPT_TYPE_CTRL && chip->chip_id == RTL8852A) {
-		prpt = &pfwinfo->rpt_ctrl.finfo;
-		btc->fwinfo.rpt_en_map = prpt->rpt_enable;
-		wl->ver_info.fw_coex = prpt->wl_fw_coex_ver;
-		wl->ver_info.fw = prpt->wl_fw_ver;
-		dm->wl_fw_cx_offload = !!prpt->wl_fw_cx_offload;
+			/* Check diff time between real BT slot and EBT/E5G slot */
+			if (dm->tdma_now.type == CXTDMA_OFF &&
+			    dm->tdma_now.ext_ctrl == CXECTL_EXT &&
+			    btc->bt_req_len != 0) {
+				bt_slot_real = le16_to_cpu(pcysta_v1->cycle_time.tavg[CXT_BT]);
 
-		_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
-			     pfwinfo->event[BTF_EVNT_RPT]);
-
-		/* To avoid I/O if WL LPS or power-off */
-		if (wl->status.map.lps != BTC_LPS_RF_OFF && !wl->status.map.rf_off) {
-			rtwdev->chip->ops->btc_update_bt_cnt(rtwdev);
-			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
+				if (btc->bt_req_len > bt_slot_real) {
+					diff_t = btc->bt_req_len - bt_slot_real;
+					_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_DRIFT, diff_t);
+				}
+			}
 
-			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
-				rtw89_mac_get_plt_cnt(rtwdev, RTW89_MAC_0);
+			_chk_btc_err(rtwdev, BTC_DCNT_W1_FREEZE,
+				     le32_to_cpu(pcysta_v1->slot_cnt[CXST_W1]));
+			_chk_btc_err(rtwdev, BTC_DCNT_B1_FREEZE,
+				     le32_to_cpu(pcysta_v1->slot_cnt[CXST_B1]));
+			_chk_btc_err(rtwdev, BTC_DCNT_CYCLE_FREEZE,
+				     (u32)le16_to_cpu(pcysta_v1->cycles));
 		}
-	} else if (rpt_type == BTC_RPT_TYPE_CTRL) {
-		prpt_v1 = &pfwinfo->rpt_ctrl.finfo_v1;
-		btc->fwinfo.rpt_en_map = le32_to_cpu(prpt_v1->rpt_info.en);
-		wl->ver_info.fw_coex = le32_to_cpu(prpt_v1->wl_fw_info.cx_ver);
-		wl->ver_info.fw = le32_to_cpu(prpt_v1->wl_fw_info.fw_ver);
-		dm->wl_fw_cx_offload = !!le32_to_cpu(prpt_v1->wl_fw_info.cx_offload);
-
-		for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
-			memcpy(&dm->gnt.band[i], &prpt_v1->gnt_val[i],
-			       sizeof(dm->gnt.band[i]));
-
-		btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_HI_TX]);
-		btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_HI_RX]);
-		btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_LO_TX]);
-		btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_LO_RX]);
-		btc->cx.cnt_bt[BTC_BCNT_POLUT] = le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_POLLUTED]);
-
-		_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_FREEZE, 0);
-		_chk_btc_err(rtwdev, BTC_DCNT_RPT_FREEZE,
-			     pfwinfo->event[BTF_EVNT_RPT]);
-
-		if (le32_to_cpu(prpt_v1->bt_cnt[BTC_BCNT_RFK_TIMEOUT]) > 0)
-			bt->rfk_info.map.timeout = 1;
-		else
-			bt->rfk_info.map.timeout = 0;
-
-		dm->error.map.bt_rfk_timeout = bt->rfk_info.map.timeout;
-	}
-
-	if (rpt_type >= BTC_RPT_TYPE_BT_VER &&
-	    rpt_type <= BTC_RPT_TYPE_BT_DEVICE)
+		break;
+	case BTC_RPT_TYPE_BT_VER:
+	case BTC_RPT_TYPE_BT_SCAN:
+	case BTC_RPT_TYPE_BT_AFH:
+	case BTC_RPT_TYPE_BT_DEVICE:
 		_update_bt_report(rtwdev, rpt_type, pfinfo);
-
+		break;
+	}
 	return (rpt_len + BTC_RPT_HDR_SIZE);
 
 err:
-- 
2.25.1

