Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D37592365
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Aug 2022 18:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiHNQUw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Aug 2022 12:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbiHNQUZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Aug 2022 12:20:25 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83A316584
        for <linux-wireless@vger.kernel.org>; Sun, 14 Aug 2022 09:01:36 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id b22so1076764uap.0
        for <linux-wireless@vger.kernel.org>; Sun, 14 Aug 2022 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Qocp7Pc45mAEfguMx3AKkwennc/G9y0G5gDdVyfoWC4=;
        b=AOuQvqY7UYtKBF0cCLlRSWl7Qz8h6sB5A9bwI0Utq2+fV5fYs/upjQUiEOhnsgetZU
         ojgS5pttA5DfJRaAZSYHiH+KosaqxiPgjRPysikaPvOo0jIuFHSx201HKRWy9fqNIhyy
         vsEr0UFbkbbnEHZ0DFpp3qjmyAS9O0V97A0r37FweFLaNb5q8n86mV7inyFgNgo9vYhQ
         3iOzPuqL7OlBxLWqpO4pQO0BuTfdO0aBB//K2QwKpzfZPLMew6cVhn0LnK1qy0HW4Scx
         miL4ujR3KJNhLyTsPFId29fj+JEd3LEa1QdU9NUTw+RwTvQlL7mnZYd47/mKR+jRsBLA
         kjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Qocp7Pc45mAEfguMx3AKkwennc/G9y0G5gDdVyfoWC4=;
        b=7IwmEi6kRWyB+2L7go/q8rxrSNuHvGIoX0au+FWgaZieVx81XsYCBaXlp0vguBD6AH
         a/iRTt4AliVi79GY77I7gRLcjuapI7laJ7f0WseeVj1tl20OEerIFEN3XWRq30tE/Kt+
         E3nsrLI6TjG5g1DtMiWwZTrtPVwbv8vDxEeccRa9W4mjQ4dwfVLbEdUnq5Ynp95bUlQW
         dqW5kYT+q4mw8NXahbgwYFtcWP8KsqHpY01/rIeHsfdSrClAjpslh5socR08IX6T0I9E
         xQIzoXCtTxcItEqTyHgsJix+29NeeSYD3KEiD5uLYdl5oB68zofKD1F1drZKh5lsXDI4
         4R+g==
X-Gm-Message-State: ACgBeo2fkSJIJYOp3X97LllYsS+7J6YhAx2d0VvK2zA3kxWrwzJspmgE
        HLkxdrSFCuIJ6KvhKugk2Tl2SCn1mTBc+7ywu5Q=
X-Google-Smtp-Source: AA6agR7ZJCLZENELrllWjpXZpSehZmkdgWebE4omZampl+LH+AqSL6cx2+NDKDt1ojmuHFfeVyMZhoWVIS9pGznHWhE=
X-Received: by 2002:ab0:49a9:0:b0:387:71ed:915c with SMTP id
 e38-20020ab049a9000000b0038771ed915cmr5104235uad.85.1660492895904; Sun, 14
 Aug 2022 09:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220226045047.643695-1-mikezackles@gmail.com>
 <c09a353b-8e52-6d9d-a3c6-743e4e6f444b@mail.uni-paderborn.de>
 <871qtyj6b6.fsf@kernel.org> <CAN+PumF3JfmwVh_7BffLza+v7iD58QsxanCvbCrS1ztSt=XjNw@mail.gmail.com>
 <d9dc0c00d9ea8bb5b9341a7bcd4a75fc369a7d8f.camel@intel.com>
In-Reply-To: <d9dc0c00d9ea8bb5b9341a7bcd4a75fc369a7d8f.camel@intel.com>
From:   Zachary Michaels <mikezackles@gmail.com>
Date:   Sun, 14 Aug 2022 09:01:24 -0700
Message-ID: <CAN+PumF73tYv0tFT3nGdbgpLCFEB3PgobYBgLisTVCw+q_5K6g@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Make missed beacon timeout configurable
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tmvolin@gmail.com" <tmvolin@gmail.com>,
        "dennisba@mail.uni-paderborn.de" <dennisba@mail.uni-paderborn.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Aug 14, 2022 at 6:05 AM Greenman, Gregory
<gregory.greenman@intel.com> wrote:
>
> On Wed, 2022-08-03 at 08:50 -0700, Zachary Michaels wrote:
> > > Why not just increase the default beacon timeout value?
> >
> > I made it a parameter because I was under the vague impression that a
> > larger timeout wouldn't be ideal on a well-behaved network, but this
> > isn't my area of expertise. I just thought this would be the most
> > conservative change since it would support identical default
> > operation.
> >
> > Thanks for taking a look.
>
> I see that this issue https://bugzilla.kernel.org/show_bug.cgi?id=203709
> has a long history from 2019. But, anyway, what value for
> beacon_timeout solves the problem?

It seems that most people have had success with 256, but that number
may be somewhat arbitrary.

> May I ask you to perform two experiments that could help us find
> the root cause for this issue? The first is to run with a default driver and
> to collect a firmware dump (here is a wiki with directions how to do that,
> https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#firmware_debugging)
> and the second is to load the defaut driver with modparam power_scheme=1. This will
> completely disable power save and will let us know if the issue is somehow caused by
> the NIC going to sleep and missing beacons.
>
> Thanks,
> Gregory

Unfortunately I am no longer experiencing this issue, but someone else
on this chain may be able to help. (Someone having problems requested
that I submit the patch.)

There may be some relevant information in the linked bug report if you
care to sift through it. There are reports that turning off power save
did not work, and there are also some firmware dumps.

Best,
-Zach
