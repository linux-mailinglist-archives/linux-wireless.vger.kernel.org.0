Return-Path: <linux-wireless+bounces-17141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06539A03D2C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 12:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B266188661D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110391E501B;
	Tue,  7 Jan 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyyHy/5h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B891E47C8;
	Tue,  7 Jan 2025 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247678; cv=none; b=X3wq0J9+WxFKisw1ssfnvbTl9NeVq/acUnhJDqw/dSeQ0xL7GUoBDFFF94x0rIYdE+0yjL4hl9RAUvkh4U1fCBTYfBKF+QELEJl3QdcZw34NV3SVBBHh6eshO24tr77gs4js4A2NmWIz8sUt3tWtwUT5UrjGTcRJAkshsEtJJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247678; c=relaxed/simple;
	bh=KEKrs8t58jaBmhFQsL4Q4hxanzR/VOGIqdOtudk9yYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixY1RWmUCrnw/qZY+kDhiCatHIV0fLZKNDSzsNk+ZvlQxFy5KFAH4vny6zT+D5qhdUHrBB/w1IFNi/frSq1DHcfh0/NwwyjCWKqrqTBeXy1jtP6sG0mp2OIX0/0QAjRm5rd3DBOWQgG0Ui6lrCPOUDtssPls6dHexfw5d7VW+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyyHy/5h; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e4419a47887so19406897276.0;
        Tue, 07 Jan 2025 03:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736247675; x=1736852475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEKrs8t58jaBmhFQsL4Q4hxanzR/VOGIqdOtudk9yYw=;
        b=cyyHy/5huF51Oj+fEAMIUgS6rWFvx4bTB+11Wlf1OU3hfTaAVest3OetTgR2xJeM24
         rUCwE4cBUV1FV2PJd79Q7UPdB7xT+V3F29KFoGxVr/4H8f26ux9Yn+HdTUKVX3DvPDKt
         +37TEQU7hi2oufFex1DGm1O/JRm97pokgx7PkxrOoZjvtUfLNRfe4QkdGhbk+OB0gDRD
         ZIAmpZbzPa1ucA0UR8jYLcLkMaL05kqcTDd4zWC47i/CC1FEcXwdU/VTC5YBJipARKD6
         5qkV9zFlYzOn1eklkB3sMuU57l2hDu78+1j2GJl4p217y2sZLu9rW3RUwsIazFZ/hy01
         64Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736247675; x=1736852475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEKrs8t58jaBmhFQsL4Q4hxanzR/VOGIqdOtudk9yYw=;
        b=mazqz7QCVEr9RHNMFXPmL6npCd5bGaafhjnM8QsKgSqtXg49iamKnx7yv7j6CAcP1s
         BbXjIIeeCkfdaSEegiOWe7kgiEpxSQfOvBh1vcaqZLibKd4kDNQyVnPDU+tYRRqXX7gK
         Bv6c/jbxlJICXdWPDzra/xWdugd+QD4AeNlBdcH48BBHGA71KPRqTQWc65k0VEspQfqT
         9lnUH/ek+JwVERPNdMgaACTSuXX+81A5UD2zvUTJiBMYNPuwmFYd6Bi5rVx96xZyXUO3
         ErWbbpC54QOjUX4kpxaCYJEaPihbXA9ewnH6Wh1fT2YJ53s9PHai3MBXYhjRU888ryEK
         AiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmslrOXTtKxrW6pACVT5TAhD3LbxB5h4g5dWAp5npxvSnuONdDGN8dHvU9XxC12scnp0R56mqL@vger.kernel.org, AJvYcCV0U+XJodV7+as+fau/NYkPwtD2wdYQ/yX9AD57rygZltAxpbv0Ce8mp9lxOZgMEj/6EQ+TTOg6pLBHdEU=@vger.kernel.org, AJvYcCXzD2CK+SWvQq6bos3cBj43WWq0o4dGrx59HSmKvuu6ZoZuY7Y6HpEl0aPyAv0mj0O/BroULpGd8Nc1oBUmbBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFmM3bdASwH9pzBU2U8g6LYyxO0OnwGK5+pFUGFGMGLQZbeBPk
	Whrins/IfKEkKlpgl1DubyX8MyblissRNWqp4c7f8pXRap9obfRhMIZbdr0bgZAKS60/aigOseQ
	AuLlQUg3k24PCUcG+CgLhIGdWH5sQMQPS
