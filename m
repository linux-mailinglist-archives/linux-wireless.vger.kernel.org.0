Return-Path: <linux-wireless+bounces-16542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA29F6884
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 15:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B830161D53
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7651A23B6;
	Wed, 18 Dec 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkEH+h7e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED42219ED;
	Wed, 18 Dec 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532351; cv=none; b=KK1dhWQ60wyh+wZjdcd1U+G1IEa8YnHaFwmTYu41s1ZL1rzWEriX6pRHgVJBNAnKyn77mG5atj7yJ4OkrBXiN4rv32D/qCNtsKJLoOBhoe3Kd/rq7zQCP4UgWCsz4isr0YPI7ORVgLhFQKRfr7WBaTrWITK5U934y0bVkYjN1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532351; c=relaxed/simple;
	bh=8FsK/bER8lP7OunJFmegsYl6K/NI0Rc49MtT+8SVWsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/fkIyzntbcZQ8EGHHaooHiEmbBcRb0f1hs6RXkjcDxsXqggUycpUrtppe8AnWbRey6PvhiQm2qomqt2k+4LeBGa/RNslC0GXCoWawou0KfNsWlZWlzSF0KRmTEUW/GE+lbjsaKqQrdcuBDXh0o3/5Ofh3+ej1k7inU5dAGCf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkEH+h7e; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2a3bf796cccso2148829fac.1;
        Wed, 18 Dec 2024 06:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734532349; x=1735137149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=55iqn6k0ksE8M1ea/JmwD0ngi/GTsL3+dCKm5pf5BGc=;
        b=RkEH+h7eDTVXXyZ73Z1RPGMazu3BT4l320J6p7Rtu112pEvQu4WNpFZ50yzQFkBFAx
         UOguHvuLczqPKss39jgRcgiup2/FhJgpLBtqUseobPMnyhjM/XRDQmF9d/HCox1VSfk2
         qJVh+4m4jZDwptwLGkzy+IlJEs+dP7ge4zr3ThALTO6S0OEY+ZB2fkKdzAfzLBuI056O
         NIw9zmZ/i6wa05HK/kFKrC7ldDHiYwN1yWfuY4KZlpLmAm9uhHAbver2GDJXwmuepzY/
         wKukKXDi6Zwc300fn8Hinovo5FGBLtYm73boFVibz/5+QjAqy25fCwghQWtvaXWPEAPx
         cPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734532349; x=1735137149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55iqn6k0ksE8M1ea/JmwD0ngi/GTsL3+dCKm5pf5BGc=;
        b=kN/KYJz7tYstm0YvSdI1HHgqu2Ju3mGbtggmI1g5IDm6dIeAG9B9XE7oB3d5qhK4aO
         baahjUyjWsxRTzqJ626hp9cyMdu4syBx3rYrjwceOCsI7X5KAMiqtBWBJd4PfLuzxWyq
         Ens8eeH7heP3gFf9MGWcgvxdTm1jt19pzPhMGObmFK/fZFspddvOXGyUjJGc6B5VR8kz
         rNn5lGWSWTvIAo6k+EXJudnaHSTE7rGjHAKsTFGX//2TPdXiySO6Bi2RbgncHP37l3f0
         JK2XBPK2Vd5pMITHiEqyS7y+2jCCV9zymOkfTzHliZpk5eBkayZx/hREb7l8NuJAKFA8
         anUA==
X-Forwarded-Encrypted: i=1; AJvYcCUd4ReLctt2Su14/56PXWs8DN0+1BvuCRdze1YZd5tPfU3RVKyYfVhvrZk3wS6l0eeNSpqYzdUV6EP1JTCqwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDUUr894jybGIToxhF9ov57hv8Or48yWKEH94XwaCYAAAgvD6
	cDsQZW72pHsIenV9j4DvtEmIo4KASm90NTcUjH4m8KyNLtgzM51IjL37qdcR8WnO3m/2OtoWbTL
	Ix9/KdQ+PHm/Jr7o9FtKfT6uHavR4/w==
