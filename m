Return-Path: <linux-wireless+bounces-8813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB8F90457C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 22:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D370F285081
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA307F49B;
	Tue, 11 Jun 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lDXiPaFK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED72628D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136371; cv=none; b=GHPxG8rrDxMlaJDFIVWLlBGlYAdzOsxtB353YCig1jeqj8AMp7ztcfP03WydTSGpvujGPaY2hHYV7Hi9+59v23FXAqGEL86gsdzs6XmFLIoTVaQXxqiWywkjNwZuZh4CIQo14UsqWSQNI/qnApdnPQE6acGuj3e8VW2SOlPMfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136371; c=relaxed/simple;
	bh=uHnbK8yZ9GQzrqt+GVlF51JCkKEzN8ZWdF3jcm+f9eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6RYxWIXacB+3YQWo7NcQn6QT6zxgOzo7n9P0MiwN7C2I/I+8meIWkQb5un7d0aBgDFtS0cd/gUObWm1n1tH9Ml6rqZYKzBlmeXtgAOCzFIhr35+3/43kwMXs69HQ5suR8oNGZSynvB1G5Uv9LD49Tppk8lprbdtSlEJJkWCHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lDXiPaFK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so1860429e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718136368; x=1718741168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHnbK8yZ9GQzrqt+GVlF51JCkKEzN8ZWdF3jcm+f9eQ=;
        b=lDXiPaFKuovlZYK3il23Wg5MewPD2fut+IdNs/xXt0jIgm2xmMmXE+y/fre4x5GqsK
         NCzmzTar6Jw99zD8UuilH6uG+Xrp5Ioy6EYHtsVSlTNDAarndn3Zo3iXaaUX1HOfANdK
         UC+Je0/6JHMDLlVvLVR9JUTNs7qMwjAJHnKonfbs8bi3SyVQxyVR45PWiIGjpqbyMK40
         l7ip7rsasFHt3X+04ngrpj+uIV5xcl0AROL14tuQcFiuT/J3dm+qMI/WtYbTgLh+PuNv
         Ec6B7rIKumfUJ0WwrMChJHnq2CMqtDgu+O8eJ3USHaI8+SL6lsZoxBG0jEcMBWvWiSO0
         YeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136368; x=1718741168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHnbK8yZ9GQzrqt+GVlF51JCkKEzN8ZWdF3jcm+f9eQ=;
        b=dH85D4SsYCdvtKc1A32Ap6/En84DRDaDTT3h/TZ121tpVdNGLJrtqBKwvWMiprI0qk
         QrpiJ/op6NfaRsFhQyhWhKsbCxCramZTVayyWXD67+yylhbWlZk8wMb9YNMNifTIz2IP
         9vxXWWJOnse0vuOoWPxzRuyKexzs0XBI4x3N3xGbbwAzpY3uVnxeCSWwKzh6+Oy288PG
         d/hxY2KnTeLI9WVvwvi4HwHSXgtPqAcdSlX0YXSlO3Lbn7V+b8IOpaAJq06qhnf2nLgp
         7klYP0FYCV4R2ZvVywqIzNhZQfA83TM/kJmmbMJFZ6DKCzmVZ+rg2uoh2uEXmoMaApom
         pVZA==
X-Forwarded-Encrypted: i=1; AJvYcCVCUZ79j4plkxCoX8Vbjm+yA23V6P+jVXFsDJJd/VWwQp9eGxORaBQ8C+I33eJaHuAMSBrq6Vm3t2jTRYQAN4c7U3xCfxn4qaKRK/hy4wA=
X-Gm-Message-State: AOJu0YyDydrPBA2WU6XIMYjiRhOh4k8zFyH8DkjEXi8bkQEUxgCLtxB7
	NX53p06a1lePk3XZhwzdnSMeAhBdeB10w56i/VlxMIYnOh+xUyITOaG4xsnSc5BPewthw2cX302
	DU9jwhOwp0D5bilianJD30rcjOaFbYnFg4XkUg1LR17yzpM0v
