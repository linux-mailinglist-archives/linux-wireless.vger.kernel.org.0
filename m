Return-Path: <linux-wireless+bounces-1580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81375826A66
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96811C21C07
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832411CB0;
	Mon,  8 Jan 2024 09:13:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498211C87
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089DCVB03873272, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089DCVB03873272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:13:12 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 Jan 2024 17:13:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:13:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 06/10] wifi: rtw89: refine H2C command that pause transmitting by MAC ID
Date: Mon, 8 Jan 2024 17:13:07 +0800
Message-ID: <20240108091307.67296-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240108091134.67007-1-pkshih@realtek.com>
References: <20240108091134.67007-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

To reuse this function to support extended H2C command that is used by
newer chip, change to use a pointer to fill pause ID and mask.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 61ae8e584a3b..991c42c4e509 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2489,20 +2489,23 @@ int rtw89_fw_h2c_notify_dbcc(struct rtw89_dev *rtwdev, bool en)
 int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 			     bool pause)
 {
-	struct rtw89_fw_macid_pause_grp h2c = {{0}};
-	u8 len = sizeof(struct rtw89_fw_macid_pause_grp);
+	struct rtw89_fw_macid_pause_grp *h2c;
+	__le32 set = cpu_to_le32(BIT(sh));
+	u8 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_JOIN_INFO_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
-		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
+		rtw89_err(rtwdev, "failed to alloc skb for h2c macid pause\n");
 		return -ENOMEM;
 	}
-	h2c.mask_grp[grp] = cpu_to_le32(BIT(sh));
+	skb_put(skb, len);
+	h2c = (struct rtw89_fw_macid_pause_grp *)skb->data;
+
+	h2c->mask_grp[grp] = set;
 	if (pause)
-		h2c.pause_grp[grp] = cpu_to_le32(BIT(sh));
-	skb_put_data(skb, &h2c, len);
+		h2c->pause_grp[grp] = set;
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
-- 
2.25.1


