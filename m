Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C11507D1
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 12:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfFXKKY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 06:10:24 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36486 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbfFXKIE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 06:08:04 -0400
Received: by mail-vk1-f195.google.com with SMTP id b69so2629650vkb.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2019 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/0WI+KW6a3rqwPqVdvcE+ZOO7dieHbJa/TxHGT3Qf8=;
        b=Zn1H1C8e8tbJiCngX0gjSjOTB3/UUzh0f64AyHb3YuFCfMPubAfJul9OJhIQoVIZb1
         rdCXn6wmqer6o4ry8KoQ3OPY+aQm9M5R2RgqFyruDpa4Ov3J7s3Q9sNg2K7rK5cAT9lh
         zoGCOlUg2LCLrFtlj4QQW6NSfUv56MXEBzp1bPQjjtzyBH94q0rrR84xJuwGMEuHMXhw
         YcCHwOCzt6wlCXjTyard1FURZJxOZ6edl2PFhQ4cljWAmFPJOpBK5qQ6PW6p/A+A175x
         j4YmM+AjdvO/QxEMKHozAeMzznpjqqCsR7xIP+SuduYoWZoylp2wAg0qTBEWTGlal4PY
         mmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/0WI+KW6a3rqwPqVdvcE+ZOO7dieHbJa/TxHGT3Qf8=;
        b=BN6WFJdnN0Alz/9PFurxgDYsYxsF40LOfP5lG4xg9PFKDFR0G1PfUAM88f+Wvbuqqi
         yM+McBUuApDJHlIBzAcS2tmu+354CApg1XXYREHgtT58UCUyt8gb7UL5PsLlcUxAJcG5
         qcFoc/ykFjYS2y9AvfQ7tMm43NBvSs0ZH7G13Bo7k7/u9AIlKjY2PCHJLlLFgkbZJCuG
         7+Cp9f60Xh6nzqXwX0sqWI/LIdDRQBWHMsb4OGKpaMFaEKMy3mnhRbbfqXTn93xXwsAB
         zWVT9Y3QSSPw2Z/DlvlBAQ7lI9wVAiLtHdYqGhVayWTlJlbdsCd7wPlxQBHTYW1/tAz1
         Ek1A==
X-Gm-Message-State: APjAAAVLJidqBSt1VH/Qke1xKL3me5lBWjLMirVsnGuilbEnmcpaGCXE
        z2sao9jDWNLUgfm/2Cbu+x6FfaN1oYvN2AVW8p2dsj0u
X-Google-Smtp-Source: APXvYqwz1W7IOvxX6qt1/wGL11Mxq9VV4uVrpEq1h16Gou8ekHo6WIRFWzqWYA4bzMqRVuBHkSBM8nModbvjT+P8Dqs=
X-Received: by 2002:a1f:8641:: with SMTP id i62mr13679284vkd.79.1561370882939;
 Mon, 24 Jun 2019 03:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190620130148.1674-1-yegorslists@googlemail.com> <90ccc515bb26b212b537fc1b0287afaa0f86fdf8.camel@sipsolutions.net>
In-Reply-To: <90ccc515bb26b212b537fc1b0287afaa0f86fdf8.camel@sipsolutions.net>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Mon, 24 Jun 2019 12:07:35 +0200
Message-ID: <CAGm1_ksic4xcVdaPAObwwNdaQ19E3ZiK97SkmVmp8kz6H2KpOw@mail.gmail.com>
Subject: Re: [PATCH] Add SPDX identifiers
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 24, 2019 at 11:45 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2019-06-20 at 15:01 +0200, yegorslists@googlemail.com wrote:
> > From: Yegor Yefremov <yegorslists@googlemail.com>
> >
> > Software Package Data Exchange identifiers help to detect source file
> > licenses and hence simplify the FOSS compliance process.
>
> Well that's nice and all, but it's also wrong.
>
> You haven't included any documentation that says what the SPDX
> identifier, and specifically the "ISC" tag means in the context of the
> project, and it's not even the same license text as on spdx.org.

What about such definition?

SPDX short-form identifiers provide information about licenses that
apply to the source file.

As for the exact license I wasn't sure myself. Buildroot identifies it
as ISC [1]. How do you define its license in SPDX terms?

[1] https://git.busybox.net/buildroot/tree/package/iw/iw.mk

Yegor
