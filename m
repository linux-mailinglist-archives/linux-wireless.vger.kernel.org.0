Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230C33F4F75
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 19:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhHWRYd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhHWRYb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 13:24:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BBAC061575
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 10:23:48 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso38238024ott.13
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j39JGa4+/JoPd7jWAo3EsnacOlycl0dd9VYa1paZWZw=;
        b=aML2ZoYwbJUyZY3T5viLxlIzeL7kZupQ2VWoUC/61msAkwKvU+DTV44Fi9VqicYt/M
         8CspSsZi+q9BdRGJhNzzIrZIRL1y4SJAclOnSI21k/2qlYFIAvAGm6x6Gik8hu+dsWa8
         KQ+eLhQzY0EZgW8ARS11Byr73RZLag/vw+Z08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j39JGa4+/JoPd7jWAo3EsnacOlycl0dd9VYa1paZWZw=;
        b=LzD8aGz5AYM5zli44KV89E4I50NXrGP4AhFc6hrbsxz2hV4Dy7ykKOs1WdYUzpkMJ/
         5690KKl2rMqOr9+kUBACsjMIQVrAMncEXUdn3Q6txgD9ovZAGnwvWHk/Fh8XHEMNEpXp
         45vOaM3LCzq0RsZt0V9GPIqTDc3IZW224Cfh/JBi94HBcXMs9O9H+EyMB0W9ZW9dIkq3
         i+SZknUwCBPFajQqXKwaLvIR28UXPt93ZPcg0JrIMb9EXXFYQMQbqsJ2tSAg2UoC9+F0
         5LP1+qeEC724hqmOcIdAiLmGBFdkzkZyZ2aj4csTbuLxAEY+bO2sUntWQdEHpk3FBOdw
         tgAg==
X-Gm-Message-State: AOAM532YwZsF5/IS25BYvQb6xPqXI45FtNzySlvO+1YWUQD1WPieLELj
        tBwOuG43rbD/pps4AwSXag1fY2JBvQ6EGA==
X-Google-Smtp-Source: ABdhPJxw/Zp1nrd+jhsmATCtgUFtnUbQmhd+zd+vEdXkWo7Ag1WKF7u1Tl3wmxPQ3vXJFGY6NIFcTw==
X-Received: by 2002:aca:a80a:: with SMTP id r10mr12559420oie.119.1629739427953;
        Mon, 23 Aug 2021 10:23:47 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id p2sm3801764oip.35.2021.08.23.10.23.47
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 10:23:47 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso23456635ota.8
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 10:23:47 -0700 (PDT)
X-Received: by 2002:a9d:6310:: with SMTP id q16mr28892267otk.203.1629739426626;
 Mon, 23 Aug 2021 10:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <YSJ//ki/A1EgfLga@skv.local>
In-Reply-To: <YSJ//ki/A1EgfLga@skv.local>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 23 Aug 2021 10:23:35 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNzv6D1PthjUU-CVw6amT+JHmJP2mNSL=LVJKGm0zkEXw@mail.gmail.com>
Message-ID: <CA+ASDXNzv6D1PthjUU-CVw6amT+JHmJP2mNSL=LVJKGm0zkEXw@mail.gmail.com>
Subject: Re: Revert: ath: add support for special 0x0 regulatory domain
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        felix+debian@gueux.org, Massimo Maggi <me@massimo-maggi.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Aug 22, 2021 at 9:49 AM Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:
> 4) As many users are affected by this problem and maintainers don't really
> want to revert the problematic patch,

I'm not totally sure that's true. So far, it looks like an oversight.

Over a year ago, Kalle said he "just need[ed] to check something
internally first":
https://lore.kernel.org/linux-wireless/87r1rsbdnx.fsf@codeaurora.org/

I don't see the result of that, except that this is marked Superseded:
https://patchwork.kernel.org/project/linux-wireless/patch/20200730124923.271429-1-alsi@bang-olufsen.dk/
and this is marked Rejected:
https://patchwork.kernel.org/project/linux-wireless/patch/20200527165718.129307-1-briannorris@chromium.org/
I'm not sure if the Rejected was before or after the last reply above...

Maybe it needs an Nth person to submit a revert?

Brian
