Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687681553ED
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 09:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgBGIrs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 03:47:48 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42879 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGIrs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 03:47:48 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0178lfct009980, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0178lfct009980
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 16:47:41 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 16:47:41 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 16:47:41 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 16:47:41 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 16:47:31 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v3] rtw88: Fix incorrect beamformee role setting
Date:   Fri, 7 Feb 2020 16:47:29 +0800
Message-ID: <20200207084729.24882-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

In associating and configuring beamformee, bfee->role is not
correctly set before rtw_chip_ops::config_bfee().
Fix it by setting it correctly.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
  * cannot put bfee->role = RTW_BFEE_NONE after out_unlock
    put it enclosed by else

v2 -> v3
  * remove unnecessary 'else' statement

 drivers/net/wireless/realtek/rtw88/bf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index fda771d23f71..b6d1d71f4d30 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -41,7 +41,6 @@ void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	struct ieee80211_sta_vht_cap *ic_vht_cap;
 	const u8 *bssid = bss_conf->bssid;
 	u32 sound_dim;
-	u8 bfee_role = RTW_BFEE_NONE;
 	u8 i;
 
 	if (!(chip->band & RTW_BAND_5G))
@@ -67,7 +66,7 @@ void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		}
 
 		ether_addr_copy(bfee->mac_addr, bssid);
-		bfee_role = RTW_BFEE_MU;
+		bfee->role = RTW_BFEE_MU;
 		bfee->p_aid = (bssid[5] << 1) | (bssid[4] >> 7);
 		bfee->aid = bss_conf->aid;
 		bfinfo->bfer_mu_cnt++;
@@ -85,7 +84,7 @@ void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		sound_dim >>= IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT;
 
 		ether_addr_copy(bfee->mac_addr, bssid);
-		bfee_role = RTW_BFEE_SU;
+		bfee->role = RTW_BFEE_SU;
 		bfee->sound_dim = (u8)sound_dim;
 		bfee->g_id = 0;
 		bfee->p_aid = (bssid[5] << 1) | (bssid[4] >> 7);
@@ -102,7 +101,6 @@ void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	}
 
 out_unlock:
-	bfee->role = bfee_role;
 	rcu_read_unlock();
 }
 
-- 
2.17.1

