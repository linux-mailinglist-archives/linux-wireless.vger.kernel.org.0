Return-Path: <linux-wireless+bounces-20095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A0A589B3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 01:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E6C169DBA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 00:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1851BC3F;
	Mon, 10 Mar 2025 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jVzJU6wj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF04D2FB;
	Mon, 10 Mar 2025 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741567019; cv=none; b=H7K59h3Y3rpRRBtrmTxiXWou1jfSyuFFatAhIzYxz/IBYmJ4Y0e4jfbWKClERQWNrpyG819ClaciV0VL0WDCXMZDXL5uAhVO3gWqgUwViZeEsxEn6WNeQLs8KAb97kWv0tcmOi9vzbu6hMhlQzoF/dMxIUUWWDX1veysm0DLsAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741567019; c=relaxed/simple;
	bh=4h1t9rN4ICMWhjBR/mCrdznTowjXzA9D5KrBreqnjN8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QzzvgJjGFb7+3Bgd64I6ATlDvCSx9S0WqQuEk+2RQDPTvjHWNWmxTP8Id39Y1yLHPL98824AvoH7rRrEZQDxl2iHAoOumiKk/grOHxf9Pzq9Ze1Ox7ZgTeQ8NiP7HfTEkQuhWYuWPml+sRfPOZT+Va4DQPvCrCapEL5olM8ot/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jVzJU6wj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52A0X9axC2169990, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741566789; bh=4h1t9rN4ICMWhjBR/mCrdznTowjXzA9D5KrBreqnjN8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jVzJU6wjtNydKyYe0mZj7EChudlvOaFqZDGY6mI5DpgLA2NfS1tMRnktXBeXVEkEU
	 0W4K15+myTRgA74H4poeQilm05D6x3GJmW2c/36nlWcTarsgxzmENhSHMpYDl8yVQN
	 RwCnv/Xze6oVQmZCel14Z1x0INWzPVnQkGEMNzGQHVrnvjd+7gfihYgeg90NKEBXst
	 inN8VbDWWA5QwA9ct0WHjnmTJL6CqvxC+FDIdmqF/HNtK9LQKinYJjtK6srZX+dgr2
	 H57opsnwqzmdpJGkMME8H7CoUzj+wljC0ZXQ8Tj40lQRT2eJhtI0CYdnrFj8RXRFwb
	 BYhUl6iOFLwlQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52A0X9axC2169990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 08:33:09 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Mar 2025 08:33:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Mar 2025 08:33:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 10 Mar 2025 08:33:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shengyu Qu <wiagn233@outlook.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "ryder.lee@mediatek.com"
	<ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>,
        "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
        "howard-yh.hsu@mediatek.com" <howard-yh.hsu@mediatek.com>,
        "greearb@candelatech.com" <greearb@candelatech.com>,
        "chui-hao.chiu@mediatek.com" <chui-hao.chiu@mediatek.com>,
        "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
        "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>,
        "sujuan.chen@mediatek.com"
	<sujuan.chen@mediatek.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "bo.jiao@mediatek.com" <bo.jiao@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v9 RESEND] wifi: mt76: mt7915: add wds support when wed is enabled
Thread-Topic: [PATCH v9 RESEND] wifi: mt76: mt7915: add wds support when wed
 is enabled
Thread-Index: AQHbkD+97GjFG0DhG0q+h/KT1ZUhfbNrhPNA
Date: Mon, 10 Mar 2025 00:33:08 +0000
Message-ID: <b6b52bfcdb614137ac63fddfdaf9cb97@realtek.com>
References: <TYCPR01MB84376C7074C566865654F05098D42@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB84376C7074C566865654F05098D42@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Shengyu Qu <wiagn233@outlook.com> wrote:
> @@ -1280,6 +1292,34 @@ static void mt7915_sta_set_4addr(struct ieee80211_=
hw *hw,
>         if (!msta->wcid.sta)
>                 return;
>=20
> +       if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
> +           !is_mt7915(&dev->mt76) &&
> +           (msta->wcid.idx < min || msta->wcid.idx > max - 1)) {
> +               pre_sta =3D kmemdup(sta, sizeof(*sta) + sizeof(*msta), GF=
P_KERNEL | __GFP_ZERO);

Need to check if pre_sta !=3D NULL before using.=20

> +               pre_msta =3D (struct mt7915_sta *)pre_sta->drv_priv;
> +
> +               flags =3D test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags)=
 ?
> +                       MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
> +
> +               tmp_idx =3D __mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915=
_WTBL_STA, flags);
> +               if (tmp_idx =3D=3D -1)

At other places, it checks this by 'idx < 0'.=20

> +                       goto error;
> +               pre_msta->wcid.idx =3D (u16)tmp_idx;
> +               mt7915_mac_sta_add(&dev->mt76, vif, pre_sta);
> +               rcu_assign_pointer(dev->mt76.wcid[tmp_idx], &msta->wcid);
> +
> +               tmp_idx =3D msta->wcid.idx;
> +               msta->wcid.idx =3D pre_msta->wcid.idx;
> +               pre_msta->wcid.idx =3D (u16)tmp_idx;
> +               rcu_assign_pointer(dev->mt76.wcid[tmp_idx], NULL);
> +
> +               synchronize_rcu();
> +               mt7915_mac_sta_remove(&dev->mt76, vif, pre_sta);
> +
> +error:
> +               kfree(pre_sta);
> +       }
> +
>         mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
>  }
>=20

