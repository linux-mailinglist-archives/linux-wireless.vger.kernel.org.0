Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562DD5E57FD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 03:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiIVB2H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 21:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIVB2F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 21:28:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8B459F767
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 18:28:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28M1RUqR4008362, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28M1RUqR4008362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 22 Sep 2022 09:27:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 09:27:54 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 22 Sep
 2022 09:27:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: disable 26-tone RU HE TB PPDU transmissions
Date:   Thu, 22 Sep 2022 09:27:19 +0800
Message-ID: <20220922012719.15037-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/22/2022 01:08:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjEgpFWkyCAxMDo1MjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kuan-Chung Chen <damon.chen@realtek.com>

Align with the spec of 802.11ax, follow the conditions for not responding
with an HE TB PPDU. When there are OBSS that cannot interpret 26-tone RU
transmissions, we should disable such transmissions.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 44 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  2 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 +
 3 files changed, 47 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index dad55952e6bdc..5ab80bceb7d7a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3703,6 +3703,50 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	return 0;
 }
 
+static void rtw89_mac_check_he_obss_narrow_bw_ru_iter(struct wiphy *wiphy,
+						      struct cfg80211_bss *bss,
+						      void *data)
+{
+	const struct cfg80211_bss_ies *ies;
+	const struct element *elem;
+	bool *tolerated = data;
+
+	rcu_read_lock();
+	ies = rcu_dereference(bss->ies);
+	elem = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY, ies->data,
+				  ies->len);
+
+	if (!elem || elem->datalen < 10 ||
+	    !(elem->data[10] & WLAN_EXT_CAPA10_OBSS_NARROW_BW_RU_TOLERANCE_SUPPORT))
+		*tolerated = false;
+	rcu_read_unlock();
+}
+
+void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
+					struct ieee80211_vif *vif)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct ieee80211_hw *hw = rtwdev->hw;
+	bool tolerated = true;
+	u32 reg;
+
+	if (!vif->bss_conf.he_support || vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (!(vif->bss_conf.chandef.chan->flags & IEEE80211_CHAN_RADAR))
+		return;
+
+	cfg80211_bss_iter(hw->wiphy, &vif->bss_conf.chandef,
+			  rtw89_mac_check_he_obss_narrow_bw_ru_iter,
+			  &tolerated);
+
+	reg = rtw89_mac_reg_by_idx(R_AX_RXTRIG_TEST_USER_2, rtwvif->mac_idx);
+	if (tolerated)
+		rtw89_write32_clr(rtwdev, reg, B_AX_RXTRIG_RU26_DIS);
+	else
+		rtw89_write32_set(rtwdev, reg, B_AX_RXTRIG_RU26_DIS);
+}
+
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 22db80716b560..04c001b1847d8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -800,6 +800,8 @@ int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val);
 int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val);
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
+					struct ieee80211_vif *vif);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev);
 void rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index e82be57f291c0..6052a2f7ad218 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -356,6 +356,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw89_phy_set_bss_color(rtwdev, vif);
 			rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, vif);
 			rtw89_mac_port_update(rtwdev, rtwvif);
+			rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, vif);
 			rtw89_store_op_chan(rtwdev, true);
 		} else {
 			/* Abort ongoing scan if cancel_scan isn't issued
-- 
2.25.1

