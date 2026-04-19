Return-Path: <linux-wireless+bounces-34984-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAHMD5zc5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34984-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:46:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C50142438F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2F0A300D687
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F42AEE4;
	Sun, 19 Apr 2026 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCF8KnUR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1740DFD7
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606359; cv=none; b=AHzdrT0/oYZtMHEXdJkOStQR+k9Yp/3fx+oL+nBe7Py27ou+KcnPu3xUiXeuJWGsYN99aGsMn2/Ga5ptnfMb5FCHe1DLZzAEk1RbNAR2fzmkYrIP4CZCr7f/DPuYdydAzTPx6zyTvdnkJc9OrJ2oy5dzkWARmd+XtTGxItYDgEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606359; c=relaxed/simple;
	bh=nrwY7ySWrxDmYKTb1r7nCO9S6cCehLpBTE7M2R/olyc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cL/Rw9kehm66fuAw1SkUMymlYFNsvI42Rt3N6DDGqPCeIBySjLG4F7j8rmLCHXJgeEdal5HfTLfjGfTIOryUYsu2B885GMWh9CzcfFoGyUGI091/ERQN/n3rjBWp6zYr1HfwB0r1TNO4fwCb7ZQdPhT9k6L2RpD5NHR3AzPsB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCF8KnUR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso22604215e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606357; x=1777211157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Bz9+5tEMfQ7nnHZj69GB7kFhD6vm9UIyrD7KzCRPDw=;
        b=SCF8KnURjaCf2rWpjLsvRDcw0lNamT/s7PbPB0kGdf19UlRK7LXdDcATHfpz3gQEBc
         qgAwIwn9MEF+p+FPIfXhh1WJZ37Qex3FD/RQ6Qz9+nnO5SPTccXQSpLAQLUItHZ197hb
         9CMaDIuBun2sQPghbj/vNYvwhqVxAIcawWFGShN6mqVerd/iAKwwAUKcpijhBDcej9hx
         R4F/IId710O92kEzRPnkJcl2Rtf4upI6uNYwwimaag4IlnrMQSsJ+/qjq897IMcHIfZ4
         79Xs0Rlc1rHLw4uGo2HAKtlLdFNVfigfwViS7if2cQ4LINWYa120SqzJFDRVnPSDwTff
         x3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606357; x=1777211157;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bz9+5tEMfQ7nnHZj69GB7kFhD6vm9UIyrD7KzCRPDw=;
        b=RNXLNsWkchRq9vjTgeCl5SMfmOnH2kZ3IaFiAmfffZ/gwvGSABbPC3NjJ/0zYL/uMP
         BdjhTxH+u/9LEEVpZJ0LTniwRJt0eTT1Z5wiicsMdlHqucX+nKx1+DBk6vUmFNqUQ4+F
         sFC8k9dQR9Tx2rqT0x1+LXE++jFGuAisthD7eyoBtaCNK1MLQxSUSO+IJCvdtVV3TcGa
         HTApQqNc7/K/xOqumeQCmskNv4uKj4x2UZ9+e++2h0fVv91AdXmTfel1kmEYgrK7dsrH
         8Ushzk+YzyEHgU0vKmESQxkhBPJjGimTo/BsdNqKFDjcsH4NnpORvk3lLAnsbHMKwhok
         9fOw==
X-Gm-Message-State: AOJu0YzL1ZLY1mnrdrBlDw50/aphsLg/JIoUgcP+9/xu9AuDJD1WdLTC
	wQywFiap+ZCD2l3cFlkXK7+pXiG3JSLdR8QUt0Mbps+Mo6dY48uKJUQ70aK03w==
X-Gm-Gg: AeBDieubvob1o8BK30ec7cPvFK5qUN5QBAqt4ilHxkJ+bIrOUXtcRU4GBgoo8qoLDlD
	Ei/VMKQ2636Tw6iyeYuBJOxnoBXSLSGBY5JL3L7xv1kCt8FsvTK8JjhOWXVZuOeX1fRwVWr8g1+
	AQtrZ2uW5ObvfWZ8f7YW/nMGegqagWQLqcUyJm1gj+Ex0GEW+Ofq76a5rx2DuzHY6s2nquxPLgE
	U4jtUmSnSJz02wT24jrSppr1KyiE1NfuYxQ/bNULUMQt7prmC6/+1NNcIBMTWyTJKNMkT3La7GC
	Gz5VTXkI5wXIgUyJJpBWqowOLJejoJ32bTb9aR4EXd5yLC202mkTpdc00CebMuXAenBtssDas9/
	ZMw1oDKFamYc3na5gcCRHALDp/iqa5XCMzG2n2eWSVR1tSIO3UtA6k2Tsqjeqw7tpTxpohrHpfc
	vESuT3mKCf6Lz2UbjN2S43xOrHlfZ3L+GSS2kJY9IA
