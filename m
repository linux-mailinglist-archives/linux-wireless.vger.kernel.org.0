Return-Path: <linux-wireless+bounces-31624-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F1KBs8shmnkKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31624-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 19:02:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1A10194A
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 19:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD89630427D9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D3D2D8DD0;
	Fri,  6 Feb 2026 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5X9LOd4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C917993
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400898; cv=none; b=S0P0ez8TtbAs0TC0jE+yoTrkJpTjfULjrVTfk1yScZBSXqaWp/LAx7N+x/6vJlElKQyFcm6s7pPpJIwmpMIrHCLFBbYpZqL9CuZwWsZ0mzoBo4wT9d9aoWln4DoelZmaPE7NThfe61MDW4gTQqiel/xV+fjmqri9+Al8sRF4y9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400898; c=relaxed/simple;
	bh=UivLRo7bdTJUlu1PqgquBIlsPNFiQeRo+/ySJjQnFUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Hl+q88kKAW6JEgWXH+SA8dcFXryBiCmlvj9UvU0h/z3XnXLsokBIyhVD0pHTc6WJfhw+Irp+FrB9RbijNVTne6scxPcFvG8KlOGnVCgeNQCd9/jJuKM/M3jPl+OydYW/YsNLwKKGaL+2s5bs5U2AFhhhuCmuXtyI/zxZbrtj/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5X9LOd4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so18868615e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770400896; x=1771005696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2NzcVsPPG2XE2zcxqgEIuU+9hCwA6HLkSVNGBkzzaA=;
        b=h5X9LOd4eqYk2w9mSe6nGWXCzzAiiIAQVIgO1Y0Tuee+a3uiXAn1FPiYRAV+TRfGjf
         eYsmoh0MgAl2ag95GLWPZfiiNS/6drNuRcoQo+qB+DYLUL7xeUicxeiSZ4lcGJ8FIVmz
         cRm7zjJNWfRHssgo3Z89JvdRju1SR82AYlIQTdC8xeG7vpMEuPX+lttHPCEshVbEeazL
         FfSAxx/XccmHpufKKTcncYz55D7IPjjQXVk/7gZl8MOaX+Ln5JK5xrObOTRh0bGp8aSV
         nmYH5jzAL4rF0D3si366dZhjnWOuMjjRpanYTgrobWbCDfc1rNdRlR2GS/YtHoxI35g4
         PEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770400896; x=1771005696;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2NzcVsPPG2XE2zcxqgEIuU+9hCwA6HLkSVNGBkzzaA=;
        b=P5YrorAAn+0ClLmkRiMx5X7RkIhNZbsMgVq/NsEKd6KJWSAklSR5x12y3px7IgBee0
         ZQa+BI9uNQwkMtYaaFrjUWUsQPhNde/IPqvAH5KuJUSvm7R8wp1CYzFpSolmbLsF95Zf
         Fac+x71Ug8y2HXuVRNntNkDDVjh+aMngFt5eOy1rI4Znm4bX++suqUcLiDgzSp2ecrM/
         0XrtnoR01iYOd/fHXNf8y7atWNa7VyLRAy3eL49u2Jee+hRG5gVgzKVnFUoAKbZuckA1
         qOAHbkeD6zBAegVLcIjGCRW2DZC/iuCoVwgQgYWaOKG2q7bbI+1E12wiJf7hRQ5hpnUH
         3Gdw==
X-Gm-Message-State: AOJu0YwM6/ECbLcmfwBTRlZSOH8UOFR8vLyU+d5k/Bf5NJIP4mKyjmOI
	kVz98qEqanWuDPeY85PS6Md6g4Xub8aM0epk6E7VCDkxWUH7s78G3YJMr6FHiw==
