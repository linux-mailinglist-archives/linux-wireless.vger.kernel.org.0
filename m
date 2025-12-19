Return-Path: <linux-wireless+bounces-29967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596A8CD0EAE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07AE73013EAE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A830148D;
	Fri, 19 Dec 2025 16:35:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA4324B0C;
	Fri, 19 Dec 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766162134; cv=none; b=mB+KO+OlRGG2Q7UO8JapRYkRTeHkXPzTMEUIVZofq07vLh8+kxXHEh5vJxHNnFcH8yb3Gq4YC7c0D5GW94X6cwOAUCCoU0VYfjniWdTo3dp+irQrXJH8BAr6Nnp20Nd5Lkw2aVb4JLWjMN3ufmlQbjZ0ntJOtGH+cKd1EUA88cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766162134; c=relaxed/simple;
	bh=kSwNBP5gPC/GuyOemkxtFQ7hhveIP6mF6ZCIrUcYH+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHSWWC5/4HCZL/g1qRPZR6yQJCYjOBnOB0kqrVKyT4KC5+bI/c+DER69LV+0zVMyzbl5ilVaJP78E0tEJ3aeeEqvAtlCtY8x0BfuV27R4Ukskqi47KbXUgp1Auj/egZJHpprZODSPw3ZdrWk/MFj2OU2m5EXZqQCsgGRIm3be2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=telenor.net; spf=pass smtp.mailfrom=miraculix.mork.no; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=telenor.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 5BJGNl07348315
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 16:23:49 GMT
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 5BJGNl1O3709595
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 17:23:47 +0100
Received: (nullmailer pid 631960 invoked by uid 1000);
	Fri, 19 Dec 2025 16:23:47 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bmork@telenor.net>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: mt76: mt7996: fix mixed FEM check of mt7996
 chipset
In-Reply-To: <20251110120110.193562-1-amadeus@jmu.edu.cn> (Chukun Pan's
	message of "Mon, 10 Nov 2025 20:01:10 +0800")
Organization: Telenor
References: <20251110120110.193562-1-amadeus@jmu.edu.cn>
Date: Fri, 19 Dec 2025 17:23:47 +0100
Message-ID: <87fr96tp7w.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

Chukun Pan <amadeus@jmu.edu.cn> writes:

> To support the following varaint of the mt7996 chipset:
> - tri-band: band0 iFEM and band1/band2 eFEM
>
> We should read band1 for the determination, using band0
> will incorrectly identify it as iFEM.
> This is also the judgment logic of the mt7992 chipset.
>
> This fixes the load error on the Quantum Fiber W1701K:
> mt7996e 0000:01:00.0: eeprom load fail, use default bin
> mt7996e 0000:01:00.0: Message 0012002d (seq 5) timeout
>
> Fixes: e8cb33ad546a ("wifi: mt76: mt7996: add support for more variants")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/init.c
> index 5e95a36b42d1..143400541746 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> @@ -1137,7 +1137,7 @@ static int mt7996_variant_fem_init(struct mt7996_de=
v *dev)
>  		adie_idx =3D (val & MT_PAD_GPIO_ADIE_SINGLE) ? 0 : 1;
>  		adie_comb =3D u32_get_bits(val, MT_PAD_GPIO_ADIE_COMB_7992);
>  	} else {
> -		adie_idx =3D 0;
> +		adie_idx =3D 1;
>  		adie_comb =3D u32_get_bits(val, MT_PAD_GPIO_ADIE_COMB);
>  	}

Thanks for this.  It solves half the puzzle I have.  But unfortunately
it adds new questions too.

I have two closely related devices from Zyxel, where one is supposed to
be iFEM and the other eFEM.  Looking at the eeprom data provided by
Zyxel, it seems that the eFEM device is actually mixed like your
example.  And indeed - your patch makes that device work properly.

The problem is that the patch breaks the other device variant, which
used to work before.  If we assume the eeprom data from Zyxel is
correct, then this variant is iFEM.

I added some debug printk's to mt7996_variant_fem_init() so I could see
what detection data we have.  I read both MT_ADIE_CHIP_ID(0) and
MT_ADIE_CHIP_ID(1) to be able to compare logic input before and after
your patch.

The two devices are almost identical, except for BIT(0) of
MT_ADIE_CHIP_ID(1).

iFEM device, working before, broken after this patch:

 mt7996e 0000:01:00.0: MT_PAD_GPIO=3D0x00008400, adie_comb=3D1
 mt7996e 0000:01:00.0: MT_ADIE_CHIP_ID(0)=3D0x79758a02
 mt7996e 0000:01:00.0: MT_ADIE_CHIP_ID(adie_idx)=3D0x79778a11, adie_idx=3D1

Mixed iFEM/eFEM device, broken before, working after this patch:

 mt7996e 0000:01:00.0: MT_PAD_GPIO=3D0x00008400, adie_comb=3D1
 mt7996e 0000:01:00.0: MT_ADIE_CHIP_ID(0)=3D0x79758a02
 mt7996e 0000:01:00.0: MT_ADIE_CHIP_ID(adie_idx)=3D0x79778a10, adie_idx=3D1

Looking at mt7996_eeprom_variant_valid() I understand that the
MT_EE_WIFI_PA_LNA_CONFIG is given by the two lowest bits of bytes 0x196
and 0x197 for band0 and band1/band2 respectively. 0 for iFEM and 3 for
eFEM.

And the Zyxel provided eeprom on my iFEM device has indeed 0 in the
MT_EE_WIFI_PA_LNA_CONFIG field of both bytes:

 00000190  11 23 24 24 25 24 08 a0  e0 0c 08 08 00 00 00 38

While the mixed iFEM/eFEM device has 0 for band0 and 3 for band1/band2:

 00000190  11 23 24 24 25 24 08 0b  4b 0c 22 22 00 00 80 38


Any idea how this should be fixed?  Is there still something missing in
mt7996_variant_fem_init()? Is the ADIE chip id difference significant
here?  Or is there something wrong with the devices/eeproms I have?



Bj=C3=B8rn


