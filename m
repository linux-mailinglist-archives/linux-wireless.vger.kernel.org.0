Return-Path: <linux-wireless+bounces-29697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 669ACCB7BC5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60BA3301C3F0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2243E2512C8;
	Fri, 12 Dec 2025 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mXO0/uVs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7F21E091
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509288; cv=none; b=qjAGHjdXh59c8LZyCaxNoS+1OKStOEAdrVrNGW940l4MTSHAo51Eo6jC/5+PHJaR9V7IZBP9SHn1Kifnu76blKmdHm06Uaz94cjilL+1Z0moN/nAdUDW/QkrmhWjQKghKBApXX6HjO7JBqfAFtZsLBDzT52o9P2gIDKo1Q8lLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509288; c=relaxed/simple;
	bh=fWKMOmqfj/hq23eSq5mSM/wnZ44DBiifUnzG7hqi56U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mf8vZSw8ERrzUJTsR92u84C8MkFLz1CVQj2BE0AB266ZPNmjpG/dtJUKrxRARtwzxPeZ/jdAYwCXpzoXe7/dF/k6iJRJ9WtOnMogWjqBS/CfvKTKDnHOnAJwzjEUONhfUskQ9TxZA1Dz6FDWTfZqC8jLkzvNhggx926/7iSx0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mXO0/uVs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC3EirL63508859, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765509284; bh=/no4cKOvnPRlzBIOWST1ckEemXr+qIjn+4qfgoMvpUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mXO0/uVsz0gjFKtPy8OofserZN3dIoT9Lg3ODNL4gZx4Ph6ys42snMJVSxzf59bj7
	 Gt5iM9psgnQgU4KcOsvvRM+OCQvwD1xlyx7+tyVeriOAENzGBjQWMJiUd7+IKJS7hB
	 HrQGDzrgDqSqj9O/fehfuTVdqQxdNh+zjf+AHytIqsgR0rFcnAAT9eexWUE2tRaYog
	 2ObpzST2+kNNC0Sivs5LN4ZkIrts7bCpdEeMBkSd7HEbHSLIgZFRgcc7jzPz5E4F7U
	 bC4VUA/N9D8gtE4bTLnrRvMWad9svwPzwP3AIdpcxVQbvesGxNlEFw3En8yrHrDNGp
	 mk90esG04WpjQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC3EirL63508859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 11:14:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 11:14:44 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 11:14:44 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 12 Dec 2025 11:14:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/12] wifi: rtw89: setting TBTT AGG number when mac port initialization
Date: Fri, 12 Dec 2025 11:13:02 +0800
Message-ID: <20251212031303.19882-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212031303.19882-1-pkshih@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

When initializing mac port, needs to set TBTT AGG number to trigger TBTT
related interrupts. Otherwise, after sending join info H2C command with
disconnection mode, firmware will clear TBTT AGG number. Without the
setting from mac port initialization after that, this port will not be
able to transmit beacons.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 066c99f3e53a..7ffb039e7d1b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4422,6 +4422,7 @@ static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev,
 #define BCN_HOLD_DEF 200
 #define BCN_MASK_DEF 0
 #define TBTT_ERLY_DEF 5
+#define TBTT_AGG_DEF 1
 #define BCN_SET_UNIT 32
 #define BCN_ERLY_SET_DLY (10 * 2)
 
@@ -4725,6 +4726,16 @@ static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
 				B_AX_TBTTERLY_MASK, TBTT_ERLY_DEF);
 }
 
+static void rtw89_mac_port_cfg_tbtt_agg(struct rtw89_dev *rtwdev,
+					struct rtw89_vif_link *rtwvif_link)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
+
+	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_agg,
+				B_AX_TBTT_AGG_NUM_MASK, TBTT_AGG_DEF);
+}
+
 static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link)
 {
@@ -4985,6 +4996,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_tbtt_agg(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif_link, true);
-- 
2.25.1


