Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DCE680719
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 09:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjA3ILT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 03:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjA3ILR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 03:11:17 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A27ED7
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 00:10:52 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k4so11617374vsc.4
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 00:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymIAXtCd2MxqtYWvrJZz0PEkm0tFm2YFN6GsAuKltPg=;
        b=VjBFoQyvxVbZcRjLUrbibXw4+MT8g0UWQSD5G0+jS0OLvVW/KtzPBQ3zu/A9gW63DF
         f/l3VAfgTqNXiiLTav7jolzt/AvRqrG8xKKncUHoUpkN+9/+rg586QUbOmYg2O/hoYVa
         iGDrVeTGq4FqWr/Zfhu+fazosEJH8l5CAD642AYSppVIR3mh7EEedUIRs2Bn5x4yzMYK
         V68lgUNYYVPPGMEIihaSvz7cwNBmtjzuMUaFDRBLdVIbgcknFyCpeNLdOAsL5Ad0Mun4
         Bp89Q+gJkGPhaIqayZ5HBeoJVUg87pDRxwX1F2+xan/kajjdNkzp/HZTfln2s//WsK/T
         VISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymIAXtCd2MxqtYWvrJZz0PEkm0tFm2YFN6GsAuKltPg=;
        b=2ZgGibYrwpbJvlzJda5l04eL4VkCEMzU81dLKnzd4xx+vzicn0wso4SSjJdW6uyLUQ
         ZPaJ3JQuqEEtp+ToGhWj4ACzWfF9whtXevNmQBLJuBthdYwd8U4d/j7KNzB4HCgbhXGz
         YeIk9RdPlVCaVs9jat1+KMWazF1trGHq7r2nzMlsw6gfxp56soV56+3L4EqrGBGPCpvJ
         bm3pRpF+3OHWJcI1LR9zbCrag/TJ//JtSSVIPevUvlxPAV6cH+Pg8fjxLSD0ThJTbYTH
         Nqtq0L/8/CJXJUMM5TgX04O31DzGF7BotSzJr5takg+A09KNDXU51vmaCWBKmpfA82UH
         3leg==
X-Gm-Message-State: AO0yUKXDAMTFqkyFQ1A0RzdPGbdEsnN03/KSFD98TovoxsPv4S+ejXr3
        BsIxW2fVO3EfCBZZ9wnGJUo1Zqf5+OKt5ORjEs/brA==
X-Google-Smtp-Source: AK7set9o1e8iWYYvaoq70mZHQVo6LDmk5L7AnpPp1CiDFpmmDUsbP/J1TrEQHND2L6dETz8Z0PbBef9gd1pXrlqpqi4=
X-Received: by 2002:a67:d998:0:b0:3eb:8780:ced6 with SMTP id
 u24-20020a67d998000000b003eb8780ced6mr2091574vsj.12.1675066145479; Mon, 30
 Jan 2023 00:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20230124145430.365495-1-jaewan@google.com> <20230124145430.365495-2-jaewan@google.com>
 <Y8//ZflAidKNJAVQ@kroah.com> <CABZjns5FRY+_WD_G=sjiBxjSwaydgL-wgTAR-PSeh-42OTieRg@mail.gmail.com>
 <Y9dWztPR3FxkLv26@kroah.com>
In-Reply-To: <Y9dWztPR3FxkLv26@kroah.com>
From:   Jaewan Kim <jaewan@google.com>
Date:   Mon, 30 Jan 2023 17:08:54 +0900
Message-ID: <CABZjns6nER31ZbBKQ_QKU0Hrh5V5U_W6Q4vGsE7kt7S5YYy3mg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mac80211_hwsim: add PMSR capability support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@android.com, adelva@google.com
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

On Mon, Jan 30, 2023 at 2:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 30, 2023 at 12:48:37AM +0900, Jaewan Kim wrote:
> > On Wed, Jan 25, 2023 at 12:55 AM Greg KH <gregkh@linuxfoundation.org> w=
rote:
> > > > +static int parse_ftm_capa(const struct nlattr *ftm_capa,
> > > > +                       struct cfg80211_pmsr_capabilities *out)
> > > > +{
> > > > +     struct nlattr *tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1];
> > > > +     int ret =3D nla_parse_nested(tb, NL80211_PMSR_FTM_CAPA_ATTR_M=
AX,
> > > > +                                ftm_capa, hwsim_ftm_capa_policy, N=
ULL);
> > > > +     if (ret) {
> > > > +             pr_err("mac80211_hwsim: malformed FTM capability");
> > >
> > > dev_err()?
> >
> > Is dev_err() the printing error for device code?
>
> I am sorry, but I can not understand this question, can you rephrase it?

I just wanted to know better about `dev_err()`,
because all existing code in this file uses `pr_err()`,
and there's no good documentation for `dev_err()`.

Given your answer below, it seems like that `pr_err()` isn't a good
choice in this file.
Am I correct?

>
> > If so, would it be better to propose another change for replacing all
> > pr_err() with dev_err() in this file?
>
> Odds are, yes, but that should be independent of your change to add a
> new feature.

Got it. Then I'll break the consistency in this file for my change,
and also propose another change for using `dev_err()` instead of `pr_err()`=
.

>
> thanks,
>
> greg k-h



--=20
Jaewan Kim (=EA=B9=80=EC=9E=AC=EC=99=84) | Software Engineer in Google Kore=
a |
jaewan@google.com | +82-10-2781-5078
