Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8195BB4BC
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 01:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiIPXQB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiIPXPx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 19:15:53 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E8A59B9
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 16:15:49 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZKNQ-0006yn-0b;
        Sat, 17 Sep 2022 01:04:04 +0200
Date:   Sat, 17 Sep 2022 00:03:57 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 00/15] rt2x00: OpenWrt patches improving MT7620
Message-ID: <YyUA3Xbhe7/RSjGz@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Over the years we have been accumulating a number of patches improving
support for the IEEE 802.11bgn 2T2R wireless interface built into the
MediaTek MT7620 MIPS SoCs. Many of them have not been in shape for
being submitted to Linux and changes were needed to make checkpatch.pl
all happy. Now they look as good as it gets, given that most code deals
with undocumented registers and was adapted from the vendor driver.

Patch 1/1 also has been previously submitted and then (imho wrongly)
rejected, so I've included it in this series.

Alltogether rt2x00 now performs almost as good as the vendor driver,
see benchmark of HT20 client below:

Accepted connection from 192.168.5.133, port 37382
[  5] local 192.168.5.175 port 5201 connected to 192.168.5.133 port 37384
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  9.57 MBytes  80.3 Mbits/sec
[  5]   1.00-2.00   sec  9.68 MBytes  81.2 Mbits/sec
[  5]   2.00-3.00   sec  9.98 MBytes  83.7 Mbits/sec
[  5]   3.00-4.00   sec  9.72 MBytes  81.6 Mbits/sec
[  5]   4.00-5.00   sec  9.49 MBytes  79.6 Mbits/sec
[  5]   5.00-6.00   sec  9.88 MBytes  82.9 Mbits/sec
[  5]   6.00-7.00   sec  9.76 MBytes  81.8 Mbits/sec
[  5]   7.00-8.00   sec  9.96 MBytes  83.6 Mbits/sec
[  5]   8.00-9.00   sec  9.76 MBytes  81.9 Mbits/sec
[  5]   9.00-10.00  sec  9.86 MBytes  82.7 Mbits/sec
[  5]  10.00-10.03  sec   243 KBytes  78.4 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.03  sec  97.9 MBytes  81.9 Mbits/sec                  receiver

Accepted connection from 192.168.5.133, port 49588
[  5] local 192.168.5.175 port 5201 connected to 192.168.5.133 port 49598
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  12.7 MBytes   106 Mbits/sec    0    557 KBytes
[  5]   1.00-2.00   sec  11.1 MBytes  93.0 Mbits/sec    0   1020 KBytes
[  5]   2.00-3.00   sec  11.2 MBytes  94.4 Mbits/sec    0   1.57 MBytes
[  5]   3.00-4.00   sec  11.2 MBytes  94.4 Mbits/sec    0   1.58 MBytes
[  5]   4.00-5.00   sec  10.0 MBytes  83.9 Mbits/sec    0   1.58 MBytes
[  5]   5.00-6.00   sec  11.2 MBytes  94.4 Mbits/sec    0   1.58 MBytes
[  5]   6.00-7.00   sec  11.2 MBytes  94.4 Mbits/sec    0   1.58 MBytes
[  5]   7.00-8.00   sec  10.0 MBytes  83.9 Mbits/sec    0   1.58 MBytes
[  5]   8.00-9.00   sec  12.5 MBytes   105 Mbits/sec    0   1.58 MBytes
[  5]   9.00-10.00  sec  10.0 MBytes  83.9 Mbits/sec    0   1.58 MBytes
[  5]  10.00-10.03  sec  1.25 MBytes   381 Mbits/sec    0   1.58 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.03  sec   112 MBytes  94.1 Mbits/sec    0             sender


Daniel Golle (8):
  rt2x00: add support for external PA on MT7620
  rt2x00: don't run Rt5592 IQ calibration on MT7620
  rt2x00: move helper functions up in file
  rt2x00: fix HT20/HT40 bandwidth switch on MT7620
  rt2x00: set correct TX_SW_CFG1 MAC register for MT7620
  rt2x00: set VGC gain for both chains of MT7620
  rt2x00: set SoC wmac clock register
  rt2x00: correctly set BBP register 86 for MT7620

David Bauer (1):
  rt2x00: add throughput LED trigger

Tomislav Požega (6):
  rt2x00: define RF5592 in init_eeprom routine
  rt2x00: add RF self TXDC calibration for MT7620
  rt2x00: add r calibration for MT7620
  rt2x00: add RXDCOC calibration for MT7620
  rt2x00: add RXIQ calibration for MT7620
  rt2x00: add TX LOFT calibration for MT7620

 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 1705 ++++++++++++++++-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |   10 +
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |    5 +
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |   18 +
 6 files changed, 1787 insertions(+), 25 deletions(-)

-- 
2.37.3

