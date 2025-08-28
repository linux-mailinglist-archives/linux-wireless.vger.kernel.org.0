Return-Path: <linux-wireless+bounces-26729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62642B396D6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932851C23B73
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3792D8799;
	Thu, 28 Aug 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dYuf+lPe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC6196C7C;
	Thu, 28 Aug 2025 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369559; cv=none; b=I3Ae0U5GJ9YuaYwUQjQgV5oGQNEpe7DwAf/k9nbDu+IrGV0Y3aaYWHfzkNAtpxeE2hlWFjbzyLgnrNu3m/0w7usmSrKRk6fKvJOP2McSFJ1O87H3N/pgYIGbL/4KjXmo+73oTOcd4ggg4oR5cwdJM57A49GJCKT/Bzhb1PLl7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369559; c=relaxed/simple;
	bh=ytdowwNueHukEQYqDrTg0e5LJvNPOab32hbkG4VijVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQ6jIO8injD0JoFnIFuEeZVyAM1rb/QNUzzi154a2I9hOAraO3pk6RDcuOKykPVGRQTdQstBKgv2qTNHN/Qb8HpwCd8nF5pz3lfT+ENbylfScPVSvHuTu+AwMvvKuIG3jrnPHpIj4TYeV9AOUi8XLvxMTJUshIAXj11E/iS8W+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dYuf+lPe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57S8Pfi761365662, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756369541; bh=RCqFeiI+zHutK2BmbqfhQ18jSVpGGqok7TanAIyR31M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dYuf+lPe+bfvATm4NI4skx6xrrVs6UFCjq9IRWRq2C2L4d//8TGqgcVRra5Wt9QsD
	 055Tn4+WSE3ujIjdinwv6xaV4XUXhIGWLgRaAsvZp9K6fYI5alMp7xzIZUm1pzE2Dp
	 3cydrfqDBZOVedai6no4ELVWp3euaOM0ga3zESy3lmYf3n3AErPAUwqJjXlVUFMM5a
	 Gm0kOBQe+59s+qAeF8jRrIQ17b/t29O7var/nptifD25RATnS6f7ZJpfalUwmTq7FD
	 6dI9F+ElGQopQj8dFlxLgEx7o8YRte5vuM6GWTlco15zFwkia9w1uutCk1Z9Xvakpn
	 Dj2iG07D+vp5A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57S8Pfi761365662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 16:25:41 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 28 Aug 2025 16:25:40 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d]) by
 RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d%2]) with mapi id
 15.01.2507.035; Thu, 28 Aug 2025 16:25:40 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw v2 3/4] wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
Thread-Topic: [PATCH rtw v2 3/4] wifi: rtw89: fix leak in
 rtw89_core_send_nullfunc()
Thread-Index: AQHcF0satO4YPEs4NUCorgmwN+GLurR3u3tw
Date: Thu, 28 Aug 2025 08:25:40 +0000
Message-ID: <e40bc0798fdb48c7919d3954803a7751@realtek.com>
References: <20250827120603.723548-1-pchelkin@ispras.ru>
 <20250827120603.723548-4-pchelkin@ispras.ru>
In-Reply-To: <20250827120603.723548-4-pchelkin@ispras.ru>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> If there is no rtwsta_link found in rtw89_core_send_nullfunc(), allocated=
 skb is leaked.  Free
> it on the error handling path.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: a8ba4acab7db ("wifi: rtw89: send nullfunc based on the given link"=
)
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> b/drivers/net/wireless/realtek/rtw89/core.c
> index 28bbc898b95e..e498c08151d5 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -3454,14 +3454,14 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rt=
wdev, struct
> rtw89_vif_link *rt
>         sta =3D ieee80211_find_sta(vif, vif->cfg.ap_addr);
>         if (!sta) {
>                 ret =3D -EINVAL;
> -               goto out;
> +               goto out_unlock;
>         }
>         rtwsta =3D sta_to_rtwsta(sta);
>=20
>         skb =3D ieee80211_nullfunc_get(rtwdev->hw, vif, link_id, qos);
>         if (!skb) {
>                 ret =3D -ENOMEM;
> -               goto out;
> +               goto out_unlock;
>         }
>=20
>         hdr =3D (struct ieee80211_hdr *)skb->data; @@ -3471,22 +3471,23 @=
@ int
> rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link =
*rt
>         rtwsta_link =3D rtwsta->links[rtwvif_link->link_id];
>         if (unlikely(!rtwsta_link)) {
>                 ret =3D -ENOLINK;
> -               goto out;
> +               goto out_free_skb;
>         }

How about just adding dev_kfree_skb_any(skb) here ?

>=20
>         ret =3D rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link=
, skb, &qsel, true,
>                                        wait);
>         if (ret) {
>                 rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret)=
;
> -               dev_kfree_skb_any(skb);
> -               goto out;
> +               goto out_free_skb;
>         }
>=20
>         rcu_read_unlock();
>=20
>         return rtw89_core_tx_kick_off_and_wait(rtwdev, skb, qsel,
>                                                timeout);
> -out:
> +out_free_skb:
> +       dev_kfree_skb_any(skb);
> +out_unlock:
>         rcu_read_unlock();
>         kfree(wait);
>=20
> --
> 2.50.1
>=20


