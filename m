Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7250D3D727E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhG0KB3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 06:01:29 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37431 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbhG0KBZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 06:01:25 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16RA1LeO4008714, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16RA1LeO4008714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Jul 2021 18:01:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 27 Jul 2021 18:01:20 +0800
Received: from localhost (172.16.21.11) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 27 Jul
 2021 18:01:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: [PATCH 4/4] rtw88: wow: fix size access error of probe request
Date:   Tue, 27 Jul 2021 18:00:46 +0800
Message-ID: <20210727100046.30116-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727100046.30116-1-pkshih@realtek.com>
References: <20210727100046.30116-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.11]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/27/2021 09:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMjcgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/27/2021 09:41:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165266 [Jul 27 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/27/2021 09:43:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Current flow will lead to null ptr access because of trying
to get the size of freed probe-request packets. We store the
information of packet size into rsvd page instead and also fix
the size error issue, which will cause unstable behavoir of
sending probe request by wow firmware.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 8 ++++++--
 drivers/net/wireless/realtek/rtw88/fw.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 3bfa5ecc0053..e6399519584b 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -819,7 +819,7 @@ static u16 rtw_get_rsvd_page_probe_req_size(struct rtw_dev *rtwdev,
 			continue;
 		if ((!ssid && !rsvd_pkt->ssid) ||
 		    rtw_ssid_equal(rsvd_pkt->ssid, ssid))
-			size = rsvd_pkt->skb->len;
+			size = rsvd_pkt->probe_req_size;
 	}
 
 	return size;
@@ -1047,6 +1047,8 @@ static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 							 ssid->ssid_len, 0);
 		else
 			skb_new = ieee80211_probereq_get(hw, vif->addr, NULL, 0, 0);
+		if (skb_new)
+			rsvd_pkt->probe_req_size = (u16)skb_new->len;
 		break;
 	case RSVD_NLO_INFO:
 		skb_new = rtw_nlo_info_get(hw);
@@ -1643,6 +1645,7 @@ int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
 static void __rtw_fw_update_pkt(struct rtw_dev *rtwdev, u8 pkt_id, u16 size,
 				u8 location)
 {
+	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 	u16 total_size = H2C_PKT_HDR_SIZE + H2C_PKT_UPDATE_PKT_LEN;
 
@@ -1653,6 +1656,7 @@ static void __rtw_fw_update_pkt(struct rtw_dev *rtwdev, u8 pkt_id, u16 size,
 	UPDATE_PKT_SET_LOCATION(h2c_pkt, location);
 
 	/* include txdesc size */
+	size += chip->tx_pkt_desc_sz;
 	UPDATE_PKT_SET_SIZE(h2c_pkt, size);
 
 	rtw_fw_send_h2c_packet(rtwdev, h2c_pkt);
@@ -1662,7 +1666,7 @@ void rtw_fw_update_pkt_probe_req(struct rtw_dev *rtwdev,
 				 struct cfg80211_ssid *ssid)
 {
 	u8 loc;
-	u32 size;
+	u16 size;
 
 	loc = rtw_get_rsvd_page_probe_req_location(rtwdev, ssid);
 	if (!loc) {
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index a8a7162fbe64..a3a28ac6f1de 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -147,6 +147,7 @@ struct rtw_rsvd_page {
 	u8 page;
 	bool add_txdesc;
 	struct cfg80211_ssid *ssid;
+	u16 probe_req_size;
 };
 
 enum rtw_keep_alive_pkt_type {
-- 
2.25.1

