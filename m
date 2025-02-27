Return-Path: <linux-wireless+bounces-19505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED8BA47053
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 01:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30C316E00A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 00:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C55270042;
	Thu, 27 Feb 2025 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGT1pBfL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB76E545
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616575; cv=none; b=ioQbF3xEEjRVCjZPihvz5+vqy0s7t4+xIoxCBkGpNyQ2o0OHeodPi5YjAZ4MCjIYaGT1rqS3PabLBPDBebg+HeJte0PkN17nxXmwFTp9yQCic1hM3s30W/hi9L/08w1xtQpyDpDRd3MtNsnrwHws4+AMqIhOw61BLf+uiNwZ8uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616575; c=relaxed/simple;
	bh=qrrfvJEfB3aTKM488wYcHln6UNo3BaeE4/DyKezwzwg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dLpzk46i2im5GsraK588Tpwve23oo7c1KAt2Ayicqlf1v3E0K2DdGyAROMjWXzrmQJ6C1Pp3xpQJ3xaoC47wPsVSxhe7lEP3Vtmd+5w9OW6q61rRcwno3vRP+UUSmzIvHKqLMu7K8zvZDe4lgjDBbNOaqc6HNRt92+sz42xSOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGT1pBfL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec61d0f65so66511166b.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740616572; x=1741221372; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jshC1WgvKeS/X/xxAqOcynD+UIW2oEfxfloI6izBUD8=;
        b=NGT1pBfLY2MIocLFuzCgzV2pG0a0aFRRPhlNggQJkF283aX+GCuK029ewMmwl+HiUP
         Bycf6dyYt0U2+3VKqd/of4I472KRCQT1LZ2Rj+Og62QGCcXO9d8rv24J1r/B9FFgnyJb
         vv7CVmHBPaXEwHhH1CwsSsrS22IIF6boTPH8AFkhsSjpBB1jzwuvCDbrFfSp7tBGs90S
         9BqyTivhuArqyN+t2zmrjpb6BmtVY74GehxQ956viTJwDPK8d0XzdK+uP0tKGRcG2Ut5
         en/IEcKpmTgPRR1PrXSK07Eyyt/kERcfRWXmpd2Z0Dq+P8XxhDTIg3HUKnwHP8tftnOZ
         sy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616572; x=1741221372;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jshC1WgvKeS/X/xxAqOcynD+UIW2oEfxfloI6izBUD8=;
        b=HlwIbnnlTLkSS8njInBk/6td2sRO4kg7U76x2U3gQKRKxbt+v3aafl3khGJffV3UFJ
         CGU4Pbke8BBhTzhzxfMZ+c2mP2iaVOWkT5IcSOMCW1Q8l7fIgCHsciDTNkG9XZK7pj/t
         nGvmRFtGGnzV2buNz7ub2QZYHp7ZU6OLQlYamEF3yRV/um9hgdgPz3wunbQ51WsGb45a
         ertKK1ciX0AZ9camMvTR4D+u8UnOJzDnT7PDhq2mwGWLjotu7dIi9ZowgF3qNnyIbqJy
         TG5I8y+xe3QGPJp/P+QzhSI1YSRfygh59LTHQKScUcjNBgzpAKoJBzU2/I3ghpv0Vo1Q
         RTtA==
X-Gm-Message-State: AOJu0YzDZyUTZ0tMYuhJtu8MYspNb8J5V3QpupKTO2d26br9UmTEPPwc
	327YtXvCgxakA7M9TZAx+Am39X6Y1sSHWl7HoFy0UygXROim6Mbm58JUWQ==
X-Gm-Gg: ASbGncvvNaYLksqdSqwBif8y3pMd/80vOK+KkI8rUyPVNC1IdwIfUNwsEB0hShj8Llb
	nHrEgVNwXCBMqsQ1S5pi8ZamIy5xX0YeaeSC5/hxlfg3TJxUXhC/BFEAZCPs5L5CiaagF24epAY
	dddtb/Kr/yCDFdVZs6XIXAx5/hqDu6hoTXPAJUI2UsJN19nMrQVK9MysfyMtUwduNugPcU+cZWv
	Lul3zxDHAE/XrN1YMDLN8VLyNLhSwUcAnMFBi9ei6BvQfmUlElCItWw1CsoA/9I7PGMRHt4E73S
	PSDP8R4F+XpiyOzUIIHn5YrC24Nqs1d//mU=
