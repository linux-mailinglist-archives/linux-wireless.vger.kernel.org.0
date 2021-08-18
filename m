Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44AB3EFFE9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhHRJGX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhHRJGW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 05:06:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F83C0617A8
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 02:05:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w6so1373630plg.9
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 02:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NwlqG+rGO9KvfhCSwLDgRYsI8h6dWdnqYqbHJGPEme0=;
        b=R5Ryqi+3ufOXj4PruwnTvqtfAJxKzmWANSkCph9vX3JAIUwLfa/ogsf0XiAzmuAaIb
         VPDfjaA6JoKlT4Kx+R9SxDMV4d2OeUToJNM29cVAvSSW7Gq1sgBqjsTAvV4VPEc/f7nR
         v/9FoiPkSVtpFKIvuRP2dgdjigBNevI1IirKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NwlqG+rGO9KvfhCSwLDgRYsI8h6dWdnqYqbHJGPEme0=;
        b=NtL7RFbroubRxDbBWWdGwZ8q3KsNqg00WArDvXHN9iqAntCJWJNe6MfB7RUH22Wcfq
         zMmsBx6DeyZnPkMt6pgF8WZlleY6JhgvXvJMr3/vr1H/8wXV/XY2dRE8t6ttRj4GxDK9
         qtcyco3q0HKcJRPxNcjsPf/rjGoavPWtpSpeLB7YeI6ereUUDljDO4Cdu9a3pxSHabCz
         N/t/PepbMusz1bAP9BKCkSuACbapYN170oPVCkWr0Tecbq1XSTLP3winmPCHu3a7X6JC
         valpDIuMFZhU1JXHglGiRR5i9fzYPxRk8xpiQoB44uSPfIqBKk4Qw98DYWmrOQDF6RwT
         7z/w==
X-Gm-Message-State: AOAM5334PgdWWuPaESqgrfX6oX+dMIwWParOMDDzDkbht8tvRi2ntX3T
        +tI6mXDWmCQv6C7oK9OPbPG9pQ==
X-Google-Smtp-Source: ABdhPJy5VoNYR8gwCuIaLE1kUReGMfgEfhj9n5qCxc6K8dzpoM8CUxBKq9FzEjdxDuCc9RNmRV3rMg==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr8162537pjj.117.1629277547417;
        Wed, 18 Aug 2021 02:05:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y19sm5468368pfe.71.2021.08.18.02.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 02:05:46 -0700 (PDT)
Date:   Wed, 18 Aug 2021 02:05:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 44/63] mac80211: Use memset_after() to clear tx status
Message-ID: <202108180203.592E3F01@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-45-keescook@chromium.org>
 <11db2cdc5316b51f3fa2f34e813a458e455c763d.camel@sipsolutions.net>
 <8b48dac4c40127366e91855306d24e07eb0b81d9.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b48dac4c40127366e91855306d24e07eb0b81d9.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 18, 2021 at 10:06:51AM +0200, Johannes Berg wrote:
> On Wed, 2021-08-18 at 09:08 +0200, Johannes Berg wrote:
> > On Tue, 2021-08-17 at 23:05 -0700, Kees Cook wrote:
> > > 
> > > @@ -275,12 +275,11 @@ static void carl9170_tx_release(struct kref *ref)
> > >  	if (WARN_ON_ONCE(!ar))
> > >  		return;
> > >  
> > > 
> > > 
> > > 
> > > -	BUILD_BUG_ON(
> > > -	    offsetof(struct ieee80211_tx_info, status.ack_signal) != 20);
> > > -
> > > -	memset(&txinfo->status.ack_signal, 0,
> > > -	       sizeof(struct ieee80211_tx_info) -
> > > -	       offsetof(struct ieee80211_tx_info, status.ack_signal));
> > > +	/*
> > > +	 * Should this call ieee80211_tx_info_clear_status() instead of clearing
> > > +	 * manually? txinfo->status.rates do not seem to be used here.
> > > +	 */
> > 
> > Since you insist, I went digging :)
> > 
> > It should not, carl9170_tx_fill_rateinfo() has filled the rate
> > information before we get to this point.

Ah-ha! Thanks for checking. I'll update the comment to explain the
rationale here.

> Otherwise, looks fine, FWIW.

Thanks!

> Are you going to apply all of these together somewhere? I (we) can't,
> since memset_after() doesn't exist yet.

Right, given the dependencies, I am expecting to just carry the whole
series, since the vast majority of it has no binary changes, etc. I'm
hoping to get it into -next soon, but we're uncomfortably close to the
merge window. :P

-- 
Kees Cook
