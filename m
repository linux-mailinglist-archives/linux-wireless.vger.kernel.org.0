Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85ADBF278C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 07:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfKGGOf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 01:14:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42632 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfKGGOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 01:14:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id n5so851020ljc.9
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 22:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G20uDCnZ3VggElG4QPQIueyfFp9elwSxdclEXe5q4wI=;
        b=Pfr4O/UFKdu1PstiJc5UkY5CxZVKh1mQyDEUnzFkBFC36EJnrfqe3p8x/jEhdnN6SD
         ovz0YB2wHd5vKFez+AL9kEqfC7CmhiWdQMUPI/675Aam8MGpaElHbf+bJQjuBmlkNIM/
         MECzG6CXNrhdeW5zfg7BH8XAcRGgbfVs2DJr0HhpldDVjyM64qAtH3oLCReaZEeyQ7Jz
         o052OkpraQz92DWJjimWTjtVqABhXgmduCv8trSbCbof6udAu1dCndCmkigiGbQboFPH
         R85rfBwd1rk9MOip3TRuyCciD2jVqa3mqyEZ1sOKnPHQGhE6DEy7Bym46JP5vdwFs1iP
         4EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G20uDCnZ3VggElG4QPQIueyfFp9elwSxdclEXe5q4wI=;
        b=tgiekmsKqlm6giUo3BEd8SnQbRCqxKykAV5NRvBBwu3RgZEOTSiK2fXcWxnp4APqpQ
         C6La43MKgjpwqKhsD8nnd1cRKs+Snpk2MBXUtEQLax0ZqS6RmXl6mJJulgl5XuSJr42/
         2cUm4nffIqPXTQZrQtpTsDmS//ZkKrUwQMgjeak3FX1TZZOsla5rMZn6q3QoGD9tJOK2
         RMLt0RzW5g2coI+z6cMSEmlahhW90a1Zlx6yQr31QGNWZ5KFSkgzlsT76wozjB4Z7vWt
         7TYX5HfZQsfMGWW+VPXKsReQOXqstiyRznKGf32kncRP2hC2jPF0C2hv1nueGQ4QJ47W
         uB3Q==
X-Gm-Message-State: APjAAAVlWqrdHqQT+88P0O5ZKLwt7bGD+8ddyvVqh+d0SEQ6DcSM7jm8
        xvtZYeek1plW7XlqnhpfuPhUyqmDdVg275sNcc1yCw==
X-Google-Smtp-Source: APXvYqysDCGa4md3DJKlaj1XmpADyCPv3/2tOdV7mFSIVBTUCjOtcAW5LEDFojFZhMnhdYazOBoH+jLACx6BhWt3znk=
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr961356ljj.114.1573107272596;
 Wed, 06 Nov 2019 22:14:32 -0800 (PST)
MIME-Version: 1.0
References: <157182473951.150713.7978051149956899705.stgit@toke.dk>
In-Reply-To: <157182473951.150713.7978051149956899705.stgit@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Wed, 6 Nov 2019 22:14:20 -0800
Message-ID: <CA+iem5s6jDNR+yA21UB_zJiZeVxix_QaO6RYw6sN69j2859zFw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add Airtime Queue Limits (AQL) to mac80211
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Patchset v6 works for me with ath10k driver.  AQL does its job as
expected and tests show very significant reduction in latency in
congested environment. The txq stuck issue in patchset v4 got fixed.

However, the device's total pending airtime count still underflows
sometimes. Even though it doesn't cause apparent side effect, there is
some issue with the pending airtime update and needs further
debugging.

Regards,
Kan


On Wed, Oct 23, 2019 at 2:59 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> This series is a first attempt at porting the Airtime Queue Limits concep=
t from
> the out-of-tree ath10k implementation[0] to mac80211. This version takes =
Kan's
> patch to do the throttling in mac80211, and replaces the driver API with =
the
> mechanism from the previous version of my series, which instead calculate=
d the
> expected airtime at dequeue time inside mac80211, storing it in the SKB c=
b
> field.
>
> This series also imports Felix' airtime calculation code from mt76 into
> mac80211, adjusting the API so it can be used from TX dequeue, by extract=
ing the
> latest TX rate from the tx_stats structure kept for each station.
>
> As before, I've only compile tested this (lacking the proper hardware to =
do more
> testing). So I'm hoping someone with a proper testing setup can take the =
whole
> thing for a spin... :)
>
> The series is also available in my git repo here:
> https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/log/?h=3Dm=
ac80211-aql-06
>
> Changelog:
>
> v6:
>   - Fix sta lookup in ieee80211_report_used_skb().
>   - Move call to ieee80211_sta_update_pending_airtime() to a bit later in
>     __ieee80211_tx_status()
> v5:
>   - Add missing export of ieee80211_calc_rx_airtime() and make
>     ieee80211_calc_tx_airtime_rate() static (kbuildbot).
>   - Use skb_get_queue_mapping() to get the AC from the skb.
>   - Take basic rate configuration for the BSS into account when calculati=
ng
>     multicast rate.
> v4:
>   - Fix calculation that clamps the maximum airtime to fit into 10 bits
>   - Incorporate Rich Brown's nits for the commit message in Kan's patch
>   - Add fewer local variables to ieee80211_tx_dequeue()
> v3:
>   - Move the tx_time_est field so it's shared with ack_frame_id, and use =
units
>     of 4us for the value stored in it.
>   - Move the addition of the Ethernet header size into ieee80211_calc_exp=
ected_tx_airtime()
> v2:
>   - Integrate Kan's approach to airtime throttling.
>   - Hopefully fix the cb struct alignment on big-endian architectures.
>
> ---
>
> Kan Yan (1):
>       mac80211: Implement Airtime-based Queue Limit (AQL)
>
> Toke H=C3=B8iland-J=C3=B8rgensen (3):
>       mac80211: Shrink the size of ack_frame_id to make room for tx_time_=
est
>       mac80211: Import airtime calculation code from mt76
>       mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
>
>
>  include/net/cfg80211.h     |    7 +
>  include/net/mac80211.h     |   45 +++++
>  net/mac80211/Makefile      |    3
>  net/mac80211/airtime.c     |  390 ++++++++++++++++++++++++++++++++++++++=
++++++
>  net/mac80211/cfg.c         |    2
>  net/mac80211/debugfs.c     |   78 +++++++++
>  net/mac80211/debugfs_sta.c |   43 ++++-
>  net/mac80211/ieee80211_i.h |    8 +
>  net/mac80211/main.c        |    9 +
>  net/mac80211/sta_info.c    |   32 ++++
>  net/mac80211/sta_info.h    |    8 +
>  net/mac80211/status.c      |   33 ++++
>  net/mac80211/tx.c          |   69 +++++++-
>  13 files changed, 709 insertions(+), 18 deletions(-)
>  create mode 100644 net/mac80211/airtime.c
>