X-Gm-Gg: AZuq6aIPPBQhG26g/Du3mA8QrMY1q/77tFTm4UP2UtvY5vtmiEwNKxTE/q33AcCH+Fr
	Grv0QNofZ9ROvFRQYWXR6s6vZSe5dyns1eFPDMJ1HJ01na7fD8MbsRK9rFZ0FN1UUnKaut2h3nv
	p3zlQI0DWZyUUF5O6K/Ukv0KIJGs4levTp0XT/HSO6neVfRTzgeHoQ0f5ThWjmutw9V+QIt3c5+
	W9GY+kL0u5bfwlgm7bsaOQv65G7I28vCPqF1LQqYsyHT5tDGY2cFlRiJbpjyuvFxKA2FQ78ynXk
	W/E0+QGCd3M+wyd0Ki2VCIc4YtW/bRzSxHblLSzUbbDCRkYBvn2ByJ8d0nakr+J2AwrnJ9uNzAj
	CrhYQMK/YeTi4EQXqizRnovSvvFfkPl5tpMGcpnRUGrGMxPhtXfQmpgHBuQQUxgc4Bpr5vMbON3
	/QAWOaFrJXQenAHnwFYy+vZZdzp/S7nw==
X-Received: by 2002:a05:600c:528b:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-483201d61c7mr51024945e9.7.1770400896176;
        Fri, 06 Feb 2026 10:01:36 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831d0b5b31sm117043335e9.4.2026.02.06.10.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 10:01:35 -0800 (PST)
Message-ID: <88cce107-ff52-496f-bb77-b930e4182b67@gmail.com>
Date: Fri, 6 Feb 2026 20:01:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw89: Turbo mode for RTL8851BU/RTL8852BU
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31624-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 65E1A10194A
X-Rspamd-Action: no action

RTL8851BU and RTL8852BU currently have much lower TX speed than
expected, ~100 and ~300 Mbps, respectively. This is because part of the
chip's memory is allocated for some unknown firmware features instead of
the TX buffers.

The vendor drivers have a module parameter called "rtw_quota_turbo_en",
which can be used to choose between full TX speed or the unknown
firmware features. It is on by default.

Change the relevant chip parameters to implement the turbo mode. Do it
only for USB because PCI is already fast even without the turbo mode.
It's unclear if SDIO will need it or not.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---

What firmware features are we missing when we use the turbo mode?
Is it anything important?

---
 drivers/net/wireless/realtek/rtw89/mac.c      | 31 +++++++++---------
 drivers/net/wireless/realtek/rtw89/mac.h      | 16 +++++-----
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 32 +++++++++----------
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 24 +++++++-------
 4 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8472f1a63951..c98ca2a82194 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1729,8 +1729,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8852C PCIE SCC */
 	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
 	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
-	/* 8852B USB2.0/USB3.0 SCC */
-	.wde_size25 = {RTW89_WDE_PG_64, 162, 94,},
+	/* 8852B USB2.0/USB3.0 SCC turbo */
+	.wde_size30 = {RTW89_WDE_PG_64, 220, 36,},
 	/* 8852C USB2.0 */
 	.wde_size31 = {RTW89_WDE_PG_64, 384, 0,},
 	/* PCIE */
@@ -1754,10 +1754,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size19 = {RTW89_PLE_PG_128, 1904, 16,},
 	.ple_size20_v1 = {RTW89_PLE_PG_128, 2554, 182, 40960,},
 	.ple_size22_v1 = {RTW89_PLE_PG_128, 2736, 0, 40960,},
-	/* 8852B USB2.0 SCC */
-	.ple_size32 = {RTW89_PLE_PG_128, 620, 20,},
-	/* 8852B USB3.0 SCC */
-	.ple_size33 = {RTW89_PLE_PG_128, 632, 8,},
+	/* 8851B USB2.0 SCC turbo */
+	.ple_size27 = {RTW89_PLE_PG_128, 1396, 12,},
+	/* 8852B USB3.0 SCC turbo */
+	.ple_size31 = {RTW89_PLE_PG_128, 1392, 16,},
 	/* 8852C USB2.0 */
 	.ple_size34 = {RTW89_PLE_PG_128, 3374, 18,},
 	/* PCIE 64 */
