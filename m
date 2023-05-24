Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B289870F478
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjEXKpP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 06:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjEXKpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 06:45:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F270497
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 03:45:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q1lzS-0007wV-Fm; Wed, 24 May 2023 12:45:10 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q1lzS-00078n-9p; Wed, 24 May 2023 12:45:10 +0200
Date:   Wed, 24 May 2023 12:45:10 +0200
From:   "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
To:     "petter@technux.se" <petter@technux.se>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "pkshih@realtek.com" <pkshih@realtek.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
Subject: Re: rtw88: rtw8822cu (LM842) -> failed to get tx report from firmware
Message-ID: <20230524104510.GV15436@pengutronix.de>
References: <188007.70407276-sendEmail@petterwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <188007.70407276-sendEmail@petterwork>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Petter,

On Thu, Apr 06, 2023 at 10:41:20AM +0000, petter@technux.se wrote:
> Hi,
> 
> I have seen a very similar issue as Andreas. It was found when streaming a mender file (using mender install <url> from my arm device. But I have also managed to reproduce a similar issue by flooding the interface using iperf. 
> 
> on target:
> $ sudo iperf -s -u
> 
> On host:
> $ iperf -c <ip> -u -b 200M -t 300
> 
> Then it will almost instantly get problems causing the lm842 dongle to stop working.

I could finally reproduce this problem by placing an access point close
enough to my device. Only then the incoming packet rate is high enough
that the "failed to get rx_queue, overflow" message triggers.

In my case the time it takes to print this message many times is enough
to confuse the device so that it finally responds with:

[  126.449305] rtw_8822cu 1-1:1.2: failed to get tx report from firmware
[  142.081419] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[  175.929407] rtw_8822cu 1-1:1.2: firmware failed to report density after scan

I just sent a patch printing the message with dev_dbg_ratelimited
instead which fixes that problem for me, you're on Cc.

It likely won't fix Andreas' problem though, as I don't see this message
in his bug report.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
