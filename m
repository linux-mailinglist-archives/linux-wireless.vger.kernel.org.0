Return-Path: <linux-wireless+bounces-26059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB99B161B3
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 15:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27331893375
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B22D6406;
	Wed, 30 Jul 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9wOsd3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91F2D3ED9
	for <linux-wireless@vger.kernel.org>; Wed, 30 Jul 2025 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882992; cv=none; b=BvZIhlje5cblQN/1y7suO23LdvxRAaxmuQnm93wrVUnlz3Q6scdspqXHIkOPqDvllALDmyjxM56qiAFLdpvbzJ05X4I7kmwz4T2ot3uydim0QJLYJA+xT3CvfACIK5ubT0HWVB5Q2dTQpyjdfanfaiUzKCZfSm9zA+7JF+CIR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882992; c=relaxed/simple;
	bh=xBoRp0SChLZCXFGFEHaZwUjrEDvia350fk+vxlo53EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bRSihOGoeDaoE2EO5Y9gxvtN1UqiYWV9w9oQL96+p2lZgojH3Ai704bT5TU29OwkY7rc8qVwe+DoqPbSnqqKwftIPE4k6OfiJK6Oa1BxdOUxHrZVCy+9C7TXx3aFfK6Nm8pE5e2QvPykBL+P2fWQdWZJPdyy9KFUoWbeLzHwiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9wOsd3R; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0e0271d82so1281869966b.3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jul 2025 06:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753882989; x=1754487789; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBoRp0SChLZCXFGFEHaZwUjrEDvia350fk+vxlo53EU=;
        b=M9wOsd3RAQgu97UCATbG1V6fC6j7LkZog4Dn4yUg1M0GnqqwCn6kvYkizU37aygIgm
         A0B51n1uRWLpT/b+4B8bxN0R9LMqaf/0BLMV3QDXwLGD5gKKOlHjv1sYbuUSAAoGA5kA
         cB1BCM2bEtyyJdq6JaSolaH+k9NbxBpI4efcfmgUenfU0wuMRW9UnmGJ4ZPHPUasZSLO
         N81CDAWneWEaNcjUc9xFXN47oXqVpMJnzB66Z/FbnisDHZuMsmeqfRAtCdmEMJ/STN2Z
         MtlWEi+2t9LSKkpiyxrCov4L/JyT2y4e8upZPjwh/p31dMsn58xi/wSj9/9GLRIW4KuT
         rpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753882989; x=1754487789;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBoRp0SChLZCXFGFEHaZwUjrEDvia350fk+vxlo53EU=;
        b=CsWoUXmiYifC3htvopk1UcbBYjj/KD/pOtf6NCY07Urs26FX+OPHlE048SvcnTHpzy
         Kpar6iQG8grPQ9SNET3Rxp3rz8XmlnhKtkBRi9D5OxJ/gFKpg0ftqq44SpR8gLXofOLU
         iPdKHeY5dPk2MyH5IG7uRn9yN0hFN+NoSuCu/4+tHIxTHdLGvhkFXlcPpQ0fHUPOJzVS
         omGIxk3GmDuyQXwlGUMCHuO/0nId0HjJDGbJ57D4NIGrZeIxSZs0mB+4Hqfnnw+o/gAT
         j4JoQ2O8x7zQMkbl2AL/+8sfwQCyUlJX7YDmHzIafwty0cRJHR7cBueXgyjv6mk7J6ZX
         l+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7c9HhWgEPpAXNNCwoPHQlyQZCMpgGh7UFGG2GNYtM8tINpSKOaya/YRvivaIF2T7DnUgpkL/QIU1CO7qHtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9epZ26mbrMLFafrL6L9+DpLlli9E/Mfs4J5QF4PSGZifD3v3
	3OYWy2z/1yhQ17pEFBY0HQ4t50aH10uMhMJZCvEdEFaCRsXaJSTqtKf4YaJ0idqhWTOsSEswJeD
	6YmwVYqIR72raUBGFf/acvapmvqEPe34=
X-Gm-Gg: ASbGnctlh1ZRtnOQ6h8LQx8oeFSNGVfyjPIlY7WAERBu7Mqq2pKNes+0KKDHsrKzcHK
	PpVwdBeWCpU9m/l/V5Yfh7jaaXMC6y7lBQybQS3COXv5aFBo6vf+qhYN0tDOPYLhv3bZC1rFnXv
	7pApqDiJ6gmvzktMWbUY+/0UF/gqvIbH+OJhfaPEA+R/1otCG5CuByiXNiVcMQmgctjNKxZR+v4
	8tkkOw=
X-Google-Smtp-Source: AGHT+IF2uKFJr5JGCokIm2/mPtbEjeJlskOZ000LCEx19oKBb6NdVkOI6CRy+VZ+SjtDN52qfYlA2WzAEtzWkaoz2Lg=
X-Received: by 2002:a17:907:6d11:b0:ae9:928d:f285 with SMTP id
 a640c23a62f3a-af8fda83de2mr470966466b.55.1753882989068; Wed, 30 Jul 2025
 06:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHGaMk-S4SZgcLczH1ntBvYJCk1vxJBfxzN_FSpGANC+-P0p1A@mail.gmail.com>
 <3c90ae9c1234f19f8506cb277b7e09bdce5b477e.camel@sipsolutions.net>
In-Reply-To: <3c90ae9c1234f19f8506cb277b7e09bdce5b477e.camel@sipsolutions.net>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Wed, 30 Jul 2025 21:42:59 +0800
X-Gm-Features: Ac12FXwfoiIqWVfJy6EHz0M_BMUO11C--MnCGMp5x6kCWC2uFSw-3keIao39hQo
Message-ID: <CAHGaMk_ySctq4zHrhsfxDrtUBDe7dp=ecm-tBJDRzHND11hCzQ@mail.gmail.com>
Subject: Re: Question about flush_sta()
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 1:15=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Tue, 2025-07-29 at 23:21 +0800, Castiel You wrote:
> > Hello,
> >
> > I have a question about flush_sta() behaviour.
> > From reading iwlwifi which is the only driver implemented flush_sta(),
> > it looks similar to flush() with drop set to true.
> >
> > Is it correct to assume flush_sta() acts more like drop?
>
> It doesn't really matter, but dropping the packets is faster and this is
> during disconnection, so there isn't really much of an expectation that
> they might go out, and in fact the connection might not really be viable
> any more anyway.
>
> We'll probably need to rework some of this for UHR though.
>
> johannes

Hi Johannes,

I see. Thanks for the explanation.

Best regards,
Zhi-Jun

