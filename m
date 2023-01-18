Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC4672739
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 19:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjARSjf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 13:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjARSjH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 13:39:07 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92247166C5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 10:39:02 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 7so25197563pga.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 10:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TkdLxEaiYbYFI01FIO46fjb3rebDHbOyroQ5aM/rJo=;
        b=A0bbzArU4k4MCbWU+aHa7acGbVm1cT8zGL4DyhJlRgzOwV4UESfyKlfNemaDL+x68u
         1QqDsPbIK50FF1dtzOrsUijWUFKxmj8HxLyYMasaitickD+GM2A2vUH/mM3ANclbV14j
         QdXP1791oRsFASvWrUlJaa0hZjmUOesfmu+gYCbMUHSCjOvT7m0UyMsUTUd7PEdlpwCx
         AePEedAAQE3WvbqRAHteP0CEYKhtt8afcSd9/r1d/jaAo4e2BiTe52zIUDvSVpSCFeL8
         iSpq0+H79gu1me2ybIiebc0BfEk5b2HPoNdYIozk/2xvVnuII8Q+dTW1LJE4rIUfFqv7
         yv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TkdLxEaiYbYFI01FIO46fjb3rebDHbOyroQ5aM/rJo=;
        b=zQS4atRz3AegVGN6fh+wxn+4c1N8pUWIdY+11h/7tWxRQenyRuiog1qqSJm+tgLomS
         zjKS04fzw5/6q5UqeEn/bau/Rzlnw3aoAsRj5U3ElpFsnwWh4gpuq4q3eFFKKStkzGAB
         SyjV1WPO73d3X7WZpOuLegkwOifIMvcuTDHSDduKDozk6NCtIHaaZo0+Kip3CsIWDF7U
         0qfLHgZVa9M9T+GnUe18nInpxyr4cEWIu3r4CfPqlhESvc6TvWPekr/vtbmAWvqfd3Kw
         4TZrQKAjhA3LQphOU6IAEXc6cYmplPYFRGTMafrrfNQ8K63zNDlnsAJsOeLDqmWyQ0BV
         ryPQ==
X-Gm-Message-State: AFqh2kpBANKVPycmpSAIsFRfYvnTzLPXopuOKjTI02GK5asYt2YAKkNw
        NPn+9VG9a1mpx1B1Y57+jwE=
X-Google-Smtp-Source: AMrXdXuaz4TvhIHSbMzfo06L6pyVRJ9XVw/hw4569hDP6nd0dx3+g9gsynMOZoQcHvf+VVRGvK7/1Q==
X-Received: by 2002:aa7:8a50:0:b0:587:d491:995f with SMTP id n16-20020aa78a50000000b00587d491995fmr8276757pfa.20.1674067141999;
        Wed, 18 Jan 2023 10:39:01 -0800 (PST)
Received: from [192.168.254.20] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id u4-20020a626004000000b00575caf80d08sm5531517pfb.31.2023.01.18.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:39:01 -0800 (PST)
Message-ID: <0594be9d5415b215926d40a2f92390d056057811.camel@gmail.com>
Subject: Re: [PATCH 0/1] Fix __ieee80211_disconnect when not associated
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 10:39:01 -0800
In-Reply-To: <bf0193b9d8546c9712e0cb0fcaf4c90913098771.camel@sipsolutions.net>
References: <20221025203443.410121-1-prestwoj@gmail.com>
         <6b963cb79064fb70eeba7fdcc6ff5abb25348144.camel@sipsolutions.net>
         <52746d84e1961ee6cb896a8f23d6857774945014.camel@gmail.com>
         <bf0193b9d8546c9712e0cb0fcaf4c90913098771.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-01-18 at 19:08 +0100, Johannes Berg wrote:
> On Wed, 2023-01-18 at 09:54 -0800, James Prestwood wrote:
> > > 

<snip>
> 

> > 4. At this point the firmware decides its not gonna continue and
> > calls
> > __ieee80211_disconnect which is a no-op when not associated.
> > 
> 
> This is also completely irrelevant to the state. The firmware doesn't
> "decide not to continue". Something else already decided it doesn't
> want
> to continue. This is entirely driven from the top - be it the
> net/wireless/sme.c for CMD_CONNECT, or userspace for CMD_AUTHENTICATE
> and CMD_ASSOCIATE.

Well, we see this:

iwlwifi 0000:00:14.3: Not associated and the session protection is over
already...

So _something_ happens in the driver/firmware causing this event to be
generated, thats all I'm saying. But yes, it really doesn't matter why
but rather how mac80211 handles it.

> 
> > We assumed
> > either CMD_ASSOCIATE or CMD_CONNECT will come after
> > CMD_AUTHENTICATE,
> > or a CMD_DEAUTH if there was a problem.
> 
> Yeah for CMD_CONNECT I guess that's reasonable. In fact you really
> shouldn't even look at the authenticate/associate even in these cases
> since they're not guaranteed (e.g. if you have a fullmac device),
> they
> only happen as a consequence of the mac80211 implementation, not by
> design.
> 
> So I think you're just looking in the wrong place - the real question
> is
> why the association sequence in net/wireless/sme.c doesn't continue
> (or
> abort) at this point?

I think I narrowed down this "why" pretty well. A connection loss event
happens between a successful authentication but before association.
Since __ieee80211_disconnect does not take this state into account the
kernel haults the reassociation and never informs userspace.

Maybe my solution/fix is incorrect, but its at least a starting point.

> 
> The whole "firmware event" thing is completely incidental and an
> implementation detail. The firmware decides nothing. All that happens
> here is that the firmware decided to no longer wait for the
> association
> to happen (but that wasn't even started), and a driver bug that
> basically just prints the wrong message - it says it's expecting to
> be
> associated but it can't actually expect that since we never even
> transmitted an association request.
> 
> > I will say, we do see a CMD_DEL_STATION event here which we never
> > processed in this case.
> 
> And you probably shouldn't anyway, again more of an implementation
> detail, not really by design.
> 
> > But again, I would expect a CMD_DEAUTHENTICATE
> > since we successfully authenticated, right?
> 
> No, you can't expect that, you could be authenticated with the AP for
> an
> indefinite amount of time, or never hear the deauth frame (if it ever
> sends one).

Ok, so at least a CMD_CONNECT event right?

Maybe I'm giving nl80211 too much credit, but the
CMD_AUTH/ASSOC/CONNECT APIs have always seemed symmetric in terms of
events, in that if you issue one of these commands you will get an
event in return. So I would expect CMD_CONNECT to generate a
CMD_CONNECT event.

> 
> johannes


