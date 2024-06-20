Return-Path: <linux-wireless+bounces-9284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D019100B8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870501F25DE8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862671A8C15;
	Thu, 20 Jun 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgj7M79p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144621A8C08
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876804; cv=none; b=lR1KPdZjScl/4u/gx/tDJ5Knpm5sXJ58zJnmo3b7tSrqd4wS789j+4OLQ1qDgZ6PRmoZ9wAAbO/EGeL0WPsKPC1Eufq02psu9DlWJWGradO5fCfUSdTSL7PMV6UVHQDAlYGZnRRq/71mi5M7f1vJdZ574hVG8eo5UQTEj6T8JWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876804; c=relaxed/simple;
	bh=rNIOKzcwK3pdjqaqdsGkpgJmK9GSZc1BC+fo/O2YJXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRxRczJnR1Tku31mIO79wQHDSn31UJyiHShWZcYbwMBtaxgnfkVkfkP/qiXNb/1cAYRnztsKpoGPal3D/Fj76au2zRgvgevFMxxEkKvVXghJ6yld1DY4bYWG6U3xB9Pdd1K+lFMV+Gp7LS3AvmhsRDeItgysVmInKMrKzYE8TyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgj7M79p; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a08092c4dso6880567b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718876802; x=1719481602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgSLok9248zUH94CIqG1aU31X9pCD+9Gxn9TdonRlVc=;
        b=Hgj7M79p05Qj7/A6C0rnGbvvczfQT4m2k4tewcNTGa+Vyj/bsZfSD1AN8wUgXF60uj
         O+Pr0iXDHoL646cru6WVohTcaWffCAvjwGYDTvwX+shEHhdFbTxvF4ykDHXYkb4h5R5d
         y/upaP/ZFri4ydhEGkn2XE2RyTlWRV0oZCvn1Hung4v/2o5nknNUgoP83Yfz9+dfMk3U
         2vY7iMf1kjKU6+rFhSS7WvNwj1Gca7/Lw4UWG3ACTI7i7uDFZ9J1S02tLqsirrpkYksB
         UEt31ZU3vdQiYpioMPkLhB/7wddxGsPfxX/B61GCLLu6uicgyrYVz40vaA9dmin7niIi
         SERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876802; x=1719481602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgSLok9248zUH94CIqG1aU31X9pCD+9Gxn9TdonRlVc=;
        b=AkgRlNkz6VSSu4MBsUH6cuWlYUCYChWX/E+DVZ1GE+hUMTZT8En+h0JGepWUmqdDc+
         hEODxlnqiVodiskPn90zpvJwG9nimwkDCGGHYmEcATjZ3OExLs7QXXrJG7bQVrhrVQDz
         XtRDT6Iawjmdr2XSSQ41gES+2EYExwY7BX7ObBq0dSQalUj7GYvGETLrSBs45GYrWkoE
         xfbbOsaarPajqWMnJ+2C+6XSbX8vgnwnZoucS/lxwRzLa6rcNMN3o+IHRu7AKa6ptysd
         VoU28qhaIORwLJ6TPpySeNdLL7u+gwhXqF3qYJdmkv/tCaNSnRbpP5htbOYu+u0yM4DR
         uYng==
X-Forwarded-Encrypted: i=1; AJvYcCUyWYrNiNKAIzr20CjWHvBSCQZlQ8JTWf9BARJgu1zXZmx3mGLS8TlsKhu4FRSVVM1+w64S4+QECUWHDs85fe20BkiX9YzqxumHEBN+nCQ=
X-Gm-Message-State: AOJu0YwsL5DiF3VbhDwMG735BvDhGWPCIwYC7cq1JoSbZGGbQSvxc2o6
	cXbVwI+gxpBQWCz2fWizR/dCsRU0VLJVSFA4dj67F+raB9bQPS1+CxNF4QzlAI812CUE1lzQBy4
	grAgPOhs8lnc27pKGxLyofFBTUc4=
X-Google-Smtp-Source: AGHT+IFqLSKS5K41fiVpUsu27BMJJni/5wt5ZZUTYsjR0JWKIVDOOYmzUA1liNLqeUTRNwAUzGgzfuvcIT0CMCcbPUc=
X-Received: by 2002:a0d:eb41:0:b0:61a:cd65:3010 with SMTP id
 00721157ae682-63a8e1dcaedmr48296707b3.30.1718876802073; Thu, 20 Jun 2024
 02:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com> <CALeDE9O7DCPhoxdMyHmYFOjwdkPRepiaaC92QorzSTXCduZ+xQ@mail.gmail.com>
In-Reply-To: <CALeDE9O7DCPhoxdMyHmYFOjwdkPRepiaaC92QorzSTXCduZ+xQ@mail.gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 20 Jun 2024 19:46:30 +1000
Message-ID: <CAGRGNgWH9U3XeatXA9xpkLz76COuL1xjYcfXQYLTGKBxvy=M-A@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Thu, Jun 20, 2024 at 7:19=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> Hi Arend,
>
> > After being asked about support for WPA3 for BCM43224 chipset it
> > was found that all it takes is setting the MFP_CAPABLE flag and
> > mac80211 will take care of all that is needed [1].
>
> Testing this on a Raspberry Pi 4 [1] against a UniFi U6Pro AP I can't
> connect to my WPA3 only SSID, it works fine with the SSID that's
> WPA2/WPA3 on the same AP. It doesn't connect and I get a whole lot of
> the following errors while it tries:
>
> [  155.988865] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail, rea=
son -52
> [  156.100906] brcmfmac: brcmf_set_channel: set chanspec 0xd034 fail, rea=
son -52
> [  156.108597] brcmfmac: brcmf_set_channel: set chanspec 0xd038 fail, rea=
son -52
> [  156.116317] brcmfmac: brcmf_set_channel: set chanspec 0xd03c fail, rea=
son -52

The Raspberry Pis' WiFi chipsets use the brcmfmac driver and this is a
patch to the brcmsmac driver. This driver is for older and simpler
WiFi chipsets than the ones on the Raspberry Pis.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

