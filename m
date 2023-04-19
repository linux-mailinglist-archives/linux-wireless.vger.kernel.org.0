Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1800D6E73E2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 09:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjDSHWG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 03:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjDSHWF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 03:22:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1E46B1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 00:22:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pp28e-0007rT-V9; Wed, 19 Apr 2023 09:22:00 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pp28b-0003lz-A2; Wed, 19 Apr 2023 09:21:57 +0200
Date:   Wed, 19 Apr 2023 09:21:57 +0200
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
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific
 rtw8821c variants
Message-ID: <20230419072157.GR13543@pengutronix.de>
References: <20230417140358.2240429-1-s.hauer@pengutronix.de>
 <20230417140358.2240429-4-s.hauer@pengutronix.de>
 <abc17f5fe6c944a5a1361d4d76817a08@realtek.com>
 <20230418085806.GO13543@pengutronix.de>
 <3bad94b1b1914b30a38e8325e2593aeb@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bad94b1b1914b30a38e8325e2593aeb@realtek.com>
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

On Wed, Apr 19, 2023 at 12:20:33AM +0000, Ping-Ke Shih wrote:
> 
> 
> > -----Original Message-----
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Tuesday, April 18, 2023 4:58 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: linux-wireless <linux-wireless@vger.kernel.org>; Hans Ulli Kroll <linux@ulli-kroll.de>; Larry Finger
> > <Larry.Finger@lwfinger.net>; Tim K <tpkuester@gmail.com>; Alex G . <mr.nuke.me@gmail.com>; Nick Morrow
> > <morrownr@gmail.com>; Viktor Petrenko <g0000ga@gmail.com>; Andreas Henriksson <andreas@fatal.se>;
> > ValdikSS <iam@valdikss.org.ru>; kernel@pengutronix.de
> > Subject: Re: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific rtw8821c variants
> > 
> > On Tue, Apr 18, 2023 at 12:36:31AM +0000, Ping-Ke Shih wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Sent: Monday, April 17, 2023 10:04 PM
> > > > To: linux-wireless <linux-wireless@vger.kernel.org>
> > > > Cc: Hans Ulli Kroll <linux@ulli-kroll.de>; Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih
> > > > <pkshih@realtek.com>; Tim K <tpkuester@gmail.com>; Alex G . <mr.nuke.me@gmail.com>; Nick Morrow
> > > > <morrownr@gmail.com>; Viktor Petrenko <g0000ga@gmail.com>; Andreas Henriksson <andreas@fatal.se>;
> > > > ValdikSS <iam@valdikss.org.ru>; kernel@pengutronix.de; Sascha Hauer <s.hauer@pengutronix.de>
> > > > Subject: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific rtw8821c variants
> > > >
> > > > According to the vendor driver the pkg_type has to be set to '1'
> > > > for some rtw8821c variants. As the pkg_type has been hardcoded to
> > > > '0', add a field for it in struct rtw_hal and set this correctly
> > > > in the rtw8821c part.
> > > > With this parsing of a rtw_table is influenced and check_positive()
> > > > in phy.c returns true for some cases here. The same is done in the
> > > > vendor driver. However, this has no visible effect on the driver
> > > > here.
> > >
> > > I agree this patch, but still want to know more about the meaning of
> > > "...no visible effect...". Do you mean your USB device works well with/without
> > > this patch? or, IO is absolutely the same when loading parameters with
> > > check_positive()?
> > 
> > Yes, it works with and without this patch. With this patch
> > check_positive() returns true in some cases whereas without this patch
> > check_positive always returns false.
> > I don't know at all what effect this change could have, maybe I just
> > need the right test case to verify it really makes a change.
> > 
> > I just realized that something like the below is missing, as the
> > cond.rfe part needs the raw rfe value from fuses >> 3.
> > 
> > Maybe we just take 1/4 and 2/4 and drop the others. I am running out of
> > time for further debugging RTW8821C which is a chip our customer isn't
> > interested in.
> > 
> 
> I think we can take all patches, because they go forward to correct direction,
> and other flaws can be fixed after people can really get that kind of modules.

Fine with me, thanks.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
