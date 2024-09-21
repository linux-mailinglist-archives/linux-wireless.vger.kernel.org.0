Return-Path: <linux-wireless+bounces-13071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984C97DD07
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 14:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1DFB20FB7
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE2142E86;
	Sat, 21 Sep 2024 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uCDzUkm7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5851E49F;
	Sat, 21 Sep 2024 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726920263; cv=none; b=XxvT1+MI6EPX4Nx3BpMzjgrTNZyYRW9sq6rquXKt7MGnm5gAHK5vpS+Jw7OS1CgBOzcbRn5kbqdNZf+JV71AeYaRg7UbljIKv6hvCEhd3mFQOpk+e4nXdlZvQxddlXKmkTzPsh3/M4B4ATiYi7EKReUMQqFBsi9DOv4sSu+vhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726920263; c=relaxed/simple;
	bh=zeHBd+jpN0FHswZRhXNBVhUMYHPwBCudf70YBsWzHkM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kD+O65hDRuHWYUv3FrPUQN4oc8UvLf1S3c4J2kd6MilcwYNaEZXkW3e1ecmk6cAHc5XlRPH2ZaNIjDsguIgTLrQMNBOi2fKW0ENxobqxDVwVhCVttp6GDEB+OrufpzjDXN3Bsjluqo+XaAuir37CpkCXhETmsqYXKTfJ0PRhswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uCDzUkm7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726920250; x=1727525050; i=markus.elfring@web.de;
	bh=sU9bIIzGnTpvnLV1pwylT++PxrcoOaCsoLi2elpHlM4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uCDzUkm7pLFHKI7ZiSOp5GdJgmYKmtzO5t595In59SS0QOIqxpElBLklJYTZJdzU
	 bevQobXBV5+0L3CSzMzzcVr6lGQm86r07jsECQD5j4eWyByWn6COTINcfjYTHzKaV
	 gA9xDe2al4zycunM+3RvSntot2U+dTqOYIP92ddgOlJxY1MA28qUzkcJy8vMe4Kdp
	 9O6+tWODD6os4Xgi/1GXX9QmclY7jwH8p4b6Pd1rZkY6a+zyYu/GkkT2/evYnf96C
	 C4DO7flN1bKRjvQ8vthQvYWReYzPt1xCrIfpsMP+EVHHRL+lcU5O1a6rCazbudTj1
	 u96tc87XWZtp2GbQ4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX17-1s8z2l3BMz-00heVG; Sat, 21
 Sep 2024 14:04:10 +0200
Message-ID: <f33395d9-c463-46e1-8a67-b9a07aa8f202@web.de>
Date: Sat, 21 Sep 2024 14:04:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] ath6kl: Omit a label in ath6kl_sdio_power_on()
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
X-Provags-ID: V03:K1:TDUV9U6gQOqxrKmW9o59nvLv9E4o2pQmEQ3E9hKDGagv8IpMPo7
 QtiHVlTAYg+P0aLksAr70DZDsJVrIy0KjzhXKKqHu1vy41cnk/dx+PXiFNFs580ghPNKPii
 v8zakZQzVqrVMUtvjiQZyBPGWYMAfFVRji8lOCov3ZVdqoEfvZ7zf/ODptFVEKnD/9RIYgO
 91GXsUY1rCa9c8l4IcD6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4RUt3BWjUFo=;XVGyb+3wc7uW2QVYBkEr0Yey1k6
 5Eb4DHu6qD9owH3Al4m41moThfiV9Anai7y0nFX8y7VDemjvu7aafMy2Aum8LCQH+z5hACH8S
 jmwlTOzD8E8BbZkuWIeQDGnFrfN0ED4w/ISWYa54xxWscTWkBl1etGqJZu1AxE1xnzrHONAS+
 umYNxjx12CQcwajAnHuFHcj8PRfeeBeSK6/OmRXTy1Y4enWbBkO307NO9nb5lpjSzkZbuXmnv
 +YvY5uOyhwuUc/NSHkcOgDaCFYbyQNl6CsLqweTc1N72fW8uIvyDPfmoTOj+nGDrLU9oy6B9o
 i9b6RSQgRGmBjBpXc9uxUMFF+Ylt7a1ZEiTsQIJeN4wcBeyT12kNotsRHpq+muhSFCsXtz/PB
 NIz5uVEd2I6UiIVx7FtMWb7TVvxai2bcXgNgkw/3nD9Dh27c+Kmv4tvmQZwa3K8R93jKL+Wp8
 AeR/c9FVKda3piomxPhhVPZZMY4eIGumlZM8hRab+XDNWwnlNf883p/k/SgFnrWLtAkyUWWQz
 aQ673U74bQKBhdh2/Y047KR5HGeURhCJwOzHDeQGy1szY5jZxrO6JchLstYvW8ZncddREBLm3
 4vva5NVF30IOg6+GIFeKvjA+75rK4Y0CgocDQKIzXr2CwT2Vlf04LCgP/F9GTZV1h9E4PeaOf
 14AhnG5fqZ54+3WXV3WiKErsuhxzer+pzbynDA3Bd23S3IedDz9h69mwDPh61RSdvVmYH7Y9F
 jsPRMIFjI/pkA32H0oMB/PKTR1VVL0THIgYSGTtOLdR+jHmAu3vapwIKAN5tEdJBw/f/9ZcIo
 unT9kJ26SAzs893/zg1GKgQg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2024 13:04:19 +0200

Delete the label =E2=80=9Cout=E2=80=9D so that this function implementatio=
n becomes
a bit more succinct.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/ath/ath6kl/sdio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless=
/ath/ath6kl/sdio.c
index 5106c6909dc8..e4d15cc9b36c 100644
=2D-- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -529,13 +529,11 @@ static int ath6kl_sdio_power_on(struct ath6kl *ar)
 	ret =3D ath6kl_sdio_config(ar);
 	if (ret) {
 		ath6kl_err("Failed to config sdio: %d\n", ret);
-		goto out;
+		return ret;
 	}

 	ar_sdio->is_disabled =3D false;
-
-out:
-	return ret;
+	return 0;
 }

 static int ath6kl_sdio_power_off(struct ath6kl *ar)
=2D-
2.46.0


