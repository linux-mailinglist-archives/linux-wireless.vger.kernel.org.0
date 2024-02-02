Return-Path: <linux-wireless+bounces-3020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E1C846FDC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA4D1F271D6
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC213F00D;
	Fri,  2 Feb 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Cvcn+psg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267A140772;
	Fri,  2 Feb 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875892; cv=none; b=pYgZ3B98wcO5HDxG5BB6XRQjhnm02Og8/lmyvhII0HG1/sAZY/7+bHnX1e/ZBXHVUmsRUH8T8m2uOcCUJ9BCEwhR3ajVup7MbRvWOENU9OjprMTFEU96HOFMTnn83Wb/tqmCW9vEzczO0bNEf/Wbg1JX/fGnXwraX9W077JjEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875892; c=relaxed/simple;
	bh=8BzL9t0Y5BCGHieDGGgan/co80m067E9gDzrU9Mlp1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4ZD6cLbNE1BGGpTuoEjvOBJs69txOKhfbGYErii/hZefWIYWaT0lyBarZrrEXygO8HEJ7WEJXHaTQ/TXUtOaNf/UMYwCk8h6oage+eMz+G57AjxcrL0TQaSrUgAj0yKFtJep7fqu8yY2C7gdB4mLglruM80vWPgF+ZFhY6G6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Cvcn+psg; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706875879; x=1707480679; i=fiona.klute@gmx.de;
	bh=8BzL9t0Y5BCGHieDGGgan/co80m067E9gDzrU9Mlp1M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Cvcn+psg65e4RjQO5a4wsc5EWDNnCzVdpn27aKjgYJCKI3SuQ70yot4fjWCgjQvQ
	 nTyZpgz3ESYXuZtmppAjHbekBjW+92nWNvbxxn1LG6fUqVZmFBA3lfNUpvOGlSjWn
	 Zw3ENhNtscInomnwTis0xA+Hy3A58ddryA4elCc4ah80cEGAyb5WYOoLG1wZeT+6S
	 tnES4Tva6m9xs5IiKCgWzllUT57WV1DoFwrHo3f60onfZ9y30E+YkPw6QgdOal93k
	 7K2jfBfihAMm6izciTDcd55iDusnGRHi4iQ8STu4JF+2MXB8GokhgqdinAjFSNpiC
	 8Z6iUPc+5BsyyOk0CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.17.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowGa-1qgbOa3KdK-00qSFN; Fri, 02
 Feb 2024 13:11:18 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 8/9] wifi: rtw88: Reset 8703b firmware before download
Date: Fri,  2 Feb 2024 13:10:47 +0100
Message-ID: <20240202121050.977223-9-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:tEaz1ZEgpAYeLPzm45NEtJeFiUSw5EJxLIIX7LZJeeg4utpjRCD
 D9L1V8FQdVXg5cTKZT3YHQ+AxWzYyRkLP3ve9jt5fYXDJSDC0rvT5dwgshx9G1/oDpBES83
 5RiwrYbKnwwEbNduP03ASZlopn5pzUsfE3rUoTTEheiehxfPDX8bd5E+EXEqVH6gpWeOzkO
 a3NEzNDwhMmbR2nD2HATg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o7qoOM5cLWU=;uJx6kJ3T7Til55pkNi3iFGTr2Aw
 aac1PFwQWQ7qlIoU0oBcAK+ZxnlzuLNIUUADnxG2sLQSnxWJXEy43vY+OXw83T0l1sImIXjja
 tVfI/9ymkpx8/vSnBbEh/jyZ4wCM5JCHT9h7GYz+6lqEOp4TOrQvtBWbWCCs3uENS6w7Kh5XS
 t4tNfxwXMvto2wZ2jeYFvBsR1+xVzECBhNP9xgPlAJRxZdRHrjGv8FUN/o4hvSQ+wAu8Me5IZ
 056TypXed2CowlOIKqGOEFHvyd2CY4xGBdgeJFYTFitmK/CelvfhUGUHDILBRuvIRrkfSdlIu
 MemNkdDdcUF1mlg5JciLdph3N1aPgwOMMQqXJ8bpthN3vgmeHUcF+T2mCqN/6LfY3yUybwcTH
 oW2KHaBhPlCAptmUjTzBVCJJYh7a+D/I5//TnSQ7Bq+Z/iX2bhzEEfJ/66GsTJiAP2osve+dr
 mVOB5t5ypOIVb1m2ve8tgEuuf3RQKtszNTahhZ1oDTvOZN9fFutCfCtC0hwGMuCRrj1qCFg2B
 SxuaVI/OKPYh4QaswpGQ4kobfeSIc4ROUz4WS+aahTcmphcCFSsCI9Xbh0Ayc3yr2B6S7eerg
 CtZ0fl8snSUGYldPguCfZofu0RCwxhxIMAZg7NDQQ4vLrjMp4XNAAYC46zYzQ2G7mKi27r1bA
 9wmhGOHTCp7M0/6mRFEr48kCNjAWBFWON8qBJeYXa5UAnNfQQ9kwmbXEZ8nmhHQy/SROC4KFn
 P2DTyS2jRTjYUn7ka6vpYAmoxKfwkhlyGi1J//cxkqLWbBXfYhRNy6LrifqBA7UHBIfV0RVdj
 oHY4ilpHq44ncoRi2Lu1j4gRWO1tzjNIm91Ckt8RFkCAc=

Sometimes 8703b firmware is still active from previous use when the
driver needs to download the firmware during MAC activation. Reset it
in that case.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wirele=
ss/realtek/rtw88/mac.c
index 298663b035..b6de097e44 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -936,6 +936,12 @@ static int __rtw_download_firmware_legacy(struct rtw_=
dev *rtwdev,
 {
 	int ret =3D 0;

+	/* reset firmware if still present */
+	if (rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8703B &&
+	    rtw_read8(rtwdev, REG_MCUFW_CTRL) & BIT_RAM_DL_SEL) {
+		rtw_write8(rtwdev, REG_MCUFW_CTRL, 0x00);
+	}
+
 	en_download_firmware_legacy(rtwdev, true);
 	ret =3D download_firmware_legacy(rtwdev, fw->firmware->data, fw->firmwar=
e->size);
 	en_download_firmware_legacy(rtwdev, false);
=2D-
2.43.0


