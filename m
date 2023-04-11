Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F66DDB2B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDKMtH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 08:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDKMtC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 08:49:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600B54C1C
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 05:49:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33BCmRBZ1030623, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33BCmRBZ1030623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Apr 2023 20:48:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 11 Apr 2023 20:48:49 +0800
Received: from localhost (172.16.20.144) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 11 Apr
 2023 20:48:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v6 5/5] wifi: rtw89: fix authentication fail during scan
Date:   Tue, 11 Apr 2023 20:48:32 +0800
Message-ID: <20230411124832.14965-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411124832.14965-1-pkshih@realtek.com>
References: <20230411124832.14965-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.144]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
v6: no change
v5: no change
---
 drivers/net/wireless/realtek/rtw89/fw.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 032afbaeb71d6..d3348f9bcc2a7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3199,7 +3199,7 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 }
 
 static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif)
+				       struct rtw89_vif *rtwvif, bool connected)
 {
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_mac_chinfo	*ch_info, *tmp;
@@ -3243,7 +3243,7 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 			type = RTW89_CHAN_ACTIVE;
 		rtw89_hw_scan_add_chan(rtwdev, type, req->n_ssids, ch_info);
 
-		if (rtwvif->net_type != RTW89_NET_TYPE_NO_LINK &&
+		if (connected &&
 		    off_chan_time + ch_info->period > RTW89_OFF_CHAN_TIME) {
 			tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 			if (!tmp) {
@@ -3276,7 +3276,7 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif)
+				   struct rtw89_vif *rtwvif, bool connected)
 {
 	int ret;
 
@@ -3285,7 +3285,7 @@ static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
 		rtw89_err(rtwdev, "Update probe request failed\n");
 		goto out;
 	}
-	ret = rtw89_hw_scan_add_chan_list(rtwdev, rtwvif);
+	ret = rtw89_hw_scan_add_chan_list(rtwdev, rtwvif, connected);
 out:
 	return ret;
 }
@@ -3363,16 +3363,19 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
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

