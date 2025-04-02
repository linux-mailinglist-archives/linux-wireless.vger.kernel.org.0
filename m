Return-Path: <linux-wireless+bounces-21060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5DA788C4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 09:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F5A3AF2BA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 07:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91820AF6D;
	Wed,  2 Apr 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joJMbcdg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1401DE2B4
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578264; cv=none; b=mbxNyK7Fnn9EaPLquZlISj+oFzNGEVrolZQNQpy5bWMevVmv+zj0ka63k5qZnurKGa65Phc6m5sfNINYlFXgUQvtax3pNg/QrPSSeDO0lZwyjJJ4Gm6gD98Wwmfa7A3i+nSswif/Hx8+R6ufDaga2LXXe47JgZhgydJpjZo+Lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578264; c=relaxed/simple;
	bh=3c4j12VqZY+7G3IdTC6KFYky7eV+Noh4DJMHQ9mUMtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Crykz60rpRdfrGEtBTSO4+25jmua4QR/HQ38HP2maUOZbV4v/fcNS/DyPTo+5MArOliUoo2eWbT4kFovnix/oMMjawf0yBo/5Nt9nZGFjPmjHFpOBheWW122qOvLGzbZ0azsxtokQ/T0kpCocxMGag/AiPzPn5pg0jyVGyTjeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joJMbcdg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so1118317066b.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 00:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743578260; x=1744183060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c4j12VqZY+7G3IdTC6KFYky7eV+Noh4DJMHQ9mUMtI=;
        b=joJMbcdgGDV8fJaYOFWYb8yOxmu6Us5Mlal+CdxvpwTk5U/ARMuLYGJMePRhCMXz1C
         7SMIxNUY625pW51M6Z8jDflLtdgCILi7TaATRL2M675DoCPmEJwZ3fkObK4NKgj3WhNK
         8bUTXl0tvdAZnXExWw1H08e525AmJktC+c3/WnsOk3TYtrUHiTtDRxw6qZiGsEdtJiYs
         qpUuA9Q+NEZ/mkbb8UWAANEH4c5WRx0SYKWaXozi8clRbmriSxmg+KLQj5KRxF5yd4i0
         N7GATjJ2P4FKPt/nF4WJAZxwuRRXFKSyUHdD8nUHwE6UJAFeTMtMbvtSWetwTyTB6eNH
         CiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743578260; x=1744183060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c4j12VqZY+7G3IdTC6KFYky7eV+Noh4DJMHQ9mUMtI=;
        b=gmmlkWl3llahKk1p1VwEKMYVzom0gGgWd8QMhxlD8v2KGMHh807qVWWxZ7DGgmFH3z
         yR01Mxox9bLCLC5zn3ixYr4deOyuN+KMn/A/IWdB6QMHLZIPeKycMrxvq1OoeBcZo750
         8SsSVjB/0FBxB2Vn5caTqOJRy8d5X1Cmpvr0qFXIVUna6tUb6fEvJV49QEsNYFTAQEo6
         1sxdOht/1fkqWJ7JM6X3M+WcT51P1tu+vVOMO3tzJHwDZ9aszV93n0jFJgIcWxwmmzaG
         78IPOrgAHYVdU8O8QsnG9r++QPKk8O+yvo2re6vPLZR2ksyX4+3KxzUyVvZxiUBEvtYQ
         o54g==
X-Gm-Message-State: AOJu0YxTxxlWriU7lCmFqFy0ZDCeRF/y6jKo+h0MpZZvfazVJmxj0ivB
	kCk5k8Jwc5aeaui1gMJBunJSKqxyKg3BUyxQqxcnQ3BM3i8V79Ja5+Y283nDqDcLRg1YQPX9+Sn
	h/fpfPCzeEUV9ioQ3/TJNn05t/HtVqA==
X-Gm-Gg: ASbGncuhQEXEgZ6kQbrxN2lrt2w00mbP+5e9hpUz2ZmpmzCbBF4wNAd5kZqWUt0qa5B
	90tSf1Sye2h/hQzdg/2s4Yal2f2N1L3SlmZzXp01hY8Q/Fm2DeTeMeENTSgio1wFmAO1pTHmayi
	XoixgJxsMerqFlZW5q8wSoiq9EYIvS
X-Google-Smtp-Source: AGHT+IGBdBkUu9qaXOWu+GNB4S7N1wHt++faZiCK4J261RHw9ii3TYJD04q26nv9qWDF7W6QVDfizo1FciQ1jKmUK+Q=
X-Received: by 2002:a17:907:3fa4:b0:ac1:f002:d85d with SMTP id
 a640c23a62f3a-ac782af6f36mr480296866b.6.1743578259555; Wed, 02 Apr 2025
 00:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401201259.50627-1-janusz.dziedzic@gmail.com> <9481e6a3844f897d03f8f4bfef335092f4ac76da.camel@sipsolutions.net>
In-Reply-To: <9481e6a3844f897d03f8f4bfef335092f4ac76da.camel@sipsolutions.net>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Wed, 2 Apr 2025 09:17:28 +0200
X-Gm-Features: AQ5f1Jqa3ew2c47pAxUOf1gMQlAcQB3yQOquBG-nkKNAd1YgqO-crwWdYiweGBw
Message-ID: <CAFED-jm3Ot3urZuDnYaWE1vyXuAMDvw_W7vuxUOjQtRqN-y0uA@mail.gmail.com>
Subject: Re: [RFC wireless-next 0/2] wifi: allow tagged control packets
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, j@w1.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 2 kwi 2025 o 09:00 Johannes Berg <johannes@sipsolutions.net> napi=
sa=C5=82(a):
>
> >
> > This is initial version I tested using Mediatek mt7915e and hostapd.
> > Guys please check/comment.
> >
>
> How serious are you with this? ;-)
>
:)

> On a very quick read: the first patch cannot build, there's a security
> issue I think, the nl80211 attribute is defined wrong, you're making
> unrelated changes, and you're probably breaking older hostapd versions.
>
Just do minimal imp/check and share RFC, while don't know this
approach could be accepted.

BR
Janusz




--
Janusz Dziedzic

