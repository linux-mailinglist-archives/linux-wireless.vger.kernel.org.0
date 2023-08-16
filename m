Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C64477DC1B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbjHPIW4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbjHPIWc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:22:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59E402102
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:22:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37G8M49E0001415, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37G8M49E0001415
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Aug 2023 16:22:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 16 Aug 2023 16:22:23 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 16 Aug
 2023 16:22:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: provide functions to configure NoA for beacon update
Date:   Wed, 16 Aug 2023 16:21:32 +0800
Message-ID: <20230816082133.57474-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816082133.57474-1-pkshih@realtek.com>
References: <20230816082133.57474-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Callers call renew function when wanting to generate a new P2P NoA
information element, and call append function to append NoA attribute
one by one. Then, updating beacon work will fetch the P2P NoA information
element configured by callers and add it to beacon.

The use case of MCC (multi-channel concurrent) <GO + STA> for example:
* start MCC - GO part
	renew P2P NoA
	append period NoA after calculation
* download beacon for GO
	fetch P2P NoA and add to beacon content
* stop MCC - GO part
	renew P2P NoA (reset)

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 27 ++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c   | 10 ++++
 drivers/net/wireless/realtek/rtw89/ps.c   | 61 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/ps.h   |  4 ++
 4 files changed, 102 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 257582fc39ea..431b0d3daa2a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2896,6 +2896,32 @@ struct rtw89_roc {
 
 #define RTW89_P2P_MAX_NOA_NUM 2
 
+struct rtw89_p2p_ie_head {
+	u8 eid;
+	u8 ie_len;
+	u8 oui[3];
+	u8 oui_type;
+} __packed;
+
+struct rtw89_noa_attr_head {
+	u8 attr_type;
+	__le16 attr_len;
+	u8 index;
+	u8 oppps_ctwindow;
+} __packed;
+
+struct rtw89_p2p_noa_ie {
+	struct rtw89_p2p_ie_head p2p_head;
+	struct rtw89_noa_attr_head noa_head;
+	struct ieee80211_p2p_noa_desc noa_desc[RTW89_P2P_MAX_NOA_NUM];
+} __packed;
+
+struct rtw89_p2p_noa_setter {
+	struct rtw89_p2p_noa_ie ie;
+	u8 noa_count;
+	u8 noa_index;
+};
+
 struct rtw89_vif {
 	struct list_head list;
 	struct rtw89_dev *rtwdev;
@@ -2938,6 +2964,7 @@ struct rtw89_vif {
 	struct cfg80211_scan_request *scan_req;
 	struct ieee80211_scan_ies *scan_ies;
 	struct list_head general_pkt_list;
+	struct rtw89_p2p_noa_setter p2p_noa;
 };
 
 enum rtw89_lv1_rcvy_step {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7dd7bc4be9c7..67cc3f852da8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -9,6 +9,7 @@
 #include "fw.h"
 #include "mac.h"
 #include "phy.h"
+#include "ps.h"
 #include "reg.h"
 #include "util.h"
 
@@ -1923,6 +1924,8 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 	u16 tim_offset;
 	int bcn_total_len;
 	u16 beacon_rate;
+	void *noa_data;
+	u8 noa_len;
 	int ret;
 
 	if (vif->p2p)
@@ -1939,6 +1942,13 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 		return -ENOMEM;
 	}
 
+	noa_len = rtw89_p2p_noa_fetch(rtwvif, &noa_data);
+	if (noa_len &&
+	    (noa_len <= skb_tailroom(skb_beacon) ||
+	     pskb_expand_head(skb_beacon, 0, noa_len, GFP_KERNEL) == 0)) {
+		skb_put_data(skb_beacon, noa_data, noa_len);
+	}
+
 	bcn_total_len = H2C_BCN_BASE_LEN + skb_beacon->len;
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, bcn_total_len);
 	if (!skb) {
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 84201ef19c17..b98ec178abe1 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -278,3 +278,64 @@ void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
 		rtwdev->lps_enabled = false;
 	}
 }
+
+void rtw89_p2p_noa_renew(struct rtw89_vif *rtwvif)
+{
+	struct rtw89_p2p_noa_setter *setter = &rtwvif->p2p_noa;
+	struct rtw89_p2p_noa_ie *ie = &setter->ie;
+	struct rtw89_p2p_ie_head *p2p_head = &ie->p2p_head;
+	struct rtw89_noa_attr_head *noa_head = &ie->noa_head;
+
+	if (setter->noa_count) {
+		setter->noa_index++;
+		setter->noa_count = 0;
+	}
+
+	memset(ie, 0, sizeof(*ie));
+
+	p2p_head->eid = WLAN_EID_VENDOR_SPECIFIC;
+	p2p_head->ie_len = 4 + sizeof(*noa_head);
+	p2p_head->oui[0] = (WLAN_OUI_WFA >> 16) & 0xff;
+	p2p_head->oui[1] = (WLAN_OUI_WFA >> 8) & 0xff;
+	p2p_head->oui[2] = (WLAN_OUI_WFA >> 0) & 0xff;
+	p2p_head->oui_type = WLAN_OUI_TYPE_WFA_P2P;
+
+	noa_head->attr_type = IEEE80211_P2P_ATTR_ABSENCE_NOTICE;
+	noa_head->attr_len = cpu_to_le16(2);
+	noa_head->index = setter->noa_index;
+	noa_head->oppps_ctwindow = 0;
+}
+
+void rtw89_p2p_noa_append(struct rtw89_vif *rtwvif,
+			  const struct ieee80211_p2p_noa_desc *desc)
+{
+	struct rtw89_p2p_noa_setter *setter = &rtwvif->p2p_noa;
+	struct rtw89_p2p_noa_ie *ie = &setter->ie;
+	struct rtw89_p2p_ie_head *p2p_head = &ie->p2p_head;
+	struct rtw89_noa_attr_head *noa_head = &ie->noa_head;
+
+	if (!desc->count || !desc->duration)
+		return;
+
+	if (setter->noa_count >= RTW89_P2P_MAX_NOA_NUM)
+		return;
+
+	p2p_head->ie_len += sizeof(*desc);
+	le16_add_cpu(&noa_head->attr_len, sizeof(*desc));
+
+	ie->noa_desc[setter->noa_count++] = *desc;
+}
+
+u8 rtw89_p2p_noa_fetch(struct rtw89_vif *rtwvif, void **data)
+{
+	struct rtw89_p2p_noa_setter *setter = &rtwvif->p2p_noa;
+	struct rtw89_p2p_noa_ie *ie = &setter->ie;
+	void *tail;
+
+	if (!setter->noa_count)
+		return 0;
+
+	*data = ie;
+	tail = ie->noa_desc + setter->noa_count;
+	return tail - *data;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 4c18f49204b2..aff0fba71cb0 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -16,6 +16,10 @@ void rtw89_leave_ips(struct rtw89_dev *rtwdev);
 void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl);
 void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 void rtw89_recalc_lps(struct rtw89_dev *rtwdev);
+void rtw89_p2p_noa_renew(struct rtw89_vif *rtwvif);
+void rtw89_p2p_noa_append(struct rtw89_vif *rtwvif,
+			  const struct ieee80211_p2p_noa_desc *desc);
+u8 rtw89_p2p_noa_fetch(struct rtw89_vif *rtwvif, void **data);
 
 static inline void rtw89_leave_ips_by_hwflags(struct rtw89_dev *rtwdev)
 {
-- 
2.25.1

