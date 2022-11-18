Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D388962ED15
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 06:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbiKRFLy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 00:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiKRFLr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 00:11:47 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EACBD6E540
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 21:11:45 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AI5AvdS6003114, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AI5AvdS6003114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 18 Nov 2022 13:10:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 18 Nov 2022 13:11:39 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 18 Nov
 2022 13:11:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: fw: implement MCC related H2C
Date:   Fri, 18 Nov 2022 13:10:41 +0800
Message-ID: <20221118051042.29968-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118051042.29968-1-pkshih@realtek.com>
References: <20221118051042.29968-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/18/2022 04:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzE3IKRVpMggMTA6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

These MCC H2C(s) require to wait for MCC C2H to determine if the
execution is successful. Through rtw89_wait_for_cond(), we make
them wait for either a completion with data from MCC C2H handlers,
which calls rtw89_complete_cond(), or timeout.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 329 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h | 369 +++++++++++++++++++++++-
 2 files changed, 697 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 544f6d4b68735..c469fd1322803 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3263,3 +3263,332 @@ int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+
+static int rtw89_h2c_tx_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
+				 struct rtw89_wait_info *wait, unsigned int cond)
+{
+	int ret;
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		dev_kfree_skb_any(skb);
+		return -EBUSY;
+	}
+
+	return rtw89_wait_for_cond(wait, cond);
+}
+
+#define H2C_ADD_MCC_LEN 16
+int rtw89_fw_h2c_add_mcc(struct rtw89_dev *rtwdev,
+			 const struct rtw89_fw_mcc_add_req *p)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_ADD_MCC_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for add mcc\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_ADD_MCC_LEN);
+	RTW89_SET_FWCMD_ADD_MCC_MACID(skb->data, p->macid);
+	RTW89_SET_FWCMD_ADD_MCC_CENTRAL_CH_SEG0(skb->data, p->central_ch_seg0);
+	RTW89_SET_FWCMD_ADD_MCC_CENTRAL_CH_SEG1(skb->data, p->central_ch_seg1);
+	RTW89_SET_FWCMD_ADD_MCC_PRIMARY_CH(skb->data, p->primary_ch);
+	RTW89_SET_FWCMD_ADD_MCC_BANDWIDTH(skb->data, p->bandwidth);
+	RTW89_SET_FWCMD_ADD_MCC_GROUP(skb->data, p->group);
+	RTW89_SET_FWCMD_ADD_MCC_C2H_RPT(skb->data, p->c2h_rpt);
+	RTW89_SET_FWCMD_ADD_MCC_DIS_TX_NULL(skb->data, p->dis_tx_null);
+	RTW89_SET_FWCMD_ADD_MCC_DIS_SW_RETRY(skb->data, p->dis_sw_retry);
+	RTW89_SET_FWCMD_ADD_MCC_IN_CURR_CH(skb->data, p->in_curr_ch);
+	RTW89_SET_FWCMD_ADD_MCC_SW_RETRY_COUNT(skb->data, p->sw_retry_count);
+	RTW89_SET_FWCMD_ADD_MCC_TX_NULL_EARLY(skb->data, p->tx_null_early);
+	RTW89_SET_FWCMD_ADD_MCC_BTC_IN_2G(skb->data, p->btc_in_2g);
+	RTW89_SET_FWCMD_ADD_MCC_PTA_EN(skb->data, p->pta_en);
+	RTW89_SET_FWCMD_ADD_MCC_RFK_BY_PASS(skb->data, p->rfk_by_pass);
+	RTW89_SET_FWCMD_ADD_MCC_CH_BAND_TYPE(skb->data, p->ch_band_type);
+	RTW89_SET_FWCMD_ADD_MCC_DURATION(skb->data, p->duration);
+	RTW89_SET_FWCMD_ADD_MCC_COURTESY_EN(skb->data, p->courtesy_en);
+	RTW89_SET_FWCMD_ADD_MCC_COURTESY_NUM(skb->data, p->courtesy_num);
+	RTW89_SET_FWCMD_ADD_MCC_COURTESY_TARGET(skb->data, p->courtesy_target);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MCC,
+			      H2C_FUNC_ADD_MCC, 0, 0,
+			      H2C_ADD_MCC_LEN);
+
+	cond = RTW89_MCC_WAIT_COND(p->group, H2C_FUNC_ADD_MCC);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
+#define H2C_START_MCC_LEN 12
+int rtw89_fw_h2c_start_mcc(struct rtw89_dev *rtwdev,
+			   const struct rtw89_fw_mcc_start_req *p)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_START_MCC_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for start mcc\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_START_MCC_LEN);
+	RTW89_SET_FWCMD_START_MCC_GROUP(skb->data, p->group);
+	RTW89_SET_FWCMD_START_MCC_BTC_IN_GROUP(skb->data, p->btc_in_group);
+	RTW89_SET_FWCMD_START_MCC_OLD_GROUP_ACTION(skb->data, p->old_group_action);
+	RTW89_SET_FWCMD_START_MCC_OLD_GROUP(skb->data, p->old_group);
+	RTW89_SET_FWCMD_START_MCC_NOTIFY_CNT(skb->data, p->notify_cnt);
+	RTW89_SET_FWCMD_START_MCC_NOTIFY_RXDBG_EN(skb->data, p->notify_rxdbg_en);
+	RTW89_SET_FWCMD_START_MCC_MACID(skb->data, p->macid);
+	RTW89_SET_FWCMD_START_MCC_TSF_LOW(skb->data, p->tsf_low);
+	RTW89_SET_FWCMD_START_MCC_TSF_HIGH(skb->data, p->tsf_high);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MCC,
+			      H2C_FUNC_START_MCC, 0, 0,
+			      H2C_START_MCC_LEN);
+
+	cond = RTW89_MCC_WAIT_COND(p->group, H2C_FUNC_START_MCC);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
+#define H2C_STOP_MCC_LEN 4
+int rtw89_fw_h2c_stop_mcc(struct rtw89_dev *rtwdev, u8 group, u8 macid,
+			  bool prev_groups)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_STOP_MCC_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for stop mcc\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_STOP_MCC_LEN);
+	RTW89_SET_FWCMD_STOP_MCC_MACID(skb->data, macid);
+	RTW89_SET_FWCMD_STOP_MCC_GROUP(skb->data, group);
+	RTW89_SET_FWCMD_STOP_MCC_PREV_GROUPS(skb->data, prev_groups);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MCC,
+			      H2C_FUNC_STOP_MCC, 0, 0,
+			      H2C_STOP_MCC_LEN);
+
+	cond = RTW89_MCC_WAIT_COND(group, H2C_FUNC_STOP_MCC);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
+#define H2C_DEL_MCC_GROUP_LEN 4
+int rtw89_fw_h2c_del_mcc_group(struct rtw89_dev *rtwdev, u8 group,
+			       bool prev_groups)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_DEL_MCC_GROUP_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for del mcc group\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_DEL_MCC_GROUP_LEN);
+	RTW89_SET_FWCMD_DEL_MCC_GROUP_GROUP(skb->data, group);
+	RTW89_SET_FWCMD_DEL_MCC_GROUP_PREV_GROUPS(skb->data, prev_groups);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MCC,
+			      H2C_FUNC_DEL_MCC_GROUP, 0, 0,
+			      H2C_DEL_MCC_GROUP_LEN);
+
+	cond = RTW89_MCC_WAIT_COND(group, H2C_FUNC_DEL_MCC_GROUP);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
+#define H2C_RESET_MCC_GROUP_LEN 4
+int rtw89_fw_h2c_reset_mcc_group(struct rtw89_dev *rtwdev, u8 group)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_RESET_MCC_GROUP_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for reset mcc group\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_RESET_MCC_GROUP_LEN);
+	RTW89_SET_FWCMD_RESET_MCC_GROUP_GROUP(skb->data, group);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MCC,
+			      H2C_FUNC_RESET_MCC_GROUP, 0, 0,
+			      H2C_RESET_MCC_GROUP_LEN);
+
+	cond = RTW89_MCC_WAIT_COND(group, H2C_FUNC_RESET_MCC_GROUP);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
+#define H2C_MCC_REQ_TSF_LEN 4
+int rtw89_fw_h2c_mcc_req_tsf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_fw_mcc_tsf_req *req,
+			     struct rtw89_mac_mcc_tsf_rpt *rpt)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct rtw89_mac_mcc_tsf_rpt *tmp;
+	struct sk_buff *skb;
+	unsigned int cond;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_MCC_REQ_TSF_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for mcc req tsf\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_MCC_REQ_TSF_LEN);
+	RTW89_SET_FWCMD_MCC_REQ_TSF_GROUP(skb->data, req->group);
+	RTW89_SET_FWCMD_MCC_REQ_TSF_MACID_X(skb->data, req->macid_x);
+	RTW89_SET_FWCMD_MCC_REQ_TSF_MACID_Y(skb->data, req->macid_y);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MCC,
+			      H2C_FUNC_MCC_REQ_TSF, 0, 0,
+			      H2C_MCC_REQ_TSF_LEN);
+
+	cond = RTW89_MCC_WAIT_COND(req->group, H2C_FUNC_MCC_REQ_TSF);
+	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+	if (ret)
+		return ret;
+
+	tmp = rtw89_completion_cast(&wait->data, rpt);
+	*rpt = *tmp;
+
+	return 0;
+}
+
+#define H2C_MCC_MACID_BITMAP_DSC_LEN 4
+int rtw89_fw_h2c_mcc_macid_bitamp(struct rtw89_dev *rtwdev, u8 group, u8 macid,
+				  u8 *bitmap)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct sk_buff *skb;
+	unsigned int cond;
+	u8 map_len;
+	u8 h2c_len;
+
+	BUILD_BUG_ON(RTW89_MAX_MAC_ID_NUM % 8);
+	map_len = RTW89_MAX_MAC_ID_NUM / 8;
+	h2c_len = H2C_MCC_MACID_BITMAP_DSC_LEN + map_len;
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, h2c_len);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for mcc macid bitmap\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, h2c_len);
+	RTW89_SET_FWCMD_MCC_MACID_BITMAP_GROUP(skb->data, group);
+	RTW89_SET_FWCMD_MCC_MACID_BITMAP_MACID(skb->data, macid);
+	RTW89_SET_FWCMD_MCC_MACID_BITMAP_BITMAP_LENGTH(skb->data, map_len);
+	RTW89_SET_FWCMD_MCC_MACID_BITMAP_BITMAP(skb->data, bitmap, map_len);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MCC,
+			      H2C_FUNC_MCC_MACID_BITMAP, 0, 0,
+			      h2c_len);
+
+	cond = RTW89_MCC_WAIT_COND(group, H2C_FUNC_MCC_MACID_BITMAP);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
+#define H2C_MCC_SYNC_LEN 4
+int rtw89_fw_h2c_mcc_sync(struct rtw89_dev *rtwdev, u8 group, u8 source,
+			  u8 target, u8 offset)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_MCC_SYNC_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for mcc sync\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_MCC_SYNC_LEN);
+	RTW89_SET_FWCMD_MCC_SYNC_GROUP(skb->data, group);
+	RTW89_SET_FWCMD_MCC_SYNC_MACID_SOURCE(skb->data, source);
+	RTW89_SET_FWCMD_MCC_SYNC_MACID_TARGET(skb->data, target);
+	RTW89_SET_FWCMD_MCC_SYNC_SYNC_OFFSET(skb->data, offset);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MCC,
+			      H2C_FUNC_MCC_SYNC, 0, 0,
+			      H2C_MCC_SYNC_LEN);
+
+	cond = RTW89_MCC_WAIT_COND(group, H2C_FUNC_MCC_SYNC);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
+#define H2C_MCC_SET_DURATION_LEN 20
+int rtw89_fw_h2c_mcc_set_duration(struct rtw89_dev *rtwdev,
+				  const struct rtw89_fw_mcc_duration *p)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_MCC_SET_DURATION_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for mcc set duration\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_MCC_SET_DURATION_LEN);
+	RTW89_SET_FWCMD_MCC_SET_DURATION_GROUP(skb->data, p->group);
+	RTW89_SET_FWCMD_MCC_SET_DURATION_BTC_IN_GROUP(skb->data, p->btc_in_group);
+	RTW89_SET_FWCMD_MCC_SET_DURATION_START_MACID(skb->data, p->start_macid);
+	RTW89_SET_FWCMD_MCC_SET_DURATION_MACID_X(skb->data, p->macid_x);
+	RTW89_SET_FWCMD_MCC_SET_DURATION_MACID_Y(skb->data, p->macid_y);
+	RTW89_SET_FWCMD_MCC_SET_DURATION_START_TSF_LOW(skb->data,
+						       p->start_tsf_low);
+	RTW89_SET_FWCMD_MCC_SET_DURATION_START_TSF_HIGH(skb->data,
+							p->start_tsf_high);
+	RTW89_SET_FWCMD_MCC_SET_DURATION_DURATION_X(skb->data, p->duration_x);
+	RTW89_SET_FWCMD_MCC_SET_DURATION_DURATION_Y(skb->data, p->duration_y);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MCC,
+			      H2C_FUNC_MCC_SET_DURATION, 0, 0,
+			      H2C_MCC_SET_DURATION_LEN);
+
+	cond = RTW89_MCC_WAIT_COND(p->group, H2C_FUNC_MCC_SET_DURATION);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 6d9c3dc58f037..6d53d1a6c907c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2767,6 +2767,355 @@ static inline void RTW89_SET_FWCMD_TSF32_TOGL_EARLY(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 16));
 }
 
