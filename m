Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8354776DAF3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 00:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjHBWso (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 18:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjHBWsm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 18:48:42 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991031706
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 15:48:41 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56cc461f34fso190935eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Aug 2023 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691016521; x=1691621321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WIjizju2dZJ80Pa0W/XCfHZ95+sdLcByQyOZRHtAyqw=;
        b=ctvj3XF6xtqRy3qudrahIkInlA8+UZAv0B+XOi3USHfYhQJkN+EeVuaG/5vdgQA7Tk
         Vb0O1jn2xz0h8K5LAG8nZdo/dzoudKHOMtjaNnqFoHZ5LRlqUL4Jb0iFAul/yNyp1LDo
         V95c2kH1K4glbS5aTqOJW2F5LDIfX2c5CQk1P2DEzSVS7RVQUxNxLtz75umG2chVHkzH
         H0L6cEzZ575s7pSaXveidQTXbzp5Y91KrzdfyPn19qDWM2nT9KupCzq1p9mML5ZeQSZo
         J61q5KNvf1eux55GUsXoLdhWBXSadAyS+uecRgfEJTmSn9rUBQ8QdCfH7d3cjKiH4ixC
         vYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691016521; x=1691621321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIjizju2dZJ80Pa0W/XCfHZ95+sdLcByQyOZRHtAyqw=;
        b=Ye5mmwhlSWnO8W/K3F2aoUwvkgD6HptR68A609XIY8l7A+WtT3oVh6B3BBPwlnGU9m
         X2GmN+PjWj4K3xxS+A9uhrUVsENMZ9RyI9k4CVdFGrYuhtoPirtz47dDp1swPUZ7JGPg
         d5nY4OvoH4aEGOZyvqDdyekNAKT1nyK9lJhT304Fg29uyY6pi1Q+h59aaT7hIZbaxChO
         zV+kW5uVGDFOx0ugjSIyUqTf3a2YEsg3yhp0O/vS+3P3IOnMLrkmqkvqxM41bXhWtbDK
         LndeVkJhrF3EQpIi0YqVkbj3T+IHjWaVdB/ztngnDhdRkCDPXPFLz2NKyuCONOSYu6Yc
         8TpA==
X-Gm-Message-State: ABy/qLb/epS8wtd3eNwVww2NIqw6XDttyXHYh9OwTVp38aiY2UCVYevN
        3oobKVLl3z8oyLF66GVAO7W2iWZ/rrI/3oHn2Jc=
X-Google-Smtp-Source: APBJJlGLYEk4ZvbMQ5OJKb9aMHP5nOyMcYUxQ9pM1Tc1hiujtUPOzA0l0nHwGZDf35S1mXla/XsgZ2ZuIX0QOLlGPdc=
X-Received: by 2002:a4a:3015:0:b0:56c:812a:924c with SMTP id
 q21-20020a4a3015000000b0056c812a924cmr11343911oof.1.1691016520902; Wed, 02
 Aug 2023 15:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230608095051.116702-4-dmantipov@yandex.ru> <168664510862.24637.10587241603155144086.kvalo@kernel.org>
 <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru> <87h6rad3fp.fsf@kernel.org>
 <bccf723a-9f57-73a7-37af-badc6c156daa@yandex.ru> <87cz1vbulk.fsf@kernel.org>
 <2e78d1f5-4dc5-9665-e3a1-ee00dcc41630@yandex.ru> <fe6b1abc-d529-c20f-3fcb-43d891091080@lwfinger.net>
 <87v8dzxg5l.fsf_-_@kernel.org> <92233d7c-9595-9223-39e1-6df68b13d474@lwfinger.net>
 <2131579919.392146.1690979184620@mail.yahoo.com> <87msz9v79k.fsf@kernel.org>
In-Reply-To: <87msz9v79k.fsf@kernel.org>
From:   Hin-Tak Leung <hintak.leung@gmail.com>
Date:   Wed, 2 Aug 2023 23:48:29 +0100
Message-ID: <CAJMB+NgDZTXau5-C3GTfMDTEtoOJuuR6skpnr-p2rzpoWR3tqA@mail.gmail.com>
Subject: Re: MAINTAINERS: rtl8187 wireless driver
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Hin-Tak Leung <htl10@users.sourceforge.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2 Aug 2023 at 16:10, Kalle Valo <kvalo@kernel.org> wrote:
>
> Hin-Tak Leung <htl10@users.sourceforge.net> writes:
>
> > On Tuesday, 1 August 2023 at 18:05:08 BST, Larry Finger <larry.finger@lwfinger.net> wrote:
> >
> > <snipped>
> >
> >> > In the git history the last activity from Herton is from 2010 so I think
> >> > we should remove him.
> >>.>
> >> > Is Hin-Tak still active? The last activity is from 2020.
> >> >
> >> > Also the git tree is outdated so that should be removed.
> >
> >> Kalle,
> >
> >> I removed Herton and Hin-Tak as Maintainers for rtl8187 > and updated the tree
> >> entries for rtl8187 and rtl8180. Patches are submitted.
> >
> > I think I tried to Ack some recent changes a few months ago, but it
> > didn't go through - my email server insists on sending html-enabled
> > messages, which gets dropped by the kernel mailing lists. I did have
> > to jump through some hoops to use git-send-email instead for important
> > things.
>
> Yeah, your reply was in HTML so our lists dropped it. I'm sorry to say
> but if you are not able to send mails as text/plain you cannot continue
> as a maintainer, we require that the mails are visible in the list.
>

I should have done this ages ago - can I switch e-mail address, and
possibly keep the old one? I also have a g-mail address which I use
less often. So I would like to keep getting e-mails on the sourceforge
one, but only respond from the gmail one when needed. Is that more
acceptable?

Hin-Tak
