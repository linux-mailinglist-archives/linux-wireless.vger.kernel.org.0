Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2101B9151
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2020 17:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgDZP4h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Apr 2020 11:56:37 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:56076 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgDZP4h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Apr 2020 11:56:37 -0400
Received: from [192.168.254.4] (unknown [50.34.219.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A41B613C283
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2020 08:56:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A41B613C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1587916596;
        bh=9/1w6dAGFFxWzAuGO0TNENsbBAnkOJjjdZA7wKKQvFk=;
        h=To:From:Subject:Date:From;
        b=Tr2opzNWvPTCwgX5v/INCCyi3Ecy3Yc8d65WDP66AWOwwvusvLaXyuh4BxkfKMk80
         2k76r2838YObzYISM7/Ub8fhY2JoLOSGmUxLEzGUFCjRHM/UJ6erBWJ3BFpcD9KK3j
         3KPRtO+/ug473/J9fGVuSMIKSDbn9mFxy1zC6R50=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: WiFi Performance issue in 5.4.25+
Message-ID: <1a7c11e6-df88-209a-6053-17d4578c27e8@candelatech.com>
Date:   Sun, 26 Apr 2020 08:56:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

One of my test cases is to create lots of virtual station devices, and run bi-directional
TCP traffic between them an an Ethernet port, through an AP.  My automation is doing
around 7 tcp flows per station vdev.

This test is reliably falling apart at around 30 stations on an i7 2-core processor
system.  Interesting to me is the perf top in this state.  The stop_queue reliably
dominates.

   1   22.20%  [kernel]                            [k] __ieee80211_stop_queue
   2    7.66%  [kernel]                            [k] __lock_acquire_lockdep.isra.36
   3    4.46%  [kernel]                            [k] queued_spin_lock_slowpath
   4    4.40%  [kernel]                            [k] lock_release
   5    4.18%  [kernel]                            [k] lock_acquire
   6    1.47%  btserver                            [.] bitfield::get
   7    1.45%  [kernel]                            [k] sock_poll
   8    1.32%  [kernel]                            [k] tcp_poll
   9    1.30%  libc-2.23.so                        [.] __memset_sse2
  10    1.26%  [kernel]                            [k] do_raw_spin_lock
  11    1.06%  btserver                            [.] Cell<BaseEndpoint*>::next
  12    0.85%  btserver                            [.] Endpoint::doTrafficRound
  13

At 180 to 190 stations, the situation significantly improves.  At this point, there are only
two flows per station.

If I limit to one TCP flow per station for all numbers of vdevs, then it does not have total failures like it does with more
streams, but the stop_queue still dominates the perf top at higher numbers of stations (like 60-70).

I need to do some more testing with other kernels and such, but curious if anyone
has any suggestions as to why stop_queue is taking so much time?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
