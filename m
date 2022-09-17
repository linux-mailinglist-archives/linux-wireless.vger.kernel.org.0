Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CAB5BB9D7
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIQSNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 14:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIQSNo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 14:13:44 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA372B63F
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 11:13:41 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 1985 invoked from network); 17 Sep 2022 20:13:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663438418; bh=uEaloLaNcTQJof9iu0sEtPcsyEB7lyHi9OFgZXGyl3g=;
          h=From:To:Cc:Subject;
          b=A5FTSlD1YoHejoJTDMTGVSKZAnoVbomST4HT2xTHq6nwoby9XmB02A3UohWCYZFT0
           15AbaILoUl5pey5DFcoaFSSpRBB/svrr1l7pteAqdBKV4g7VGg+xlUaBIIf6x5RR0j
           DkWokQNNPqXx63J2sgo8C1nQH248XSu6m57Bv4qQ=
Received: from 89-64-13-65.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.65])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 20:13:38 +0200
Date:   Sat, 17 Sep 2022 20:13:37 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 00/16] rt2x00: OpenWrt patches improving MT7620
Message-ID: <20220917181337.GA19997@wp.pl>
References: <cover.1663431288.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663431288.git.daniel@makrotopia.org>
X-WP-MailID: e8c718209899185a36d100fc4f3f384c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0ZP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 05:43:44PM +0100, Daniel Golle wrote:
> Over the years we have been accumulating a number of patches improving
> support for the IEEE 802.11bgn 2T2R wireless interface built into the
> MediaTek MT7620 MIPS SoCs. Many of them have not been in shape for
> being submitted to Linux and changes were needed to make checkpatch.pl
> all happy. Now they look as good as it gets, given that most code deals
> with undocumented registers and was adapted from the vendor driver.
> 
> Patch 1/1 also has been previously submitted and then (imho wrongly)
> rejected, so I've included it in this series.
> 
> Alltogether rt2x00 now performs almost as good as the vendor driver,
> see benchmark of HT20 client below:
> 
> Accepted connection from 192.168.5.133, port 37382
> [  5] local 192.168.5.175 port 5201 connected to 192.168.5.133 port 37384
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  9.57 MBytes  80.3 Mbits/sec
> [  5]   1.00-2.00   sec  9.68 MBytes  81.2 Mbits/sec
> [  5]   2.00-3.00   sec  9.98 MBytes  83.7 Mbits/sec
> [  5]   3.00-4.00   sec  9.72 MBytes  81.6 Mbits/sec
> [  5]   4.00-5.00   sec  9.49 MBytes  79.6 Mbits/sec
> [  5]   5.00-6.00   sec  9.88 MBytes  82.9 Mbits/sec
> [  5]   6.00-7.00   sec  9.76 MBytes  81.8 Mbits/sec
> [  5]   7.00-8.00   sec  9.96 MBytes  83.6 Mbits/sec
> [  5]   8.00-9.00   sec  9.76 MBytes  81.9 Mbits/sec
> [  5]   9.00-10.00  sec  9.86 MBytes  82.7 Mbits/sec
> [  5]  10.00-10.03  sec   243 KBytes  78.4 Mbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.03  sec  97.9 MBytes  81.9 Mbits/sec                  receiver
> 
> Accepted connection from 192.168.5.133, port 49588
> [  5] local 192.168.5.175 port 5201 connected to 192.168.5.133 port 49598
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  12.7 MBytes   106 Mbits/sec    0    557 KBytes
> [  5]   1.00-2.00   sec  11.1 MBytes  93.0 Mbits/sec    0   1020 KBytes
> [  5]   2.00-3.00   sec  11.2 MBytes  94.4 Mbits/sec    0   1.57 MBytes
> [  5]   3.00-4.00   sec  11.2 MBytes  94.4 Mbits/sec    0   1.58 MBytes
> [  5]   4.00-5.00   sec  10.0 MBytes  83.9 Mbits/sec    0   1.58 MBytes
> [  5]   5.00-6.00   sec  11.2 MBytes  94.4 Mbits/sec    0   1.58 MBytes
> [  5]   6.00-7.00   sec  11.2 MBytes  94.4 Mbits/sec    0   1.58 MBytes
> [  5]   7.00-8.00   sec  10.0 MBytes  83.9 Mbits/sec    0   1.58 MBytes
> [  5]   8.00-9.00   sec  12.5 MBytes   105 Mbits/sec    0   1.58 MBytes
> [  5]   9.00-10.00  sec  10.0 MBytes  83.9 Mbits/sec    0   1.58 MBytes
> [  5]  10.00-10.03  sec  1.25 MBytes   381 Mbits/sec    0   1.58 MBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.03  sec   112 MBytes  94.1 Mbits/sec    0             sender
> 
> v2: comments from Stanislaw Gruszka have been addressed.

For the series:
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
