Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620056F784A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 23:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjEDVmd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 17:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEDVmb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 17:42:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ECD1435A
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 14:42:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac866d31aeso1718421fa.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 May 2023 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1683236547; x=1685828547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi8TNJQCquLkK0t6PCVOd2CDPGssuvgSFC+27YVDm6M=;
        b=OEqbSAx92CGWzrZox/Jqav4Riwx4JAE4xQC/iAJZBy8dMvMFkD61FSxP4qGVhCXK49
         NZDWYhnE3MjOwWmDR10SSzz/3S2/OAI5hV601BeNtnJ4m4weCUV/ZrL1lVTRGfij0IAA
         eGmAN44bG3hEhgaQeVWzD+owcioQsol8jjSFRDoyv2/K0H0Mdyk8SvRduBq9UXEDP6EO
         BefcvuBajQdVCZFa7vFjt3j8rej6ZvQW2wuv2KIKb5SwVIkyBL3AF3RVQ12eHTltZ4M3
         Owva8wfqlkFUTHqx2NzQFHqHKLyccWUNTvfqiyf9XZY7qlctC8kW3RJYzT3YiN91iqK6
         Z9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683236547; x=1685828547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi8TNJQCquLkK0t6PCVOd2CDPGssuvgSFC+27YVDm6M=;
        b=CJ1lHoKYtUB7d93oq79FSDvB+/cHs5SwmaIxlusSNkzT7+D2/rmQ832+kWOzfzxZ4X
         S7QfapY05kPUBWBjlcI6IhHvM+7EQ3ekpMmj0Rwbn2K9uBKzTExSzLjnyjCszI+waVHU
         UA3c+6uMVpk/z0eWlvyO3GtSvi+BGCMRBpU1FpQ9TpauYNVKFCnqMAMQl5tkfFUYDE/U
         NCK61BAAloCtUXwmzerBhget0PC4jfIJQ4pFIu4WPoUiGJkhs/vbfxLbPf8pYeEgDHtK
         gII7HroBk4Wi7Yhvj+F7jcEtmy2pWhUcCHGReK6pP0BXRfCue2x2eW+F9F8YchYB0pv8
         CSNQ==
X-Gm-Message-State: AC+VfDyOkjrO6+dQT/1rkePvajsYWhnL8Wv1kJQVPM7yTfhBMl8weaKT
        kzaRTTp0rRHMXrVa/OOj98Ag76tDPVPMVefqVahrmLgNtb3KqVlPabg=
X-Google-Smtp-Source: ACHHUZ7txee4hIxs9wS6zSMC+C2vYiP3FDKeX+wI12QejMs9kqBFd2prLlxMEZd6RH7BERCsd2bqj9RUbUrJlyfeGqk=
X-Received: by 2002:a2e:90c5:0:b0:2ac:751c:8512 with SMTP id
 o5-20020a2e90c5000000b002ac751c8512mr1316628ljg.16.1683236547628; Thu, 04 May
 2023 14:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230504024923.1925530-1-gilad.itzkovitch@morsemicro.com> <2362effcd29ca81e5024545a8d050d7f05a2b1d2.camel@sipsolutions.net>
In-Reply-To: <2362effcd29ca81e5024545a8d050d7f05a2b1d2.camel@sipsolutions.net>
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Date:   Fri, 5 May 2023 09:42:16 +1200
Message-ID: <CAG_xHGP1qyC=sHLq1q9juM+Q8Q+0W4XfUGhXNM5ASz-+t6yD5Q@mail.gmail.com>
Subject: Re: [PATCH] cfg80211: S1G rate information and calculations
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 4, 2023 at 6:56=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Thu, 2023-05-04 at 14:49 +1200, Gilad Itzkovitch wrote:
> >
> >   * Information about a receiving or transmitting bitrate
> >   *
> >   * @flags: bitflag of flags from &enum rate_info_flags
> > - * @mcs: mcs index if struct describes an HT/VHT/HE rate
> >   * @legacy: bitrate in 100kbit/s for 802.11abg
> > + * @mcs: mcs index if struct describes an HT/VHT/HE rate
>
> Did you mean to add S1G to this list? Not sure why else you moved it at
> all :) And maybe if yes, add EHT while at it. But I can do that
> separately too, or maybe we should just remove the list and say "if not
> legacy" or something...
>

As you said below, we shifted the kernel-doc to match the new order.
So, yes, the S1G
is missing from that list as you mentioned. Maybe it's better to
change it to non legacy as the list
becomes too long. I can change it (and add EHT) if any other change
will be required as part
of version 2, otherwise, I don=E2=80=99t mind you changing it as part of
committing the change.


Gilad

>
> But I can also just change that when I commit it, if you prefer/don't
> mind.
>
> >   * @nss: number of streams (VHT & HE only)
> >   * @bw: bandwidth (from &enum rate_info_bw)
> >   * @he_gi: HE guard interval (from &enum nl80211_he_gi)
> > @@ -1761,9 +1773,9 @@ enum rate_info_bw {
> >   *   only valid if bw is %RATE_INFO_BW_EHT_RU)
> >   */
> >  struct rate_info {
> > -     u8 flags;
> > -     u8 mcs;
> > +     u16 flags;
> >       u16 legacy;
> > +     u8 mcs;
>
> Oh ... I see, you moved the kernel-doc because of this reordering? No
> need to do that, FWIW, the kernel-doc order doesn't really matter.
>
> But thanks for doing this reordering to keep the struct without holes!
>
> johannes
