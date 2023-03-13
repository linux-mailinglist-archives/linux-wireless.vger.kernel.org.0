Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06F36B709F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 08:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCMH6F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 03:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCMH4x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:53 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17B212AC
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 00:55:16 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id a3so10225134vsi.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678694100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV/twyf5nyEa1UyOr6UbiWV75q4LBzLujCKuebdhOaY=;
        b=AA8XHAPJLZuSUM7DTvEk6Sha1NSesGp/pHqCPPSuurgOX111Xf3BO+hWZRMeZRYvua
         TrmoNlf7UtdxWb0dmWfJiujwVtpGjEFyUGk3cLk8kioB7ojfnSo82Z2HuP/Z+MsMcpcI
         LHTEhyRg9YAsASswj2JGWZ5XBf4bV35jthvvgmD2SsrW8ikTUbDIgn7qFr/ekbzsMIZN
         8snxpmqgGoUjHJIee+gSaXnnCB2PBZUMFxK7UU1S5dQ2QxjdUj4TPMiKTgC9AtP/T78R
         Qaj4HF+uhMvXxqHRKdOCHa5HBWverWxOId3nRbI8Q2hdxBq7DS3OEJ1EPmqUEw7UkLjZ
         Sytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QV/twyf5nyEa1UyOr6UbiWV75q4LBzLujCKuebdhOaY=;
        b=IaO6yGAjNzt2sej7rFpeRY0MJUR9akOClTIuaq6IWsgc8y4MWQN/PkSMdF/5Rctw3g
         4pCToLkf2hLOYchQKKbO11/S//MyNzKiYLsRo1zRKD324zpH6sr8laSZH1kLGjHdLBKJ
         zaM9xqJglU5uDpqJeVmsIb3CJOcMgfHJf5B4zCTXEovoDiDvGeJ31s5DlW/rc0Vj9c7t
         6I4xVPBWi/ENOvunNgbhXbgPuK9RRQyE6e7E6fJC8WxAZbQdAtS4R1NkhzdcEP0Am9qD
         RhQ3jS6UGVTggVAtdlujgrxLjlQDP3cfX5nYFO/4S4Wu+dZXX1/u14Oqq+cMKwZqM9id
         +kSA==
X-Gm-Message-State: AO0yUKUz7JPUfoAnsZj4yuKzBnWAAVo5SQ/BTcPl18dbGx+H5l2A9w/W
        ojPRKwM5b0QvlnhDjqqSo0EhOSm7aSv0WkBC0HiImg==
X-Google-Smtp-Source: AK7set+GE6yHpaDC9Qbffc7bu56Gi+F2PLFvzGCj1j278ZTk2zEr3U8QEXBjfCYaOQ5tN0HoaLFZs1aQyfMWUhUS7Hc=
X-Received: by 2002:a67:ec4f:0:b0:411:c9c5:59ae with SMTP id
 z15-20020a67ec4f000000b00411c9c559aemr21423835vso.5.1678694100399; Mon, 13
 Mar 2023 00:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230302160310.923349-1-jaewan@google.com> <20230302160310.923349-2-jaewan@google.com>
 <ZAYa4oteaDVPGOLp@corigine.com> <CABZjns6=CM7qYPEDnhP=ZpJqMaA=yWw6vSMPOTRnk87PsYY4yg@mail.gmail.com>
 <51c2b615d848c227edae52cc07df334695c7f856.camel@sipsolutions.net>
In-Reply-To: <51c2b615d848c227edae52cc07df334695c7f856.camel@sipsolutions.net>
From:   Jaewan Kim <jaewan@google.com>
Date:   Mon, 13 Mar 2023 16:54:48 +0900
Message-ID: <CABZjns4feHMHtoR5+AYBRpP-Jo=BMaG4Wa2UF2ouWoKFQeuuBg@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] mac80211_hwsim: add PMSR capability support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Simon Horman <simon.horman@corigine.com>,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@android.com, adelva@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 8, 2023 at 5:07=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Wed, 2023-03-08 at 08:00 +0000, Jaewan Kim wrote:
> > >
> > > > +static int parse_pmsr_capa(const struct nlattr *pmsr_capa, struct =
cfg80211_pmsr_capabilities *out,
> > > > +                        struct genl_info *info)
> > > > +{
> > > > +     struct nlattr *tb[NL80211_PMSR_ATTR_MAX + 1];
> > > > +     struct nlattr *nla;
> > > > +     int size;
> > >  +      int ret =3D nla_parse_nested(tb, NL80211_PMSR_ATTR_MAX, pmsr_=
capa,
> > > > +                                hwsim_pmsr_capa_policy, NULL);
> > > > +
> > > > +     if (ret) {
> > > > +             NL_SET_ERR_MSG_ATTR(info->extack, pmsr_capa, "malform=
ed PMSR capability");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     if (tb[NL80211_PMSR_ATTR_MAX_PEERS])
> > > > +             out->max_peers =3D nla_get_u32(tb[NL80211_PMSR_ATTR_M=
AX_PEERS]);
> > > > +     out->report_ap_tsf =3D !!tb[NL80211_PMSR_ATTR_REPORT_AP_TSF];
> > > > +     out->randomize_mac_addr =3D !!tb[NL80211_PMSR_ATTR_RANDOMIZE_=
MAC_ADDR];
> > > > +
> > > > +     if (!tb[NL80211_PMSR_ATTR_TYPE_CAPA]) {
> > > > +             NL_SET_ERR_MSG_ATTR(info->extack, tb[NL80211_PMSR_ATT=
R_TYPE_CAPA],
> > > > +                                 "malformed PMSR type");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     nla_for_each_nested(nla, tb[NL80211_PMSR_ATTR_TYPE_CAPA], siz=
e) {
> > > > +             switch (nla_type(nla)) {
> > > > +             case NL80211_PMSR_TYPE_FTM:
> > > > +                     parse_ftm_capa(nla, out, info);
> > > > +                     break;
> > > > +             default:
> > > > +                     WARN_ON(1);
> > >
> > > WARN_ON doesn't seem right here. I suspect that the following is more=
 fitting.
> > >
> > >                 NL_SET_ERR_MSG_ATTR(...);
> > >                 return -EINVAL;
> > >
> >
> > Not using NL_SET_ERR_MSG_ATTR(...) is intended to follow the pattern
> > of net/wireless/pmsr.c,
> > where unknown type isn't considered as an error.
>
> NL80211_PMSR_ATTR_TYPE_CAPA is normally NLA_REJECT (not sent by
> userspace), you just use it here for the hwsim capabilities which makes
> sense, but it feels better to just reject unknown types.
>
> If you're thinking of actually using it we still have in pmsr.c this
> code:
>
>         nla_for_each_nested(treq, req[NL80211_PMSR_REQ_ATTR_DATA], rem) {
>                 switch (nla_type(treq)) {
>                 case NL80211_PMSR_TYPE_FTM:
>                         err =3D pmsr_parse_ftm(rdev, treq, out, info);
>                         break;
>                 default:
>                         NL_SET_ERR_MSG_ATTR(info->extack, treq,
>                                             "unsupported measurement type=
");
>                         err =3D -EINVAL;
>                 }
>
>
> johannes

Done, and uploaded the next patchset for this. Thank you for the review.

--=20
Jaewan Kim (=EA=B9=80=EC=9E=AC=EC=99=84) | Software Engineer in Google Kore=
a |
jaewan@google.com | +82-10-2781-5078
