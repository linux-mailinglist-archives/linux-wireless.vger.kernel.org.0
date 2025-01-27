Return-Path: <linux-wireless+bounces-18044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC3EA1DCEC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 20:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6513A6351
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 19:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75D194C96;
	Mon, 27 Jan 2025 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="g9poIM1a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C77189F43;
	Mon, 27 Jan 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738007338; cv=none; b=mQJpajz85KBcYNrLWzsqYY4n+3JPJ9h8veLjzTwJuaPGRh9nHFrxl01knAdoI8L4c+Y7FdKzUsqpyD8aAtcX4EmZqNScjGqadYU/ZliXz00TA6Qj7zHSe18JKH5L3uawWf0fZMZSFCY5M/QvCT2aBce+b4veBpp3WJmX7JWKz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738007338; c=relaxed/simple;
	bh=ro6QN2mJ13LgUk7K+2HpgHyalFgS7tQjN+1OfPnc9q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TB5uFnNCVI6kFGgObxyUj5NjeTCdcJL5Qq/49AzyBATVT+mPst8oJFdEL947ZhBd+FvCBItDJ/d95DCCdougCNT/JSieF/9aDmKFZSAbKSNoGaXBldxblmedBMVYMpAzXakB9LWq0pChrOD0Xv3UsCaq7Y2vKffeJXl8hIRS83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=g9poIM1a; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738007327; x=1738612127; i=smoch@web.de;
	bh=SN7Hax3V7meZCCQdThMA9BV5EAHTRutl1/qaATTXcRk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g9poIM1aVUqXFOlLK7oXNMeyeMWcPXvnGCBLzqBaOIAi9UmYn/z/xbNpk6w65VEI
	 cGuQG8gl5wgvqIdSj7oZXlDAzXPRQEId7Xfp1l+JfVRh3qfxV2p/HYc7eJs8CtDoQ
	 w92fZap+NKdcROVKiyh6j69hF3QJA64U/ONF7TAuCnJe3q55OUtVwFAZaieC9SK5S
	 R51swjpBksSARBJXKGg3ULw4PXXGPxGqW2pVgjMf7M9gfF2e4KMbZ9pFOF3Z6+fiK
	 MzecIV4fed1TogJ2NsNTEJigyWvjRJ7cfFOYBgk1cxOn5JJnad3twina6mGsOaxHE
	 ngrAnJQHXzpMnDG+Dg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from x1 ([109.40.243.154]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2Phc-1td3rM2scI-005wcu; Mon, 27
 Jan 2025 20:48:46 +0100
From: Soeren Moch <smoch@web.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Soeren Moch <smoch@web.de>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v2] wifi: rtl8xxxu: retry firmware download on error
Date: Mon, 27 Jan 2025 20:48:28 +0100
Message-ID: <20250127194828.599379-1-smoch@web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6SoqzoYr/kIna3zRe0Bsf5CxbbpSBC+s0pz5HIuxeq0NUkxoMfp
 kkSK0YQCDhNsBnMsvurC5J0Sz5NRJnZ0wcroFYV94E9Q7S11XY9dmt6O2yr1p18ze+F6f9l
 GHVMBXB+PEBWKQIRTCfUDPjhNDyCijpiccB56XzB1WS4pwYhZ/7bm5bnE/qx8Anhze8BSlF
 VybrZGOMFQZZPWHAfsFZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j15uIffQLkQ=;vRe0Lak+o6tTflmF4GVoB/EJccY
 cP+fqXYGXUwUZPgFTuP+6rbflpCC1KqrtCWvCZd4K6kiQXHHLMEH2Yy0xC9J4/0JGGfCmbU7Z
 yatvNUKdJ3ZYU8szEAmqAn/AJG5ZE0Y+O72ZmMGoKj0bBA9Bd7VSpnWqQJgRjUCPB2svsO+8a
 ioo2Ay1zJDoJy63piSTQ6pPN80mdkbltVQY6SBy1aE4uEQoFz7tSdS0UNeKbF8S1WeyHCFx79
 IQfdft6hqfVLrjlh/zTYT5tne+sEpGZxsUEPHU31/B99rd8u9WSQHy6WC5FkuSFZ0vTgr+gbf
 Boam6NeuPi34kr0UzqIs5hZhfTequZFrRSshiSZBywiXgku2GdI4j0dEdN6pPfk5wRpiG43D4
 ukAaMZBQJnDAhCCm+UT+B6IOXunuYKjKDcahX0F62jTSYkMtWabufvfGO47iMkZN46NzpOM2o
 4VLp41OocZ574eQsu9ZArj63OpuYOJOxRC1jDeDoOfmFEVaKbsJ76WhZjhVi1R4uZq1aOq3mq
 FJcqV1Oy7eyBjOV4BUDHRv0g6Nok9v+7bZHRLdIfM3nnSo3NuZwGCopXaEacr5xkoOettquSR
 o28rDo6DGgjZetoOT2M8PEcVzspoy1IC8N0aWepbFWTiHjQpb3+U1R2NvyhA3Pvih/5YkUqVN
 v6c1PBxEW8BFuyvKC7NRnnG71AUZitJWlkTNI9mq0aybjW6nK7AZ6AeQGkM9IjY7Sp0f5UatT
 gwU+MI++Z/QlxZhoXDuxiyFmS9sS8whOF8mw2WqmUqKcpQ5JcxRIzz7EUL/ZioD9o4vrR79s6
 14Ve2dPBVQr3maaVCfGzltk6P9AT8vlIic0h5NhoOhMy1I9Pob9WsIZfmmg+i18otsYX/o7Ng
 gWK9Trm7qL7RJVkbrtzAYyNCrhggBBdmTACSIZpzLXtbjpYeoAI1YFrw74kaZ0qeArjBA0otM
 lMxShimW7XekCi0StGdu1cymN/mtorRig7gABYRBAp+K+xExCQ6uE4xFT9uJxmYi27/3EA4xn
 D+O2ifGma2o3+av8Cx/3ABzl+F/R50kyN2N+IymWmh/+xPHR8DeN4yzLivIg/qxRUXVFtgwl4
 38B+5oRwhDmu2gNVs4P2kh2md8dhz8UZvjbqDxcHDV2gUTndic9twdAOyOrTFoDu5GeqN3rXg
 7DtmK0QGshtheVJIVPNlGpWi9AZIpi80Yu2mvPCV4wimgnIbFwBtPnA7WYgRv11Ri3v7LRVdk
 yn4D8Swq3arv1EQYaLXEPPdxKo4vcNUhHyDXL9vQNvUTbEWFnTYQ5Wh/6YgtkaIYu7rPj3PB4
 PmZz4m5IroR8Wj7ACuqtzdQkg==

