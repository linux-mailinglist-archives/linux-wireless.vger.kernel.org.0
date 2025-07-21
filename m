Return-Path: <linux-wireless+bounces-25774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998DB0CCD9
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 23:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82376C3937
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1E21C190;
	Mon, 21 Jul 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6fLzHBH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35406203710
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134611; cv=none; b=k3orVadrRenIPGCIz0SiTxNnWoiQuVdKJEKrFtf9p2EcAllC7IoN/TeUr8pXDztF3UuvVM2DrbevDvQ5Nb9+Aa0XQ8HzCYUMDYi8Zba5Ck+RAFRrkv2Ibkm3B2lzomGSYObg2GbUkfPymFyQ1tvCv1v+GnQtpdWRliVSMlxFHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134611; c=relaxed/simple;
	bh=qhtWDUO4sns6nxCpFEYKNVcTP1ZIn5b3fGq/f+Hx6uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwcDysUI9jop07QNG76GURkTNMT2x7PqM0CzqoTXe2aEm5V5YcyB/f2gOsWKHA/3HZebzuEZ9C76jJztDGa9ZpSvyfCBuQGuviJoTvwuTN+fglO3/iXfo34VPOFH6aeV0lCcpvFit5yyNUrdx+RVdKX0DlwUMUISdoWJYcGMBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6fLzHBH; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8bd2eaf8ccso4448394276.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753134609; x=1753739409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NjSFTK7/jtmmy4Qgy5FYJA9GOyMmTJFi70ip4qLJxOM=;
        b=g6fLzHBHl2KOaRdgG32PnepLfkhN6RyGmKvLRnHU11yfyLn26S1fhaXIyJI4PN96is
         bVApnaClK+MchzuawM9+VK6BlSbqbHRKwcTWHYE3LSHxv8J1s93jE2NjFlFsEGz1sv/w
         jIdWMxcN0U02bte9ODlONuqmvMbxrzZSVehG0yCVmujDYYLULhl8ktcIjjwt0rrQbRAs
         GJCynlvyPgTE1gHmSXaX6K0tU6V1wEr2IvmZ5N3bWWsXkgxVudcjwjWJmtAToH2pWZzd
         ViUDk+jfBft+UUHOEjCot8QM2cDe9iCOVPR6Zp0NJzcUCFZAsKo8fYqPb+ss/bqySDpM
         WpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753134609; x=1753739409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjSFTK7/jtmmy4Qgy5FYJA9GOyMmTJFi70ip4qLJxOM=;
        b=MtVElC0Oo3vGAZxz26GbftwTsRMQytOe7bZWWq/10a7Uf8pFlrWJVr+c+66l6ntTpw
         ArWUFGUWcWFBCDpl+loCaLLMrIfyulYJu3eJbVbTI68H6N2jPaEx2deqNMZ06X+3ExOi
         vhN0Yq0hWCcrJgqcqi5TabQt6VNgD/0KWQeN68tKRXwQdzDi9Dtye9pjnb9Gux7NdjPP
         Skd4b4iYrf+ay4tTYF+46If8jK8D7Cb06PkIZRKXnMlrxcRuGuricgbrlgFqW2N3z5NP
         z692Vct+lemUIZ7NWO1pRAzaf0hyPayVJnD2dHg9F/k6TYiVkv7oVNMNi///LkRXRMn/
         T+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqSPsUb230S/zrf304s6nIbIdwWHvEWnKw9hFvmhVf25HGMWq5i0lIFfnrkxqMwtDlmPhPTIvXxTOwNfEI9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpNC90W6afgGHHwSyAk9sjuKv3oaB3cNla+ZIfQR/wDwIDnTV
	gqLxW4fE8WilpNgallI74zOkk79U+bFJp16N6pgWZVq1Oc9n3MO7Wu6vW+tD+aU/8gqldoSHUEN
	jlDCAsYObvIEj6xD+tlZBfjde3OGQ7EA=
