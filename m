Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF275379DE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiE3L2b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbiE3L20 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 07:28:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253DC4B86D
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 04:28:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24UBRsLF2026618, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24UBRsLF2026618
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 May 2022 19:27:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 30 May 2022 19:27:54 +0800
Received: from localhost (172.16.20.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 30 May
 2022 19:27:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] rtw89: support MULTI_BSSID and correct BSSID mask of H2C
Date:   Mon, 30 May 2022 19:27:43 +0800
Message-ID: <20220530112743.106857-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.31]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/30/2022 11:08:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMzAgpFekyCAwOTowMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The BSSID mask of H2C is used to match BSSID of receiving packets.
Normally, we set six bits BSSID mask to exactly match BSSID of packets
sent by target AP. After we support multiple BSSID, it could connect a
nontransmitted BSSID, so we can only match first five bytes of BSSID.
That means we could possibly receive other AP's packets if only the last
byte of BSSID is different from target AP.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: add RTW89_ prefix to name of #define, and move to proper place.
---
 drivers/net/wireless/realtek/rtw89/cam.c  | 7 +++++++
 drivers/net/wireless/realtek/rtw89/cam.h  | 8 ++++++++
 drivers/net/wireless/realtek/rtw89/core.c | 1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 8a26adeb23fb2..db3c55f0ccd0d 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -602,11 +602,18 @@ int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
 	u8 bss_color = vif->bss_conf.he_bss_color.color;
+	u8 bss_mask;
+
+	if (vif->bss_conf.nontransmitted)
+		bss_mask = RTW89_BSSID_MATCH_5_BYTES;
+	else
+		bss_mask = RTW89_BSSID_MATCH_ALL;
 
 	FWCMD_SET_ADDR_BSSID_IDX(cmd, bssid_cam->bssid_cam_idx);
 	FWCMD_SET_ADDR_BSSID_OFFSET(cmd, bssid_cam->offset);
 	FWCMD_SET_ADDR_BSSID_LEN(cmd, bssid_cam->len);
 	FWCMD_SET_ADDR_BSSID_VALID(cmd, bssid_cam->valid);
+	FWCMD_SET_ADDR_BSSID_MASK(cmd, bss_mask);
 	FWCMD_SET_ADDR_BSSID_BB_SEL(cmd, bssid_cam->phy_idx);
 	FWCMD_SET_ADDR_BSSID_BSS_COLOR(cmd, bss_color);
 
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index a3931d3e40d26..74a6c4748d64f 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -9,6 +9,9 @@
 
 #define RTW89_SEC_CAM_LEN	20
 
+#define RTW89_BSSID_MATCH_ALL GENMASK(5, 0)
+#define RTW89_BSSID_MATCH_5_BYTES GENMASK(4, 0)
+
 static inline void FWCMD_SET_ADDR_IDX(void *cmd, u32 value)
 {
 	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(7, 0));
@@ -309,6 +312,11 @@ static inline void FWCMD_SET_ADDR_BSSID_BB_SEL(void *cmd, u32 value)
 	le32p_replace_bits((__le32 *)(cmd) + 13, value, BIT(1));
 }
 
+static inline void FWCMD_SET_ADDR_BSSID_MASK(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(7, 2));
+}
+
 static inline void FWCMD_SET_ADDR_BSSID_BSS_COLOR(void *cmd, u32 value)
 {
 	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(13, 8));
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 958fe2787c6a1..4df81f00c2211 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3011,6 +3011,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
+	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				     BIT(NL80211_IFTYPE_AP);
-- 
2.25.1

