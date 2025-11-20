Return-Path: <linux-wireless+bounces-29160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E60CC73390
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AE004ED6ED
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD3314B74;
	Thu, 20 Nov 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DsbcF4rH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B93148AE
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631089; cv=none; b=CebzcoNJNbD1ZaaXPRPbf3JoBBeOqJpG87x0HxHGJfOPOoLW1JC1gGC41LcWjc4Hyi/hCiBIr8ZFArmqU07GorGZ6dtNvFf6+38Utqt63oRpCGP0TiuAmprgBgJ4ri7uk01NE3rs87rfUCyVsVx++ljlKKnpvPuecvdG/gykwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631089; c=relaxed/simple;
	bh=nvqDwB2S4fakg25zdvPBN5c8MUg763tsxFJSu3J1UUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d58wuHvJWG4JwhlHZ8uHOYSPijj7v7K15V2nGkKKQ3BVL4JiGpO7MXUDlvijr2vR0Jdh1tkdLQM5/DkL4v4g033YVkslczxy/76QgppuSocpjYxZZxStOngB3uMT55CKWyXcqla0G4b9lGZAELm26de91j+h1MQjThBEpK8IdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DsbcF4rH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-594330147efso604379e87.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763631086; x=1764235886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX4iyu9EAKO/oezebDb0snHsPGNpzmQwHE8L27cq180=;
        b=DsbcF4rHbO3CP/QYW1Uw+ev73qpXwofJLGHwg/ehNZww3MYMl1AK8ly2tnyGx9/cZu
         JQ7+bO89upZrP0SgDYX8cnXk31HJx+0ul58/eLLLE+hLhXztgbWEgbRRHUpKrK5xRph+
         7BCP7JCbH/uS5noU2IU8wQkSrUdN4hpO6ivI+iKnOXsGAju4Qke4ZU5cTr24/4c0xlQK
         KyMBUJvGXXEF7B/Wi+Rv+XtvsqnYDIKys44HxgjW+1ddFLlvvG8ctaR9CjWvWxAOcfmt
         Pl9hXYiEVpmbGzhTDQ2F+10So6U2+YA+qnSlCqpeB5hrTWG4bxmjdtOdaDK5NvcZyYDN
         v15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763631086; x=1764235886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WX4iyu9EAKO/oezebDb0snHsPGNpzmQwHE8L27cq180=;
        b=s2BpKfF8HnlUqcciIp/ib7J2ZG50XWH5+1/Pf7Z8NTWkV70ZtUORwr3ivrVdvtwl5+
         ZOmzv0ru5KXEeYpAiHKWi5ucCmyNMJvqHVnGgle+d5NjwrSyHEgnSKrvrz3h5b5YYP09
         yJx76gDXZJG+xs876C4awzbJouMaST8uyN8pwPA+HzBF8dMzjDiAkh8v/FbyJBIvW9os
         IaNLXwldH4CfgHvtqoiinuw3MCsdxiAoFGwec6BTCqWJHpv+BLrtFUsST828L2q0hK0+
         oJhDn+MsL/OSx2Bj4rrhBCQcsyOpKoR+PA1zfdc0eEMc3ZXy06N9TP6sptO/M7Ziw6lq
         U0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhFGRsizzUh3GYo+DHd07p5aBanpJpkgVqTFlcohkubt2lJ1I3+73K64fuOmnqRGhF7vj4GFi+7dkJ9ZG+Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdbGBtJnQRm5+nz9h6EunOVi8E0QmGn15Z13YIuvDMD411Aru
	p+TeDYgM3vetzs9AyD6pi7kxoDTxLnK4KQAu6lg6nwhYOMC5id5tTjN2I1oZalZFtSJl7e32CXw
	RjvhPHqU5C+DwyTEFI/KZd7z8ZkYqL0oIPk3gllheCQ==
X-Gm-Gg: ASbGncuyRCwTYMmtDd8kvPpMH8NbAx3/eU2x1GvIVS16kax8DVjhbZdw/OaYYSIUhID
	BZdk0t3sCcfCUkzdHvztXvzdbEhMt0KkcZIuIMrDcGHSqxGMuvrO2tPQTnGNH3l0Tab/vWiAUoJ
	VGDtSp4jMJek6FDxxS/LaErKuT+syrAiVdGSbb8Gf+YEMoiLaqL12UbvUKwsDaJINTEbdXv1GWA
	Xy9H/DC80OnqjUAwDoNo9RziBV/LH6e39Hzx62M/zOX6pFtixOyUua/U4FNKi2II83F61O8p6im
	En77FzspqBGm13ATwDHihyNG6mxp
X-Google-Smtp-Source: AGHT+IHgpjSimC6NLcONWtWkgjfxN+H8HpiMyZpjXnIo+gCC4mcs514MQ7/pWVej8BzvUxDqj2DVz6xU2pfRX2zm7Sw=
X-Received: by 2002:ac2:4c46:0:b0:595:76d6:26f4 with SMTP id
 2adb3069b0e04-5969e2d5826mr779212e87.5.1763631085839; Thu, 20 Nov 2025
 01:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114095035.70765-1-marco.crivellari@suse.com> <f74e480c731a8ef0775a86021fc85482ab245217.camel@sipsolutions.net>
In-Reply-To: <f74e480c731a8ef0775a86021fc85482ab245217.camel@sipsolutions.net>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 20 Nov 2025 10:31:13 +0100
X-Gm-Features: AWmQ_bl4FTdxlL2cA6_T6HK4rEMHX-LIHUz2byrWMp-evl4iS8z88LCEcoHb0KM
Message-ID: <CAAofZF5=RATd55NCZU18DvxSnjz6TEcD00U=s0evPPOfcdWRPg@mail.gmail.com>
Subject: Re: [PATCH] wifi: ipw2x00: replace use of system_unbound_wq with system_dfl_wq
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 10:28=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> The subject and this:
>
> > Switch to using system_dfl_wq because system_unbound_wq is going away a=
s
> > part of a workqueue restructuring.
> >
>
> doesn't match what you actually do:
>
> > -     mod_delayed_work(system_wq, &priv->rf_kill, round_jiffies_relativ=
e(HZ));
> > +     mod_delayed_work(system_percpu_wq, &priv->rf_kill, round_jiffies_=
relative(HZ));
> >
>
> johannes

Sorry Johannes, wrong copy and paste, I will send a fixed v2.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

