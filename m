Return-Path: <linux-wireless+bounces-22100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79BA9DD18
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 22:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8516D17FA4A
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CD718BC3D;
	Sat, 26 Apr 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxc234w6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16921F3B8B
	for <linux-wireless@vger.kernel.org>; Sat, 26 Apr 2025 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745699184; cv=none; b=Rilcwx8YGHywaG70UmhTbSCBdouqqD7lnGOd2NY0o8eFUtU52WaTf6QiLQzMEusvqH2h5bR9j0/RT8PzVe6NcPHyk2JneAb+Q+paqB25jy2iWE6VWGzrAmHSNSCeVZNIemRryRJkD+XKgunnwGCr7n9rgOIQHw9zW9+v9UJa7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745699184; c=relaxed/simple;
	bh=IWYCsK8E55AIvzTuqnP1BM7/cbrjf1ZpugdXQWx/71A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tid+eGED3VS2Tvjs5RmsAgLz2JcbW33gm0ZGmfwFjqSes1nTiq0X7LbVdOY10MtuXgMGTNNHfopxz5dQtH0uwWLpDqfKq+DGfks+p1YRnFVrmMae7huFrC1D/CESBIbR9c7C1oiKE+XjTzfcRKSVRDlikrCO3XCBBFcwExREq9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxc234w6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso4303436a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 26 Apr 2025 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745699181; x=1746303981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWYCsK8E55AIvzTuqnP1BM7/cbrjf1ZpugdXQWx/71A=;
        b=kxc234w6ZsPLeL6cm/c6qPndo6ELKFBBoAa3NUHc72nzUb70mU92peTAn2YkcFbViN
         DTTd0x2xyzdwKWbRbgEumhYTFJ9PBWSIS+JBnXOajexHpHRqlqbpzmM+h/xHspvScw/C
         lcQHKNOBP4AhcAa+fsjFlwBW+qQzRN+4sOMON2fiKTlJjDHPzQQo6IpTRkxF7VJz6u8f
         m5bQWnv8lWu8XEpd60nxxssH1H+7hbOSpaP4xmyoz5pPfOuuHd39lHimvMpj41rjLWHs
         QfPFpQyTCxNEgHRTMJ9wN6bUgEZlY5cZAoKKY03BpHjI7fitG8vsxQXbuHaq1tQTnxE+
         uAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745699181; x=1746303981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWYCsK8E55AIvzTuqnP1BM7/cbrjf1ZpugdXQWx/71A=;
        b=Zri83uBKwuouPty/5zyISYZ4a8TqNKQUIzkiryBIvg85J9Nwy2j3DAfden9psmHINu
         qz4SnSkzR2ap4brwtbTScnIcT98oRjwMatkx7Ms58hIpMhvbmgfw8lpQLvv8QmHgFocb
         F1AZE4bYccTCiTabDMnqXrhYzObumo0aC768PU4+a1YgXrT/B5996XGS8+awMgmjRgFC
         eTfhoKFVGMgIffNwhb72iGXNcSOv0Q0hOwoiM9nCFwXPsKLPQHsGbasg55pqUv8FSaS3
         oOhyl+I7uUQPJbKk7gO+atA/CjjCi+zVEimjHQQZvttS0IN8F0kOcrRLYqyiiuiL7W8q
         quxA==
X-Gm-Message-State: AOJu0YxJ5yNY4W/oydJwskqiloGXUYM/v/N+TGSmzOfVWfYRIJ7G/tf6
	NmUzDWL974OltBYEhE2WDd9AXALBHB5ZcrHPA9R5jnVRfCrktggyTf/0OmmN9exbw1GJm4WQvdq
	VI+1vaiNGQfvW0HAhap1lj+tc8vWNlYnV
X-Gm-Gg: ASbGncs2dGscXS69s7BlGY8Qf4myx28oqCnj/lyvSRFgXmafVK3QZOJ6vafa2vBidvD
	dhQU6Tzdy/c08MkLvxc9t1lE/h1NHf0iQzqWX8W1kCBH+wyafvEAxK0nu7T9O9HK1nZGyb0O6cr
	bSXPdTwyJZeJw6ClE133RUOv3t
X-Google-Smtp-Source: AGHT+IFdfbLsjYpcG/n0xno9SZLYPMwlQhZbFwbEwWwjTL9ndhR73BUcpJk91fRXYsYOK06MaqCExFcYSdZTJuc/mPQ=
X-Received: by 2002:a05:6402:3547:b0:5f4:5dfa:995f with SMTP id
 4fb4d7f45d1cf-5f722690a05mr6061228a12.13.1745699180708; Sat, 26 Apr 2025
 13:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413160455.158335-1-janusz.dziedzic@gmail.com>
 <0c995a29d73a99084add34ef2b56b0fe673578c4.camel@sipsolutions.net> <5872dd78f2f947b27f3851e3f425677a2ddcf6d4.camel@sipsolutions.net>
In-Reply-To: <5872dd78f2f947b27f3851e3f425677a2ddcf6d4.camel@sipsolutions.net>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Sat, 26 Apr 2025 22:26:08 +0200
X-Gm-Features: ATxdqUG8PAA6JP72w4qe0AdNZLAImsPm52bhBW62nX2pluUTyfgq3Bs9AbHmFkk
Message-ID: <CAFED-jmCc6JZhxBPUNSHoYiaXN0pNPwvSyeGf4qHzUdAQAHHAg@mail.gmail.com>
Subject: Re: [PATCH iw] iw: print HE mcs correctly when mcs_len
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 23 kwi 2025 o 16:44 Johannes Berg <johannes@sipsolutions.net> nap=
isa=C5=82(a):
>
> On Wed, 2025-04-23 at 16:43 +0200, Johannes Berg wrote:
> > On Sun, 2025-04-13 at 18:03 +0200, Janusz Dziedzic wrote:
> > > Print HE mcs correctly when lower layer
> > > report correct/real mcs length.
> > >
> >
> > I applied some other HE related patches and this didn't apply any more.
> > Please check/rebase.
Will send v2

> >
>
> In some way though this also means your kernel patch _did_ introduce a
> userspace regression, so I'm not entirely sure why we should do it at
> all?
>
I think
 - only HE report wrong MCS/PPE len - EHT report it correctly
 - only bug in iw, hostapd recalc it based on HE capab
 - looks odd to skip kernel patch only due to some user mode app bug

No strong preferences from my side. I also recalc it in my MultiAP app :)

BR

Janusz

