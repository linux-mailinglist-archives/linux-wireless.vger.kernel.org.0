Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29E050D9BB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Apr 2022 08:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiDYGuA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Apr 2022 02:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiDYGt6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Apr 2022 02:49:58 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E366F8A;
        Sun, 24 Apr 2022 23:46:54 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p62so14892900iod.0;
        Sun, 24 Apr 2022 23:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+hmsH5keO46hs2cNa85ZpA/Y+Y0MOYjGvgOWRr8GDzM=;
        b=mHBVuX4SgON7Y2qWzJ5+Sgcw/+FSVsjzx6ReiK57wFvjJExQeaKalrDZaB5fhZbteE
         N9DecHKpXvzsFcWFPDi7Tl4kEgchgwpZZwzYoJx9Rmz1nYJ1UEv1aqPIlTsZpdEqnw2O
         Gp3JbWxxdFfF+Hj2JfHoiQGzMEEBN9M73x17wgnD1WYxwKaxSmJMu0MbkUSOyGrPe+yi
         up0p2GEP8m6fnvxNPcy50Vk9kax6EvgR3VakmHTpMQUK/BVBV6UBg3+yK9mgvno9VXVf
         nDeTdF50NH7SGgJ8JxZ1DOaHjf+tvY/mW1UwiyQOjVB+Bhj0XG+cTt1R44IUFw4lXION
         7UEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hmsH5keO46hs2cNa85ZpA/Y+Y0MOYjGvgOWRr8GDzM=;
        b=ABWU7da6iZKelfb8vXuV6wjEJLV+hCXLqKgepvHJTthviXCpEKWVJoRAQOy+vKF52X
         FRIkAHLKCZiLnlGzWM5hii/a2Uv1zDHb/fAUBLCMkt+BqCpeCBcV/DT/4/x7KQJkhxzP
         UgvOkaoBJ0CySyPACwJeq0+hC6I6NX4yUMToBGB3vTuOkwgz2yADinJvjPdRKmuMDtS8
         wzwhR1TDyeUXc+79caLx3QIXH17gyQGFeZ/Zw3czquKzSIN7S3L1N56OQyzz7TRwVeQo
         HRKmZ2HUxo50yFZ0qV5MZ3uUkmcmJJgr2eM3PcgWHbGmBRQHqdKKxmJOzogijN0yY2TT
         rhZA==
X-Gm-Message-State: AOAM531Bwgcma5HePLmTL//z7XWTj9b0L/0bOTBYMZGZTA4XJSlCufic
        100JRm3L1EpV7zqPzEiKFSX/piZDugByTROLa58gOaVe
X-Google-Smtp-Source: ABdhPJwCEsJtaGmusq/EvWmxZw3eqhF28LcMm2e7o3DzZTDJOCc/mrHPeqQvIk5Dz0RNnz5mRml3cg3zJz8qK+3lmaU=
X-Received: by 2002:a05:6638:258e:b0:32a:7db9:e769 with SMTP id
 s14-20020a056638258e00b0032a7db9e769mr6603394jat.113.1650869214437; Sun, 24
 Apr 2022 23:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktEim1vGOf5i=H_sqrPvg=dT50790YYwXgYKgAut-a=ng@mail.gmail.com>
 <YmDpTAu9wmlLijDA@atomide.com> <CAGm1_kv+b1h1OuWr4w5jS_mqfQpXF7UexiWFsOSs+MJK546=ew@mail.gmail.com>
 <CAGm1_ksOt-JtOcTBG7wEqaHagx1NTGYXTMTOG40AN2RELqWKwg@mail.gmail.com>
 <YmKaoRfxo4bMzDdR@atomide.com> <87ee1oqq7s.fsf@tynnyri.adurom.net>
In-Reply-To: <87ee1oqq7s.fsf@tynnyri.adurom.net>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Mon, 25 Apr 2022 08:43:26 +0200
Message-ID: <CAGm1_kvjdOdXVd5DTUZZx33dQNxtdc+tiGqnP8mA+Gz73GtXiQ@mail.gmail.com>
Subject: Re: wl18xx: NVS file handling
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
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

Hi Kalle,

On Sat, Apr 23, 2022 at 8:16 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Tony Lindgren <tony@atomide.com> writes:
>
> > * Yegor Yefremov <yegorslists@googlemail.com> [220422 10:40]:
> >> Wouldn't we need this functionality [1] to make the NVS fw file optional? :-(
> >>
> >> [1] https://patchwork.kernel.org/project/linux-dmaengine/patch/20181112160143.4459-1-l.stach@pengutronix.de/
> >
> > Hmm yeah, how about if we use just an empty nvs file for no warnings then?
>
> What's wrong with firmware_request_nowarn()?

The driver uses asynchronous semantics for NVS loading. Hence, I
didn't want to change this.

Regards,
Yegor
