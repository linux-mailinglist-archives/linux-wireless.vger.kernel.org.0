Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5FF7780A9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 20:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjHJSsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 14:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjHJSsJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 14:48:09 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B2DEA
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 11:48:08 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a7d7de894bso501932b6e.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691693287; x=1692298087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze3eFn9HLq7IBoP8s3fALbKZvRPzgrRdddTs4KNujfQ=;
        b=HrqGj+z1TbD+BIPYFzkVp8jKABhwdS1sMwziMA/Vzkm7MNrco1wyRYorpJZrMOXqdw
         bJIp14dfEKK7NeaACKQlXESRSG/MueVsPh5mSgzxSAXACrTFwQJqitug4eM7FXxRjj4H
         cAy42ORweCwhcIdoXjYzg1mNirdI6sWMt4guLfJAfJa904v303Vb4zc9wDw+RdvYLuUl
         f5O4VgHGvAofKToXLedzkaEQY8foi88E3gBdw+SzzahxIn2D5RRexBYtmzktoqifnHH6
         rCOVgXWTfmHv4Qs3UcDgcPldPvH1pjUQdqgY9FVM0CE4zngjzT5n2cPcjTlqAPLkf8VP
         CBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693287; x=1692298087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ze3eFn9HLq7IBoP8s3fALbKZvRPzgrRdddTs4KNujfQ=;
        b=RwxnVXZG5wOJdcmB5WdOR7SJILy/FiP3if1McR+23ueB4ttm0rE6JQh3zRb5soC8p3
         nNM6oLaWjfw14HCs01rgfbLDY0anoeNsq6d+K2aVksmSIAzmFlxd0zalkLcQK25L0OlM
         UlBldULLMqd6E1nGr7QjEnhyqvb2M0ySKnBGqVHc29Yv752tirEZEtrexmTAbUtAZqLD
         rwEtTizg8tJyBtg9XMLs6oT9qLepHNAMy4K+9PH0O3OKdYRW+OYr9TYivT66lvtgOxIC
         6fK+c+BV5Y5LW+H6GHC9690FJR7tZxyBsSf/LpSqfJf6NKL7aE1/gWUgTGfhp22D32A7
         ZiMg==
X-Gm-Message-State: AOJu0YxrqpQCV+f3AIdtvOBmADKENJiwwbMq2CjMCTLgRSV8x32zGlEl
        N89RPM+v6Aeug7OwRzOIaT5aIGOfwlV7gUCsJ5K2yhuy+5M=
X-Google-Smtp-Source: AGHT+IGMmbLI7D8+DPFOrWWIYA0IVXJjDsC258jHZ4lxI8Uk5V9Wwu5f/Ybe0BN2Q/Np9mYCz16AN9J6rfbl/0V58qM=
X-Received: by 2002:a05:6808:2097:b0:3a7:5524:9b75 with SMTP id
 s23-20020a056808209700b003a755249b75mr4547507oiw.45.1691693287657; Thu, 10
 Aug 2023 11:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230719194039.16179-1-Chaitanya.Tata@nordicsemi.no>
 <2307e1741e9d32e8f1ffc4e83c73b63a4e32512b.camel@sipsolutions.net> <CABPxzYJvAtgbrr_v6cMuKwFjzRjYOCDota+koYp-iogtJS75HQ@mail.gmail.com>
In-Reply-To: <CABPxzYJvAtgbrr_v6cMuKwFjzRjYOCDota+koYp-iogtJS75HQ@mail.gmail.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Fri, 11 Aug 2023 00:17:49 +0530
Message-ID: <CABPxzY+_2DEK-wfAr1V9z1iHZky-7vF24mQx2yFgtFUoTdWgmw@mail.gmail.com>
Subject: Re: [PATCH] wifi: Add support for sending BSSMaxIdle in association request
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 11, 2023 at 12:05=E2=80=AFAM Krishna Chaitanya
<chaitanya.mgit@gmail.com> wrote:
>
> On Tue, Aug 8, 2023 at 4:43=E2=80=AFPM Johannes Berg <johannes@sipsolutio=
ns.net> wrote:
> >
> > On Thu, 2023-07-20 at 01:10 +0530, Chaitanya Tata wrote:
> > > When WNM is enabled, a station can send its preferred BSS maximum idl=
e
> > > period in the association request, add a new netlink attribute to get
> > > this value from the supplicant and add BSS maximum idle IE in the
> > > association request.
> > >
> >
> > I don't see anything here that even requires all this code, rather than
> > wpa_s just including the element itself in the association request extr=
a
> > IEs?
> Yeah, WPA supplicant can prepare this, please ignore, thanks.
Just remembered why I had to implement this in kernel, the associate/connec=
t
data structure in wpa_s `wpa_driver_associate_params` doesn't have any
ies/extra_ies, it only gives wpa_ie and rest all are parameters for mac8021=
1
to use. So, had just extended this as well, do you think we should add
this ies/extra_ies
to the association like we do for scan? Or as MLME is in mac80211,
just use this patch as is?