X-Received: by 2002:a05:600c:5297:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-488fb74a431mr164930925e9.8.1776606356545;
        Sun, 19 Apr 2026 06:45:56 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78446csm96399315e9.4.2026.04.19.06.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:45:56 -0700 (PDT)
Message-ID: <474eb37a-a2e1-434a-b648-9e4b78e604d2@gmail.com>
Date: Sun, 19 Apr 2026 16:45:55 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 08/11] wifi: rtw89: Add
 rtw8922a_hfc_param_ini_usb{2,3}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Language: en-US
In-Reply-To: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34984-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C50142438F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8922AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/mac.c      |   3 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 125 +++++++++++++++++-
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8d5375ec33a2..9058312322e0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1716,6 +1716,9 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.hfc_preccfg_pcie = {2, 40, 0, 0, 1, 0, 0, 0},
 	.hfc_prec_cfg_c0 = {2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0},
 	.hfc_prec_cfg_c2 = {0, 256, 0, 0, 0, 0, 0, 0, 0, 256, 0, 0},
+	.hfc_prec_cfg_c3 = {18, 32, 148, 148, 1, 1, 1, 1},
+	.hfc_prec_cfg_c5 = {18, 32, 148, 148, 1, 1, 0, 1},
+	.hfc_prec_cfg_c6 = {8, 32, 148, 148, 1, 1, 0, 1},
 	/* PCIE 64 */
 	.wde_size0 = {RTW89_WDE_PG_64, 4095, 1,},
 	.wde_size0_v1 = {RTW89_WDE_PG_64, 3328, 0, 0,},
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9db9ae219cd6..3aad234b2a0f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -926,6 +926,9 @@ struct rtw89_mac_size_set {
 	const struct rtw89_hfc_prec_cfg hfc_preccfg_pcie;
 	const struct rtw89_hfc_prec_cfg hfc_prec_cfg_c0;
 	const struct rtw89_hfc_prec_cfg hfc_prec_cfg_c2;
+	const struct rtw89_hfc_prec_cfg hfc_prec_cfg_c3;
+	const struct rtw89_hfc_prec_cfg hfc_prec_cfg_c5;
+	const struct rtw89_hfc_prec_cfg hfc_prec_cfg_c6;
 	const struct rtw89_dle_size wde_size0;
 	const struct rtw89_dle_size wde_size1;
 	const struct rtw89_dle_size wde_size0_v1;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index b247980cc9ec..380049ef15b5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -57,6 +57,126 @@ static const struct rtw89_hfc_param_ini rtw8922a_hfc_param_ini_pcie[] = {
 	[RTW89_QTA_INVALID] = {NULL},
 };
 
+static const struct rtw89_hfc_ch_cfg rtw8922a_hfc_chcfg_ch7[] = {
+	{54, 222, grp_0}, /* ACH 0 */
+	{0, 0, grp_0}, /* ACH 1 */
+	{54, 222, grp_0}, /* ACH 2 */
+	{0, 0, grp_0}, /* ACH 3 */
+	{54, 222, grp_0}, /* ACH 4 */
+	{0, 0, grp_0}, /* ACH 5 */
+	{54, 222, grp_0}, /* ACH 6 */
+	{0, 0, grp_0}, /* ACH 7 */
+	{54, 222, grp_0}, /* B0MGQ */
+	{0, 0, grp_0}, /* B0HIQ */
+	{54, 222, grp_0}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{0, 0, 0}, /* FWCMDQ */
+	{0, 0, 0}, /* BMC */
+	{0, 0, 0}, /* H2D */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8922a_hfc_pubcfg_p7 = {
+	492, /* Group 0 */
+	0, /* Group 1 */
+	492, /* Public Max */
+	0, /* WP threshold */
+};
+
+static const struct rtw89_hfc_ch_cfg rtw8922a_hfc_chcfg_ch8[] = {
+	{24, 196, grp_0}, /* ACH 0 */
+	{0, 0, grp_0}, /* ACH 1 */
+	{54, 226, grp_0}, /* ACH 2 */
+	{0, 0, grp_0}, /* ACH 3 */
+	{54, 196, grp_1}, /* ACH 4 */
+	{0, 0, grp_1}, /* ACH 5 */
+	{54, 196, grp_1}, /* ACH 6 */
+	{0, 0, grp_1}, /* ACH 7 */
+	{54, 226, grp_0}, /* B0MGQ */
+	{0, 0, grp_0}, /* B0HIQ */
+	{54, 196, grp_1}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{0, 0, 0}, /* FWCMDQ */
+	{0, 0, 0}, /* BMC */
+	{0, 0, 0}, /* H2D */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8922a_hfc_pubcfg_p8 = {
+	304, /* Group 0 */
+	304, /* Group 1 */
+	608, /* Public Max */
+	96, /* WP threshold */
+};
+
+static const struct rtw89_hfc_param_ini rtw8922a_hfc_param_ini_usb2[] = {
+	[RTW89_QTA_SCC] = {rtw8922a_hfc_chcfg_ch7, &rtw8922a_hfc_pubcfg_p7,
+			   &rtw89_mac_size.hfc_prec_cfg_c5, RTW89_HCIFC_STF},
+	[RTW89_QTA_DBCC] = {rtw8922a_hfc_chcfg_ch8, &rtw8922a_hfc_pubcfg_p8,
+			   &rtw89_mac_size.hfc_prec_cfg_c6, RTW89_HCIFC_STF},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_prec_cfg_c2,
+			    RTW89_HCIFC_POH},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
+static const struct rtw89_hfc_ch_cfg rtw8922a_hfc_chcfg_ch4[] = {
+	{54, 606, grp_0}, /* ACH 0 */
+	{0, 0, grp_0}, /* ACH 1 */
+	{54, 606, grp_0}, /* ACH 2 */
+	{0, 0, grp_0}, /* ACH 3 */
+	{54, 606, grp_0}, /* ACH 4 */
+	{0, 0, grp_0}, /* ACH 5 */
+	{54, 606, grp_0}, /* ACH 6 */
+	{0, 0, grp_0}, /* ACH 7 */
+	{54, 606, grp_0}, /* B0MGQ */
+	{0, 0, grp_0}, /* B0HIQ */
+	{54, 606, grp_0}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{0, 0, 0}, /* FWCMDQ */
+	{0, 0, 0}, /* BMC */
+	{0, 0, 0}, /* H2D */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8922a_hfc_pubcfg_p4 = {
+	876, /* Group 0 */
+	0, /* Group 1 */
+	876, /* Public Max */
+	0, /* WP threshold */
+};
+
+static const struct rtw89_hfc_ch_cfg rtw8922a_hfc_chcfg_ch5[] = {
+	{54, 311, grp_0}, /* ACH 0 */
+	{0, 0, grp_0}, /* ACH 1 */
+	{54, 311, grp_0}, /* ACH 2 */
+	{0, 0, grp_0}, /* ACH 3 */
+	{54, 311, grp_1}, /* ACH 4 */
+	{0, 0, grp_1}, /* ACH 5 */
+	{54, 311, grp_1}, /* ACH 6 */
+	{0, 0, grp_1}, /* ACH 7 */
+	{54, 311, grp_0}, /* B0MGQ */
+	{0, 0, grp_0}, /* B0HIQ */
+	{54, 311, grp_1}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{0, 0, 0}, /* FWCMDQ */
+	{0, 0, 0}, /* BMC */
+	{0, 0, 0}, /* H2D */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8922a_hfc_pubcfg_p5 = {
+	419, /* Group 0 */
+	419, /* Group 1 */
+	838, /* Public Max */
+	0, /* WP threshold */
+};
+
+static const struct rtw89_hfc_param_ini rtw8922a_hfc_param_ini_usb3[] = {
+	[RTW89_QTA_SCC] = {rtw8922a_hfc_chcfg_ch4, &rtw8922a_hfc_pubcfg_p4,
+			   &rtw89_mac_size.hfc_prec_cfg_c3, RTW89_HCIFC_STF},
+	[RTW89_QTA_DBCC] = {rtw8922a_hfc_chcfg_ch5, &rtw8922a_hfc_pubcfg_p5,
+			   &rtw89_mac_size.hfc_prec_cfg_c3, RTW89_HCIFC_STF},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_prec_cfg_c2,
+			    RTW89_HCIFC_POH},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
 static const struct rtw89_dle_mem rtw8922a_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size0_v1,
 			   &rtw89_mac_size.ple_size0_v1, &rtw89_mac_size.wde_qt0_v1,
@@ -2969,7 +3089,10 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
-	.hfc_param_ini		= {rtw8922a_hfc_param_ini_pcie, NULL, NULL, NULL},
+	.hfc_param_ini		= {rtw8922a_hfc_param_ini_pcie,
+				   rtw8922a_hfc_param_ini_usb2,
+				   rtw8922a_hfc_param_ini_usb3,
+				   NULL},
 	.dle_mem		= {rtw8922a_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
-- 
2.53.0


