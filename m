Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255C56AB987
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Mar 2023 10:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCFJTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Mar 2023 04:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCFJS7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Mar 2023 04:18:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273068A52
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 01:18:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pZ6zX-0008Vs-DT; Mon, 06 Mar 2023 10:18:47 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pZ6zV-0001BK-Q2; Mon, 06 Mar 2023 10:18:45 +0100
Date:   Mon, 6 Mar 2023 10:18:45 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Performance of rtw88_8822bu
Message-ID: <20230306091845.GC27249@pengutronix.de>
References: <93d565e1-3a23-69f3-bedd-b71eb601bceb@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93d565e1-3a23-69f3-bedd-b71eb601bceb@lwfinger.net>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

On Sat, Mar 04, 2023 at 08:52:26PM -0600, Larry Finger wrote:
> Sascha an Ping-Ke,
> 
> I have been testing the RTW8822BU driver found in my rtw88 GitHub repo. This
> code matches the code found in wireless-next. I created 9 files of 5.8 GiB
> each and used a for loop to copy them from the test computer to/from my
> server. The wireless connection is on the 5 GHz band (channel 153) connected
> to an ax1500 Wifi 6 router, which in turn is connected to the server via a
> 1G ethernet cable. The connection has not crashed, but I see strange
> behavior.

What chipset are you using? Is it a RTL8822bu or some other chipset
reported by the driver?

> 
> With both TX and RX, the rate is high at 13.5 MiB/s for RX and 11.1 MiB/s
> for TX for about 1/3 of the time, but then the driver reports "timed out to
> flush queue 3" and the rate drops to 3-5 MiB/s for RX and 2-3 MiB/s for TX.
> These low rates are in effect for 2/3 of the time. The 5G bands are
> relatively unused in my house, thus I do not suspect interference.

I've received a very similar report this weekend. About 3-4 messages per
second, "timed out to flush queue 3", but driver continues to work.
I've also seen it this morning by accident and once again while writing
this mail. This was on a RTL8821CU.

So far I have no idea what the problem might be.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
