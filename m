Return-Path: <linux-wireless+bounces-33283-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ee6IDqst2nkUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33283-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 08:07:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452F295644
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 08:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E36430065DA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB01B279324;
	Mon, 16 Mar 2026 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="g0gbLvQ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF0322C88;
	Mon, 16 Mar 2026 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644854; cv=none; b=bvwj0dB6sD7rKkZVhHpDnMocO7Y/nGctAY65iXKhh9WbuJg9x+B8DFKYg6gW4r5dHlGOGphvFkpOCgSO0D/L77mylZoEdr4oM4YhtZq+nSLgHjtzEHpBI/4yuUsBVbJsjdwvxx1knHp07I7nHD0dhdbJNc2IJaByeGFty9alaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644854; c=relaxed/simple;
	bh=iVge2eeLTLA9NzLPi0zmyiVu+BFhlWDvIA4dl4zNe1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V8AxMKKTn39O0/q/q6CppABr6gk4uBqrRDKE+9hCw7KOhOG9DowYAMxnwpeCOsQ7V3rdt/y+4RoUStGYAZanZm/oR7IgdUqyqxScjswNC6hHoe1o3lb6WA9R64Ejhh4p+LpSurSsc8zhVCbKLQ7dNt2ylJwtCcVwU9Qgy6+St5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=g0gbLvQ7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G77PC801440547, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773644845; bh=v/45E4Z6vR1ZmTiMiOINAQRlNcO+j87tWj/EhzcFIeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=g0gbLvQ7aLTNHJ14KEzA31TSzSNsUqHsL69yEeIyIzRZGeI3VaoshpbdgdHA1sSVY
	 u9XLqlfh0CzhKlxre1nVM8ReDQKCPDAgVMYeivhdsqJwcUfG6N+ZR6g+ybG7bFPXNI
	 u/EQU9YjU+aOuuwy2fDbxNwCr8hjZEHtDrQJGnnB4G1UcdURGz2Bxfb2cqRm+KcofE
	 Mi88rwKzNq3/klOF8n+dAOL9h0AqjjR3m2sswO+wNHkkG1mfcJaUUH9+kYpZP+Ofjy
	 h1ijFPmaQDPzlEWLZgbXzqmzY702tw2PiLCTvf4jJGVarudMNOW/bsskcHMY+dK2zS
	 RZIIwFNI1LGOA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G77PC801440547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 15:07:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 15:07:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 15:07:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 16 Mar 2026 15:07:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?iso-8859-1?Q?Georg_M=FCller?= <georgmueller@gmx.net>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 3/4] wifi: rtl8xxxu: update max report mac id on
 station add / remove for 8188e chips
Thread-Topic: [RFC PATCH v3 3/4] wifi: rtl8xxxu: update max report mac id on
 station add / remove for 8188e chips
Thread-Index: AQHcsvUZDJ+nmebUe0aVFgNy5ItEobWwvsfA
Date: Mon, 16 Mar 2026 07:07:24 +0000
Message-ID: <186032c2b7c94327bd6867936852b45e@realtek.com>
References: <20260313135321.3196688-1-georgmueller@gmx.net>
 <20260313135321.3196688-4-georgmueller@gmx.net>
In-Reply-To: <20260313135321.3196688-4-georgmueller@gmx.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33283-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2452F295644
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Georg M=FCller <georgmueller@gmx.net> wrote:

remember to add commit messages when you send formal patch.

>=20
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 23 +++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index 5ad23c5c9305..15fc4843edb2 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -3884,6 +3884,15 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *pri=
v)
>         rtl8xxxu_write8(priv, REG_RSV_CTRL, val8);
>  }
>=20
> +static u8 rtl8xxxu_max_acquired_macid(struct rtl8xxxu_priv *priv)
> +{
> +       u8 macid;
> +
> +       macid =3D find_last_bit(priv->mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM=
);
> +
> +       return macid;
> +}
> +
>  static u8 rtl8xxxu_acquire_macid(struct rtl8xxxu_priv *priv)
>  {
>         u8 macid;
> @@ -7499,6 +7508,7 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *hw=
,
>         struct rtl8xxxu_sta_info *sta_info =3D (struct rtl8xxxu_sta_info
> *)sta->drv_priv;
>         struct rtl8xxxu_vif *rtlvif =3D (struct rtl8xxxu_vif *)vif->drv_p=
riv;
>         struct rtl8xxxu_priv *priv =3D hw->priv;
> +       u8 max_mac_id;
>=20
>         mutex_lock(&priv->sta_mutex);
>         ewma_rssi_init(&sta_info->avg_rssi);
> @@ -7510,6 +7520,11 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *h=
w,
>                         return -ENOSPC;
>                 }
>=20
> +               if (priv->rtl_chip =3D=3D RTL8188E) {
> +                       max_mac_id =3D rtl8xxxu_max_acquired_macid(priv);
> +                       rtl8xxxu_write8(priv, REG_TX_REPORT_CTRL + 1,
> max_mac_id + 1);
> +               }
> +
>                 rtl8xxxu_refresh_rate_mask(priv, 0, sta, true);
>                 priv->fops->report_connect(priv, sta_info->macid,
> H2C_MACID_ROLE_STA, true);
>         } else {
> @@ -7535,10 +7550,16 @@ static int rtl8xxxu_sta_remove(struct ieee80211_h=
w *hw,
>  {
>         struct rtl8xxxu_sta_info *sta_info =3D (struct rtl8xxxu_sta_info
> *)sta->drv_priv;
>         struct rtl8xxxu_priv *priv =3D hw->priv;
> +       u8 max_mac_id;
>=20
>         mutex_lock(&priv->sta_mutex);
> -       if (vif->type =3D=3D NL80211_IFTYPE_AP)
> +       if (vif->type =3D=3D NL80211_IFTYPE_AP) {
>                 rtl8xxxu_release_macid(priv, sta_info->macid);
> +               if (priv->rtl_chip =3D=3D RTL8188E) {
> +                       max_mac_id =3D rtl8xxxu_max_acquired_macid(priv);
> +                       rtl8xxxu_write8(priv, REG_TX_REPORT_CTRL + 1,
> max_mac_id + 1);
> +               }
> +       }

At first glance, I'd say should we consider STA+AP concurrent case?=20
Because days ago, we talked about that in another thread.=20

It looks like MAC ID is another problem for concurrent case, because
rtl8xxxu_max_acquired_macid() returns MAC ID starting from 0.

But special MAC IDs are defined for non-AP vif:

#define RTL8XXXU_BC_MC_MACID	0
#define RTL8XXXU_BC_MC_MACID1	1

(But this is not scope of this patch.)

>         mutex_unlock(&priv->sta_mutex);
>=20
>         return 0;
> --
> 2.53.0
>=20


