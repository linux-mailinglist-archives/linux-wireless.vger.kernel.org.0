Return-Path: <linux-wireless+bounces-7761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB168C802B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 05:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049061C20F5E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 03:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6101D524;
	Fri, 17 May 2024 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jingojango.net header.i=@jingojango.net header.b="IHU6votA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045BAD530
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715916314; cv=none; b=Nf/1wGVDik2EENdDEM/3oVcdvH6QMB9zcczIgi/34yi1/otcLdvn/l+cjknfgCjJSVbhESi/A8Qcz+KBWReoMZjnbvpZQXmPcG3JDE+4PlKuucek2nNbxMjyr6nCLGCuSg0qXhmi2216WwqqSruPQRGhg/oKSQmRUw40U0hzOSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715916314; c=relaxed/simple;
	bh=P8vLeMmOTqhd+d6qcFgvCct2wJ6HTEKBaG61F98HVNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQjHLlnl6Nwlbr55JQQi1d0bC1rwDVB83r6XO3ZzocEeALNNKiPmSCgIDYGNGEoqEBO9MMdOtQ7j7l8JY4emivEJEqjynBNrXNTHRQmt0eYeeoZ67L5iBaQ33bQkmFT8b2CFU1Q4Tjw9UCeIuI7CvzzShLBSztBZ6uwuwzR3+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingojango.net; spf=pass smtp.mailfrom=jingojango.net; dkim=pass (1024-bit key) header.d=jingojango.net header.i=@jingojango.net header.b=IHU6votA; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingojango.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jingojango.net
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7f386d05eb8so54266241.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 20:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jingojango.net; s=dkim; t=1715916312; x=1716521112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fvkaKwS9XgvnpUFWjtNm9Qj1TjNSMOvZkhbYZxwbek=;
        b=IHU6votAfLUd7W9XqgbJurNYPvgwVwcUdirBZyzDy1X4je59JBigQkwS57uXh5Zn4e
         FhVQK9EzShOESfR5pjU4Rj04tf/oaMaw2nhBb3kdRx2PSU+AMFiu918EoJwM/nGJ/pI2
         HY4Jbmc+IO6wmPUzCvHgeWuWBXXqOQL2/iQDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715916312; x=1716521112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fvkaKwS9XgvnpUFWjtNm9Qj1TjNSMOvZkhbYZxwbek=;
        b=ndhHOlJUlrgYBrqxc5cIQSXEQh5gbAjdlJhEgSJrErrfvKRp/fXs6QpFymd9LsTGhF
         DV4isG2KdPHqgcExWZefn+zq+4YFcbrtBJW1qRhImAGJcfkv5TA3vvkn1lQSf7CY88wb
         JtweORh5gx1Eo6AVO1kX4+bh5HlR7FFnx+x4suAKuUfkipehWDT7y2m8BcGfdZ0ugje8
         yHq1qgmdEq5tXf3QxRKr223LFKjcsSuwy1JVnQHF7rOcwcwfcZWu3RtlgP2LdGYM4luc
         DHgdcBIGbW2kf1NrUaOXNjSoSo2ovqgTDcp4YN9SUUZd7M4bgExW+dc0YJu7a/F9OmL/
         +L/g==
X-Gm-Message-State: AOJu0Ywygi0ZzKd6k6lEuhEUumTFt27jGnnk+I00AmgfOMldd8bCunkp
	supCVwBeJrvZKgZ/Vn9q75SAUW4rKBK01K7EmG00sdlJEy7vKKbicItXmq4ydUyptt3run1wO0X
	lpUTJpDjBBZFgOMRcEXzLWfEXV1/kQzuVL7rv
X-Google-Smtp-Source: AGHT+IFbWfB0Bpy0zFYGVuiIseu828xgwQDZrltT87fzT2mAqlC5ng+zdtO7u/qvG6Kty8VHApEQszkZ08srgAGWACI=
X-Received: by 2002:a05:6122:31aa:b0:4df:19c0:86cd with SMTP id
 71dfb90a1353d-4df88134fd7mr19647590e0c.0.1715916311811; Thu, 16 May 2024
 20:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMDnkSkWQqQN-cimuJ--XFEJbdNPJK_z7hocskSaBQbnH+tW=g@mail.gmail.com>
 <c8fd2e5a096748d0aec9adcc6b294fdc@realtek.com>
In-Reply-To: <c8fd2e5a096748d0aec9adcc6b294fdc@realtek.com>
From: Kurt Grutzmacher <grutz@jingojango.net>
Date: Thu, 16 May 2024 20:25:00 -0700
Message-ID: <CAMDnkSkRzi0tMH-6PumDjjY6WChPz+C8m5_5LX1ZayeUKtF5gw@mail.gmail.com>
Subject: Re: No packets in monitor mode with rtw89_8852ce
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:29=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Kurt Grutzmacher <grutz@jingojango.net> wrote:
> > Using a Realtek 8852ce module in monitor mode on Ubuntu 22.04 LTS I am
> > able to capture frames on 2.4 GHz channels but not any other
> > frequencies. Low power mode is disabled.
> >
> > [98869.471001] rtw89_8852ce 0000:02:00.0: loaded firmware rtw89/rtw8852=
c_fw.bin
> > [98869.480121] rtw89_8852ce 0000:02:00.0: Firmware version 0.27.56.14,
> > cmd version 0, type 1
> > [98869.480142] rtw89_8852ce 0000:02:00.0: Firmware version 0.27.56.14,
> > cmd version 0, type 3
> > [98869.757041] rtw89_8852ce 0000:02:00.0: chip rfe_type is 1
> >
> > ubuntu@ubuntu:~$ sudo iw realtekwifi0 set freq 2412
> > ubuntu@ubuntu:~$ sudo tcpdump -i realtekwifi0
>
> My 8852ce is wlan1, and then below instructions can show up some packets:
>
> sudo iw dev wlan1 interface add mon0 type monitor
> sudo ifconfig mon0 up
> sudo tcpdump -i mon0

That just validates my statement that 2.4 GHz channels work. You did
not set a frequency so it started on channel 1.

Try this, or any 5 GHz channel that you know has valid dot11 traffic:

sudo iw dev wlan0 interface add mon0 type monitor
sudo ip link set mon0 up
iw dev mon0 info
    Interface mon0
    ifindex 8
    wdev 0x200000002
    addr 1c:ce:51:91:5e:92
    type monitor
    wiphy 2
    channel 1 (2412 MHz), width: 20 MHz (no HT), center1: 2412 MHz
sudo iw mon0 set freq 5220
sudo tcpdump -i mon0

For reference, here are my module options. Without these I cannot set
the frequency:

options rtw89_pci disable_aspm_l1=3Dy disable_aspm_l1ss
options rtw89_core debug_mask=3D65535 disable_ps_mode=3Dy