X-Gm-Gg: ASbGncuulO/NAV71IJtuePSBtt8kvO1X6DmvA8vT44xydlUfoF3FcF/dV3iTYaZNW1O
	SUq7UKAThexgV1NObjX5eEVSfyY78YHKQ/8z88Oxmv/SCLmfOhIgTjgm8lU6gZL0TDRvu
X-Google-Smtp-Source: AGHT+IFyMW2N5XWmeC401DjiP8EK9p9DQsfIGeAFHCBgMCE5Lk9tMoq/5U6MaQ9K6nHQ0kSO4/uTNPEO6QKa9QHLF+Y=
X-Received: by 2002:a05:6870:3d8e:b0:2a3:c59f:4cba with SMTP id
 586e51a60fabf-2a7b3088006mr1283971fac.17.1734532348669; Wed, 18 Dec 2024
 06:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210161448.76799-1-donald.hunter@gmail.com>
 <20241210161448.76799-8-donald.hunter@gmail.com> <9c0fcee07cb7b93308a5d0185c4e74fb3cbbef1c.camel@sipsolutions.net>
In-Reply-To: <9c0fcee07cb7b93308a5d0185c4e74fb3cbbef1c.camel@sipsolutions.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 18 Dec 2024 14:32:17 +0000
Message-ID: <CAD4GDZz3xSyA2zJcs-wbZa4yD-ZT90PeOLFReOcr286-nycA6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/7] netlink: specs: wireless: add a spec for nl80211
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-wireless@vger.kernel.org, 
	donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 08:36, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2024-12-10 at 16:14 +0000, Donald Hunter wrote:
> >
> > +  -
> > +    name: wlan-cipher-suites
> > +    type: enum
>
> I'm not sure exactly what this does, but I'm not sure 'enum' is the
> right way to think about it. Pretty much every number (OUI + subvalue)
> could be valid here, if the driver advertises support for it and you
> have a supplicant that understands it.

It was an attempt to enumerate the valid values, but from what you are
saying I think it will need to remain as u32, probably with
'display-hint: hex".

> > +  -
> > +    name: wiphy-bands
> > +    attributes:
> > +      -
> > +        name: 2ghz
> > +        doc: 2.4 GHz ISM band
> > +        value: 0
> > +        type: nest
> > +        nested-attributes: band-attrs
> > +      -
> > +        name: 5ghz
> > +        doc: around 5 GHz band (4.9 - 5.7 GHz)
> > +        type: nest
> > +        nested-attributes: band-attrs
> > +      -
> > +        name: 60ghz
> > +        doc: around 60 GHz band (58.32 - 69.12 GHz)
> > +        type: binary
>
> This (and s1g/lc) should also nest, with the same attributes? There
> should be no structural difference between the bands, even if most of
> the values are only used/valid for some of the bands.

That makes sense. I'll add the nest type to them all.

> > +operations:
> > +  enum-model: directional
> > +  list:
> > +    -
> > +      name: get-wiphy
> > +      doc: |
> > +        Get information about a wiphy or dump a list of all wiphys. Requests to dump get-wiphy
> > +        should unconditionally include the split-wiphy-dump flag in the request.
> > +      attribute-set: nl80211-attrs
> > +      do:
> > +        request:
> > +          value: 1
> > +          attributes:
> > +            - wiphy
> > +            - wdev
> > +            - ifindex
> > +        reply:
> > +          value: 3
>
> could the value not reference "get-wiphy" and "new-wiphy" from the
> command list? That might be easier to understand?

There is currently no schema or tool support for referencing enum
constants when defining protocol message ids. Most of the netlink
families don't have any need for an enumeration of commands in the
spec; nl80211 is unusual in reporting available commands.

I'm currently working on completeness of nl80211 and a couple of
feature gaps in ynl-gen-c.py to resolve 'make -C tools/net/ynl'
failures. I doubt that I will have a v3 patchset ready before net-next
closes for the holidays.

Thanks,
Donald.

