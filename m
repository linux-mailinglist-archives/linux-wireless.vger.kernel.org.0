Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D19686114
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 09:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBAIBG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 03:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjBAIBF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 03:01:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB75953558
        for <linux-wireless@vger.kernel.org>; Wed,  1 Feb 2023 00:01:01 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pN83A-0000Xj-1T; Wed, 01 Feb 2023 09:01:00 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pN838-0000ua-1j; Wed, 01 Feb 2023 09:00:58 +0100
Date:   Wed, 1 Feb 2023 09:00:58 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Subject: Re: rtw88: rtw8822cu (LM842) stalls completely, needs replugging to
 wake up.
Message-ID: <20230201080058.GH13319@pengutronix.de>
References: <20230131114611.sm6m3fc4g5n7lhqc@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131114611.sm6m3fc4g5n7lhqc@fatal.se>
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

On Tue, Jan 31, 2023 at 12:46:11PM +0100, Andreas Henriksson wrote:
> Hello,
> 
> I've tested the rtw88 usb driver additions that was merged in 6.2-rc1 on an LM842 dongle (rtw8822cu)
> and would like to ask if anyone else has noticed the problems I'm seeing.
> After downloading a certain amount of data the traffic just completely stalls. No error messages
> (not even when using rtw88_core with debug_mask=0xff).
> 
> My dongle:
> https://www.lm-technologies.com/product/wifi-802-11ac-bluetooth-5-0-2t2r-usb-combi-adapter-lm842/

That's the same dongle as I have. I didn't notice any problems myself,
but I'll try to reproduce next week.

> [  134.250277] rtw_8822cu 1-1:1.2: Firmware version 9.9.13, H2C version 15
> [  134.310449] rtw_8822cu 1-1:1.2: WOW Firmware version 9.9.4, H2C version 15

I had some hope I could tell you to use the latest firmware files, but
these are the newest already :-/

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
