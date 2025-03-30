Return-Path: <linux-wireless+bounces-20972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BFEA759E4
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 14:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81A1188667D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5613665A;
	Sun, 30 Mar 2025 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wudO0rT4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A751A282ED;
	Sun, 30 Mar 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743336152; cv=none; b=YX/OR8uCs7oiL8PbEF5mbB6qNh9ThzTXS8gmLXgPZpaOAMjJy5oiw8T5nI5MQYiAK7gYW9rgZQQaXl6G56uRqSn93CeG2Irofe0T3Utq518DJ7EVBiZsmV+qvnbbx2zPko8fJoaQxN5jO63/o05lHl2/mJWEqrAtTwf/S3Ysur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743336152; c=relaxed/simple;
	bh=/ESHn4nXeNvwWIGWrCtfYc7nnFnjQEwfayhsX3AOyDs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=blOVwuCEHCm018Ln/QnTp39OQZ8uIdggfbDHSVM6aW0pVD0+i8elu9wnCJ71YWaMjX/31wJ9qy53jOHQUJLEFXzOeWB13MnCszApgXKl13b6QdRH9+zF3nHmy52klukdDdd+TErmd9gNIifNg0MCuDKhHgXifdLfcim7y502c6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wudO0rT4; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743336094; x=1743940894; i=markus.elfring@web.de;
	bh=/ESHn4nXeNvwWIGWrCtfYc7nnFnjQEwfayhsX3AOyDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wudO0rT4Aixa0UPD45im1c5awgJR8WZRu8s/SnyjmKbed/WGwS7ES8VmL7Mn0yof
	 nr4B3zmIZTMxpn8K7+3uxz2ekMnHCno6TX2HP2aqFzLdH/o4xltOG1075vvSP/gEm
	 FltI/ziqd1e6f6RiXX+oGQfx4nKuZLPhI3Xrm9gEUPwYuHWT7r8hsJ6r9+HlI9lVL
	 XPemjVslhQ2m31ouMTXBeD3kGCKToDhxImB2QXz294eT5gUL64UoOalGkMHF3opZm
	 T3aQSPM7kBbvbp3oB1yvSE4dWQsVdT/Is13JmgWkvDth0TR/F3baZV4apyOScpuLH
	 plu0bAda9wlZM5xerQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.13]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1tHnNT172L-00jFi1; Sun, 30
 Mar 2025 14:01:34 +0200
Message-ID: <e911f15a-51d5-4741-89ee-b1422dec07ab@web.de>
Date: Sun, 30 Mar 2025 14:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abdun Nihaal <abdun.nihaal@gmail.com>, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Johannes Berg <johannes@sipsolutions.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Erick Archer <erick.archer@outlook.com>,
 "John W. Linville" <linville@tuxdriver.com>, Kalle Valo <kvalo@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20250330103110.44080-1-abdun.nihaal@gmail.com>
Subject: Re: [PATCH v2] wifi: at76c50x: fix use after free access in
 at76_disconnect
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250330103110.44080-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YE/2h1DGVA5MlT7jpl20t2UskcHoOi2G4Kjo+hXSMIOEESdqHvL
 l6xWADl1yEG7Do9oaBtVkCniaVaHECTUb71PSyp1QM77/jPRUu+tL1nmjx0XaAb2t36zy/h
 kfWzZ4K7tpyL0RBynV+ACLl185Gq2v14Lvwf3vqu6OJk8SfuYHyJMR4s0D2/KzKKxa/xoE+
 m9+jXnYuOOS7WQ5kVArpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UWSfTPbmz2c=;DZwjpFZaApIPM5TQ7jLRttmMXwh
 o9YKRbw8Ac6lFegJx/EzNI7ADylL/HYPblxQ26fLlEMiNVWUkj2eEMrDWfe4vRxxOBNeHdhjR
 Vkyr6YCb1mvGjD2+2KGzLQAw6g+SHCx0gAV/n5VcCUSN2Pj0vB7Wh9KeVzj76uSuuxW01xf5X
 9zliJO7Znilz0IL149lVayXfusimerJAGGBbb72sINlJf3fQQpMNX3zB6katlCQpRO+fm+MV7
 +6fjx4CPTygcIpMSaSfSe65iKABrc4I/qEbVy5HuKoC41UpS6Gb80jEmStXPeUdIPQ9MbkCzg
 mwP8DxEFpu/GZoYc6CtWjBj0epLPgSHBnVv8qvn6mOPARQ9PLdcKnIEkdbWs05DhHclkLNYYH
 whpCJFKjrV9fjuPygjZi8tY3UhzsvnX4eocd424K9/xBNQq/4WOdOnjXOBsNJxrnG9FP1DbVT
 WvcAbBpXyDYv/0B75A+FgNCNHgidPh3pLs7nIJCeae6I7TqmyzeBDQvXaGHYNtFO5uHjy/FDG
 +7da7xn7He4e9XLfpsTwUBNwfg+qIHJ+taDBmxLaNfXCPY4OKZoYzFQejAN8eI5JENw97BHh8
 V0vTwBizooixgA9xaeoNODYKVyJl3HmXdp+Y+k2mAUbH8QYOQbjRZgQp37C4vNOFROcXUPDZp
 iv302EGt8YOXE6DZFjTXc/dUcGbKw/VDt624QewsLImrFlpUqHQY+yrfexl0zqQrTMNQ7g/oT
 sbSAvo5O2jIarkVlTYk73AQIX8joIjDk81wEAomhSuvEq9sIN5bjMftPjZ4IQXhzw3Eqx+F8w
 EO33sB3LIacrK/hWesyr//vqoYFRjMf0cpbBGVKaKQq6Ic2duZMmtxNZXI0b56tULJ/0q4lQa
 IWkT6nzrecijXL0dfK4vZzqyZqjSehcjkKHtWOedIGOCj4TiokB6JbGqL6q5KL1LVlbH9waVv
 xfm5KmKRjDJ0wbmhud1q2tBa4MMcbyDi9vWhxQGLwYriE0iI0BI5qW3pyQ7N3Nl5WZtDcDrPv
 XrwFx5e0jrQpWVnZHGd7FMepQT9AQmr3+4JwIW8EeLCeNJfBvOUDbGc6/dzWVkGTZaCS/31FI
 Uew7oJlR9MMmqb56ATVeRHgwOMfsHB4PUKAh1rS6fOWZKYOmMKBSdVsO2CzNVQmDJ+Jneqs+n
 3o52ushMUR0y7QCoK59GxWZa+MmaHyNMsqOBKeok97HaTHYxgf40Qc5YEosPmmFu8mLB5keZH
 NvS+SU+ALZbiI2jBa+XepUd44YIqnMctN75OQQCJDNPQ935P+2/VGarzHIWzz0+aXTx/4SnXA
 9ALj0/O9X9hZszRyZAqcbSS02SXry3vC1Zx0M1SvmHQxpP2kS++xNoYFnP9FMwxjXJ5kresrl
 5zcQEL+pzamut28+pzGCKV7prYJQV24CpHVOLlib09c9+bqC0lGzX5KCzHXAX7MxvBgabRvrs
 OWVuXUcLhfvKZRJ4oGJyqru7bZsnDwgA5Oltxa3b5xiJW570TF5JJ11ddjyvfbwImWpGR/A==

> The memory pointed to by priv is freed at the end of at76_delete_device
> function (using ieee80211_free_hw). But the code then accesses the udev
> field of the freed object to put the USB device. This may also lead to a
> memory leak of the usb device. Fix this by using udev from interface.

Would you like to append parentheses to any function names?

Regards,
Markus

