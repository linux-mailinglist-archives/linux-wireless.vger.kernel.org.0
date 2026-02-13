Return-Path: <linux-wireless+bounces-31800-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGQIIPXBjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31800-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2EB13337A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 909803010B5B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2621D1DA62E;
	Fri, 13 Feb 2026 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dp9n+Czl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D212288E3
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963442; cv=none; b=QD8JYGivMROlT7p69BSq86icOjXfGst/8halhhPKX+z/KvUjHRZcOnpemHdMmC1NTrx5vV5nuiM3j1H+pagtFj/vNZv3GgMls+x1ANFvTDOaRqLukKkxfZmcKhSE7y11zI7S7M/0VTTgPRUVW2CrrblUW1v85yBcbTNMxClFClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963442; c=relaxed/simple;
	bh=z2rDpE0TJiaf2NoyNsNL7KB7xq9DPOny2XYGYQW8wyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rL2tKTe58WT8Tf/VDIiQBhkE0tHrPh26/GXxE1MrrONnVZnKCqsXFo8NIpLBb6vjpBAoJwjYOO0b9b07DwaVB9wsVr8ZNg0tzEYb6JApJIFhBzvTkFfdtIf89bYu8UBA/3D2F2r7rz1RWuKU463rjL8mxOS+D51SAm2dLRMl/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dp9n+Czl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6HIt641419646, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963438; bh=qzeFhACqPT9SU9YB7hy/Uh5wo2Z0DtDm37xHWQrqACQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dp9n+CzllgEHj0eVqfEDnlaAN+LSyik1zHFCYorQs7BVWNlFO8YQlWs1c08k+cPCD
	 STXQksb+G9cUqOZZZlfVHq+ozTK/kRIaqw389bdiqmLd773J7Z8hDvklHZEHP/EMD8
	 gHE0YVpxzB9j8cXDmZTJPbkjpp08JwgILfHEVxvYeld1WWS4DSmQQhk06oVcGLZ/jl
	 3phRpmghSTXNz1IzqDeBoM5C5dBrVld1bMQWj6uAcMj7b5EPwzgkkOnPPeXXKCWsFw
	 iwYOL3QqqqYcVdwI31EW+jOrtFXc3uvSSRdXqATHEMe4m0zKR9LnqlP5hfXWEkc441
	 4oZWmSzZKWPzw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6HIt641419646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:18 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:18 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/12] wifi: rtw89: 8852a: update supported firmware format to 1
Date: Fri, 13 Feb 2026 14:15:46 +0800
Message-ID: <20260213061552.29997-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213061552.29997-1-pkshih@realtek.com>
References: <20260213061552.29997-1-pkshih@realtek.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31800-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2C2EB13337A
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

More data will be included in Firmware file and loaded via FW elements.
Unlike other chips, for RF radio, RTL8852A uses rtw89_phy_config_rf_reg
instead of v1, so update loading handling of corresponding FW element.
And then, increase RTL8852A FW format to 1 to prevent old driver from
misusing the data in FW elements.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c       | 5 ++++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 8 ++++----
 drivers/net/wireless/realtek/rtw89/phy.h      | 4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 2 +-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ff27f00ec6d2..64874907bfe0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1073,6 +1073,7 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 				 const union rtw89_fw_element_arg arg)
 {
 	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_phy_table *tbl, **pp;
 	struct rtw89_reg2_def *regs;
@@ -1129,7 +1130,9 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 
 	if (radio) {
 		tbl->rf_path = arg.rf_path;
-		tbl->config = rtw89_phy_config_rf_reg_v1;
+		tbl->config = chip->chip_id == RTL8852A ?
+			      rtw89_phy_config_rf_reg :
+			      rtw89_phy_config_rf_reg_v1;
 	}
 
 	*pp = tbl;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 6c6d5f1da867..0e9925f43260 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1659,10 +1659,10 @@ static void rtw89_phy_config_rf_reg_noio(struct rtw89_dev *rtwdev,
 				     (struct rtw89_fw_h2c_rf_reg_info *)extra_data);
 }
 
-static void rtw89_phy_config_rf_reg(struct rtw89_dev *rtwdev,
-				    const struct rtw89_reg2_def *reg,
-				    enum rtw89_rf_path rf_path,
-				    void *extra_data)
+void rtw89_phy_config_rf_reg(struct rtw89_dev *rtwdev,
+			     const struct rtw89_reg2_def *reg,
+			     enum rtw89_rf_path rf_path,
+			     void *extra_data)
 {
 	if (reg->addr == 0xfe) {
 		mdelay(50);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index ab263738d212..094c7e45f254 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -852,6 +852,10 @@ bool rtw89_phy_write_rf_v3(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev);
 void rtw89_phy_init_bb_afe(struct rtw89_dev *rtwdev);
 void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio);
+void rtw89_phy_config_rf_reg(struct rtw89_dev *rtwdev,
+			     const struct rtw89_reg2_def *reg,
+			     enum rtw89_rf_path rf_path,
+			     void *extra_data);
 void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
 				const struct rtw89_reg2_def *reg,
 				enum rtw89_rf_path rf_path,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 6089cf9e1d54..898c534a5762 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -12,7 +12,7 @@
 #include "rtw8852a_table.h"
 #include "txrx.h"
 
-#define RTW8852A_FW_FORMAT_MAX 0
+#define RTW8852A_FW_FORMAT_MAX 1
 #define RTW8852A_FW_BASENAME "rtw89/rtw8852a_fw"
 #define RTW8852A_MODULE_FIRMWARE \
 	RTW89_GEN_MODULE_FWNAME(RTW8852A_FW_BASENAME, RTW8852A_FW_FORMAT_MAX)
-- 
2.25.1


