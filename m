Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B1B1D18
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfIMMLK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 08:11:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfIMMLK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 08:11:10 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A44D080F91
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 12:11:09 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id g1so4281497ljl.22
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 05:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=P/y1QolOmUl57X3uu8no6li4qk/g2U4iIuaoTH4Zx3s=;
        b=s94gUvyv20k6JJSXMMmdHufYbN+Dx8Af0bDJZMDogmUXFPJfAap8q20nk5SznoSi8f
         7oA0FENRDfCZKQKpO54+pkt7oZVYjv0j9Y822k4QUPe1O0GZKFOxHxTtaiFJfOLjhWaE
         ZNr0HISNZeldC2NbpKw7jMK5Idam9fZtuAkBezlXrMkjKrhTh9v3X5Tw30DXdWh2ZnZk
         OK8mWRTBQUIWOywCs4mm1KrLzY/vFnZEItjt0+q8jWW5Sf9remjAB8FyfpHntfUzLs3c
         WGj+nVQtD4wV4Ow3nn8s2GP3lnPAhjw9p6DS+0UKr7Dm881m71Ung6VbC88Y1fhOFkeQ
         o4Xg==
X-Gm-Message-State: APjAAAWm2GoZGpU7avzrVGgyYddEONS/17ySp2mnswjCasIf+lfaDN4q
        g6s/BlbV/SPahFXXzXiW3DzejHeJizHNT2YnzsYpHcagfCPlocImr7PlCPWVsxs2xhxF8NB+LeI
        Hho1tpVY6e6x0bDNEm7vZvsHDXIw=
X-Received: by 2002:a19:2313:: with SMTP id j19mr30673443lfj.138.1568376667800;
        Fri, 13 Sep 2019 05:11:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMhW5upUUiVZtuc5W0IUi0zpGx4acoqaZN2H8xawxkeFj3ydUg8sh5FQyl9e4U0DgWSYi0qA==
X-Received: by 2002:a19:2313:: with SMTP id j19mr30673431lfj.138.1568376667631;
        Fri, 13 Sep 2019 05:11:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id k6sm7006575ljk.45.2019.09.13.05.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 05:11:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 02035180613; Fri, 13 Sep 2019 14:11:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lukas Redlinger <rel+kernel@agilox.net>,
        linux-wireless@vger.kernel.org
Cc:     j@w1.fi
Subject: Re: BUG: using smp_processor_id() in preemptible [00000000] code: wpa_supplicant
In-Reply-To: <CAN5HydrWb3o_FE6A1XDnP1E+xS66d5kiEuhHfiGKkLNQokx13Q@mail.gmail.com>
References: <CAN5HydrWb3o_FE6A1XDnP1E+xS66d5kiEuhHfiGKkLNQokx13Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 13 Sep 2019 14:11:05 +0200
Message-ID: <87k1acs8fa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lukas Redlinger <rel+kernel@agilox.net> writes:

> Hello,
>
> on Arch Linux 5.2.11 with wpa_supplicant 2.8 / 2.9 our systems
> increasingly show this issue:
>
> [72770.969617] BUG: using smp_processor_id() in preemptible [00000000]
> code: wpa_supplicant/16207
> [72770.969638] caller is ieee80211_xmit_fast_finish+0x5a/0x1e0 [mac80211]
> [72770.969640] CPU: 2 PID: 16207 Comm: wpa_supplicant Tainted: G
>  W         5.2.11-arch1-1-ARCH #1
> [72770.969641] Hardware name: CINCOZE DI-1000/DI-1000, BIOS 5.11 02/20/2019
> [72770.969642] Call Trace:
> [72770.969647]  dump_stack+0x5c/0x80
> [72770.969661]  debug_smp_processor_id+0xde/0xe0
> [72770.969674]  ieee80211_xmit_fast_finish+0x5a/0x1e0 [mac80211]
> [72770.969687]  ieee80211_tx_dequeue+0x472/0xb50 [mac80211]
> [72770.969695]  iwl_mvm_mac_itxq_xmit+0x6f/0x100 [iwlmvm]
> [72770.969721]  _ieee80211_wake_txqs+0x218/0x450 [mac80211]
> [72770.969733]  ieee80211_wake_queues_by_reason+0x7a/0xd0 [mac80211]
> [72770.969745]  ieee80211_set_disassoc+0x48d/0x5d0 [mac80211]
> [72770.969760]  ieee80211_mgd_deauth.cold+0x4a/0x3f4 [mac80211]
> [72770.969797]  cfg80211_mlme_deauth+0xc1/0x220 [cfg80211]
> [72770.969809]  nl80211_deauthenticate+0xd8/0x120 [cfg80211]
> [72770.969813]  genl_family_rcv_msg+0x1f3/0x470
> [72770.969815]  genl_rcv_msg+0x47/0x90
> [72770.969818]  ? __kmalloc_node_track_caller+0x1b7/0x2d0
> [72770.969819]  ? genl_family_rcv_msg+0x470/0x470
> [72770.969820]  netlink_rcv_skb+0x75/0x140
> [72770.969822]  genl_rcv+0x24/0x40
> [72770.969823]  netlink_unicast+0x177/0x1f0
> [72770.969824]  netlink_sendmsg+0x1fe/0x3c0
> [72770.969827]  sock_sendmsg+0x4f/0x60
> [72770.969828]  ___sys_sendmsg+0x304/0x370
> [72770.969831]  ? unix_ioctl+0x99/0x190
> [72770.969834]  __sys_sendmsg+0x81/0xd0
> [72770.969850]  do_syscall_64+0x5f/0x1d0
> [72770.969851]  ? prepare_exit_to_usermode+0x85/0xb0
> [72770.969853]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Hmm, ieee80211_set_disassoc() has a call to ieee80211_flush_queues();
but that only calls into the driver, it doesn't flush the TXQ. Maybe we
need to add that?

-Toke
