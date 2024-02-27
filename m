Return-Path: <linux-wireless+bounces-4122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE586A408
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 00:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E536B27094
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 23:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7893A5788C;
	Tue, 27 Feb 2024 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="htB100WX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D45786B;
	Tue, 27 Feb 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078153; cv=none; b=fo5pEmENd6bVuAtESIwS0R3Q6APA+HfER5MEG6BiJCeTUg+4ihJPwYw99Nh/Or5stK0+fuI0if1v59w6YX3q45jO2nQYkcfnr5tntM6h6IiOV/fhFzd17Kmr/hjZ76D2s01V/mWxsoLEX0G+VsE9kzzCAmQOWIG+0qFoArMOFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078153; c=relaxed/simple;
	bh=crlhiY6qgkK15nd+3o63nXhD6gdOLtEZFlTS+eK41+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQxO0igci9t/DBKctkwJtsKJrMsuFXUJ1iDb29Dkd/ra8VHBr2ewKJWXlvVy6SY81JaIfsT1fapX8wbXkY4XlA8sG69GwE7GVZb50rIdm1uDZiwARng40N/x2Vyry1tLR9v1U2Au9sGubfzRfG1/7rXV6Ja9ZTZ99qgN4fQSzHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=htB100WX; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709078139; x=1709682939; i=fiona.klute@gmx.de;
	bh=crlhiY6qgkK15nd+3o63nXhD6gdOLtEZFlTS+eK41+A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=htB100WXSvLGQTFgO8OUOaDTY1i8Vc+d1TqHwCFHJPDA81yRadnvhdROqfaK+6Nk
	 7P8o2VWv5+v74YGQkWDvOne94TJ7dzkIjmiGMtC7k2z20OOORvngoemlW1X1vPkac
	 I5KE9BuEQKXG39nJE+e+qS3rczEuTOow9p/Ufzsdz1HDea6VBI6bV09ZaWFMpj3pL
	 QPtePvjZIx8W3egYMyvVnOOcAzHFfFsbIhPttNCdXOEMSUYYQFg451E+LMcb3GghC
	 meoIxhJGBm1wmUOqBUrXvsS2Hq6EHh5V6r6zdqsTY5AXYKt79Q/1iES96YTi8TuQs
	 oJWyNqf07FjK5dux0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.29.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1r6Ki21lqr-00Zj3W; Wed, 28
 Feb 2024 00:55:39 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com
Cc: Fiona Klute <fiona.klute@gmx.de>,
	kvalo@kernel.org,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	pavel@ucw.cz,
	megi@xff.cz
Subject: [PATCH v2 6/9] wifi: rtw88: Add rtw8703b_tables.h
Date: Wed, 28 Feb 2024 00:55:00 +0100
Message-ID: <20240227235507.781615-7-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227235507.781615-1-fiona.klute@gmx.de>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JoF/US/fNMVLtrL0IfA1U7sZsrSEXTOdbI4iSw8J6AT/PztmHgI
 3gyFg29Rm/LiR6/uvnTbkQ6yTFSzpdS992RThZM4cTMUM7ufoGvw5W9JI/ssG2j6j/DDZqa
 X1p74yrWjYLFyj3SuEOkuv7BPSLeGWSZ6s6VG4a3ZNvz97uUf05/aR77WSsdXnwFmhYMWAF
 W4YsRFT0ApmX3w+oiBo5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D7mx7wjkoxY=;nZonzY8HqknmP3DO/zUNSHr40p7
 qSjbvNrGC7c8oSRPMbIPwDmncXXUWODNKY0qBkUdLj08kk98FUPQSjCLWojSwCt0NOyzbegxQ
 3MwfeXBEfl6k0P4M85ft48xcR4VMkHp2+CF8P+0+hzBvCxb00+dSlSJwFayp/2iSS2sViTKWW
 WfgRXJLSLnT6iIidwg/gyWTf3dSaHybyB2Y+EdUa3l25wkDN0+GYyg776or6O/mlyyRBMVM2N
 bzFVrepBb17SDWbvWUzupkeBg3OkpgcdnWB4PvXDJkRUvBUvod5qXkok0drr3EyDrnxnjV0mv
 XsH4po/tBPci6DO1CWndf7l+/Zz1Wu3nJGtso54YHuuZwVhwcsElJDWdQHFWEyLaifIiIfMQD
 6eVGYkMVqZRUVAPBMdiZlit5URg77WS7HRM6XaO6OjvjTtITWND4yuxxpeVwZf+YqtDVG+QWr
 CXGbccENinFphukulKoeYPD7MV11iR7bfGz9ITENqLTN49FApIsrMNDdNROpyxmtfz2jfCPwH
 Z5fCIArrCfraWLZNn2LEZAK6/IGOp27lgl+HPYWwovvrwYSuIQn16PaFnycRpJc20gZ1E8Uhp
 r2qiDbdyyR5qhqwTX0jKtFosWmcuC8l64jq0FzQTRV1jvusi1YeJWWAUfp+1RrW3u6QbJbdkx
 AL22S5KSCdYCAf1UrJWlNT6Ma36HIeZdrL/7CzHbzZe2DktjHZmLtYaCcx6orfKYOYOXHuCi1
 5lrh0ctFwMwnIPFTSZpUPRIT52LgPHJ/6NxmMfh92vN/fWmay3AnmKPWFBTSDotbiH9QimwKU
 jMo6UupUJIoaXYSe84FSuZg6i9PZ/s3d1hymSMEt3w8bI=

Initialization table definitions for rtw8703b.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 .../net/wireless/realtek/rtw88/rtw8703b_tables.h   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h b/driver=
s/net/wireless/realtek/rtw88/rtw8703b_tables.h
new file mode 100644
index 00000000000..98bd399bddb
=2D-- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright Fiona Klute <fiona.klute@gmx.de> */
+
+#ifndef __RTW8703B_TABLES_H__
+#define __RTW8703B_TABLES_H__
+
+extern const struct rtw_table rtw8703b_bb_pg_tbl;
+extern const struct rtw_table rtw8703b_txpwr_lmt_tbl;
+extern const struct rtw_table rtw8703b_mac_tbl;
+extern const struct rtw_table rtw8703b_agc_tbl;
+extern const struct rtw_table rtw8703b_bb_tbl;
+extern const struct rtw_table rtw8703b_rf_a_tbl;
+
+#endif
=2D-
2.43.0


