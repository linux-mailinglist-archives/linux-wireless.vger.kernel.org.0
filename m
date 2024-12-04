Return-Path: <linux-wireless+bounces-15890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358F9E3C38
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B3616387B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E620898A;
	Wed,  4 Dec 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZNvK6XS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4561F7096;
	Wed,  4 Dec 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321330; cv=none; b=jfpH/V8jmXo8BlQtkjQ8Vzzilfs6tUi5jRCH4W9ttuu/LezVL6DtErddp4JAXbJbzsGjD4uY2bF31yR3w2XjbAl2YjvbFD1pQixhMP32cCST/OfHcVL2ecJAjfg5pYVrwDm4/L4Iw3AGICDxQbeytTUj998j7KdEczJrjrLoGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321330; c=relaxed/simple;
	bh=1okdIYs91H96snC5/ndQeyXzr6F826zbfhNCRycItLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdeGfuM3idVTb9isfoZe0IqjQXRu/FvksxrlRktACXNHe5ObTOn99jnSegvHVXiaoJ2AAh8Q5TGVADQp1y0+1Oy7oplDeXvrsCTTr7yI1yA5GYbr3I2mBb4gmWgcSd5LRd1NQ7dNxiLddmADt9RVAbD8N9C686nd64kdWL/fMhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZNvK6XS; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f1e79c2f81so3215739eaf.2;
        Wed, 04 Dec 2024 06:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733321327; x=1733926127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vx0u3vo0+JUIMPSAFw/f3+EyZZy7ixLIYC9U8AZ9zVg=;
        b=SZNvK6XSLRaGKZoji3Kq5o5BhKpbEIXrFxLtqcxY9lLRfW/T3vwIjWOkGTDRR6Tol9
         VR6bAOpsXGzohUvo5QUp+aLIEg4RHVr3FyZIPg/1QZMR8+y5ecVHYlUq2n8Aunz580gX
         Gzf6koUYSzCsuSw0zC6VTgp91yc+IF5yEcI4jEnRWQENoNa2vX+HkCrLJLKrTkGyqrYg
         SQm5TXIQ84Uko1TFEuqk1MILtFjpK0YgYC+nUNckqtrka6eh+B7XTULgPkDtIfIzGbNW
         ik5KegMTAB81GNqPp2rqTNgnYzHDXkfQ3QYifd7vsGUlBywdmBBPVFTYVgKW97ixRaFb
         EBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321327; x=1733926127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vx0u3vo0+JUIMPSAFw/f3+EyZZy7ixLIYC9U8AZ9zVg=;
        b=bS0k+rYB1pSv4R8/s9Tw6axvUiClJpjf8PoAb6up5v65mTG85Bx30kqk8ws+48uKL/
         sZ6BKOCIfcIFj26EAEHnrLKqKkIURtrHS6xPk/8ChVdD4D53RARmR75fziA/Iwlj0V3M
         Z5ORpKoSPedr8Z8+R9pIpFk1JX++/OvkT0RBXAKX2ehCzvNxbiWoC445cXerq9YB9GJY
         iAXg5FUZJk/089XXKgy74JzSKaClIwMEYnC0TYx+PIwG2kOzspikWefd8WmSSheKWmhN
         BV50Z+wS0GYVT7Ufs+N2Wdj/5BHx7bkisA/JwPJ7tAxcuvrA7xzmZLNDAIkdF9QfjcLW
         CMrg==
X-Forwarded-Encrypted: i=1; AJvYcCXXJiOKvkdoq54gvREGdLjg733X5hZItI1c9+kC/e3ytVW6nR1RW+7VsIKkmYQs76Yzg8vN8xfFzfARK58y6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIoAByv+duatNOgItrl/3IuWGXTy4Hj2rMp1OwZVrYYYwyItHX
	KoLpzhpdfqNppE/6r4htDrEUzY9jsA21oXnuGGe+eGtOJQmaQ8qZbpYMjJdZCK7wdeoMv80grG2
	DCKYdvWx5ru1c3oxeNGANTRMS9EgRAw==
