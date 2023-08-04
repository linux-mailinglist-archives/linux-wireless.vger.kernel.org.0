Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161F76FF2D
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 13:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjHDLEO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHDLEM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 07:04:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150489B
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 04:04:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686f8614ce5so1843828b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 04 Aug 2023 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691147050; x=1691751850;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIUxYtufbcwUHtDQd0gMASnXyoHtRYUVaoyQboEuXJM=;
        b=ACEzEbCFV1rXTKzx05LxOkBf70Q7zXIpfCgLN2krNbIV9bgi3VY998D2GiDhqf/Y6V
         yrX13DsnWUX6jQqsZPUlfQc11z1JKuiabx/zvlyz74FR+HyQMofxs3tvp7UP1RL+4WSv
         iAVrdR/o88jBZ1JBoolgvw9MBp5LRrjW3fBzENQhJeI4QA+/Jog8d75Fft1sc3TvWHvO
         I0dEvBjunR1kJ3kZzSi+a2o7TxJ005adZIE3SD7zILWz3fWCh0yW0C31T1X/kqyk7a3k
         lGMV5IKf7k+y0nHWi45Ct5w1NkUEXhBkk+VAYigqbz/HI+nW2jWc7WOUYzZs7OSMuWUW
         6ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691147050; x=1691751850;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIUxYtufbcwUHtDQd0gMASnXyoHtRYUVaoyQboEuXJM=;
        b=IuMy/YZFp6qTBWCHulXapHWomASAJvX5IcrRZycF2fOqJPFOHg/zOSe5Zju7/sB4Cl
         iEM/PL6/FWUMoiJYATQ+Flh8HJNRsTVCZxCPF7hxb9c4KDUY8HsnQRRcbsys1TwmZiT3
         d3PKcjWAH3SLOnqZP5V1zJD1uQvzaYDpWewLY9vn7Efsb140mDxd/Bgt6XRVJPaEpsov
         51SxCzPmBKxZsOWKsZdUoIgJ8PeJVbC3fVgdej2OkkLV6FhzLG7hwjrfCcSI+yul4euS
         XL0w/CDG7cQ83yOngOyKbDkiL5GPB5Kj7NC5sQe0N/hDR4ZiJpKgmVoKjj+ZYubG15j9
         PpxA==
X-Gm-Message-State: AOJu0YxhQ78U0oeS+TRsR0dJ3d+HlGO3MrW4sb9H5/t4cIa7bZB8oW0K
        bxFBeYokuxeGCcxrlxpizq9dVLUKusABR8K5M2vcmN38
X-Google-Smtp-Source: AGHT+IFmkGPoYbXUJJ53W0gyNLUf0CBliGd0ElJU0RLnn8lG6lr3dPkpMf1G3LBYqNJIHJYyHizJcWpI9dbbKxGYYs8=
X-Received: by 2002:a17:90b:e0e:b0:269:1e3f:a54d with SMTP id
 ge14-20020a17090b0e0e00b002691e3fa54dmr1335436pjb.10.1691147050388; Fri, 04
 Aug 2023 04:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAA93jw6NJ2cmLmMauz0xAgC2MGbBq6n0ZiZzAdkK0u4b+O2yXg@mail.gmail.com>
In-Reply-To: <CAA93jw6NJ2cmLmMauz0xAgC2MGbBq6n0ZiZzAdkK0u4b+O2yXg@mail.gmail.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Fri, 4 Aug 2023 04:03:58 -0700
Message-ID: <CAA93jw6d_uq_MNa16F6hna0evo1jq-BLFvZQq9WJSfxy52_BGA@mail.gmail.com>
Subject: Re: a nuking the mac80211 changing codel parameters patch
To:     Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I cannot help but wonder what the results have been on people applying
this patch over the past 6 months?

