Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5655F1B32DD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 00:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDUW4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 18:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUW4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 18:56:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C714C0610D5
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2020 15:56:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g4so270704ljl.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2020 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8rcnxOJsGi9Z4WDx8eJy3VEB5Ate3c2UIAH3lhnIso=;
        b=PNtCHyTn9gTX69dViY1iYFAzCef4GWjDpWoJ8mNgtQW9u1LfRTjrmOG8DbnAMpA8nv
         4doza+uo2/rGCjbXyX/TIQdKV6uxSo8NYm9NAv7RlUPXlQOFjoZ/8lNKb0X1IaAqmmd8
         VH5aPKsDdr3mQCru/XJA3uYK3kA6bTIj4Pg9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8rcnxOJsGi9Z4WDx8eJy3VEB5Ate3c2UIAH3lhnIso=;
        b=jAaEuRwOIXgE7Nnq6/V4zkVLwAMkLBEFZxKdKsUwNu7ynKrHujPh9YvtriKF+hawG5
         tBJmB9zMfP1vVyFjn3k/preMikklqKeFRFo651z2N3QTzpws5XNWO4lUWVok0VLrKXqg
         iHMT4NRDxEaszhW03glEvdOE2bu0gP11BNUU2DDFrSKoN4gsPPdF5fuKF5n5VVMrYiQE
         kK15h1QKPBZ3+yRi24DEdVVZDT48jcoGbFEuUYAZRwJxInG1BIeVK7v+XBbV9K9sWiF3
         ol4VyPZW7Ee1kVDkR/W2YG4ggOkkF2VjrraJpcpxjEef4JXY9BP4+Meu/bdSeExRylj8
         YBKA==
X-Gm-Message-State: AGi0Pua/R48NWRq/cUIc/R63i+Q5SpXPKv0/+bUEsL2TBpxDgUN1jz6C
        aboNMzcxtmktGqhVKJtTX6WizyUPeTc=
X-Google-Smtp-Source: APiQypJYBbH/Yv1Xuo0twIMZXatsesE2NS5KA56D/BtPy8IvtHTJBW7Q1Av01M7l9fxANlIEWHFxMg==
X-Received: by 2002:a05:651c:1209:: with SMTP id i9mr13368697lja.250.1587509790411;
        Tue, 21 Apr 2020 15:56:30 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 14sm3068693lfz.8.2020.04.21.15.56.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 15:56:30 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id k28so51086lfe.10
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2020 15:56:29 -0700 (PDT)
X-Received: by 2002:ac2:4859:: with SMTP id 25mr15426506lfy.59.1587509788761;
 Tue, 21 Apr 2020 15:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200421211552.GA36171@t2b3>
In-Reply-To: <20200421211552.GA36171@t2b3>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 21 Apr 2020 15:56:17 -0700
X-Gmail-Original-Message-ID: <CA+ASDXN==qo2T6g5YCWpUFPXAdFgcKgww5EbmsmUTvsrSSRHug@mail.gmail.com>
Message-ID: <CA+ASDXN==qo2T6g5YCWpUFPXAdFgcKgww5EbmsmUTvsrSSRHug@mail.gmail.com>
Subject: Re: rtw88: BUG: scheduling while atomic: kworker/u16:0/33416/0x00000002
To:     "Tobias S. Predel" <tobias.predel@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tony Chuang <yhchuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm not sure about the first half your problem, but for the
scheduling-while-atomic:

On Tue, Apr 21, 2020 at 2:16 PM Tobias S. Predel
<tobias.predel@gmail.com> wrote:
> [28125.482259] BUG: scheduling while atomic: kworker/u16:0/33416/0x00000002
...
> [28125.482436] Preemption disabled at:
> [28125.482443] [<0000000000000000>] 0x0

^^ This line is a bit weird -- shouldn't this have a real PC?

> [28125.482452] CPU: 5 PID: 33416 Comm: kworker/u16:0 Tainted: G        W         5.7.0-rc2-next-20200421-1-next-git #1
> [28125.482456] Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85 Ver. 01.09.01 10/15/2019
> [28125.482477] Workqueue: phy0 rtw_watch_dog_work [rtw88]
> [28125.482481] Call Trace:
> [28125.482495]  dump_stack+0x66/0x90
> [28125.482505]  __schedule_bug.cold+0x8e/0x9b
> [28125.482512]  __schedule+0x686/0x7b0
> [28125.482520]  ? _raw_spin_unlock_irqrestore+0x20/0x40
> [28125.482525]  schedule+0x46/0xf0
> [28125.482531]  schedule_hrtimeout_range_clock+0xa5/0x120
> [28125.482540]  ? hrtimer_init_sleeper+0xa0/0xa0
> [28125.482546]  usleep_range+0x67/0x90
> [28125.482568]  rtw_fw_send_h2c_command+0xe0/0x1a0 [rtw88]
> [28125.482590]  rtw_fw_set_pwr_mode+0x95/0xb0 [rtw88]
> [28125.482610]  rtw_enter_lps+0xa1/0x100 [rtw88]
> [28125.482625]  rtw_watch_dog_work+0x21c/0x230 [rtw88]
> [28125.482635]  process_one_work+0x1da/0x3d0
> [28125.482643]  worker_thread+0x4a/0x3d0
> [28125.482651]  kthread+0x122/0x160
> [28125.482658]  ? process_one_work+0x3d0/0x3d0
> [28125.482663]  ? kthread_park+0x90/0x90
> [28125.482670]  ret_from_fork+0x1f/0x40

This looks like it might be a regression here:

commit 6343a6d4b2130be9323f347d60af8a7ba8f7242c
Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue Apr 7 15:33:31 2020 +0800

    rtw88: Add delay on polling h2c command status bit

That poll macros is using usleep, which obviously can sleep. We need
to be using a udelay-variant instead.


Brian
