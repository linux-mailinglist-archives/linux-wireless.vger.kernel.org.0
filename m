Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A63870564C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 20:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjEPSsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPSsV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 14:48:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F80E4F
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 11:48:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96ab81aa68dso946290466b.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684262898; x=1686854898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGbNO23jwcr0NmWQcmVu9kK8qGnMgJblxN1oi2Wogw0=;
        b=Qrxq7acCJ5kzwfinzhkyu8jZPV36GN6dDcaMJ4fDI0GRLZyKmlmfpKVOhk7ccey+XN
         DzeOywTkWoTqXO+ndqJXTlcGqHwp8sxNdI+1MB42vWFEg8/o0Ug7RT90YCKWyNjnichU
         nnlJ9o2q/pjHZvanpg0iQS/TEP5K/OclZCOZyMDcDypOL1bOEtRvzJAwZHvJPqz3DrVN
         /MLQplWodeXakIci0HIjaDs0QqKWnB83zjY9DAiL+Y++v+JRSMX3sB1maR0n049QLTPk
         HBbEO8q75BI7S28x0jFAiRd5+6lUXuWOusk9XE8O+z0zYcZPgTSbIRkksEmrAs1OGH/3
         7aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684262898; x=1686854898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGbNO23jwcr0NmWQcmVu9kK8qGnMgJblxN1oi2Wogw0=;
        b=ULfYhCfq/xZKVhhoFecw5/2oaYacdBxp/9RhdKpghsGhmPv+3coULAnQUedgl3oBZq
         +rBM5lqoDU+m86nb8LrOLYdk1D3Eha8mndL2qhJB/wcZ1oA7S9b84MV87a9uWWRGQ25h
         rF4mzTYoYOx+qn+ccZhyi0EyI9BCNfz4NXVFAjgS4gmCtk9mxwkEmwx75L0JRuzHsjcT
         J3X2V2/bsZk4jJp5NgsN7ZRowta0RNR3xmLUuUuO9VyFSjbcd8BaVtIe9XJREcuX8SMX
         Ok+8QaVKyMATRlVsyMyUBh0VpIxrtfYU6WryppR4ZFQT6DV3NySHrUSgbzD7j6CJias+
         8FWA==
X-Gm-Message-State: AC+VfDxN5MN7Q4UmYpNdYDkAuWkMFieLQNAvujpIBCBsxxBgB3I/FKpF
        +VtUWTiPF8c/mnvfSERSJy6L+vccQP13NIYNTz0=
X-Google-Smtp-Source: ACHHUZ7jwTzftIMuBLoir9caZa/nQEtLxIdfbAWlu+BF8Rb9JGU5nHjuH/dQQRVlx43gr+0rCOkYNaCYGLxZ9P5p8Ng=
X-Received: by 2002:a17:907:940e:b0:950:e44:47ae with SMTP id
 dk14-20020a170907940e00b009500e4447aemr37296864ejc.40.1684262898272; Tue, 16
 May 2023 11:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <3162376.5fSG56mABF@jernej-laptop> <cee4e4f8-78e9-1bf7-c1a9-8ae5c662c785@lwfinger.net>
 <1855371.CQOukoFCf9@jernej-laptop> <CAFBinCCjzLH7ZZJ9Siw1Lp49qneO+qRJp-g8rGwAYuRwNj2Oyw@mail.gmail.com>
 <CAFBinCAD-7Mi06z-RGVREDQ3bYsDUOyDkBgoNW5mDLuKM8H7sg@mail.gmail.com> <7106ab11-197d-e0d1-f54a-f56d438a022d@lwfinger.net>
In-Reply-To: <7106ab11-197d-e0d1-f54a-f56d438a022d@lwfinger.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 16 May 2023 20:48:07 +0200
Message-ID: <CAFBinCDbY5_xs7eNv5M-GyYGGFSwwTUtRSQSi9R9wZFzumiE5Q@mail.gmail.com>
Subject: Re: Driver for rtw8723ds
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

On Tue, May 16, 2023 at 8:31=E2=80=AFPM Larry Finger <Larry.Finger@lwfinger=
.net> wrote:
[...]
> >> I'm out of time for today though so I cannot continue testing.
> > I took time during my lunch break for some more experiments and came
> > up with the attached patch (the vendor driver does something similar
> > and I only noticed that after I observed some rtw_rx_pkt_stat with
> > pkt_len being zero).
> > It survived 30 minutes of uptime, updating my system and several
> > iperf3 runs (in both directions).
> > iperf results:
> > - RX: 48 Mbit/s
> > - TX: 33 Mbit/s
> >
> > And to be clear, those results are with:
> > - the word IO bugfix
> > - the initial two patches from this series
> > - Larry's addition of the second RTL8723DS SDIO ID
> > - the attached patch
>
> Martin,
>
> Please send me a copy of the version of sdio.c that works. It seems likel=
y that
> I got mine all messed up as the OP at GitHub is getting lots of warnings =
from
> net/mac80211/rx.c:803.
Please take the file from [0] - this is how I successfully tested it.


Best regards,
Martin


[0] https://github.com/xdarklight/linux/commits/mangopi-mq-quad-20230516