X-Gm-Gg: ASbGncs0bfIk4Orktn05pStNDqZxJql27XNWH7ry18wqSx65NQU2Ktmva/slYkQiE2M
	K/ahu0gQ6+p4yEG7AfgC9Q2J0P/JXDarMygaU
X-Google-Smtp-Source: AGHT+IESbclHNi0aP0xGBKr3deuAaZJDr4lG0Dh7OVv9uwUcMBSKaPSMR53J0WwFXMrMQJrmWAWE/FkpXxZoRbiTjjo=
X-Received: by 2002:a05:6902:c0a:b0:e39:772b:4bae with SMTP id
 3f1490d57ef6-e538c207517mr39123922276.6.1736247674657; Tue, 07 Jan 2025
 03:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
 <20250103085540.GA94204@wp.pl> <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org>
 <20250103131002.GA100011@wp.pl> <2f7a83-6777e880-a451-5cf12280@99910178>
 <20250104103753.GA2228@wp.pl> <2f7a8b-67792f00-52db-be99fc0@193911177>
 <Z3r3vxy8cRRH6w1m@pidgin.makrotopia.org> <2f7a84-677b8500-5061-4ac1e700@152950135>
In-Reply-To: <2f7a84-677b8500-5061-4ac1e700@152950135>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 7 Jan 2025 12:01:03 +0100
Message-ID: <CAOiHx==4Yg=Ne0SHWx1jJTJF0QziVJYxdp0mpAkd-GkVfp+tWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rt2x00: Remove unusued value
To: Ariel Otilibili-Anieli <Ariel.Otilibili-Anieli@eurecom.fr>
Cc: Daniel Golle <daniel@makrotopia.org>, Shiji Yang <yangshiji66@outlook.com>, 
	Stanislaw Gruszka <stf_xl@wp.pl>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, =?UTF-8?Q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>, 
	Linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 6, 2025 at 8:23=E2=80=AFAM Ariel Otilibili-Anieli
<Ariel.Otilibili-Anieli@eurecom.fr> wrote:
>
> Hi Daniel, hi Shiji, hi Stanislaw,
>
> On Sunday, January 05, 2025 22:21 CET, Daniel Golle <daniel@makrotopia.or=
g> wrote:
>
> > H again,
> >
> >
> > On Sat, Jan 04, 2025 at 01:51:25PM +0100, Ariel Otilibili-Anieli wrote:
> > > Great, then; thanks for having acked the patch as such.
> >
> > I just noticed that Shiji Yang had posted a series of patches for
> > OpenWrt which also addresses the same issue, however, instead of
> > removing the augmented assignment, it fixes it to the supposedly
> > originally intended way.
> >
> > See
> > https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dpackage/k=
ernel/mac80211/patches/rt2x00/621-04-rt2x00-fix-register-operation-on-RXIQ-=
calibration.patch;h=3Daa6f9c437c6447831490588b2cead6919accda58;hb=3D5d58390=
1657bdfbbf9fad77d9247872427aa5c99
> >
> > I suppose this was tested together with the other changes of the same
> > series, so we may want to pick that instead.
>
> Thanks for having put some time into the research, Daniel; I looked into =
the openwrt archives for 2024, none of Shiji=E2=80=99s messages mentions th=
at patch.

You didn't find anything because these changes came in via a PR on
github: https://github.com/openwrt/openwrt/pull/16845 :) OpenWrt
accepts contributions both via email and PR on github.

Best Regards,
Jonas

