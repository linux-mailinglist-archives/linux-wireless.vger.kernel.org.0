Return-Path: <linux-wireless+bounces-13069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44097DD03
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 14:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AFE1F21B21
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926B1E49F;
	Sat, 21 Sep 2024 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MdsUFmxQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1015E97;
	Sat, 21 Sep 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726920064; cv=none; b=K3qkng4rVYJJTiYV+yI40aAldPf0z0WQsIdXLIwnLs6gEDgKVRMcNDiaJEaLLqqdPEEpsRdU56X0WnJCrndgLmT2LnylPo3s4Lw4s6YvH85dpg12X56gplVu9pPweymsUHEhNmXz4NwMAHmgXOXacirB1mmkqDNSyqzrSM6edjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726920064; c=relaxed/simple;
	bh=8QTHG8jxUhGVDFlIspvQ15r0RW8cCkaBmB0+zHq1Uf8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pn5sTcXQwrWNxSxMXT6ATxZsixxbp3WAkNZcpmozHzzh1uTboNV6mnDxHiimMTENqWcfZWI1TpV+pW7LFeP4mzYBP/nyAQ5ThMhzYCz6VX9RP2IYgB+Gok95EV2n54416aLIt+Y0LTpPkaAgswkzfnjtRnnfgHW8FOtFbpYpDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MdsUFmxQ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726920028; x=1727524828; i=markus.elfring@web.de;
	bh=JL/4ckLfitYF+pRt2eRaZg8quX2Y5roO5htoFv4Za5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MdsUFmxQIwi24aIRGvzHxQmeyd2kbndS3tVGeeQ8rdSMAvA4GhsGQmAqIpB6T/ro
	 BuuyO0Ft38fQMS9uzp3GU9SXqdXO42sn7S3Yo0v3xfd3CCcrSbMiohXK7Xupa8BIK
	 1yr3dxqGgRGIwkiNL8HaMt3ONc+M63jyPHXDoGZ6gA6pnjz9Ch/QUcBlE8S/XnsPW
	 7nM2iLz9AjswqZHOwoSrASYpqNMd8TBCX5z2iNiXtoO6z6klBnPiBAY+cESvuKlOK
	 U6OOQoov99POuoiXoKtAPONhArSPtewbH1feuJU17zvEGAIwv+g6ofzklMVv+GIkD
	 TBQ2/th1E70YguK6oA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1srQp42I3G-00GWEi; Sat, 21
 Sep 2024 14:00:28 +0200
Message-ID: <d5a19bb5-f940-4f07-9f98-c670d96cc839@web.de>
Date: Sat, 21 Sep 2024 14:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, James Minor <james.minor@ni.com>,
 Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Steve deRosier <steve.derosier@lairdtech.com>,
 Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] ath6kl: Adjustments for ath6kl_sdio_power_on()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4l7fWbY10L+DahbXYsA8l9XHwHGUdt+CoPhEr4Y5zc3171WD6d2
 tNU6muIuuqKQRw3MTH9W4W74GNvdCipLUKvckwlLY9rguyI1wTQn8Yp/ZlEB1f4/YsqdOsQ
 iqMMKtV74QAYpk3pNQW1DyS5MZz20abndVp6SIAp0BiZJieHg+T+mlLMDhnLqyDuxb8TpB4
 t0GWs41oAfprerzUzuecA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d3bEMTh4P/w=;ZM4/63AimS9cPPOTQwWFSebQdXz
 ATK1HhowpD5abb237ZdCpfLIRXtrD1NTaHHtELECbuv474xe1o6yxC8yHMqRHQWJVvSFEw0XY
 KbreDuMGh+3/A/9Mlyc1BsSImaAPxwTj1Jyf43to+eVSbdBd940AZRDk88ch+8cZmiibvuBbQ
 b/BLa4pGCSbCGx/kWtv3V2EIyTGmGeUbHk28RNLUMErluXyqmnBDJU9x7CDNQUlSOqhbvrgpu
 jOAIP/RaDyvAfdy7AtiIM2wkia9aquGnsyegR57UfL9cMNHA7KcF8dA1cPVm2A1Bz8xRXYMGY
 HNayDT1mNxQA3kcmym6SrRgkxxFusCq2VTZYmqaveZCizNbIPt21+Jcv5uNWA3j7+cpMDsnDB
 awB2+NNYGAxtlErVgQP1dvPuxge8g3IF/CXwaifmOfkj6yopofr3nvFVJNvK83AdyGlkHjps+
 f1ZLMbLMhPCnQlszYzQcuF4TqsOGihoiAeN0sTkkLQRRCnF+MXSUhxTr5AKX5wROmMUWiSWoM
 gmzwjd6vNq0Z6+YaX6VYMYHg+0g5M6k3XaN4U9MDK0/bbtDc2csTkveQ1UhntBU9+vkwtwPSF
 vBKwBlX/iOB6GlTg81nqxhRuP1XmuWhyTwwfoxBnjO82ha7bRpGwW2vRDxvSHK55IC5LqUskt
 lzXhCmAATMl+Inli99BDlp4a2CH3OcuAhtHyJBuNKMhEvqKu12OPqF378fMlG6eDSP/tbSHh/
 8v+km7nbxfJ/tcyz2Ikay34puEkWzipkmwr/7bkDMvrFzBaUUkueqRXGQdTmZLVhgE8orkORv
 m3++YU3BnMxNib3Me5s2FWJw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2024 13:43:21 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use sdio_release_host(func) call only once
  Omit a label
  Reduce scopes for two variables

 drivers/net/wireless/ath/ath6kl/sdio.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

=2D-
2.46.0


