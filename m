Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C687123BD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 11:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbjEZJei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243249AbjEZJeP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 05:34:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E9110F3
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 02:33:39 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q2Tp5-0007HF-QH; Fri, 26 May 2023 11:33:23 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q2Tp1-0007tg-Pm; Fri, 26 May 2023 11:33:19 +0200
Date:   Fri, 26 May 2023 11:33:19 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Hans Ulli Kroll <linux@ulli-kroll.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Tim K <tpkuester@gmail.com>, "Alex G ." <mr.nuke.me@gmail.com>,
        Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        ValdikSS <iam@valdikss.org.ru>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "petter@technux.se" <petter@technux.se>
Subject: Re: [PATCH] wifi: rtw88: usb: silence log flooding error message
Message-ID: <20230526093319.GR17518@pengutronix.de>
References: <20230524103934.1019096-1-s.hauer@pengutronix.de>
 <290b05447cc542a9b35c25ff89ba8ff3@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290b05447cc542a9b35c25ff89ba8ff3@realtek.com>
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

On Thu, May 25, 2023 at 12:45:23AM +0000, Ping-Ke Shih wrote:
> 
> 
> > -----Original Message-----
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Wednesday, May 24, 2023 6:40 PM
> > To: linux-wireless <linux-wireless@vger.kernel.org>
> > Cc: Hans Ulli Kroll <linux@ulli-kroll.de>; Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih
> > <pkshih@realtek.com>; Tim K <tpkuester@gmail.com>; Alex G . <mr.nuke.me@gmail.com>; Nick Morrow
> > <morrownr@gmail.com>; Viktor Petrenko <g0000ga@gmail.com>; Andreas Henriksson <andreas@fatal.se>;
> > ValdikSS <iam@valdikss.org.ru>; kernel@pengutronix.de; petter@technux.se; Sascha Hauer
> > <s.hauer@pengutronix.de>
> > Subject: [PATCH] wifi: rtw88: usb: silence log flooding error message
> > 
> > When receiving more rx packets than the kernel can handle the driver
> > drops the packets and issues an error message.
> 
> The workqueue rtw88_usb is using is:
> 
> 	rtwusb->rxwq = create_singlethread_workqueue("rtw88_usb: rx wq");
> 
> Have you tried workqueue with flags WQ_UNBOUND and WQ_HIGHPRI? Like,
> 
> 	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
> or
> 	rtwusb->rxwq = alloc_ordered_workqueue("rtw88_usb: rx wq", WQ_HIGHPRI);
> 
> Then, driver get more time to process RX, so it could ease flooding messages. 

No, I haven't tried this. Regardless of that, I think it still makes
sense to rate limit the messages. There will always be a slower system
that can't cope with the number of packets even with a higher priority
workqueue.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
