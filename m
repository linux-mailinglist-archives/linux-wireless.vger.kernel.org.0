Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF350B771
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Apr 2022 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447593AbiDVMhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Apr 2022 08:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447605AbiDVMhh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Apr 2022 08:37:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC357150;
        Fri, 22 Apr 2022 05:34:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 21so10264812edv.1;
        Fri, 22 Apr 2022 05:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwDd9SH4uurKR/4auDMoTaz+abvGmRh0RwNfa8C9Iik=;
        b=PUA5RFKH1ODbUMEnAMK+7DwA4p7jfxF6HxTRzxXS/Dn/tFTjAIrYTjjK53uozqfJrQ
         PLLM3qdA8rM8wsBTUsSLfVGVd9Dy3pBG4QeLx6zFjfEbeLqKJg8mE2Qrjd/5kbSbUz7K
         j887wFHUWdsKwgqwFIlRG/wxhRf2Uair50OWR3DB9G/ZI+Std6goNa9jdV5g+2aK2jp0
         lv+56BODDS+b2zehQ6uZoKPddpbmMcS9dWaQunjo8G/Fh4Pt78jMypyld59FyQJTrGtk
         pl1qdJukwJMIsi6oVIYc8d8fpelWxjb5NvhmQk1+IpPPLD4sp9GGHFRmjGj/m3jp7bZp
         cAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwDd9SH4uurKR/4auDMoTaz+abvGmRh0RwNfa8C9Iik=;
        b=5+j9iLC37ktMG7z3Ga4s/yq1zglbj9SRY/k0wro4zDoAaumdxRQlPL35kwiSmZ4jhJ
         PfUCx6IeSwb34SSxffRnJZ/yS+ljStl2TpFKL3mS8gBS8Bik43cUwEitO9HCVb482F7j
         E3IVPuK830jG4ArTRyb/0jStfsi8tKvBfeYDHqxWEuqf0auvN2eXBUym85PEnqufvADh
         Xo0WtQWPjWaHp9qrRoafTXV/vtu0miGo3ClRYdnr9KsA6jRtHkHiyr3Rdf59vyJQhkAk
         f8q9q8qPPlHOiDGS47ENT8T21qNU6NMMiRddcZbvRhyrLM7oAAYRu6kmadx3iUvCtjcU
         O2JA==
X-Gm-Message-State: AOAM532ETh2E4ROrHJBZRW68aTUykrXAqQ4UhNFnPJ4zATjpLqF0baJv
        Kjsqj8XrIXDfWsLyH8lFlUrc+bngByd2hsSfzOLrj8kvIxg=
X-Google-Smtp-Source: ABdhPJw5WzcjpWe2TEAKBECSXlrkAtdKzNR0uwHOmK1xFeOUbt25AhP0UsvWzw2l6puBz0VR165VmLUXM7vN0Pl0rAI=
X-Received: by 2002:a05:6402:1d55:b0:423:e3a9:d455 with SMTP id
 dz21-20020a0564021d5500b00423e3a9d455mr4529126edb.340.1650630882015; Fri, 22
 Apr 2022 05:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktEim1vGOf5i=H_sqrPvg=dT50790YYwXgYKgAut-a=ng@mail.gmail.com>
 <YmDpTAu9wmlLijDA@atomide.com> <CAGm1_kv+b1h1OuWr4w5jS_mqfQpXF7UexiWFsOSs+MJK546=ew@mail.gmail.com>
 <CAGm1_ksOt-JtOcTBG7wEqaHagx1NTGYXTMTOG40AN2RELqWKwg@mail.gmail.com> <YmKaoRfxo4bMzDdR@atomide.com>
In-Reply-To: <YmKaoRfxo4bMzDdR@atomide.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Fri, 22 Apr 2022 14:34:31 +0200
Message-ID: <CAGm1_ktc0OsYEt-D=OUhEJz6VFgW15wBWkxb6fS5CWTgzZ6YHg@mail.gmail.com>
Subject: Re: wl18xx: NVS file handling
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-wireless@vger.kernel.org, sebastian.reichel@collabora.co.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 22, 2022 at 2:08 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Yegor Yefremov <yegorslists@googlemail.com> [220422 10:40]:
> > Wouldn't we need this functionality [1] to make the NVS fw file optional? :-(
> >
> > [1] https://patchwork.kernel.org/project/linux-dmaengine/patch/20181112160143.4459-1-l.stach@pengutronix.de/
>
> Hmm yeah, how about if we use just an empty nvs file for no warnings then?

touch /lib/firmware/ti-connectivity/wl1271-nvs.bin

wl18xx_driver wl18xx.0.auto: loading
/lib/firmware/ti-connectivity/wl1271-nvs.bin failed with error -22
wl18xx_driver wl18xx.0.auto: Direct firmware load for
ti-connectivity/wl1271-nvs.bin failed with error -22

Regards,
Yegor
