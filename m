Return-Path: <linux-wireless+bounces-23115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87BABABC1
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 20:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B73BF2EA
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 18:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36E7148830;
	Sat, 17 May 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OX7MW6+Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30944B1E45;
	Sat, 17 May 2025 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747504917; cv=none; b=YFmnmrE/laCqnDflZ8ViYoe6Xt+ANbH2FQnkXccm7t8Xigg4pEzsNCm1rrAKhhR1VBZfe0mT1OEJ4AhTl31H/9qrVYU1MdTVeRj21jGBd8G1lQ8Td0cJotlElI+r54L0OvipOlz3pMrtBz2s4lwdV9IOP28NsimAykz/raTR1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747504917; c=relaxed/simple;
	bh=5aBOsGbdCnxAk09k8KrUvZofVNhHW+rS11IkuXATWpA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=JElhIoInjF/fqyuC8fIblvdSseYgOt5xFOHtYTQZnvtquwZBMI0pNT0GnXNXm8a+OF+dVMIwVmjT53WYo3j0PTwDqzesRJfD57KqKMma9oyYgQWWnQXMh63mwro+hzlrMoirDGWedt+bW5N3uUY4m9GOrYTQu7mbWdxfYrFumic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OX7MW6+Q; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747504890; x=1748109690; i=markus.elfring@web.de;
	bh=SpGz0mgfSy0dGsokb7EQbHYPttCEHqkOkWjC/fsUf04=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OX7MW6+QBZZW2lVeru+HJmDMrmgU2tET/B5GXkWmXHhnZIHzPGrDVv0Gjqwy0Jd5
	 q8qnw20PRgHDwKaUY9zVr8neySHZmvAzGcOpSTz3l7xM1OpaPMQh7EuBDa57lY92s
	 48MB3WOOqNa+Io3qwaV/CE4RjcTbUooXlIOFtAns2RUIgBJ1KtLXnkmbb3gTlR4VA
	 feeOp2va9Wo3iabmuW03ui5Dqr+Et1NQv2M8x6VuEkfgmU7FectftiaZ37UZUe4sU
	 bltFzTEdinxxQepgZSlH1f/DpKibEAi1btaLCeHOMJzqgckU/BVdzeqjr+U8wBAYt
	 lSOqZZWNuTRwjlwO5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnFyI-1uhk2Y0I9k-00k7yM; Sat, 17
 May 2025 20:01:30 +0200
Message-ID: <8debcddc-b788-4ee0-99d4-b9ac28d62df9@web.de>
Date: Sat, 17 May 2025 20:01:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-wireless@vger.kernel.org,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250517154611.910-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] wifi: wilc1000: Handle wilc_sdio_cmd52() failure in
 wilc_sdio_read_init()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250517154611.910-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aDje+Y5p/VRQQNoqQwcR8EeolwyzVYwEevv8AI2mofIQL67z2Dg
 UVFdnfpVkVzM1LoM7nHHDxMNNSKuhZKhPYs5LYowD3xlLrChFuYjBgYGPIPAR7FldgrnHOm
 FRd2FA8Ozf1QWiaSobqPcY5g194LCeb6O1AQUFS+AJ+w63f3G/DopUpzqJeoGRHrn5goeOd
 oBAk57C9SQvUvU/CV7FmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j08uRNsWw4w=;INUoJGRpounDjCuc8mXXkLl4t4C
 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

=E2=80=A6
> Add error handling for wilc_sdio_cmd52(). If wilc_sdio_cmd52() fails,
> log an error message via dev_err().
=E2=80=A6
> ---
>  drivers/net/wireless/microchip/wilc1000/sdio.c | 8 +++++++-
=E2=80=A6

How do you think about to integrate adjustments for two function implement=
ations
by a single patch for better error handling in the affected software modul=
e?

Regards,
Markus

