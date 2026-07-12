Return-Path: <linux-wireless+bounces-38903-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XQo6JDEOU2qGWQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38903-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFDE743B87
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Vvs+oGHK;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38903-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38903-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C88D301F4A5
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F7E274670;
	Sun, 12 Jul 2026 03:46:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC5F846A
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:46:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783827979; cv=none; b=gMsw6Z0MkEO6I9+d9cfxqEQ/cW2vQFksRxzT/dIFmKbEI1pG4029jyQr7RPU+y3HoPXtRIGZKOLbTzOaaIhcYIkJ/uBD+g8O4i/9UrDJMxdrfd3x55EDsr2++RHtSdGuTjMTCWW2MeLIFBUKSl/wL2XhYPdgC3u9aCgMp6nqCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783827979; c=relaxed/simple;
	bh=rB990GhsFhdaSQlZ5yvb7wGApFHnhsGYmrQ75HRWa5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjhTkSWjw15C74+DqLvdI6gFx7AQVM9541RFLFbqAncFvf79D4XQdi8myn4vgWk4qzSmaRZxFwr70HiIVXarKn4RXqXcj3cskiMNh7HyRtBOFm1FQq9KUBUAChZWcwWYiEyUVR8ZQebcv+n7edfsl0Gv39XYLLULPw7KTwhGuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Vvs+oGHK; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C3kF1H1535607, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783827975; bh=rBkQrEUu2N/uI/jMe5Y3CW/4DxfNsDCwRyBf60l7ROM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Vvs+oGHKMm3X+0gETrcJYTkErjTfE+dvmbt2klKl6evajD4i5dE3loiPQZ6R2Ap5d
	 EtCvyaNBCB1BdyTVT8B0VEye4EPxZfZJkf6e8qV5sJd8BD2lGhtJnXjoZp2PoctwLz
	 X3X3N/2MG9ECe8lEWqtv4m6Y17G4duSBNu2cIgnB0gf8BQZUAJ5fuTlOky2MET93od
	 qWfsvOyWGBVVp/Ptkh3SQHMhKZ3qjoe4vqE+v7Vt1cR0TmwDD/hXNvoBTWcG6XTd+K
	 Z3uJh6ZZuR4xWZ7COPBmesQcJVT0oHvo8HJvuKpypndsrID6sT24ZSf3zCkc3H6nlQ
	 FBfKmxE+Gh4CA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C3kF1H1535607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:46:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:46:15 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:46:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 2/8] wifi: rtw89: mac: abstract register definition of firmware boot debug
Date: Sun, 12 Jul 2026 11:45:00 +0800
Message-ID: <20260712034506.53209-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712034506.53209-1-pkshih@realtek.com>
References: <20260712034506.53209-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38903-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:echuang@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CFDE743B87

The registers of firmware boot debug are different between WiFi 6 and 7
chips. Add field to abstract it accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c     | 5 +++--
 drivers/net/wireless/realtek/rtw89/mac.c    | 1 +
 drivers/net/wireless/realtek/rtw89/mac.h    | 1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0e7168605850..01770a6a1f6f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1939,13 +1939,14 @@ static void rtw89_fw_prog_cnt_dump(struct rtw89_dev *rtwdev)
 
 static void rtw89_fw_dl_fail_dump(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 val32;
 
 	val32 = rtw89_read32(rtwdev, R_AX_WCPU_FW_CTRL);
 	rtw89_err(rtwdev, "[ERR]fwdl 0x1E0 = 0x%x\n", val32);
 
-	val32 = rtw89_read32(rtwdev, R_AX_BOOT_DBG);
-	rtw89_err(rtwdev, "[ERR]fwdl 0x83F0 = 0x%x\n", val32);
+	val32 = rtw89_read32(rtwdev, mac->boot_dbg);
+	rtw89_err(rtwdev, "[ERR]fwdl 0x%x = 0x%x\n", mac->boot_dbg, val32);
 
 	rtw89_fw_prog_cnt_dump(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6e3da5e4a1b3..b58d9439ee6d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7442,6 +7442,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.agg_len_ht = R_AX_AGG_LEN_HT_0,
 	.ps_status = R_AX_PPWRBIT_SETTING,
 	.mu_gid = &rtw89_mac_mu_gid_addr_ax,
+	.boot_dbg = R_AX_BOOT_DBG,
 
 	.muedca_ctrl = {
 		.addr = R_AX_MUEDCA_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a5f1694af91a..c05f5ee0d2fd 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1067,6 +1067,7 @@ struct rtw89_mac_gen_def {
 	u32 agg_len_ht;
 	u32 ps_status;
 	const struct rtw89_mac_mu_gid_addr *mu_gid;
+	u32 boot_dbg;
 
 	struct rtw89_reg_def muedca_ctrl;
 	struct rtw89_reg_def bfee_ctrl;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 4bdf20b7ba6d..46aea7f6a4a1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -3287,6 +3287,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.agg_len_ht = R_BE_AGG_LEN_HT_0,
 	.ps_status = R_BE_WMTX_POWER_BE_BIT_CTL,
 	.mu_gid = &rtw89_mac_mu_gid_addr_be,
+	.boot_dbg = R_BE_BOOT_DBG,
 
 	.muedca_ctrl = {
 		.addr = R_BE_MUEDCA_EN,
-- 
2.25.1


