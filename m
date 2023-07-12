Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4109750275
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jul 2023 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjGLJGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jul 2023 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjGLJFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jul 2023 05:05:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDAD195
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 02:05:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so4147109a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1689152711; x=1691744711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeB4LiCs/ui+KqHI7O7oRLQBQTEkfeBX6A3a7U04DuE=;
        b=OC1jEvLimDJ8N4w1hhhqbtGTlaOPkUyeghFsqAaNWoSNtGJwxpFFCcTi2GOVX9Mq+E
         Dr6neff4ksqwq2ycuDrF/sW5t7guUr0F74/9BksMoH0mrk/eig/xTOhJ91lKbgH4m3ju
         KwaxTv8BC+u1rjIvktTWYc3FSbwgu1SvBRBGKRJMgpleOv39gcc9QzorGgrV+W7jOH9n
         bLVj4BCoBmvXGwmphwCLrTu+RIjBIND7tXo9H9UFSm8hq0ryMFdqC7Nu9nBiulLX7LCp
         3UquIN6Z+tAVLoTqK25g20BUvj/quOPn9oeqKffEY0NRsRdHA/t1+W+bfabQ2+AGDocu
         Aa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689152711; x=1691744711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeB4LiCs/ui+KqHI7O7oRLQBQTEkfeBX6A3a7U04DuE=;
        b=XcZ8DveDDqfBX6xQThlB9lkxjfzanV5UPHdottXyYprHbANC+xa5LTbZwBx1oaG2YO
         wA6IvPpup3BJps7AjG3A7esuKf+sdiq2j/7OkCiy/br//lvQcjfrLgVW1ylpsCBym4Ic
         ERDbEzIdI/Bx4fTvozBN5EqAfOUARJSCGnYgouKl9WxCcb9aB5AdKISikCrAmxkqVyyR
         z6foePJ2A6gUD+6bqpLFz9mDNF6+KUoqsv86PspjX3kLaytk8jiTGKqQQCksjbOBvV10
         nOfH/GTWZvXZ+pncyeVELLg4kNl2WeGkx3ojmcLsY4K+5zjiptBTtEUNHuBFlngsfc+R
         ctuQ==
X-Gm-Message-State: ABy/qLZlBt66OzxfX9MxHVLUyeJX+KaI0XRoO07sy4+EFLdWbwYWHF3E
        Fez/2bh2ptQL4DypH5ahnH5GeuVlSKfKGXcNoMqX6A==
X-Google-Smtp-Source: APBJJlH4LUJpLDeAxxDKd/GbjNuuMrcURiOMw+M8xengZ4aHcAF/5X2zSxUr1OowYplxlWHEAeCe4+5vBzLewCxn3uI=
X-Received: by 2002:aa7:ccd9:0:b0:51e:362d:b172 with SMTP id
 y25-20020aa7ccd9000000b0051e362db172mr6218843edt.32.1689152711504; Wed, 12
 Jul 2023 02:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230712083841.222607-1-koen.vandeputte@citymesh.com> <9936de52da43347ba0ccfb8737440a9698fb4585.camel@sipsolutions.net>
In-Reply-To: <9936de52da43347ba0ccfb8737440a9698fb4585.camel@sipsolutions.net>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Date:   Wed, 12 Jul 2023 11:05:00 +0200
Message-ID: <CAPh3n82BY0bFkHs6DKKf6+ZUZw+DJmTy7=JEG8REFHyHFMqoVQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: fix mbssid nesting
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 12, 2023 at 10:44=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Wed, 2023-07-12 at 10:38 +0200, Koen Vandeputte wrote:
> > Executing command NL80211_CMD_GET_WIPHY and parsing it's output
> > natively without libnl shows following attributes as part of
> > the nl80211 generated netlink message (part 16):
> >
> > GetWiphy: Type: 1
> > GetWiphy: Type: 2
> > GetWiphy: Type: 46
> > GetWiphy: Type: 33074 <-- wrong enum value, above MAX also ..
>
> That's not wrong, that's just NLA_F_NESTED | NL80211_ATTR_MBSSID_CONFIG,
> since it *is* in fact a nested attribute.

ahha! so one should check on each received attribute if this flag is set?

>
> > Switching to nla_nest_start_noflag() which ommits the NLA_F_NESTED
> > flag (like most other similar functions do) fixes this:
> >
> > GetWiphy: Type: 1
> > GetWiphy: Type: 2
> > GetWiphy: Type: 46
> > GetWiphy: Type: 306 <-- correct enum value
> > GetWiphy: Type: 316
>
> Let's say it _changes_ it, but it doesn't _fix_ it, since it's not
> broken.
noted
>
> Using nla_nest_start_noflag() is a legacy thing, it shouldn't be done
> any more. You need to update your userspace, I'm not applying this
> patch.

Sure, no problem.
I guess all the ones with the noflag so far are using it to avoid
breaking legacy stuff?

>
> johannes
>

Thanks for the quick review.
Highly appreciated!
