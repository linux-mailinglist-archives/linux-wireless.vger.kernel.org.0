Return-Path: <linux-wireless+bounces-31096-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCY3GkbScmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31096-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:43:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C15CF6F3F4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D1BD301DBA7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1400331282E;
	Fri, 23 Jan 2026 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Dxawxxvn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E23033EC
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132490; cv=none; b=NzfeLtHvjy3Pb7ZryqYwl/bMKYEsgaBI2Ow8mNihC8b6atfJLQAJp6uoQ1FK1O7RTZltVnqEG/ySYEBc/hV4dS/tO2I1/RIm4ZVVv30X8gMfsJiFkqKMqmg8IxrpdN2YxlqAM2jgfe6LprmMQpVhWFAwhRed1xWT7B/5mRBZT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132490; c=relaxed/simple;
	bh=BmVdoukpYl9OkbqzOoZp4Ak1ZuiNVQF+YucmrNYbobI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAevNUF+Exd9UvaJUaIDe5EfyT+mbB7xTmNkDmm3dkLWrunihP5CwPTDsuj3keSgm66JF5FmR53b75YJrxG7pxLri2QYRFyuVEPVcpVpuYQa8j8r4r0wDAtuatON21BXV4Dj4FEIyVc530ZjA/RHPTnT9g7ps1HIr9Rl4KsWSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Dxawxxvn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1fCEg92206862, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132473; bh=9sA7b+dkxb3dYSvy4D2OrgoxPDVjAaodbEk4unnDx/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DxawxxvnutEvvJBZryexXEu1tm9vuJzOUSM9ZESAfaH40lx32s/80SetjeOGBKLE4
	 tjlcsi+bMYHgMvehedtRpQarZakL9gBsfo87dS0kNg3B7ylsOfBNz79u8LqS0hxuNn
	 FuikCWMyGg7CULZnMLgau0rgx/kGqo7OfEp1BvYa26C6Gy9Xk8yE+/gHkyVxsGxiMc
	 Zzp30R9QpWT0nSHQXBOGpzRj9qR5eVI5qyUEQCZnENGgkOJ6Kyrab+2WyfUYjfyms6
	 JqWuvxVuhLkLaB2rbrljfQvKUraqKkTcltJoNAmiNNXxJoJweYrk/6RKBFHlntF25R
	 tpdrtLmGgdM3Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1fCEg92206862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:41:12 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:41:12 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:41:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/11] wifi: rtw89: phy: add PHY C2H event dummy handler for func 1-7 and 2-10
Date: Fri, 23 Jan 2026 09:39:53 +0800
Message-ID: <20260123013957.16418-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260123013957.16418-1-pkshih@realtek.com>
References: <20260123013957.16418-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31096-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C15CF6F3F4
X-Rspamd-Action: no action

The two functions aren't implemented and hard necessary by driver.
Implement dummy handler to avoid messages:

  rtw89_8922de 0000:03:00.0: PHY c2h class 1 func 7 not support
  rtw89_8922de 0000:03:00.0: PHY c2h class 2 func 10 not support

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h  |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/phy.h |  5 ++++-
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8a33a63619d5..4c50c0166d4f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7783,6 +7783,17 @@ void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev)
 	__rtw89_fw_free_all_early_h2c(rtwdev);
 }
 
+void rtw89_fw_c2h_dummy_handler(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	struct rtw89_fw_c2h_attr *attr = RTW89_SKB_C2H_CB(c2h);
+	u8 category = attr->category;
+	u8 class = attr->class;
+	u8 func = attr->func;
+
+	rtw89_debug(rtwdev, RTW89_DBG_FW,
+		    "C2H cate=%u cls=%u func=%u is dummy\n", category, class, func);
+}
+
 static void rtw89_fw_c2h_parse_attr(struct sk_buff *c2h)
 {
 	const struct rtw89_c2h_hdr *hdr = (const struct rtw89_c2h_hdr *)c2h->data;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index da802482c47d..d45b6ea6ea1b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5249,6 +5249,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v3(struct rtw89_dev *rtwdev,
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_fw_c2h_purge_obsoleted_scan_events(struct rtw89_dev *rtwdev);
+void rtw89_fw_c2h_dummy_handler(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len);
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_sta_link *rtwsta_link,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 41a8ce3aaffc..6c6d5f1da867 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3332,6 +3332,7 @@ void (* const rtw89_phy_c2h_ra_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_FUNC_STS_RPT] = rtw89_phy_c2h_ra_rpt,
 	[RTW89_PHY_C2H_FUNC_MU_GPTBL_RPT] = NULL,
 	[RTW89_PHY_C2H_FUNC_TXSTS] = NULL,
+	[RTW89_PHY_C2H_FUNC_ACCELERATE_EN] = rtw89_fw_c2h_dummy_handler,
 };
 
 static void
@@ -3419,6 +3420,7 @@ void (* const rtw89_phy_c2h_dm_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY] = rtw89_phy_c2h_lowrt_rty,
 	[RTW89_PHY_C2H_DM_FUNC_MCC_DIG] = NULL,
 	[RTW89_PHY_C2H_DM_FUNC_LPS] = rtw89_phy_c2h_lps_rpt,
+	[RTW89_PHY_C2H_DM_FUNC_ENV_MNTR] = rtw89_fw_c2h_dummy_handler,
 	[RTW89_PHY_C2H_DM_FUNC_FW_SCAN] = rtw89_phy_c2h_fw_scan_rpt,
 };
 
@@ -4009,7 +4011,7 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 
 	switch (class) {
 	case RTW89_PHY_C2H_CLASS_RA:
-		if (func < RTW89_PHY_C2H_FUNC_RA_MAX)
+		if (func < ARRAY_SIZE(rtw89_phy_c2h_ra_handler))
 			handler = rtw89_phy_c2h_ra_handler[func];
 		break;
 	case RTW89_PHY_C2H_RFK_LOG:
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index a587f83b8d67..ab263738d212 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -139,7 +139,9 @@ enum rtw89_phy_c2h_ra_func {
 	RTW89_PHY_C2H_FUNC_STS_RPT,
 	RTW89_PHY_C2H_FUNC_MU_GPTBL_RPT,
 	RTW89_PHY_C2H_FUNC_TXSTS,
-	RTW89_PHY_C2H_FUNC_RA_MAX,
+	RTW89_PHY_C2H_FUNC_ACCELERATE_EN = 0x7,
+
+	RTW89_PHY_C2H_FUNC_RA_NUM,
 };
 
 enum rtw89_phy_c2h_rfk_log_func {
@@ -168,6 +170,7 @@ enum rtw89_phy_c2h_dm_func {
 	RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY,
 	RTW89_PHY_C2H_DM_FUNC_MCC_DIG,
 	RTW89_PHY_C2H_DM_FUNC_LPS = 0x9,
+	RTW89_PHY_C2H_DM_FUNC_ENV_MNTR = 0xa,
 	RTW89_PHY_C2H_DM_FUNC_FW_SCAN = 0xc,
 	RTW89_PHY_C2H_DM_FUNC_NUM,
 };
-- 
2.25.1


