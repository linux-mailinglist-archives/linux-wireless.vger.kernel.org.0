Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD1F3A8E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfKGVbH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 16:31:07 -0500
Received: from mail.taht.net ([176.58.107.8]:56466 "EHLO mail.taht.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfKGVbH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 16:31:07 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 16:31:05 EST
Received: from dancer.taht.net (unknown [IPv6:2603:3024:1536:86f0:eea8:6bff:fefe:9a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.taht.net (Postfix) with ESMTPSA id ACA642296C;
        Thu,  7 Nov 2019 21:24:24 +0000 (UTC)
From:   Dave Taht <dave@taht.net>
To:     Kan Yan <kyan@google.com>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH v6 0/4] Add Airtime Queue Limits (AQL) to mac80211
References: <157182473951.150713.7978051149956899705.stgit@toke.dk>
        <CA+iem5s6jDNR+yA21UB_zJiZeVxix_QaO6RYw6sN69j2859zFw@mail.gmail.com>
Date:   Thu, 07 Nov 2019 13:24:12 -0800
In-Reply-To: <CA+iem5s6jDNR+yA21UB_zJiZeVxix_QaO6RYw6sN69j2859zFw@mail.gmail.com>
        (Kan Yan's message of "Wed, 6 Nov 2019 22:14:20 -0800")
Message-ID: <87pni3fkhv.fsf@taht.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> Patchset v6 works for me with ath10k driver.  AQL does its job as
> expected and tests show very significant reduction in latency in
> congested environment. The txq stuck issue in patchset v4 got fixed.
>
> However, the device's total pending airtime count still underflows
> sometimes. Even though it doesn't cause apparent side effect, there is
> some issue with the pending airtime update and needs further
> debugging.
>
> Regards,
> Kan

That's great to hear! I have been trying to clear some time to get on
this too (I have a HUGE number of fq_codel related updates on top of
this worth testing) but it's still looking a few weeks out.

>
>
> On Wed, Oct 23, 2019 at 2:59 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> This series is a first attempt at porting the Airtime Queue Limits concept from
>> the out-of-tree ath10k implementation[0] to mac80211. This version takes Kan's
>> patch to do the throttling in mac80211, and replaces the driver API with the
>> mechanism from the previous version of my series, which instead calculated the
>> expected airtime at dequeue time inside mac80211, storing it in the SKB cb
>> field.
>>
>> This series also imports Felix' airtime calculation code from mt76 into
>> mac80211, adjusting the API so it can be used from TX dequeue, by extracting the
>> latest TX rate from the tx_stats structure kept for each station.
>>
>> As before, I've only compile tested this (lacking the proper hardware to do more
>> testing). So I'm hoping someone with a proper testing setup can take the whole
>> thing for a spin... :)
>>
>> The series is also available in my git repo here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/log/?h=mac80211-aql-06
>>
>> Changelog:
>>
>> v6:
>>   - Fix sta lookup in ieee80211_report_used_skb().
>>   - Move call to ieee80211_sta_update_pending_airtime() to a bit later in
>>     __ieee80211_tx_status()
>> v5:
>>   - Add missing export of ieee80211_calc_rx_airtime() and make
>>     ieee80211_calc_tx_airtime_rate() static (kbuildbot).
>>   - Use skb_get_queue_mapping() to get the AC from the skb.
>>   - Take basic rate configuration for the BSS into account when calculating
>>     multicast rate.
>> v4:
>>   - Fix calculation that clamps the maximum airtime to fit into 10 bits
>>   - Incorporate Rich Brown's nits for the commit message in Kan's patch
>>   - Add fewer local variables to ieee80211_tx_dequeue()
>> v3:
>>   - Move the tx_time_est field so it's shared with ack_frame_id, and use units
>>     of 4us for the value stored in it.
>>   - Move the addition of the Ethernet header size into ieee80211_calc_expected_tx_airtime()
>> v2:
>>   - Integrate Kan's approach to airtime throttling.
>>   - Hopefully fix the cb struct alignment on big-endian architectures.
>>
>> ---
>>
>> Kan Yan (1):
>>       mac80211: Implement Airtime-based Queue Limit (AQL)
>>
>> Toke Høiland-Jørgensen (3):
>>       mac80211: Shrink the size of ack_frame_id to make room for tx_time_est
>>       mac80211: Import airtime calculation code from mt76
>>       mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
>>
>>
>>  include/net/cfg80211.h     |    7 +
>>  include/net/mac80211.h     |   45 +++++
>>  net/mac80211/Makefile      |    3
>>  net/mac80211/airtime.c     |  390 ++++++++++++++++++++++++++++++++++++++++++++
>>  net/mac80211/cfg.c         |    2
>>  net/mac80211/debugfs.c     |   78 +++++++++
>>  net/mac80211/debugfs_sta.c |   43 ++++-
>>  net/mac80211/ieee80211_i.h |    8 +
>>  net/mac80211/main.c        |    9 +
>>  net/mac80211/sta_info.c    |   32 ++++
>>  net/mac80211/sta_info.h    |    8 +
>>  net/mac80211/status.c      |   33 ++++
>>  net/mac80211/tx.c          |   69 +++++++-
>>  13 files changed, 709 insertions(+), 18 deletions(-)
>>  create mode 100644 net/mac80211/airtime.c
>>
> _______________________________________________
> Make-wifi-fast mailing list
> Make-wifi-fast@lists.bufferbloat.net
> https://lists.bufferbloat.net/listinfo/make-wifi-fast
