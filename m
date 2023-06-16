Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70F733128
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjFPM00 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFPM0Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 08:26:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5937230DE
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 05:26:24 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qA8Wv-0005mB-IE; Fri, 16 Jun 2023 14:26:17 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qA8Wq-0000ek-NG; Fri, 16 Jun 2023 14:26:12 +0200
Date:   Fri, 16 Jun 2023 14:26:12 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     petter@technux.se
Cc:     pkshih@realtek.com, linux-wireless@vger.kernel.org,
        Larry.Finger@lwfinger.net, andreas@fatal.se, iam@valdikss.org.ru,
        kernel@pengutronix.de, kvalo@kernel.org, linux@ulli-kroll.de,
        petter.mabacker@esab.se
Subject: Re: rtw8822cu (LM842) stalls when running HW offload scan
Message-ID: <20230616122612.GL18491@pengutronix.de>
References: <20230612133023.321060-1-petter@technux.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612133023.321060-1-petter@technux.se>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 12, 2023 at 03:30:23PM +0200, petter@technux.se wrote:
> Some time ago https://bugzilla.kernel.org/show_bug.cgi?id=217034 was
> created. From the beginning it was just about some error printouts.
> Then Andreas (who created the bug report) mentioned that it seems to
> work worse after bumping the firmware to > 9.9.10. After some fixes
> from Sascha the error printouts dissappeared. But when I also started
> to run this using firmware > 9.9.10 I also got problems. On my i.MX8
> and RPi4 board it works fine, but on some of my less powerful boards
> such as and older RPi and my i.MX6 SoloX board, it always fails using
> 9.9.10 firmware. After some digging in the git log, I discovered
> that HW scan offload was introduced in a later firmware. So when I
> disable HW offload scan it seems to work again on all my boards. But
> still I want to understand why the HW offload scan don't work for
> me.
> 
> Like described in the bug report I get below when running on latest
> 6.4 mainline with all relevant patches around rtw88 applied.

I can't reproduce this here. I am currently running v6.4-rc3 plus:

wifi: rtw88: usb: silence log flooding error message

I tested on a i.MX6S (not SoloX) board with Firmware 9.9.14.

A "nmcli dev wifi rescan" works just fine and the link also continues to
work.

I verified that FW_FEATURE_SCAN_OFFLOAD is set and used in the driver,
also that it's not set in Firmware 9.9.9. I also tried to put some
load on the link by running iperf3, still no difference.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
