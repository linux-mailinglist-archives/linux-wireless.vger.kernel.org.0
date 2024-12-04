Return-Path: <linux-wireless+bounces-15884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548869E3AE8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 14:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A50B282205
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA01ADFFB;
	Wed,  4 Dec 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyZ7AlHW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965941EB2A;
	Wed,  4 Dec 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317967; cv=none; b=ZLTOJ0RlZ6DhIkZjGp52MTx5LNaUi6ShRAuHZdjspSi884jqy0/gW5kzuXZ9SxSo8mSBv48wkO4TAXRKujmF+Oc0zCfqJmxuj2MBkvV6Nz/MWzTAfpoaAOHTgWIw6D5W613M7Q6ZbUWqmyODDvmSLmWkG/yivNOEvmXaFMoNh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317967; c=relaxed/simple;
	bh=VIUK04LVOfGVxbmHKcb0qsEg6cfSyIr43VqcBQbptmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/J/PIJ1IUQsegd/r3XGXA8mT4c5LKlQlTWvC9hIF4ARekz/VFyTY4gj/xrl4uy4rjfMzitPMlqxU1ifIsLKwABvaXiPekVBsyqUR4WdFoL3qLQGjXbURU/9261dUPPL/bFOgyVi1Fzc0XHviTouhzmMjuSmrypnvFT4rQ9VIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyZ7AlHW; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f201a932b2so2624341eaf.3;
        Wed, 04 Dec 2024 05:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733317964; x=1733922764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Er0JJ4HnnWUKJxYWUs3oKnf37/VCZXrCRAx0KVDXO5k=;
        b=PyZ7AlHWznmmOYpzN1xV/RSo/u+4AJ2P6Q+TOPv5DGrYCSiRof9uJljD7u70Z8i36w
         IIt0u4N4uykoEnh7a0JJxYO72MbNguIxxQlyuJiolkCmtc/ecyxPawtqPYd5i8HQOb2o
         NraSkL25VdsV30t5mRZj3mu7s8vxj0CcS/G46UU00c96HroiNwBXMquhDO+KQvE0JpC+
         7jNUyXAvaG4LWsLhfJ/Z5euJz8RpaIoG/dbKaZim4XFapo5soBEecH4jTJKE7s/pjaNK
         FKgsLfMLp4Qth8nkjz/zViNA1GRGYUtFeVLUEt9h8NRW/kRXQoFiiRdolFbxRONt0P7A
         aqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733317964; x=1733922764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Er0JJ4HnnWUKJxYWUs3oKnf37/VCZXrCRAx0KVDXO5k=;
        b=iaeRIympikb9bX+SFE8kzFDNZtUJCbxeuB/qiw+cJe1Pc/jCweR0TYUlPs7im98aCo
         yyiNe5qV/W78ge6RzuI2NhUnPY+MpPx3Nn6QSV3cVeaPOuk6Q4D631wwoEu/UKM+i6KD
         SPAZ6A09pU809Oz9gz0xG7wHlLT+CF2iLPhfC8+ny/aS3oIdyjX4tBovDQS5RhTDYmbr
         Q44qPSNoVJN+dsWMuiXBoDCVaIpES/uZ29TTrqsVFn/B9OM2wypqEzixqEk/BS1g0mGC
         6AB4orvGtQFLzHzKzglvkGZXb5hVj+1QGp91Te0I7TK4eL5Qhy/p/NBaDI5LsQEA39y5
         +ZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp2f5yjaDStWGU2cw/Nh2nxH7dMAt6ODXuY3waLcgQ58Rj4zIaN62vNQWmtqaNav4S/fxedjUXSSVcqO4/oA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15OXb56kcHVS9ehhwppOEoaqptuHGz5ngEif3XN7+yZRrBAem
	sGJBf8sxnTLZ0Y5JTgKMMxXiVyg78VXvTzh70WehyKmZ41I02h1Hoc+tbTNMesVwIAKMYGkzmSy
	3rd9euql4DZRwyN/gKv1yvYtDTKnvCg==
X-Gm-Gg: ASbGncvZXry2trzUT7apXiLIoXTXdybM0MyusE2vVAz2pO0jiMtAydW0vwaUNIGbw9F
	nAMzVcLwHUTkeT99mVkYjyR0p8c2kyuUc3pQjHyny4P6lYFs2VQepCz7avo/mew==
X-Google-Smtp-Source: AGHT+IHO96tMxSKRbZQtOA4hBDQkJQBi1pHkXJuYKBzo/KOi1aNj5qscZiqFTx6aUWiziap5iG8j6HbHBDIqzoRCU30=
X-Received: by 2002:a05:6830:7318:b0:718:167f:7f1c with SMTP id
 46e09a7af769-71db57ed524mr2807738a34.13.1733317964533; Wed, 04 Dec 2024
 05:12:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203130655.45293-1-donald.hunter@gmail.com>
 <20241203130655.45293-8-donald.hunter@gmail.com> <016ba49a8b072f89fc4340341be166e26cc1b9a8.camel@sipsolutions.net>
In-Reply-To: <016ba49a8b072f89fc4340341be166e26cc1b9a8.camel@sipsolutions.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 4 Dec 2024 13:12:33 +0000
Message-ID: <CAD4GDZyCPiw1r02BHA_atDQdhsyVhxg=W1dnwi-Bc_tnkxtVeA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 7/7] netlink: specs: wireless: add a spec for nl80211
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-wireless@vger.kernel.org, 
	donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 13:12, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2024-12-03 at 13:06 +0000, Donald Hunter wrote:
> > Add a rudimentary YNL spec for nl80211 that covers get-wiphy and
> > get-interface.
>
> OK, that says what it's doing, but why?

My main motivation is coverage, for 2 reasons: firstly to flush out
any feature gaps in YNL such as the ones I fixed in this series and
secondly to achieve a critical mass of YNL specs that encourages
people to build more tooling around the specs. YNL is already used for
in-tree test automation and documentation generation. There is
potential for generating strace dumpers and people are starting to use
generated user space code.

> Also, I don't know how we will maintain this if it's not tied to any
> kernel code. What do you suggest? Do you want to just maintain it
> following the nl80211.h spec all the time?

It's a good question. I am okay with maintaining it alongside the
nl80211.h file, which will likely motivate me to write some automation
at least for notifying any divergence. There might come a time when it
becomes desirable to generate some of nl80211.h from the spec, as
Stanislav Fomichev is doing for ethtool here:

https://lore.kernel.org/netdev/20241202162936.3778016-1-sdf@fomichev.me/

> > +      name: get-wiphy
> > +      doc: Get information about a wiphy or dump a list of all wiphys
> > +      attribute-set: nl80211-attrs
> > +      do:
> > +        request:
> > +          value: 1
> > +          attributes:
> > +            - wiphy
> > +        reply:
> > +          value: 3
> > +      dump:
> > +        request:
> > +          attributes:
> > +            - wiphy
> >
>
> This already seems wrong - dump wiphy really should unconditionally
> include NL80211_ATTR_SPLIT_WIPHY_DUMP these days.

Yes, the valid parameter attributes should be wiphy, wdev, ifindex and
split-wiphy-dump by the look of it.

Thanks,
Donald.

