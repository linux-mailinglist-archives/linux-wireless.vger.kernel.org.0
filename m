Return-Path: <linux-wireless+bounces-9444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AAC912DC1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 21:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEEC1F22855
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 19:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E5168482;
	Fri, 21 Jun 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ECAbtvCH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FCA4644C
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997430; cv=none; b=uk7eaPqVjxjWX11AbNb8uCnZM9ZLtXhRmDccQSaaAdIfQzLylsIQigI6pJw/2x4MvRXmJLFNz3wc9njfgVzwMUFBzmvB5+zKyyeAFjmA+ZvcFcYN1WSjjtEtQlMX1+H7bv9hHj3gJMPfkhEXsTa135Qc+nR1u6LQrMOgyxd6EkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997430; c=relaxed/simple;
	bh=7J5AIRkxOti8YYAHsz/gEyTkLUKSwh4/mHoyvBWhX2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlIeYKznXrT2TWBP3o24Ffps+8OZZt9hFFGhAXgBWhiELp+7Bbv7RLO+B2P7E2ePughZ5IkPPK9Jz2GNLfEkiviMWk2NWMY9AUnC9uuxPKzYb3TpCarkZfMn8MPrA9+dH8+YFGPRD0/luKS0SjkpMTTgWjrCrOtNYHb3oTHaedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ECAbtvCH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so2519231a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718997426; x=1719602226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J5AIRkxOti8YYAHsz/gEyTkLUKSwh4/mHoyvBWhX2A=;
        b=ECAbtvCHGsnw/7UdTSrKimVG62XhPwynNC/c44Jg0ctt5iFvTjFEJ+MY2XJiNMeVc/
         a1p9hPwZZV1jufs5evXfKGO3GGJiDciWygJBcvWFsrOO3KhM4tnpn6KQUkNVqGlFN9JO
         3jdprApHcy7eS4+77syeqiLz8FBT3Aa8jTLGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718997426; x=1719602226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J5AIRkxOti8YYAHsz/gEyTkLUKSwh4/mHoyvBWhX2A=;
        b=AfeyULtCF6SeRmrYHc8+5rajQXCqGRWfE0APJgaBkXFmZRWadrX/OXB2dF7unxK3L2
         JQ9C5XPsKLLTRSaMTesdOG1HcIhdb4Q5vzh3oMHRII5Vydu4/JUSnaDdauZrPf7OmVuK
         x4RDok3i4WVOXxCG6GvQb2/YTevxrrEuV6ssGI1BpgQQ5yfzHKFWPY44mSYBQUoFCDmh
         uVGxFL54TZObj51PN5Dg/GFCoS1+qxb5tHHOQj3tajz1DSVbegOVS1r2VpxNzwXKKcIw
         Jv6DQQn4WL6SrxAyXJaQNW9WWyNJR2X31bt8VcRGoIJ9ZK5ojqaH5VmZXjC7ZXSPqK0Q
         RFRQ==
X-Gm-Message-State: AOJu0YwKjZaffCTmJEdkV2tdEO6Wt/wrWVqQj9pXWfRttE9AO5dd6n/7
	RPA7OFZufd6l7/QU42X0hID1W2oLApTEUjBkvat8XqUq1PxvzbDpqN5RzX1D2sVpys3AvtW3yRI
	=
X-Google-Smtp-Source: AGHT+IFp4QA2UjaBgFRoLFF0j0RVYvUZbh3tkdqZiBXoBW5R9+CsziRwuMUI4YDfTEgmVMvjYoQhfw==
X-Received: by 2002:a17:907:8b90:b0:a6f:709e:5248 with SMTP id a640c23a62f3a-a6fab77188dmr528440366b.54.1718997426472;
        Fri, 21 Jun 2024 12:17:06 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b2b5sm112088766b.84.2024.06.21.12.17.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 12:17:05 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso251282466b.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 12:17:05 -0700 (PDT)
X-Received: by 2002:a17:906:1f4f:b0:a6f:8265:8f2 with SMTP id
 a640c23a62f3a-a6fab642399mr452321666b.37.1718997424907; Fri, 21 Jun 2024
 12:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
 <ZnRvZMQJUr4APwUU@google.com> <ZnU-STTaTWjHViwW@pengutronix.de>
In-Reply-To: <ZnU-STTaTWjHViwW@pengutronix.de>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 21 Jun 2024 12:16:50 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMSyVbPrTz4Vag-4_yi7080bBtkwBgOLFYOTmwb=NDvNQ@mail.gmail.com>
Message-ID: <CA+ASDXMSyVbPrTz4Vag-4_yi7080bBtkwBgOLFYOTmwb=NDvNQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:48=E2=80=AFAM Sascha Hauer <s.hauer@pengutronix.d=
e> wrote:
> On Thu, Jun 20, 2024 at 11:05:24AM -0700, Brian Norris wrote:
> > Possibly dumb question: what's unique about mwifiex here? Everything yo=
u
> > describe above sounds applicable to all drivers, IIUC, and I don't see
> > any other driver that touches max_num_akm_suites.
>
> I asked myself the same question and I don't have an answer to it. To me
> it looks like the number of akm suites is limited by the akm_suites array
> size which is CFG80211_MAX_NUM_AKM_SUITES which is 10 and that could be
> used for all drivers.

Yeah, I can't figure out a great answer either. Although I did find that
(1) it's theoretically possible some driver could be confused by
larger indices (which should be easy enough to audit...) and
(2) there's at least 1 borderline example, in wilc1000 --
wilc_join_bss_param is only prepared to handle up to 3 akm_suites. But
it also has a (magic number) bound of 3, so it will silently drop the
4th, 5th, ... suite.

So maybe it's a reasonable start to have drivers modify this as
needed. If we later figure out all drivers should be OK with an
increased limit, we can unify that later.

> max_num_akm_suites is introduced to be driver specific and so I changed
> it only for the driver I am currently interested in.

Sure. Seems fine to me.

Acked-by: Brian Norris <briannorris@chromium.org>