+enum rtw89_fw_mcc_c2h_rpt_cfg {
+	RTW89_FW_MCC_C2H_RPT_OFF	= 0,
+	RTW89_FW_MCC_C2H_RPT_FAIL_ONLY	= 1,
+	RTW89_FW_MCC_C2H_RPT_ALL	= 2,
+};
+
+struct rtw89_fw_mcc_add_req {
+	u8 macid;
+	u8 central_ch_seg0;
+	u8 central_ch_seg1;
+	u8 primary_ch;
+	enum rtw89_bandwidth bandwidth: 4;
+	u32 group: 2;
+	u32 c2h_rpt: 2;
+	u32 dis_tx_null: 1;
+	u32 dis_sw_retry: 1;
+	u32 in_curr_ch: 1;
+	u32 sw_retry_count: 3;
+	u32 tx_null_early: 4;
+	u32 btc_in_2g: 1;
+	u32 pta_en: 1;
+	u32 rfk_by_pass: 1;
+	u32 ch_band_type: 2;
+	u32 rsvd0: 9;
+	u32 duration;
+	u8 courtesy_en;
+	u8 courtesy_num;
+	u8 courtesy_target;
+	u8 rsvd1;
+};
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_MACID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_CENTRAL_CH_SEG0(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_CENTRAL_CH_SEG1(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_PRIMARY_CH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_BANDWIDTH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(3, 0));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(5, 4));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_C2H_RPT(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(7, 6));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_DIS_TX_NULL(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, BIT(8));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_DIS_SW_RETRY(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, BIT(9));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_IN_CURR_CH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, BIT(10));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_SW_RETRY_COUNT(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(13, 11));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_TX_NULL_EARLY(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(17, 14));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_BTC_IN_2G(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, BIT(18));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_PTA_EN(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, BIT(19));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_RFK_BY_PASS(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, BIT(20));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_CH_BAND_TYPE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(22, 21));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_DURATION(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 2, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_COURTESY_EN(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 3, val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_COURTESY_NUM(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 3, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_ADD_MCC_COURTESY_TARGET(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 3, val, GENMASK(23, 16));
+}
+
+struct rtw89_fw_mcc_start_req {
+	u32 group: 2;
+	u32 btc_in_group: 1;
+	u32 old_group_action: 2;
+	u32 old_group: 2;
+	u32 rsvd0: 9;
+	u32 notify_cnt: 3;
+	u32 rsvd1: 2;
+	u32 notify_rxdbg_en: 1;
+	u32 rsvd2: 2;
+	u32 macid: 8;
+	u32 tsf_low;
+	u32 tsf_high;
+};
+
+static inline void RTW89_SET_FWCMD_START_MCC_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(1, 0));
+}
+
+static inline void RTW89_SET_FWCMD_START_MCC_BTC_IN_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, BIT(2));
+}
+
+static inline void RTW89_SET_FWCMD_START_MCC_OLD_GROUP_ACTION(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(4, 3));
+}
+
+static inline void RTW89_SET_FWCMD_START_MCC_OLD_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(6, 5));
+}
+
+static inline void RTW89_SET_FWCMD_START_MCC_NOTIFY_CNT(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(18, 16));
+}
+
+static inline void RTW89_SET_FWCMD_START_MCC_NOTIFY_RXDBG_EN(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, BIT(21));
+}
+
+static inline void RTW89_SET_FWCMD_START_MCC_MACID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_FWCMD_START_MCC_TSF_LOW(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_START_MCC_TSF_HIGH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 2, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_STOP_MCC_MACID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_STOP_MCC_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(9, 8));
+}
+
+static inline void RTW89_SET_FWCMD_STOP_MCC_PREV_GROUPS(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, BIT(10));
+}
+
+static inline void RTW89_SET_FWCMD_DEL_MCC_GROUP_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(1, 0));
+}
+
+static inline void RTW89_SET_FWCMD_DEL_MCC_GROUP_PREV_GROUPS(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, BIT(2));
+}
+
+static inline void RTW89_SET_FWCMD_RESET_MCC_GROUP_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(1, 0));
+}
+
+struct rtw89_fw_mcc_tsf_req {
+	u8 group: 2;
+	u8 rsvd0: 6;
+	u8 macid_x;
+	u8 macid_y;
+	u8 rsvd1;
+};
+
+static inline void RTW89_SET_FWCMD_MCC_REQ_TSF_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(1, 0));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_REQ_TSF_MACID_X(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_REQ_TSF_MACID_Y(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_MACID_BITMAP_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(1, 0));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_MACID_BITMAP_MACID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_MACID_BITMAP_BITMAP_LENGTH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_MACID_BITMAP_BITMAP(void *cmd,
+							   u8 *bitmap, u8 len)
+{
+	memcpy((__le32 *)cmd + 1, bitmap, len);
+}
+
+static inline void RTW89_SET_FWCMD_MCC_SYNC_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(1, 0));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_SYNC_MACID_SOURCE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_SYNC_MACID_TARGET(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_SYNC_SYNC_OFFSET(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 24));
+}
+
+struct rtw89_fw_mcc_duration {
+	u32 group: 2;
+	u32 btc_in_group: 1;
+	u32 rsvd0: 5;
+	u32 start_macid: 8;
+	u32 macid_x: 8;
+	u32 macid_y: 8;
+	u32 start_tsf_low;
+	u32 start_tsf_high;
+	u32 duration_x;
+	u32 duration_y;
+};
+
+static inline void RTW89_SET_FWCMD_MCC_SET_DURATION_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(1, 0));
+}
+
+static
+inline void RTW89_SET_FWCMD_MCC_SET_DURATION_BTC_IN_GROUP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, BIT(2));
+}
+
+static
+inline void RTW89_SET_FWCMD_MCC_SET_DURATION_START_MACID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_SET_DURATION_MACID_X(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_MCC_SET_DURATION_MACID_Y(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 24));
+}
+
+static
+inline void RTW89_SET_FWCMD_MCC_SET_DURATION_START_TSF_LOW(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(31, 0));
+}
+
+static
+inline void RTW89_SET_FWCMD_MCC_SET_DURATION_START_TSF_HIGH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 2, val, GENMASK(31, 0));
+}
+
+static
+inline void RTW89_SET_FWCMD_MCC_SET_DURATION_DURATION_X(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 3, val, GENMASK(31, 0));
+}
+
+static
+inline void RTW89_SET_FWCMD_MCC_SET_DURATION_DURATION_Y(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 4, val, GENMASK(31, 0));
+}
+
 #define RTW89_C2H_HEADER_LEN 8
 
 #define RTW89_GET_C2H_CATEGORY(c2h) \
