Return-Path: <linux-wireless+bounces-2517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF883D4C6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51C71C2165B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AFB1CF8F;
	Fri, 26 Jan 2024 06:34:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B531CF8D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250882; cv=none; b=iQWApvFEltzisWx9g1guLNbJEM3mPnCxXxnt2mK6SoOedWkntT64I1aWNAWlD2K53Ks+D/7qr7WizGGFkrWwJ+8XPdJ5ugPDolREoblXwl+7a60a1N1A+aYg+syjvz1yH0alQ4aFPLx6KtsQ0eKR+DYAnpENNC4G+RCWZXzNJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250882; c=relaxed/simple;
	bh=uzTqkIfKYLSAhG2tQ4ssafzxafD+cpKGsMdMLRuN0gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4Y/aXmiIYMOnyCButsBjhLRCELPK6QlxZl4dCG0H9HojT1lycSgj8enuqKAyvsqUUuoypg0zFAJdTi41WITtkb37T4HZGma8/AuV8JjPa4FGelEkdM2k0gSZtYHprHVB5XQG5/o5Qd2A1IwidfoVFtm0TdlFJNQ0YlZWHxr1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40Q6YX8M02085602, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40Q6YX8M02085602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:34:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 26 Jan 2024 14:34:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 14:34:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: debug: add FW log component for scan
Date: Fri, 26 Jan 2024 14:33:51 +0800
Message-ID: <20240126063356.17857-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126063356.17857-1-pkshih@realtek.com>
References: <20240126063356.17857-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

This allows scan related logs when FW log debug mode is on.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 8 ++++++--
 drivers/net/wireless/realtek/rtw89/fw.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e49360e29faf..43fe9333d3e7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1829,10 +1829,14 @@ int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
 int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 {
 	struct sk_buff *skb;
-	u32 comp = enable ? BIT(RTW89_FW_LOG_COMP_INIT) | BIT(RTW89_FW_LOG_COMP_TASK) |
-			    BIT(RTW89_FW_LOG_COMP_PS) | BIT(RTW89_FW_LOG_COMP_ERROR) : 0;
+	u32 comp = 0;
 	int ret;
 
+	if (enable)
+		comp = BIT(RTW89_FW_LOG_COMP_INIT) | BIT(RTW89_FW_LOG_COMP_TASK) |
+		       BIT(RTW89_FW_LOG_COMP_PS) | BIT(RTW89_FW_LOG_COMP_ERROR) |
+		       BIT(RTW89_FW_LOG_COMP_SCAN);
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LOG_CFG_LEN);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for fw log cfg\n");
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2c94d82d384c..cb5b7bf88177 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -149,6 +149,7 @@ enum rtw89_fw_log_comp {
 	RTW89_FW_LOG_COMP_TWT,
 	RTW89_FW_LOG_COMP_RF,
 	RTW89_FW_LOG_COMP_MCC = 20,
+	RTW89_FW_LOG_COMP_SCAN = 28,
 };
 
 enum rtw89_pkt_offload_op {
-- 
2.25.1


