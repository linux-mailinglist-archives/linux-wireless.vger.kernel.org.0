Return-Path: <linux-wireless+bounces-27196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE18B509EF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 02:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438D77AD5DA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 00:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C978F54;
	Wed, 10 Sep 2025 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ezlGNwd0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1619D093;
	Wed, 10 Sep 2025 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464684; cv=none; b=QZWEGjeOocalZeeWHqcHLshey46Se4ezwpwHc/c44viG8Gy9cvJROrhKN4MQMTY/WjtsJH4qWsO4dwsn4CVatOfMPe5pET2vkA0Ra0/4HKTF6BGBb+Hl7orngeoWKH51kG2+ODKepdO77UX5dPKUapjem5SqS+z5XpLiyw2aJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464684; c=relaxed/simple;
	bh=Cd/LhAC3OdULazTtLXZ2kDCrWNzkkHlYUMoWV0jvamc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k0hsMWdmiDfOtbCQhnnHdzOvQ/KnDbpcTeJTk+k235lm0n+8NBTDJiuX2ddf5I+vtmOa2mcnTUjUX1gTor4qumobrmnIoRZIsTEb4CxU295K2FUy6HZtycRz1DEx3ueYnaWLnse6IBzMRYLv5KKNJBPxMyDpm21yKDbnXWTnC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ezlGNwd0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58A0bsjD7416368, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757464674; bh=9n6IzR3PgOzhIEHGjGMIwn7DV9RVL3N2moaSKDuol3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ezlGNwd0KBmSWJys6tyPeyPoew1MVwzxV1gb1f2MyGMwnDj/JWHy36lkDhwP5q/BQ
	 XidrRXmqD/2/dZxLeIDeK5DErWjQF/WTKk70qpZD0WgezUTkOGZqnqkDMZUx8R5/Bf
	 XCM+vQZI8brB2efJBDjaPoFdeTMWkf5UsggroU0cSVDhbjqkySyRbNzKzrnjWaYjr0
	 rLertKleJofpcW+B1y3WPFXdGnTEwWrkooKYtl+gdFLIG/43O/T8dogt/9sLizwxzK
	 GuFn/OwAfYtS0Yl2oQzU03tH91NoA/1bUg37WWa8KkxAAfrU/ZJeDAl68eEhJWvv/d
	 xAIS/pHcGww7g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58A0bsjD7416368
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 08:37:54 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 10 Sep 2025 08:37:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 10 Sep 2025 08:37:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 10 Sep 2025 08:37:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "open list:REALTEK WIRELESS DRIVER (rtw89)"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] net: wireless: rtw89: Sleep while waiting for firmware init
Thread-Topic: [PATCH] net: wireless: rtw89: Sleep while waiting for firmware
 init
Thread-Index: AQHcIc+fk+Cu8K8WX0+hNcR/3x+wJ7SLkeew
Date: Wed, 10 Sep 2025 00:37:54 +0000
Message-ID: <4a3f6b40a0064de1acd80f4eeb1cdd0f@realtek.com>
References: <20250909211255.1486851-1-megi@xff.cz>
In-Reply-To: <20250909211255.1486851-1-megi@xff.cz>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ond=F8ej Jirman <megi@xff.cz> wrote:
> From: Ondrej Jirman <megi@xff.cz>
>=20
> This avoids RCU stalls caused by waiting up to 400ms for firmware init.
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  drivers/net/wireless/realtek/rtw89/fw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wirele=
ss/realtek/rtw89/fw.c
> index 16e59a4a486e..2c034b764a0a 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -109,9 +109,9 @@ int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev, enum=
 rtw89_fwdl_check_type type
>         u8 val;
>         int ret;
>=20
> -       ret =3D read_poll_timeout_atomic(mac->fwdl_get_status, val,
> -                                      val =3D=3D RTW89_FWDL_WCPU_FW_INIT=
_RDY,
> -                                      1, FWDL_WAIT_CNT, false, rtwdev, t=
ype);
> +       ret =3D read_poll_timeout(mac->fwdl_get_status, val,
> +                               val =3D=3D RTW89_FWDL_WCPU_FW_INIT_RDY,
> +                               1, FWDL_WAIT_CNT, false, rtwdev, type);

As I know, sleeping while RCU lock is not allowed. Please share kernel log
about the RCU stall and your perspective.=20

>         if (ret) {
>                 switch (val) {
>                 case RTW89_FWDL_CHECKSUM_FAIL:
> --
> 2.51.0
>=20


