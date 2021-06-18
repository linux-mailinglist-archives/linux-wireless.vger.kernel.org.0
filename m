Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A7F3AC98C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhFRLQE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:16:04 -0400
Received: from mout02.posteo.de ([185.67.36.66]:41583 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhFRLQE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:16:04 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6584D2400E5
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 13:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1624014833; bh=6I6wno2eBn8HDLaReDV8/JsxCpHED2YpfYCUJhU9YRo=;
        h=To:From:Subject:Date:From;
        b=OB232FIBNuEOd7/ewMJLBPha4zM+wzv7M3b+O5I03mio9S6+oMk/4yDJJ21nteI+7
         a6xNbyTEIjxdH8TLV5JP18fIMbbymkCZjbXy6f8Ywy+GxbDqMqhghQRh1JPCt2LrcW
         CDLQRU/YCP+70v/ot5ZZvZFk0sawwgHU3Hx06+5QAKKJ3AMxFpRjybR3RylNRa3kJx
         bHIaepoRT6JLe2VgwVkscRBJ0gl56m9ZyCLAN99WWaR61T5AAS7g09DqpZ5mj3lF/a
         BjkWNMXpju5Qt+rn1DfWGhEOsy+HnzEXTOswermb/E2NYJstdwWSeUjIjxJ37/r6/z
         KliyqP+nD6qiQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4G5xBT08qlz9rxQ
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 13:13:52 +0200 (CEST)
To:     linux-wireless@vger.kernel.org
From:   Petrosilius <petrosilius@posteo.de>
Subject: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
Message-ID: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
Date:   Fri, 18 Jun 2021 11:13:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Lorenzo Bianconi,

we are running a set of R11e-2HPnD devices and having trouble getting
dynack working properly.
Setup:
* linux-5.4.123
* OpenWRT (current development branch) with wireless backports-5.10.34-1
* distance 2m between ap and sta
* Low ambient noise wifi environment
We experienced some non working dynack or low performance in the
connection due to too high calculated ackto's.

Here is a ath9k debug output example for a non working dynack @ 10Mhz BW:

Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500427] ath: phy0:
{48:8f:5a:3c:bb:03} tx sample 44905341 [dur 8720][h 29-t 30]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500437] ath: phy0:
ack_ts 44844835 st_ts 44905341 st_dur 8720 [17-29]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500445] ath: phy0:
ack_ts 44923425 st_ts 44905341 st_dur 8720 [18-29]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554642] ath: phy0: rx
sample 44977693 [h 18-t 20]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554701] ath: phy0:
{48:8f:5a:3c:bb:03} tx sample 44964984 [dur 6032][h 30-t 31]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554710] ath: phy0:
ack_ts 44923425 st_ts 44964984 st_dur 6032 [18-30]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554718] ath: phy0:
ack_ts 44977693 st_ts 44964984 st_dur 6032 [19-30]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577890] ath: phy0: rx
sample 45000939 [h 19-t 21]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577946] ath: phy0:
{48:8f:5a:3c:bb:03} tx sample 44998471 [dur 912][h 31-t 32]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577956] ath: phy0:
ack_ts 44977693 st_ts 44998471 st_dur 912 [19-31]
Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577964] ath: phy0:
ack_ts 45000939 st_ts 44998471 st_dur 912 [20-31]

THe above output is generated in dynack.c by

        ath_dbg(ath9k_hw_common(ah), DYNACK,
            "ack_ts %u st_ts %u st_dur %u [%u-%u]\n",
            ack_ts, st_ts->tstamp, st_ts->dur,
            da->ack_rbf.h_rb, da->st_rbf.h_rb);

The ackto is afterwards calculated by

        if (ack_ts > st_ts->tstamp + st_ts->dur) {
            ackto = ack_ts - st_ts->tstamp - st_ts->dur;

Filling in the values of the first sample:

(ack_ts > st_ts->tstamp + st_ts->dur) ?
(44844835 > 44905341+8720) ?
(44844835 > 44914061) ? ... not given

Therefore a new ackto is not calculated and i can also see that in the
ack_to file:

600 A
600 A
600 A
...

These look like the default values to me (and do not change), but
ath_dynack_get_max_to() should return 750 A for our 10MHz BW case - this
looks also suspecious to me.

For 5 MHz bandwidth there is a ackto calculated (~382 A, looks a bit too
high to me) but the performance is way below expectation (<1MBit)
For 20 MHz bandwidth there is a ackto calculated (51 A) and the
performance is fitting the expectation.
If you want to take a look at the logs for each of these cases for ap
and sta, you can download them here:
https://cloud.hs-augsburg.de/s/eworxkJoL6JXYzZ

Did anyone else experience such a behaviour on non 20MHz Channels or
does anyone have an idea on where this behaviour might originate from?
I am not experienced in the ath9k driver code, but a uneducated guess
might be that the ring buffer where the dynack algorithm is taking its
frame-samples from is not behaving as expected for the 5&10MHz case.

regards,
julian dorner