@@ -1780,8 +1780,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt18 = {3228, 60, 0, 40,},
 	.wde_qt19_v1 = {613, 6, 0, 20,},
 	.wde_qt23 = {958, 48, 0, 16,},
-	/* 8852B USB2.0/USB3.0 SCC */
-	.wde_qt25 = {152, 2, 0, 8,},
+	/* 8852B USB2.0/USB3.0 SCC turbo */
+	.wde_qt30 = {210, 2, 0, 8,},
 	/* 8852C USB2.0 */
 	.wde_qt31 = {338, 6, 0, 40,},
 	.ple_qt0 = {320, 320, 32, 16, 13, 13, 292, 292, 64, 18, 1, 4, 0,},
@@ -1799,6 +1799,9 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8852A USB SCC */
 	.ple_qt25 = {1536, 0, 16, 48, 13, 13, 360, 0, 32, 40, 8, 0,},
 	.ple_qt26 = {2654, 0, 1134, 48, 64, 13, 1478, 0, 64, 128, 120, 0,},
+	/* 8852B USB3.0 SCC turbo */
+	.ple_qt27 = {1040, 0, 16, 48, 13, 13, 178, 0, 32, 14, 8, 0,},
+	.ple_qt28 = {1040, 0, 32, 48, 43, 13, 208, 0, 62, 14, 24, 0,},
 	/* USB 52C USB3.0 */
 	.ple_qt42 = {1068, 0, 16, 48, 4, 13, 178, 0, 16, 1, 8, 16, 0,},
 	.ple_qt42_v2 = {91, 91, 32, 16, 19, 13, 91, 91, 44, 18, 1, 4, 0, 0,},
@@ -1817,13 +1820,9 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* PCIE 64 */
 	.ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,},
 	.ple_qt59 = {147, 0, 32, 20, 1860, 13, 2025, 0, 1879, 14, 24, 0,},
-	/* USB2.0 52B SCC */
-	.ple_qt72 = {130, 0, 16, 48, 4, 13, 322, 0, 32, 14, 8, 0, 0,},
-	/* USB2.0 52B 92K */
-	.ple_qt73 = {130, 0, 32, 48, 37, 13, 355, 0, 65, 14, 24, 0, 0,},
-	/* USB3.0 52B 92K */
-	.ple_qt74 = {286, 0, 16, 48, 4, 13, 178, 0, 32, 14, 8, 0, 0,},
-	.ple_qt75 = {286, 0, 32, 48, 37, 13, 211, 0, 65, 14, 24, 0, 0,},
+	/* 8851B USB2.0 SCC turbo */
+	.ple_qt61 = {858, 0, 16, 48, 4, 13, 370, 0, 32, 14, 8, 0, 0,},
+	.ple_qt62 = {858, 0, 32, 48, 37, 13, 403, 0, 65, 14, 24, 0, 0,},
 	/* USB2.0 52C */
 	.ple_qt78 = {1560, 0, 16, 48, 13, 13, 390, 0, 32, 38, 8, 16, 0,},
 	/* USB2.0 52C */
