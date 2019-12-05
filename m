Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5C51144E7
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 17:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLEQeU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 11:34:20 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:57918 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQeU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 11:34:20 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icu54-004ABQ-5d; Thu, 05 Dec 2019 17:34:18 +0100
Message-ID: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
Subject: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 05 Dec 2019 17:34:16 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Toke, all,

I'm debugging some throughput issues and wondered if you had a hint.
This is at HE rates 2x2 80 MHz, so you'd expect ~1Gbps or a bit more,
I'm getting ~900 Mbps. Just to set the stage.

What I think is (part of) the problem is that I see in the logs that our
hardware queues become empty every once a while.

This seems to be when/because ieee80211_tx_dequeue() returns NULL, and
we hit the
                        skb = ieee80211_tx_dequeue(hw, txq);

                        if (!skb) {
                                if (txq->sta)
                                        IWL_DEBUG_TX(mvm,
                                                     "TXQ of sta %pM tid %d is now empty\n",
                                                     txq->sta->addr,
                                                     txq->tid);

printout, e.g.
iwlwifi 0000:00:14.3: I iwl_mvm_mac_itxq_xmit TXQ of sta 0c:9d:92:03:12:44 tid 0 is now empty

This isn't always bad, but in most cases I see it happen the hardware
queue actually is rather shallow at the time, say only 57 packets in
some instance. Then we can basically send all the packets in the queue
in one or two aggregations (see I here an example with 57 packets in the
queue, ieee80211_tx_dequeue() returns NULL, and we then send an A-MPDU
with 38 followed by one with 19 packets, making the HW queue empty.)

This is with 10 simultaneous TCP streams, so there *shouldn't* be any
issues with that, I did indeed try to lower the pacing shift and it had
no effect. I couldn't try with just one or two streams (actually one
stream is not enough because the AP has only GBit LAN ... so in the
ideal case wireless is faster than ethernet!!) - somehow the test hangs
then, but I'll get back to that later.


Anyhow, do you have any tips on debugging this? This is still without
AQL code. The AQM stats for the AP look fine, basically everything is 0
except for "new-flows", "tx-bytes" and "tx-packets".

One thing that does seem odd is that the new-flows counter is increasing
this rapidly - shouldn't we expect it to be like 10 new flows for 10 TCP
sessions? I see this counter increase by the thousands per second.

I don't see any calls to __ieee80211_stop_queue() either, as expected
(per trace-cmd).

CPU load is not an issue AFAICT, even with all the debugging being
written into the syslog (or journal or something) that's the only thing
that takes noticable CPU time - ~50% for systemd-journal and ~20% for
rsyslogd, <10% for the throughput testing program and that's about it.
The system has 4 threads and seems mostly idle.

All this seems to mean that the TCP stack isn't feeding us fast enough,
but is that really possible?

Any other ideas?

Thanks,
johannes

