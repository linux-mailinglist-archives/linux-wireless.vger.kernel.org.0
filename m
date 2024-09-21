Return-Path: <linux-wireless+bounces-13072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDA97DD09
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 14:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E353E1C20CFB
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1717D1547DA;
	Sat, 21 Sep 2024 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="krahBzQr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771038FAD;
	Sat, 21 Sep 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726920391; cv=none; b=tpRfqGLiwbCOTRryzTF5KArABWGfUMzTPVnToAYEg6Sq58spPZQGgre3elXC7okxYAPAKcHh1U8C2aJb1R0KUlK5eN31vYgBu/7suXrXMUdq0pSLxlQJBFvFEvR2ylCxeZNLLUEFhholsZUcXz9IUc8LaILBWg4Ly5hO1tie7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726920391; c=relaxed/simple;
	bh=zr0gouvj17I6fBXXOtd2ymGKS+xiRy4XeRt48l60BIY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BEai0NCPdXKdoOrL9pXsbHuPKn5r5Dg7U4V09k1D/LNNK780LR3dK0535sKJJby3rqYMjq4AkOk66KM81cZmQK/EF+Q27icMAJwcFPB8gHlOoihQr6Rd4rukokHrkwzorAvBXg6RUfpgPrsXvnwz2vJha6JrI7aHtVI/3Wxx83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=krahBzQr; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726920368; x=1727525168; i=markus.elfring@web.de;
	bh=TK18ZHNWFJjXGBqBT4dkWADl7TFmWTlo5r5480j6deo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=krahBzQrlEQqIsS5yBasyazsIQhK8Ww/AwFRMiL3ajvBut54SdRh3IhAmmrcnLmG
	 f2n+YSzNMQg3CmifnNiAjVoLrAizI4LBFQHiwVlP+EyCUaQ1dUxpxoeBZDsiJtld9
	 Yl6vrK0q+9blpD8CEXjvNY05EpYaamkCNDyw2R6fKHohKQM1FjO4WtsTNXo0D/jnj
	 LBMA1Z6gug3kNgizg0kVT5ZXFHoLpSK0/0/WiAWu4Sqm4zpBwNggqSQXi1vRZ066E
	 DCSpedcIX0XtxumqkGKoS0pO5UYJQUHPRN0JUfNBr2h3m+4Z+DP0b7JQMSD3EEIa0
	 RnwvK0Oo8iFxfxZ3CQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUl9B-1sRtR31baT-00Osak; Sat, 21
 Sep 2024 14:06:08 +0200
Message-ID: <33b08664-fa25-4cef-86b2-49f65b4369c9@web.de>
Date: Sat, 21 Sep 2024 14:06:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] ath6kl: Reduce scopes for two variables in
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
X-Provags-ID: V03:K1:99V4E3mGFuvjnUZkMhWYuj/BeKN26mTx+uQu6VxiEI1CP8OfQ8c
 puhfxyJrZLsj4yqNsEL6q0grzKYo8p3C3q/zJ5UcAJOPY93y0WI1B5tLLq0niKBcbAbkBAJ
 tXZ9UKnYZzCMDnQ7beLyMEifzV4SZp0Jc51PIIlkQxSO7jgFL6dTz0y7vemfZgtclYpErR3
 6DvK52caKuOWlWBaopYow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fG7TVt/+ZC0=;kRVzu2eNJ1b31ZuzA6D0ZqV8FDh
 XavHzTx7p6cz/UALvWLtJZcr0CiWRlRZIarktZiOhtJt38mGJkGvQsZS0nHABs5ABHy4iT0yF
 vwwkirYMZvlkAGNqLIwMqQ9WUkheHKVS6H9v0MLteCJxBXZA4GGBUtLmB7fDVQuuQxEGHQmZk
 MBMZjdWADy7AJxvPtLNmTM9AaK6PLfY0RUzEsXpn07cdDs7Nncl+es20I2kjFZn4lVZGpXoqx
 EOjsUd0rG829Wx4rub81t4J/Gv0Rn7W7JvDSzUaujNTp95aJ92D+Lg2rYtkQuYsMJiDpp2qqG
 UAlZl0oVfpmBA8ozmYo+OeQ0AWPDd4xgjvuKFuxCpT8fC6OQaxYUhE+v+nCE1xcQVzKyyAXEJ
 nLLd9mMssQ2kA4CN7l6i8eSvjMCFKKmrtpOFNdgrho51dtQmO/QEUEOGEMpua1yVaTIE5n1KV
 YlREskaCuz3GGeRoezKEQbKFEA1lx0Bg43niRoV1j9/BqSrGsB4aTyRdPJsHtC5zylfUjJmDV
 oqNgKTQCAVKCNYKmFaffFalSAXi/TGmR722D1BGjDCY2NEtHTtNmkBT5Vf15I6y770nAQ0M2t
 J1TMYeGxITP7yRV38mZVL5Br8dOz0FHH4fQTLd2CyG9uN25VAZaB7qri+AT5BnteVxrgQw2/S
 kCjoFE0KO/iCDD8qNtWYms9knbaGO9ZUanVkc1CPYrlmfpJzwC+EBJ2DPnxHkXYE3oLiGZbNs
 jLuV5VmD61WqFVmEKhKelUGjyB1sdtoymTbrCLCkifTPhlaFBrjDC6ToHe/T1Yn5H0KAC1y9q
 8dL7WApqdGKsKdStE3la1IjQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2024 13:30:48 +0200

Adjust the definitions for the local variables "func" and "ret"
so that the corresponding setting will be performed a bit later.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/ath/ath6kl/sdio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless=
/ath/ath6kl/sdio.c
index e4d15cc9b36c..689f83f6bce5 100644
=2D-- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -503,17 +503,15 @@ static void ath6kl_sdio_irq_handler(struct sdio_func=
 *func)
 static int ath6kl_sdio_power_on(struct ath6kl *ar)
 {
 	struct ath6kl_sdio *ar_sdio =3D ath6kl_sdio_priv(ar);
-	struct sdio_func *func =3D ar_sdio->func;
-	int ret =3D 0;

 	if (!ar_sdio->is_disabled)
 		return 0;

 	ath6kl_dbg(ATH6KL_DBG_BOOT, "sdio power on\n");
-
+	struct sdio_func *func =3D ar_sdio->func;
 	sdio_claim_host(func);

-	ret =3D sdio_enable_func(func);
+	int ret =3D sdio_enable_func(func);
 	sdio_release_host(func);
 	if (ret) {
 		ath6kl_err("Unable to enable sdio func: %d)\n", ret);
=2D-
2.46.0