X-Gm-Gg: ASbGncuCVsNJC1gy8/gG+7na8Hhp7fjjgTmPbgJnoo97efvZ6/E1f5GjgG0dKtEtlDX
	xKSogZop3LyM1oTQIbMK0UEhmvWaEy3jVr0rWDZXfC5+DWkyJzM/dBkG0oBg5qf0OO4SC79sYO6
	H+lJ9zBQLySRJ8qU36UQkSGDooGWLDm8Ptnc7GCFvbou3NobHAwHGlPFU3EYftfN0yUWmOGY57f
	AJPxg==
X-Google-Smtp-Source: AGHT+IHp/QbVQpP/iW3i0q+M7DawEhqXJBs3W2nF9CrWya5gk5Oil5znpkrHUlUK8ishKwyW/R30sNoCM3IK6kLc0uk=
X-Received: by 2002:a05:6902:2289:b0:e87:982c:5524 with SMTP id
 3f1490d57ef6-e8c5f8ac5dbmr19834485276.24.1753134608982; Mon, 21 Jul 2025
 14:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-XvFvGigpY7JYFn@debian.local> <20250716184226.GA2547862@bhelgaas>
In-Reply-To: <20250716184226.GA2547862@bhelgaas>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 21 Jul 2025 22:49:58 +0100
X-Gm-Features: Ac12FXxNXBAeAhVAwWwxwk96-aVdQChQ7gw5acnVbXB8GPPK7GVjU3cHaObwRy0
Message-ID: <CAP-bSRZ+Ovj-MRVU9H5_nruA2wSTZ73Z1VXTbf4FFaPWVXP9dQ@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi: probe with driver iwlwifi failed with error -22
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 19:42, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Mar 28, 2025 at 12:36:38AM +0000, Chris Bainbridge wrote:
> > Hi,
> >
> > Laptop: Lenovo Legion 7 16ACHg6.
> > Wifi: Killer(R) Wi-Fi 6 AX1650x 160MHz Wireless Network Adapter (200NGW)
> > 04:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:2723] (rev 1a)
> >
> > Wifi stopped working in recent kernel builds:
> >
> > [   20.907824] Intel(R) Wireless WiFi driver for Linux
> > [   20.907955] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
> > [   20.912024] ee1004 2-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
> > [   20.913666] NET: Registered PF_BLUETOOTH protocol family
> > [   20.913670] Bluetooth: HCI device and connection manager initialized
> > [   20.913806] Bluetooth: HCI socket layer initialized
> > [   20.913810] Bluetooth: L2CAP socket layer initialized
> > [   20.913828] Bluetooth: SCO socket layer initialized
> > [   20.917455] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x100530 wfpm id 0x80000000
> > [   20.917674] iwlwifi 0000:04:00.0: PCI dev 2723/1654, rev=0x340, rfid=0x10a100
> > [   20.917679] iwlwifi: No config found for PCI dev 2723/1654, rev=0x340, rfid=0x10a100
> > [   20.920126] iwlwifi 0000:04:00.0: probe with driver iwlwifi failed with error -22
> >
> > Bisect led to:
> >
> > commit 75a3313f52b7e08e7e73746f69a68c2b7c28bb2b (HEAD)
> > Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > Date:   Wed Feb 5 14:55:42 2025 +0200
> >
> >     wifi: iwlwifi: make no_160 more generic
>
> https://git.kernel.org/linus/64dc5d5e341d ("Revert "wifi: iwlwifi:
> make no_160 more generic"") appeared in v6.15-rc5 and reverts
> 75a3313f52b7 ("wifi: iwlwifi: make no_160 more generic"), so it
> *looks* like this regression should be fixed, but it still appears in
> the tracker at https://linux-regtracking.leemhuis.info/regzbot/mainline/
>
> If it is resolved, can somebody send the appropriate regzbot fix
> command?  (See https://linux-regtracking.leemhuis.info/about/#tldr)

Yes, that revert fixed it.

#regzbot fix: 64dc5d5e341d

