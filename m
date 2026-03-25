Return-Path: <linux-wireless+bounces-33816-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI8NGU6Ow2lVrgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33816-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:27:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2D320ACE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 427943110FC4
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320A369229;
	Wed, 25 Mar 2026 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DOFPK8Yp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB433859C
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423364; cv=none; b=quc/al/1/Dm0/TThJGp7bVYmjEmrLnCFvqAV1u+IxcETunWvMEZwMkBXExfVpboUx4z04mV+0VmxM2x7bI+D89x7ESGI13EcqTXb3HFlWFjyUTIR36xmDlpRb1ofX+EnMura9Y05js13Jb4r1S8qU8DuaHRAOAGjSAhttgFyHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423364; c=relaxed/simple;
	bh=OIpiGPdtcCnXVULK0C8d0pCN8SpPsAtNRrO+jzl0SVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnBbqG9nqmSJUYR5HRVvZeT0PbP1UUTFPhptFyB9B1yCJ0edst+1ElkeZk7EM+QPJLeZu9wOceA8L5ZsVVpVU611Aulo83CA2qd/DaogD8hBb/UGAJ62E8GZaS7Aa490A7vd1k7axJQlelZwfTWMNdQEv/xDwbwWMqVmmXUa2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DOFPK8Yp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62P7MccO62939490, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774423359; bh=QrPKjXgNSpmo5pGIhn/PBngc13xRmqIx9rw7cLjGxD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DOFPK8YpCABGKDmPDD+KslflHMITIlKHf3d8xnjs7oHxNicO+E4exPeAES+OVdEQ1
	 he0Ou7vW1Gy+pmgekkSNDpAA7a9DHqZhhkqUdJxPgeriVWZcaqsvY2MBVKwbqRrXtf
	 j8/x5pRvDkhwMI3wQEo69kqlY50eOKVKV275LJ/+UPr5k8kxtUgFBJaodHx70h3/Qs
	 nwkPOlgMkwg3XS5BETH4XsrtMqMrvmkZJfc2VLjnaRe3bewb1Hd+o9vpk5gaMMCVpz
	 4oZ/mdp1PcvXn+Aslc5cEDZsdOSFzUueIOJ89YyxSVQaVRPps6s7cOCK/L8MxleIv1
	 4ChW32qKupKmQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62P7MccO62939490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:22:39 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:22:39 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:22:39 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 25 Mar 2026 15:22:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 7/8] wifi: rtw89: phy: load RF parameters relying on ACV for RTL8922D
Date: Wed, 25 Mar 2026 15:21:29 +0800
Message-ID: <20260325072130.41751-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325072130.41751-1-pkshih@realtek.com>
References: <20260325072130.41751-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33816-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D1B2D320ACE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RF parameters are conditional formats with RFE type and CV as arguments,
but RTL8922D has many variants and use ACV as argument instead of CV.
Add to select proper register values.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 3a241738ac06..980a2e7c36e1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1808,7 +1808,7 @@ static int rtw89_phy_sel_headline(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_phy_init_reg(struct rtw89_dev *rtwdev,
-			       const struct rtw89_phy_table *table,
+			       const struct rtw89_phy_table *table, bool by_acv,
 			       void (*config)(struct rtw89_dev *rtwdev,
 					      const struct rtw89_reg2_def *reg,
 					      enum rtw89_rf_path rf_path,
@@ -1817,8 +1817,8 @@ static void rtw89_phy_init_reg(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_reg2_def *reg;
 	enum rtw89_rf_path rf_path = table->rf_path;
+	u8 cv = by_acv ? rtwdev->hal.acv : rtwdev->hal.cv;
 	u8 rfe = rtwdev->efuse.rfe_type;
-	u8 cv = rtwdev->hal.cv;
 	u32 i;
 	u32 headline_size = 0, headline_idx = 0;
 	u32 target = 0, cfg_target;
@@ -1885,16 +1885,16 @@ void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev)
 	const struct rtw89_phy_table *bb_gain_table;
 
 	bb_table = elm_info->bb_tbl ? elm_info->bb_tbl : chip->bb_table;
-	rtw89_phy_init_reg(rtwdev, bb_table, rtw89_phy_config_bb_reg, NULL);
+	rtw89_phy_init_reg(rtwdev, bb_table, false, rtw89_phy_config_bb_reg, NULL);
 	if (rtwdev->dbcc_en)
-		rtw89_phy_init_reg(rtwdev, bb_table, rtw89_phy_config_bb_reg,
+		rtw89_phy_init_reg(rtwdev, bb_table, false, rtw89_phy_config_bb_reg,
 				   (void *)RTW89_PHY_1);
 
 	rtw89_chip_init_txpwr_unit(rtwdev);
 
 	bb_gain_table = elm_info->bb_gain ? elm_info->bb_gain : chip->bb_gain_table;
 	if (bb_gain_table)
-		rtw89_phy_init_reg(rtwdev, bb_gain_table,
+		rtw89_phy_init_reg(rtwdev, bb_gain_table, false,
 				   chip->phy_def->config_bb_gain, NULL);
 
 	rtw89_phy_bb_reset(rtwdev);
@@ -2000,6 +2000,7 @@ void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_phy_table *rf_table;
 	struct rtw89_fw_h2c_rf_reg_info *rf_reg_info;
+	bool by_acv = chip->chip_id == RTL8922D;
 	u8 path;
 
 	rf_reg_info = kzalloc_obj(*rf_reg_info);
@@ -2015,7 +2016,7 @@ void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio)
 		else
 			config = rf_table->config ? rf_table->config :
 				 rtw89_phy_config_rf_reg;
-		rtw89_phy_init_reg(rtwdev, rf_table, config, (void *)rf_reg_info);
+		rtw89_phy_init_reg(rtwdev, rf_table, by_acv, config, (void *)rf_reg_info);
 		if (rtw89_phy_config_rf_reg_fw(rtwdev, rf_reg_info))
 			rtw89_warn(rtwdev, "rf path %d reg h2c config failed\n",
 				   rf_reg_info->rf_path);
@@ -2056,7 +2057,7 @@ static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
 	rtw89_phy_preinit_rf_nctl(rtwdev);
 
 	nctl_table = elm_info->rf_nctl ? elm_info->rf_nctl : chip->nctl_table;
-	rtw89_phy_init_reg(rtwdev, nctl_table, rtw89_phy_config_bb_reg, NULL);
+	rtw89_phy_init_reg(rtwdev, nctl_table, false, rtw89_phy_config_bb_reg, NULL);
 
 	if (chip->nctl_post_table)
 		rtw89_rfk_parser(rtwdev, chip->nctl_post_table);
-- 
2.25.1


