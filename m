Return-Path: <linux-wireless+bounces-9420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D8911F36
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60FC1C20A89
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B4C18E20;
	Fri, 21 Jun 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="Nb8KXGQD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98175168C3C
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959662; cv=none; b=MUgy9vIcb0p9rP7EshvUhntqlLTLFscCxgXtcYPxU87Jh3EBxZ5QYhdoaL7EVMW7Cf+HErEdyoEUOEICtFG0Z+Zg6y+Tq4SuFCZuvGNxCvy3wsQWj7UjUkgawEWO6oHCVznuhhHaLbFELsfQx1pbQh0SBOu3Ea87nKJdz0UTCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959662; c=relaxed/simple;
	bh=IDMu00mV1qaVpBkrHZ5jMnVpkSyXptp2t4w1GNmg9GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNLz2K/WVkloC+tvGFZt//RgyepPXvyplUuFuA2FTUhW6a+FG2XnAjICXlCiTxo5OY+8u1tpMj8CpfpM8X9ZSGMkb6kXbQFEkafdMXbwgHt8h/IQoR02fWKv8Ttl9NcsvE1OqmtrlWDjhiu85/ZYQggBZAft92irWFOEZE+xl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=Nb8KXGQD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso1158054a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1718959659; x=1719564459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDMu00mV1qaVpBkrHZ5jMnVpkSyXptp2t4w1GNmg9GE=;
        b=Nb8KXGQDwYcJVn9BlfoPV4m4MybO7xTDygUiX2BBvFNNftNRLVBezOzCiZTaqBzZ7m
         9ZcbGjx5v/6y+LG1DKt8elW9bY74HaUi7XsflSMAPSMzRgtnQZf7H5ZvW/Wsf6mX+tP0
         gwjTBrO8fXJCnUY9vJJz22jXq4TQjkTEHuqew2LH5X8hjRM56RnfaE89/BRUR+A991D6
         e3CKPZHS2dehqS4SGPDgc6YhbkZ/xmYKD5GczthuWYkxPN/ZXT67TCSaUaKvKFQgAH2E
         EHb2lrEWTMtMe8OYI03G6byQyqZs8m4g8nW7VhR0ioQWkyloV5kv++U+MmDdRNFirXRS
         0aDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959659; x=1719564459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDMu00mV1qaVpBkrHZ5jMnVpkSyXptp2t4w1GNmg9GE=;
        b=YpD/+VfuoTxnyQNUhpTmBihk+yxQMzUg4jF8HeYskPh/sVH43HSUAUE2ebZO/NkkuO
         JATdK/UEouCofg54UDFf3r8jmNmpS6/Gj+g9pMIumV+1CNPya46BKX5v9KsvYqDFq9VH
         +u8dC8Ak+7QSPs5XiZuf5YPX6U0gKECm27eejJcX472vs8WAEvPQxrYxAx5QvYJ/YocV
         4rnu4qmg7gE+4ihunOxYZYBxHycO9EduG9CwsS2OYioGlJNwGwbZWu6rMDDI3hwPH1tj
         gS9BD5fdExYckhi8ZFF4de4WA/WKbJuTgPHVakThlUzgceXNMv8U6NJIsGCcJ27O+4LA
         JcHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiGOPUYpKq7jJaGDXEXXK1wr90DK8Ida/S7XxMGMsHLga5s+tNiVcN+hfpPunCruifGh90s7x/7s5VJIN4JU0/nxHlFrRyln0dfoHiVQg=
X-Gm-Message-State: AOJu0Yxn5ajfk0bWG7KWz6zRRwoHaGr/fQpAnfR++4y9IwhM1cztTWcs
	ERgV9iauSdWlEiiFcm60sHxxIVvjLYHr7njX94Ie4cTYQl4kJUzEbsz/8uK7vIbokuOEsNCoNO1
	YPpRS6uBB7yGZ+3JuMho0FxFiw24xSk5pxStC0mWXu8lZ0SBaPTd66g==
X-Google-Smtp-Source: AGHT+IFbHYh8icaOhJudVrdY/YTgZkwzGJ1/e/hmi87432nITQ8twIZwgr0tJr4hZwSyjkLTGFiZ6JIyQ80ckbc3C/w=
X-Received: by 2002:a50:8d14:0:b0:57c:78fb:1a32 with SMTP id
 4fb4d7f45d1cf-57d07e82ab3mr4394205a12.19.1718959658908; Fri, 21 Jun 2024
 01:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
 <efc8cdc0853a921ce4dad1a36b084608fe0b01a8.camel@sipsolutions.net>
In-Reply-To: <efc8cdc0853a921ce4dad1a36b084608fe0b01a8.camel@sipsolutions.net>
From: Koen Vandeputte <koen.vandeputte@citymesh.com>
Date: Fri, 21 Jun 2024 10:47:28 +0200
Message-ID: <CAPh3n834eg1_+gmh_LMTQnc95aLBWNVOANjZsMap=_szOY2nHQ@mail.gmail.com>
Subject: Re: ieee80211.h virtual_map splat
To: Johannes Berg <johannes@sipsolutions.net>, quic_jjohnson@quicinc.com
Cc: ath10k@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:21=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Fri, 2024-06-21 at 10:04 +0200, Koen Vandeputte wrote:
> >
> > memcpy: detected field-spanning write (size 64) of single field
> > "tim->virtual_map" at
> > ../ath10k-ct-smallbuffers/ath10k-ct-2024.03.02~eb3f488a/ath10k-6.7/wmi.=
c:4043
> > (size 1)
> >
>
> Check out commit 2ae5c9248e06 ("wifi: mac80211: Use flexible array in
> struct ieee80211_tim_ie") ... :)
>
> johannes

Ooh .. fixed already :-)
Thanks a lot for the pointer

Jeff,
will this one get backported also?

Thanks!

Koen

