Return-Path: <linux-wireless+bounces-14760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AFD9B7275
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 03:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87601C236C9
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1E57E59A;
	Thu, 31 Oct 2024 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uL0MwnBz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2402AE6C;
	Thu, 31 Oct 2024 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730341391; cv=none; b=Jyxd9XiscZhBtznJl75E0jGkrJbBsVZYc20qeosmvt81gc7Pe7T5m1THTz7W17NRMNDJ0OMl7ANdWagx3QoU/ohZt81gfK4YxTqrZTGzbgaodR2mtXzeM/aNektg/nlOZCIglaLHIAT2TFZ4qqamgI3838LaPrfUTgqtsOeSGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730341391; c=relaxed/simple;
	bh=9opkyeq0kLSTsTLiqycHnOF8P+mJWazS9Ah594gUDOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LBzoa2vqVTg/SkeKg3/aD0Gx3u7wuaP8QkQIJMoJQ7kDD42B0fxXFfZoyGaPpJm9NzFEhcK70fFSBe/ywCd5xLmmUbtvuCsvTdCA5FLME28lbFQS/Ey56MoSwJtPzuNz3G66JHNkY3YVI8bmmZ3GbUwkwXW8kFfUJHH8IKMMJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uL0MwnBz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49V2MuNnA703591, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730341376; bh=9opkyeq0kLSTsTLiqycHnOF8P+mJWazS9Ah594gUDOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uL0MwnBzognVnH0C+O+9OAsQHICkbejJNrCYlG5JuMhSKxWXjwb+BLOzf0xO8USni
	 DaQzSBOM0TAZ9QV7yq9KH0vMxeIb8WzXb+TiKFEnHaTJlORQWatSijyYA72DaUgdZ+
	 zfnSezfdIoqpQw6q2uZNAwJN/67SfIqJxXnGEtsVl2XzPly9+UozD6ISB3B1lEMRdf
	 3KURRb0XRwcBKreLnPnn6Fdw5OCgncV0xyhPj161yQDhYtORAsDAh6xc+QOnCcbOKj
	 n8jzLaWDRLFmqIQeIhsQOggJLXjxYDTeb9aKm+2TtW5RvQxm4YtjPoEoMwzCo0CCKy
	 wEYWxtPHO7UWg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49V2MuNnA703591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 10:22:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 10:22:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 31 Oct 2024 10:22:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 31 Oct 2024 10:22:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Colin Ian King
	<colin.i.king@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: rtw89: 8852a: remove redundant else statement
Thread-Topic: [PATCH][next] wifi: rtw89: 8852a: remove redundant else
 statement
Thread-Index: AQHbKs2jaIf4cD8J/kudO5dYm+aIqbKfQGOAgADgsrM=
Date: Thu, 31 Oct 2024 02:22:55 +0000
Message-ID: <7aad60c126214fdf9fd144d0a085b3fd@realtek.com>
References: <20241030131416.3091954-1-colin.i.king@gmail.com>,<eb39e027-7ab4-4062-a895-cac28d37a8a6@quicinc.com>
In-Reply-To: <eb39e027-7ab4-4062-a895-cac28d37a8a6@quicinc.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> On 10/30/2024 6:14 AM, Colin Ian King wrote:
> > The cascaded if statements covers all 16 bit values in the comparisons
> > of dgain and the last else statement is not reachable and hence
> > dead code. Remove it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/driver=
s/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> > index 9db8713ac99b..f3568c4d0af6 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> > @@ -2248,8 +2248,6 @@ static s8 _dpk_dgain_mapping(struct rtw89_dev *rt=
wdev, u16 dgain)
> >               offset =3D -9;
> >       else if (dgain <=3D 0x155)
>=20
> should you drop the test and unconditionally return -12 here?

Agree +1. People don't suspect the else case at first glance.=20

>=20
> >               offset =3D -12;
> > -     else
> > -             offset =3D 0x0;
> >
> >       return offset;
> >  }
> =

