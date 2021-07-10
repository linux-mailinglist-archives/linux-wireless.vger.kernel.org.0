Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB23C32EA
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jul 2021 06:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhGJFBi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jul 2021 01:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhGJFBi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jul 2021 01:01:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2345C0613DD
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jul 2021 21:58:53 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m254e-0007cX-ET; Sat, 10 Jul 2021 06:58:44 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1m254c-00048Z-Br; Sat, 10 Jul 2021 06:58:42 +0200
Date:   Sat, 10 Jul 2021 06:58:42 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 07/24] rtw89: add MAC files
Message-ID: <20210710045842.ykovwmod7hnsbvnj@pengutronix.de>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-8-pkshih@realtek.com>
 <20210709173817.GB2099@pengutronix.de>
 <310161353e627903f2a828ac28c69ae49b81568b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <310161353e627903f2a828ac28c69ae49b81568b.camel@sipsolutions.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:52:25 up 219 days, 18:58, 36 users,  load average: 0.05, 0.05,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 09, 2021 at 08:16:50PM +0200, Johannes Berg wrote:
> On Fri, 2021-07-09 at 19:38 +0200, Oleksij Rempel wrote:
> > On Fri, Jun 18, 2021 at 02:46:08PM +0800, Ping-Ke Shih wrote:
> > 
> > > [thousands of quoted lines]
> 
> FWIW, it would really help if you were to actually quote only the bits
> you're replying to...

ack. I was thinking about providing patch as response to remove only
unused code. This patch set is 80K lines and it is not possible to review it
just in between the work and children within my hobby time.

@Ping-Ke, if you wont to speed up the review, I would recommend your
company to contract me or someone else to do it in the main working
time.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
