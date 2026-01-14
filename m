Return-Path: <linux-wireless+bounces-30808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDB4D1D7A6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 10:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 699E8300EE7D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032EF3876C3;
	Wed, 14 Jan 2026 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZbNcV2pT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A737F8AF
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382444; cv=none; b=nguvriD7mb1Feqm2uJyg9qF//uzrMpijkOnwmrdPgdjC1EtbkKd9yQtYV9/liX9/yEhOqfPA96YIDyb8L0vs8T6CRY86cHcU5parOCKcUjMzBp6Xw+fjE3S4e6TUWHVDjwTwohIPAmtANm9Rj7gOFuKdowQU+0gdHDA5lcoX6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382444; c=relaxed/simple;
	bh=cF98mkEVd4jNVADlWVfxuGh/Uj+/voFfotpDuQm2wUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM93iox6p68PhcZItTKgMKuMf/7/PuFnTx8mehRRJhvG76200q3pqOfdhZBPaUYQzM99Mvf6o8woecBGzildhcrKtuoQO6c+s+Q6zQZ0DZ4nzLllAe0ThoyZZuDDAfFpAo+W/8kUkFn07yB5j7ebLF0NKcXvC/o6TNxumaXoGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZbNcV2pT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b67388c9cso10786905e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768382441; x=1768987241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF98mkEVd4jNVADlWVfxuGh/Uj+/voFfotpDuQm2wUs=;
        b=ZbNcV2pT2bumOJgaqLe4IqlNo77szArJTthk39An2IDH0gaCZLEHQ6xpCa5DIICHT7
         YFceHocs0Tlj9Q1z18QGqB3jaTbUw2bXWzrae1XiavMHiJxk7Cv33Zt5opjZVpqEkzkn
         7rSLYjTB4nU8vdS6IfK8VTWQ4UvefIDWF1fOL/1cHLBa6yQ8ARFXzydCFymEBlspn5Eo
         bEScD0A1IVwPKlc+j2gnDyTXK6IUH9rqq5rB2w7JeEdH0/QtH/NC+St9joqh+NnB2au7
         YpinU+4YpKc/IDnQbdLlziHiihbxe+3oRFjwtleCsSaqxsBivdO2guLG7allc0+DcNKI
         48hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768382441; x=1768987241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cF98mkEVd4jNVADlWVfxuGh/Uj+/voFfotpDuQm2wUs=;
        b=KLWbLPSLTAkuNuYR4FSazOMJz+g35Z+33U4gyPoaBtbAvbVUchZpb26JBUo2S+Qeoo
         cKhK4ZsEnzxx2hovJakU+mo+s43zpILDm4rH7v1OpFiUv6n4TFMvPsnMVXQJ+76EKZx2
         8NYHR7Rw6ZrBOP3xzUu40+JsABsQh2wCs4L28xgTHcBmSQc5I/osofZB7EfoLqb3gMnX
         E0RAN7ZaU4BX/zIVpE8sJfXNbhia/+476lJ5XsE1vP98VyuRAgrS1KwQMKhi3deATvQe
         ApS6XCrUQ1bpr6yXA1i2U+/igXJPwAu3FqMc29EzEPXtUUZxmLjNNtuSCvR3yuMvC8gg
         8DKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU7+zEMkuC4HAiryN9r5MmukSzEqbzLEFEUX43Rmu8vhqSqTBq6wD5LSAVdXY4XNYAxPBseAoz5tTEywWmuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAGXKHqnOX0NUNXC79oaHV5ewEctd5amikRl9pFZ5sqlRf0IUP
	FBXXf9Bx9Km/0f3wSQV0nadDFvo3RBuNEMqpodg6xoS/LdMiD7BksvuonDHbaEyk1PDqnsGU0++
	cLgyc9H9eG5U8p6VdDl/L6+GYu/LcPz8vGyVqDzS69Q==
X-Gm-Gg: AY/fxX6qk35cz+tkSBKayur0/0t+7+NkM4F4I3c5bTtrVpP7yZZ47pwuU/elR+jigqb
	S5plfS93Qd17g7XvXKRVdDYHG/94GFS5cA0ifMfJ/nScRjGGtzrtbQalPxIfuYafGYdh5K8+98a
	Vd3FlnO6J7Kr5ykv3BIpe/0/pXUM32dvnzhXIen2DimBxK+fAwIXOE7RoUmXmjIJnSmHGIvBvBN
	A2r1VxpNDUMMTZabKqXp1OROtKauaZYJ+KRmvkBko2cECEUbpbrxmWpVmxf2R1cl9KoVcMde/PM
	mleXx62bGdu+ysTtv67eCm3QW+d0
X-Received: by 2002:a05:6512:3783:20b0:594:2f72:2f7b with SMTP id
 2adb3069b0e04-59ba151b4a7mr334106e87.6.1768382441467; Wed, 14 Jan 2026
 01:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113162032.394804-1-marco.crivellari@suse.com>
 <CAAofZF5yenY8Q92taaJW2-=kenDVuc6ABEtbVT5+yzM_pBVZsw@mail.gmail.com>
 <2f4c22558d20b42615adde772551c1bfb346da47.camel@sipsolutions.net>
 <CAAofZF4Ptjmo=7taHuw_rdya-kGhEZGqXbQn8yPCi1pgA24mkw@mail.gmail.com>
 <ed1279c6d79e13f9679ac33ea47201d5eea2d1c4.camel@sipsolutions.net>
 <CAAofZF7BkX4hy=Sp2Yjq=aGrYL4wPj_vuoMRxPKpnU2Gs2eQbA@mail.gmail.com> <32088fccfccb468db893b33022f21fba@realtek.com>
In-Reply-To: <32088fccfccb468db893b33022f21fba@realtek.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 14 Jan 2026 10:20:29 +0100
X-Gm-Features: AZwV_Qg9hPbPIlURB4pRINf7dlmYg5g7NEIwTOBoje8HPki8603HzvZReVATA3Y
Message-ID: <CAAofZF4+nDAWQrKEPTwR9vtfECevdjm=nsXR+5wUwGQCzsv=SA@mail.gmail.com>
Subject: Re: [PATCH 0/3] replace system_unbound_wq, add WQ_PERCPU to alloc_workqueue
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 1:42=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
> [...]
> The rtw88 one [1] is still queued on my hand, because it was wrongly appl=
ied [2]
> causing regression and reverted by [3]. However, I have not rebased rtw-n=
ext
> tree on top of wireless tree, so I can't apply [1]. Do you think this is =
urgent?
> If so, I'd send a pull request to wireless-next right now since it is 6.1=
9-rc5.
> I don't want frequent pull-request that maintainers have extra load.
>
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/20251113160=
605.381777-3-marco.crivellari@suse.com/
> [2] 9c194fe4625d ("wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users")
> [3] 0ff5e81e1518 ("Revert "wifi: rtw88: add WQ_UNBOUND to alloc_workqueue=
 users"")

Hi,

I still have some other patches around, so if you have to posticipate
this to the next release is fine with me, no need to rush.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

