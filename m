Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542A289F06
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Oct 2020 09:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgJJHza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Oct 2020 03:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbgJJHzM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Oct 2020 03:55:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB79C0613D2
        for <linux-wireless@vger.kernel.org>; Sat, 10 Oct 2020 00:55:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id y198so13140474qka.0
        for <linux-wireless@vger.kernel.org>; Sat, 10 Oct 2020 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIbfa8CnKY7IkW3rParF9jXfx9AUSNx+WkfiE3ixDLU=;
        b=K74AqtWTCzeJ3fHFsLhU28oHxZJ+TBfWXN0ajy3/k79H47kIb6MQDZ9nJQCyC7X1FQ
         tr6uLNZQBBPRT+S6uqbkjrpuJdO3XjwIxeDqOGwnGiO7ZtFx3PGlnbSpe/ewrpp7dpmA
         6yM6plNwn4lhupl/UBahvQezEoGzNs3DkYzamN5bJXG5KgZ3aRevOBWopKO2nKx5gcdh
         wrxutUi4qd2RDt9iHtSgJIroiijkuyHseBKYyMkxv2dBGNmX45+SzDmE+11usmet2Y3C
         B9ycpdjwSsWETinivuhVzm/zmT56SoTeMaLwEoQRLw8++vWysmVZQwgYvmFoF0KUJnBc
         IhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIbfa8CnKY7IkW3rParF9jXfx9AUSNx+WkfiE3ixDLU=;
        b=AdAbTOuLLOvjjDEZe/TRr8+Dpehynki09cwc9QjjJnsT3hoUG6PBCnyd+lvHQzisvh
         oe3PdavDdPdx4crVKu9Xj9X9uDtSwuagQ3dzdXHCLPrHDe3cvlQNxZPbu166ESE5KNUa
         wx6AyPgV74VTTjK/YJWCk6ViM1PdxREVOfdUEGqnosTr/a3LctxSzaZzwNAdzVYgTqeM
         45WIQiOvKisN80i2QhS8A5A/S1wIQGKrccK6tkYoGW+DQK9jmPqButx8slpQzE8mrtrU
         acSiZ0ji6RLC2+7nO15U8JHzHCjngHoRrHoc+vFpv9dbZtaNlk/aMNsoQ5OWz8SaKW2P
         UfsA==
X-Gm-Message-State: AOAM532DuYaHXN7mR/hKUzpxwUydDD8mEloXa/qXOGkBLWsPFrs5c2aF
        lbiI/bafA1kniZX6FOBO7OuGY6go1KF5k9jWh2ShuQ==
X-Google-Smtp-Source: ABdhPJyGZIeP/r5j1IxcIHRQMZhGLZo7w7MDc8zflXTalRA5Cb9Of04dAcnojeKE3/QoqUcIaXbsjr/CPBqlOjWL7RA=
X-Received: by 2002:a37:5684:: with SMTP id k126mr1356621qkb.43.1602316509213;
 Sat, 10 Oct 2020 00:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201007101726.3149375-1-a.nogikh@gmail.com> <20201007101726.3149375-2-a.nogikh@gmail.com>
 <20201009161558.57792e1a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201009161558.57792e1a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 10 Oct 2020 09:54:57 +0200
Message-ID: <CACT4Y+ZF_umjBpyJiCb8YPQOOSofG-M9h0CB=xn3bCgK=Kr=9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: store KCOV remote handle in sk_buff
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Aleksandr Nogikh <a.nogikh@gmail.com>,
        David Miller <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Oct 10, 2020 at 1:16 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  7 Oct 2020 10:17:25 +0000 Aleksandr Nogikh wrote:
> > From: Aleksandr Nogikh <nogikh@google.com>
> >
> > Remote KCOV coverage collection enables coverage-guided fuzzing of the
> > code that is not reachable during normal system call execution. It is
> > especially helpful for fuzzing networking subsystems, where it is
> > common to perform packet handling in separate work queues even for the
> > packets that originated directly from the user space.
> >
> > Enable coverage-guided frame injection by adding a kcov_handle
> > parameter to sk_buff structure. Initialization in __alloc_skb ensures
> > that no socket buffer that was generated during a system call will be
> > missed.
> >
> > Code that is of interest and that performs packet processing should be
> > annotated with kcov_remote_start()/kcov_remote_stop().
> >
> > An alternative approach is to determine kcov_handle solely on the
> > basis of the device/interface that received the specific socket
> > buffer. However, in this case it would be impossible to distinguish
> > between packets that originated from normal background network
> > processes and those that were intentionally injected from the user
> > space.
> >
> > Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
>
> Could you use skb_extensions for this?

Why? If for space, this is already under a non-production ifdef.
