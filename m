Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6B6F0CE
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 23:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGTV3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 17:29:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46601 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfGTV3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 17:29:32 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so65657823iol.13
        for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2019 14:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKChedqrwuL+IRcibVtBTRS8dDUCRX/IX1dFfkiqP1E=;
        b=L9LpDnX5lZlD2Sa1knaFtTCiz97/1mOw5iBSWn2PCrCozHuohyhYZikpFKpvRIJ7Mj
         a1RUz2nkppjJxdqWFVSNFoLQrLMXGD0i+glxB3MtBAR6BKoriD37RK6TnrH/QXb0fAlO
         xRp4qc2/o0y6Qt9t7hCbnuPvifeW/1k6xkw03fwd3WN8jE2/6XdKSs9n/wpn97ZdX2rQ
         vn7Tw9HwKpg5HeCty89JhQidee+5nLaW9/iJtjjZQBcwokJ1W/m0YdICJUovDwGUFaA6
         HMvC4QIyAJlJhUv2jNYM4dWFHxu60nTde5pkGrdFCeNW7c6ld+lEsMvw2zfM5RR36X0W
         4s/Q==
X-Gm-Message-State: APjAAAUfgoq8pNji0/u39f+Vh8ZUfc+Jx9IkML2sSOKOB1jdXVChOD+c
        nJLFtUTD3XYe6VHxegrJEimsMPiblS6Y+PGjEwg3UHNi
X-Google-Smtp-Source: APXvYqzZMVl2P5Z64gcYi9OUvw2wtSBZyRLeWObOp57NGNyV5eEnRCPIZ7qRch+ByzghCj1CfapSsW8IiX7nfP7ous8=
X-Received: by 2002:a5d:8702:: with SMTP id u2mr36351854iom.228.1563658171977;
 Sat, 20 Jul 2019 14:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <a266417a71907f663991142f5ce44becc09e6996.1563490117.git.lorenzo@kernel.org>
 <2dffacc1bcbf001d38a173cdce7d141a3dd130a7.camel@sipsolutions.net>
In-Reply-To: <2dffacc1bcbf001d38a173cdce7d141a3dd130a7.camel@sipsolutions.net>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 20 Jul 2019 23:29:20 +0200
Message-ID: <CAJ0CqmWCp3fOKM1TdNaMV4KEnd0L3KFFxiBB1tQQeWEvZdAGyw@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7603: fix watchdog rescheduling in mt7603_set_channel
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On Fri, 2019-07-19 at 00:50 +0200, Lorenzo Bianconi wrote:
> > Convert MT7603_WATCHDOG_TIME in jiffies rescheduling watchdog delayed
> > work
>
> Seems a bit inconsistent to me, the previous patch for mt7615 used
> jiffies in the define, but here you convert?
>

Hi Johannes,

I personally prefer to define the timeout directly in jiffies (as it
is done in mt76x02) but MT7603_WATCHDOG_TIME is already used in this
way (e.g. mt7603_mac_work()) so I have just maintained the convention.
Anyway we can convert it as well.

Regards,
Lorenzo


> johannes
>
