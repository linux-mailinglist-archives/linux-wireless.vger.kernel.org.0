Return-Path: <linux-wireless+bounces-4512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE18B8770D5
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 12:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB001F216D3
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019C45C8B;
	Sat,  9 Mar 2024 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="ABCL24Am"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093D22612;
	Sat,  9 Mar 2024 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709985468; cv=none; b=cKqD+ePcKvdMycr7ahRSjZKHleMJRezarFKk8LGT503zuuvlW4fxXK1Qa/Ed/1qna/u7S+QZyo4rg7j9qH2UJBiD2LFfgStj3P1jNCSZHKu0uw8FqSXEqY0gwl6CYnp/jbciAVi0SYW6RqqepVlp18B9fXo7fjqtd0rex83HWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709985468; c=relaxed/simple;
	bh=crlhiY6qgkK15nd+3o63nXhD6gdOLtEZFlTS+eK41+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0gUGzp4O6ovKD9kvWM83hMsFJp6bxsFKi/7RuhU8PTvqfXe27/mxrzTzYrpaHhERfQmj4TOWrGRvlbFrRhY5QbQ2sreNom1DDbxhyJnplltN9OejUc4OqnXtcOEfQGoNOusERn/y4MVHliCri+C53LfkamDY+yq6AlCcOLxQ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=ABCL24Am; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709985456; x=1710590256; i=fiona.klute@gmx.de;
	bh=crlhiY6qgkK15nd+3o63nXhD6gdOLtEZFlTS+eK41+A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=ABCL24AmWaQdkIeURZTP6dFhh8nfs/Y4AZDX7d25dI8fAt2yAFeLqKiphCLjjcJm
	 Hn6FJcAY08Is/ZVCBT7gZFbBjGpltNfd9HkSEybiA33VUrNDQ0yYFtR2VlFD153jZ
	 sXLZESqz8gZuED5tsKefpjxBIJ5bapRLGYNwnycE40Lh73gse1VxJ8UftsoIG2aTF
	 2ZZC7KdkyTjB6zOozyy4Yr925sXqG33XpzoA8WItFBnjKsxvK1yUfE8lWSQWBQ3CZ
	 lHdKTWVGx7oW4vEJSQuHBqC0Y5QraSKtkG9i9kVeCRQCMx4iMpIobhdpQLJ+mXyRb
	 uA60xD9zl/S4apiwPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.112.71]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCfD-1rNBTq3Q4f-00V65E; Sat, 09
 Mar 2024 12:57:35 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v3 6/9] wifi: rtw88: Add rtw8703b_tables.h
Date: Sat,  9 Mar 2024 12:56:42 +0100
Message-ID: <20240309115650.367204-7-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309115650.367204-1-fiona.klute@gmx.de>
References: <20240309115650.367204-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u5xvcfEmQ3UtentDbASptWuD2af7NETgGBm0PJU/3XysGl51Wa/
 YhMKqOnL+LkUYM8xgN295LAJMYnu93kSGEwHxVA8YxToZTQ157em+EcIJYAY87gN70f9nme
 j2BxklfAeef8LV0/eIl3Hj5MQAfJhUScGErEBP0ObeSRYLo6OLPuOIj3ArF6sHow4Je4AMn
 b285l0q+qj+0htxMwTyZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ffoGBTcitgc=;ItKU62VO/fFNyaRgliJBvCJ6ZF/
 admMenH4w69WnG/fX9ucNty2Bpl7wCzt5NsR3Uoql1chCS/MMHHbHzVVNsey9e+HWhAcGe5SD
 4P2K2YWCXMTR7dlGUCUkx11Iu0wwhMXAZsg7PUkNkPO9d6nqVm3vFk1i4PDi6t/ZtIjtRsfH/
 hULLqSf9EhsCM2iBh9Hqrdtnh89J5vVLUHZtXGpn+2SpS3t6KlaAK4iNZu7iZo86qppOkk+J4
 YjK4G7sNgnK37PZJgDBMHpAeBKb9Kjbil5tU3tdRDDb1W61d1lSZ0FdPs7to5BxbQ4KpOUO+R
 mmN/nGuor0v0NDiH+QwQ1CRDXLfVpKX0tp501J2YKIVh6ObRKCR/Eb6TqVsYFykvyoq1oqCFH
 yEPBoBZU9KgKUtAApSRPNqPCacJ8sKXOqPpVDDF7D1ya9PZ+rmp3JIWVS34OUjYLPyXj1uKFV
 AsmErN971l1iJME7iUGqH8fk1wijOrhJw1c/QsmH8lW69exLB7kScycEDC9QA1ScPfzUHIX/e
 t943BGTXl64IGdvQwCIRkSKu+I5jzqzBxEZks8MKEl9OokW4+toxacVsHbZBZaECUmw0u0er4
 fkH8gB1ZIOQL+UedZlrf60+dDxETJ8g94Ownf2BDk/mAaGgxFG5pSvkrNk745XxnOzLeUQQgt
 hXxrJIeOWpSEMTDnL5nhzKyakTRyVi5sjZe60PIN6LYeX0DP3R5AZfBjjDUdLxUkSAAgAFhF1
 VrAZnF25sHQlo4i7/iuMklW13xyXhy50KA7ro5/fZpUDuwV/M6ZRR7VtmIqH1rxRoCP056H+p
 oHDJkESmFDA7Z3u+Nm7KoHCUG1S1rSlHFzyT+hlviLozw=

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


