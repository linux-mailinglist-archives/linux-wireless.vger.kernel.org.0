Return-Path: <linux-wireless+bounces-4123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA65C86A407
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 00:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA7E1F23383
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 23:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640BF5810C;
	Tue, 27 Feb 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="CT38dLXi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7958D5788E;
	Tue, 27 Feb 2024 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078155; cv=none; b=bK2FyREFzYzXlJzT7dFplrHzKIsAfuGp77X0hKDhrf4zTWEeMRHzcdFMQKqA+M1SMCoiPv9ORsQfh2IKOrv1/hoZa4oT+hYo2hZUvraXlRtSuosJBbaWgjgYlpzld9eIXXx4ebufUhWukD7U0/l4QmPBmUITjloaYpIc2CasxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078155; c=relaxed/simple;
	bh=KwZr///IvqX1ALEKr4OOy/LNKMTrPfYHY9pB5hMd8FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFu3IYkdBPwqK1xubsHIWsnHw4MRr6uV28NXDWzz2sDYEVKEgwM95QCwh2vXtO9yzFCb3la6G1RaNjqeqZs6kMYeaHJKkOJeu3dWK/0hRCm2ipbWd6TGGdDP17OIRTBGpQtOrWp0at8GpYdNUFYa/suNkfzUQtuPLrsd93HnVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=CT38dLXi; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709078142; x=1709682942; i=fiona.klute@gmx.de;
	bh=KwZr///IvqX1ALEKr4OOy/LNKMTrPfYHY9pB5hMd8FY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=CT38dLXirfbDdnCIcHYAAwiLe9yIoLYlgXaQolRMRVs8A+slg6t3ZlidJV+aidAH
	 UoSZ5Dff+IjSbPFH8jpumisx2G5ywbuRsGaaRosvDaNTpl4YY+dCkVmWIhhFzy4yU
	 BJKwcBlXGJk25Uxy4V5s0dcBkNFieLlQfn78eMkxJbu0Zwt3LjZ8UA1bYGntHGwJs
	 Ywrhx2SPg+cdENmbXrAZlbMMpbfXL2Kyff6u7Dxfd5z8VgO/BzsIbNUXEgXxd8E6u
	 AJk3LroIWsoXNPJF8eKPDElxkkwjZH+voSqTR/wQeLoqExTBQ+bxTWc3idtJY0LGr
	 lyB5owArfbveWfYHmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.29.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1rJsRt1eud-00LlAu; Wed, 28
 Feb 2024 00:55:42 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com
Cc: Fiona Klute <fiona.klute@gmx.de>,
	kvalo@kernel.org,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	pavel@ucw.cz,
	megi@xff.cz
Subject: [PATCH v2 8/9] wifi: rtw88: Reset 8703b firmware before download
Date: Wed, 28 Feb 2024 00:55:02 +0100
Message-ID: <20240227235507.781615-9-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:Z5eyZrHvba8PxLJN5Hr3vcNeeUJqFIvIWaze9xab8LkcE+BDGsA
 5RlozFR08fi4GEzAxYiqE+20eJITitADr7VAbyMOCLdDMR8Ch4vRKEbxJhlBlParOoO+mpt
 opsIsa+YNTWR+PTDuYNxTLnk+EI5+DJjJNH04Ay+CDNFkOzZY1BEEG3r/43thP3fHwaebB8
 5raqaGki2GcIzLUDLR9zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rIvpk7JLOG4=;qM6BzlFHdR9J9tMp7xHbQq6/8OU
 Y1gp+2UMfa8IgJWDTdIX7DImCtcuYO5FxkVYWKVsa7/vTOViBxwmhcUY2YNMECn178mNMyO3K
 aJo1XzCb49P+5Frun49XZjCbSOzz6WA5Me2iZu7dAh5l1Ttz//ht/9942Ug11JKqAdb8BX6cL
 r0KjayHa4W805Ty9m22t6P6bBAQgKvasEuUzb48UNeDzbv1iHG/mWZo4aT/rhNzi61rs7z+FD
 MKqrd2GSuvF0nHtLnbnB0lUzoohBTE2qJtxxxMavWpM4dDA+nD8gggELnvai0O4rm87+VyWof
 LdYaB+6kANsk6MEq9C8Lw4Cc1MqcTdVoXhiJ3wHOLGD7sk9eU5aSDTZHqrFf8CqN41q7VTvj+
 MUehCDv7nmO3tQqFL1SmTg/Xn8IuGxtcwjMlGxUT+6fdwTkA1fGk2AUC7PRwEoh7HYt5XZz4t
 Y/f73lIYglxPOnMWJdk7k8JeSsQ1Xl+Bc0NSqSh9q92Xu2k/eFnZP54/Z8NmoR6qI4k6Ntx0D
 fQVoWnpeJswycFNFRM/6EI+OFm1XbNwLrsCpLEtQ1SnSgZqISZ4GL6i+K6Yz1vNhUabwNOhvM
 stHMKk/2CUxUQrrvs4r1uLcEFEMgB0vXBUUkiU2SXaY6MjJPVWJb8wdVG5veBzE1iVHBfjK84
 0+gHB6i8/yr/JCtLZ0btnjTXsVfdVpooxuV9UcyztGyI0cgLYKl7a3XB1uVRZRbiJfq1crkUe
 10TAgjMoMyDaSo00NmPhrrAbvZ0guV/3Rgyd1hORmgOq5kjvBpDaU462CZx2RR3g2wg6Yf4YN
 TFJeIIR/aUVd+T3x/WLXA6uz+XUMVU2/bYUytVnRy8gTU=

Sometimes 8703b firmware is still active from previous use when the
driver needs to download the firmware during MAC activation. Reset it
in that case.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wirele=
ss/realtek/rtw88/mac.c
index 298663b0358..5fa38b1068e 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -936,6 +936,12 @@ static int __rtw_download_firmware_legacy(struct rtw_=
dev *rtwdev,
 {
 	int ret =3D 0;

+	/* reset firmware if still present */
+	if (rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8703B &&
+	    rtw_read8_mask(rtwdev, REG_MCUFW_CTRL, BIT_RAM_DL_SEL)) {
+		rtw_write8(rtwdev, REG_MCUFW_CTRL, 0x00);
+	}
+
 	en_download_firmware_legacy(rtwdev, true);
 	ret =3D download_firmware_legacy(rtwdev, fw->firmware->data, fw->firmwar=
e->size);
 	en_download_firmware_legacy(rtwdev, false);
=2D-
2.43.0


