Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315DC7ABD23
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Sep 2023 03:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjIWBkN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 21:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjIWBkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 21:40:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B986F19C
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 18:40:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bffa8578feso51699701fa.2
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 18:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695433203; x=1696038003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpl9/vTvToaSda9SWWb29L6KDCw6ydexp+tSrTygRME=;
        b=VdsCcG0gX//OgwaCYlmHyirYGm4IuVJEwoM2C4NJSk5A9jYwsCWMD3q+PRmwO2BvN0
         KD2RcHTl+oCwGc23y8dn/d3HFysiXLg0bv1dcqkJ5+Hw34eg6zZgwQDUtZJ1FpqhPawE
         MI82pWTQao73gTLB+wEBitSD693DIKdJulOe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695433203; x=1696038003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpl9/vTvToaSda9SWWb29L6KDCw6ydexp+tSrTygRME=;
        b=rYP6HCyK7I3g46OglNxwz1oJmjrWkJCZHKz1Cfa3suKLBQVVqfy2BvVBg1fJUhJUsC
         Tut473v3B8zlHZvDL5OyMFOxvfbwJrPOQVAdQ4iuXiV3rOXcgFzIrAl6mZmr/JcgMr0X
         Gj6UYrVkXAWyePPW29CrhjkgjqQW4XmwSiUdKo9o8IdtAQ5B9Z+854uHKqLUmxvx3ie/
         KcPdx1GWlKBsdNUlCdQv3qlKWrLAl5OAU8dE4K1CPwvN1UvgZZa7FtwxFCeqeeB9XEjE
         d+PHKGxMV08olGG1+1pakg/99mJZrPh0+/ixjw7q5dGIDVSj1vUiDXomC2Ta1vlw1NJC
         NAgQ==
X-Gm-Message-State: AOJu0YyNvdyKmWoNFhNbfGRgj5Gsfj7c01/S0N0eVyJCNzqgytRQ6Pzz
        Pu7XB7H7v6l8ahauIZf5OPiw/qjpctqLpaIMH9U=
X-Google-Smtp-Source: AGHT+IEg452jKm70/K8JfWGQnR639XocgxqsrR78wEh8s17V1VneW6k5+jseNmoFRR7AQGLZkSWTOA==
X-Received: by 2002:a2e:9dc3:0:b0:2bf:f5c9:2dce with SMTP id x3-20020a2e9dc3000000b002bff5c92dcemr684924ljj.30.1695433203280;
        Fri, 22 Sep 2023 18:40:03 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 22-20020a05651c00d600b002b6cd89a3fcsm1127826ljr.118.2023.09.22.18.40.02
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 18:40:02 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b962c226ceso51705461fa.3
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 18:40:02 -0700 (PDT)
X-Received: by 2002:a2e:90d7:0:b0:2bf:f17d:c834 with SMTP id
 o23-20020a2e90d7000000b002bff17dc834mr646754ljg.29.1695433201619; Fri, 22 Sep
 2023 18:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112259.18656-1-dmantipov@yandex.ru> <ZQt89BPMN6Fg3H6z@google.com>
 <cc57fb2f-1eca-f366-bec3-d4cdbb2c39ec@yandex.ru> <87o7hvafo8.fsf@kernel.org>
In-Reply-To: <87o7hvafo8.fsf@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 22 Sep 2023 18:39:46 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNu-CWa9V5Oc-01pLp72iMVRw7m46+bDdNUxVmfrR9PSQ@mail.gmail.com>
Message-ID: <CA+ASDXNu-CWa9V5Oc-01pLp72iMVRw7m46+bDdNUxVmfrR9PSQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: fix SDIO firmware dump wait
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 21, 2023 at 5:12=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Dmitry Antipov <dmantipov@yandex.ru> writes:
>
> > On 9/21/23 02:15, Brian Norris wrote:
> >
> >> Have you tested this patch? You've certainly caught a logic bug, but
> >> that doesn't mean the seemingly obvious solution actually works.
> >
> > Unfortunately by eyes only :-(. IIUC there should be a weird hardware
> > stall to trigger an execution of the branch in subject, so I'm not sure
> > how to actually test it even if I would have an access to the hardware.

If you had the hardware, you could at least test the positive case --
that the "normally operating" case at least succeeds without hitting
the retry/timeout loop failure. What if it's common for this "start
flag" to be stuck non-zero, but we were ignoring it due to the bug
(after a timeout), and things still worked fine? You rarely can trust
that driver authors got their hardware/firmware bits correct as
written, just because the driver logic suggests it should be so...

Or if you're just interested in testing the firmware dump: these
drivers have a debugfs mechanism for triggering firmware dumps on
demand. You don't need to actually crash the WiFi firmware.

> I don't know about Brian but for me testing for regressions is the most
> important part. If the patch is only compile tested it could break the
> whole driver without anyone noticing. And then it's in a release and too
> late.

I might make a similar claim, but context-dependent. Certain kinds of
patches are clear refactorings, and can reasonably be verified with
static analysis. But many patches have a moderate or substantial
runtime impact, and those are very important to test. In any case, it
can even be difficult to judge the difference between the two types,
so it's pretty fair to err on the side of "if it isn't run tested, it
isn't worth merging" if you'd like.

> That's why I have been asking you to add "Compile tested only" to the
> commit log so that it's obvious to everyone that your patches have
> received zero testing but you don't seem to care.

Yeah, that'd be nice. By now, I've pattern-matched the author though,
so my question was more rhetorical ("because I'm sure you haven't
tested the patch, I don't feel inclined to Ack it").

Brian
