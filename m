Return-Path: <linux-wireless+bounces-30607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99243D0B39D
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 17:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 464DA3028E60
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AA364022;
	Fri,  9 Jan 2026 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TMxiF39s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883C3128C7
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975555; cv=none; b=heEK0+V0Vi+MQbm7jbz8Qr0q7QwFuPT0PbQQIUPw41ACIZ/oXd0gmjd7DOMQeel7g9dYS5ACgTZH9tWOEXHFSfpHoP/T8mkzDD0Oxzv72VpGIscQYj/vdoSFuTC8mEFBUk+rzkgxMlgTK2K5UfBi1ZtTIKcvHe1+Ehj+zZ+/LjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975555; c=relaxed/simple;
	bh=1ip5fyBSdZz2soiGrqNvWK2b9io5ZSxneOkgvDMYvPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faW7/zYJ1VBYgodUBCR9PUtcWja9xPa5QfD/tQZhoKoQbGejQfsj8F+rzShAbNGnI7b9pXQXlEOGJbE0fdLGRsXHmLpaW4CW1CTRsQTtA+DJFTY6Gr4tvkVOlb3hJdqCq/8agugWMMfBE+kJtMML0Q1ouaAusKSN8EGWoJ3tMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TMxiF39s; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b6f267721so3040855e87.2
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 08:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767975552; x=1768580352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/IB76mh4rj0qENwJrbP5dbbEK02NuOvPVoitVUzqOs=;
        b=TMxiF39sg8mjIZBFEfm/1FuuzE6GM2ICrqE+ixU9x+S8U7PXryLMpDLJJIEssZ+Wed
         nhe/VFEV9DS6dyOQBwsbr9UICMhsmk2iApo7zzaqqvXBY6o6uSm1nMyjQmt7Q1OYUP30
         gJQexI7dHKf0pG4ZvNon8nq+lI+Fh8Z2PdVnJgrofkqg8rGZe3hE8LaCBTE6MWI2xEMk
         weRD9cLh3nQiLnXh4CyR5+ZyTE0LdXkdh6+xx0yHX3iHe7mRwKqLBzLjoZEk/vQ+uD5K
         zyj/POnQzhhJO9lBcGiHMbOVNiwN80KSkdmTR3ORyBVxftUh1/lA8G89N9p0vbZtUe2Y
         ExlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767975552; x=1768580352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/IB76mh4rj0qENwJrbP5dbbEK02NuOvPVoitVUzqOs=;
        b=h5KmaIpyKZVa6goqIbCKFH5uX/EHhcdHvpFt3976TSGbaMOh/2ahp/brKgzXmu9XQK
         BMhKDHPdvW5LbB4Z2chSm6fTYV3dC81hxvOEvDQKXN+l5L4beMbkD00pmigsW8i4FeM0
         ku9hGw7DkrIdtjuc+jksdjVrOxRcGQTBx3MMRZS/tj2FChdgBWxWvtIWJpbqt29Q2JfM
         CBSsr2T+k9Xnyw582T64yrewq0KgSodkIng7gGcHnGHpwhsDFuQM8AuwPSYdo275nRyl
         rSVwHnhQ/mYIuOfbFwAq3s/V/Ps+AY3A1JbWXfU6V0j/FEsPwpK0AkC/8idZpZtQMOG5
         yrlA==
X-Forwarded-Encrypted: i=1; AJvYcCWkRcLOs8ZsB2mTjQvV3J4LRjG6SUCH1cBDU/3223WASA9f2XGzCbCKLFCDlhqgaeJeNuPsR+0ycUqDn6rryA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziVVhQChOq1lH23lV86ZpfiUXIwUqH4Z+MMmRaG8HFKWpPghnS
	GqifXQ5uBolo2LdacHGm7TWYDtv3q8IzIFyWVqsEWyGUQbTFk0lLNr5d5OGxzvzwaCyNVwhKVHH
	jnqHu3trEJNPwE1K0ebADMpN1ocoygJzDtxS1yKOplA==
X-Gm-Gg: AY/fxX7Wd2DQ54DTXPt96NtOsnPRvW1QweD0L1nfs0gsorDqcuhnh4sdb0OLfPXQIAg
	Oo0MLE2GoVyqyXGLWt6SEWDFbiFuz0xmjhAL88OCmej2GqTbzZ3rkHmNYSUJtmaOHjdcFIjMQUa
	kFPqxWT49aJAHPvEleLKAK7og48ZMyc27uCkCf+2husIhC0VFEgwdLmgLL5SE1vspLWYG/GOa4Y
	kb3F9lyskuOJ7FqSOJJUw++7DKoRJTdgPpMCrE3Y0lhRx0ApelerQlMiEouPue91XbCOM3P08Nz
	b6GJwRIhuLNMtjOhWVl5l3a0s1ZbE6t5KwSIT/4=
X-Google-Smtp-Source: AGHT+IH8b1wx6Adeu5/Hr7Z5O3Sz6vm+KcBcqydLgUCi/srCTWLC8madBTg6k/e7Ictr5/h2WvMo5JVirKYn1G1K418=
X-Received: by 2002:a05:6512:2312:b0:59b:420f:953d with SMTP id
 2adb3069b0e04-59b6f058365mr3439513e87.48.1767975551706; Fri, 09 Jan 2026
 08:19:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113160825.383883-1-marco.crivellari@suse.com>
In-Reply-To: <20251113160825.383883-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 9 Jan 2026 17:19:00 +0100
X-Gm-Features: AZwV_Qi21AwXjxfmfzhQ1tWwfg2d3gwm4cZtCedDHR3xbXO3GcZ78tLqkg9qg2s
Message-ID: <CAAofZF4--X2_0Hwwe5s5Q6-ocSVpcW+zdEWe2FEPURnzuGYx8g@mail.gmail.com>
Subject: Re: [PATCH] wifi: wfx: add WQ_PERCPU to alloc_workqueue users
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Jerome Pouiller <jerome.pouiller@silabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 5:08=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  drivers/net/wireless/silabs/wfx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

