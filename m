Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE22A5BB0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 02:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgKDBRe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 20:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgKDBRe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 20:17:34 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CABC040203
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 17:17:34 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n15so17840869otl.8
        for <linux-wireless@vger.kernel.org>; Tue, 03 Nov 2020 17:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWLBlprm1Z8PFZFufIugvFYMXyp4CNmp/lPYMF15bJ4=;
        b=oU8dM/bWLZV65XH0tQGkpLqPMLlHi3sQJ7DvfKwBsXihxrrakkH/9X7Q0eSLZ0QB2M
         dnxsR2UZDGFq7n8GTm93deLexzbYUj9dBMALrf7kyCQl1R6+5WXaQkwjNpvM499wbsJi
         ihmx8o4KqZoXch1oBgE3YP2v57q762PwRxVHJCZVIrhEwy2XhyHhBRCWLriLQ2C9sX/Z
         2D10srJdlk/QtU7ah98i9vrO7yh7e4/x+16zA5ZLxkuJfBgB4XPbdqRiT58hp8/+Si49
         gDIYmJwS8hmDTZ3Mrd+oFv+vHBwiORqkcGo3+uxOnwy9Gi3D7KfSD6fN3ummedf+F9Ey
         ezDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWLBlprm1Z8PFZFufIugvFYMXyp4CNmp/lPYMF15bJ4=;
        b=FG5asvpu+6Q5vA3nAv2epnd4lGp2t8OsJpTaAXhvkQnzPMNjlNaUAwxo50zN6FhUeR
         +EJwaCGAPXj+QvUQpYvnAJdNKi+lvpeFtIw12Q1MhcaFKeJHlMWRvoiVWfJRcT6wNlIY
         CI35enu/y/hI8tSv/8hsFFFWzG1cVIfLPz9SE1G7oAbInEuU7aqX+UM/2BunsuTV/JWw
         udIL8NAcp3WMTUsigetPkE8Zwro1jxX2d/ceg3v2Sfqxo8Lz39QHIIVdBNi+IgfeQhH5
         uJMSRRRDWT+nUdk+D4U1XJyDjUckmv8D76gmRVuFXrBAhf4TukFaJ50QSQeE5nz5/GKT
         doCA==
X-Gm-Message-State: AOAM531XkX1JbmFhq2Zuzkw3KVSerC+Q4KKzmlPcVB6U5KGTWjYOPlrM
        sgmmTO+lEViJ0I2SCbGZKcynGluZbAjN+BcaF+8WOQ==
X-Google-Smtp-Source: ABdhPJxJNJ3n76Dhx+C4wWZrUnXySf/w3Ku2Z4YwEnPJlcTYGD18tV0hUlmRpzArksnEZKJs21hKaKCDxoS10lYE1gY=
X-Received: by 2002:a9d:6013:: with SMTP id h19mr17469425otj.262.1604452653311;
 Tue, 03 Nov 2020 17:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20201030205639.1452712-1-kuabhs@chromium.org> <20201031024631.1528113-1-kuabhs@chromium.org>
 <e5302eb0b20339d3f6544652e4034993@codeaurora.org> <aba43fb268fe29aecf84bf7e68629dc0de28d0ad.camel@sipsolutions.net>
In-Reply-To: <aba43fb268fe29aecf84bf7e68629dc0de28d0ad.camel@sipsolutions.net>
From:   Abhishek Kumar <kuabhs@google.com>
Date:   Tue, 3 Nov 2020 17:17:22 -0800
Message-ID: <CAB5ih=PtneRW+sU9KbPNgEM8GvPA1rfa87M41fsL=y=VP71Y5Q@mail.gmail.com>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power limitations.
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Carl Huang <cjhuang@codeaurora.org>,
        Abhishek Kumar <kuabhs@chromium.org>, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 3, 2020 at 5:15 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-11-03 at 10:34 +0800, Carl Huang wrote:
> > On 2020-10-31 10:46, Abhishek Kumar wrote:
> > > From: kuabhs@chromium.org
> > >
> > > There are few more additional comments here.
> > > > + * @NL80211_CMD_SET_SAR_SPECS: SAR power limitation configuration is
> > > > + *     passed using %NL80211_ATTR_SAR_SPEC.
> > > > + *
> > >
> > > This command requires NL80211_ATTR_IFINDEX, probably should be better
> > > to add
> > > this in the comment ?
> > >
> > Per Johannes's comments, this explicit index is not required. Are you
> > fine with it?
> >
> > Instead, user-space application records the array index when querying
> > the SAR
> > capability. When set, the nested array index will be used to set the
> > power.
> > This requires user-space has a strict mapping of index. and
> > NL80211_ATTR_IFINDEX
> > is to be removed.
>
> Wait, what? The IFINDEX is still required, that identifies the interface
> - though it probably shouldn't be required, this should be per wiphy, so
> you could also use ATTR_WIPHY_IDX?
>
> You're thinking of ... something
> else. NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX perhaps?

Yes, probably the index mapping that you are talking about is using
NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX .

I think Johannes has already covered most of the comments. I have one
last one  mentioned below.

> +nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
> +                     struct sk_buff *msg)
> +{
> +       struct nlattr *sar_capa, *specs, *sub_freq_range;
> +       u8  num_freq_ranges;
> +       int i;
> +
> +       if (!rdev->wiphy.sar_capa)
> +               return 0;
> +
> +       num_freq_ranges = rdev->wiphy.sar_capa->num_freq_ranges;
> +
> +       sar_capa = nla_nest_start(msg, NL80211_ATTR_SAR_SPEC);
> +       if (!sar_capa)
> +               return -ENOSPC;
> +
> +       if (nla_put_u16(msg, NL80211_SAR_ATTR_TYPE, rdev->wiphy.sar_capa->type))
> +               goto fail;

The nla_put_u16 NL80211_SAR_ATTR_TYPE here uses u16 whereas in the to
get this property below it uses nla_get_u32 .  I think this should be
consistent ?

> +       if (!tb[NL80211_SAR_ATTR_TYPE])
> +               return -EINVAL;
> +
> +       type = nla_get_u32(tb[NL80211_SAR_ATTR_TYPE]);
> +
> +       if (!tb[NL80211_SAR_ATTR_SPECS])
> +               return -EINVAL;

As mentioned above the get and put for NL80211_SAR_ATTR_TYPE is not consistent.

-Abhishek
