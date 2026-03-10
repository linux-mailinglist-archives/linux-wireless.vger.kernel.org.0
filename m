Return-Path: <linux-wireless+bounces-32802-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cESUL6l5r2kXZwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32802-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 02:53:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DE9243D7F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 02:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DECA7311173D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306222DC77A;
	Tue, 10 Mar 2026 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVJeCK5H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1ED2D8762
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107241; cv=pass; b=gXXs2xsqmJM6B1Kp6Ch1Jlm5v49Y49SJi6TVowAEnrzkXfqirpliMKzaSNbuu3DTqUfw7jM+YmOflT6leQu3efjO1sSzMZOzDCVQn0pN0AyhpcDp22vpuvqMSymKA6PvYyLQRqxjSQOcqBRrtvWoqwPh7+efiMBkLCSXsi2VDqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107241; c=relaxed/simple;
	bh=NBlN5KyU0kHRd0EUy91TOrcNkPwjsWDsVfWWuChOLbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8AsjlEC0OywIKqkKAfJmhj9Vsp9kitvgq7amVkq4KTu9G34oY+j+8X9cXZZz/crbTpALwPyJHQ8rs+k1IALNKmV6McusFygnBD+8jRcvSuEcCt2lVvIIUDQI9R9KHiTRsV7tFKolWT0w7podQU6ijf7QXKLro66APC8KP1o504=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVJeCK5H; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9431300833so526756266b.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 18:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773107238; cv=none;
        d=google.com; s=arc-20240605;
        b=NSr5V1yhWAAXrOmkNNhYJBVZJN8NyxOWo7gwNlCg5wXBNkUs87VRiIFDZIg2NyYFrS
         XJU64NWmKw2k3pwKumUWuyE2fERzxEI3H6PyIpR0u4MudhO1BoAF0pIE0mJ2AJsHOUHp
         23ntWTc+4KnTPjGecdtnK3dblHo/v7CssP+rGqy9TJ4hmHQo5gv5w8T0cHJ8ZwAAqSa+
         BwO+S4rIqoWEXY3NdDNPsK8nDeh8H+dSL8f090oaTp34f5IPUCvuUacrPb3MpA+0F/vc
         hYix6T7PhyfmiQXa13Zn5hwYIlGQycKrDvf0x6kV5COH2GqW1wi3+6VL1wIEh74LK1QQ
         TTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NBlN5KyU0kHRd0EUy91TOrcNkPwjsWDsVfWWuChOLbo=;
        fh=QTeIW9UG0zBdEjqACwa1P18H1x43Rgl3XLgi5r+zgZ8=;
        b=DWNOovt2Z7QG+LR2lcUccZexK1mwPxt+473hbZ/BeuwiqebwY8V+Uraa1NdIdBiYT+
         DiCzfmiMRIrK6cXkxNXaslCZFa1QEbsGnUboeaYcSuvpfh0wyx0fI4ULKrrp2G5I/HxW
         RSrPaXjgGMeCO65NwIonWQy5/zlQy/sFrb+nMJJ+MBwuYopgbgbU5u6DE0nqdkYvZP+l
         KDMtO8O0z6pmkQEbPVOZZw0dOyocHLw65Qc7LJwfxq6iJaIyo5+0vhuJfQvUd4tPEpFh
         7OOzUFfDA/j6tShlH+go4xhXbLsgWPEWoXjWqW+PVV/nRv2gESoeLg1RLvt46RE5mN3K
         VcGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773107238; x=1773712038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBlN5KyU0kHRd0EUy91TOrcNkPwjsWDsVfWWuChOLbo=;
        b=MVJeCK5HizPAvqSX04S9fk73TCDWTIV/2SPLDX6lavgGd5+09om0NiRg9TQGppJYCr
         zvWCoBVaR6BNBy/NW2ZCs/PKrj//Ly7OzSeS5HXn6wXLXYtHzflF9DP5JUYsTg0glbUI
         eWg+3BQl/442zbggnqDUwQtm4PNqLSvW5aF1ypEQZ6il6rrsvYVT9yEHsifW12UgL9cS
         bA1ATHfSsxwTEAGbJF0yYttEnDUILt8sgwBfObXCBTi0dBIBZ4CGW9cNx+iPqKw6k6dT
         WZMa3qdClwYjomKI1oRFasiJhiOYVh5JJRvpIKte2pJdshWDKkmx7c6dl4OegNNx4tLP
         ZkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773107238; x=1773712038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NBlN5KyU0kHRd0EUy91TOrcNkPwjsWDsVfWWuChOLbo=;
        b=dgajhPhwHBxwSksaJUjQ4QE5V21k+sKrnz2d2u5OuZ+JhHyGQ2ElfkZutuYEuVOHL4
         WZ5i+PkN0CQFiB5Vhguqsx2/614d/9olOCO9PE6kfqredONWqGnAZYgmW5MEYxFwoAUH
         2oKVqIASdEm3ImHBZo+gPUm3FcpJVjaoRmnWeAVeqH0tZlkGzWZUYu6+Tsn1gYVUIId4
         AJ4RcNlme51IC/1/pQT4649Xi4jjJZgejH7LajsyrfvzHbgdQFcgNa6+SUJBxli/D2yc
         IzhFcHU29PZerwRObURNu/N6ra3ylTqvmR0NfLDnsf+ymBvaWWbo+gmBoNdG0gtEsZKd
         lUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyU6pomu9K6sWMhneh9wIILxE7T88vr64qG+kH7IPrQyMtdW1cNWBnEjUSvzefwmUQOuLjJ6M34pCbvaln0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFdN3vDvh5oe2QatCVeyAr3qlpYFlj23zuyxGRMocqFAl8DFa
	FRziWbl5qRqvLfs7jQzTKHzz2q5uj8409BrQS6y96jlYeBj8malWQW2VHGvsgloFb67t3mg2kQf
	JnNwq6hi4bR7Lba9nIJ6jzH4TLTE3ivw=