@@ -3183,9 +3532,27 @@ int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			    bool enable);
 int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif, bool enable);
-
 int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
 			    struct rtw89_wow_cam_info *cam_info);
+int rtw89_fw_h2c_add_mcc(struct rtw89_dev *rtwdev,
+			 const struct rtw89_fw_mcc_add_req *p);
+int rtw89_fw_h2c_start_mcc(struct rtw89_dev *rtwdev,
+			   const struct rtw89_fw_mcc_start_req *p);
+int rtw89_fw_h2c_stop_mcc(struct rtw89_dev *rtwdev, u8 group, u8 macid,
+			  bool prev_groups);
+int rtw89_fw_h2c_del_mcc_group(struct rtw89_dev *rtwdev, u8 group,
+			       bool prev_groups);
+int rtw89_fw_h2c_reset_mcc_group(struct rtw89_dev *rtwdev, u8 group);
+int rtw89_fw_h2c_mcc_req_tsf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_fw_mcc_tsf_req *req,
+			     struct rtw89_mac_mcc_tsf_rpt *rpt);
+int rtw89_fw_h2c_mcc_macid_bitamp(struct rtw89_dev *rtwdev, u8 group, u8 macid,
+				  u8 *bitmap);
+int rtw89_fw_h2c_mcc_sync(struct rtw89_dev *rtwdev, u8 group, u8 source,
+			  u8 target, u8 offset);
+int rtw89_fw_h2c_mcc_set_duration(struct rtw89_dev *rtwdev,
+				  const struct rtw89_fw_mcc_duration *p);
+
 static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-- 
2.25.1

