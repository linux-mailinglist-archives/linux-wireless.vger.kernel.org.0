Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78969A848E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 15:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfIDNeo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 09:34:44 -0400
Received: from mail.taht.net ([176.58.107.8]:59680 "EHLO mail.taht.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbfIDNeo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 09:34:44 -0400
Received: from dancer.taht.net (unknown [IPv6:2603:3024:1536:86f0:eea8:6bff:fefe:9a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.taht.net (Postfix) with ESMTPSA id 71D9F22898;
        Wed,  4 Sep 2019 13:34:42 +0000 (UTC)
From:   Dave Taht <dave@taht.net>
To:     Wen Gong <wgong@qti.qualcomm.com>
Cc:     "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
        <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
        <87k1apnyyo.fsf@taht.net>
        <259d8d7f8c2a4c428ae14ff211c83c1a@aptaiexm02f.ap.qualcomm.com>
Date:   Wed, 04 Sep 2019 06:34:29 -0700
In-Reply-To: <259d8d7f8c2a4c428ae14ff211c83c1a@aptaiexm02f.ap.qualcomm.com>
        (Wen Gong's message of "Wed, 4 Sep 2019 04:43:21 +0000")
Message-ID: <87lfv4chi2.fsf@taht.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@qti.qualcomm.com> writes:

>> -----Original Message-----
>> From: Dave Taht <dave@taht.net>
>> Sent: Wednesday, September 4, 2019 12:10 AM
>> To: Wen Gong <wgong@qti.qualcomm.com>; ath10k@lists.infradead.org;
>> linux-wireless@vger.kernel.org
>> Subject: [EXT] Re: [PATCH 2/7] ath10k: change max RX bundle size from 8 to
>> 32 for sdio
>> 
>> 
>> In terms of deeply grokking what increasing buffering to achieve high
>> bandwidth on a testbench, vs what it can do to clobber latency in the
>> real world at low bandwidths, I tend to point folk at:
>> 
>> https://www.youtube.com/watch?v=Rb-UnHDw02o&t=25m40s
>> 
>> where I got a whole bunch of hackers to stand up and act like packets
>> in an aggregating FIFO wifi queue.
>> 
>> This key section is only 8 minutes long, and I promise, y'all laugh
>> at least 3 times at the demonstration.
>> 
>> At the time, also, the ath10k was so overbuffered that on one test
>> I could try to start 100 flows, and only get five.
>> 
>> https://lwn.net/Articles/705884/
>> 
>> and on my slides:
>> 
>> https://blog.linuxplumbersconf.org/2016/ocw//system/presentations/3963/
>> original/linuxplumbers_wifi_latency-3Nov.pdf
>> 
> Hi Dave,
> So your mean is change 8  to 32 will impact latency? It will increase latency of rx?

Heh. for rx, in this case, probably not!

I just get twitchy every time folk fiddle with buffer sizes. In one
recent case someone had fiddled with the interrupt polling interval on
something, going from 1ms to 10ms - it saved on cpu, but...
... just trying to make sure folk grok the tradoffs with a bit of
laughter.

carry on!

>
>> 
>> 0xFFFEFFFF
