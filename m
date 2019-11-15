Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE679FD2B9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 03:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKOCHW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 21:07:22 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43552 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKOCHV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 21:07:21 -0500
Received: by mail-il1-f196.google.com with SMTP id r9so7702337ilq.10
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2019 18:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WtJNvvQTM57vQy9ybmYv61sRHptoEawBLzqO01pOMCs=;
        b=IFoecrc8m8fphAQaN/F5RyjAqWGCR4PfqvdyIL3FNL+mdRFg7pn5uvyk8pbrpBdrpp
         vPmA6k1laEJWcEib3xyXQvchHZntOVfj/CbBzD4AMURCirGAA+XI+/oCJJUloSqtxlaI
         xXKPdM2RVrKKGaYvyt+26v7rHQ6mbcr5kzsd4/E22p/LQhfJC0XQdrB5Qc12MpjzEY9r
         uLItm6wEk/v7EW+eB7odlNAjJmfOFpvZejRd3pX0XZYMgQbbuk+Jonn62M+B1Y4+tflP
         C/5ZW5W0OzTF7AYid7vTZESa2BAlyt1FmX//gZNCQ4BJ+2oJlwbU7OmPknjEe3EKsDML
         gkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WtJNvvQTM57vQy9ybmYv61sRHptoEawBLzqO01pOMCs=;
        b=r51ZnZcH9D6lrTeS4NkIn15489SY0KQw34ThStlM2PBZGk/RQGhchwgZk6jKWTcNIQ
         EpzsJ53bVv8cNBIie+woh+fPzUKPRVPvCC1ayxtMdkPW+oU/9BfGJd7sStjZ6RTRZA5D
         8cQ7NWCinRqWxKjywhLWWXB/2iqkO34oH2n0QZ0h4qT64FPFH+AzXe693pX3IiFrKL+2
         JtN8MnAPlCtKSLI4zlFOCnsn4brXBGj8qnKt2SYNqUC2USfHrCXYeFnJXzISZ7pwq0SD
         bHvcKTk8o8Seh8o+iDPiMfn257Eg1WeHu8PjzzPy2+HR6XbH5fBaEeKYkgLRNu2mJTWg
         ssPA==
X-Gm-Message-State: APjAAAVEVLRV6WhppVAUr6w5yCbVBzBUB2TP7gj3DtCF+UxgfjqumqiQ
        4LwLAKpsuT4+ZMIShZR9PXUg4l8t8+PB/piKbRw=
X-Google-Smtp-Source: APXvYqzaeHa6iIhXYTaET/g4GjiZgwKk4zaD7+wu+gypV1ScmN3ohggEFSZjgej3DBiLVQ42ROYiujC5V19LyiGJN80=
X-Received: by 2002:a92:c8:: with SMTP id 191mr14057710ila.287.1573783640343;
 Thu, 14 Nov 2019 18:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
In-Reply-To: <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Thu, 14 Nov 2019 18:07:09 -0800
Message-ID: <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue
 Limit (AQL)
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 14, 2019 at 6:04 PM Kan Yan <kyan@google.com> wrote:
>
> I have tested it with Toke's patch "[PATCH v6 4/4] mac80211: Use
> Airtime-based Queue Limits (AQL) on packet dequeue", but didn't
> include it here, as it is self contained and Toke has plan to update
> it.
>
> The platform (QCA9984) used in my test

I do keep hoping for pretty pictures. Got any? :-P

>  doesn't support 802.11ax, so I
> was not able to test the HE mode support added in v7 update of "Import
> airtime calculation code from mt76" from Toke.

Is there an ax QCAXXXX platform, m.2 card, or mini-pci card worth
testing at this point?

How are they handling mu-mimo?

I have a round of tests scheduled for intel's ax200 chips, soon. Not sure
what, if any, of this new work might apply.

> On Thu, Nov 14, 2019 at 5:48 PM Kan Yan <kyan@google.com> wrote:
> >
> > This patch series port the Airtime Queue Limits concept from the out-of=
-tree
> > ath10k implementation[0] to mac80211. This version takes my patch to do=
 the
> > throttling in mac80211, and replaces the driver API with the mechanism =
from
> > Toke's series, which instead calculated the expected airtime at dequeue=
 time
> > inside mac80211, storing it in the SKB cb field.
> >
> > This version has been tested on QCA9984 platform.
> >
> > [0] https://chromium-review.googlesource.com/c/chromiumos/third_party/k=
ernel/+/1703105/7
> >
> > Changelog:
> >
> > v8:
> >   - Includes Toke's v7 version of "mac80211: Import airtime calculation=
 code from mt76"
> >   - Don't clobber sta's customized queue limit when configuring the def=
ault via debugfs
> >   - Fix a racing condition when reset aql_tx_pending.
> >
> > v7:
> >   - Fix aql_total_pending_airtime underflow due to insufficient locking=
.
> >
> > v6:
> >   - Fix sta lookup in ieee80211_report_used_skb().
> >   - Move call to ieee80211_sta_update_pending_airtime() to a bit later =
in
> >     __ieee80211_tx_status()
> > v5:
> >   - Add missing export of ieee80211_calc_rx_airtime() and make
> >     ieee80211_calc_tx_airtime_rate() static (kbuildbot).
> >   - Use skb_get_queue_mapping() to get the AC from the skb.
> >   - Take basic rate configuration for the BSS into account when calcula=
ting
> >     multicast rate.
> > v4:
> >   - Fix calculation that clamps the maximum airtime to fit into 10 bits
> >   - Incorporate Rich Brown's nits for the commit message in Kan's patch
> >   - Add fewer local variables to ieee80211_tx_dequeue()
> > v3:
> >   - Move the tx_time_est field so it's shared with ack_frame_id, and us=
e units
> >     of 4us for the value stored in it.
> >   - Move the addition of the Ethernet header size into ieee80211_calc_e=
xpected_tx_airtime()
> > v2:
> >   - Integrate Kan's approach to airtime throttling.
> >   - Hopefully fix the cb struct alignment on big-endian architectures.
> >
> >
> >
> > Kan Yan (1):
> >   mac80211: Implement Airtime-based Queue Limit (AQL)
> >
> > Toke H=C3=B8iland-J=C3=B8rgensen (1):
> >   mac80211: Import airtime calculation code from mt76
> >
> >  include/net/cfg80211.h     |   7 +
> >  include/net/mac80211.h     |  41 +++
> >  net/mac80211/Makefile      |   3 +-
> >  net/mac80211/airtime.c     | 597 +++++++++++++++++++++++++++++++++++++
> >  net/mac80211/debugfs.c     |  85 ++++++
> >  net/mac80211/debugfs_sta.c |  43 ++-
> >  net/mac80211/ieee80211_i.h |   8 +
> >  net/mac80211/main.c        |  10 +-
> >  net/mac80211/sta_info.c    |  38 +++
> >  net/mac80211/sta_info.h    |   8 +
> >  net/mac80211/tx.c          |  47 ++-
> >  11 files changed, 872 insertions(+), 15 deletions(-)
> >  create mode 100644 net/mac80211/airtime.c
> >
> > --
> > 2.24.0.rc1.363.gb1bccd3e3d-goog
> >
> _______________________________________________
> Make-wifi-fast mailing list
> Make-wifi-fast@lists.bufferbloat.net
> https://lists.bufferbloat.net/listinfo/make-wifi-fast



--=20

Dave T=C3=A4ht
CTO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-831-205-9740
