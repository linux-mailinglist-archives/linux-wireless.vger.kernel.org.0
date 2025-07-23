Return-Path: <linux-wireless+bounces-25941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76269B0F2F6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001413A40EC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26592EAD00;
	Wed, 23 Jul 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak5XwfIb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B12EA736
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275742; cv=none; b=pNdjhhvxGWUQ7ESZ3O5vdYCIHLIkVqh81XmUfPk8jFWqK/+1gkGQ24Jicpija/fuSn88Sv4l3ae9ohgHA0gadnOK8/+zrOQQdSGC+91VTR81JZQTY78onsYrECpHzfNWixyyQHS5EITzdTyDu9lcNBKDkqoVGgutqnbvAHbR4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275742; c=relaxed/simple;
	bh=Ioj9jms0xa9lQKRRktaV71dleYrls3WZPjBSCjNjzlE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aytWhve3KTse3TKxUo3yZOMy9/tMXF1KcRAOvSDor2PmMvYv6mQwasumx6X52kNdSXiqMigkHMoMhi6eml2i1fR7IThLahXnTvuipO+7Q/W/wLT45NZLgDOk8rbQbqTeoDvZIlGZWQF1QJWI6WPWsBaHVz3lRJug7KtqUd21Lss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak5XwfIb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-612b34ef0c2so11598027a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753275738; x=1753880538; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl1tWn0UWyCQtSBiSA+txRqJ+SIi0LLgzNqMSAUb1Dg=;
        b=ak5XwfIbc9XXyvZJnxeH3UmAWUyREuHqNNOL6Z9JTgweZThSACXwKmkyT4CFBu9VKF
         OhPAWU3RVA7ZbEXRoWUDyPSQBr+DbeDPPRvNviga4CXT8jGZhSAuGkJwdCsSW7ghErUy
         f/AvBfV6XRGlH4XkHwYTvfMbXJ1D8XMPcPOgiEvmk0dAdhGC7amiqF77QMS3iUfsF60X
         qKQYhA6xBecN4+G9GTPzdKKw3Pgd4cJu//FewzxfWc7E4AZjSO34LU7vmCdpiVSLRC55
         lS+1zVldEi8NJGkA4RXngUbbRI7T+SYkcCJL1zHxQ9XBTAghpwSpTqrgxnDWyHHLuRfs
         vmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753275738; x=1753880538;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xl1tWn0UWyCQtSBiSA+txRqJ+SIi0LLgzNqMSAUb1Dg=;
        b=LRMZATJ1RsdJbw6HQGWx8JrIYrvVXveKCQPNk09KjtRmcMJfNC8fG46YElnGXv+jbq
         MgHnLKNvB7BjavhHaZ3Yrniu5pzJn+Zj2oqSV/MT9/L+qirZOYZbtxQLaGT3M1ou3y+W
         YdfoyNjdwzU0tulwtBw+/+ODKIJioFllMdlc14PHo07mVD8379Oxc6WXtSP44THOZ0Uh
         JHc4thUzfeePt1Qau6BPenxCd4ptxR1fUsuCeawh0VlkKTgO5Qvj5NjlJL7T7eAk0YHK
         dkJgbUOLJIJ1xmrEL0AAtkZUoJTdTQHPRYxPjnCpCmn+EnZoTkb4zlNsFg6LXNCjvVvI
         TRzA==
X-Forwarded-Encrypted: i=1; AJvYcCU9EXhVocj85CdBlxUIt/aJUcd1akCFi8zO5ZhPaw+bCH2UeAsVrMA276KXMMR1LqoYmWEhXE+LUHBn/m3fVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBl2y7VOfyDROc68KBY61tTm3jQ1uP0HLujKrwYE8D1ZZik0r8
	tPuZBUqAszwEgjVS5JAojHFJYiI4b5eGrA+v7iMKBIlgBf6QRIUE2NBH
X-Gm-Gg: ASbGncswm2cwaZWP79u9lnGQ2Ojv8ed18Bt8g/mm54fX92Imc+wMNEuLni0uAzBqQhf
	GD1hTW6l4PbHcAb7xa/7LLPveCy/ltVeBxMuLt/eEWp1YoefQ/AcWeaI77bqtl9W+DohjDTb/v5
	h8ozEovU/Ahoh+f7RLai1KpV+chDkwCoGX8CKpaoi/iiWhzMvxlYyL09lGpRfw0zy94tKiQE8OI
	7G2lUQ15dRzk42eypC4F13YELgjkUMvcF4y/4InK8ZrAk4GwyhYCH4pqsN1TFSUUTen99A0FMF/
	0u++ZBsfhAx39Mw5+mPFjSDOhY4OwlHR/XvvE6BVvbsq3xuzWd7BFrJ55pKmmtKT9E48N1XqWU9
	qcjCeWvCUiSyh8le3cmNjkLPY2DwqArUWLUd/PQZpU4lsuXbXznnat63taqPOj7/cEE7QNoauQM
	uc
X-Google-Smtp-Source: AGHT+IH7nMr1U6ZP9hJ7wusJiz2Q8DNMlZtXyiuGtEkCyZ+V7y379iLTI7i92FgVOPCmCrlvpqwkKg==
X-Received: by 2002:a17:907:708:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-af2f6c1bd3dmr291528566b.24.1753275737356;
        Wed, 23 Jul 2025 06:02:17 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.play.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79c279sm1043335066b.28.2025.07.23.06.02.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:02:16 -0700 (PDT)
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


