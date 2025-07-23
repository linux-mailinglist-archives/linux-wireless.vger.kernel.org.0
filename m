Return-Path: <linux-wireless+bounces-25942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB416B0F2FE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 15:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F5A1893782
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DFD2EAD03;
	Wed, 23 Jul 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="budiX86H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27232EA737
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275742; cv=none; b=pi8sPx56b3X1zklCwtukt1MI6IbDoN2SwrmZhARIlB//O1UtwWxLIIdncrR7VfKkSniUetzNGueNN5fq9Gu0SaaqPhGQOUboMrSHkRmcFwmVjAWxjvogCoPhr7LespW/dRJ59P2yxE8k5p/jc35806M/f0zlHQE+XQguma3IMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275742; c=relaxed/simple;
	bh=Ioj9jms0xa9lQKRRktaV71dleYrls3WZPjBSCjNjzlE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aytWhve3KTse3TKxUo3yZOMy9/tMXF1KcRAOvSDor2PmMvYv6mQwasumx6X52kNdSXiqMigkHMoMhi6eml2i1fR7IThLahXnTvuipO+7Q/W/wLT45NZLgDOk8rbQbqTeoDvZIlGZWQF1QJWI6WPWsBaHVz3lRJug7KtqUd21Lss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=budiX86H; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso11988798a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753275739; x=1753880539; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl1tWn0UWyCQtSBiSA+txRqJ+SIi0LLgzNqMSAUb1Dg=;
        b=budiX86HYY/KSZ1THGmGobr17+rtSBAyYwnw70FdVSDlSIm/D+PGM5oCY9MyOuMLpL
         clF6VfKx7CPKf7SmrDx6zEPxf0UWKlmd5JxRt5WqCav14GWsZguI0cPUDf4J0tksBJJF
         mYZjO7cFXO4y1DoxgYXaAOM+Z4E1MVb5Tg/PuKwv3/A3HJwrroBOgZQId2E8yd8HkDV1
         1zL3amZWiqtUnooCaQjDhSAHN+6zkfl9D+5Z+QZnGySTRZ2KJKBCKAYOWcIvCKsXtOmL
         AC1ftVxo+A4DGhmQE7/Y8YSitj/a4Yeo38O1NUhTP1ASU0u8t7JmgVQHDobWo7x5EbnB
         T3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753275739; x=1753880539;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xl1tWn0UWyCQtSBiSA+txRqJ+SIi0LLgzNqMSAUb1Dg=;
        b=K2h4XtHr7teBj2Ux23GXMUj2VIr2mrnUs2GpRNiibACRF7m0o0afrqlKSPNG135DR4
         fOhgYCN/Yh1mjw5MKTr2w7IA0X2pl7gfWOVu3cjRoRtCUP3HVAC2OcJiarSD0sDWkxpv
         rS7y+CXfh8NKxlSQhNuHJRNpj7rt5Jt0tJBv16xxJN62AKKzMezU4IoTq0DZsNJkeakU
         yZZmj5sOnEMq95XFIPKCXy3uJldrRbHRJKSErZx4DeMfDHxa52vihQJBIcsUm/KToy+F
         fV3eeXzBup6gJftIcYdV3HaNnCcOMoptLcni9bMcS6bN666sEGNkSTuQKcpyvLeEO9yP
         STLA==
X-Forwarded-Encrypted: i=1; AJvYcCVlwfWpHCxf7QT2L3cdLBkBsT2TrMS1zlB0c7MTdbnnNyQwW8l/nDxhYMR6ScICUWMx0wY3TTesB7pzdVu89A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfXXlSNjlb96zQk8qtjtQ5AH5zEkg7JWjf6w1tcv4wULLhnd8
	GtX756euCSNLbib6vJ+jlWDnj14UoGJIY0DT967ckHF84HHG4fDrkbl1
