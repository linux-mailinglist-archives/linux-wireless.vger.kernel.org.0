Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46B51DD2EF
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 18:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgEUQRz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUQRz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 12:17:55 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F64C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 09:17:55 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id o26so4325667vsr.10
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ji0OpoGJ8VjDjArAd8rvFq/AM62rv6No+vAMV/IpQ54=;
        b=f8iYwCZQgameHd5sQp4y+KJSlzey2PMBeKBY9oFN19K4KO91g9jnfyqbWfAdSM6YMx
         uPQYYwhJCUnXyHg9kffoRSJdOGP1YPJfZmmA91jWbw8nBm5bgUb6N7Es7bjRfw8c44vi
         KtIe0W9TZnBfOtRQ+2B/PX7dn+AlVCRYhtjMVW4A/i+Wmc6BP7nD4G9IZozOY+B6asQ2
         fUsIudDBnwif4fsTCKUjo+SO6revAeQDMgv+n4ku3+4ALqbkQDbCL5qy4/cQSMpYB5yx
         QKxrH9rmmcYRfgyU792BP3mkqopkZ2+tD0mj/gyY1yRyiKJNuKUe0x0XMowdP5c75RAG
         BBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ji0OpoGJ8VjDjArAd8rvFq/AM62rv6No+vAMV/IpQ54=;
        b=iobKkucWTIhrzFWjEhHBW4kZfR/B0MaKGXOxs9s6h5cQzTdKbLVQHQ61exFRLE0u+9
         MaiswndSq4N5dAzPQs5Mlrr020XZINVDkedJSaGWllXPcq5hbaC3twgVefH0F+GGgNTJ
         gPlUIY+SMPi/8ZDv8+1AyN9ImEhAG+Zbb0X7PQ5kKQXqMvVVFaA1VywAnEhcy3pOgSz2
         zqT/BEmTeC7XN4DvKod7YUHUsnkknD3Gl5HH96BCB9ONEA5mbzrYijjBSFy7ROVlUq1a
         xhf3zSipy8MIUoKsozkgANMwdbPdFN+uRzg57wc5v85TLD2gIyXYqBw4hrSYGA0Zk38X
         Serg==
X-Gm-Message-State: AOAM532q9iHCG9xSW8uxgkUzZazb3M9zQ4BBRpciaDoSuDBzD84k6mfC
        tY2eRlKKx2mqavmNAv7emnotveL+Mxm121tATA==
X-Google-Smtp-Source: ABdhPJxgLaIPBr9Nn2R3gn18Ddkt5IhjKdKYh+uuBM2LzjTDta2rVDGpWTJj9RoObI3S0SRqyx32dURzsuS2nFTnQZQ=
X-Received: by 2002:a67:f64a:: with SMTP id u10mr7885413vso.202.1590077874373;
 Thu, 21 May 2020 09:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net> <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net> <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net> <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net> <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum> <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum> <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
In-Reply-To: <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 21 May 2020 17:17:43 +0100
Message-ID: <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, guys,

On Thu, 21 May 2020 at 15:52, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> It's not exactly a modern Wi-Fi card either, and being 802.11g might
> actually help limiting the CPU overhead.

Yeah, as I expected, it's neither great nor terrible. I fired up iperf
to do some quick and dirty testing: with WPA2 (hardware crypto) I get
around 13 % CPU, with WPA3 (software crypto), around 34 %. The
throughput is pretty much the same.

Cheers,
Rui
