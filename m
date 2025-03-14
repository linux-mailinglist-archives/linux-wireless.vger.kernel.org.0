Return-Path: <linux-wireless+bounces-20360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A8A6069C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 01:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67E7460551
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 00:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC65228;
	Fri, 14 Mar 2025 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Mvjr3659"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2710420ED;
	Fri, 14 Mar 2025 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741912766; cv=none; b=NznUQpwEyMQvb01YIA+2BGDlxX+tfv+Zv6ofNy27Au83F9hgYNovPpKeooJ88M0laTpvHdpTQZn7nA5g0qoWxD1EYoWwh3wk69+Jnur5kdvoDgdQYQfam8vs/vHj+fLOzaY5ZmKmY0q1JquU/gGiZcK6O6IrgRjqkff5vA7enRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741912766; c=relaxed/simple;
	bh=+PjJVE098bZa/wU50gzrS6mqYmWbxu5ewW7VD/uon2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXhfhS5Io+rbiZymWGO2rdvcbcqEglDRaf+Nt4/8mc6yHAVknOwmDmczDt5y4htHSP6qNmbwo+c650FnCKq52mmBNvT3WYgvkDmC/6aG91i1NtXHfmw7QQC6NVke6rIiogRqvGIspkHFzl3PAfOII2mIiTK6UdYpAe+Pr9hWeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Mvjr3659; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E0cJpxD2137090, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741912699; bh=+PjJVE098bZa/wU50gzrS6mqYmWbxu5ewW7VD/uon2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Mvjr36592I0PnIn+ZJ0etW/hp6ShwMpJa0ZXuzCTvj9IQ3jcUuVXPNaG+z2cAwCh2
	 FtgNxeramY2a7EGRt6TS/hCaqCZ9hdLPuFnIjKX5v/CtMicW+nFuYKwIZUuqMTHkl4
	 bi9v3rM9mnnbQ1akc6wXwu2dusiAjiZtFGqiSYXRMVEOc/SVz7l2EYiGXnLFGsvNEk
	 qV8Ymx/HIwFuA/7ckPvCCtnriB+uA1FfbUeZbi17QCUaKHS6BQcQfdNVdqYtx4sKyV
	 ZaKaBdiIgCEaxsH6TZZLTAgPht1hUAxUxt/22hM/vJRwPOKv1w0CJysjmSxPI0VCad
	 K3sWUDLKuYWoA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E0cJpxD2137090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 08:38:19 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Mar 2025 08:38:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 14 Mar 2025 08:38:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 14 Mar 2025 08:38:18 +0800
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
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
CC: Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: RE: [PATCH v2] mt76: mt7915: wed: find rx token by physical address
Thread-Topic: [PATCH v2] mt76: mt7915: wed: find rx token by physical address
Thread-Index: AQHblBmGB45wtbg220K+EOh15tj5ybNxx3Qg
Date: Fri, 14 Mar 2025 00:38:18 +0000
Message-ID: <e935ee9c19de4b9baf547aa6861d23e7@realtek.com>
References: <TYCPR01MB843753CE1DBAF4FAEF76B17698D32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB843753CE1DBAF4FAEF76B17698D32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Shengyu Qu <wiagn233@outlook.com> wrote:
> The token id in RxDMAD may be incorrect when it is not the last frame
> due to WED HW bug. Lookup correct token id by physical address in sdp0.
>=20
> Downstream patch link:
> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feed=
s/+/737340322ab22b138fd200e02
> 0d61ffdbe3e36a9/autobuild/autobuild_5.4_mac80211_release/mt7988_wifi7_mac=
80211_mlo/package/kernel/mt76
> /patches/0062-mtk-wifi-mt76-mt7915-wed-find-rx-token-by-physical-a.patch
>=20
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
> Changes since v1:
>  - Reordered code sequence to reversed Xmas tree order
>  - Renamed some variables
> ---
>  drivers/net/wireless/mediatek/mt76/dma.c | 26 +++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index 844af16ee5513..25893686cbe85 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -445,8 +445,32 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_q=
ueue *q, int idx,
>=20
>         if (mt76_queue_is_wed_rx(q)) {
>                 u32 token =3D FIELD_GET(MT_DMA_CTL_TOKEN, buf1);
> -               struct mt76_txwi_cache *t =3D mt76_rx_token_release(dev, =
token);
> +               struct mt76_txwi_cache *t;
> +               bool found =3D false;
> +               u32 id;
> +
> +               if (*more) {
> +                       spin_lock_bh(&dev->rx_token_lock);
> +
> +                       idr_for_each_entry(&dev->rx_token, t, id) {
> +                               if (t->dma_addr =3D=3D le32_to_cpu(desc->=
buf0)) {
> +                                       token =3D id;
> +                                       found =3D 1;

found =3D true;

Since you are digging how frequent this can occur, you may decide to have a
conversion function afterward, so it would be good to move this loop
into a function, like mt76_dma_get_id_from_txwi(dev, t). Then the you can
replace the implementation at that time.

By the way, I personally don't like so many indents. A function can ease
indents.

> +
> +                                       /* Write correct id back to DMA*/
> +                                       u32p_replace_bits(&buf1, id,
> +                                                         MT_DMA_CTL_TOKE=
N);
> +                                       WRITE_ONCE(desc->buf1, cpu_to_le3=
2(buf1));
> +                                       break;
> +                               }
> +                       }
> +
> +                       spin_unlock_bh(&dev->rx_token_lock);
> +                       if (!found)
> +                               return NULL;
> +               }
>=20
> +               t =3D mt76_rx_token_release(dev, token);
>                 if (!t)
>                         return NULL;
>=20
> --
> 2.48.1


