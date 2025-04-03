Return-Path: <linux-wireless+bounces-21123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC00A7A0B9
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 12:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE01898007
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA024503F;
	Thu,  3 Apr 2025 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RvXf/cnK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910513C67C;
	Thu,  3 Apr 2025 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675237; cv=none; b=d6hvjFAiJ8ycvW6xx4xzrcQzbACXLDgdI3Ps2YJXe0BLhCM3zjNm8L/ZWYWCCOojxqrLIxHhy48gfFMchf00AtM9xbNt8ZripGV2G/oJ5ET6dhW6omoqYoTgf0UEukOiBK7yYcC5seHXoH81HDN2jA9dWTFPxnJHEvt8oR9HUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675237; c=relaxed/simple;
	bh=iZfe9IKc/fwgyE69mtiki9lj76GS0qFqCnTdfkVXFfU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ue4se0wM3aHcetGAOnOxIpm2r3R82m1rl2+LO0N5Swwb6sdvGvlbavJX+zNlI6H2S9yhcpkv+PRjvAlwFeKDpYXQJZkQWpeGVBXVNs2MNScK0lYImStzzmFAt/hxQ+DDzow+xFY6CVoA+9VD2dEl7B4M7u54OeJrNEiwPyK/PP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RvXf/cnK; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743675213; x=1744280013; i=markus.elfring@web.de;
	bh=CARrPYNC+39nu2aCcF5f+6rCXN+MipGAP0Rp28eM2S8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RvXf/cnK4bKjLf+iiCwbERJtPdoEvch2sZiwMwLxp1yaey4Lnbm2xmShYZIXpgRj
	 SXeDrauR7IyfW4jwpUAGiLERFE1IOYHEn9VhiZJ0Duxt2bV7vUtk1FGV4m0OM/RuU
	 mWNMtRqMcf3MZAqM5YROzC8hBOOvrEUTqoOWKGEGmwNc1Q2ktRacY/s9cszx42dQz
	 LOWQVcX6BVRZFw+MFajHK9fnSxZ9+ZlXLbSVtYH3UDQIJwDCw/oLuvOmhyI1WDH1A
	 yUaOzNI1MvxH8gorkBVlKowACVhzWKuuSVx8gvv0Gbd9BHeGW8cPlAS/6T1reIe0i
	 Uc/LCL8s0C9ZuRbcFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.50]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1ts2Ff2PrK-009QNs; Thu, 03
 Apr 2025 12:13:33 +0200
