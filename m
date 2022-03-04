Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244FE4CDF7A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 22:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiCDVCH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 16:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiCDVCG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 16:02:06 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41DF6586
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 13:01:17 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id o7-20020a056820040700b003205d5eae6eso10288910oou.5
        for <linux-wireless@vger.kernel.org>; Fri, 04 Mar 2022 13:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUXX7IWto3u/1R7Tb5iNdIbM2+de9iHuZnlflZ/eQTk=;
        b=KJuDznvkwBKdf0etWcgmy7amQKVF7rCMFWFCeXGuT3enR92BziHGa1fGvZf+cLbDRU
         tfusQVqwy/E2PDP1CjvfDeijrQ2fxXlOyL4tfW3BvR532/H8lWthIknYHzCOTHMNPpBo
         nOSZqJYzJx6/gqABJxzIAFfR6OHvJ99EHavx3NAOCFqaF7sP2R6yp3GKzM2zPyPEO08T
         TzaYsroEodhZSqbwAweiFpf2E9TExQBAgT9B3ocGRWZqMvJDmEBdBBFen8qiNE+AhCdM
         8Qe0BRX8CbmYz73FxZy1OCCpGjtAYagRMoVjS0IVMbQLfKBbzPtJE/qykfEmWk0guneE
         0/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUXX7IWto3u/1R7Tb5iNdIbM2+de9iHuZnlflZ/eQTk=;
        b=2vLBlKa0Tk8AqlovUywQZ8WY3/0+63DaJxfpi1ubeYGH+b8CL5qse56kKlib3bBp6S
         hBBehhQHysssf6gxt6bd6WwesFBXGtwCzbmrmW5BxIVWrurqY/dcbA0lQixFh6WSgMuN
         xuh7FUxvxJy/uaGjc2ZEm9LlBpuwNw2WbZYOYXpfMizj7KoB4PMlZOSLjhx7AYQ71Lcs
         3EUJ/1sJ5MASoWoO/OAtyKz0GBpM4d8Cs7Rzf8+sSyeZ78wwPD4U94VqjWGDBf30HbyD
         7FF6iL/i/2gj3HLC6iQN9kotC7HbX59U0lmZ9lqSudD8NILpeS1Iu+KPNXgz8k73JjK4
         YFlA==
X-Gm-Message-State: AOAM531WzEIA3KXyD0qSO+K3FozTnYVwBunNY1hkA6tL4iwFZNyURPaQ
        bFjo6WNYhdVv9wj4PEfGkwy94JWkGrlBTh+PEG8y7VaS
X-Google-Smtp-Source: ABdhPJyNyzH6KRK3g06Al4eRe2QhrFtpht97PF1WKXFz6u2RGWSeZAgIyGK9CjfpSnIBjeKUmtwsj+hP28c67Wtt7sE=
X-Received: by 2002:a05:6870:d250:b0:da:b3f:2b29 with SMTP id
 h16-20020a056870d25000b000da0b3f2b29mr582242oac.200.1646427677304; Fri, 04
 Mar 2022 13:01:17 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_MM8w=U6WqRDbwHrjP4Jpco0bUKEsE5QiTYiYAEK1xtBg@mail.gmail.com>
 <8ed18133-4441-101e-d5a8-40a1e2e70bf4@lwfinger.net>
In-Reply-To: <8ed18133-4441-101e-d5a8-40a1e2e70bf4@lwfinger.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Mar 2022 16:01:06 -0500
Message-ID: <CADnq5_OUDMiyB3+H-Y-TkY16t_mHa+-uN5gv8rNyCT7XNwYZCw@mail.gmail.com>
Subject: Re: Way to enumerate wireless adapters in kernel
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Linux Wireless List <linux-wireless@vger.kernel.org>
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

On Fri, Mar 4, 2022 at 3:48 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 3/4/22 13:59, Alex Deucher wrote:
> > Hi, is there a way to enumerate wireless adapters in the kernel and
> > determine what their channel and frequency is?  I'm looking for a way
> > to determine this from another component in the kernel so as to avoid
> > any potential frequency interface from another device in the kernel.
>
> The command 'iw dev' will list the device name and frequency if the device is
> connected. There is a bit of extraneous output, but it is not difficult to sort
> it outwith something like iw dev | egrep "Interface|channel"

What about within the kernel itself?  E.g., from another kernel driver?

Alex