Occasionally there is an EPROTO error during firmware download.
This error is converted to EAGAIN in the download function.
But nobody tries again and so device probe fails.

Implement download retry to fix this.

This error was observed (and fix tested) on a tbs2910 board [1]
with an embedded RTL8188EU (0bda:8179) device behind a USB hub.

[1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts

Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>

Changes in v2:
- mention related device in formal commit message
- fix loop iterations
- adapt download retry message to common style including
  function name
- hide firmware write error and retry messages behind
  debug settings, according to feedback by Ping-Ke Shih
=2D--
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wi=
reless/realtek/rtl8xxxu/core.c
index 7891c988dd5f..9008c619d833 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -860,9 +860,10 @@ rtl8xxxu_writeN(struct rtl8xxxu_priv *priv, u16 addr,=
 u8 *buf, u16 len)
 	return len;

 write_error:
-	dev_info(&udev->dev,
-		 "%s: Failed to write block at addr: %04x size: %04x\n",
-		 __func__, addr, blocksize);
+	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_REG_WRITE)
+		dev_info(&udev->dev,
+			 "%s: Failed to write block at addr: %04x size: %04x\n",
+			 __func__, addr, blocksize);
 	return -EAGAIN;
 }

@@ -4064,8 +4065,14 @@ static int rtl8xxxu_init_device(struct ieee80211_hw=
 *hw)
 	 */
 	rtl8xxxu_write16(priv, REG_TRXFF_BNDY + 2, fops->trxff_boundary);

-	ret =3D rtl8xxxu_download_firmware(priv);
-	dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+	for (int retry =3D 5; retry >=3D 0 ; retry--) {
+		ret =3D rtl8xxxu_download_firmware(priv);
+		dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+		if (ret !=3D -EAGAIN)
+			break;
+		if (retry)
+			dev_dbg(dev, "%s: retry firmware download\n", __func__);
+	}
 	if (ret)
 		goto exit;
 	ret =3D rtl8xxxu_start_firmware(priv);
=2D-
2.43.0


