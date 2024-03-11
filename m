Return-Path: <linux-wireless+bounces-4552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCA877E36
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 11:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5918AB20308
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 10:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A849838F9C;
	Mon, 11 Mar 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="ohivN9wC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42137152;
	Mon, 11 Mar 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153504; cv=none; b=ez/oxeBy7onYX8RkWLjysPsFt/KnmJGFo2demTnaUzxf1N68HdL5/MxbHghRPrMI4I3mrdE/hv+fu60bZsZtbet72fYXhR7q8cQ+JlCPYJZS0Er+5KTLS90gtMLDYmrK/ZlsHqVRj4zDIp4/BY10n/lJZNqnyC0GO5UUJHbK23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153504; c=relaxed/simple;
	bh=crlhiY6qgkK15nd+3o63nXhD6gdOLtEZFlTS+eK41+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmJJba4YArQeAcc94BXNQYg6dB99y6MiE1oip+TPjZnKzpMy6/kJKVHu35pZEoUvP90li8ciLxqPuU8xmr6JM1y52AE8g5JYDA3pB8HiyqrO9z7Qb218pg5ASsMC8sJyKPXuQUlAyN1eFf+hQrCuX+m+jXL18LexZWzfYOoPPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=ohivN9wC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710153491; x=1710758291; i=fiona.klute@gmx.de;
	bh=crlhiY6qgkK15nd+3o63nXhD6gdOLtEZFlTS+eK41+A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=ohivN9wCGlaAkSWkzvOtgT/0uf0IDWto9ums9UDqKGF5eGB7pjKtjWgKnROAnhIZ
	 aKgULrUaRJvl9t1NVVdKxmB6RzV/s8EyC7PrUxaIWZlveJqfvdYsZOJm7U50qPWt1
	 oQ40JB7BIchoK+8aeQh7gunPRinueFejzLHTYYdWfKpKZZRGnmcJLbOQlhMPoUHHC
	 WfzrrOHCi0MnKcVQCeNmXhZ2t1HJeILm+TlzdbDbZKmzUhxAtS+u0hB6eeq0En/O8
	 Mg05/oz1XUOHnUuvldLTrZ54vNjsgoNjR0LsIR/EcqXr4qXQd3GEysgjO4fGR7qm+
	 E6Lt02iOFbqF7wBVSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.108.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUqL-1rXGzE0tLz-00D0TP; Mon, 11
 Mar 2024 11:38:11 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v4 6/9] wifi: rtw88: Add rtw8703b_tables.h
Date: Mon, 11 Mar 2024 11:37:10 +0100
Message-ID: <20240311103735.615541-7-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311103735.615541-1-fiona.klute@gmx.de>
References: <20240311103735.615541-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ft4wmVJJYk5xr7YIdEH6pNkDxSyG6HMuFUAKZGN1pzy5OPHRgcf
 yBJK6gcSU/pebtBCl3jMeZerr+cFWzMzfWCVILYUEmYPzN+J54rb9RyJxM2H4JV+kd2636X
 /BsNeFqe3qk90fQUqs1M10mV6gHM9411371OSBCSQxPZhdDQ+Vo+qohuVXSD5kHxNkbawUB
 wWY8LlbdDOJwDlX2GGEPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yXFtqoJC25Y=;5DB0T6+ZcC2quOlc3RX1pNv2V8a
 mrkS6VkA0Bw3UyusYp6DzOh+EiO1qeBCOJ9605QeUUGznE+ats3z+CfhhU0APRh24atMrDU6T
 j0oO/JEkPKZ8f0RKZeh9M2j2eLWEcQvjZTg60+KfGijsyHDNBJgqAaYtT4++IB7jXF4Y3Wtcu
 F/nSTPvjE0hen2iNbS8AVb9NPVq4BoHdv5WNllk88g4lBMlMgWM18fyUcFYcTimXIUFWBgmmv
 PnKyPCVJvYbJ0lbI8V3k6dbyXF3owjIZzFKh9ZWqzjm8mckNm/64J9wrT9PTSMlFrLUGsUeyn
 5n5aGlaBxFdzo+JEjF00kFnAp365u3tEztLFrxUwXD8HroxZMg0XsbSXx0/tY2+TzVN0wqAfM
 cHU0P7O21PZCrQzToXvwXMKU9QsQA9wzs3yZw2Q9+2tzigAXQ0zhGFbACeMJqHSaymhExIqR7
 rS9uvh9/24mB82PCkp8s1QGz42WBLwOesmuL+23BUR5o7XQDYVMkU9dbevBgnXAxv9pF/QyPI
 2Vw1Z1sFXgRN6+7h92t4RF+XZVpzYYs5Cs874hhgZ7a2ZX/uA2csuzMsvjfa3a6ec3eQfOBRs
 U+E95bpgngtoytmvID3UqC1O8S8/dVrB7roPivqN49JZkpHflL3nbgoddo15dZ50QtEnPXx3C
 JMc4Btn+TWNVhwK+bU1yUO0BHRrU5PmACasxZrILduxWaY6+OeP4ryTlWxUjr4uCW260ULhjt
 t5f3CMUaEl6NsjA/8rZffx2zho+JLg/Aggdt8mtbTEk+v5tKVa5sSY6V6rifFFqZlBAeF4WRV
 HUncrcvdja9QqyGa8NovQK92/EKODTxslbBnytRbjGQ90=

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


