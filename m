Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1549067753F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 07:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjAWGyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 01:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjAWGyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 01:54:45 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A90B61A487
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 22:54:42 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30N6sQCA1012865, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30N6sQCA1012865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 23 Jan 2023 14:54:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 23 Jan 2023 14:54:29 +0800
Received: from localhost (172.16.16.32) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 23 Jan
 2023 14:54:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: fix potential wrong mapping for pkt-offload
Date:   Mon, 23 Jan 2023 14:53:56 +0800
Message-ID: <20230123065401.14174-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123065401.14174-1-pkshih@realtek.com>
References: <20230123065401.14174-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.32]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/23/2023 06:33:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMjMgpFekyCAxMjozNzowMA==?=
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

From: Chin-Yen Lee <timlee@realtek.com>

When driver fails to send H2C to firmware for pkt-offload, we should not
update the pkt_list of driver, and need to release allocated pkt index to
avoid wrong mapping between driver and firmware.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 85c7172e931bf..210785149801b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -948,13 +948,13 @@ static int rtw89_fw_h2c_add_wow_fw_ofld(struct rtw89_dev *rtwdev,
 	if (!skb)
 		goto err;
 
-	list_add_tail(&info->list, &rtw_wow->pkt_list);
 	ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, skb);
 	kfree_skb(skb);
 
 	if (ret)
-		return ret;
+		goto err;
 
+	list_add_tail(&info->list, &rtw_wow->pkt_list);
 	*id = info->id;
 	return 0;
 
@@ -2133,6 +2133,7 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_PKT_OFLD + skb_ofld->len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c pkt offload\n");
+		rtw89_core_release_bit_map(rtwdev->pkt_offload, alloc_id);
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_LEN_PKT_OFLD);
@@ -2151,6 +2152,7 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
+		rtw89_core_release_bit_map(rtwdev->pkt_offload, alloc_id);
 		goto fail;
 	}
 
@@ -2684,13 +2686,14 @@ static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 			goto out;
 		}
 
-		list_add_tail(&info->list, &scan_info->pkt_list[band]);
 		ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, new);
 		if (ret) {
 			kfree_skb(new);
+			kfree(info);
 			goto out;
 		}
 
+		list_add_tail(&info->list, &scan_info->pkt_list[band]);
 		kfree_skb(new);
 	}
 out:
-- 
2.25.1

