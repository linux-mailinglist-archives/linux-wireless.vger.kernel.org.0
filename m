Return-Path: <linux-wireless+bounces-15886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7C9E3B36
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 14:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C690C280EFA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9A1B85FD;
	Wed,  4 Dec 2024 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWdNSTsh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656951B0F31;
	Wed,  4 Dec 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318704; cv=none; b=CPOlXNHDjBlRM5DajdC9npKTcCfidTsxLpOrGh9kmFvsFk+GvQQmlgfRj2p0JKqqlHCypUAz6zMrMX/Nb2ApGDpM42rFJEt5/e0UQOUurxHBqfZQ/B0SLPAwDY9h7U1rDt8xWdEmSrSxpJ8mujyhCY0af33J8v4Eo1hZuLWM9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318704; c=relaxed/simple;
	bh=B6cTtzY7QbAALt0d5LxHIb5LiHNJK0CROwRgt8o7zeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuMCg+QuTGcJCua3AiKEn9+PFhCyrU+m6BMOdY8voO5JsULhe/gupk4ytGL6UuDP7XK7zlwnvLKWcebN9qQGtcQwU9FjUrhwp1SZ975J1no8iyCVw//XW8T4lgJziRMZVbCzztAVYge4vHpeA7fL7u765MGdxeIwPauSL8Ynol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWdNSTsh; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29e6399b009so1776074fac.1;
        Wed, 04 Dec 2024 05:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733318702; x=1733923502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc87vt9ipHVSbxExS3x5IzVKbKpSeOccgguVTnaeI/U=;
        b=VWdNSTshUTgs8/sAAEGgWJWqVvrM+LUjiKK3w21dwj/Awonb4QdffdGhM1ZDhUgo54
         qyJJX0XcuSS3Muvmi81nP9woZK2G2v3/LlZXakykbw8+drLufuFOmh26PVYv6pBDLCfD
         JL8ugV2Q+1BwG3/RS0cuJnPo3qDiVfDbqvNwiae1pyK33ZJBqFVLmmiQJWy3+UBlBw5O
         6yPhIWjPVZSoo+Brp9Gmx4rfOD2cz7fKNwiunN0qQZMVTGaZEZNkgWz8moBI4GjnmPKi
         2XJaeZAAJ9q7ah4xo3uP0DO9gKzLBHEiqHVOK1eSSKv38Je3a43pvVgASQTMxav/kjNL
         30CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733318702; x=1733923502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fc87vt9ipHVSbxExS3x5IzVKbKpSeOccgguVTnaeI/U=;
        b=A6MnS2Lex3LItpx44yEVRGK7aM0LQue8BvJuoPVYMxWZ5AZNVpTaSTAimZMfdoop32
         mwAm3+KKgzZMTAl7mQkSNoK/yFnCQ/tCmscOg6YriahGJU42JkDhuHKmlA8oz1UynU8l
         ubqVGvAcNWwW4Mig7XS5JWnc1CaWM17YCf8tWOJty3hwnDQdr1SfRPtYZiFH4sQ+M529
         5dOdw1DeuEN0Aiia1Moer9rBJXw6anwxc4um98A05HdojmOrbzRYXniTDQ5vWOvq7Snw
         eS7Zl+QCSygh/ZvWnacu0C5NuFmPraANFum6jaryjafmc9CRQmCYFbOdfK7B00OpmB74
         WDMA==
X-Forwarded-Encrypted: i=1; AJvYcCXsgRbEwkHvGtb6l3usGGj9lDmrD1FBueEHeLfUEzO2ghp2WAb2uQfSIr6Cw7n5DWIIv3q7oYoeqg54wUT13A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBaEsZm78E05qUjdlmRGPZfbB4nsYw2HNFlNyL3L3EqdHbc0/2
	+ibnOdqiOn9x9xBCFAtj0nSeeN4n5cW9RyH+n7mfN9/3QHl+GMH76kLhDHd+UkX3v3WXvZuZHxP
	HmrpX7q7m1RE3GjCh7OBEmK/5IUI=
X-Gm-Gg: ASbGncuNS8hwulUwFktUwGnvoiRanV/D8QVDwezSIKiNbCDo8Vu0pNZe6wbAS7mwd80
	fHdR9GQFL7+xDkkVNLPzRAQyf30FJmi+8CgkozHjmUpyWFdhKNnCQ31sI0kaOhQ==
X-Google-Smtp-Source: AGHT+IHT0Ep4eq6PbUofk9egNmmvZlnQjL/1CqgMAIvbSh19a1IVIGpt2C6aAp6oynMMgWuw2kBD2ayp+ivsH76pm7A=
X-Received: by 2002:a05:6830:4704:b0:718:787:b416 with SMTP id
 46e09a7af769-71dad672365mr5247833a34.16.1733318702502; Wed, 04 Dec 2024
 05:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203130655.45293-1-donald.hunter@gmail.com>
 <20241203130655.45293-4-donald.hunter@gmail.com> <20241203180320.0d4e5670@kernel.org>
In-Reply-To: <20241203180320.0d4e5670@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 4 Dec 2024 13:24:50 +0000
Message-ID: <CAD4GDZyshPDo0CD8CvTwgHH1kuOeRZRNP3qiSXSmW3=epCEZrA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/7] tools/net/ynl: support decoding C arrays
 as enums
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 02:03, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue,  3 Dec 2024 13:06:51 +0000 Donald Hunter wrote:
> > Add support for translating arrays of scalars into enum names.
>
> But not formatting hints.. ? ;)

Oooh, good catch. This does suggest that a refactor is needed for
scalar handling.

> > Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> > ---
> >  tools/net/ynl/lib/ynl.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> > index 0d39a83574d5..f07a8404f71a 100644
> > --- a/tools/net/ynl/lib/ynl.py
> > +++ b/tools/net/ynl/lib/ynl.py
> > @@ -627,6 +627,8 @@ class YnlFamily(SpecFamily):
> >              decoded = self._decode_struct(attr.raw, attr_spec.struct_name)
> >          elif attr_spec.sub_type:
> >              decoded = attr.as_c_array(attr_spec.sub_type)
> > +            if 'enum' in attr_spec:
> > +                decoded = [ self._decode_enum(x, attr_spec) for x in decoded]
>
> nit: missing space after 'decoded' or extra space before self, with
> that fixed:

ack.

> Acked-by: Jakub Kicinski <kuba@kernel.org>

