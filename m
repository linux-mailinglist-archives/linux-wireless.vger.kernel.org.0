Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9A6DE8DC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 03:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDLB24 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 21:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLB2z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 21:28:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF788107
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 18:28:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33C1SPc14009287, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33C1SPc14009287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 12 Apr 2023 09:28:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 12 Apr 2023 09:28:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Apr
 2023 09:28:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: coex: send more hardware module info to firmware for 8851B
Date:   Wed, 12 Apr 2023 09:28:31 +0800
Message-ID: <20230412012831.10519-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412012831.10519-1-pkshih@realtek.com>
References: <20230412012831.10519-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

8851B has various hardware module types, so BT coexistence in firmware
needs these information to make decision. Add them to make 8851B work
well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |   5 +-
 drivers/net/wireless/realtek/rtw89/fw.c   |  64 ++++++------
 drivers/net/wireless/realtek/rtw89/fw.h   | 113 +++++++---------------
 3 files changed, 75 insertions(+), 107 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 40fb18b613d90..dc57ea5877513 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -957,6 +957,8 @@ struct rtw89_btc_ant_info {
 
 	u8 single_pos: 1;/* Single antenna at S0 or S1 */
 	u8 diversity: 1;
+	u8 btg_pos: 2;
+	u8 stream_cnt: 4;
 };
 
 enum rtw89_tfc_dir {
@@ -1413,8 +1415,9 @@ struct rtw89_btc_module {
 	u8 bt_solo: 1;
 	u8 bt_pos: 1;
 	u8 switch_type: 1;
+	u8 wa_type: 3;
 
-	u8 rsvd;
+	u8 kt_ver_adie;
 };
 
 #define RTW89_BTC_DM_MAXSTEP 30
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5fa6863d36b30..ebaf4559a04e5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1806,8 +1806,6 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 	return ret;
 }
 
-#define H2C_LEN_CXDRVHDR 2
-#define H2C_LEN_CXDRVINFO_INIT (12 + H2C_LEN_CXDRVHDR)
 int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -1815,44 +1813,52 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_init_info *init_info = &dm->init_info;
 	struct rtw89_btc_module *module = &init_info->module;
 	struct rtw89_btc_ant_info *ant = &module->ant;
+	struct rtw89_h2c_cxinit *h2c;
+	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
-	u8 *cmd;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_INIT);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_init\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_LEN_CXDRVINFO_INIT);
-	cmd = skb->data;
-
-	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_INIT);
-	RTW89_SET_FWCMD_CXHDR_LEN(cmd, H2C_LEN_CXDRVINFO_INIT - H2C_LEN_CXDRVHDR);
-
-	RTW89_SET_FWCMD_CXINIT_ANT_TYPE(cmd, ant->type);
-	RTW89_SET_FWCMD_CXINIT_ANT_NUM(cmd, ant->num);
-	RTW89_SET_FWCMD_CXINIT_ANT_ISO(cmd, ant->isolation);
-	RTW89_SET_FWCMD_CXINIT_ANT_POS(cmd, ant->single_pos);
-	RTW89_SET_FWCMD_CXINIT_ANT_DIVERSITY(cmd, ant->diversity);
-
-	RTW89_SET_FWCMD_CXINIT_MOD_RFE(cmd, module->rfe_type);
-	RTW89_SET_FWCMD_CXINIT_MOD_CV(cmd, module->cv);
-	RTW89_SET_FWCMD_CXINIT_MOD_BT_SOLO(cmd, module->bt_solo);
-	RTW89_SET_FWCMD_CXINIT_MOD_BT_POS(cmd, module->bt_pos);
-	RTW89_SET_FWCMD_CXINIT_MOD_SW_TYPE(cmd, module->switch_type);
-
-	RTW89_SET_FWCMD_CXINIT_WL_GCH(cmd, init_info->wl_guard_ch);
-	RTW89_SET_FWCMD_CXINIT_WL_ONLY(cmd, init_info->wl_only);
-	RTW89_SET_FWCMD_CXINIT_WL_INITOK(cmd, init_info->wl_init_ok);
-	RTW89_SET_FWCMD_CXINIT_DBCC_EN(cmd, init_info->dbcc_en);
-	RTW89_SET_FWCMD_CXINIT_CX_OTHER(cmd, init_info->cx_other);
-	RTW89_SET_FWCMD_CXINIT_BT_ONLY(cmd, init_info->bt_only);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxinit *)skb->data;
+
+	h2c->hdr.type = CXDRVINFO_INIT;
+	h2c->hdr.len = len - H2C_LEN_CXDRVHDR;
+
+	h2c->ant_type = ant->type;
+	h2c->ant_num = ant->num;
+	h2c->ant_iso = ant->isolation;
+	h2c->ant_info =
+		u8_encode_bits(ant->single_pos, RTW89_H2C_CXINIT_ANT_INFO_POS) |
+		u8_encode_bits(ant->diversity, RTW89_H2C_CXINIT_ANT_INFO_DIVERSITY) |
+		u8_encode_bits(ant->btg_pos, RTW89_H2C_CXINIT_ANT_INFO_BTG_POS) |
+		u8_encode_bits(ant->stream_cnt, RTW89_H2C_CXINIT_ANT_INFO_STREAM_CNT);
+
+	h2c->mod_rfe = module->rfe_type;
+	h2c->mod_cv = module->cv;
+	h2c->mod_info =
+		u8_encode_bits(module->bt_solo, RTW89_H2C_CXINIT_MOD_INFO_BT_SOLO) |
+		u8_encode_bits(module->bt_pos, RTW89_H2C_CXINIT_MOD_INFO_BT_POS) |
+		u8_encode_bits(module->switch_type, RTW89_H2C_CXINIT_MOD_INFO_SW_TYPE) |
+		u8_encode_bits(module->wa_type, RTW89_H2C_CXINIT_MOD_INFO_WA_TYPE);
+	h2c->mod_adie_kt = module->kt_ver_adie;
+	h2c->wl_gch = init_info->wl_guard_ch;
+
+	h2c->info =
+		u8_encode_bits(init_info->wl_only, RTW89_H2C_CXINIT_INFO_WL_ONLY) |
+		u8_encode_bits(init_info->wl_init_ok, RTW89_H2C_CXINIT_INFO_WL_INITOK) |
+		u8_encode_bits(init_info->dbcc_en, RTW89_H2C_CXINIT_INFO_DBCC_EN) |
+		u8_encode_bits(init_info->cx_other, RTW89_H2C_CXINIT_INFO_CX_OTHER) |
+		u8_encode_bits(init_info->bt_only, RTW89_H2C_CXINIT_INFO_BT_ONLY);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
 			      SET_DRV_INFO, 0, 0,
