Return-Path: <linux-wireless+bounces-33998-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KzLIPtpxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33998-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:16:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0683339096
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B6E0311A40F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADF938C2CF;
	Thu, 26 Mar 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQngYQmy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFE156661
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544892; cv=none; b=pbx12UU9qUIzbhs0o3kGVNk2+ve+eahA9qChQTcDIPLNwaAGbKLAs4W/AMMkZppYV45Mn2+SKdgbTPiiZZuHzqR5CKX2nvVMPfSk9Ei1n5WmmrZASugO9QS2STe0jx+ihSrCthy2ST+h7fyPw2YK6z7gxSyNPVtUf3GbqQJGdJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544892; c=relaxed/simple;
	bh=xxad1YNtULpxt/niR8QfAkFNaV0H62dvI8Sn/+iCkMU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sECecJl2ERd4l/FZTfPLb2q7s0/4XIdUo5IAOmKOaIneBpQxs2FolSy+uZcXkGYcKc8LFA9m6N6S+F8OnUBMzA3vTzeYz55kRMejwSPzn5twMqi9ZVUiwZrixCupJCtcvDF/Bia+8eoxZoamsrlZQDHYc7KYng4Mw86Czz1ChAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQngYQmy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b7481f9d3so726277f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544889; x=1775149689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7PjWn2uKu19ACwcJ/pKXHMzgEBbVRkdpTNIiJojbp0=;
        b=VQngYQmyMaM1MEebtthgzb5/635Pbv4HmCOgGpytrkaPKJaaB/hWOo/RWLyPRdSrV0
         L2pZFgXW2YRTgqlKMaG/lSWIqSerEcAEQk6518sh22Kcy/72BR1TMrLtNiEeDrQSJVqd
         T4AEV/JCSeeKa8+Zf5XykCAum2eFENuuYWnf+XwYvoigS194U2g/TmuLRzlmuAKn/SjB
         XgXHF9rPsYMJE61TZIrx10EZ2qNfP0OYj1iQ3/VqhPMP+lw+4UZbO0kmaGyQ1rSZweD9
         Et6/Q2ni1XRooxhclLg+TQyp6e9+oaFzeXaZxqEZEsENIzsjkeQwPQlOAufNag4eeDJx
         mv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544889; x=1775149689;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7PjWn2uKu19ACwcJ/pKXHMzgEBbVRkdpTNIiJojbp0=;
        b=ARFTCNkHFzIEyMSFdrur6MTTyqN4lxx79zoAPfGFFxRC8PnQPAR+8xexP2U3c/Oqt0
         A8Dg/OUBcr2YrAvSUQ45GMU+QXnhLfMwvf8In4B/+mKNFRNX/PFCji4X8teG/JA2p4sa
         X1/EEQ4b7o5eD3YH1+7BUH0VI+r4mBMUDxHGLizEsRN9cjhn/EDrhIVVBV+bxSorqaXy
         M/7Mmdu1je8NrQ5LfADK2tX4tb88ukkMxZfIZEOJytIVSgppDICjhWqCmv1UG1ZfgECL
         yfedp4wR3sY4HtyfQiPRYgLyeTQlwIy+7Vm4ii2fr7K5vOj64BENuMLgZpgL9D75xILW
         yRSA==
X-Gm-Message-State: AOJu0Yy7VGr3mwDAPjw5zU2iiXKHm7H4EReljeikUCc0o/3fPGf1t+xb
	0RFLIpbCtbR4cF+aAFzz3Tk4PSAVv38Pqx0npOcJgOFFKVIM8zu0ayLcbDBRQA==
X-Gm-Gg: ATEYQzxSVGDd27/LiV222H63ilYLxM7/KXeNbKZNinc0LYM2YR55dRt0iDouf0U0IEx
	8/wzCWeoZbRQukqsHzA1UAUDfLbV9tSkOKVm2rdEJ53IKsVb9OEqMZPrSj44mpYKZDA2UNzcvkW
	zk2oHvzhKw8M1vGOgRJzyXbW90JB5whPx7BQ8Uoe2A6AsB3HrTpXnruZOXlsXJ4TWhWYjfzlCoA
	fTTNknwJKBAmXFZDhPek7LQ+FJgiV2BXaih4gYFrAh970wwgCy2910pGxRTkbLGPHNojjr3XsGL
	fswFhGhCNZO/fByxl/UEqjPrIwjxe/uLANn/Qq2qGz3HtC6yUmJ25v3rJ+hrOdlreghF8F9oh2G
	2+HR2Z7z5P4jWtF+wHqiRfMKwoiYd3sfVvIvVbIqOrE8HSQXd0Uq6EAHeHYjrfkfHE16IGPXSlJ
	k1qW6wJNHBvu1xVdNNU/4/QkBa+dP0db6mhB8PMkFy
X-Received: by 2002:a05:6000:1449:b0:439:ddc0:4bee with SMTP id ffacd0b85a97d-43b889c4d98mr13229715f8f.16.1774544889096;
        Thu, 26 Mar 2026 10:08:09 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919dfb54sm9432090f8f.31.2026.03.26.10.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:08:08 -0700 (PDT)
Message-ID: <6a8b746c-f702-4a76-876d-bc39991b3baa@gmail.com>
Date: Thu, 26 Mar 2026 19:08:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 09/12] wifi: rtw89: Add
 rtw8922a_hfc_param_ini_usb{2,3}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Language: en-US
In-Reply-To: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-33998-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0683339096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8922AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |   3 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 125 +++++++++++++++++-
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3320797be26d..57072b5d9feb 100644
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
index 88a877556cb3..f997d54faaf1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -925,6 +925,9 @@ struct rtw89_mac_size_set {
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
index 83497b4d7992..141759798920 100644
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


