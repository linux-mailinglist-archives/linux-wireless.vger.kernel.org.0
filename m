Return-Path: <linux-wireless+bounces-34985-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDoeAMTc5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34985-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:46:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9119424397
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5F6A300D9CD
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606462AEE4;
	Sun, 19 Apr 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICCrx6yf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295640DFD7
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606396; cv=none; b=NtQRABbb91hNL5XcihtGT48Sc8pxS71zl7DJUSgp5jg3i1u4X0trh0qdBxq9zEDZ+0W4f5YUUEsY8UzyzXfamzfcAhNnd+Zz5tSm6nRYiPl/iqgUSoER88KJNhiTwWcSKTiM/TRAlAlC0G2uEwLsjXByDOyIQrYYuO6CJz0j+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606396; c=relaxed/simple;
	bh=Bz1nCWsso9iio7H7zS3mb6SCeWwEiM4WL/FR2Eg/CEw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W2tB3hrrBRC/4jLlf518wZnaleS07aYZt2qNVkpteyJqFGT6GKVAp4RoXR3DtGkEJ/Umenal0oMZgbEgJdlJ0yj4Vo9Pk3cHetPDpcoXm2YZOtfVS6s61GuN6zStYH07SX4rK+O7NtkWr0lzFY1AQXJg7rRjVh/Wu/wX0GDRRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICCrx6yf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43fe608cb92so1343698f8f.2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606393; x=1777211193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UNSD4HKHmrI3tIjZqsHFvIuPFVnt7j58cZPhRfu9YUA=;
        b=ICCrx6yfptEU6phIvqK+wJAw4Td5UapGxuVobYWRHDMwquneUcTewWUz7oaFZuiVs4
         ehQ+1p7NmAMUZXI4O8MS7CqxGawZcsylULjoKulA9v6JspVWL9GOZfql31cWsf9s4a6X
         IBkt28HOip3d3nGCy19qCTKlj37AzDoEngW4ba9F5UofKOex5/Gy1QnXZffvs7eTMetf
         oAIJjIo8zdDluPHp+wTxCtO7kjEzzi6uDlQw8ghhSllnQuarCTzV+9TI2FcjbAiJPoGB
         wG5QjNnx7rQg3miA8eyoERyAX6NBcqwwEg0Ui+2R/xqS8NKqMzLXhS5geghaaphOQUlT
         CgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606393; x=1777211193;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNSD4HKHmrI3tIjZqsHFvIuPFVnt7j58cZPhRfu9YUA=;
        b=DXqr8QePKb/Ws04BgzDgJ3Jq/Jh4awAibkxLu3tlHtbqwnWiPJh6k+r9I/YXHWoCdH
         /MKFFiI63yWfFn7MCZOF1+uqM9Gg/fVCetY1L+fHw6Ae7wIXWzdvcqLaX/cQWQBoWaIE
         Jiavfu+SCB7zqIS0XtYxicP3rYXIhZ14nsX7XFbB2dy8+e+12LRHjqiarGyWw5JiQ+Iy
         p48/Wz0Px83QyJe1oUmJ4HeghTEv7HA3Oa5rSaKrOLCTusm2ELMykpdXjDaM8xbK2xDu
         j62quElpxuRiYGHun3+pKoNSkY25JmHHNwf2/oeag3OIqOZjMdDOm8j2mXzwqCKe0mVE
         zGhQ==
X-Gm-Message-State: AOJu0Ywfk1QOyuquggFObCHkz1qrZgSezeuhbyR3HXBg3VfdIZQJyRh5
	EzvJqJrmAsWvIJWvYMOcCm/1dCG3pwh6J+1A34L29r3HZ2Izby5Eak/HTtATag==
