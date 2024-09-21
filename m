Return-Path: <linux-wireless+bounces-13070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB7597DD05
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 14:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B31C282AB8
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571882876;
	Sat, 21 Sep 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ny2nJI+D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B91E49F;
	Sat, 21 Sep 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726920175; cv=none; b=DWeCyh7TUPi0b7Y02HcQFZPTI8ratza57KhTQ3OwgxzDJoFlMFBdyHqy1CuPXsxcn1oP2kDfJGBhx/vooDwQyoF9xWqjZJJ6LU3/AxnnG/OnQc2pi8CCwD6zP3MZWz1VV/GoLNlxZZ2cS95p+AUuHV1Pm7q0a1v9T82Yrtp2leM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726920175; c=relaxed/simple;
	bh=CEawkW4j/3FwdhrrG8z9uxgUjpJrgxwwD3ERQwXJENc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OHFwze/oZipjH2jZRJ1GlQ/vOhyXc9PGTvQiXsl5t+3Ude9roNp0juLbpJn9XrcOcpx4ArxuDAk9SIZQ3YbiSrzC0stlW9jWY6McryrBKjucEBd2V4tS+pfF2YOUTgTl9GO1EvLZ7Q2wFtwf3tLVxd7n9v6cUaiV9AuYngjb2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ny2nJI+D; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726920150; x=1727524950; i=markus.elfring@web.de;
	bh=HzVrrsfa6DHNfn9T2DCLPRLw5kYNl9j3zngi6zzGsxw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ny2nJI+DGSaGjbingVCf3l1/7Rwnh7+dmEgZUOjF3LyGP08smL9GYOfpIi66iI9e
	 X4ZL4YuKbX1lvADNla7HFc0OQyclkiLZMd9RkxVZ8hbBq6ZiFFDZnppSK1w6fSCmz
	 hZrdBOhVtoZN02k5Pql95l3R71Iqv+TJ8mAyApjntXWSmbmgEHtzGrD8cCDmGZi6z
	 hea7Zrt+W3LXHZA+KRIm7aOqtn+YRAPE+N9/gFVCUTofLiPZlCWhcTnczqTbZqBic
	 +aLB5mGF4qIIeQUiQrtPyuMsNQmlpi2uGIpTJgZxPAHoQ5b3mUEQP0sf+ve5mDIF7
	 +lnKRKWAPhFrrDBpDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xjb-1rs0Rh31Od-00xfD2; Sat, 21
 Sep 2024 14:02:30 +0200
Message-ID: <5437e685-8fb5-45f4-a78e-9aa961f5adf7@web.de>
Date: Sat, 21 Sep 2024 14:02:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] ath6kl: Use sdio_release_host(func) call only once in
 ath6kl_sdio_power_on()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-wireless@vger.kernel.org, James Minor <james.minor@ni.com>,
 Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Steve deRosier <steve.derosier@lairdtech.com>,
 Julia Lawall <julia.lawall@inria.fr>
References: <d5a19bb5-f940-4f07-9f98-c670d96cc839@web.de>
Content-Language: en-GB
In-Reply-To: <d5a19bb5-f940-4f07-9f98-c670d96cc839@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I3CBTEDZ5u89hl5A2Q9zxpyRlYtNA2Egj4hxcZduSNQoxyEy1by
 B6z0SKEkzLf4VCHM+huaHxQytgLBrlm9Tf9fND1TOhjM86k7ahDKuK6NZVSLss1bSvCGtns
 dlaS4qqS8HnahSuOr/Zpbap+anDuUQM+TWDEEBs2uAwB9qP+ninwuuuIyB/f/k17eyPcbsV
 Iwd7w1UhbEWkTRd2Q6JcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XL2DkwLxsII=;4l7w30JC3zBu26fh7+kgGa2pC8r
 XYBljwpWzlIXFt2GZSb2p5ft6S8HMaqWxt+FhINKyzR0Q1Iwn1/+K8VudbyTH5oD7/eZLd2KO
 mSzmVl/FiniKPmz9Cu22rYz4Q2tQSmvBRXbftW4OBhlXf2824wqdqx88blx0d7fHQEwAjVfNy
 RrXwRAW8LVY8PMNZcHdP5xaQVVZnPlizIybtI7BvERnZiYIZPPR0tzzSdkjDrzEeJCsVX4bvr
 CcTxlC3INXi1dzm1G5kICLlnjnO5/CKZFgfQSQLfyfpZLuO3y/uTwt3gUk51HVu6qRCK8V/e2
 xcJ6vF1QgL/YSmOwlWWdTNAw0Sh8ztCMuW8D7nQKuyAq262OgbeNRBe7VzGqYdduYJ0EMxoSG
 kVc/OLl52AhJ4o7N1vCd1V2G+aVI3J9pnSUuL7AU6N3yFEv7zJGNok/JoDfKak3hxM1wFXlP0
 n08mVws9RtddPdhJJdeVDyeeIOuRH7d9MET7ryIcLoNh+5hcyy85cNlGTTh/dPPpfnIt97nJg
 OWujc0Ov2CbojLqhhzU2FNPECmNsDBYkp0z/6Z4+HrqIMPmTgqAqWivsvst4i5qHNqXkJ3sWO
 8Wr/hYFlj7HUzzKmkixzRSNWmHGB6bworKA0J0fX3m3erzxuYb64EZ2+6HFs08BRq2tnoERTU
 KL70OWkw6RWwZ7YCev4+62SXQ2YvqaSm+JSAYjcm1Oi1QKHh079ZqovYncZE8up6Hn43UoPwg
 rnhr4aKtQy657zUaYmq8UrkM0DRDILwoHld3cY5IBUgVDHOgBZGy4yVaml0a3gu0JiWJVHDgT
 khkc9sLTXCVOpkrRg0GEHa4Q==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2024 12:00:19 +0200

A sdio_release_host(func) call was immediately used after a return code
check for a sdio_enable_func() call in this function implementation.
Thus use such a function call only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/ath/ath6kl/sdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless=
/ath/ath6kl/sdio.c
index 9ab091044706..5106c6909dc8 100644
=2D-- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -514,14 +514,12 @@ static int ath6kl_sdio_power_on(struct ath6kl *ar)
 	sdio_claim_host(func);

 	ret =3D sdio_enable_func(func);
+	sdio_release_host(func);
 	if (ret) {
 		ath6kl_err("Unable to enable sdio func: %d)\n", ret);
-		sdio_release_host(func);
 		return ret;
 	}

-	sdio_release_host(func);
-
 	/*
 	 * Wait for hardware to initialise. It should take a lot less than
 	 * 10 ms but let's be conservative here.
=2D-
2.46.0