X-Gm-Gg: ASbGncsYK3TTO1u0RnyZYKW1NasLpINk0VYfRaI5stNU2FthyRt7GR+X2dYsDabPDZ4
	dykRWFYxDMFKoaIMJQUz8YJfbuavf/5J89G0Ghel3TPzdYuJByCuLnhos8MR9CbXiW2BRp5+6O5
	nZOpqVIRqcSTdhqM1OAWbI78vy17C9kflf0mF5AvJ0bJXaZP1tUs0U6KcyZW6IhweWW1W9Guc0F
	qVRJSM0jqR6lxheu206mSLG5AA9ps9OS/7dO3D5CZBvfEpkNggRlFD5WW2cJ7ANSOIMsi2ecFS2
	cqdDtZMwzBGn5fxZ3FyO8rXz3Ndvza8pcO+DG8weyYAuZ0OdyD9fVvxtG3nKDbRTyA0MK+83hgY
	naN2ygj0PeeThbRjo4f/Bwst6BiPbujYK/oDN0MZEVAk5fX+GCWGU3VKWD8ih8ntGcZoPXj28sO
	684lJfRbpwIfc=
X-Google-Smtp-Source: AGHT+IH2AKbxPWCYCRYuIGyZ+DSPs6OJmdW0zSFrUdQAlTZDWl4QKIqM4izOzbVArum/k9601c8E1Q==
X-Received: by 2002:a17:907:3d4e:b0:ae0:a483:39bc with SMTP id a640c23a62f3a-af2f8d4ec18mr302646766b.46.1753275738581;
        Wed, 23 Jul 2025 06:02:18 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.play.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d8fcasm1053781966b.68.2025.07.23.06.02.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:02:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path'
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <5933c3ef71914cdf83687042488800d2@realtek.com>
Date: Wed, 23 Jul 2025 15:02:04 +0200
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
 <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
 <34d9c169c92540caa294095d2172b4fc@realtek.com>
 <18989932-3578-4E45-BA8B-6C2C76FDE7FE@gmail.com>
 <ed867462c8d945b28b2e913d1cd0c3d5@realtek.com>
 <7dfa0377-538f-464b-b4e4-4c9daa1fb85a@gmail.com>
 <5933c3ef71914cdf83687042488800d2@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> Wiadomo=C5=9B=C4=87 napisana przez Ping-Ke Shih <pkshih@realtek.com> w =
dniu 23 lip 2025, o godz. 14:23:
>=20
> Thanks for the hints. I think it's worth to try:
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c =
b/drivers/net/wireless/realtek/rtw88/main.c
> index fa0ed39cb199..5ea13c775796 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -1861,6 +1861,8 @@ static int rtw_chip_parameter_setup(struct =
rtw_dev *rtwdev)
>        hal->chip_version =3D rtw_read32(rtwdev, REG_SYS_CFG1);
>        hal->cut_version =3D BIT_GET_CHIP_VER(hal->chip_version);
>        hal->mp_chip =3D (hal->chip_version & BIT_RTL_ID) ? 0 : 1;
> +       printk("rtw88: %s:%d hal->chip_version=3D0x%x\n",
> +               __func__, __LINE__, hal->chip_version);
>        if (hal->chip_version & BIT_RF_TYPE_ID) {
>                hal->rf_type =3D RF_2T2R;
>                hal->rf_path_num =3D 2;
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c =
b/drivers/net/wireless/realtek/rtw88/sdio.c
> index cc2d4fef3587..5c9e7c8cdd7e 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -144,6 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev =
*rtwdev, u32 addr,
>=20
> static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
> {
> +       if (!rtw_sdio_is_bus_addr(addr) &&
> +           !test_bit(RTW_FLAG_POWERON, rtwdev->flags))
> +               return false;
> +
>        return !rtw_sdio_is_sdio30_supported(rtwdev) ||
>                rtw_sdio_is_bus_addr(addr);
> }
>=20

With this change all works ok.
15 boots and all 15 were with nice wifi :-)

 dmesg from working system: https://termbin.com/09a1


