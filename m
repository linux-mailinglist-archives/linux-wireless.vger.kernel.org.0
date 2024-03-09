Return-Path: <linux-wireless+bounces-4513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8688770D7
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 12:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028C7B212FB
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 11:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE67E3B7A8;
	Sat,  9 Mar 2024 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="m0OBqLoh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F63A1CD;
	Sat,  9 Mar 2024 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709985469; cv=none; b=V1sE1VGSfZmrmt+nNbPP2C7F2VdEwUl5u93m6wii1ccJI4Vndrbli/aQx2Ku5cMnXEA44d+SKYyDT6OitGToXaefi6kW5TfbhSpxaAE3t8E/aA/QtpL11NSB94bwuumX3d00dG+OBUM9tR9v05gzfLRI9Hvp/FiE+ZE9W7EO87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709985469; c=relaxed/simple;
	bh=KwZr///IvqX1ALEKr4OOy/LNKMTrPfYHY9pB5hMd8FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsnrrQCo17lECXv+jSpNuORKRnSOOQ68PVLRLM3WTvVnrVmkvUH+k6TjHkC6oo2D5wDhybVmXCkHNHcT08ogpqWfNeBF+dDqxfOG0IY77GgGSn6pm5RQm9ONszvUKSff3iaw/Ecgc7sZyS1P6DlwBcex7zBqpxHQe3CV60wkOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=m0OBqLoh; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709985457; x=1710590257; i=fiona.klute@gmx.de;
	bh=KwZr///IvqX1ALEKr4OOy/LNKMTrPfYHY9pB5hMd8FY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=m0OBqLohlsM40d09ZxwbMhQhbqjpS7FK90qN8NZe/+fuYevE/GmTiCX6sAaiPKf+
	 NN6ZLz0VBO7LXogMkCAly8jqx6QdqmY1Z/CjwJlfw0wRsr6IjtOOKtvD7ReyBwXoJ
	 Z9rBKeD6phs9aaqa40TowZVWmMpgX8v+YKVEh8/LuVqsjsFrjJu6HKOQTQNUIf8eK
	 cNhtPW9oCmEU4gspnZun7sBAKXTjqEBYgTC7d8wb8Q3AirPm5ckDc7rSJNTxtI5It
	 uOl5aq6HwggjAh1WARm3JAN0nMeA02ZZU/PDyq1Ax2/XG5v2TIpDDJgoQ8RejqxCM
	 PWWZHudkYsJTmiMm7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.112.71]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1r6L2o03Vb-00nRyw; Sat, 09
 Mar 2024 12:57:37 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v3 8/9] wifi: rtw88: Reset 8703b firmware before download
Date: Sat,  9 Mar 2024 12:56:44 +0100
Message-ID: <20240309115650.367204-9-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:93Wh7zjC7xWE+cYTuIkuM2UtTC4hTovN9b6LKXltcwQCHKW9iNu
 e/T8kg3mRAneHl/m/sV1vcRtignez4Ec3qc/3Hxs9g0nMk67enttwpMOYgFijbk6ptFKcuj
 P1P3U1JDmr4dokDjrFs+oYRoPGA1i1bxI6kip8AZjd8l/KURBAAKxlc8QllKugg8nLKdDyA
 I4vksvRAEqm5K2ObvILHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NG+efRHEFds=;xkjLljadMslbiPLJ0M2iv6rgyMv
 WUEDgmlZGX+yzBIL3SuZXgxzd/np/w9Vq2JNs2OjWg1g9lVLUBq2ejRm/p78feAZ8X1x9rzqa
 U6pvsuCWZQIQSfZWiRnoZkBpxIP1KMf6uV0VCxVNToIDKZkI9h8NpGFE7JmGKCKNcqtwH33us
 dy9VKCDL7QCLRAIPfjdJzWcLDzCwjoiDnXB4+dXaciazBobyOwVFaE78EivKqZf9KAuJQzuq9
 K1Bn1HZF5vNvSIXGcA9IriTSaCnnAF/udzqsY9nYLedaZZ002kZi229nhUEf8dKyAuKe7S2+R
 Yp4UHHXpXxdT2o2DYapIvw7SwBLXV0+8uO3ibgNm/hpbZUGi2BpmEWC2iNQXZ7GjuVWRO/Q9I
 rk55jvbFg5r5LBoM5PmAzQ+UIrGjJNKXf5v1+R2vWn+prcs0BiCRS9zYUhzxKRrECP+Ed3RO7
 uevNn8WsGoB4tZgCbjnQv4LIQeU+AVzEDLKcPMv9XAOk5jjwwg2B7ZeT6Obvk3TqC6b0IUAgP
 yl8WFJAYhT6HGpaKkC40AAnstOYITitrh4b3daMxO9UjRR9udn6BJRAjmPF5liyAbPyKTOtaP
 ksCMM0R9JoJTzuRayd2yg8lNvYTlXfe633ALnJo7KSucvqqdq/3/hfNrofKG5fmtHAC/kZ737
 R7bmtp5+44FuAprX6nHrfcoRGzRrfVohlkHb2jxE67w1nRmECoHbToQkGuLEmkjkYJziCaEL1
 5sXt+43sVDa2uhOYLWMWEeXCGZukn39rI1l+vfpqR1/qMZI1WItoPUK3VJhrC9vBf0QojPiO0
 uZCY8jazskYD8eZc5fDSLRnuxM/GiDf8sMNSmho5xUj90=

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


