Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE1100D6A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 22:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRVId (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 16:08:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39260 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKRVId (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 16:08:33 -0500
Received: by mail-io1-f67.google.com with SMTP id k1so20496320ioj.6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 13:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6ToDI7YAwAGIZCVsFetdjYJyOLY7Wu7XON7IJlg1Rm8=;
        b=K4P6HPvR1Nsg5cMOfe5CdXWaGPjk+Dkh0tTYiEVxzR4XaYVIAyIrkFIW4M+JoNDYGB
         pK7G36qDCgIrPuqZ+vL/ekananemRZQAdrP6gGK7Ca2mXVoUqv3+URRWKDbR1T1cckJl
         YRly+VwpDAykU0V/vTCkSvkWRBRA+rByeNPd7lNRVcRva/llz3XXXYekypeIVAc2coUN
         nEQEGa/UHlCj95tqBxArBy1jiH9KAnWqVKSJhN/MBoVpcTkdocyP35pPX4Sp3mbxHIwE
         FXdMd/F06CrmVciAzzOWO6Gg6THH/IPi8JcY2V3SJOKR5IcuLv9Jaf/zGIrdgRdCAq49
         w/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6ToDI7YAwAGIZCVsFetdjYJyOLY7Wu7XON7IJlg1Rm8=;
        b=pa8LOvHvvDmawhFFhWH21+9tNWCpk+iAXv/2a/nc/0M8QlZWRC3fjleIDY1fEvPPCs
         vHCWpY8hHlAhmAFeHZChN2qQDrhcevBNu3vdKQCKY/jVzDDVsEyZZM/bvACiv6ZWHTRM
         paTunnB4D6EVKuP9MpkCVa+M99zGkewt/CNQ6pXL+Vb7ojqdENa4fb6I1PHBmVvUfi/L
         a2MNa9qWd2oOTkztIhhIipUmFI3NvoaumhHNcnwqoyWI5LaoNOLhuuqPbPwOxnVfqs2c
         dze2kBOSgbL0fIpmeG4NQZ83KJXDfZ4MqkfBKwCkEnpFAmdbs4H/RdxrSOeS3/og4Vc/
         mxMA==
X-Gm-Message-State: APjAAAVxeID08ZVEh18wMD6wM7Dp93ts8wN0tZkQ+8JYZV7qUQRuFS78
        JDmwNoQYVBByLgn4og8fL0KwGbe+eWhqwxRM7LU=
X-Google-Smtp-Source: APXvYqzGf3T9qKCp2WNakneZGvOqt1rvFFU9WtfJZ6mZBL9GIyjbRQG5qpR/s/S7xHaU1OVCDqMLShgEDqEO2vI+0uM=
X-Received: by 2002:a02:1788:: with SMTP id 130mr14987456jah.82.1574111312236;
 Mon, 18 Nov 2019 13:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
 <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com> <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com>
In-Reply-To: <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Mon, 18 Nov 2019 13:08:21 -0800
Message-ID: <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com>
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

On Fri, Nov 15, 2019 at 4:10 PM Kan Yan <kyan@google.com> wrote:
>
> > I do keep hoping for pretty pictures. Got any? :-P
>
> Certainly! I do have some :). Here is the link:
> https://drive.google.com/corp/drive/folders/14OIuQEHOUiIoNrVnKprj6rBYFNZ0=
Coif

Those were lovely, thanks!!!! Big win. Since you are on patch v10
now.... Any chance you could turn ecn on and off and give it a go
again in your next test run?

Also:

--step-size=3D.04 --socket-stats # the first is helpful to gain more
detail, the second as to the behavior of the tcp stack. You might need
to run as root (and It's only useful on the tcp_nup test) for the
latter (and have the right ss utility)

Secondly - and AFTER this patchset stablizes, I'd like us to look into
returning the codel default to 10ms or less
from it's currently 20ms or worse setting. Tis another easy test

And y'all know how much I love the rrul_be and rrul tests.....


> >
> > Is there an ax QCAXXXX platform, m.2 card, or mini-pci card worth
> > testing at this point?
>
> It will be great if someone with 11.ax platform can help give it a try.
>
> > How are they handling mu-mimo?
>
> I think it should still work. The queue length in airtime for each indivi=
dual queue is unchanged, even the multiple queues are allowed to transmit c=
oncurrently with mu-mimo.
>
>> I have a round of tests scheduled for intel's ax200 chips, soon. Not sur=
e
>> what, if any, of this new work might apply.
>
> It will be very interesting to know how it performance on 802.11ax platfo=
rms. Supposedly 802.11ax already fixed the latency problem so the benefit o=
f this patch should be less significant.
>
>
> On Thu, Nov 14, 2019 at 6:07 PM Dave Taht <dave.taht@gmail.com> wrote:
>>
>> On Thu, Nov 14, 2019 at 6:04 PM Kan Yan <kyan@google.com> wrote:
>> >
>> > I have tested it with Toke's patch "[PATCH v6 4/4] mac80211: Use
>> > Airtime-based Queue Limits (AQL) on packet dequeue", but didn't
>> > include it here, as it is self contained and Toke has plan to update
>> > it.
>> >
>> > The platform (QCA9984) used in my test
>>
>> I do keep hoping for pretty pictures. Got any? :-P
>>
>> >  doesn't support 802.11ax, so I
>> > was not able to test the HE mode support added in v7 update of "Import
>> > airtime calculation code from mt76" from Toke.
>>
>> Is there an ax QCAXXXX platform, m.2 card, or mini-pci card worth
>> testing at this point?
>>
>> How are they handling mu-mimo?
>>
>> I have a round of tests scheduled for intel's ax200 chips, soon. Not sur=
e
>> what, if any, of this new work might apply.
>>
>> > On Thu, Nov 14, 2019 at 5:48 PM Kan Yan <kyan@google.com> wrote:
>> > >
>> > > This patch series port the Airtime Queue Limits concept from the out=
-of-tree
>> > > ath10k implementation[0] to mac80211. This version takes my patch to=
 do the
>> > > throttling in mac80211, and replaces the driver API with the mechani=
sm from
>> > > Toke's series, which instead calculated the expected airtime at dequ=
eue time
>> > > inside mac80211, storing it in the SKB cb field.
>> > >
>> > > This version has been tested on QCA9984 platform.
>> > >
>> > > [0] https://chromium-review.googlesource.com/c/chromiumos/third_part=
y/kernel/+/1703105/7
>> > >
>> > > Changelog:
>> > >
>> > > v8:
>> > >   - Includes Toke's v7 version of "mac80211: Import airtime calculat=
ion code from mt76"
>> > >   - Don't clobber sta's customized queue limit when configuring the =
default via debugfs
>> > >   - Fix a racing condition when reset aql_tx_pending.
>> > >
>> > > v7:
>> > >   - Fix aql_total_pending_airtime underflow due to insufficient lock=
ing.
>> > >
>> > > v6:
>> > >   - Fix sta lookup in ieee80211_report_used_skb().
>> > >   - Move call to ieee80211_sta_update_pending_airtime() to a bit lat=
er in
>> > >     __ieee80211_tx_status()
>> > > v5:
>> > >   - Add missing export of ieee80211_calc_rx_airtime() and make
>> > >     ieee80211_calc_tx_airtime_rate() static (kbuildbot).
>> > >   - Use skb_get_queue_mapping() to get the AC from the skb.
>> > >   - Take basic rate configuration for the BSS into account when calc=
ulating
>> > >     multicast rate.
>> > > v4:
>> > >   - Fix calculation that clamps the maximum airtime to fit into 10 b=
its
>> > >   - Incorporate Rich Brown's nits for the commit message in Kan's pa=
tch
>> > >   - Add fewer local variables to ieee80211_tx_dequeue()
>> > > v3:
>> > >   - Move the tx_time_est field so it's shared with ack_frame_id, and=
 use units
>> > >     of 4us for the value stored in it.
>> > >   - Move the addition of the Ethernet header size into ieee80211_cal=
c_expected_tx_airtime()
>> > > v2:
>> > >   - Integrate Kan's approach to airtime throttling.
>> > >   - Hopefully fix the cb struct alignment on big-endian architecture=
s.
>> > >
>> > >
>> > >
>> > > Kan Yan (1):
>> > >   mac80211: Implement Airtime-based Queue Limit (AQL)
>> > >
>> > > Toke H=C3=B8iland-J=C3=B8rgensen (1):
>> > >   mac80211: Import airtime calculation code from mt76
>> > >
>> > >  include/net/cfg80211.h     |   7 +
>> > >  include/net/mac80211.h     |  41 +++
>> > >  net/mac80211/Makefile      |   3 +-
>> > >  net/mac80211/airtime.c     | 597 ++++++++++++++++++++++++++++++++++=
+++
>> > >  net/mac80211/debugfs.c     |  85 ++++++
>> > >  net/mac80211/debugfs_sta.c |  43 ++-
>> > >  net/mac80211/ieee80211_i.h |   8 +
>> > >  net/mac80211/main.c        |  10 +-
>> > >  net/mac80211/sta_info.c    |  38 +++
>> > >  net/mac80211/sta_info.h    |   8 +
>> > >  net/mac80211/tx.c          |  47 ++-
>> > >  11 files changed, 872 insertions(+), 15 deletions(-)
>> > >  create mode 100644 net/mac80211/airtime.c
>> > >
>> > > --
>> > > 2.24.0.rc1.363.gb1bccd3e3d-goog
>> > >
>> > _______________________________________________
>> > Make-wifi-fast mailing list
>> > Make-wifi-fast@lists.bufferbloat.net
>> > https://lists.bufferbloat.net/listinfo/make-wifi-fast
>>
>>
>>
>> --
>>
>> Dave T=C3=A4ht
>> CTO, TekLibre, LLC
>> http://www.teklibre.com
>> Tel: 1-831-205-9740



--=20

Dave T=C3=A4ht
CTO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-831-205-9740
