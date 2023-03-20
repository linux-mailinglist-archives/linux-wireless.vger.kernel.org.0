Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EDC6C1212
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjCTMms (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCTMmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 08:42:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFADCC20
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 05:42:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32KCgPcB5023722, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32KCgPcB5023722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Mar 2023 20:42:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Mar 2023 20:42:39 +0800
Received: from localhost (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Mar
 2023 20:42:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 5/5] wifi: rtw89: fix authentication fail during scan
Date:   Mon, 20 Mar 2023 20:41:25 +0800
Message-ID: <20230320124125.15873-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320124125.15873-1-pkshih@realtek.com>
References: <20230320124125.15873-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.31]
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

From: Po-Hao Huang <phhuang@realtek.com>

We used to store operating channel info after associated. However, scan
might happen before that. Without switching back to operating channel,
authentication or association might fail. Therefore, we switch back to
operating channel when the scanning vif's BSSID is non-zero, which
implies connected or during attempt to connect.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 15323af2e6edf..02a22ca613b2f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3188,7 +3188,7 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 }
 
 static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif)
+				       struct rtw89_vif *rtwvif, bool connected)
 {
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_mac_chinfo	*ch_info, *tmp;
@@ -3232,7 +3232,7 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 			type = RTW89_CHAN_ACTIVE;
 		rtw89_hw_scan_add_chan(rtwdev, type, req->n_ssids, ch_info);
 
-		if (rtwvif->net_type != RTW89_NET_TYPE_NO_LINK &&
+		if (connected &&
 		    off_chan_time + ch_info->period > RTW89_OFF_CHAN_TIME) {
 			tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 			if (!tmp) {
@@ -3265,7 +3265,7 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif)
+				   struct rtw89_vif *rtwvif, bool connected)
 {
 	int ret;
 
@@ -3274,7 +3274,7 @@ static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
 		rtw89_err(rtwdev, "Update probe request failed\n");
 		goto out;
 	}
-	ret = rtw89_hw_scan_add_chan_list(rtwdev, rtwvif);
+	ret = rtw89_hw_scan_add_chan_list(rtwdev, rtwvif, connected);
 out:
 	return ret;
 }
@@ -3352,16 +3352,19 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 {
 	struct rtw89_scan_option opt = {0};
 	struct rtw89_vif *rtwvif;
+	bool connected;
 	int ret = 0;
 
 	rtwvif = vif ? (struct rtw89_vif *)vif->drv_priv : NULL;
 	if (!rtwvif)
 		return -EINVAL;
 
+	/* This variable implies connected or during attempt to connect */
+	connected = !is_zero_ether_addr(rtwvif->bssid);
 	opt.enable = enable;
-	opt.target_ch_mode = rtwvif->net_type != RTW89_NET_TYPE_NO_LINK;
+	opt.target_ch_mode = connected;
 	if (enable) {
-		ret = rtw89_hw_scan_prehandle(rtwdev, rtwvif);
+		ret = rtw89_hw_scan_prehandle(rtwdev, rtwvif, connected);
 		if (ret)
 			goto out;
 	}
-- 
2.25.1

