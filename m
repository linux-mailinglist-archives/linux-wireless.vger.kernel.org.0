Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C947D8CE3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 03:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJ0Bze (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 21:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0Bzc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 21:55:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51080AB
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 18:55:29 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39R1tLEF13465344, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39R1tLEF13465344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 09:55:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 27 Oct 2023 09:52:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 27 Oct
 2023 09:51:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/4] wifi: rtw89: set entry size of address CAM to H2C field by chip
Date:   Fri, 27 Oct 2023 09:50:56 +0800
Message-ID: <20231027015059.10032-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027015059.10032-1-pkshih@realtek.com>
References: <20231027015059.10032-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The new chips change hardware design to shrink entry size of address
CAM from 0x40 to 0x20, so make this change accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c | 16 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index f5301c2bbf13..914c94988b2f 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -488,6 +488,20 @@ static int rtw89_cam_get_avail_addr_cam(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static u8 rtw89_get_addr_cam_entry_size(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	switch (chip->chip_id) {
+	case RTL8852A:
+	case RTL8852B:
+	case RTL8851B:
+		return ADDR_CAM_ENT_SIZE;
+	default:
+		return ADDR_CAM_ENT_SHORT_SIZE;
+	}
+}
+
 int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
 			    struct rtw89_addr_cam_entry *addr_cam,
 			    const struct rtw89_bssid_cam_entry *bssid_cam)
@@ -509,7 +523,7 @@ int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
 	}
 
 	addr_cam->addr_cam_idx = addr_cam_idx;
-	addr_cam->len = ADDR_CAM_ENT_SIZE;
+	addr_cam->len = rtw89_get_addr_cam_entry_size(rtwdev);
 	addr_cam->offset = 0;
 	addr_cam->valid = true;
 	addr_cam->addr_mask = 0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index c11c904f87fe..cd2e9b850c72 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -10,6 +10,7 @@
 
 #define MAC_MEM_DUMP_PAGE_SIZE 0x40000
 #define ADDR_CAM_ENT_SIZE  0x40
+#define ADDR_CAM_ENT_SHORT_SIZE 0x20
 #define BSSID_CAM_ENT_SIZE 0x08
 #define HFC_PAGE_UNIT 64
 #define RPWM_TRY_CNT 3
-- 
2.25.1

