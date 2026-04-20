Return-Path: <linux-wireless+bounces-35003-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AED6GpKg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35003-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F373A426964
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AABCA301184F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC43783D4;
	Mon, 20 Apr 2026 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rxjthmKJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFA2FD1B1
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656527; cv=none; b=FmSermcT4QCPi1elsqwjQx2HIbuovMle24ioAtJZjUYCWz4n3kGlvBH6uUBs9KvWenuxHmeB/BrkB8scxc365yjGx2617uHfTHnXhOpdnkjbY3eThyIOY2+L2c6B7nTqsqxKgYV2J3m7CMEGmzobKH7jefqkaqo7ykXfYDeU000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656527; c=relaxed/simple;
	bh=CjkndO+uE7hZr16juuFgdS+U84eeKAMfuk9QZ0lkVGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQV75OPpEoHWQesdSYBCp0UtAT775BbbKSSX7qGYy7JjD+hDm8sRkMQVb6R2EPH8jRkw0gxr1II5UGFiFU396yGUG5GCKCaxMRSz/0n2+7b/VmipOsVCZaCZ7ojEmLz9Swcx82MyAI3Ky9RE4ypt0PsTXHR2hltbs3QgXqTiZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rxjthmKJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3g3ID1427588, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656524; bh=OLqhws0HE2e99+p5MGO5037+UU3oORbFGKQ4S8fn7WM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rxjthmKJ/F5tXv4ky1cV3QVnEDJlrttr9xgwWMLPfXB9xGDVthexD8tDWa9RCbQ7i
	 4vMvsMVWdmti0XLvAzOIIIIuG4P7NxYK7HkCJ2GrxI0GoIxf0umArvSA6jdT3TpUkL
	 Bg7E2hBdxEcLoojhApFm96YN+Jo0nP7AdvzWCjY6O+94AIBA8+ZS5eZhBFRmvhRnOa
	 3dDN6FhOUtTP/LRDZf3leHZzMTSxZYjmugwSBZF7suegz8jqxbC55kPjgjpeOTvm8C
	 JJLe8NmnhO9wUj8Wx/IgaiEYZXkmGjO/3E8i9Z54wiND3HFY5jjY9gfBJ3QQ1zA+M4
	 ZuVSfXShMYvSg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3g3ID1427588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:42:03 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:42:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:42:02 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:42:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 10/16] wifi: rtw89: use firmware offload for PHY and RF batch register writes
Date: Mon, 20 Apr 2026 11:40:45 +0800
Message-ID: <20260420034051.17666-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-35003-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F373A426964
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Huang <echuang@realtek.com>

Use firmware offload to perform batch register writes for PHY and RF.
This reduces I/O operations, improves bus transfer efficiency, and
decreases hardware initialization time.

Performance improvement on USB 2.0 HCI:
- rtw89_phy_init_bb_reg: 61 ms -> 5 ms
- rtw89_phy_init_rf_reg: 587 ms -> 106 ms

Use offload-aware delay functions (do_udelay and do_mdelay) for the
delay calls in rtw89_phy_init_reg, rtw89_phy_config_rf_reg, and
rtw89_phy_config_rf_reg_v1 to ensure compatibility with batch register
writes.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 38 ++++++++++++++++--------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f26cbde6bdd0..5065326d8c53 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1352,17 +1352,17 @@ static void rtw89_phy_config_bb_reg(struct rtw89_dev *rtwdev,
 	u32 addr;
 
 	if (reg->addr == 0xfe) {
-		mdelay(50);
+		rtw89_io_mdelay(rtwdev, 50);
 	} else if (reg->addr == 0xfd) {
-		mdelay(5);
+		rtw89_io_mdelay(rtwdev, 5);
 	} else if (reg->addr == 0xfc) {
-		mdelay(1);
+		rtw89_io_mdelay(rtwdev, 1);
 	} else if (reg->addr == 0xfb) {
-		udelay(50);
+		rtw89_io_udelay(rtwdev, 50);
 	} else if (reg->addr == 0xfa) {
-		udelay(5);
+		rtw89_io_udelay(rtwdev, 5);
 	} else if (reg->addr == 0xf9) {
-		udelay(1);
+		rtw89_io_udelay(rtwdev, 1);
 	} else if (reg->data == BYPASS_CR_DATA) {
 		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK, "Bypass CR 0x%x\n", reg->addr);
 	} else {
@@ -1692,17 +1692,17 @@ void rtw89_phy_config_rf_reg(struct rtw89_dev *rtwdev,
 			     void *extra_data)
 {
 	if (reg->addr == 0xfe) {
-		mdelay(50);
+		rtw89_io_mdelay(rtwdev, 50);
 	} else if (reg->addr == 0xfd) {
-		mdelay(5);
+		rtw89_io_mdelay(rtwdev, 5);
 	} else if (reg->addr == 0xfc) {
-		mdelay(1);
+		rtw89_io_mdelay(rtwdev, 1);
 	} else if (reg->addr == 0xfb) {
-		udelay(50);
+		rtw89_io_udelay(rtwdev, 50);
 	} else if (reg->addr == 0xfa) {
-		udelay(5);
+		rtw89_io_udelay(rtwdev, 5);
 	} else if (reg->addr == 0xf9) {
-		udelay(1);
+		rtw89_io_udelay(rtwdev, 1);
 	} else {
 		rtw89_write_rf(rtwdev, rf_path, reg->addr, 0xfffff, reg->data);
 		rtw89_phy_cofig_rf_reg_store(rtwdev, reg, rf_path,
@@ -1715,6 +1715,11 @@ void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
 				enum rtw89_rf_path rf_path,
 				void *extra_data)
 {
+	if (reg->addr == 0xfe) {
+		rtw89_io_mdelay(rtwdev, 50);
+		return;
+	}
+
 	rtw89_write_rf(rtwdev, rf_path, reg->addr, RFREG_MASK, reg->data);
 
 	if (reg->addr < 0x100)
@@ -1885,11 +1890,16 @@ void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev)
 	const struct rtw89_phy_table *bb_gain_table;
 
 	bb_table = elm_info->bb_tbl ? elm_info->bb_tbl : chip->bb_table;
+
+	rtw89_io_pack(rtwdev);
+
 	rtw89_phy_init_reg(rtwdev, bb_table, false, rtw89_phy_config_bb_reg, NULL);
 	if (rtwdev->dbcc_en)
 		rtw89_phy_init_reg(rtwdev, bb_table, false, rtw89_phy_config_bb_reg,
 				   (void *)RTW89_PHY_1);
 
+	rtw89_io_unpack(rtwdev);
+
 	rtw89_chip_init_txpwr_unit(rtwdev);
 
 	bb_gain_table = elm_info->bb_gain ? elm_info->bb_gain : chip->bb_gain_table;
@@ -2016,7 +2026,11 @@ void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio)
 		else
 			config = rf_table->config ? rf_table->config :
 				 rtw89_phy_config_rf_reg;
+
+		rtw89_io_pack(rtwdev);
 		rtw89_phy_init_reg(rtwdev, rf_table, by_acv, config, (void *)rf_reg_info);
+		rtw89_io_unpack(rtwdev);
+
 		if (rtw89_phy_config_rf_reg_fw(rtwdev, rf_reg_info))
 			rtw89_warn(rtwdev, "rf path %d reg h2c config failed\n",
 				   rf_reg_info->rf_path);
-- 
2.25.1


