Return-Path: <linux-wireless+bounces-25921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A971B0ED94
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169D73A0F67
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BF427603B;
	Wed, 23 Jul 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goFGfX31"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3C19C54B
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260399; cv=none; b=PMd/x9rLnz7YQudCAO2F5PKxD7RE78DviBexs0wCP/MfwokDQ4D0Wh/wbDwuyGpy2I9Kq1s5PbkSD67XZTWlIpe6xdQqOOpJCI2xIS0HW/ivWWTqQ69LmVgMS4rKYxA+HgSQtYzckMSzoKyc34lieogp0SowX1MShZJrJ8V6gFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260399; c=relaxed/simple;
	bh=JdUaF+f1WveJsSbo5jW++gaykCyHRcUF+LVwTjh3xqI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s+k8ObIGdzVWoGuq4HtOqI2p31Ekeml3vjuh8aY1qrqo063l5LGGb0xba0q/P/tqZapLLokT/kRfOyqQqYK30FVgB2FH/Akvs4efzcoxlYydVzCbhhotbNdCMX41J8T4o0wPdAJemtG9DryKGd4Sf8EzX+b70j6isCoBQ9dDF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goFGfX31; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso125836766b.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753260395; x=1753865195; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl0jXm8QvSBtinyJQxa8ukfTLPQE8YyGRwQWT05DQM8=;
        b=goFGfX31QVrBwcLejCcmI6+klIq4yxDK8SVjPpMCQ3Qaw0jEAhxYZi+dEC7PYFG0Tt
         tgVHvC8B158yg5x+YmFdQ/M17eqo33mHMexy54Zt6u1HezLKTou0SvD5eAswG7oMyBG/
         pb2/PB6VscE8vGS2xqd35Bl4D+Oj+7kyNICtdHB6UY+mpnKIC1c/ZpDCIKQsmayaEqTC
         1aCtbh8gkHCiLVDeG5uElmAfxfMgtBh2UkoKyLoCPcaEwSdM6txFU1lOPO0+pSrO5i7d
         olWJzw/dRLKg7qWihAIc7DseUjb+Z/mEzb5CDPKBBSW70asaw/CFYZ1IVeiS1Htuy5o7
         6ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260395; x=1753865195;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl0jXm8QvSBtinyJQxa8ukfTLPQE8YyGRwQWT05DQM8=;
        b=rXUkMYehCfgcLwpKap0txl3kE+6OcGGUKhYBawikkZx0AYsHesCL9YeKlmFJOjgDXz
         T1pUQeur/hexe3MQEzTGjoFqBZz1QtN9lDdgEFT6VoHt32g1YjfGwLygoibCAVp4R2Iw
         vOg63fgdq36nNgKTPlhD82Y1udI9ar1fu06o7TJnuhPIuthTMLrnshwALvgl0nXUXHtL
         s2sS0A9uO/7t0I1ug+DgeAmRrWU7ODwac288BIpp05A2NECwJhcQBhAxHzWA1REz1FDr
         caIg61SqrzHzedhGYpbd9eK3Fqh0ANMGvVQH0kHIdMTzvIkY/TL3Y0Axj6ol94Xqn0Kk
         Dasg==
X-Gm-Message-State: AOJu0Yx5RHX+u3yjV726s67XnaROnizRFCPOcJP5uRnPSCjt4h5i8Yat
	gi6QKqHnv6pGk9LXcML2YQVmiWvb5YIPeASJRoM6b+XXeEORXEmiZpYJ
X-Gm-Gg: ASbGncuXJ8oNZYsAaIunqdeVClRl5MKSKVPF+fPXFCKxC2kqXLPnx9slz9OSYKrqF2B
	W8/ld7grk2lH1KDZSAzoBe0bfH1YB1PWK/kgehyuejewz72uskxrqJWwv8olFg34wpCXTG5zWqv
	17q2les3QtMwcqGdeEPWV4d3YXW9vSsaLCyZVZTbdo8Pq/ZeuomXsuCTESzuszNih1uStxKEa2I
	pvqVKqCUooXfTXzBj22bhvmkNPYyyeWiR5u8Aa6HvLDOfqJva7Wt5Guy5yIsy0x5QBv7glPlbRI
	UyPz0vHG2IEcgmcSW3zdrYGPhiBspBHagWiYtnfZYq4AiS9vjr4pbujgXEE+feHgA8nym21eiA+
	Y/SyaH07QsZM2yD9Fm8XEg+GAGXzeJNIQh+ag/DAWKk4wknLbSHfWQaTVa/X+GmDDbvw2YB1IZZ
	IQ
X-Google-Smtp-Source: AGHT+IHV3OTBeEu3YmWpQsSpNXcwz5P1DAMwQBYlB4nezD4ruEgdQIqeEQoGWfDpgzinGyMGpv15wQ==
X-Received: by 2002:a17:907:6ea7:b0:ae3:c72f:6383 with SMTP id a640c23a62f3a-af2f48b0ac8mr201404466b.17.1753260394351;
        Wed, 23 Jul 2025 01:46:34 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.play.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d8fcasm1016040466b.68.2025.07.23.01.46.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:46:34 -0700 (PDT)
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
In-Reply-To: <34d9c169c92540caa294095d2172b4fc@realtek.com>
Date: Wed, 23 Jul 2025 10:46:22 +0200
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <18989932-3578-4E45-BA8B-6C2C76FDE7FE@gmail.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
 <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
 <34d9c169c92540caa294095d2172b4fc@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> Wiadomo=C5=9B=C4=87 napisana przez Ping-Ke Shih <pkshih@realtek.com> w =
dniu 23 lip 2025, o godz. 10:19:
>=20
> working state:
>   rtw88: rtw_chip_parameter_setup:1859 hal->chip_version=3D0x493d30ea
> non-working state:
>   rtw88: rtw_chip_parameter_setup:1859 hal->chip_version=3D0x303030ea
>=20
> I'd try to read more times to see if it can become correct...
> Also, I force to use correct value at the last iteration to see if it
> can work even incorrect value of register 0xF0.
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c =
b/drivers/net/wireless/realtek/rtw88/main.c
> index fa0ed39cb199..137418d1108d 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -1858,9 +1861,14 @@ static int rtw_chip_parameter_setup(struct =
rtw_dev *rtwdev)
>                return -EINVAL;
>        }
>=20
> -       hal->chip_version =3D rtw_read32(rtwdev, REG_SYS_CFG1);
> +       for (int i =3D 0; i < 20; i++) {
> +       hal->chip_version =3D i =3D=3D 19 ? 0x493d30ea : =
rtw_read32(rtwdev, REG_SYS_CFG1);
>        hal->cut_version =3D BIT_GET_CHIP_VER(hal->chip_version);
>        hal->mp_chip =3D (hal->chip_version & BIT_RTL_ID) ? 0 : 1;
> +       printk("rtw88: %s:%d hal->chip_version=3D0x%x\n",
> +               __func__, __LINE__, hal->chip_version);
> +       mdelay(100);
> +       }
>        if (hal->chip_version & BIT_RF_TYPE_ID) {
>                hal->rf_type =3D RF_2T2R;
>                hal->rf_path_num =3D 2;
>=20
>=20

well - with above patch all starts to work well :-)
10 boots, 10 working wifi with correct scans.

demsg from working sys: https://termbin.com/bhs4=

