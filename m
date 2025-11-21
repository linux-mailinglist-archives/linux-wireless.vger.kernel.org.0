Return-Path: <linux-wireless+bounces-29229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E14C78399
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 10:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5CC7230BCB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02542E2299;
	Fri, 21 Nov 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QsjQed6c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB5288C0A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717632; cv=none; b=rTfTlItj+VAaQYd5s+4C/RflM9GfOoewQA891XWrJJ1zzrWDAZ+4PKKKrLYEBC/2dxJDxxUOpMV6VDH5CiGQw/ImU+3Lk+5G7MLUnHVAdY0yVapl9oUFCv8ydoy0dvcTGZ0HMz4SWAZku6mSa8VIWSsxbqIzMXLkOywz2MsvXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717632; c=relaxed/simple;
	bh=RxTR859+35fhg5hi/7dcI2n14zdxbKcn1iVduYrLEM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ic4bC2YVq+jWnxZLPNvVoweAk8BwjOOmSm3P9mSb+43wwwO2X3H75hyhlKRc56kcnV/Fna6OrAPoK2Az7eguCJhtVTcJlVeVLPvkomGnNhWP3m13mMmt940tiYZBcnzIloJrTd4za2a7oN9pQfK2c/o08nifk/hAwe8lYU6UzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QsjQed6c; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5958931c9c7so2082705e87.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 01:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763717629; x=1764322429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxTR859+35fhg5hi/7dcI2n14zdxbKcn1iVduYrLEM0=;
        b=QsjQed6cC9JB/N+xDGfHeMs4K1g6aZUlgU1RsCH2algCxs5rjhIsuFO5QzDdJ2tPF1
         naOfP826ynjmDvCJpUR7BYx0Q0yFn94TX9pgTW+e+5Ae4lPbZCk0jiEWs1PMCJQ86wv+
         i4MVdkUWqhpW3mE+Mmu7oU5/AKSSgo0g011cG1TM5+8Wy+ebKNZ+yb5UCv6tbNKLnhIx
         WzldIUMIL/p9fw+nar31dWZvTHcYdqPJwOrRaLEhe+nFn+z6T7kKUKnHBF8Oc1TbWKGw
         FDkrp7pvPxp5lHhGjoAsVoJ1Atwgu+vC15iVGJjUI4iKBEUZBdG353yybDpD+69DrWYH
         R5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763717629; x=1764322429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxTR859+35fhg5hi/7dcI2n14zdxbKcn1iVduYrLEM0=;
        b=wREnW4dhQF6K1BiOyBY8UfJSKyOEd/1KlZxweyxeiEaEzBD0M5dEepWjoCil+4QWwd
         IW7k2Wuh9T9Hu8Fhl8g9rKT+iZnJVh7TQOK29m30gUtENE5Qu2Ybgn21ZHbiRujsrt/B
         Cv6w7bRdm0alcuKp3BIGYG6FUjZj+KMvU9lqRs65Fuf+dqvrz008QN58yC/d4H7lhRNh
         a5ECb8YfUWKPVjcaBQJ74HJFVWi8g9ERruU+GRBeehHkMkos+oHpiBp146T8kOBBLWqn
         Z2xTK/Vs/tl/DEWm3qNcIBAvbPd9O1ep15Aaj5QYuisP3W0B9SBxyLt0L08qaoD+gO+s
         3Bsg==
X-Forwarded-Encrypted: i=1; AJvYcCVrqYq+UsNOQphqvgbKasv848r6qxnd8RmMurGgQWVjcHt9XB1hIUwKlpG4UUpML0+/UIvYwUadAZ1iJirbSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaZxkjkJOaOJ7rnc4M+rMuJV7bu17jz8euBpM4Cj2sSE/ePI5
	v1XgnWmSNnUfE9p40cnBZhS/49NFWPnBJ2kLfWK6iQqLPF/PK4n+Rdswc3lk/9fYmquhL8Qs/q+
	MUBIATFL+dI5QzTWzMJzhS3Ifb33h09hxI3uusLO7Yw==
X-Gm-Gg: ASbGncs0gOaOFX7T/ORSE5FmoGyEOOp2OESfsW3HjkODOLv69e/Df/4P3uUU/E1SJQ2
	WCJUMRhPa9/5bjmhN27oj7F7zjRQ4DMoesycF35d1etZQ2f+SJk8mY4DY0iOWXtciXDvkJ0MAod
	X955+MYVccoBYhJHVWvToEA3PdMu8c5OfhQU52OM4kz4IZR8xpDYuFnssbpRcTpoDxuSi01pxnu
	WTl7nkem8aHkMGNLAl6hXJIJ20RDsW2q+iGelIdLNGLH+kCj9ipAU/3Xu4LXX65GgfXUa4ipq4V
	EYtXe7BZkgmoCbSUVL0e3UHZncHd
X-Google-Smtp-Source: AGHT+IG5kNvwSL693Oq5jYU0jyMDCIVMJh3ZpsoICB0YzJgifsZSpoiP5wcOCpR/lnTS9b6TYaBAYdZe1VZIVEF5Yyw=
X-Received: by 2002:a05:6512:3341:b0:594:2a49:f274 with SMTP id
 2adb3069b0e04-596a3eec537mr519945e87.38.1763717628825; Fri, 21 Nov 2025
 01:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118102032.54375-1-marco.crivellari@suse.com>
 <20251118102032.54375-2-marco.crivellari@suse.com> <daecde81-29d9-43e9-89d4-f7aa2010db62@RTKEXHMBS04.realtek.com.tw>
In-Reply-To: <daecde81-29d9-43e9-89d4-f7aa2010db62@RTKEXHMBS04.realtek.com.tw>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 21 Nov 2025 10:33:36 +0100
X-Gm-Features: AWmQ_bmAhAfsAfkw9ewWoNXNtByj6hwWLsZ_5x-d2BtMjGhABtV3qG8RpvleVI8
Message-ID: <CAAofZF40priQe-9PDifwjd=c5aKA94apt76W9Shzq0VTDUVSoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] wifi: rtlwifi: add WQ_UNBOUND to alloc_workqueue users
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 4:49=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>[...]
> 2 patch(es) applied to rtw-next branch of rtw.git, thanks.
>
> 7cbec00dc731 wifi: rtlwifi: add WQ_UNBOUND to alloc_workqueue users
> 9c194fe4625d wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

