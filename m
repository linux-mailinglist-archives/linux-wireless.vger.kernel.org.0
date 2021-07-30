Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268E93DB124
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 04:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhG3CbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 22:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbhG3CbO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 22:31:14 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B6FC061796
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 19:31:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n10so9281971plf.4
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 19:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fUqZ0NLVZxg4yvCXyE1lEs/e7e2cakQ+3GgW8pZJCvA=;
        b=etYre1AjERNhjyVA/9+2+oLRj921sU45jCtD5h5fRrioHVxndRb/wVYqd+Gvs/9PWN
         W5TIwCrEKVrSomZp1XNcHMR3yLthFd9Qftp86Ybrvy7SLYwhXBueLu90Yc4ejQUhYSOC
         pE6uT73BOuVftlnSqfS6+2EzGpdU+4QF+7NHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fUqZ0NLVZxg4yvCXyE1lEs/e7e2cakQ+3GgW8pZJCvA=;
        b=JrXEWOHmSQv/eI8rcp50TSyw9o8NFsw8n64prbTfTa5pZux9aoblDtg6tHHkZ1CB4i
         Vhj1v0+I3uAPYXoZkY6Qz1lIA/p+NjFg0/zxleBie2tWRC4y1b09s+UieboiM1scE6fE
         fBRDKUy5+2qVLw49lKIY7sZ3iUnr+pQFdKmKrB0S0qp53uZrWUyihp+KqTO/Sqmj1Api
         tdw+N0DtDWk5A7M0GubzgTBGkz7gXambDrScBAJRUO7LfP1N4sz+rYO39afKcvlsVLNF
         V0s9r2f0Ow3WCQTmzvIABL+vbWDiYiR/ZyyZvMR5vulhMJoo2IlMTB8YTl06PqiOEGv/
         SVZw==
X-Gm-Message-State: AOAM531hjHHF0s8J3Rx0qRQtQb7WNLtkZ2jRivE7ZN0W1D+nixUsMpfJ
        OH0aqRYMbmNeUOAoBzk9C/9c3g==
X-Google-Smtp-Source: ABdhPJxIpjyYfp2wSF3KUcMBsoeqagBGHs5J6YJ1XjDsi8DNMVFxuffmFFgkMO9ZoPoLSYu5GHbnWw==
X-Received: by 2002:a05:6a00:168a:b029:2fb:6bb0:aba with SMTP id k10-20020a056a00168ab02902fb6bb00abamr526959pfc.32.1627612270101;
        Thu, 29 Jul 2021 19:31:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm218718pjq.10.2021.07.29.19.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 19:31:09 -0700 (PDT)
Date:   Thu, 29 Jul 2021 19:31:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 48/64] drbd: Use struct_group() to zero algs
Message-ID: <202107291845.1E1528D@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-49-keescook@chromium.org>
 <1cc74e5e-8d28-6da4-244e-861eac075ca2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cc74e5e-8d28-6da4-244e-861eac075ca2@acm.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 28, 2021 at 02:45:55PM -0700, Bart Van Assche wrote:
> On 7/27/21 1:58 PM, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memset(), avoid intentionally writing across
> > neighboring fields.
> > 
> > Add a struct_group() for the algs so that memset() can correctly reason
> > about the size.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   drivers/block/drbd/drbd_main.c     | 3 ++-
> >   drivers/block/drbd/drbd_protocol.h | 6 ++++--
> >   drivers/block/drbd/drbd_receiver.c | 3 ++-
> >   3 files changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> > index 55234a558e98..b824679cfcb2 100644
> > --- a/drivers/block/drbd/drbd_main.c
> > +++ b/drivers/block/drbd/drbd_main.c
> > @@ -729,7 +729,8 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
> >   	cmd = apv >= 89 ? P_SYNC_PARAM89 : P_SYNC_PARAM;
> >   	/* initialize verify_alg and csums_alg */
> > -	memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
> > +	BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
> > +	memset(&p->algs, 0, sizeof(p->algs));
> >   	if (get_ldev(peer_device->device)) {
> >   		dc = rcu_dereference(peer_device->device->ldev->disk_conf);
> > diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
> > index dea59c92ecc1..a882b65ab5d2 100644
> > --- a/drivers/block/drbd/drbd_protocol.h
> > +++ b/drivers/block/drbd/drbd_protocol.h
> > @@ -283,8 +283,10 @@ struct p_rs_param_89 {
> >   struct p_rs_param_95 {
> >   	u32 resync_rate;
> > -	char verify_alg[SHARED_SECRET_MAX];
> > -	char csums_alg[SHARED_SECRET_MAX];
> > +	struct_group(algs,
> > +		char verify_alg[SHARED_SECRET_MAX];
> > +		char csums_alg[SHARED_SECRET_MAX];
> > +	);
> >   	u32 c_plan_ahead;
> >   	u32 c_delay_target;
> >   	u32 c_fill_target;
> > diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> > index 1f740e42e457..6df2539e215b 100644
> > --- a/drivers/block/drbd/drbd_receiver.c
> > +++ b/drivers/block/drbd/drbd_receiver.c
> > @@ -3921,7 +3921,8 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
> >   	/* initialize verify_alg and csums_alg */
> >   	p = pi->data;
> > -	memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
> > +	BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
> > +	memset(&p->algs, 0, sizeof(p->algs));
> 
> Using struct_group() introduces complexity. Has it been considered not to
> modify struct p_rs_param_95 and instead to use two memset() calls instead of
> one (one memset() call per member)?

I went this direction because using two memset()s (or memcpy()s in other
patches) changes the machine code. It's not much of a change, but it
seems easier to justify "no binary changes" via the use of struct_group().

If splitting the memset() is preferred, I can totally do that instead.
:)

-Kees

-- 
Kees Cook
