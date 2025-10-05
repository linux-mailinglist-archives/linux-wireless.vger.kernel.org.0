Return-Path: <linux-wireless+bounces-27816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A236BB94C1
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Oct 2025 10:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FB12345835
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Oct 2025 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BF71F12F4;
	Sun,  5 Oct 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mPSfjFj6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5C1F19A
	for <linux-wireless@vger.kernel.org>; Sun,  5 Oct 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759653500; cv=none; b=Cjc2Re1IdQGt4W/3YyM+z8gW8bWskDgWPWtWPOhs/ARRuLUgAFh/v7NMFB8pGHewV+SWYd/cq5Gcwu4iHFhSOw8te4Tg0rvGhNkq3v8fJus3QItdyHTgu1JDBzdj2WmipYB+vDS4F/3Lbem130dJFF1Gy47GTyw+y4DfqBDUFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759653500; c=relaxed/simple;
	bh=3fqWPSIJd3csmKZXNaWWqZ3XRDeayAB5rf7z0R2exvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmKdxqJqhQDr7EwqwV+/ZHCw8w/iUG467T5zMS6x69l5KXkeN4ru75XuPocp74QzVyaAIhxHwrT+BbqCaJ4WMMnAck4Osf/AOnhRHI1bPL9FgPPj8ry66Zu8xhzv1hwNuPx+aLouXSGS1QtlYQTG6ksJpj/WgjBAh5v+7JO861E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mPSfjFj6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-367444a3e2aso47213871fa.2
        for <linux-wireless@vger.kernel.org>; Sun, 05 Oct 2025 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759653497; x=1760258297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fqWPSIJd3csmKZXNaWWqZ3XRDeayAB5rf7z0R2exvo=;
        b=mPSfjFj6Wqfxn3fwpSqWJx87aheLRCYmRJUztu2vObv8J4vLEdpFmz40XizaAhddPn
         gUo61X3era7lKGtAzhPgSSNgDxqCcPYEkwHAxossxwlkoO0nuxN59tYNMo4wXyzh92A5
         miPkXGRRmlYCZHrjYOPnSk3a2DpXkl6n7oTBuh8gNSn7eIldvJKy6DQSTOPJPIKeutDw
         BTOBXCD2p8fVmIQwQtRjXA/akZ/0HkqTZ7NGMCOo1gg1PttGgDNq+i/Z05V27JnPvmuj
         eXOkbI6yQpTt19+wRy8bzEOKgUqVUaJazwEjXFL4qMipQu5lUqPvV8HjCgwlNNJkDETp
         PTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759653497; x=1760258297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fqWPSIJd3csmKZXNaWWqZ3XRDeayAB5rf7z0R2exvo=;
        b=R5j882PHKUOI53GSU6aFbiHPuH6KWqBPMjkOeLzs82IozufXGOqJG5Tbf6i43exW8n
         0tXhgGMmuFlk4uIjNLRWEau/bKDd5I+Z1H6DuJh2gBCBLnc5ws/CHQp/+nHwn0nroImi
         x86iqPVTQ1RfBEeS37DVtik68aeIdtBu1yl4RvsA6DgYv+xuZr0h8xMTSLDZJIG4vg4u
         2vUxupsOvPJYv+PS71aSwEninMhdvr5Ftit5l+Kczkea+OIpO13Ar+PKWhpOsMajthUm
         kvLXoJ76Jth2CVr3+xmF44bq0fh28FcKnJitB/hylaG/SpBLrTQi9dAVDZcVJsoL/Yhf
         BqLA==
X-Forwarded-Encrypted: i=1; AJvYcCX5+MmWgDyq2arV0s4lMijiXiKOg6yI9VoQaGXIPUW2P37XNXyirpyKqFOQKidDqA6NTFmJbRYh3eHG7A1OLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBoRITbwVozj0uKrm9pj8tfq52q7Nr4++C8UyltjrfVNnQ81s
	saawLOqEkkjgTXWSoJd2fIjODjYVx3TkpoUYlQcKyyESeGrca/49sH8tnYCD6k6kNhfaptpafaQ
	DTIn5S0oX4mGWU6icr4pKcIFPVoUG1kBd0mzqAuE36g==
