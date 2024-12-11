Return-Path: <linux-wireless+bounces-16272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB51F9ED998
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 23:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A219C164AA8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 22:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C7E1A841F;
	Wed, 11 Dec 2024 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxJT5G3B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399681DB956
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955893; cv=none; b=X+o+CkaIoUv/UURi/G5KS0rNZL9bZP7wEZZx+E6J87ERBXpzJwByPykGLXKSbGkl8sPDCZNdIDtGgfu3TL4YT+JGHa2PKRskLvdmRgrZ0GDTe0wdqEyLJkyqZa2fY2tw7mGtX/ATUQR0ic2CYScSH0gS7f3kXYT5ooYFCNHTT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955893; c=relaxed/simple;
	bh=RV/W/MroeiS9i7sZw8kk7loBgZRFz63mwAfHWQtoXlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtIZeXyqNOq/IMSFG74NbilrnXRH+SLeWN4mSQRivZPNm3s9KbA24vVtyWULuVApGhylpq8QrpcOEKSBEiti9q7EpqV8vhoBl4tGA2N1PA678DWlQJ3lwb0Yp2t1O067bXGoV22m6b70mhBVUx9QgXnNs/AKnJAhiEz9G4d+2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxJT5G3B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733955890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4L62xxnOjfKCwQHQtFYxaSuIGZjtEixLHzI3Spv7u9I=;
	b=DxJT5G3Bm88gTE25/B/XJpT4WqEks49r6GDDl+WxkvIvhr0fPDrovpW5F72RjJQ655K8AB
	TguYPHMbqmMEobuNGYfRkFKy+hyF6XbRMCcCGFNK7QNBN6cTfQXsC1lEvvXpsah7PRbbzF
	NLuZjhuYJzKfVg+vfgEkCAwWnrMp+gY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-julEBbA1MQ2rDjykAYkfdA-1; Wed, 11 Dec 2024 17:24:49 -0500
X-MC-Unique: julEBbA1MQ2rDjykAYkfdA-1
X-Mimecast-MFC-AGG-ID: julEBbA1MQ2rDjykAYkfdA
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6efed4768cdso47156907b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 14:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955888; x=1734560688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4L62xxnOjfKCwQHQtFYxaSuIGZjtEixLHzI3Spv7u9I=;
        b=uN84nrhS2hTksoW/rT8O98JcB911LmPtuSKIvT1p5CInXFWYRs1Q1c5VyJqLc4G/2A
         TZ1xoBx4MCfge5mHZxMQLUarCEKWy2LJ241kfbusw5/CEpAltrBJEWyWhL7rzkAkmlFM
         ZnXZjM2QpixLLaSBWx+qOYJQVhFFqH6bPlMW1hGlFJmQ2DvpHOAMMDcK7k7YzzlvbfGg
         TMEYIrMcxuoweVXmZhDCwFk9xEBqBkIHoCh1lrQVOq/eHUgq8Jcmj/c7g6qiKw/LAGcD
         ODkA75D/oUmt+T2tk9GwyCRpXhob4Ulky+onhR//Xhsa3VDjP4/+cfUHXd4OtIQpXZl6
         vOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7sHjeVlt59upGTrnV+0q9ZkUKx56kJGSosiSvbofOTOLcTDusM3mRCFwq0p2NWbv5WhecaRqC42y6xaXbUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOPBOhCMrerUWzbkJ8Bzw8wtbLwS/Zh4x7SX5i/BLOWfbMaCXW
	BjXODPEvEV3nJJNlUhQCu6GyAH7QEc/xh28TvXf2Q4Q2ToJfCPbq7sJnWJn45hGGSsrUVtMpwVq
	//F4Ti3nvQbBluCs4wrskQMyfUP3J6R/+mzdfNqVvRQy/9poXHoVWjuvtXq955qOo37MO/z6ahi
	JsFF0MhbSucnLaVuFaUTxVFaycmoHtE58GZksRmRE=
X-Gm-Gg: ASbGnculr2JVsEWL2E0o02ZKKJNJwoTSqlqAvMMioQGVMPzae4bCEOfvglXgK8JigV9
	6HYe/QGPutkFgYhUNtxaas71H6kmazcC4eN7veLOoeRAwK9ShlZSudlWyzVny5phvcQ==
X-Received: by 2002:a05:690c:4485:b0:6e2:2600:ed50 with SMTP id 00721157ae682-6f19e5071a2mr10985117b3.21.1733955888563;
        Wed, 11 Dec 2024 14:24:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh7oBAib1eBpyek7a5WPWh4QHh7h9VICuRKeigaC7/liBhCsHFKK7GpYF1R309LJITTPHEPKoaTwkJLcRC/qY=
X-Received: by 2002:a05:690c:4485:b0:6e2:2600:ed50 with SMTP id
 00721157ae682-6f19e5071a2mr10985027b3.21.1733955888311; Wed, 11 Dec 2024
 14:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210161448.76799-1-donald.hunter@gmail.com>
 <20241210161448.76799-8-donald.hunter@gmail.com> <20241211210713.GE2806@kernel.org>
In-Reply-To: <20241211210713.GE2806@kernel.org>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Wed, 11 Dec 2024 22:24:37 +0000
Message-ID: <CAAf2ycnfaZ9z4+skH9cUFxgx8Dk60ct-WsZXq9YS6gUtY1dQFw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/7] netlink: specs: wireless: add a spec for nl80211
To: Simon Horman <horms@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 21:13, Simon Horman <horms@kernel.org> wrote:
>
> On Tue, Dec 10, 2024 at 04:14:48PM +0000, Donald Hunter wrote:
> > Add a rudimentary YNL spec for nl80211 that covers get-wiphy,
> > get-interface and get-protocol-features.
> >
> > ./tools/net/ynl/cli.py \
> >     --spec Documentation/netlink/specs/nl80211.yaml \
> >     --do get-protocol-features
> > {'protocol-features': {'split-wiphy-dump'}}
> >
> > ./tools/net/ynl/cli.py \
> >     --spec Documentation/netlink/specs/nl80211.yaml \
> >     --dump get-wiphy --json '{ "split-wiphy-dump": true }'
> >
> > ./tools/net/ynl/cli.py \
> >     --spec Documentation/netlink/specs/nl80211.yaml \
> >     --dump get-interface
> >
> > Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>
> Hi Donald,
>
> Perhaps I'm doing something silly here, or my environment is somehow
> broken. But with this patch applied I see:
>
> make -C tools/net/ynl/ distclean && make -C tools/net/ynl/
> ...
> Exception: new_attr: unsupported sub-type u32
> make[1]: *** [Makefile:37: nl80211-user.c] Error 1

Hi Simon,

Thanks for reporting. It was also flagged up on patchwork. My bad. I
had a blind spot for checking the C build because the last few specs I
have worked on have been netlink-raw which don't have codegen. I'll
look at fixing this and any subsequent issues.

Thanks,
Donald.


