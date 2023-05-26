Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0D712460
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbjEZKRt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 06:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbjEZKRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 06:17:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E23A9
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 03:17:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q2UVv-0005lp-2T; Fri, 26 May 2023 12:17:39 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q2UVs-0001xx-Mr; Fri, 26 May 2023 12:17:36 +0200
Date:   Fri, 26 May 2023 12:17:36 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Pkshih <pkshih@realtek.com>, Hans Ulli Kroll <linux@ulli-kroll.de>,
        ValdikSS <iam@valdikss.org.ru>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Tim K <tpkuester@gmail.com>, Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        "Alex G ." <mr.nuke.me@gmail.com>, kernel@pengutronix.de,
        petter@technux.se, Andreas Henriksson <andreas@fatal.se>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] wifi: rtw88: usb: silence log flooding error message
Message-ID: <20230526101736.GS17518@pengutronix.de>
References: <20230524103934.1019096-1-s.hauer@pengutronix.de>
 <ZG32XKBsAub+Y+bO@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG32XKBsAub+Y+bO@corigine.com>
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

On Wed, May 24, 2023 at 01:34:52PM +0200, Simon Horman wrote:
> On Wed, May 24, 2023 at 12:39:34PM +0200, Sascha Hauer wrote:
> > When receiving more rx packets than the kernel can handle the driver
> > drops the packets and issues an error message. This is bad for two
> > reasons. The logs are flooded with myriads of messages, but then time
> > consumed for printing messages in that critical code path brings down
> > the device. After some time of excessive rx load the driver responds
> > with:
> > 
> > rtw_8822cu 1-1:1.2: failed to get tx report from firmware
> > rtw_8822cu 1-1:1.2: firmware failed to report density after scan
> > rtw_8822cu 1-1:1.2: firmware failed to report density after scan
> > 
> > The device stops working until being replugged.
> > 
> > Fix this by lowering the priority to debug level and also by
> > ratelimiting it.
> > 
> > Fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/net/wireless/realtek/rtw88/usb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> > index 44a5fafb99055..976eafa739a2d 100644
> > --- a/drivers/net/wireless/realtek/rtw88/usb.c
> > +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> > @@ -535,7 +535,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
> >  		}
> >  
> >  		if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
> > -			rtw_err(rtwdev, "failed to get rx_queue, overflow\n");
> > +			dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
> 
> This is certainly an improvement. But as I understand things
> it is still somewhat verbose if the condition persists.
> Did you consider dev_dbg_once()?

My rationale was that dev_dbg() is normally disabled anyway. With
CONFIG_DYNAMIC_PRINTK you would still have fine grained control if you
want to see this message or not.

Personally I don't care that much, I would switch to dev_dbg_once() if
that's preferred.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