[...]

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 9d790f234e82..32c5aa1a361e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2385,10 +2385,20 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *d=
ev)
>=20
>         mt76_connac_mcu_del_wtbl_all(&dev->mt76);
>=20
> -       if ((mtk_wed_device_active(&dev->mt76.mmio.wed) &&
> -            is_mt7915(&dev->mt76)) ||
> -           !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
> -               mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0=
, 0);
> +#ifdef CONFIG_NET_MEDIATEK_SOC_WED

if (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) ... ?

> +       if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
> +               if (is_mt7915(&dev->mt76) ||
> +                   !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
> +                       ret =3D mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(C=
APABILITY),
> +                                               0, 0, 0);
> +               else
> +                       ret =3D mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(S=
ET),
> +                                               MCU_WA_PARAM_WED_VERSION,
> +                                               dev->mt76.mmio.wed.rev_id=
, 0);
> +               if (ret)
> +                       return ret;
> +       }
> +#endif
>=20
>         ret =3D mt7915_mcu_set_mwds(dev, 1);
>         if (ret)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> index 49476a4182fd..c3dd0cb4a5d3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> @@ -278,6 +278,7 @@ enum {
>         MCU_WA_PARAM_PDMA_RX =3D 0x04,
>         MCU_WA_PARAM_CPU_UTIL =3D 0x0b,
>         MCU_WA_PARAM_RED =3D 0x0e,
> +       MCU_WA_PARAM_WED_VERSION =3D 0x32,
>         MCU_WA_PARAM_RED_SETTING =3D 0x40,
>  };
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wire=
less/mediatek/mt76/util.c
> index 95b3dc96e4c4..7fac9c79ebdf 100644
> --- a/drivers/net/wireless/mediatek/mt76/util.c
> +++ b/drivers/net/wireless/mediatek/mt76/util.c
> @@ -42,9 +42,11 @@ bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offs=
et, u32 mask, u32 val,
>  }
>  EXPORT_SYMBOL_GPL(____mt76_poll_msec);
>=20
> -int mt76_wcid_alloc(u32 *mask, int size)
> +int __mt76_wcid_alloc(u32 *mask, int size, u8 flag)
>  {
>         int i, idx =3D 0, cur;
> +       int min =3D MT76_WED_WDS_MIN;
> +       int max =3D MT76_WED_WDS_MAX;

In reverse X'mas tree order?

>=20
>         for (i =3D 0; i < DIV_ROUND_UP(size, 32); i++) {
>                 idx =3D ffs(~mask[i]);
> @@ -53,16 +55,45 @@ int mt76_wcid_alloc(u32 *mask, int size)
>=20
>                 idx--;
>                 cur =3D i * 32 + idx;
> -               if (cur >=3D size)
> +
> +               switch (flag) {
> +               case MT76_WED_ACTIVE:
> +                       if (cur >=3D min && cur < max)
> +                               continue;
> +
> +                       if (cur >=3D size) {
> +                               u32 end =3D max - min - 1;
> +
> +                               i =3D min / 32;
> +                               idx =3D ffs(~mask[i] & GENMASK(end, 0));
> +                               if (!idx)
> +                                       goto error;
> +                               idx--;
> +                               cur =3D min + idx;
> +                       }
> +
>                         break;
> +               case MT76_WED_WDS_ACTIVE:
> +                       if (cur < min)
> +                               continue;
> +                       if (cur >=3D max)
> +                               goto error;
> +
> +                       break;
> +               default:
> +                       if (cur >=3D size)
> +                               goto error;
> +                       break;
> +               }
>=20
>                 mask[i] |=3D BIT(idx);
>                 return cur;
>         }
>=20
> +error:
>         return -1;
>  }
> -EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
> +EXPORT_SYMBOL_GPL(__mt76_wcid_alloc);
>=20
>  int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx)
>  {
> diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wire=
less/mediatek/mt76/util.h
> index 260965dde94c..99b7263c0a20 100644
> --- a/drivers/net/wireless/mediatek/mt76/util.h
> +++ b/drivers/net/wireless/mediatek/mt76/util.h
> @@ -27,7 +27,12 @@ enum {
>  #define MT76_INCR(_var, _size) \
>         (_var =3D (((_var) + 1) % (_size)))
>=20
> -int mt76_wcid_alloc(u32 *mask, int size);
> +int __mt76_wcid_alloc(u32 *mask, int size, u8 flags);
> +
> +static inline int mt76_wcid_alloc(u32 *mask, int size)
> +{
> +       return __mt76_wcid_alloc(mask, size, 0);

return __mt76_wcid_alloc(mask, size, MT76_WED_DEFAULT); ?

> +}
>=20
>  static inline void
>  mt76_wcid_mask_set(u32 *mask, int idx)
> --
> 2.48.1


