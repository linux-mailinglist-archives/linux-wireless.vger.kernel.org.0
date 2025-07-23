Return-Path: <linux-wireless+bounces-25911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA4B0EC0D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9840E1897077
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2544A17BA6;
	Wed, 23 Jul 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQDpNZeQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C26ADD
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256113; cv=none; b=Cg7SUjoq5kUklK6Eqiy5BNzUvomWIIxjUfoYC0JCEsPW4lnlabALwla56TakLU+J8W4FVCdBh/dJKWEWzSh7BR8Ne0VYU7Zp2t8LPfpKq4yEcD/6syxvgDG+zjOir/3nLtcoxnfSscVLQ3ILGjPAcM1QSrNZL3ABWwSJccAWxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256113; c=relaxed/simple;
	bh=0jH7gN7Slkof+OnBdFGIGMAtrzCtCs/yqPPfAvlQIP0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V+2u/k75DFz+37GRjYtb6OI7f2ZSzVAaGTb6TaU0+cHkKY35GlwV1OHYYvVosoHuofnFtwYu6ljldEP2Hbtz48GbTt4j+V5toAFiS4g5/s4+aH5b1nDCsITFOtI/XfoDLxhSGZ6Q+fONEGF688p4EvxzovhkSuyh93f6BnJNDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQDpNZeQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adfb562266cso1049017066b.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753256109; x=1753860909; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3A5Slf1bZnPnELJttbMTfKkW1J+GaNxjkOJ1XRKhGs=;
        b=RQDpNZeQweNeWwXRu6dKivS0zh5IWoVgMZfKwMVhMypbHlqB4qoNl+YZUSTLoBMGPh
         +vgljX942Xn0LytbI/usYzxox5cq/ueEVAguI1ujDcyE1Ocao/QMFky6n5/etcsIkFKx
         hXH1a6bc4Vb4dnMSAniQjBaMECOdLAb+nxY0qjisXRhi+C56KV+eWsBzcAho2VM+Dh86
         W7TliL0YzdWi0UfTjtVqJ/rWHnJt4RTSUc5t+hMQ9DwSYeeon+k5p7/wAxPLRB/317lJ
         TtvN81/9QlcXyEZuVmZEMS7cTkJWNpnH/9q82Ns8hhLqh7pXgl6s0dT1sFP1g5+jvVsC
         Uz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753256109; x=1753860909;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3A5Slf1bZnPnELJttbMTfKkW1J+GaNxjkOJ1XRKhGs=;
        b=E5rAE1WIO69WZXjHv7rMRQSx+ccF0RdnLA2g/T0kv7cLN96EiC5cmCrpayUaVK2H6N
         vUsl9AYVWxh5Csdjo5fR/J6O5lKmOc+g1abl7KXGYebXf8HgD7OOgQzQaLt6FvU053hc
         eghM+5Okr4DCltK9KVXhuqba/DqdZ5C5eiU7NN4x9gOY3t84IcygnSiA3supVmz/UiK3
         u+B0VxgPmm7pf/Ut6sBPk/IcgL79qAZtzpquGg2V9gchb50uZT+jkN+JaLUaLUcza3F2
         J4nkrSgCc43Yri6oxRul7KCrJ1M8as127RbEp7S/ksmcQUfhDcxyts3f2KpVmz47cSSw
         QtUg==
X-Gm-Message-State: AOJu0YzDvBiqLOZBS5goeB1Iy3j0V7fETAGxZtd/VWPAOFMFyhn6ZNEv
	Uqo6I0RHRaO08OfU/+4zeyNMj8xYrz5sEyZUZR6iBlCKWO6EkD6oVleO
X-Gm-Gg: ASbGncv25f62OYRceKTJmpGiGHXEKVblcSlS6CCArbbtnB7cjXgi75CrKXov9UpgzbT
	pfghL0bDF9cQEO73zHOj0odh9jsvLjaBxfhs0bG0DODv/vs1kxwvvzjcYGiXFNMS6PvtV1TeYlQ
	cHp8ALzRab3C5x4wV19YK/NA45IL6Dzhn4qP/GojfMRfm9B6Le+RlRXT8lpPtkGnfHw8GfJmeBv
	twr1BQMMBk/2s4LdWUHeNwsUJTt6hSmMjmGJa8N2JAzNmoG+03BWFmj+X6RHkXbiBqWjW1WMDQb
	sow0uH6lHJejQZebjvg2ZkAVMga9gEFc1yG+ivFa/RxwnGZS6MVxAsE4LeHlZktU3VRETXDMtkO
	Fy6vLnd8ZOTpbZ71loF+Rk0MCPAraVx0XA9hJ+EzR+09P4ieB6ih9SK5iPdZ6fVSeKlZz72Mqpm
	bX
X-Google-Smtp-Source: AGHT+IHBoQyRpmBOkTPP77/h7qrH2toRVCOLy0+4suotFUGJOJYBqrpMwyRFO82PHkOIS6e5nw8hKA==
X-Received: by 2002:a17:907:3d0d:b0:ae0:da2d:44b9 with SMTP id a640c23a62f3a-af2f64b604cmr194847766b.7.1753256109101;
        Wed, 23 Jul 2025 00:35:09 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.play.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cad63ebsm1002822866b.143.2025.07.23.00.35.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 00:35:08 -0700 (PDT)
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
In-Reply-To: <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
Date: Wed, 23 Jul 2025 09:34:57 +0200
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> Wiadomo=C5=9B=C4=87 napisana przez Ping-Ke Shih <pkshih@realtek.com> w =
dniu 23 lip 2025, o godz. 02:52:
>=20
> Piotr Oniszczuk <piotr.oniszczuk@gmail.com> wrote:
>=20
> [...]
>=20
>>=20
>> Working: HT RX MCS indexes: 0-15
>> Non-working: HT RX MCS indexes: 0-7
>>=20
>> Isn=E2=80=99t that 8-15 are for 2x2mimo?
>> So maybe - by some reason - hw sometimes reports support for only 1x =
mimo but receives from air 2x mimo
>> (2 streams) and thats why I see hell of "unsupported rf path"  errors =
from driver?
>=20
> I think your point is correct that firmware reports incorrect value =
somehow.=20
> With below changes, we can check this:
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c =
b/drivers/net/wireless/realtek/rtw88/main.c
> index fa0ed39cb199..3363458a9ea1 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.


=E2=80=A6=E2=80=A6.


pls find dmesg from:

non-working state: https://termbin.com/8x42
working state: https://termbin.com/b804

ps: a added rtw88 pref to printk=E2=80=99s to easier spot it=E2=80=99s =
otputs=E2=80=A6




