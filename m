Return-Path: <linux-wireless+bounces-14852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC69BAA02
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 01:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAF01C20A54
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 00:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C5D17C;
	Mon,  4 Nov 2024 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Dzzl/CjW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EAD79C0
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730680664; cv=none; b=OjOIlvZNDa4Yy1hv7AEme50KTsV2fuojrTaoP0k3QCKzU9d7O4qyqCQOpwvLxtLkJggrE6UIL7EmxlxCpHd1kWOGvb2EtJ73CpsqJrnPvN/U96IU+8RVF35g9R3iE5Kz/Io9Mqiq5hSGOgsHzADNVg4rDDlthGFfUW28C+XBS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730680664; c=relaxed/simple;
	bh=yS5Dhg/ytutgNmvl+bvPCW9LKLWg/cM4lM4PpjgM68E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WemLi/1H/d/r6SnMiipRAiH/hG8enrQQvwwN0taYLKECcAnqWsTNVQ5D57COE++AVX5CGC6tVbprpzAIU7Fbi1oSx+xIj+wt7Q5MyNrbrSq6Sy1Q4nro3kMIg9SiSKvNyR6MS+exHQJXamThW36eJJEkyPhFklc/I38ljDbAm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Dzzl/CjW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A40aieA72562100, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730680604; bh=yS5Dhg/ytutgNmvl+bvPCW9LKLWg/cM4lM4PpjgM68E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Dzzl/CjWCDQ1ZR8DksNnEVa+Y5Ky3wKjfaIZ5a8KEQJtXi3UyvD/Z3i0Iao4Tp2lP
	 0ewipUF44OrvaTGuDNuxChBmnUEfUEMQxmV+Ycp5BVNqA+YtqLfeTviLq8ffINd1ti
	 CWW3HJXd0ha9UifQvl0uYyt4ZziCAsOl7VxMN0ucvThaVkDMbn2eboA3MxNXUbdiX+
	 YJlSTo77pFuJQ9ZXK2Dh3hgbeROM7rqnA7RJ9xvgW1aBLekU8SRp9exJZrxOLUIhTt
	 gw1Ns6/N+lv+FaUfq2f6t/gjKLKPXViwlyxVDlbEmxt5AoDQLWk97CViVSbvH/XOui
	 pUR1WxTnG2URg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A40aieA72562100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 08:36:44 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 08:36:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Nov 2024 08:36:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 4 Nov 2024 08:36:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "Sean.Wang@mediatek.com"
	<Sean.Wang@mediatek.com>,
        "Soul.Huang@mediatek.com"
	<Soul.Huang@mediatek.com>,
        "Leon.Yen@mediatek.com" <Leon.Yen@mediatek.com>,
        "Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
        "Eric-SY.Chang@mediatek.com" <Eric-SY.Chang@mediatek.com>,
        "km.lin@mediatek.com" <km.lin@mediatek.com>,
        "robin.chiu@mediatek.com"
	<robin.chiu@mediatek.com>,
        "ch.yeh@mediatek.com" <ch.yeh@mediatek.com>,
        "posh.sun@mediatek.com" <posh.sun@mediatek.com>,
        "Quan.Zhou@mediatek.com"
	<Quan.Zhou@mediatek.com>,
        "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>,
        "Shayne.Chen@mediatek.com" <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH] wifi: mt76: mt7925: fix get wrong chip cap from incorrect pointer
Thread-Topic: [PATCH] wifi: mt76: mt7925: fix get wrong chip cap from
 incorrect pointer
Thread-Index: AQHbLDX0jMThJqBg2Um9khMS5zKJGLKmSMqg
Date: Mon, 4 Nov 2024 00:36:44 +0000
Message-ID: <db0ce439afcf434abafeaf03de31ddee@realtek.com>
References: <20241101081249.27834-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20241101081249.27834-1-mingyen.hsieh@mediatek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Mingyen Hsieh <mingyen.hsieh@mediatek.com> wrote:
>=20
> Use tlv instead of skb, because using skb will get invalid data
> with wrong offset.
>=20
> Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware =
supports it")
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> index 0c2a2337c313..9b6aff463063 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -823,7 +823,7 @@ mt7925_mcu_get_nic_capability(struct mt792x_dev *dev)
>                         mt7925_mcu_parse_phy_cap(dev, tlv->data);
>                         break;
>                 case MT_NIC_CAP_CHIP_CAP:
> -                       memcpy(&dev->phy.chip_cap, (void *)skb->data, siz=
eof(u64));
> +                       memcpy(&dev->phy.chip_cap, (void *)tlv->data, siz=
eof(u64));

chip_cap is u64 in CPU order, and tlv->data coming from firmware should be=
=20
little-endian order. So using le64_to_cpu() might be more suitable:=20

dev->phy.chip_cap =3D le64_to_cpu((__le64 *)tlv->data);


>                         break;
>                 case MT_NIC_CAP_EML_CAP:
>                         mt7925_mcu_parse_eml_cap(dev, tlv->data);
> --
> 2.45.2
>=20


