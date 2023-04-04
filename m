Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7A6D69B6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 19:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjDDRBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjDDRBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 13:01:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A579B8
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 10:01:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r11so33525794wrr.12
        for <linux-wireless@vger.kernel.org>; Tue, 04 Apr 2023 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680627687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDGnXoGwEChAFRAWjhCsHFaWRtmtPVds+R+V0cWphoI=;
        b=tGysa/ySr+aMNbz9i+r+Gzvuh4e9lfJXOuj+yFaOtNFtUxsD3HY0DJYSiv8BFkC6IT
         XCjdnKCGorzQP1R2a7uORzhp7x8GZARFCEmeVKgPEaLy57UxMZQlBdQL3ymkIX+zsfQb
         yVazofjpZXNFp+bLzXLbnEl/zVKfIh3+6tbFAcoJJyZscIHQU/kisj5J82z/u0W3esRs
         riQ1ks6FOD7JmhRsJ9XUtDYGAZ9W831E7C2HHnlZlvPoc/Whno7Jt3VGMQuEOOxMY3pT
         DqrLs0cKaUFoD1eNjR+fcy46Z3gY5YbWtujQ1DzpKNFGk5trjSTG9lMcbzIodyLmFYfl
         JlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDGnXoGwEChAFRAWjhCsHFaWRtmtPVds+R+V0cWphoI=;
        b=Q/WZt8/isBTmGqKJlejERJ1uexmU57DN5TDaRCGMuMqpSwwCqncCMZcISRSyOFqbi7
         BvawKrE/hceuSkNK/aJmHL7f5BjwqIxxneT6IuUUqRxPfuZREenAkCQO+WmSWcpEscs0
         qYlNauUAK6GZrbyKw4ouhk/mJ93k1GqX8MDGXDKW57wDUwkVpkhAy5cJQvJ/xNbKoFfe
         gz5JuBTxO7FislonoDXX40qWQ2zvHnc8yC6WH48L/g7h8FwkvEF5PzMEsyA2b8vE3Hmm
         3mpLfrnY6impoA7gk15++t6NbtUwcVeAnznxfX9CK/Ca9gFmSM3OnraT1BY2XJUOrSxQ
         vhEQ==
X-Gm-Message-State: AAQBX9eWFGhvmhxBU7urWZSFWItB8NoPL3f9Oh0QTt0PAp+QBgoEavJ5
        SbKSi+lqmO+gRZmcLFNl8mB2p6gPuWneaDUWCi1bvw==
X-Google-Smtp-Source: AKy350a81lpxOoVmAEyrppLxUzCnlLNA7TRbMsc14EnlAtwy6sUo9+gDFg4YXp/hscBfZpS80TFszjhVQft+UvEJvT0=
X-Received: by 2002:a5d:4601:0:b0:2cf:e70f:970c with SMTP id
 t1-20020a5d4601000000b002cfe70f970cmr597147wrq.12.1680627687530; Tue, 04 Apr
 2023 10:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230404134803.889673-1-edumazet@google.com> <ZCxN1l3rXnmt+2wL@corigine.com>
In-Reply-To: <ZCxN1l3rXnmt+2wL@corigine.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 4 Apr 2023 19:01:15 +0200
Message-ID: <CANn89i+5R2B00zkjocOOSWRLB0ZNBgjdMLSBbUFpcTOH=9obAw@mail.gmail.com>
Subject: Re: [PATCH net] mac80211_hwsim: fix potential NULL deref in hwsim_pmsr_report_nl()
To:     Simon Horman <simon.horman@corigine.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>,
        Jaewan Kim <jaewan@google.com>,
        Johannes Berg <johannes.berg@intel.com>
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

On Tue, Apr 4, 2023 at 6:18=E2=80=AFPM Simon Horman <simon.horman@corigine.=
com> wrote:
>
> On Tue, Apr 04, 2023 at 01:48:03PM +0000, Eric Dumazet wrote:
> > syzbot reported a NULL deref caused by a missing check
> > in hwsim_pmsr_report_nl(), and bisected the issue to cited commit.
> >
>
> Hi Eric,
>
> I think this is for net-next / wireless-next as
> the above mentioned patch does not seem to be in Linus's tree.

Oh right, script error on my side. This was generated from -next tree.

>
> > ---
> >  drivers/net/wireless/virtual/mac80211_hwsim.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/ne=
t/wireless/virtual/mac80211_hwsim.c
> > index f446d8f6e1f6e1df108db00e898fa02970162585..701e14b8e6fe0cae7ee2478=
c8dff0f2327b54a70 100644
> > --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> > +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> > @@ -3761,6 +3761,8 @@ static int hwsim_pmsr_report_nl(struct sk_buff *m=
sg, struct genl_info *info)
> >       int rem;
> >
> >       src =3D nla_data(info->attrs[HWSIM_ATTR_ADDR_TRANSMITTER]);
> > +     if (!src)
> > +             return -EINVAL;
> >       data =3D get_hwsim_data_ref_from_addr(src);
> >       if (!data)
> >               return -EINVAL;
>
> I could well be wrong, but this looks a little odd given that nla_data is=
:
>
> static inline void *nla_data(const struct nlattr *nla)
> {
>         return (char *) nla + NLA_HDRLEN;
> }
>
> Perhaps we want something like this (*compile tested only!*) ?
>
>         if (!info->attrs[HWSIM_ATTR_ADDR_TRANSMITTER])
>                 return -EINVAL;
>         src =3D nla_data(info->attrs[HWSIM_ATTR_ADDR_TRANSMITTER]);

Oh right, thanks for reviewing this :)

I will send a V2 soon.