@@ -2004,7 +2003,7 @@ static u32 dle_expected_used_size(struct rtw89_dev *rtwdev,
 {
 	u32 size = rtwdev->chip->fifo_size;
 
-	if (mode == RTW89_QTA_SCC)
+	if (mode == RTW89_QTA_SCC && rtwdev->hci.type != RTW89_HCI_TYPE_USB)
 		size -= rtwdev->chip->dle_scc_rsvd_size;
 
 	return size;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index e71a71648ab8..e6b715b95409 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -938,7 +938,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size18_v1;
 	const struct rtw89_dle_size wde_size19;
 	const struct rtw89_dle_size wde_size23;
-	const struct rtw89_dle_size wde_size25;
+	const struct rtw89_dle_size wde_size30;
 	const struct rtw89_dle_size wde_size31;
 	const struct rtw89_dle_size ple_size0;
 	const struct rtw89_dle_size ple_size1;
@@ -953,8 +953,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size19;
 	const struct rtw89_dle_size ple_size20_v1;
 	const struct rtw89_dle_size ple_size22_v1;
-	const struct rtw89_dle_size ple_size32;
-	const struct rtw89_dle_size ple_size33;
+	const struct rtw89_dle_size ple_size27;
+	const struct rtw89_dle_size ple_size31;
 	const struct rtw89_dle_size ple_size34;
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt1;
@@ -968,7 +968,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_wde_quota wde_qt19_v1;
 	const struct rtw89_wde_quota wde_qt23;
-	const struct rtw89_wde_quota wde_qt25;
+	const struct rtw89_wde_quota wde_qt30;
 	const struct rtw89_wde_quota wde_qt31;
 	const struct rtw89_ple_quota ple_qt0;
 	const struct rtw89_ple_quota ple_qt1;
@@ -980,6 +980,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt18;
 	const struct rtw89_ple_quota ple_qt25;
 	const struct rtw89_ple_quota ple_qt26;
+	const struct rtw89_ple_quota ple_qt27;
+	const struct rtw89_ple_quota ple_qt28;
 	const struct rtw89_ple_quota ple_qt42;
 	const struct rtw89_ple_quota ple_qt42_v2;
 	const struct rtw89_ple_quota ple_qt43;
@@ -991,10 +993,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt57;
 	const struct rtw89_ple_quota ple_qt58;
 	const struct rtw89_ple_quota ple_qt59;
-	const struct rtw89_ple_quota ple_qt72;
-	const struct rtw89_ple_quota ple_qt73;
-	const struct rtw89_ple_quota ple_qt74;
-	const struct rtw89_ple_quota ple_qt75;
+	const struct rtw89_ple_quota ple_qt61;
+	const struct rtw89_ple_quota ple_qt62;
 	const struct rtw89_ple_quota ple_qt78;
 	const struct rtw89_ple_quota ple_qt79;
 	const struct rtw89_ple_quota ple_qt_52a_wow;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index d6deb44a685b..b63c0e785209 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -52,25 +52,25 @@ static const struct rtw89_hfc_param_ini rtw8851b_hfc_param_ini_pcie[] = {
 };
 
 static const struct rtw89_hfc_ch_cfg rtw8851b_hfc_chcfg_usb[] = {
-	{18, 152, grp_0}, /* ACH 0 */
-	{18, 152, grp_0}, /* ACH 1 */
-	{18, 152, grp_0}, /* ACH 2 */
-	{18, 152, grp_0}, /* ACH 3 */
+	{18, 210, grp_0}, /* ACH 0 */
+	{18, 210, grp_0}, /* ACH 1 */
+	{18, 210, grp_0}, /* ACH 2 */
+	{18, 210, grp_0}, /* ACH 3 */
 	{0, 0, grp_0}, /* ACH 4 */
 	{0, 0, grp_0}, /* ACH 5 */
 	{0, 0, grp_0}, /* ACH 6 */
 	{0, 0, grp_0}, /* ACH 7 */
-	{18, 152, grp_0}, /* B0MGQ */
-	{18, 152, grp_0}, /* B0HIQ */
+	{18, 210, grp_0}, /* B0MGQ */
+	{18, 210, grp_0}, /* B0HIQ */
 	{0, 0, grp_0}, /* B1MGQ */
 	{0, 0, grp_0}, /* B1HIQ */
 	{0, 0, 0} /* FWCMDQ */
 };
 
 static const struct rtw89_hfc_pub_cfg rtw8851b_hfc_pubcfg_usb = {
-	152, /* Group 0 */
+	210, /* Group 0 */
 	0, /* Group 1 */
-	152, /* Public Max */
+	210, /* Public Max */
 	0 /* WP threshold */
 };
 
@@ -111,10 +111,10 @@ static const struct rtw89_dle_mem rtw8851b_dle_mem_pcie[] = {
 };
 
 static const struct rtw89_dle_mem rtw8851b_dle_mem_usb2[] = {
-	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size25,
-			   &rtw89_mac_size.ple_size32, &rtw89_mac_size.wde_qt25,
-			   &rtw89_mac_size.wde_qt25, &rtw89_mac_size.ple_qt72,
-			   &rtw89_mac_size.ple_qt73},
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size30,
+			   &rtw89_mac_size.ple_size27, &rtw89_mac_size.wde_qt30,
+			   &rtw89_mac_size.wde_qt30, &rtw89_mac_size.ple_qt61,
+			   &rtw89_mac_size.ple_qt62},
 	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
 			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
 			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
@@ -124,10 +124,10 @@ static const struct rtw89_dle_mem rtw8851b_dle_mem_usb2[] = {
 };
 
 static const struct rtw89_dle_mem rtw8851b_dle_mem_usb3[] = {
-	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size25,
-			   &rtw89_mac_size.ple_size33, &rtw89_mac_size.wde_qt25,
-			   &rtw89_mac_size.wde_qt25, &rtw89_mac_size.ple_qt74,
-			   &rtw89_mac_size.ple_qt75},
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size30,
+			   &rtw89_mac_size.ple_size31, &rtw89_mac_size.wde_qt30,
+			   &rtw89_mac_size.wde_qt30, &rtw89_mac_size.ple_qt27,
+			   &rtw89_mac_size.ple_qt28},
 	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
 			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
 			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 197e3f5fb21b..393986b297ea 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -50,25 +50,25 @@ static const struct rtw89_hfc_param_ini rtw8852b_hfc_param_ini_pcie[] = {
 };
 
 static const struct rtw89_hfc_ch_cfg rtw8852b_hfc_chcfg_usb[] = {
-	{18, 152, grp_0}, /* ACH 0 */
-	{18, 152, grp_0}, /* ACH 1 */
-	{18, 152, grp_0}, /* ACH 2 */
-	{18, 152, grp_0}, /* ACH 3 */
+	{18, 210, grp_0}, /* ACH 0 */
+	{18, 210, grp_0}, /* ACH 1 */
+	{18, 210, grp_0}, /* ACH 2 */
+	{18, 210, grp_0}, /* ACH 3 */
 	{0, 0, grp_0}, /* ACH 4 */
 	{0, 0, grp_0}, /* ACH 5 */
 	{0, 0, grp_0}, /* ACH 6 */
 	{0, 0, grp_0}, /* ACH 7 */
-	{18, 152, grp_0}, /* B0MGQ */
-	{18, 152, grp_0}, /* B0HIQ */
+	{18, 210, grp_0}, /* B0MGQ */
+	{18, 210, grp_0}, /* B0HIQ */
 	{0, 0, grp_0}, /* B1MGQ */
 	{0, 0, grp_0}, /* B1HIQ */
 	{0, 0, 0} /* FWCMDQ */
 };
 
 static const struct rtw89_hfc_pub_cfg rtw8852b_hfc_pubcfg_usb = {
-	152, /* Group 0 */
+	210, /* Group 0 */
 	0, /* Group 1 */
-	152, /* Public Max */
+	210, /* Public Max */
 	0 /* WP threshold */
 };
 
@@ -109,10 +109,10 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 };
 
 static const struct rtw89_dle_mem rtw8852b_dle_mem_usb3[] = {
-	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size25,
-			   &rtw89_mac_size.ple_size33, &rtw89_mac_size.wde_qt25,
-			   &rtw89_mac_size.wde_qt25, &rtw89_mac_size.ple_qt74,
-			   &rtw89_mac_size.ple_qt75},
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size30,
+			   &rtw89_mac_size.ple_size31, &rtw89_mac_size.wde_qt30,
+			   &rtw89_mac_size.wde_qt30, &rtw89_mac_size.ple_qt27,
+			   &rtw89_mac_size.ple_qt28},
 	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
 			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
 			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
-- 
2.52.0


