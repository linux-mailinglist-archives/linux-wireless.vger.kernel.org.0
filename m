Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03A06CB928
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjC1IQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjC1IQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:16:37 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3109448D
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:16:35 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y85so5023483iof.13
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679991395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RphEZ2Hu45Eg8YhPjSAek+H9QIVYSWnJIg5KvhxHfAU=;
        b=PEOH9fAPi/r0A53E/I5TvgG7dWYLWiCnZUH1WMl7g4vrqCCMh+GT97oY7dN+JHSpx9
         b95Nbo7VJysawugFHTKFOTpjg2RpQlb5TUQe3x3dghTDqjVhf+XJ9vkCeJRHKuVTNcy0
         59FpOfSg01TUanGDBTfwRRBpRVqBxNE2414UqWv8MWDGSDupoBd2GLbqonJpvyeTw2ra
         NRg7zxrWuqrDpn6Dp6vvOuuX0gMeBChzuaLSA+FR9LG8OBqUkjoGP9Z443y9Qn6hBYfr
         pVVvcjT5UftB+J5PIzlfI1OltLdbrzqbakzXubCJ9Y6aFUjuTpXR33rXCuoaKpEYxka8
         meaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679991395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RphEZ2Hu45Eg8YhPjSAek+H9QIVYSWnJIg5KvhxHfAU=;
        b=3cDHogbcbdTTtTaTdLI+TWXFPOpyYhYCB5341enEOpb1JBYpkHLXfIF9ptMyPw9AAm
         WP6eiiPNprnb2uJaUcoJVxk+4Y7WZOaqYY75afpzxGUximZQRW5orGuNKFNAl0JgMM+Y
         LDlsg/iAdE788pkq26+N90Y9c+stZF+B2OKjAHkU29GGP55FpvhlYYiYSLlK4IaT29Jo
         P0Nq06bj83dwVw1ft61vHKi+UBGHSvM2KQFIhvKNhJs9oRHt+l+x52GWOR+3OZ8vtndI
         zs3HakO5cI1fRXC9r4nwdVx/2eSfI2bc5eowv/TkYMnhrm6p8IEmbbgaJtew6CYZQnjI
         E6wg==
X-Gm-Message-State: AO0yUKXdeDF3Luy9skdrVnH6Y2DRMtVSGI0JVb/HMqjs4+T0/SjFfgi0
        t1gCWnIdlUAZj/RDGtGfmyj/VAiv539YAxZRV0KhubV5619kBJ3cc2hcmRJJ
X-Google-Smtp-Source: AK7set+lsNTyPFYwNMmIPAP6YdEEXy3WRPDa759KBaWczHUWPqGN2h9Er4C0Afu040VttXDKysj9r9EGS8NzPPxdvLE=
X-Received: by 2002:a05:6638:379b:b0:3c2:c1c9:8bca with SMTP id
 w27-20020a056638379b00b003c2c1c98bcamr12961702jal.2.1679991395091; Tue, 28
 Mar 2023 01:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <00659771ed54353f92027702c5bbb84702da62ce.camel@sipsolutions.net>
 <20230327180950.79e064da@kernel.org> <abcf4b9aed8adad05841234dad103ced15f9bfb2.camel@sipsolutions.net>
In-Reply-To: <abcf4b9aed8adad05841234dad103ced15f9bfb2.camel@sipsolutions.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 28 Mar 2023 01:16:23 -0700
Message-ID: <CANn89iJn6xmCK8VfJVAqhod9C=nNrqR6OprYKbWO-rrZXxoe_g@mail.gmail.com>
Subject: Re: traceability of wifi packet drops
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 28, 2023 at 12:37=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Mon, 2023-03-27 at 18:09 -0700, Jakub Kicinski wrote:
> > > Anyone have any great ideas?
> >
> > We need something that'd scale to more subsystems, so I don't think
> > having all the definitions in enum skb_drop_reason directly is an
> > option.
>
> Fair enough.
>
> > My knee jerk idea would be to either use the top 8 bits of the
> > skb reason enum to denote the space. And then we'd say 0 is core
> > 1 is wifi (enum ieee80211_rx_result) etc. Within the WiFi space
> > you can use whatever encoding you like.
>
> Right. That's not _that_ far from what I proposed above, except you pull
> the core out
>
> > On a quick look nothing is indexed by the reason directly, so no
> > problems with using the high bits.
>
> I think you missed he drop_reasons[] array in skbuff.c, but I guess we
> could just not add these to the DEFINE_DROP_REASON() macro (and couldn't
> really add them anyway).
>
> The only user seems to be drop_monitor, which anyway checks the array
> bounds (in the trace hit function.)
>
> Or we change the design of this to actually have each subsystem provide
> an array/a callback for their namespace, if the strings are important?
> Some registration/unregistration might be needed for modules, but that
> could be done.
>
> > Option #2 is to add one main drop reason called SKB_DROP_REASON_MAC8021=
1
> > and have a separate tracepoint which exposes the detailed wifi
> > reason and any necessary context. mac80211 would then have its own
> > wrapper around kfree_skb_reason() which triggers the tracepoint.
>
> Yeah, I considered doing that with just the line number, but who knows
> what people might want to use this for in the end, so that's not a great
> idea either I guess :-)
>
> I would prefer the version with the drop reasons, since then also you
> only have to worry about one tracepoint.
>

About visibility: Even before 'drop reasons' developers can always use
the call graph .

perf record -a -g -e skb:kfree_skb ...

Really drop reasons are nice when you want filtering and convenience.
But they are a lot of work to add/maintain.
This all comes at a cost (both maintenance but also run time cost
because we need to propagate reasons )
