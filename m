Return-Path: <linux-wireless+bounces-721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1351810701
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 01:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D1D1F21559
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 00:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3215A7;
	Wed, 13 Dec 2023 00:52:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411D9B9
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 16:52:18 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BD0qAm153838294, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BD0qAm153838294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 08:52:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 13 Dec 2023 08:52:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 13 Dec
 2023 08:52:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/6] wifi: rtw89: fw: add version field to BB MCU firmware element
Date: Wed, 13 Dec 2023 08:50:50 +0800
Message-ID: <20231213005054.10568-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213005054.10568-1-pkshih@realtek.com>
References: <20231213005054.10568-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

8922AE has more than one hardware version, and they use different BB MCU
firmware, so occupy a byte from element priv[] to annotate version. Since
there are more than one firmware and only matched version is adopted,
return 1 to ignore not matched firmware.

     +===========================================+
     |  elm ID  | elm size | version  |          |
     +----------+----------+----------+----------+
     |                     |  element_priv[]     |
     +-------------------------------------------+

                change to  |
                           v

     +===========================================+
     |  elm ID  | elm size | version  |          |
     +----------+----------+----------+----------+
     |                     | cv | element_rsvd[] |
     +-------------------------------------------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 8 +++++++-
 drivers/net/wireless/realtek/rtw89/fw.h | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f9727c00d8b9..76c948da669e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -401,10 +401,14 @@ int __rtw89_fw_recognize_from_elm(struct rtw89_dev *rtwdev,
 				  const union rtw89_fw_element_arg arg)
 {
 	enum rtw89_fw_type type = arg.fw_type;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_fw_suit *fw_suit;
 
+	if (hal->cv != elm->u.bbmcu.cv)
+		return 1; /* ignore this element */
+
 	fw_suit = rtw89_fw_suit_get(rtwdev, type);
-	fw_suit->data = elm->u.common.contents;
+	fw_suit->data = elm->u.bbmcu.contents;
 	fw_suit->size = le32_to_cpu(elm->size);
 
 	return rtw89_fw_update_ver(rtwdev, type, fw_suit);
@@ -820,6 +824,8 @@ int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
 			goto next;
 
 		ret = handler->fn(rtwdev, hdr, handler->arg);
+		if (ret == 1) /* ignore this element */
+			goto next;
 		if (ret)
 			return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 033ea4467876..f2b61e9ad8a7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3532,6 +3532,11 @@ struct rtw89_fw_element_hdr {
 				__le32 data;
 			} __packed regs[];
 		} __packed reg2;
+		struct {
+			u8 cv;
+			u8 priv[7];
+			u8 contents[];
+		} __packed bbmcu;
 		struct {
 			__le32 bitmap; /* bitmap of enum rtw89_fw_txpwr_trk_type */
 			__le32 rsvd;
-- 
2.25.1


