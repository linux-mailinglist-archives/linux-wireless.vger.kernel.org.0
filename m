Return-Path: <linux-wireless+bounces-28171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF174BFB0CF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 11:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0B9585F5F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB330E0E2;
	Wed, 22 Oct 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="oQ+aKLRi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4930EF9D;
	Wed, 22 Oct 2025 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123800; cv=none; b=LjpVChrLhvgjkWGyslTSjwAlUz2/4QbnbnRziCYbKdEfd8bidNpN3IBQuCCx2aH4wKVGBEukLmU+HesbXL+TdPpFQIxiHTBGFzpM+SU5X794AAZbsyiSVprr0NH2sAjSDEQzIH3zffKTe1h7fb6nHvjZ8lDJl86VZhVP8KDhAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123800; c=relaxed/simple;
	bh=sc8w4JADOyNs3jkCY/XLNuZVan+GiO+w5XAq+33pfa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i38Zp77g+05eBC2Z1VzKqrTrW3+cHX9xP3HlTRwP8ympuRryYFTJZd63LZfm9lxjqbn5osSXWsVuMXmL+/vLDKyGedL/ZQ+upwFwH3YHeOWeo9Iagc9PdOgUnJWO+n9Rb08SrssxPX8Atp+nmwbMlhOT6xVdZ4r8aC5zDWfuspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=oQ+aKLRi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59M9316C0370228, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761123781; bh=5ERmHH6eFe5HuiCgWX5ctaUDeupHikqUlWUfTuPXdJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=oQ+aKLRixTAdNCQqSzn+jMqHitC1ThEOQqpLQmUOaWxCrm6w8BmNCP4qSIHzm4nj9
	 vojwUAKpC/SlbuTmhvQlEvk4MZndAy26jG1hfy04B8hCjunnkpQ6kcvBD8TnGrxjgp
	 bgSiZEn8fbvwQyAFgORu+gxrbtmcikFY+lgfWQ6Y6RzFZ+mke/Sloa6PsAfeoMUmj7
	 +WPjTun+uXhEv9uM6HbKespFTZt+WmhN5bzmjL3YZ8xYJhq8QKsJTvo9/O4T+kdVDD
	 szyoqrpwHBBPyXhv4ugkMXqbCadXp7YhbRUtpbsBMcjzNcIUpvL79scMS1+1O2S8X3
	 cT6adyQZbBqVA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59M9316C0370228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 17:03:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 22 Oct 2025 17:03:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 22 Oct 2025 17:03:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v3 9/9] wifi: rtw89: process TX wait skbs for USB via C2H handler
Thread-Topic: [PATCH rtw-next v3 9/9] wifi: rtw89: process TX wait skbs for
 USB via C2H handler
Thread-Index: AQHcP04D/bgw1qysWkyovzU3pi7EuLTN5fXQ
Date: Wed, 22 Oct 2025 09:03:01 +0000
Message-ID: <191616d9c1864814ae95129886038ad9@realtek.com>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
 <20251017100658.66581-10-pchelkin@ispras.ru>
In-Reply-To: <20251017100658.66581-10-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> TX wait skbs need to be completed when they are done.  PCIe part does thi=
s
> inside rtw89_pci_tx_status() during RPP processing.  Other HCIs use a
> mechanism based on C2H firmware messages.
>=20
> Store TX wait skbs inside TX report queue so that it'll be possible to
> identify completed items inside the C2H handler via private driver data o=
f
> skb.  Try to do this as similar to PCIe path as possible.  When the
> corresponding TX wait skb is found inside TX report queue, unlink it from
> there and call rtw89_core_tx_wait_complete() to mark the completion.
>=20
> If the callee waiting for the completion has already timed out, the TX
> wait skb is placed into TX wait list (like PCIe part does).
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

>  static inline
>  void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *sk=
b, u8 tx_status)
>  {
> +       struct rtw89_tx_skb_data *skb_data =3D RTW89_TX_SKB_CB(skb);
>         struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
>=20
> +       if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status))
> +               return;
> +

nit: move 'info =3D IEEE80211_SKB_CB(skb);' here like PCIE does.

>         ieee80211_tx_info_clear_status(info);
>         if (tx_status =3D=3D RTW89_TX_DONE)
>                 info->flags |=3D IEEE80211_TX_STAT_ACK;



