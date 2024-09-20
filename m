Return-Path: <linux-wireless+bounces-13059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7EB97D672
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 15:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7954B22701
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5E717A5A7;
	Fri, 20 Sep 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="blIq4wMy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE513B2B0;
	Fri, 20 Sep 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839940; cv=none; b=OkIHsOF2d50DC9ryIVjf6wEkfMNhm/wv78AAVc2Es2/m/7dMx1VeBCNG8OF2lQ/fLOFPPXNaDyShRdiHOW+EGYa/IIuaWGRpvGE7S2KKSv8d07upVQrhDrA+Vg6/tthHBEySr2F67El8Mt0k3Mzd+URno5nWQzdoe0KQq/PBNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839940; c=relaxed/simple;
	bh=7nE0FXHPcTltIazbk/5NF/RFfRZkZH/tfk4HiXVSBeY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=k+YuAkaB4SGlXROChLx38xTMN2qioEKyNjqZ2Gc9X+TC2ozGBuYj7oFzAqz+JjbgNG0K8cTuEiQqIopTl7vT1j9H5DyzTe1D/JSJZe8KKD9yMovI+zKorP8mVsKraawrBHxEu+7zAHKO1+Rs82uw0SsDtG2aSwfEQsShweQZKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=blIq4wMy; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726839915; x=1727444715; i=markus.elfring@web.de;
	bh=sPpneLksOxhwyQ5MRFVWIx74WqBZdvSmOwKIfe2tfzw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=blIq4wMyb0OlhdYtdYmJVoCz8DzVfVNAKDPxWP5KPxh3G0zrlObwV5aYm1jYLHOi
	 y8nmSGz4K6/HSlVAjXzp+BpZa79wM7QPi8EAxeoGjNZKFP6dZoNRJWlOnkY8eNLCn
	 Sp68G1MhbWHKTzUinUdH+umqk2obIXn7DhheEIzkddQi3hjUDwWzPgGRHIybv7YDr
	 U9wRgajoyR8oq9/2VBJvOyMnJjXFSfqe1dojKVHMf0o7iv5SngUTGlAR6gPAyOYT0
	 OogQI66ruQHWZoH6Z8xkAXiIOhBWtI/iZbBNSrvplOFrg437fXcaol6HqcOTOlpr1
	 blGsNWRcunTZNW95Tw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP382-1sb2s30G4a-00P1Eq; Fri, 20
 Sep 2024 15:45:15 +0200
Message-ID: <6ec0735e-d735-45e0-9d6c-e79fe3a11a21@web.de>
Date: Fri, 20 Sep 2024 15:45:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Erik Stromdahl <erik.stromdahl@gmail.com>, Jeff Johnson
 <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ath10k: Use sdio_release_host() call only once in two
 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6FOEYwKD4s7QSFMq6Bua0L2xGtkxsfSmc77g3J4ZylWEFRDONuQ
 A+fYy0u6uUUgvoS1jGnxh1r133xmu3PC5+ezD6592DA1dJ53TVqZZizG/Gr5IBI2wgpuJZP
 gb6aLNOEQz7kcMDic8vzSXhqXs3GuIflCh3dSnw0eyIn7YE5fUKF28cUlG7+m4kqLhQn1x+
 6oMtLz8cQaxVawxhCuWYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CtObg4GeLkM=;iNd5clKy4ODYsuOU0YuPyJPKy6R
 eYjzl/6EEgWmS59amelD7iY49M9ljueuaXu+yT2ok4h7AGVxoU3TkPZARiA90ehAgj+AVXUrY
 hTDhlKoN45Cv/+R9jzRFSI9dzIOW/fpgPvhJD494aXgIRtq62t+CFUKiSC0XFRdi/8QKJyj+G
 B/hh83i/78kWwB0QBYhYtU0GZtlsWvKbZBdkgOfdkW26XYAgykz0WTMV5ic434bEHFAFYVGva
 iAAaqmEKef5tZBvT6BW3+pc+gr1HgCtjXbFf4wmTS8j9eQfGOkNZDP4b1UXTKjgG4shTvXAbw
 JjBctWsoEE8XgvpbV/X9OZX0T8+HeQRrjdXclAJyiILj5urqFZbkaui/5IOzfGfMDrh/XUe3k
 RQmlpUvvC8+AhjaNQ2+qkK9q91NqzCRIDuzZnNIYxjUmcfXLTpXbvNWt19g8z43sYhOsHMBtQ
 gMZwxIpR2ldwf5ZRfnkMahzKBf1Pm4iyuJXGGlYCpv8JNGLelHA4fVR4Rai1BZeYDKr8llNps
 DIjNmMvI4G6G0HRLeAmoSGTfABJ6xKO0+qi05MzkRHgHHQi1pmhcnpQO37grFpWF7Dj1fzRJD
 j2o308AC3/bHKSyyTxcoV/mrwcWNS6A3pSKSUuJWRBoQ9LptsN/CadsoIil3SvMpryFRTnnU7
 p6NPXt8DsfgLor0nnheLTxeDXHrDx9Y7LNLsS4WgLRd+qCizswzCasoYubWbkGjpC79ayKmw6
 n81emhiKFJKVuiktVzf0eJYl+ZkM6urpvG1teasm2CdndI1cWFB9G3n19zPZUeomE6+EeeFl8
 HR9zWlBDTJ+i5gq+1oOfH3mQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Sep 2024 15:36:19 +0200

A sdio_release_host() call was immediately used after a return code check
in two function implementations.
Thus use such a function call only once instead directly before the checks=
.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/ath/ath10k/sdio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless=
/ath/ath10k/sdio.c
index 08a6f36a6be9..432dee87d73b 100644
=2D-- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1589,14 +1589,12 @@ static int ath10k_sdio_hif_power_up(struct ath10k =
*ar,
 	sdio_claim_host(func);

 	ret =3D sdio_enable_func(func);
+	sdio_release_host(func);
 	if (ret) {
 		ath10k_warn(ar, "unable to enable sdio function: %d)\n", ret);
-		sdio_release_host(func);
 		return ret;
 	}

-	sdio_release_host(func);
-
 	/* Wait for hardware to initialise. It should take a lot less than
 	 * 20 ms but let's be conservative here.
 	 */
@@ -1884,14 +1882,12 @@ static int ath10k_sdio_hif_start(struct ath10k *ar=
)

 	/* Register the isr */
 	ret =3D  sdio_claim_irq(ar_sdio->func, ath10k_sdio_irq_handler);
+	sdio_release_host(ar_sdio->func);
 	if (ret) {
 		ath10k_warn(ar, "failed to claim sdio interrupt: %d\n", ret);
-		sdio_release_host(ar_sdio->func);
 		return ret;
 	}

-	sdio_release_host(ar_sdio->func);
-
 	ret =3D ath10k_sdio_enable_intrs(ar);
 	if (ret)
 		ath10k_warn(ar, "failed to enable sdio interrupts: %d\n", ret);
=2D-
2.46.0