X-Gm-Gg: ASbGncvYPNr/YnPqs6YcJFq5EUk16tIK+vG7ZU1zWrkmLFGsgVm/n4ETie6ZGeOfRrK
	fgXro2MAFHQhA3DNInzf4JD1aUR7GYltCFhnhdieOoXzlb/fmV/ILCFTDz6UDdw==
X-Google-Smtp-Source: AGHT+IF0BqOExzj4u/H/mCCNIyAfyv+H3I4HsOxvBOgLtMLfNdBmAHGcjzh4GFjo5NNZ7IxIn7jIpmEBATx1iNJ0RT8=
X-Received: by 2002:a05:6830:490d:b0:71d:634a:e0d6 with SMTP id
 46e09a7af769-71dad6069d1mr8141136a34.6.1733321327458; Wed, 04 Dec 2024
 06:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203130655.45293-1-donald.hunter@gmail.com>
 <20241203130655.45293-8-donald.hunter@gmail.com> <016ba49a8b072f89fc4340341be166e26cc1b9a8.camel@sipsolutions.net>
 <CAD4GDZyCPiw1r02BHA_atDQdhsyVhxg=W1dnwi-Bc_tnkxtVeA@mail.gmail.com> <cc0a13f9674238d3b7607e9d9b58ee6e5cc4aa5c.camel@sipsolutions.net>
In-Reply-To: <cc0a13f9674238d3b7607e9d9b58ee6e5cc4aa5c.camel@sipsolutions.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 4 Dec 2024 14:08:36 +0000
Message-ID: <CAD4GDZxa-=_8DcVjz+=AQAyyiORey2U2sv6qmayoF34nTTN_cA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 7/7] netlink: specs: wireless: add a spec for nl80211
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-wireless@vger.kernel.org, 
	donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 13:28, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> > > Also, I don't know how we will maintain this if it's not tied to any
> > > kernel code. What do you suggest? Do you want to just maintain it
> > > following the nl80211.h spec all the time?
> >
> > It's a good question. I am okay with maintaining it alongside the
> > nl80211.h file, which will likely motivate me to write some automation
> > at least for notifying any divergence. There might come a time when it
> > becomes desirable to generate some of nl80211.h from the spec, as
> > Stanislav Fomichev is doing for ethtool here:
> >
> > https://lore.kernel.org/netdev/20241202162936.3778016-1-sdf@fomichev.me/
>
> I think I wouldn't mind that - I'm hoping it'll also generate policies
> etc.? Though on that front we probably have weird quirks too ...

Yes, the policies are generated, quirks notwithstanding ;-)

> But until then I guess someone's going to have to maintain it, and I'm
> not sure I want that to be me right now :)

Ack that. The burden is on me.

> > > > +      name: get-wiphy
> > > > +      doc: Get information about a wiphy or dump a list of all wiphys
> > > > +      attribute-set: nl80211-attrs
> > > > +      do:
> > > > +        request:
> > > > +          value: 1
> > > > +          attributes:
> > > > +            - wiphy
> > > > +        reply:
> > > > +          value: 3
> > > > +      dump:
> > > > +        request:
> > > > +          attributes:
> > > > +            - wiphy
> > > >
> > >
> > > This already seems wrong - dump wiphy really should unconditionally
> > > include NL80211_ATTR_SPLIT_WIPHY_DUMP these days.
> >
> > Yes, the valid parameter attributes should be wiphy, wdev, ifindex and
> > split-wiphy-dump by the look of it.
>
> Well there's that about valid parameters, but also no (new) tools today
> should ever *not* include the split-wiphy-dump attribute. I guess that
> can't be expressed here, but it's a gotcha for implementers that just
> follow the YNL spec?

There's no way to specify that, but the constraint can be described
clearly in the doc string. I'll do that for v2.

Thanks,
Donald.

