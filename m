Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C1252E60A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 09:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346226AbiETHSj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 03:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346006AbiETHSe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 03:18:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F59D3ED28
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 00:18:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24K7HvoZ6023741, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24K7HvoZ6023741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 May 2022 15:17:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 20 May 2022 15:17:57 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 20 May
 2022 15:17:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 6/6] rtw89: support MULTI_BSSID and correct BSSID mask of H2C
Date:   Fri, 20 May 2022 15:17:31 +0800
Message-ID: <20220520071731.38563-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520071731.38563-1-pkshih@realtek.com>
References: <20220520071731.38563-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/20/2022 06:55:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjAgpFekyCAwNjowMDowMA==?=
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
 drivers/net/wireless/realtek/rtw89/cam.c  | 9 +++++++++
 drivers/net/wireless/realtek/rtw89/cam.h  | 5 +++++
 drivers/net/wireless/realtek/rtw89/core.c | 1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 8a26adeb23fb2..b211ed2ea0722 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -599,14 +599,23 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *rtwvif, u8 *cmd)
 {
+#define BSSID_MATCH_ALL GENMASK(5, 0)
+#define BSSID_MATCH_5_BYTES GENMASK(4, 0)
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
 	u8 bss_color = vif->bss_conf.he_bss_color.color;
+	u8 bss_mask;
+
+	if (vif->bss_conf.nontransmitted)
+		bss_mask = BSSID_MATCH_5_BYTES;
+	else
+		bss_mask = BSSID_MATCH_ALL;
 
 	FWCMD_SET_ADDR_BSSID_IDX(cmd, bssid_cam->bssid_cam_idx);
 	FWCMD_SET_ADDR_BSSID_OFFSET(cmd, bssid_cam->offset);
 	FWCMD_SET_ADDR_BSSID_LEN(cmd, bssid_cam->len);
 	FWCMD_SET_ADDR_BSSID_VALID(cmd, bssid_cam->valid);
+	FWCMD_SET_ADDR_BSSID_MASK(cmd, bss_mask);
 	FWCMD_SET_ADDR_BSSID_BB_SEL(cmd, bssid_cam->phy_idx);
 	FWCMD_SET_ADDR_BSSID_BSS_COLOR(cmd, bss_color);
 
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index a3931d3e40d26..e6a1ce39e7fd0 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -309,6 +309,11 @@ static inline void FWCMD_SET_ADDR_BSSID_BB_SEL(void *cmd, u32 value)
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