X-Gm-Gg: ATEYQzwRTC6IiYljv/H6vhLeTzRmPbFPQrOn/pHFO3+xUcAju4c7Ty92buaTB6x41Ic
	NyKDiRcd5CL+UsDtidu9bYyI2zPDNyyuBC73kkjToRCO1q16E7RNyAr/HqezGjfgjnwYvg0KOg3
	5v9T3URWdbbDI+jD9nzXFpDVMpd5QaCyoumbxoPtE+8wfCSvK/81Vh/NnD2HEi0FXDka9bezuS2
	ISnARcp84Iz7PJ1uZY+/7a6Rb9JelbRKVasQU8eVfP3k3xtREcOyICOzVr7zrta5AI4qiCO14Lu
	8X8IbAuAFVYplhTkWZQs9hR3aDUUwAuMDdV2f+DKX7wgijTJgXRDAgnhTABK6F8XRFBHlM/dR4X
	/K27AAw==
X-Received: by 2002:a17:907:1c9d:b0:b8f:79bc:b0d3 with SMTP id
 a640c23a62f3a-b942df82589mr725605566b.37.1773107237626; Mon, 09 Mar 2026
 18:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309215907.5789-1-rosenp@gmail.com> <CAGRGNgUsVxecZobcXvVwmaHD+QHmzp4qTPGSLOpJb6Uinrpa+w@mail.gmail.com>
In-Reply-To: <CAGRGNgUsVxecZobcXvVwmaHD+QHmzp4qTPGSLOpJb6Uinrpa+w@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 9 Mar 2026 18:47:06 -0700
X-Gm-Features: AaiRm51zrgLQDKQia7UXn_pjjoGPF9vlpqAXxflLJWQ092NFPl7NmMqXjcYFJ_o
Message-ID: <CAKxU2N_i3d2Bkx-35k7COtQ15UATVJja9wrHb8Pp8x9gDnpnBA@mail.gmail.com>
Subject: Re: [PATCHv2 wireless-next] wifi: brcmsmac: use FAM for debug code
To: Julian Calaby <julian.calaby@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, linux-wireless@vger.kernel.org, 
	"open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS" <brcm80211@lists.linux.dev>, 
	"open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS" <brcm80211-dev-list.pdl@broadcom.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 27DE9243D7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32802-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 6:11=E2=80=AFPM Julian Calaby <julian.calaby@gmail.c=
om> wrote:
>
> Hi Arend,
>
> On Tue, Mar 10, 2026 at 8:59=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > Debug code requires a separate allocation to duplicate a string. A FAM
> > allows properly sized allocation with a single kfree.
>
> Sorry Rosen for hijacking your patch here.
>
> With these changes, does allocating and copying the string really need
> to be behind a DEBUG ifdef?
I don't know. I didn't write this code.
>
> The allocation, copying and freeing of the memory isn't in a hot path,
> so allocating/freeing a couple more bytes shouldn't matter that much,
> which only leaves the memory footprint, which appears to be less than
> 10 bytes.
>
> Thanks,
>
> --
> Julian Calaby
>
> Email: julian.calaby@gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/

