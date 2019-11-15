Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC99FD2AC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 03:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfKOCE0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 21:04:26 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35200 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfKOCEZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 21:04:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id r7so8911121ljg.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2019 18:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k+RkCsTHdY2ZkVMOeC5oUQogAL9fLuSmbUmi8ZzczVk=;
        b=folNVsCeRICwPLDGWyppsoOrCQyy+uledLfhdhdLxyUq1LcIw5h74H6XE1/wpFlp7n
         WsF92nzEW5TrRSYESZcfTmrFgMwzAXZiskr0xbM+lDBdGL1tqC8OsWGgTFmOyE0XH7mR
         AyYa//UR6qiz8U2jb2d2cmZscGR9ZZGCOUAaheCu2bhvtNRthmexFXIPIKKd1UJ7zps8
         WSrE1e4IvT3i4ikRlE71kGz0rc5l+B77+8VRDxaYbM7J+feHJKm+Ege5fmvyHxLFIvHS
         lkpRY7l4l7nCL1XcKznCy6hkYChIQuWOoCyIbAcuKpQpO2KMkK0L1g54a4I59Dkjve7x
         ZObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k+RkCsTHdY2ZkVMOeC5oUQogAL9fLuSmbUmi8ZzczVk=;
        b=D251srNIwUGto+Uyb8oHk2FZ9HCh95NbCMdb9ou4uSaKadSpHm5/NosatO6BqZCZMs
         wO1JhameZCI6ij7+NCMPxUsH3zRQHnUiaZY1L+8a4ZW77m5Rl0Z1MpdnE0C6Bd7KHpgG
         gl0PkB/KoicLRnwPqsTdEfJK9sUvMFahDwCnMCo2J+aBqS4AV9QMLprb2yPjLq59ZaVy
         BnaaGx3sBU2MCsH2eP2QZXOutohFkklWe+0+rlm9Rpy1GSzO9JMWUBz78Fh3+AR9Xp3k
         D2FHbf2aIR0ihgixdleH1QlNVhgX62xN72J8eZ9iWMeGas+tqs19JnQ05uoVDy5tcqfX
         QUMw==
X-Gm-Message-State: APjAAAXGMJUaHqGmjcMqtBjzMUJssO8AlLFPnjpmBzRo58hr4Vb+uYKd
        D8FX6dXKtV/jCEFWyXmvM0PPzsm+lUq+bVGS3hcsdw==
X-Google-Smtp-Source: APXvYqwzP255AuNJVA3k98w7XR8qF5Z/vP0RFS5NY3Ln9yDLuKdInTsCYhlE8vbV5zEgMgUHJRNOjhFz80yPOJWQzd8=
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr9126760ljj.114.1573783462751;
 Thu, 14 Nov 2019 18:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20191115014846.126007-1-kyan@google.com>
In-Reply-To: <20191115014846.126007-1-kyan@google.com>
From:   Kan Yan <kyan@google.com>
Date:   Thu, 14 Nov 2019 18:04:11 -0800
Message-ID: <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Implement Airtime-based Queue Limit (AQL)
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Felix Fietkau <nbd@nbd.name>, Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have tested it with Toke's patch "[PATCH v6 4/4] mac80211: Use
Airtime-based Queue Limits (AQL) on packet dequeue", but didn't
include it here, as it is self contained and Toke has plan to update
it.

The platform (QCA9984) used in my test doesn't support 802.11ax, so I
was not able to test the HE mode support added in v7 update of "Import
airtime calculation code from mt76" from Toke.

On Thu, Nov 14, 2019 at 5:48 PM Kan Yan <kyan@google.com> wrote:
>
> This patch series port the Airtime Queue Limits concept from the out-of-t=
ree
> ath10k implementation[0] to mac80211. This version takes my patch to do t=
he
> throttling in mac80211, and replaces the driver API with the mechanism fr=
om
> Toke's series, which instead calculated the expected airtime at dequeue t=
ime
> inside mac80211, storing it in the SKB cb field.
>
> This version has been tested on QCA9984 platform.
>
> [0] https://chromium-review.googlesource.com/c/chromiumos/third_party/ker=
nel/+/1703105/7
>
> Changelog:
>
> v8:
>   - Includes Toke's v7 version of "mac80211: Import airtime calculation c=
ode from mt76"
>   - Don't clobber sta's customized queue limit when configuring the defau=
lt via debugfs
>   - Fix a racing condition when reset aql_tx_pending.
>
> v7:
>   - Fix aql_total_pending_airtime underflow due to insufficient locking.
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
>
>
> Kan Yan (1):
>   mac80211: Implement Airtime-based Queue Limit (AQL)
>
> Toke H=C3=B8iland-J=C3=B8rgensen (1):
>   mac80211: Import airtime calculation code from mt76
>
>  include/net/cfg80211.h     |   7 +
>  include/net/mac80211.h     |  41 +++
>  net/mac80211/Makefile      |   3 +-
>  net/mac80211/airtime.c     | 597 +++++++++++++++++++++++++++++++++++++
>  net/mac80211/debugfs.c     |  85 ++++++
>  net/mac80211/debugfs_sta.c |  43 ++-
>  net/mac80211/ieee80211_i.h |   8 +
>  net/mac80211/main.c        |  10 +-
>  net/mac80211/sta_info.c    |  38 +++
>  net/mac80211/sta_info.h    |   8 +
>  net/mac80211/tx.c          |  47 ++-
>  11 files changed, 872 insertions(+), 15 deletions(-)
>  create mode 100644 net/mac80211/airtime.c
>
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