X-Gm-Gg: AeBDietf97RBJ9otMJA7hIQZTs2vmJbiiTiqD0MevTNf7VVza+yCXbqb6w6A4ks+Z2j
	NeZ1zM5IQggM8WbmWv6IGAvhwcydz0A+4Eyd7yujScUAgF45v1lEhBpqhKP9g58xwqNXKdR+mbh
	+OtOnrLaRASUIclYKEohSWUc5HT8iCyZpvdyhoE9/8gTZZ255wOv0920EHVyTVdpEZ65i+NOQUb
	EBbLopA0AF73ZEERyL0aMj0C0tJcq2mYEEL8OGnKBJnevrN8ez+EH4n9ze9iPKl15tgcojJi46G
	5Uxx4uZgmOUN2OG+jd/AS6NnXN2mwIOmyIAJieW3m+BlOVdNpFnebDXlE/Evm8tgUK/QqBL/xQF
	ao+UMf1qKrAx317fbVvR/QKT8lzrhga8PFtgJJUZipxr2XqDc15mrFrQ2HtTwpyDi6E7fQIfbhp
	5qI5VcWw8t40WHrCYxN1K6sAkKE6NcbktvctUAdvZJiEXoIqyROR8=
X-Received: by 2002:a05:6000:2dc8:b0:43d:6fce:3ef with SMTP id ffacd0b85a97d-43fe3dd2b9cmr14670992f8f.21.1776606392819;
        Sun, 19 Apr 2026 06:46:32 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm20985513f8f.13.2026.04.19.06.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:46:32 -0700 (PDT)
