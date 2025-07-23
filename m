Return-Path: <linux-wireless+bounces-25914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0B0B0EC98
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86F77A56D1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDB71E32B7;
	Wed, 23 Jul 2025 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUP2k0MH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7652797B1
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257789; cv=none; b=vCDUDZhfwPSnx2wZiFtTscNEz+WUTfUhzjsSjTSQEq2erG37ITo7FKMqngLbg0IUrnPKklwlwTM0V7PGnKsl2Tievx3x4NpTrf613cK0DoWYwot6U1jdP44qLTZ8Gkbra1H5MTDTEHiIb/C8LflPLsyxxutFT0SODfhGW5wXMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257789; c=relaxed/simple;
	bh=TFWaxox9eWtbkFjv9pOXr6TZK4lshyCw0xJySHAkEbg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Sm3JLURCzJqlFAZw0lUJgYU3mDd1f/ofTn3+86lRVWfKNBtK4JO1hl0sQ8T3JuNE6vvRR4r1bB1MskongQw9k0avkSsVU7CTZ0kFCzaWKd5DLlJWRiEqoMPDTWjNoS1JoZ9iUftaXSLCv7KhDSVurFFbKJtciToZpzmmhlC8cOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUP2k0MH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0df6f5758so1046564966b.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 01:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753257786; x=1753862586; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8XWXHO2iXKEyYIRyOHIPiUDHLa+WB8tlbZDQf7aU18=;
        b=lUP2k0MH/oAhkHj6vmKaaw67Xd5AXRgMJp9VyoLGvE9SqT/ySxEF+63quwDc7koYBW
         pIpXYC2dmIXjN2BUEsneDsK6Tc4ErUKmDll4wasw/94W2WwuIBGjC3YWD50QrdHcOn36
         QF0ZnAzFRTDTdgLxVCscwLTd0LsmWYJIvmrNsWfBjunl4uNTwwFrMyDLuq1+KYNLpoaW
         nXhxuHbqMtwu+t+CzqaWCGIx7HVvGOsOyWvEAGecl8d5XsiTnrRfYG3kXhJwCs9FOUXc
         ECZjp5o/RevQovgrBJcpZeJFKBsyNzylB26NC/8OSz1N3yRVRpijfjJxTm3SLqMV/rgC
         pLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753257786; x=1753862586;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8XWXHO2iXKEyYIRyOHIPiUDHLa+WB8tlbZDQf7aU18=;
        b=dEq7DUp6uhiYB1OLa/ftirHzV+iNf6AmYLduK0sS8e5j1qpUXAww9ncf17fxmICBFH
         cmyfezdtS8Jr/DE7WGdu+sFxPsY3n6/9jMi2Fs4qHpJ6f5yGtvKfBWoV6+CVEG9+QtJo
         lekMAZiLR3l2ARWg1I95Q1YkUKEVTnq2b33/Il+KP23q7p2ZGQjbtwU922ctegvhFZb/
         W7+rYUxTLn8tPz5RPJBpxYuxdehlHUETAR2SUwAr5xrgpKgRDwEQjziO5IOz5jJ+MDdo
         HUbHgKDJBIRgqQRKGPbQ8RtB/zzTg88YZ36BlnPRMMPxGZ2n9WLZV0yXwJtHxrYvlqYc
         wI0g==
X-Gm-Message-State: AOJu0Yw7yAxsZTERWil1TUB82M5CrUa3Dh69ylJOmVRd8y8coz4lwxgd
	zb3jUFGpWhj0RpKUbvKmzR/5Yl3L4RshLY2/172+vHqYhqsaye5SDfmK
X-Gm-Gg: ASbGncsmacsFX3x4VhvS1u+rD45MBlHSqKYaR1YIBcpTQwr+FaKV0lA620/0kOX0A0/
	XteSEix8fMF26t51wn6LIrnEF6XH/68lsv1ePD2Xlq49YmVm/0WEHpIe/fuPaAcEc+mEmaxS19V
	0WTx4IMLLS6AAgJjF2x5Hs1QpiqgOhuvZkPxlPmDiZYQ1TvTF8PZPRobDzu9WsEDLV7tmmwBt90
	G35VIoSyAyhWGKdxYfX2C2tktVzHNiTWc/o/55ebPhPR96Ke57ak+nTC7FI9B3K2+X1WC1DuYoU
	6SoMBYeOK63Z3CozWm/qQLuc1kqKci/OwSmlUC0b2WzhV4rdR7sxMOxDpO/EiRYlVCA2StNWhMC
	ahorKqi0wyfbWfyU7X3fi3LmWUZIcjL92ulikpmZ4SiWTW2qiYITFVWbPokzhPPEFVt9PkIHACG
	ri
X-Google-Smtp-Source: AGHT+IGQfw74XDh4TKVRCwCVfydhLME93bgUYp15TFS5QWwyppSUf/lCAC7MsJxciuB2lSQttrLUlA==
X-Received: by 2002:a17:907:720c:b0:ae0:d1f3:f7f4 with SMTP id a640c23a62f3a-af2f6c0cbacmr191544566b.13.1753257786097;
        Wed, 23 Jul 2025 01:03:06 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.play.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6de207fdsm996846866b.25.2025.07.23.01.03.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:03:05 -0700 (PDT)
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
In-Reply-To: <b29df36b838049a088d8298220078134@realtek.com>
Date: Wed, 23 Jul 2025 10:02:54 +0200
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> Wiadomo=C5=9B=C4=87 napisana przez Ping-Ke Shih <pkshih@realtek.com> w =
dniu 23 lip 2025, o godz. 09:50:
>=20
> The dmsg find=20
> non-working state:
>   rtw88: rtw_chip_parameter_setup:1872 hal->rf_phy_num=3D1 =
hal->rf_path_num=3D1
> working state:
>   rtw88: rtw_chip_parameter_setup:1872 hal->rf_phy_num=3D2 =
hal->rf_path_num=3D2
>=20
> They were induced from register=20
>  #define REG_SYS_CFG1 0x00F0
>=20
> Please apply below change and share the working/non-working sates.
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c =
b/drivers/net/wireless/realtek/rtw88/main.c
> index fa0ed39cb199..95decf90a43d 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -1861,6 +1864,8 @@ static int rtw_chip_parameter_setup(struct =
rtw_dev *rtwdev)
>        hal->chip_version =3D rtw_read32(rtwdev, REG_SYS_CFG1);
>        hal->cut_version =3D BIT_GET_CHIP_VER(hal->chip_version);
>        hal->mp_chip =3D (hal->chip_version & BIT_RTL_ID) ? 0 : 1;
> +       printk("rtw88: %s:%d hal->chip_version=3D0x%x\n",
> +               __func__, __LINE__, hal->chip_version);
>        if (hal->chip_version & BIT_RF_TYPE_ID) {
>                hal->rf_type =3D RF_2T2R;
>                hal->rf_path_num =3D 2;


here it is:

non-working: https://termbin.com/7goz
working: https://termbin.com/lpsq


