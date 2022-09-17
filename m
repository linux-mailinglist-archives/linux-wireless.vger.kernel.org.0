Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8171F5BB86C
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIQNRj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIQNRi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 09:17:38 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F3936DF1
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 06:17:36 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 22348 invoked from network); 17 Sep 2022 15:17:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663420654; bh=04ZjOl+BJ+JomNrUqfwG3BFMCECOiWOEzstg1ce02yY=;
          h=From:To:Cc:Subject;
          b=BtLAefq/cx0KPJUMeAQGE435Hikh7Q55Uzuw+5OEda7mjVoozaJJQTI8WwG7vhV2E
           j7q8Rbvtzg2dXZ9L50YJX2VUs0ZpD9P3KncT1eU6HejcIjVVZ+a5jF39klETLbTOko
           59H3CVEiof5iXiWloi8+k1pMIDRqW4Qluvi4sv4Q=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 15:17:34 +0200
Date:   Sat, 17 Sep 2022 15:17:33 +0200
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
Subject: Re: [PATCH 00/15] rt2x00: OpenWrt patches improving MT7620
Message-ID: <20220917131733.GM17901@wp.pl>
References: <YyUA3Xbhe7/RSjGz@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUA3Xbhe7/RSjGz@makrotopia.org>
X-WP-MailID: 5a9e261cb07d7cf2d1859a11e6c86d3a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [ocM0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:03:57AM +0100, Daniel Golle wrote:
> Over the years we have been accumulating a number of patches improving
> support for the IEEE 802.11bgn 2T2R wireless interface built into the
> MediaTek MT7620 MIPS SoCs. Many of them have not been in shape for
> being submitted to Linux and changes were needed to make checkpatch.pl
> all happy. Now they look as good as it gets, given that most code deals
> with undocumented registers and was adapted from the vendor driver.
> 
> Patch 1/1 also has been previously submitted and then (imho wrongly)
>rejected, so I've included it in this series.

In general this looks good. Some calibration functions are just too
big, but we can eventually take them and refactor in the tree.
Just please assure there are no compilation warnings and add
yours signed-off by to all patches.

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

My mt7620 AP benchmarking tests quite highly depended on client devices.
With clients like iwlwifi and ath it worked ok. I got pretty poor
results when connected rt2x00 client devices :-/

Regards
Stanislaw
