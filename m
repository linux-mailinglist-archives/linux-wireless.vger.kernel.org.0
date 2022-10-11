Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A761C5FABEE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 07:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiJKFem (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 01:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKFel (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 01:34:41 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF28E33
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 22:34:38 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id h4so13190829vsr.11
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry4kB27vc8XIspDU6YdMTTqq/cvFJAGxgGuoW/PQYlM=;
        b=SQUnGjUgFJ1jgahxdCwMTThB8slSDq8MB7EYubE4dcNrvvOLm8uXU/NDzgjmZee/7C
         gYdZk1ov772qI6QirIFse1ZvqQ9vAE3oHPTAeEBibnr+OcGkrsJB3tUhOIocdsLxMGqX
         x3GV0fUFlp3NkHQC7nZFhlZ998POHGDY5GGMTckGezujC32rMjFGzoyHVpwdfuM+JIUG
         5pfRF4nky0zWc9i2t2jx2pHN8yZL4wIdM4wNC+58m5yYKBX5RgfdROztkQ2565KT2jqY
         9p2AnvdSr+GDXa3S5GfQDYgGiU41IodunptLcRUby/ZOLIa3pydtjRVUGtMtt6+ZIAlq
         e4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ry4kB27vc8XIspDU6YdMTTqq/cvFJAGxgGuoW/PQYlM=;
        b=JAHL5s5neWOaMjRLmw6/EJRvDjMMrgjAR6hQC7k1MzrTYRiun9Wt1CEzXkjcSbsstE
         6FJ0xAaguIlumNjLfL8hlYnnNHwMbYQKYZqTrw82yoPlBe1iYhHkE5dC1pSwuhwSFnvM
         eVawZZn+tXTcYCDCwGZYfXpqbNADs2tICGmdDoa1zXyekY193yUpryAWRyeRi91W2Jyr
         FI95Ljs498019B1BLrdx17sVO41NJLKHAOx8gwB8MYaHUVGEXAs2BE2UyrkpP/OZifcv
         cTPjy5/mwWbz1Lyw1Xab+xnVf9Uc1C7+bdTCUx0aed7ermotcVoku9vYMfCNSl4PATMS
         OEiQ==
X-Gm-Message-State: ACrzQf2OIsbBLCz543G4ec8m2Ng8xee1lpinp+QTop90LUIl4fOU4CxS
        6YXkFIPawTZs9KAuQDASZh3b1IDNcGfZEXM1SzS/H47rq4k=
X-Google-Smtp-Source: AMsMyM7svbrMzTFCAWd7sAS0zNBv2YT+TKCE6go9PvNsgUKkw10EaowKAJySWB9MgjpNu0Hf7zJXNfsjIo87mZ3bSLY=
X-Received: by 2002:a67:af1a:0:b0:3a7:247:34a6 with SMTP id
 v26-20020a67af1a000000b003a7024734a6mr10778292vsl.29.1665466477409; Mon, 10
 Oct 2022 22:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220923015550.1292547-1-jaewan@google.com> <1f98f992c4766acbecaeb7066e00b0ca2e2c64fa.camel@sipsolutions.net>
In-Reply-To: <1f98f992c4766acbecaeb7066e00b0ca2e2c64fa.camel@sipsolutions.net>
From:   Jaewan Kim <jaewan@google.com>
Date:   Tue, 11 Oct 2022 14:34:26 +0900
Message-ID: <CABZjns4F2s+77H6kdGt2OCAy-OAQ_BSzJ3S_NxQxuN_pPgn79w@mail.gmail.com>
Subject: Re: [PATCH] iw: info: print PMSR capabilities
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 5, 2022 at 6:48 PM Johannes Berg <johannes@sipsolutions.net> wr=
ote:
>
> On Fri, 2022-09-23 at 10:55 +0900, Jaewan Kim wrote:
> >
> > +++ b/info.c
> > @@ -741,6 +741,9 @@ broken_combination:
> >                       pat->max_pattern_len, pat->max_pkt_offset, rule->=
max_delay);
> >       }
> >
> > +     if (tb_msg[NL80211_ATTR_PEER_MEASUREMENTS])
> > +             print_pmsr_capabilities(tb_msg[NL80211_ATTR_PEER_MEASUREM=
ENTS]);
> > +
> >       if (tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA])
> >               printf("\tMaximum associated stations in AP mode: %u\n",
> >                      nla_get_u16(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA])=
);
> > diff --git a/iw.h b/iw.h
> > index e712c59..0707cb4 100644
> > --- a/iw.h
> > +++ b/iw.h
> > @@ -221,6 +221,7 @@ void print_vht_info(__u32 capa, const __u8 *mcs);
> >  void print_he_capability(const uint8_t *ie, int len);
> >  void print_he_info(struct nlattr *nl_iftype);
> >  void print_eht_info(struct nlattr *nl_iftype, int band);
> > +void print_pmsr_capabilities(const struct nlattr *pmsr_capa);
>
> Also, FWIW, it would probably make sense to make this static and put it
> into info.c at least while it's not used elsewhere?
>
> johannes

My apologies. I made a mistake when moving changes from the Android repo.
Could you take another look at the patch? It would be a great help.

--=20
Jaewan Kim (=EA=B9=80=EC=9E=AC=EC=99=84) | Software Engineer in Google Kore=
a |
jaewan@google.com | +82-10-2781-5078