-			      H2C_LEN_CXDRVINFO_INIT);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index c3c67ddf61a24..bc7850ac41a19 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2174,85 +2174,44 @@ static inline void RTW89_SET_FWCMD_CXHDR_LEN(void *cmd, u8 val)
 	u8p_replace_bits((u8 *)(cmd) + 1, val, GENMASK(7, 0));
 }
 
-static inline void RTW89_SET_FWCMD_CXINIT_ANT_TYPE(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 2, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_ANT_NUM(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 3, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_ANT_ISO(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 4, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_ANT_POS(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 5, val, BIT(0));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_ANT_DIVERSITY(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 5, val, BIT(1));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_MOD_RFE(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 6, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_MOD_CV(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 7, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_MOD_BT_SOLO(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 8, val, BIT(0));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_MOD_BT_POS(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 8, val, BIT(1));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_MOD_SW_TYPE(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 8, val, BIT(2));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_WL_GCH(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 10, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_WL_ONLY(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(0));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_WL_INITOK(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(1));
-}
-
-static inline void RTW89_SET_FWCMD_CXINIT_DBCC_EN(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(2));
-}
+struct rtw89_h2c_cxhdr {
+	u8 type;
+	u8 len;
+} __packed;
 
-static inline void RTW89_SET_FWCMD_CXINIT_CX_OTHER(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(3));
-}
+#define H2C_LEN_CXDRVHDR sizeof(struct rtw89_h2c_cxhdr)
+
+struct rtw89_h2c_cxinit {
+	struct rtw89_h2c_cxhdr hdr;
+	u8 ant_type;
+	u8 ant_num;
+	u8 ant_iso;
+	u8 ant_info;
+	u8 mod_rfe;
+	u8 mod_cv;
+	u8 mod_info;
+	u8 mod_adie_kt;
+	u8 wl_gch;
+	u8 info;
+	u8 rsvd;
+	u8 rsvd1;
+} __packed;
 
-static inline void RTW89_SET_FWCMD_CXINIT_BT_ONLY(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(4));
-}
+#define RTW89_H2C_CXINIT_ANT_INFO_POS BIT(0)
+#define RTW89_H2C_CXINIT_ANT_INFO_DIVERSITY BIT(1)
+#define RTW89_H2C_CXINIT_ANT_INFO_BTG_POS GENMASK(3, 2)
+#define RTW89_H2C_CXINIT_ANT_INFO_STREAM_CNT GENMASK(7, 4)
+
+#define RTW89_H2C_CXINIT_MOD_INFO_BT_SOLO BIT(0)
+#define RTW89_H2C_CXINIT_MOD_INFO_BT_POS BIT(1)
+#define RTW89_H2C_CXINIT_MOD_INFO_SW_TYPE BIT(2)
+#define RTW89_H2C_CXINIT_MOD_INFO_WA_TYPE GENMASK(5, 3)
+
+#define RTW89_H2C_CXINIT_INFO_WL_ONLY BIT(0)
+#define RTW89_H2C_CXINIT_INFO_WL_INITOK BIT(1)
+#define RTW89_H2C_CXINIT_INFO_DBCC_EN BIT(2)
+#define RTW89_H2C_CXINIT_INFO_CX_OTHER BIT(3)
+#define RTW89_H2C_CXINIT_INFO_BT_ONLY BIT(4)
 
 static inline void RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(void *cmd, u8 val)
 {
-- 
2.25.1

