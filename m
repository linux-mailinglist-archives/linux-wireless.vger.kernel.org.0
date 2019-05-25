Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6512A2A3
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2019 05:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfEYDqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 May 2019 23:46:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43148 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfEYDqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 May 2019 23:46:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id t187so8447673oie.10
        for <linux-wireless@vger.kernel.org>; Fri, 24 May 2019 20:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReUtPBqL58WYnd/5rJenMtO9LN3Zrp2YnhBMRbcxDAo=;
        b=YAQgyvIHQrUUQeGs1jC5DxqBe0SGCvlV/F2vlAV8Pubm9zc15GgQh7aMmb95w+0u5J
         /+iteHtow+ANm9bq/5FebeH4o3ZdCCQRUzcSLi1ziVFml/6VqHfVPjkAyKxYnRErcn2s
         L/H9ie+j6BxVQMZF0Plg9br1+1rRt+F3zHhnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReUtPBqL58WYnd/5rJenMtO9LN3Zrp2YnhBMRbcxDAo=;
        b=nshqIbyF4sDFsHB8GvSUbWyGVk1AfA0E6RgVg1OdH9gHkhdXcd/6l0vQT6B471c8wV
         7OLBJCSwKZKaaAUcaR9UTozaVho+qwQrBxPzzzYkDCtH3jqZ5kBpMIqSZms7xaJqjjm8
         /NJk7P38Y0D1YOzXMLFcyECylFig/ZuI1Rn+kSgN+qTAnds42hnqwrJuT9n36NkYGAwm
         BtEYBQFVhuS9/o6B4nwRv/F5miw5IC4UMOSirdOKqDuijo1/SYQLBNC70OVu53hiQkvS
         ES57MCBEWQoX/ipcsL87PaMyjZwEk2yg9Ugx6X/FwrD+vAVjCaFrjygDmf5GyC8NE71O
         PntQ==
X-Gm-Message-State: APjAAAXmuqvCsx0mlLLpH9I9yAdap7rJsFy+huCuklACs4z5OVyE6lPY
        DbjKP5dEvGWmRcWhGLTiNIOUgJJaZ8me3o+G/+xb9Q==
X-Google-Smtp-Source: APXvYqzI8wwW8AMr/ncLZ24Gq+ks7Oazi/crybwQoy0J9jh47czDbh8o4brI+/jrCgdGeFLeVA8f8EJjdq3PJnVPYKc=
X-Received: by 2002:aca:f189:: with SMTP id p131mr601289oih.89.1558755993830;
 Fri, 24 May 2019 20:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <1557958906-1432-1-git-send-email-thomas@eero.com> <6e162d98ba05a71577c623fe1e8e06a7051eb01c.camel@sipsolutions.net>
In-Reply-To: <6e162d98ba05a71577c623fe1e8e06a7051eb01c.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@eero.com>
Date:   Fri, 24 May 2019 20:46:22 -0700
Message-ID: <CADjYELz_4VC+14Ko0Lp2zxpMGDSF9SboqN_-LKDjFXmdsxqvXw@mail.gmail.com>
Subject: Re: [PATCH] mac80211: mesh: fix RCU warning
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Peter Oh <peter.oh@bowerswilkins.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 24, 2019 at 1:29 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2019-05-15 at 15:21 -0700, Thomas Pedersen wrote:
> > ifmsh->csa was being dereferenced without the RCU read
> > lock held.
>
> > +++ b/net/mac80211/mesh.c
> > @@ -1220,10 +1220,12 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
> >       ifmsh->chsw_ttl = 0;
> >
> >       /* Remove the CSA and MCSP elements from the beacon */
> > +     rcu_read_lock();
> >       tmp_csa_settings = rcu_dereference(ifmsh->csa);
> >       RCU_INIT_POINTER(ifmsh->csa, NULL);
> >       if (tmp_csa_settings)
> >               kfree_rcu(tmp_csa_settings, rcu_head);
> > +     rcu_read_unlock();
>
> This seems wrong to me.
>
> Really this code is the *writer* side, so you should do something like
> this:

Thanks this looks correct. I should've thought about this a tiny bit more ;)

> diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
> index 766e5e5bab8a..d578147ad7e8 100644
> --- a/net/mac80211/mesh.c
> +++ b/net/mac80211/mesh.c
> @@ -1220,7 +1220,8 @@ int ieee80211_mesh_finish_csa(struct
> ieee80211_sub_if_data *sdata)
>         ifmsh->chsw_ttl = 0;
>
>         /* Remove the CSA and MCSP elements from the beacon */
> -       tmp_csa_settings = rcu_dereference(ifmsh->csa);
> +       tmp_csa_settings = rcu_dereference_protected(ifmsh->csa,
> +                               lockdep_is_held(&sdata->wdev.mtx));
>         RCU_INIT_POINTER(ifmsh->csa, NULL);
>         if (tmp_csa_settings)
>                 kfree_rcu(tmp_csa_settings, rcu_head);
> @@ -1242,6 +1243,8 @@ int ieee80211_mesh_csa_beacon(struct
> ieee80211_sub_if_data *sdata,
>         struct mesh_csa_settings *tmp_csa_settings;
>         int ret = 0;
>
> +       lockdep_assert_held(&sdata->wdev.mtx);
> +
>         tmp_csa_settings = kmalloc(sizeof(*tmp_csa_settings),
>                                    GFP_ATOMIC);
>         if (!tmp_csa_settings)
>
>
> Can you test that and send a proper patch?
>
> johannes
>


-- 
thomas