Message-ID: <db778d8c-0a56-4b01-b5b5-5610a68a4875@web.de>
Date: Thu, 3 Apr 2025 12:13:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rex Lu <rex.lu@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Shengyu Qu <wiagn233@outlook.com>
References: <20250403064344.64253-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: Fix null-ptr-deref in
 mt7996_mmio_wed_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250403064344.64253-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FOtUCR65RPzrUtKtMJyZcNJ7HmqKEyao5W6mjn8SRcQgnfwYEcy
 Vo9lS/Mm9+uxpZGS1jxjpgrm/Lwx8EDmB6Epp1Y7Da9+NUjuBH+Z+SJ6VV2MadoSvhaZeif
 040QMrQ9MFViVVPr/MuinG5f9ckItH7tO/YX3R5jQXIYkaESsA/mNxMIrtZ0dTWhGmyPFiK
 /p7IWI3WNtszVi0Su5vIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uDjs4CvjV+I=;wmRCD8VloVebfGs1/wtaZa1Jy7L
 0VFTlya2kWdcaD8Dj8w/1Izj7gU2p5NAt+6lSZwpAXX9c6GiFlqs8Y5oT3C7h/CiVsDql9dgC
 lC5MmkYneB9E+orqTvaD29PoVqW493rJuft8/RHN49vxnDqKWw/61M081skmmgUbw7mieFh+i
 St4zsIRVxZBJLLOAkAHeNcSGhNMmPthKuRi7eUsbL/+ekADDqzRcn0gbyVJPBZkHcQ2t3hO6K
 r/OKZohys6m64AQFRDa4bARf1cR2Mb1G0j6wYJ7Gp6itDKB/eZaxwcRcBlnHZHEZeSChrTg7U
 QVgcQX/E1IaQS5P94/cJ4AH6iUhy3U58hvQLdPd4Bvh0tAK9deJDHzxAbnAxasC5dnP66FUMS
 rBYiZh+zlTOm3hkafqSPVk3S+rLM1EsRKW2mthCxB+ufYsOeawCLt6avyXpfPxjrcPmjyWlMO
 2wWO8lZ8RTre1+nFr7hXlywiD1ysAIHzL7yXft7cqaby4GhFnLG4JY4JAt8bbeEJMrAo0R8xn
 3xQuEaN+ITaoYcMALPFtAL752WQWr+gEKFXAXbHpK6ExpevEvltn2pXtGHt+JrI5lFhX/oBo7
 g7+Vs6Q4GxbIwsS7+E6/q4CYIM/zJCFsIXoyt223uW0h5XZJVBl0Ad/dLtgT6MKCpkR7bUqmN
 reAz0sqQXuFeWHCdfz+EUk4synUvwhbppfRPFmeQu+i09fUE9ZX7UYnWZTRqbRIHqDlG4h6Gn
 23YKEec49x80SoMQIW7K+WSMgx3qaJhAPph9vW+i1kVkPJbZAurBE3Etk42YUrylWm2lgqFaS
 9ceLCntgFQWN4tDZ5xQ/lTHftXNV64H2ZYmzk6IMw/PZHYQ1AOEkyFDdQxiglOjulBXzketsx
 vdms2/H0fz1QwG8gEKoxmrDSi9jVUrIK0c19K8V7YPUWo0F6Wl49/WSvBb1YxrrFuXdxM18HC
 f5Xx4Wk6O+HVt/JlbvbEHYck5Vz6cVxBdfOvJAMQvHljfKXu/ONrmXruxMLIRwYrAJESZPXl1
 aF+zmfty7/riduIL+Ao8QJV8tXatzPeiCsJ+/fYdvhF3UOg9hmDjbTNUUHb2UXPHbsrW12ocj
 7Kp0C5huZMPnznzPUUQreQMW7eOanw1F9UlhbjDwGRtOVZJKB6q3K+nbjm2vn2sivkO81O9o8
 E/Enofk/+b3xjvhq0nSUBP5iW/JX9sjMFMCFZ8EIcF7cFoe64vGCB6aIgPQjCDRNbfa3Q9I43
 +iaeDaRDorYMbp4z+39bSwVRLpiBElEEAtXnKsZ0HSXtqDNRF38JpuTU7Ei3wd+hBXdyhpxpn
 zHs0AyGN8jX+m/J06rNbPNcW/4r1wluIMFHGoNl2uhuzvpjh6R0cvyMUbZ4PsIlSLXdMLv1xT
 6NgfEKEf6mAFT8DZO8VuqzPkkqLapDW1pClSq9F4UT2wlnaLq19wV+nVbwIkhS401io4qDtqw
 gdDOIGj9nmTsphSflT1GKud+KzdbTGSgUhqFW/+Dtz4tMdGzSF//xhGuyxnyz1psq8Yh3fA==

=E2=80=A6
> Add NULL check after devm_ioremap() to prevent this issue.

Can a summary phrase like =E2=80=9CPrevent null pointer dereference in mt7=
996_mmio_wed_init()=E2=80=9D
be a bit nicer?


=E2=80=A6
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
> @@ -323,6 +323,8 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, voi=
d *pdev_ptr,
>  	wed->wlan.base =3D devm_ioremap(dev->mt76.dev,
>  				      pci_resource_start(pci_dev, 0),
>  				      pci_resource_len(pci_dev, 0));
> +	if (!wed->wlan.base)
> +		return -ENOMEM;

Can a blank line be desirable after such a statement?

Regards,
Markus

