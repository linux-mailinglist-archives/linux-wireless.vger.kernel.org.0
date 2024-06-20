Return-Path: <linux-wireless+bounces-9271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0090FC74
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 07:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E881C20F0A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 05:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25D339FF3;
	Thu, 20 Jun 2024 05:59:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B1383AE
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863148; cv=none; b=BePibl7kfKdidmHzCVirbmVeZ5TEA6UO1fDaZslq9hhjuMFbXSGghjjE72oZjN/xEFD8ogjJPPIkl4gZkqoN6VDkfzKwCQFGS9FB+OkboVmC8lQloABDSI/FLmqFzdTIvAIBlHy1pTdV3KVFOUabuKeUfW6ieq3yWGyzodm7a20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863148; c=relaxed/simple;
	bh=io1+c6XhkqSe8/ErYWvkOnuE483gGO/X49QoiICvDdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1m35tXsDSln5rCv1yYSINNZzKtFPjtyg7L0dqA7nWbekiIaIDEykqd3A+bmvoKK7WhWT9j4eFH/RmPgF0LRZVta134NX16kELantlydG35xVuU027Ik5qiIVobdGCeck0pDAYbIzYYEA4XGBS7ttMuK9p4Ah8GnNWta3l2a31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K5x57l92577723, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K5x57l92577723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 13:59:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 13:59:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Jun
 2024 13:59:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH 7/7] wifi: rtw89: add polling for LPS H2C to ensure FW received
Date: Thu, 20 Jun 2024 13:58:25 +0800
Message-ID: <20240620055825.17592-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620055825.17592-1-pkshih@realtek.com>
References: <20240620055825.17592-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

We add polling after sending LPS H2C to ensure that the Firmware is
received and executes RPWM thereafter. Otherwise, if the Firmware
executes RPWM without receiving LPS H2C, it will cause beacon loss in
WoWLAN mode due to the inability to obtain channel and bandwidth
information from H2C.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 7 +++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e3fc9f168ae5..fbe08c162b93 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2496,6 +2496,7 @@ int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	struct rtw89_h2c_lps_ch_info *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
+	u32 done;
 	int ret;
 
 	if (chip->chip_gen != RTW89_CHIP_BE)
@@ -2519,12 +2520,18 @@ int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_DM,
 			      H2C_FUNC_FW_LPS_CH_INFO, 0, 0, len);
 
+	rtw89_phy_write32_mask(rtwdev, R_CHK_LPS_STAT, B_CHK_LPS_STAT, 0);
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
 
+	ret = read_poll_timeout(rtw89_phy_read32_mask, done, done, 50, 5000,
+				true, rtwdev, R_CHK_LPS_STAT, B_CHK_LPS_STAT);
+	if (ret)
+		rtw89_warn(rtwdev, "h2c_lps_ch_info done polling timeout\n");
+
 	return 0;
 fail:
 	dev_kfree_skb_any(skb);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c9f6bdc84d03..897884e9667f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7818,6 +7818,8 @@
 #define B_UPD_P0_EN BIT(31)
 #define R_EMLSR 0x0044
 #define B_EMLSR_PARM GENMASK(27, 12)
+#define R_CHK_LPS_STAT 0x0058
+#define B_CHK_LPS_STAT BIT(0)
 #define R_SPOOF_CG 0x00B4
 #define B_SPOOF_CG_EN BIT(17)
 #define R_CHINFO_SEG 0x00B4
-- 
2.25.1