On Tue, Dec 20, 2022 at 12:24=E2=80=AFPM Dave Taht <dave.taht@gmail.com> wr=
ote:
>
> This is the single, most buggy, piece of code in "my" portion of wifi
> today. It is so wrong, yet thus far I cannot get it out of linux or
> find an acceptable substitute. It makes it hard to sleep at night
> knowing this code has been so wrong... and now in millions , maybe
> even 10s of millions, of devices by now.... Since I've been ranting
> about the wrongness of this for years, I keep hoping that we can
> excise it, especially for wifi6 devices and even more especially on
> 6ghz spectrum... but just about everything, somehow, would benefit
> hugely if we could somehow do more of the right thing here.
>
> I'd tried, last time I got this bee in my bonnet, tried to nuke this call=
 here:
>
> https://forum.openwrt.org/t/reducing-multiplexing-latencies-still-further=
-in-wifi/133605/
>
> As it is, I really encourage folk, especially with mt79 and to some
> extent mt76 ac or ath10k, to try out the attached patch, measure tcp
> rtts, and throughput, etc. A slightly less aggressive patch might suit
> wifi-n....
>
> Maybe there's a reason for keeping this code in linux wifi that I do
> not understand. But here are my pithy comments as to why this part of
> mac80211 is so wrong...
>
>  static void sta_update_codel_params(struct sta_info *sta, u32 thr)
>  {
> -       if (thr && thr < STA_SLOW_THRESHOLD * sta->local->num_sta) {
>
> 1) sta->local->num_sta is the number of associated, rather than
> active, stations. "Active" stations in the last 50ms or so, might have
> been a better thing to use, but as most people have far more than that
> associated, we end up with really lousy codel parameters, all the
> time. Mistake numero uno!
>
> 2) The STA_SLOW_THRESHOLD was completely arbitrary in 2016.
>
> -               sta->cparams.target =3D MS2TIME(50);
>
> This, by itself, was probably not too bad. 30ms might have been
> better, at the time, when we were battling powersave etc, but 20ms was
> enough,
> really, to cover most scenarios, even where we had low rate 2Ghz
> multicast to cope with. Even then, codel has a hard time finding any
> sane drop
> rate at all, with a target this high.
>
> -               sta->cparams.interval =3D MS2TIME(300);
>
> But this was horrible, a total mistake, that is leading to codel being
> completely ineffective in almost any scenario on clients or APS.
> 100ms, even 80ms, here, would be vastly better than this insanity. I'm
> seeing 5+seconds of delay accumulated in a bunch of otherwise happily
> fq-ing APs....
>
> 100ms of  observed jitter during a flow is enough. Certainly (in 2016)
> there were interactions with powersave that I did not understand, and
> still don't, but
> if you are transmitting in the first place, powersave shouldn't be a
> problemmmm.....
>
> -               sta->cparams.ecn =3D false;
>
> At the time we were pretty nervous about ecn, I'm kind of sanguine
> about it now, and reliably indicating ecn seems better than turning it
> off for
> any reason.
>
> -       } else {
> -               sta->cparams.target =3D MS2TIME(20);
> -               sta->cparams.interval =3D MS2TIME(100);
> -               sta->cparams.ecn =3D true;
> -       }
>
> And if we aint gonna fiddle with these, we don't need these either.
>
> In production, on p2p wireless, I've had 8ms and 80ms for target and
> interval for years now, and it works great. It is obviously too low,
> for those that
> prize bandwidth over latency (I personally would prefer TXOPs shrink
> intelligently as well as bandwidth, as you add stations, some of which
> happens naturally by fq-codels scheduling mechanisms, others don't, I
> even run with 2ms txops by default on everything myself)
>
> +       return;
>
> Ideally we could kill this entire call off entirely.
>
>  }
>
> A pre-thx for anyone actually trying the attached patch and reporting
> back on any results.
>
> https://forum.openwrt.org/t/reducing-multiplexing-latencies-still-further=
-in-wifi/133605/
>
>
> --
> This song goes out to all the folk that thought Stadia would work:
> https://www.linkedin.com/posts/dtaht_the-mushroom-song-activity-698136666=
5607352320-FXtz
> Dave T=C3=A4ht CEO, TekLibre, LLC



--=20
Podcast: https://www.youtube.com/watch?v=3DbxmoBr4cBKg
Dave T=C3=A4ht CSO, LibreQos