X-Google-Smtp-Source: AGHT+IE5/yw36k+Hk2trOVAAb1OQDR+qTx4DVHDX/beEQD2FzLT2njIobxF8pKDpzmrR2THXIdaM6g==
X-Received: by 2002:a17:907:7fa6:b0:abe:c8ff:32a7 with SMTP id a640c23a62f3a-abed0db724fmr1157883566b.31.1740616571820;
        Wed, 26 Feb 2025 16:36:11 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0fca3dsm28969766b.77.2025.02.26.16.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:36:10 -0800 (PST)
Message-ID: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
Date: Thu, 27 Feb 2025 02:36:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 0/7] Add support for RTL8814AE and RTL8814AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These patches add 3 new modules: rtw88_8814au for USB devices,
rtw88_8814ae for PCI devices, and rtw88_8814a which has all the logic
for both.

Originally it was supposed to be only RTL8814AU. Recently I realised
that RTL8814AE can be supported too with minimal effort, so here it is,
just one extra file and a few lines in rtw8814a.{c,h}.

Another set of patches will improve performance a bit.

Bitterblue Smith (7):
  wifi: rtw88: Add some definitions for RTL8814AU
  wifi: rtw88: Add rtw8814a_table.c (part 1/2)
  wifi: rtw88: Add rtw8814a_table.c (part 2/2)
  wifi: rtw88: Add rtw8814a.{c,h}
  wifi: rtw88: Add rtw8814ae.c
  wifi: rtw88: Add rtw8814au.c
  wifi: rtw88: Enable the new RTL8814AE/RTL8814AU drivers

 drivers/net/wireless/realtek/rtw88/Kconfig    |    25 +
 drivers/net/wireless/realtek/rtw88/Makefile   |     9 +
 drivers/net/wireless/realtek/rtw88/reg.h      |    45 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c |  2251 ++
 drivers/net/wireless/realtek/rtw88/rtw8814a.h |    64 +
 .../wireless/realtek/rtw88/rtw8814a_table.c   | 23930 ++++++++++++++++
 .../wireless/realtek/rtw88/rtw8814a_table.h   |    40 +
 .../net/wireless/realtek/rtw88/rtw8814ae.c    |    31 +
 .../net/wireless/realtek/rtw88/rtw8814au.c    |    54 +
 9 files changed, 26445 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814ae.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814au.c


base-commit: c61da149b9c2e439abe27845a71dae5ce5f5985c
prerequisite-patch-id: cbbeefd71b59d1fcea72cda22b1eb0e62b40a751
prerequisite-patch-id: 18beb866f984f1ed6769d95b3ab7894d75b3e7d1
prerequisite-patch-id: e1e0ceb709fe71d6c48e063768698c78558f11c0
prerequisite-patch-id: 17ec15a2287ce8766e35b1113fd043d25ebba9ed
prerequisite-patch-id: 36ff8f0da543fbc931db6cad60d8512dba82ecd0
prerequisite-patch-id: 0b5c2a854227b26491421be28b9348e098195881
prerequisite-patch-id: aef15a0990448c435356fe7631ddafbf35606731
prerequisite-patch-id: 56dda569e509fef7403a02d4700b22f27301ea37
prerequisite-patch-id: 0cc73f75273b064d6e8783b8ac4ed06a1025ced2
prerequisite-patch-id: 04fd029f6ae8a5f3d944ecb4c959e55d2599dd87
prerequisite-patch-id: fd5c77b6933048355029ecbcdaf3107183c26aba
prerequisite-patch-id: 6f50c5e526f96008b795477ce97e3c75845f113f
prerequisite-patch-id: 6d85bbc95c0eec75de67992a176907afa1fdbd4e
prerequisite-patch-id: 1e4fd27474a3622807b7fe5bfd3a5a09261fba46
prerequisite-patch-id: a762f356fc162e29375af231beedfc06dc3a4fc2
prerequisite-patch-id: 1c68d0186aabcd2c7ae21b605288aaa872651307
prerequisite-patch-id: b0c4ae910737add0d3068aa92efa265d11dd66e4
prerequisite-patch-id: 5b58a4a0870850a6768eca1a2e9d1523dfdeae84
-- 
2.48.1


