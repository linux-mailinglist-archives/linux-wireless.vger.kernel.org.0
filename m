Return-Path: <linux-wireless+bounces-3021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B44846FDE
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75C51C2584F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C36140776;
	Fri,  2 Feb 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="VmryjWoQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823314077D;
	Fri,  2 Feb 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875893; cv=none; b=iVEF6hwxUY7UeXtfC37OCOD9o0F/3Srl8qjXbo3+yaKTuHO11Frf4hYA7k9ywZ066ZSQZ3UbeDmGzCho8Ii+mOpHMerG19s++gO916khPm7TWOA3ULaQWDNyhfbvp9H8qv0DDQbgYBBrVsCh+dPqiweKFkvEzvNFxHDi/GWQSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875893; c=relaxed/simple;
	bh=M1r+pMll29WK1OzImoKdATSTZQEAcHuDrCZwBNePNIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5ebQP2SaXKbqGX1uyqX1J7bbNvDcdw0/ZePCk5XuOun+321Q5OMmd5T8kaR6IuD+5i/5tNSJK6qsaw0UxjHCoiCmqxTaD2nixB8H8bCGuJrc9p7AKCcHKCOz3T3dZtQ39G5ZXWViOYD2WYk5cygOnEiUYYCe4RTvyQ54IKiEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=VmryjWoQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706875877; x=1707480677; i=fiona.klute@gmx.de;
	bh=M1r+pMll29WK1OzImoKdATSTZQEAcHuDrCZwBNePNIY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=VmryjWoQesdER44t2kIgF+YIiOQztTubpcoV8s70k4Jl8QttUezTiHj0tWajLWJf
	 /Ha+jF0HbJJeUJo3AR2pZ7Ay0WUjrLSnkFZmHMB3g0jCGEPtOgy6DeLQnJv9YQkzh
	 k9k2pIsy9GS4xJDHkPHqgbI4tqa0lPGiu7YdYQ0REgluxAbgfEB5OzngwtQHwhREI
	 Ev+VGbwrH9QqRodya520EynqSYd9GX6DO8VS6jHsBha1sb9fJbXXbJfkxoDVoD5EE
	 4ov+L8IH2ktFLadZRnrQ+85gNkkoW8ddV9nbTC1ib9/njjbyigZq6fM60MA4UPPV0
	 J6/IxUY1JWHw/scWBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.17.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1rOyde2bhn-008d7Q; Fri, 02
 Feb 2024 13:11:17 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 6/9] wifi: rtw88: Add rtw8703b_tables.h
Date: Fri,  2 Feb 2024 13:10:45 +0100
Message-ID: <20240202121050.977223-7-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202121050.977223-1-fiona.klute@gmx.de>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3gZX3B94ZHKRZKYajXqbYOH0+rjhpkSVsQzv5FILn28SX3ZOd3N
 5IOaI68dUB+zFYzYd74Ly8IqEK3k+/ibd41A9kCYMa1/HbASCfHNdVxbtEmf1MTw/gmTStG
 nY++msUjeeZQbFfIAeXbseaFFOOs3q/bK59mjv6wU6E3YBkEjwuaIXN6k1Ue77Lsol48e5B
 lj2VwuoSZKzsRzP9qjtSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WeDPmaMlhfI=;4p2hgqaW9wiMOyJrb52RhanZy0h
 4zpUja9sKl22ZeBGJmmMRMb7benow4Eztc042028kwSbz71MridxRr/kMMD0IDJI7+VdfG9mQ
 3IjzVb3BJGP4R3rtjlj1SbIhbcx1lN/7z2mCf0ehkBrjLhvizVbFn/S7DXJ67AjjkeuJpD2mb
 3Yo51Yv6pbrjK8kVI2SSSibtz3ngkQv0AST7WJZ/J39uErJ7vEIU7/8NPQpygBWfWjBUGqOFE
 VTRQg3L03eQ/LDZN4Srmr5dEd5zWjFGH0CRDPRqmoD5O5W95svoFhRNVN3EtesvsMIg6FhWqV
 TGBjAhNN4OvSwtACDWTx+0c00t+vi21Pf2fqHI2Y86o/AVZCl0GDUD6YCVEicitoG3duAkSUH
 LukV7wW2pawy3knVoG/zpULmfBmfHmXK8mtcPJt6Tl6nvmizsqDkFDZpMJFFsFNcIA7BDPBdn
 nysTdA8b596cP8GEuXtkR2OioeU0Fl6ZsdW3BXLTzH6XtmJohMU8f/L4gAzNGdv7xL672H9QR
 gWxmKtL9Ri4Lhzuc2/vddOBtJeDoCfblEd21pjycdPWMDtmfgnKBGIwoytqzyjGcwQkQqhKxt
 dMNaVdqkPxxC/9R9mzf1MVI+7FyP6ZGOl+jpslGRA9wIF3n1NZf2wfzlFTLrhhRMCrQgr1ih1
 fADneNhP08AE9IhUgB7TI/F8o03CBlCIU7zN5fGb5SH/OY+Jzi0qjiokD+RBUk09FmEYtAFc4
 65S+OJWysOKDlvGyFBfVd5n5KdpmiChcVJkhV89ZJlrv8iq93hG7N2ovLNIYCe3hTa36uXaap
 3kgYFWBLWpkJeggsk23OCGyUjowmH92KHK5ajCXu0NNfE=

Initialization table definitions for rtw8703b.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 .../net/wireless/realtek/rtw88/rtw8703b_tables.h   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h b/driver=
s/net/wireless/realtek/rtw88/rtw8703b_tables.h
new file mode 100644
index 0000000000..98bd399bdd
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


