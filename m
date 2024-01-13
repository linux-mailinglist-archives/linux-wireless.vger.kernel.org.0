Return-Path: <linux-wireless+bounces-1882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D282CEFB
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 23:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D361C20F96
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 22:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FF5D297;
	Sat, 13 Jan 2024 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JF5qzecb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB766AC0
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3606dc4fdf2so42212705ab.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 14:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705186238; x=1705791038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0PR7d6kFss5MEdP8wrBHxjXBuz6CzRaEP26lZSSvbM=;
        b=JF5qzecbxhKbTYOPxRFWh6dmpzWUxp19SjYy7ImxuODSRxlhR3UFpuK/35US4781vK
         UwJ2SsdgAIj7BWj6IyFKmXR4eF0Qei1ca2fbQOGbFWXGqUoSNhwvCOIDK0M5fNuFOMlM
         N0XgpZc17n1aKFUJ06xB/ksf2bz9NtmYTO93+dJTPg8ppGB+XfCL0vm7a5kvWx0LAXPh
         OPALbT3Ox0ZLLbnR5GkJDusHqosbR+dOmPQAa3hKWKKV3CpH+9IrnFsWnlcI9tZoRiNJ
         9z36hyF+5dO8NFlTnwJnICpGM2S52iIGo5SLAtXRkoTCEWaWPZiUUWHFCFqPpsOUvtxS
         q45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705186238; x=1705791038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0PR7d6kFss5MEdP8wrBHxjXBuz6CzRaEP26lZSSvbM=;
        b=N84a4WTOFBIqz87uJA9XpgCam9nzlYXtjH9t6IGL9A6c9q1dwVzbbkcqfhFzlHQN+e
         VfK4GjwMwwxcYbQr6hsv01bj83FicDBcYr+fQcgK1cFqxdi1mP1lm5ao0TOCb3QXSsmH
         ly46SD2Ui4JVHmFv/ZWhvhnSkRtt40dDABNx9/k1QtROmlApHvlEz092dSCf4Yc5g+na
         kVHuIQY2PWBRbHihu/7t3FxKsgLRRdgRE1+6GiCG3Au/0sivP1SEyJtyjSwaLmphSOQ/
         fsTlypl16Rc7XaOhER7wjX1USUuzbnh8xjVFOw/wGhQmk2iexht/mSPPraXHKVN6YE3C
         K0ow==
X-Gm-Message-State: AOJu0Yz4f9czh+XuLF76PAkHVJN4oriVr5vBhrSuqYCcLHWZZAIs82sm
	+1CZ4NcSwrNczIbJWZ/i29ZBLfZH9Y569OdNgX2OwImpi1s=
X-Google-Smtp-Source: AGHT+IGSUVOjXFSR/cGn3f4kBlZbvoV4yjhb1el12Jgd6DM4TG4KNi3qSihIryO0XnrYjyagLoQ/4jxOHuO4dbdmWvc=
X-Received: by 2002:a05:6e02:1d18:b0:35f:b0d1:985b with SMTP id
 i24-20020a056e021d1800b0035fb0d1985bmr4988409ila.3.1705186237787; Sat, 13 Jan
 2024 14:50:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com> <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com> <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
 <0be52db8941c4e609bfda6c69a14184e@realtek.com>
In-Reply-To: <0be52db8941c4e609bfda6c69a14184e@realtek.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 13 Jan 2024 23:50:26 +0100
Message-ID: <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
Subject: Re: rtw88: rtl8822cs AP mode not working
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Viacheslav <adeep@lexina.in>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	=?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ping-Ke,

On Fri, Jan 12, 2024 at 1:40=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
[...]
> > dmesg/journalctl is clean. No messages related to wifi.
> >
>
> Have you ever tried AP mode on SDIO interface wifi cards, like RTL8822CS?
> It seems no beacon issues properly, but no obvious errors during starting
> AP mode.
I haven't tried AP mode before (and I think* that Jernej also hasn't tried =
it).

> I don't have this kind of wifi cards, could you help to check if AP mode
> works in your side?
I'll check that in the next few days.
Also I'm wondering where code enables beacons (is it
rtw_core_enable_beacon() or is there another relevant function?).
Knowing that would be helpful to analyze this further.


Thank you,
Martin