X-Google-Smtp-Source: AGHT+IHo2kDMYmvh1Fiuq6Vp0TjSyMZ5wd2GkAYNc1OHzZu/lwJY6vNBizdeJ06QMzbe9upl8ARaKOiKysYnJKD3dmc=
X-Received: by 2002:ac2:5148:0:b0:52c:5f12:5317 with SMTP id
 2adb3069b0e04-52c5f1256a6mr5730643e87.44.1718136368542; Tue, 11 Jun 2024
 13:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122106.23818-1-brgl@bgdev.pl> <20240605122106.23818-2-brgl@bgdev.pl>
 <87h6e6qjuh.fsf@kernel.org> <CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
 <871q5aqiei.fsf@kernel.org> <CAMRc=McacZMP-51hjH+d8=PVe+Wgw4a8xWcv0sRPLJKL_gP=KQ@mail.gmail.com>
 <87sexqoxm9.fsf@kernel.org> <CAMRc=McYAbhL5M1geYtf8LbgJG5x_+ZUFKXRuo7Vff_8ssNoUA@mail.gmail.com>
 <8db01c97-1cb2-4a86-abff-55176449e264@kernel.org>
In-Reply-To: <8db01c97-1cb2-4a86-abff-55176449e264@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Jun 2024 22:05:57 +0200
Message-ID: <CAMRc=Mer2HpuBLGiabNtSgSRduzrrtT1AtGoDXeHgYqavWXdrA@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k: describe
 the ath11k on QCA6390
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:40=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> Kalle,
> All of the devices out there need these supplies, but they are sometimes
> provided by generic PCI supply and on-board regulators. Basically your
> PCI adapter is not the same as QCA6390 chip on Snapdragon board.
>
>
> >
> >> Based on the discussions I have heard only Snapdragon systems who
> >> require all this configuration you describe. Of course there can be
> >> other systems but I have not heard about those.
> >>
> >
> > DT is not configuration, it is description of actual hardware. It
> > doesn't matter if Snapdragon systems are the only ones that actually
> > *require* this description to make WLAN/BT functional upstream. The
> > chipset would be the same on any PCIe board, it's just that the host
> > systems wouldn't need to take care with its power sequence. But for a
> > dynamic board like this, you don't need DT.
> >
>
> Correct.
>
> ...
>
> >
> >>> If your detachable board "just works" then it must be wired in a way
> >>> that enables WLAN the moment it's plugged in but this doesn't happen
> >>> over PCI. The chipset has a power input and GPIOs to enable each
> >>> module.
> >>
> >> I don't know how the boards are implemented but it could be so. But fr=
om
> >> host system point of view it's just a regular PCI device.
> >>
> >
> > And you don't need DT anyway for this type of devices.
>
> Detechable board, like PCI adapter, derives these supplies from generic
> PCI whatever-3.3v through additional regulators. All these supplies are
> there - on the board.
>
> >
> >>> Also: I doubt you need DT for your detachable board?
> >>
> >> Sure, I don't need DT but that's not my point. My point is why require
> >> these supplies for _all_ devices having PCI id 17cb:1101 (ie. QCA6390)
> >> then clearly there are such devices which don't need it? To me that's
> >> bad design and, if I'm understanding correctly, prevents use of
> >> qcom,ath11k-calibration-variant property. To me having the supplies
> >> optional in DT is more approriate.
> >>
> >
> > We require them because *they are physically there*.
>
> I understand that for all known DT QCA6390 hardware, the supplies should
> be provided thus they should be required. If in the future we have
> different design or we represent some pluggable PCI card, then:
> 1. Probably that PCI card does not need power sequencing, thus no DT
> description,
> 2. If still needs power sequencing, you can always amend bindings and
> un-require the supplies.
>
>
> Best regards,
> Krzysztof
>

Kalle, does the above answer your questions? Are these bindings good to go?

Bart

