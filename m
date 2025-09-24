Return-Path: <linux-wireless+bounces-27630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA7DB99052
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 11:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F248F19C2E47
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4D2848B2;
	Wed, 24 Sep 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mi8jiH/8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB326D4E8;
	Wed, 24 Sep 2025 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704600; cv=none; b=HSxFMHQAOVuNgsXLnJZpLsvbHj4oe1XyPK2uBC+1Mmg4qQv8wY0vcAqI/qKd92tlVIZemYOFJur2Ow/lT1ljIwD+9Fa3VNy/4U/ev6m2fnch7HJ5hrhGEnrzv3rHF7kbvonT1UkZ+Qn3v2hUWOdbqT4SbolckaYbi/JpkIrZTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704600; c=relaxed/simple;
	bh=a2PVPF8/ilij8lscTC5SALh83wcqF8eVKXpM25uA5Nw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cu5MX9tAyiduruGVM5Jf3zxz5v0UMxfG1L7U8btazSLqQ/ApLaOBZdb5aDRNTjevSjZE6koYY9vqrGBziRGeCaPxaT2V1MSitMKscDsAFZhqBKC6OZzK7Q+klxFlzLnEOEPBLF2awYk9XfILFTHTmTTkfBMFw8nidE4tK99ll2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mi8jiH/8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58O931NV03433708, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758704581; bh=dmffdKNuZe6WN3rTyqOktFUuI+Evc2pxexYDParIISI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mi8jiH/87W33m05JRXpndsraIbXA4/hpGkaP22mx6sMFJbGLTAidBYvDn6id4RQqz
	 cm0egQ4PiVo6P3gi6iIGtZ0kEwCYvBqdWpYcOmc9bXzCUTz6JtdiQX9KVFDKECle7Y
	 K9elbzhoeWys8fa1p4M9Cnx1Nd3Rqmi4pNQGEJm4XY7L7rrvEgwDBzzvzL2JeG19SW
	 Y+1wfcmJykKe4DdERcJ3DjM8zBxXMqbtTD4mwdrEG+GfGp+Wrl76H4sg+iq0RELYfy
	 QSHVLE8rm0sYLsf8EUuiqYK0oputLvepBAdJ8fmZ+5sZoC3eeNdDJ4Cxp/Z6GKcYvA
	 kNx5DprlwBnoQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58O931NV03433708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 17:03:01 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 24 Sep 2025 17:03:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 24 Sep 2025 17:03:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 24 Sep 2025 17:03:01 +0800
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
Subject: RE: [PATCH rtw-next 2/6] wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
Thread-Topic: [PATCH rtw-next 2/6] wifi: rtw89: usb: fix leak in
 rtw89_usb_write_port()
Thread-Index: AQHcKjJT5omW/NQns0OoAayiPu+sBrSiDXMg
Date: Wed, 24 Sep 2025 09:03:01 +0000
Message-ID: <fbd7e4192bb8422980a2916489d4961d@realtek.com>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-3-pchelkin@ispras.ru>
In-Reply-To: <20250920132614.277719-3-pchelkin@ispras.ru>
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
> When there is an attempt to write data and RTW89_FLAG_UNPLUGGED is set,
> this means device is disconnected and no urb is submitted.  Return
> appropriate error code to the caller to properly free the allocated
> resources.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtw89/usb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wirel=
ess/realtek/rtw89/usb.c
> index 3435599f4740..bc0d5e48d39b 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -256,7 +256,7 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtw=
dev, u8 ch_dma,
>         int ret;
>=20
>         if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
> -               return 0;
> +               return -ENODEV;
>=20
>         urb =3D usb_alloc_urb(0, GFP_ATOMIC);
>         if (!urb)
> @@ -305,8 +305,9 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_de=
v *rtwdev, u8 txch)
>                 ret =3D rtw89_usb_write_port(rtwdev, txch, skb->data, skb=
->len,
>                                            txcb);
>                 if (ret) {
> -                       rtw89_err(rtwdev, "write port txch %d failed: %d\=
n",
> -                                 txch, ret);
> +                       if (ret !=3D -ENODEV)
> +                               rtw89_err(rtwdev, "write port txch %d fai=
led: %d\n",
> +                                         txch, ret);
>=20
>                         skb_dequeue(&txcb->tx_ack_queue);

By the way, during I review this function, txcb->tx_ack_queue is a
struct sk_buff_head, how about just struct sk_buff *skb?=20
(I might ask Bitterblue Smith about this).

More, since skb here is from mac80211, so ieee80211_free_txskb() would be=20
more suitable rather than dev_kfree_skb_any()?

>                         kfree(txcb);
> --
> 2.51.0
>=20