Message-ID: <f9ac366b-ca8d-492e-83bf-440f8557c629@gmail.com>
Date: Sun, 19 Apr 2026 16:46:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 09/11] wifi: rtw89: Add rtw8922a_dle_mem_usb{2,3}
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
	TAGGED_FROM(0.00)[bounces-34985-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: A9119424397
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add rtw8922a_dle_mem_usb2 and rtw8922a_dle_mem_usb3 and their various
quotas and sizes in struct rtw89_mac_size_set.

"dle" could be "Data Link Engine" or "Double Link Engine". These are
some parameters needed for RTL8922AU.

Also rename wde_size4_v1 to wde_size3_v1 because the name seemed
incorrect.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 35 +++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.h      | 22 +++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 47 ++++++++++++++++++-
 3 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9058312322e0..6f76ae2a99ce 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1725,12 +1725,18 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8852A USB */
 	.wde_size1 = {RTW89_WDE_PG_64, 768, 0,},
 	/* DLFW */
+	.wde_size3_v1 = {RTW89_WDE_PG_64, 0, 3328, 0,},
 	.wde_size4 = {RTW89_WDE_PG_64, 0, 4096,},
-	.wde_size4_v1 = {RTW89_WDE_PG_64, 0, 3328, 0,},
+	/* 8922A USB3.0 */
+	.wde_size4_v1 = {RTW89_WDE_PG_64, 892, 4, 0,},
+	.wde_size5_v1 = {RTW89_WDE_PG_64, 864, 32, 0,},
 	/* PCIE 64 */
 	.wde_size6 = {RTW89_WDE_PG_64, 512, 0,},
 	/* 8852B PCIE SCC */
 	.wde_size7 = {RTW89_WDE_PG_64, 510, 2,},
+	/* 8922A USB2.0 */
+	.wde_size7_v1 = {RTW89_WDE_PG_64, 508, 4,},
+	.wde_size8_v1 = {RTW89_WDE_PG_64, 634, 6,},
 	/* DLFW */
 	.wde_size9 = {RTW89_WDE_PG_64, 0, 1024,},
 	.wde_size16_v1 = {RTW89_WDE_PG_64, 639, 1, 0,},
@@ -1754,8 +1760,13 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size3_v1 = {RTW89_PLE_PG_128, 2928, 0, 212992,},
 	/* DLFW */
 	.ple_size4 = {RTW89_PLE_PG_128, 64, 1472,},
+	/* 8922A USB3.0 */
+	.ple_size4_v1 = {RTW89_PLE_PG_256, 1963, 109, 57344,},
 	/* PCIE 64 */
 	.ple_size6 = {RTW89_PLE_PG_128, 496, 16,},
+	/* 8922A USB2.0 */
+	.ple_size6_v1 = {RTW89_PLE_PG_256, 2059, 109, 32768,},
+	.ple_size7_v1 = {RTW89_PLE_PG_256, 2027, 109, 40960,},
 	/* DLFW */
 	.ple_size8 = {RTW89_PLE_PG_128, 64, 960,},
 	.ple_size9 = {RTW89_PLE_PG_128, 2288, 16,},
@@ -1781,10 +1792,16 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt3 = {0, 0, 0, 0,},
 	/* DLFW */
 	.wde_qt4 = {0, 0, 0, 0,},
+	/* 8922A USB3.0 */
+	.wde_qt4_v1 = {876, 6, 0, 10,},
+	.wde_qt5_v1 = {838, 6, 0, 20,},
 	/* PCIE 64 */
 	.wde_qt6 = {448, 48, 0, 16,},
 	/* 8852B PCIE SCC */
 	.wde_qt7 = {446, 48, 0, 16,},
+	/* 8922A USB2.0 */
+	.wde_qt7_v1 = {492, 6, 0, 10,},
+	.wde_qt8_v1 = {608, 6, 0, 20,},
 	/* 8852C USB3.0 */
 	.wde_qt16 = {344, 2, 0, 8,},
 	/* 8852C DLFW */
@@ -1804,9 +1821,22 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* PCIE SCC */
 	.ple_qt5 = {264, 0, 32, 20, 64, 13, 1101, 0, 64, 128, 120,},
 	.ple_qt5_v2 = {0, 0, 32, 256, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,},
+	/* 8922A USB3.0 */
+	.ple_qt6_v1 = {1806, 0, 16, 24, 7, 14, 57, 0, 12, 9, 1, 4, 0,},
+	.ple_qt7_v1 = {1806, 0, 16, 24, 20, 27, 70, 0, 25, 9, 1, 17, 0,},
+	.ple_qt8_v1 = {1638, 0, 16, 24, 7, 14, 99, 99, 24, 9, 1, 4, 0,},
+	/* PCIE SCC */
 	.ple_qt9 = {0, 0, 32, 256, 0, 0, 0, 0, 0, 0, 1, 0, 0,},
+	/* 8922A USB3.0 */
+	.ple_qt9_v1 = {1638, 0, 16, 24, 35, 42, 127, 127, 52, 9, 1, 32, 0,},
+	/* 8922A USB2.0 */
+	.ple_qt12_v1 = {463, 0, 16, 24, 7, 14, 57, 0, 12, 9, 1, 4, 0,},
 	/* DLFW */
 	.ple_qt13 = {0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0,},
+	/* 8922A USB2.0 */
+	.ple_qt13_v1 = {463, 0, 16, 24, 1459, 1466, 1509, 0, 1464, 9, 1, 1456, 0,},
+	.ple_qt14_v1 = {939, 0, 16, 24, 7, 14, 57, 57, 24, 9, 1, 4, 0,},
+	.ple_qt15_v1 = {939, 0, 16, 24, 882, 889, 932, 932, 899, 9, 1, 879, 0,},
 	/* PCIE 64 */
 	.ple_qt18 = {147, 0, 16, 20, 17, 13, 89, 0, 32, 14, 8, 0,},
 	/* 8852A USB SCC */
@@ -1850,8 +1880,11 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt_51b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
 	.ple_rsvd_qt0 = {2, 107, 107, 6, 6, 6, 6, 0, 0, 0,},
 	.ple_rsvd_qt1 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+	.ple_rsvd_qt2 = {1, 56, 28, 6, 6, 6, 6, 0, 0, 0,},
 	.ple_rsvd_qt9 = {1, 44, 44, 6, 6, 6, 6, 69, 0, 0,},
 	.rsvd0_size0 = {212992, 0,},
+	.rsvd0_size3 = {57344, 0,},
+	.rsvd0_size5 = {32768, 0,},
 	.rsvd0_size6 = {40960, 0,},
 	.rsvd1_size0 = {587776, 2048,},
 	.rsvd1_size2 = {391168, 2048,},
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 3aad234b2a0f..75691a9549a7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -932,10 +932,14 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size0;
 	const struct rtw89_dle_size wde_size1;
 	const struct rtw89_dle_size wde_size0_v1;
+	const struct rtw89_dle_size wde_size3_v1;
 	const struct rtw89_dle_size wde_size4;
 	const struct rtw89_dle_size wde_size4_v1;
+	const struct rtw89_dle_size wde_size5_v1;
 	const struct rtw89_dle_size wde_size6;
 	const struct rtw89_dle_size wde_size7;
+	const struct rtw89_dle_size wde_size7_v1;
+	const struct rtw89_dle_size wde_size8_v1;
 	const struct rtw89_dle_size wde_size9;
 	const struct rtw89_dle_size wde_size16_v1;
 	const struct rtw89_dle_size wde_size17;
@@ -949,8 +953,11 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size1;
 	const struct rtw89_dle_size ple_size0_v1;
 	const struct rtw89_dle_size ple_size3_v1;
+	const struct rtw89_dle_size ple_size4_v1;
 	const struct rtw89_dle_size ple_size4;
 	const struct rtw89_dle_size ple_size6;
+	const struct rtw89_dle_size ple_size6_v1;
+	const struct rtw89_dle_size ple_size7_v1;
 	const struct rtw89_dle_size ple_size8;
 	const struct rtw89_dle_size ple_size9;
 	const struct rtw89_dle_size ple_size17;
@@ -966,8 +973,12 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt0_v1;
 	const struct rtw89_wde_quota wde_qt3;
 	const struct rtw89_wde_quota wde_qt4;
+	const struct rtw89_wde_quota wde_qt4_v1;
+	const struct rtw89_wde_quota wde_qt5_v1;
 	const struct rtw89_wde_quota wde_qt6;
 	const struct rtw89_wde_quota wde_qt7;
+	const struct rtw89_wde_quota wde_qt7_v1;
+	const struct rtw89_wde_quota wde_qt8_v1;
 	const struct rtw89_wde_quota wde_qt16;
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
@@ -980,8 +991,16 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt4;
 	const struct rtw89_ple_quota ple_qt5;
 	const struct rtw89_ple_quota ple_qt5_v2;
+	const struct rtw89_ple_quota ple_qt6_v1;
+	const struct rtw89_ple_quota ple_qt7_v1;
+	const struct rtw89_ple_quota ple_qt8_v1;
 	const struct rtw89_ple_quota ple_qt9;
+	const struct rtw89_ple_quota ple_qt9_v1;
+	const struct rtw89_ple_quota ple_qt12_v1;
 	const struct rtw89_ple_quota ple_qt13;
+	const struct rtw89_ple_quota ple_qt13_v1;
+	const struct rtw89_ple_quota ple_qt14_v1;
+	const struct rtw89_ple_quota ple_qt15_v1;
 	const struct rtw89_ple_quota ple_qt18;
 	const struct rtw89_ple_quota ple_qt25;
 	const struct rtw89_ple_quota ple_qt26;
@@ -1009,8 +1028,11 @@ struct rtw89_mac_size_set {
 	const struct rtw89_rsvd_quota ple_rsvd_qt0;
 	const struct rtw89_rsvd_quota ple_rsvd_qt1;
 	const struct rtw89_rsvd_quota ple_rsvd_qt1_v1;
+	const struct rtw89_rsvd_quota ple_rsvd_qt2;
 	const struct rtw89_rsvd_quota ple_rsvd_qt9;
 	const struct rtw89_dle_rsvd_size rsvd0_size0;
+	const struct rtw89_dle_rsvd_size rsvd0_size3;
+	const struct rtw89_dle_rsvd_size rsvd0_size5;
 	const struct rtw89_dle_rsvd_size rsvd0_size6;
 	const struct rtw89_dle_rsvd_size rsvd1_size0;
 	const struct rtw89_dle_rsvd_size rsvd1_size2;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 380049ef15b5..3f94a5e80afe 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -188,7 +188,47 @@ static const struct rtw89_dle_mem rtw8922a_dle_mem_pcie[] = {
 			   &rtw89_mac_size.wde_qt0_v1, &rtw89_mac_size.ple_qt0,
 			   &rtw89_mac_size.ple_qt1, &rtw89_mac_size.ple_rsvd_qt0,
 			   &rtw89_mac_size.rsvd0_size0, &rtw89_mac_size.rsvd1_size0},
-	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size4_v1,
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size3_v1,
+			    &rtw89_mac_size.ple_size3_v1, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt9,
+			    &rtw89_mac_size.ple_qt9, &rtw89_mac_size.ple_rsvd_qt1,
+			    &rtw89_mac_size.rsvd0_size0, &rtw89_mac_size.rsvd1_size0},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
+static const struct rtw89_dle_mem rtw8922a_dle_mem_usb2[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size7_v1,
+			   &rtw89_mac_size.ple_size6_v1, &rtw89_mac_size.wde_qt7_v1,
+			   &rtw89_mac_size.wde_qt7_v1, &rtw89_mac_size.ple_qt12_v1,
+			   &rtw89_mac_size.ple_qt13_v1, &rtw89_mac_size.ple_rsvd_qt2,
+			   &rtw89_mac_size.rsvd0_size5, &rtw89_mac_size.rsvd1_size0},
+	[RTW89_QTA_DBCC] = {RTW89_QTA_DBCC, &rtw89_mac_size.wde_size8_v1,
+			   &rtw89_mac_size.ple_size7_v1, &rtw89_mac_size.wde_qt8_v1,
+			   &rtw89_mac_size.wde_qt8_v1, &rtw89_mac_size.ple_qt14_v1,
+			   &rtw89_mac_size.ple_qt15_v1, &rtw89_mac_size.ple_rsvd_qt2,
+			   &rtw89_mac_size.rsvd0_size6, &rtw89_mac_size.rsvd1_size0},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size3_v1,
+			    &rtw89_mac_size.ple_size3_v1, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt9,
+			    &rtw89_mac_size.ple_qt9, &rtw89_mac_size.ple_rsvd_qt1,
+			    &rtw89_mac_size.rsvd0_size0, &rtw89_mac_size.rsvd1_size0},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
+static const struct rtw89_dle_mem rtw8922a_dle_mem_usb3[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size4_v1,
+			   &rtw89_mac_size.ple_size4_v1, &rtw89_mac_size.wde_qt4_v1,
+			   &rtw89_mac_size.wde_qt4_v1, &rtw89_mac_size.ple_qt6_v1,
+			   &rtw89_mac_size.ple_qt7_v1, &rtw89_mac_size.ple_rsvd_qt2,
+			   &rtw89_mac_size.rsvd0_size3, &rtw89_mac_size.rsvd1_size0},
+	[RTW89_QTA_DBCC] = {RTW89_QTA_DBCC, &rtw89_mac_size.wde_size5_v1,
+			   &rtw89_mac_size.ple_size4_v1, &rtw89_mac_size.wde_qt5_v1,
+			   &rtw89_mac_size.wde_qt5_v1, &rtw89_mac_size.ple_qt8_v1,
+			   &rtw89_mac_size.ple_qt9_v1, &rtw89_mac_size.ple_rsvd_qt2,
+			   &rtw89_mac_size.rsvd0_size3, &rtw89_mac_size.rsvd1_size0},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size3_v1,
 			    &rtw89_mac_size.ple_size3_v1, &rtw89_mac_size.wde_qt4,
 			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt9,
 			    &rtw89_mac_size.ple_qt9, &rtw89_mac_size.ple_rsvd_qt1,
@@ -3093,7 +3133,10 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 				   rtw8922a_hfc_param_ini_usb2,
 				   rtw8922a_hfc_param_ini_usb3,
 				   NULL},
-	.dle_mem		= {rtw8922a_dle_mem_pcie, NULL, NULL, NULL},
+	.dle_mem		= {rtw8922a_dle_mem_pcie,
+				   rtw8922a_dle_mem_usb2,
+				   rtw8922a_dle_mem_usb3,
+				   NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
-- 
2.53.0


