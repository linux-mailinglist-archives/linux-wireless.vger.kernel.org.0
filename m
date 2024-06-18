Return-Path: <linux-wireless+bounces-9140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D932E90C716
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3212DB23D87
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B11AAE3F;
	Tue, 18 Jun 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chsLF/OH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556B14EC51
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699180; cv=none; b=T2p51xvoJmxci+fmBnY4y7/qi1FAqmcPAwv8IdgVSCvddSZXL4xzNFf59GvMuYJsxIsRbaeTK/4q/GQNeCH+rypwtLE/jP4IcWM8xq2HAlCGUDxOOJwPPQ64AVh12okDWAjbpaRkzO/mzZv9cP1h1qrg9AzahxLec6KcTaYWqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699180; c=relaxed/simple;
	bh=g4WS8oXJ9ThgmbB0X4X/raZWanyBvfS7aFg2Ed8tr4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PgSPT9dztE4teaKnquPEPZWKMsds7sEpLt2n+eUQl4k5wcdIcn+BL0nje3x6uTsXvWgz3wYRfAxoWqA284TjMIGsNw9IbXBUcId8n0tR/JldwXU2e2jPqb9Aynmko6f4eEDI3syUFGCMQTv2ylr3VQ2cNWO5HXYid885oEbPHrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chsLF/OH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718699176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p2ATvm11PclBQWx70TQOYEfubW2SvZbggiMm3LQ7tFE=;
	b=chsLF/OHGUrOZFibmI+YrqFKpsP8BJ7vMVHbII0TSU3mCn3GrUveKurA7pV/XvoTZIDxOc
	Wy0QcR7d1XcDy3QRKClqe86sgw6JVB4mdR7XF9ZViOXg71w4uQi+Qjp3xVOKqLXcIYZLD6
	qlhIk+5rN6fgvvoAJ83iaVOF9slB7Ys=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-JAwxLW1AP9uKwGJF-NCk8w-1; Tue, 18 Jun 2024 04:26:15 -0400
X-MC-Unique: JAwxLW1AP9uKwGJF-NCk8w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4217e21bcd4so2358165e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 01:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699174; x=1719303974;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2ATvm11PclBQWx70TQOYEfubW2SvZbggiMm3LQ7tFE=;
        b=IUxdR7ZIv353zpzqtcGJApDWldadrFasptuNRBf1WEKdsY+i1mzJjq53gL0XzyTKOx
         Si6Nzyfnf888pvm6F+3HJ0WuklKKve8u4ZEoMHLdRWCCxPLfW0igbQp19DPX+5Vr8O13
         yqDjH5zhd/8wu3mrpva39GLj4qsjKILx8rhsFD/D7S5CCHToJUm14mojdBRdoQzn4UFB
         ACzWl4B1ErXFn8YRYBqp4NW00fqB/NKopSYPDuhWIiftq66a8n3O1lEAGuqc6QZ4indO
         GUxaWRzBVU84OAf/v5VY0y8nbcGVxKcSRRqr0q1bSkc2d/U5/Ev9pAA3wbtQ3q6UYiOu
         uOQA==
X-Forwarded-Encrypted: i=1; AJvYcCWRLAkqPX+eG6i1fVj/f0SIgcMRpiZnrlpj/5V3wy1bOeJfwEhziYQr5Mn54c6wPUVuED1yryal8TQG9Fb3l4yZFLD7xbEsrUPNne5sEKQ=
X-Gm-Message-State: AOJu0Yx4C+N8xhuldoSyzu4an5R372K72cO8JdtzdzuW49OAWzLGgOHM
	Tphkrv1aUlkQlOuQX3TmnKzdAlbfcFRlPaUy5T6w4KunW6eFyxh61f12QU/AX+fuZ4cVUgX728D
	p0kTfVr5duiCJEa6iszTVI8neni6JdmSRz3h0SqQqL57biqFuqQFyKAJm3BR3FJw+
