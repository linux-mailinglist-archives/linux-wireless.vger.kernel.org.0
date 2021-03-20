Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE41434295E
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Mar 2021 01:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCTANy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 20:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhCTANk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 20:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616199220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0in7Kz49NXHesq0ylu3p5N0bWWtmATp5ChZezZpRug=;
        b=ONJW/Nf3RN2nahvHV4ocEsBFRjfGL6Dx/LL3suz+tDx73Nmo8AYWZdfkcUpLOLdKfctLMK
        aVVu4ZqHbVn5khOV9Ub6gLI83rYLq9PKDxAUA8YU+09tBeJHC5g7JGduQcci8a+FuND+9r
        ED41+4h2/JYFkjpma5EEAIEHmhvvlqc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-Y6P2x6MRP9myqLAkFVvkBw-1; Fri, 19 Mar 2021 20:13:38 -0400
X-MC-Unique: Y6P2x6MRP9myqLAkFVvkBw-1
Received: by mail-ed1-f72.google.com with SMTP id i6so23814819edq.12
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 17:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=e0in7Kz49NXHesq0ylu3p5N0bWWtmATp5ChZezZpRug=;
        b=GMvla+C5lQxlFZZU9VzxJSCUgJ/24xWNGZjojLwSGsMYcIK8eo4CIbvrn0rjw1NyzK
         sEPNocnwFe0Zz3AywYiWBuf5zUIdZNxeFXZxxAkJKjgDQzyRuM5hjwsRPU0cNRmtg3Gr
         symtcQ8JjdXzkJbFQPRxUCs6yLh6Q9g6lfkg1/S1VujftRiF4fVrweE8+vXWzlAnyKoZ
         zNKjlo29aTVzBxCakkbIGX1oX4zhs7d9xbnkRBHFyKBWF0qoYEAiLgdMYqwWUDH++1d9
         lCfI3CTAXeClqByOLeta517gHfmycSH1BWBWs9PMVDKmonHRnuyCEjuhRUHTjBjuJVGa
         +8yA==
X-Gm-Message-State: AOAM530divjo/NREH70cMTqeMIeboof2JV+KS06FaJvm2ymA8aucmxS5
        kVFXSM5xMOtBQJwPboK3xQaGjVGf81MHHR9niP17Ztl2+T+eBkAuvFSbbQ6fUeFGV/7ns/XZ28Y
        f4d6L8szgcBy31cNBI65OV1myUzQ=
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr12604587edt.187.1616199216417;
        Fri, 19 Mar 2021 17:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwKM++tpMsVik9quHkYPTMO5BhEs9CnCNVJ8lyFcmg7VK3B3Ks03pydsvY4PK2yK731HWnPQ==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr12604565edt.187.1616199216077;
        Fri, 19 Mar 2021 17:13:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p19sm5034148edr.57.2021.03.19.17.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:13:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D200D181F54; Sat, 20 Mar 2021 01:13:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211: don't apply flow control on management frames
In-Reply-To: <20210319232800.0e876c800866.Id2b66eb5a17f3869b776c39b5ca713272ea09d5d@changeid>
References: <20210319232800.0e876c800866.Id2b66eb5a17f3869b776c39b5ca713272ea09d5d@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 20 Mar 2021 01:13:34 +0100
Message-ID: <87h7l6adht.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> In some cases (depending on the driver, but it's true e.g. for
> iwlwifi) we're using an internal TXQ for management packets,
> mostly to simplify the code and to have a place to queue them.
> However, it appears that in certain cases we can confuse the
> code and management frames are dropped, which is certainly not
> what we want.
>
> Short-circuit the processing of management frames. To keep the
> impact minimal, only put them on the frags queue and check the
> tid == management only for doing that and to skip the airtime
> fairness checks, if applicable.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/tx.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 5d06de61047a..b2d09acb9fb0 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -5,7 +5,7 @@
>   * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
>   * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
>   * Copyright 2013-2014  Intel Mobile Communications GmbH
> - * Copyright (C) 2018-2020 Intel Corporation
> + * Copyright (C) 2018-2021 Intel Corporation
>   *
>   * Transmit and frame generation functions.
>   */
> @@ -1388,8 +1388,17 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
>  	ieee80211_set_skb_enqueue_time(skb);
>  
>  	spin_lock_bh(&fq->lock);
> -	fq_tin_enqueue(fq, tin, flow_idx, skb,
> -		       fq_skb_free_func);
> +	/*
> +	 * For management frames, don't really apply codel etc.,
> +	 * we don't want to apply any shaping or anything we just
> +	 * want to simplify the driver API by having them on the
> +	 * txqi.
> +	 */
> +	if (unlikely(txqi->txq.tid == IEEE80211_NUM_TIDS))
> +		__skb_queue_tail(&txqi->frags, skb);
> +	else
> +		fq_tin_enqueue(fq, tin, flow_idx, skb,
> +			       fq_skb_free_func);

One consequence of this is that we create a strict priority queue for
management frames. With all the possibilities for badness (such as the
ability of starving all other queues) that carries with it. I guess
that's probably fine for management frames, though, right? As in, there
is some other mechanism that prevents abuse of this?

-Toke

