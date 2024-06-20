Return-Path: <linux-wireless+bounces-9285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D8C9100D2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EF282FCC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D731A4F3B;
	Thu, 20 Jun 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtcugpXe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E319B3D1
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877195; cv=none; b=rvGhKaEcft3TuSI3SYV/dfpAr2SjPeMB3FjNG41hUGFybtDXqjXK9SNg+tNFvJsNPhEsg7Vl0lfBmRaDsOh7d30RFrrNH2T25y6p4we0/nAN/go8IphKH0sa+FTFW85moAH2GXv/ElGZGmU3wIreLRcLQvw6EBOz8vdB2BJN7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877195; c=relaxed/simple;
	bh=gfLjd3QkChDuzoAzM3t3fnWy9YbR69Dq7dT/7ghf8cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CieTa+ZqcXGvYxKhtq+o1F04mcrhjkdqlL9fJ91CVw5TyFqwyrHHx0IuTYMf1HcgtLIUPG48GNzMyb2SP4Rfv8RXwk573zrjRtyiG5TTtSoQEm2MpcutNd4HsKw4KNKP7S6/s8tL5mShut1a6c3cUfYZ7Ly0iDfd7qKAn2bkyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtcugpXe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so1243154a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718877192; x=1719481992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VHc9yD6hEXLNpIxxUuTrYCo+DSeamUiVG3Znxi11gM=;
        b=jtcugpXeuNUpPZ1iVoJFMdXFzSjgZtysR5ks10NYpvuO+yXl1GGBlWSEaie5RLTdk+
         kYuOT38/5LdDkg+wfBaJ7hZjxByd8s7tNaPVtcAO22fgMbQbhnG+2+mdKpBbEylhUy6K
         Bri3lcvN3XJVLlF4zqcMba4gu2iLsih4aJB0NbnYOCycm3+gL23HVRPN3B9BMKbQBkkV
         WZTAFQ2zt8Gz0yMshjjxXKCi7Aj+n/WhcOqLosmEdXlHUkrXGB7T/Nsxvz8Axz/hhSms
         ZBv1xZKkVnrtsAkKAh6HLwkEi3OiyPxjr/IeMWSGWhHj9KxchiDeLjuuUPCndV5Y4YZY
         X/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877192; x=1719481992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VHc9yD6hEXLNpIxxUuTrYCo+DSeamUiVG3Znxi11gM=;
        b=IzMncm3bHsD1CUt0pMY5zyD4F9/A22IYo2uYWIj87xnq4wB7efBuUdyvq0Qe7NqvkI
         xcRnybiJ1/R8k6GzWVGM1PNadFFjopfS9VFJVW6uWtFjz9XsAStu8e44l0Og17i9QDm2
         jfkFnYvVDXOH3PLYPpwDP4JLHjFrudaCXRwl7UFkDJACAS7nU/k/yqrZ0C60fbZEmKOh
         E+iTvZPbBWwTd1jhG15xCUvqR6HjfbpLpTRMJUvQy+rQTrhPiGJwDqVj2seu3KSs90AW
         l1tcNYmg1D79js4M0FC57nlm6C/q8oOe9ay5125OLLIeCN5bzKK9BQWEBPFu5u/lPWCs
         CCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUETTIDXtSGgcwp3VZbqjI9bAu2pA0dtC/pss91v1EJ+MbaG7++xBVeyyEz3cHz4ETaa9yMZAAIEi+mAMU5lsTFPRTwqpB6IiRm16Em3AQ=
X-Gm-Message-State: AOJu0YwhopoJQFRv15ZX1JB9hz6aJ+9LvyzHlKROtZcUVEpTbN3wWIy5
	PnVM+/0BkwPBwv/xEzhQNoDHvel0v5PONO89zY+6a7U2Rg7GBKFj8RdO/GCOnE+rnZqJQu7VBaP
	4H63KNXV4n/8zyrU2sBmf4OudGgw=
X-Google-Smtp-Source: AGHT+IEEIEgMc1waOkd5VEFVPrkMLjEldUsLx6nfx4aggbummrn4fNrTftq7sf0tT/32pehTAoV+7arADnVu6AcnOYk=
X-Received: by 2002:a05:6402:1d31:b0:57c:f8d9:2f50 with SMTP id
 4fb4d7f45d1cf-57cf8d93051mr4714990a12.12.1718877191920; Thu, 20 Jun 2024
 02:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
 <CALeDE9O7DCPhoxdMyHmYFOjwdkPRepiaaC92QorzSTXCduZ+xQ@mail.gmail.com> <CAGRGNgWH9U3XeatXA9xpkLz76COuL1xjYcfXQYLTGKBxvy=M-A@mail.gmail.com>
In-Reply-To: <CAGRGNgWH9U3XeatXA9xpkLz76COuL1xjYcfXQYLTGKBxvy=M-A@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Jun 2024 10:53:00 +0100
Message-ID: <CALeDE9M78so=roEFion9GGo4tV7c+M885=ZNZgi9zKyBur+iMQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
To: Julian Calaby <julian.calaby@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jun 2024 at 10:46, Julian Calaby <julian.calaby@gmail.com> wrote=
:
>
> Hi Peter,
>
> On Thu, Jun 20, 2024 at 7:19=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > Hi Arend,
> >
> > > After being asked about support for WPA3 for BCM43224 chipset it
> > > was found that all it takes is setting the MFP_CAPABLE flag and
> > > mac80211 will take care of all that is needed [1].
> >
> > Testing this on a Raspberry Pi 4 [1] against a UniFi U6Pro AP I can't
> > connect to my WPA3 only SSID, it works fine with the SSID that's
> > WPA2/WPA3 on the same AP. It doesn't connect and I get a whole lot of
> > the following errors while it tries:
> >
> > [  155.988865] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail, r=
eason -52
> > [  156.100906] brcmfmac: brcmf_set_channel: set chanspec 0xd034 fail, r=
eason -52
> > [  156.108597] brcmfmac: brcmf_set_channel: set chanspec 0xd038 fail, r=
eason -52
> > [  156.116317] brcmfmac: brcmf_set_channel: set chanspec 0xd03c fail, r=
eason -52
>
> The Raspberry Pis' WiFi chipsets use the brcmfmac driver and this is a
> patch to the brcmsmac driver. This driver is for older and simpler
> WiFi chipsets than the ones on the Raspberry Pis.

Right you are, completely missed that :)