X-Received: by 2002:a05:600c:1d1b:b0:421:74d4:f32c with SMTP id 5b1f17b1804b1-42304d7f7b9mr88461535e9.1.1718699173999;
        Tue, 18 Jun 2024 01:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWqpCxWr0uOe6kQvSYzFQxJy29SIUhW3T6yuKBV46eMgVNLb1HfpI+xg2q6FhUZ3RLVF0LYA==
X-Received: by 2002:a05:600c:1d1b:b0:421:74d4:f32c with SMTP id 5b1f17b1804b1-42304d7f7b9mr88461355e9.1.1718699173592;
        Tue, 18 Jun 2024 01:26:13 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0b4:c10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42301a7c850sm175348375e9.6.2024.06.18.01.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:26:13 -0700 (PDT)
Message-ID: <294c30a62d415c9b641be32df2b527cfff19ef62.camel@redhat.com>
Subject: Re: [PATCH v5 3/4] net: dropreason: use new __print_sym() in tracing
From: Paolo Abeni <pabeni@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Date: Tue, 18 Jun 2024 10:26:11 +0200
In-Reply-To: <20240614081956.19832-8-johannes@sipsolutions.net>
References: <20240614081956.19832-6-johannes@sipsolutions.net>
	 <20240614081956.19832-8-johannes@sipsolutions.net>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-14 at 10:19 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> The __print_symbolic() could only ever print the core
> drop reasons, since that's the way the infrastructure
> works. Now that we have __print_sym() with all the
> advantages mentioned in that commit, convert to that
> and get all the drop reasons from all subsystems. As
> we already have a list of them, that's really easy.
>=20
> This is a little bit of .text (~100 bytes in my build)
> and saves a lot of .data (~17k).
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  include/net/dropreason.h   |  5 +++++
>  include/trace/events/skb.h | 16 +++-----------
>  net/core/skbuff.c          | 43 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/net/dropreason.h b/include/net/dropreason.h
> index 56cb7be92244..c157070b5303 100644
> --- a/include/net/dropreason.h
> +++ b/include/net/dropreason.h
> @@ -42,6 +42,11 @@ struct drop_reason_list {
>  extern const struct drop_reason_list __rcu *
>  drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
> =20
> +#ifdef CONFIG_TRACEPOINTS
> +const char *drop_reason_lookup(unsigned long long value);
> +void drop_reason_show(struct seq_file *m);
> +#endif
> +
>  void drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
>  				  const struct drop_reason_list *list);
>  void drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys);
> diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> index 07e0715628ec..8a1a63f9e796 100644
> --- a/include/trace/events/skb.h
> +++ b/include/trace/events/skb.h
> @@ -8,15 +8,9 @@
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
>  #include <linux/tracepoint.h>
> +#include <net/dropreason.h>
> =20
> -#undef FN
> -#define FN(reason)	TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
> -DEFINE_DROP_REASON(FN, FN)
> -
> -#undef FN
> -#undef FNe
> -#define FN(reason)	{ SKB_DROP_REASON_##reason, #reason },
> -#define FNe(reason)	{ SKB_DROP_REASON_##reason, #reason }
> +TRACE_DEFINE_SYM_FNS(drop_reason, drop_reason_lookup, drop_reason_show);
> =20
>  /*
>   * Tracepoint for free an sk_buff:
> @@ -44,13 +38,9 @@ TRACE_EVENT(kfree_skb,
> =20
>  	TP_printk("skbaddr=3D%p protocol=3D%u location=3D%pS reason: %s",
>  		  __entry->skbaddr, __entry->protocol, __entry->location,
> -		  __print_symbolic(__entry->reason,
> -				   DEFINE_DROP_REASON(FN, FNe)))
> +		  __print_sym(__entry->reason, drop_reason ))

Minor nit: if you have to repost for other reasons,       ^^ here
checkpatch complains for the extra space.

Otherwise LGTM,

Thanks!

Paolo


