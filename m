Return-Path: <linux-wireless+bounces-4553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC697877E37
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 11:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C846B209DD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456DC39FF7;
	Mon, 11 Mar 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="eW4vJVXe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F1199AD;
	Mon, 11 Mar 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153505; cv=none; b=HimBHoVOlDGNdHtvjDUSsyKcwTpGGq0gJUZVVdEbQ551pAIHJsTK0UT3GAzddoJ7nZwNWHpDuDBtNcxEhpHZLLcphsm/TCXwbp8dMW608dAMwz3ULpSKU4HZ00JjCZcI3TmbubwENoeW8Iw2AzTkOgiD+CGfW86jYcZkcp/SBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153505; c=relaxed/simple;
	bh=KwZr///IvqX1ALEKr4OOy/LNKMTrPfYHY9pB5hMd8FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDS9M0EcjPtJPTBYQMOVmFghl750RbANhv8eFSfYcM23UX0CZDj2yvf4FSwn9R+4ABOiIJimpPSxiYV/F0dI5Q29j8MWHcHk/7ttqyU5cquwoPpRwWkegMUmembBLlLWCzv+wmxnD0IH0pxMFT5kTAKUVWvBjvfroH/PPk2uhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=eW4vJVXe; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710153492; x=1710758292; i=fiona.klute@gmx.de;
	bh=KwZr///IvqX1ALEKr4OOy/LNKMTrPfYHY9pB5hMd8FY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=eW4vJVXemCOazOu5REIMDGKv0aLiVtywTT5KOmvIvfHA80j0Q+/8dekyQmu+JXjc
	 YrAXseCqvidlHqw2oizSkPVTE8sNpaqQ71q2pzdBFKAef+qGNcyHB7/c7ctMI+lT7
	 GOwnDSUdhz3fQXyZo8DGYY46vFXQ1zXSOIFo3iVWB7q1vzRdGQDtLKwm+qvfljZM+
	 Or+YiNqFVf/X887hhEkqYoJ5fxD1NP5eORQU310/eA/gSBcmCstrvYHS/hDKcMyUx
	 nsSnxS0S4bX4OkIIJn2a9WUH8qDdiB8Vt3whLWFMz2hLOJH7pU7UYc5Mvj2TwYy+k
	 XDqEhMa+YNhkr8VLWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.108.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1rTrDD1fFT-00P5IR; Mon, 11
 Mar 2024 11:38:12 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v4 8/9] wifi: rtw88: Reset 8703b firmware before download
Date: Mon, 11 Mar 2024 11:37:12 +0100
Message-ID: <20240311103735.615541-9-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:KPPVdPov5etYgRS1RYBEzsxh7yn1n6tR6gJEeydUszsy17LrJLg
 EaaHcbhTPuJxiJtPybWOPw6ujuGcnNVrilrR29vekEdVErL+HBaPRAOeHqj8cM08Qgwir6+
 0LGtuLCX7VPjIRGdbberd7HwnuqCT69qDEPcNIrlmopDKMyMC+r3BHk81gOTFrBF/B8a25Y
 j7S2wSPjrIiNuBIf8/czw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+TILPNUhTsw=;q8nMNFkib4Pvwo9jtvDhgU4jfYG
 hBV433wa0i72JDAKxic79rao6mXgHLwbkxNj77yfps3PCVWBEm7TZOXcQp1wPpeBhzTZz/MeO
 GG5JDjrxdxxztWUCYYwlc+CyruVFPQx2wkW3fWbu68aQjTYkUHED5Q7Ue3P0FVZF2YmKvSucG
 5V4gDEYN/bn1r1LG6nQp57STy6W70Co+rR/XvnX97JyoQf3zlKp9ChTvfno9hGMzXGdrqDg6O
 KvU+gI/Ir9AzTJ8ZeZa89fr9lW+tKOiXGarg/XQwnS5D4/fPqBA7ALsJrbHpIBj6w+JrCgDPc
 AwPmZ5rqUDYAtzoFcyYBZwwXvIlj2eSSNu+xWXuBo2p2pPlFeiYiTsgN79bdEqHRCGwEf5fvZ
 uogX6fm1/cJIfyYaFUbNU6WVHas/dtrkVKBWyYyyj6cI2OvQyZlryYPaV7WZLvVQdDu7fCOSr
 eej7rTfovTkgR31ZwTtZ29P29KhWraDnqgI9Uk9Phkzxi/IR4Y2cgb81v9q2Mzrdaf45bkUzx
 IImM3bqA4sT7rssLu2lW0nLkjV8hFrT1aNXnzhaEs867dXf4rbGYNUJLv2Wh2IcQ+SUidVlCM
 WSN48VBntkIJxYRTcN295hCm/vmMmRsz25h+Rm3aGq8v1O4Wc4WALjs8hO6ORTfpn9rCrsbmf
 3ycbtY5Rcg6fP8rsl8CpKT6icd550Lzz3VSwT7czYyjZ7K7RLgH69Uu2P5yriF3pK52Sa4DPz
 V0yJ0Iq3qcaJhtpQXZKw8VyMcXYXbxFLWV8dTX3ElPbfRWDPGhvJo1FC25oYmCrg35uaLhd+U
 ewLLDv0K9XUXA0JcItcyBHnaTf+ybvJ/jLu7GlSQnGJ1Q=

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


