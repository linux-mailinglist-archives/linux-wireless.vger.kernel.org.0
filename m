Return-Path: <linux-wireless+bounces-17836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2BA1954A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 16:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8163AB33C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBD2154BEA;
	Wed, 22 Jan 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="HHrQY355"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A2145A05;
	Wed, 22 Jan 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559938; cv=none; b=CgdhtLmaZe9kAbSUQltZ1vAem8t9dZ4hPESglJltGk0Y7pQtkOxW5+KkKDozmlbhCyYf9Ad333Ww8y9hBprQaTvyF5Sv1/CncgP0I9ZRwuE1H3GN1L9sHlfCR//OKDYpX8n9iUI7jv5PUpvOoRo4hP62k9GWwltUNSPJYsJ5W3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559938; c=relaxed/simple;
	bh=q0a3l9gh7VC/EWa7lHogQ9g2tq2aKNh2yUHtyBCDl6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYda4VYoPr+1i7BwKjjRZmQqyFokoCAzrVK7NR8pURMDHs+zewHICeQJXpwNeMMFoySkn/KK1PtyJXM+PqMaYatZ8yHOfi8M4v+FufhGbAa0zZep+zBNCAUxBJb2LbW6rFx3Z8OTiqLvH+QnsQu9OqO3AOSc4SYB1TQ30CHJEns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=HHrQY355; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737559928; x=1738164728; i=smoch@web.de;
	bh=X9TYPR973hk90vLO2mVUd6/4DMQfAZU0DhZ2uCn0EQA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HHrQY355hFK4p7I2W/uNwpHWyjN5LRDOXfcdl0pbkMhBI9fJD0Hb4IXYETd9cMW3
	 krGeuTH9YXfdZM7P4Wsz0ElsF3Jso1lqSCo0JWwLuFnW4+bYIg77any4BGUktdUY2
	 sflL1LfCUQonlXKB/yr7xCCSGTRxUBOITCAdcLAF8gdJHUrS3xJuV5l7Jx90bvHnI
	 /Tfmg1OnR9J0LoFiPu3q5ZRndYdoeog9swmSMQb8UohC+TT4hG5Q5D0uBN40mb3Ck
	 KgDYtcEzIzToP69oMr82vlM0v1Kz2K8VETLjBjaKK/rMT3Fs/CTdlIoPYNxiS9DAa
	 dgW9P6035kmWZfLoiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from x1.fritz.box ([78.54.50.138]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi537-1swuAj0FYP-00ZWu1; Wed, 22
 Jan 2025 16:32:08 +0100
From: Soeren Moch <smoch@web.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Soeren Moch <smoch@web.de>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtl8xxxu: retry firmware download on error
Date: Wed, 22 Jan 2025 16:31:56 +0100
Message-ID: <20250122153156.373470-1-smoch@web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9PT9Fs3yLQu3jn3NBC9Ln1uSPbrFcy0dxRJo9m7RIdLoHyP6/q0
 z2i8Ci3jCNkSNZ09uS7bStcKZBvkJq30KmceJQJ52Lj8sumseqVth0HU6YLxjEGtqowoIf5
 1GMTp8RdCifZROXh+9D6Ln1VHFLNebeYFKHZWykhy23n2eQ8qBDEegoXZNVC7Frb+0cS8nK
 QFCAIDC+ULPNhm8Di3WOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HKdu0KD+BkE=;09tqEw7YLAsBqT9oXdcqcMRrUrt
 6gr3pOMhcdGd6HgQ0agOnmjIr+xsWo00FiZdeV0A8Pq7ZxQYpyu4QXw1FgbIMn5JSFRgW5O5V
 rZ8JaK3PK0TlxQ58+/lOiXak2TAfOFTp1KY2VdKvrhLeiEDiLOILRPlCxEi4DOB3D4OE0Nkbv
 T1tfGHQOL4eLEytlcoB5ieqiurhqyfG7IWnrcuVaNRWvUlQkzVqo6WTEI1CIitGpJQDFRpKRo
 437xMaS2dPj9KhHaiAHIufFmkRGgVRJsrsF58fR6fwFnJAbrDDatDZLS2ifmDJpmF6n7lEPA+
 rSfzl6AULDnFvO2IKTWAWfYtXrvySPlYEl4lY3iobXOQT1WLxtOCXi5WxBWVN00n/Xt2Z3yCg
 KVHJSeG1C27XaCN6uPhuTU8IHgHYrhQfxRCUGgP/xweGaXvmP2QVyzk6FD6KITjs13PiDIBKD
 nWyh1bQZ+xOtIheLoGg0EnIwC2awTPHUjOaO5qoM7+BisvoeWAvsc9jjO8xu6Fco+vxqIuKbP
 lQA1T47e1zl1Qi1NJBmsEnWVyAVDyu9geV6nrr7EBu2Phyxi0kjNJP1OjmqQFhUPMUAAUPZc4
 QnUwLq8D78baugp7626qCwFQjdZYVQ9ZTW8TAx47ZC0vTP81aGVHyv8AVM4tdYBTjNLXX95LB
 OmwjAwaZGHlMZLKOVYUuN31k7TGwGIW4R4LVQc6kUMaxyDrNbIi6O1fZLiT28jpADzl8bhuv4
 tcg8yn3Ty2frMVAxnZZNI+dq8O+mWaP7uhA1R+nvjLbYxL+j9Tufsypb0lML4zNrtREYVAqJM
 1YxZpIDzpt2JrK1dVrmnnge5V0OWRUWTdlkLmJokGVgi4rTVsCYTYkhgxkH71Ryx1Bnh5MXFR
 C/KaQZ9tlC53wehY/uwUOXB+8bHz9NKRCLgyyfjzFB3OB62j3yiXKwox14PC22fEwDmkNt0zi
 3P7H2ottN0WBoW+CD51+LoOXohLRElSibPrmb/aOdYpf92cvjBP2PwJocp5xchQcJdQGP1m6/
 yWBA358jxhHw51vXaaNfJq7Qm7Q5DHTQZUfVDY4BAoalAzU2n1UIHeaVdxDzQHbjstOouPrh/
 zTPhvNWu8+bhHJu4NBaS0TApqnsLaD2y+NkS4cRTBWbDnyLNsh5AncHlvGAFosbGb5tRrBezm
 Oa8AeOKTOZQbkYvB1XzIWo42SQ1QYOqO/SwKZOjcGPUzQe+wEX9f77yZh5a6bGDMwIVQcAw8k
 kKDrNLtHI0ckJM82eKCBQX+3dAGv8umiI7gAuTy+5zV0BQxczwEN7LBTPPz++OOHgHtE/ER7c
 MxN65KsTbXC6/g6TvI4m3FhGeD0TTloOSMbAewZPQEO7D8=

Occasionally there is an EPROTO error during firmware download.
This error is converted to EAGAIN in the download function.
But nobody tries again and so device probe fails.

Implement download retry to fix this.

Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This error was observed (and fix tested) on a tbs2910 board [1]
with an embedded RTL8188EU (0bda:8179) device behind a USB hub.

[1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
=2D--
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wi=
reless/realtek/rtl8xxxu/core.c
index 7891c988dd5f..cd7d904eae62 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -4064,8 +4064,14 @@ static int rtl8xxxu_init_device(struct ieee80211_hw=
 *hw)
 	 */
 	rtl8xxxu_write16(priv, REG_TRXFF_BNDY + 2, fops->trxff_boundary);

-	ret =3D rtl8xxxu_download_firmware(priv);
-	dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+	for (int retry =3D 5; retry ; retry--) {
+		ret =3D rtl8xxxu_download_firmware(priv);
+		dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+		if (ret !=3D -EAGAIN)
+			break;
+		if (retry)
+			dev_info(dev, "retry firmware download\n");
+	}
 	if (ret)
 		goto exit;
 	ret =3D rtl8xxxu_start_firmware(priv);
=2D-
2.43.0