X-Gm-Gg: ASbGncuKDFxY3oZn5vfVXnaVBT0ja1dR53Wrjl13KfBIiR+T4LySNOyNyrYuSWR6zEC
	eOJaTERsKEtLn2lTz7IpvatsG1e07PdcRarOnauULkg0Mel29m4EvjaeNAan4Fho79VyIhKsTDs
	GsvQ/2pj7Nrw7BjJPCsxkDKroPptLL2OJV/zQmyg5a20jQxzL/wkdAK7vqnTNIKtdQSmUVidRsd
	tLjYkoW/b3D0cNjasllctQ6Cp74aDORhVSfgXiA7ymlGmxsw3Zz1wjDYNml7gZp9dZ2iuOk
X-Google-Smtp-Source: AGHT+IEINNT+1HcIX5qvEP3cKB0i3Rl+j+gRT3t5cn5mZ+kseOJQ3GUfdRwHB/qOyZHhmlkOW4wkJiqmUqqo9GnyvTQ=
X-Received: by 2002:a05:651c:2357:10b0:372:9780:a2b2 with SMTP id
 38308e7fff4ca-374c386133fmr17808901fa.39.1759653496689; Sun, 05 Oct 2025
 01:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004141539.6512-1-brgl@bgdev.pl> <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
 <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 5 Oct 2025 10:38:05 +0200
X-Gm-Features: AS18NWC7MOPcYjLRf-YXTIdh4W7Riig9juU3nPGCdB8PWtzaZXoX7i1GOtQ5KMA
Message-ID: <CAMRc=MdtkAFJBGN1biaGDLjgwjuzJ=kjDzEWbrX+DX27e8jYhg@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Berg, Johannes" <johannes.berg@intel.com>, 
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>, 
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "Peer, Ilan" <ilan.peer@intel.com>, 
	"Gabay, Daniel" <daniel.gabay@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 11:00=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Bartosz Golaszewski <brgl@bgdev.pl>
> > Sent: Saturday, October 4, 2025 5:19 PM
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>; Berg,
> > Johannes <johannes.berg@intel.com>; Anjaneyulu, Pagadala Yesu
> > <pagadala.yesu.anjaneyulu@intel.com>; Grumbach, Emmanuel
> > <emmanuel.grumbach@intel.com>; Bhaskar Chowdhury
> > <unixbhaskar@gmail.com>; Bartosz Golaszewski
> > <bartosz.golaszewski@linaro.org>; Peer, Ilan <ilan.peer@intel.com>; Gab=
ay,
> > Daniel <daniel.gabay@intel.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
> > REDUCE_TX_POWER_CMD ver 6 and 7"
> >
> > On Sat, Oct 4, 2025 at 4:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > This reverts commit e3fd06d1d8869747e02a022e3c9045a3187f3aa5 as it
> > > broke wifi on my Thinkpad P1 (Intel AX210) in v6.17. I don't have a
> > > better idea than reverting as - contrary to what the commit message
> > > claims - this chip seems to still be using the commands removed by th=
is
> > commit.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> >
> > And here's the kernel log: https://pastebin.com/zrTPbE0j
> >
> > Bartosz
>
> Hi
>
> I think you reverted the wrong commit?
> Didn=E2=80=99t you mean
> e3fd06d1d886 ("wifi: iwlwifi: mvm: remove support for REDUCE_TX_POWER_CMD=
 ver 6 and 7")
> ?
>

This is the same commit though, right? Am I missing something?

> Anyway, for fixing this issue, can I ask you to upgrade your FW? Then you=
 should not see this error anymore.
>

To what? I'm already at iwlwifi-ty-a0-gf-a0-89 which seems to be the
most recent firmware for this card.

Bartosz

