Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1500E6DDB25
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 14:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDKMso (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 08:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDKMsk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 08:48:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C03598
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 05:48:39 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pmDQM-0002Ed-7L; Tue, 11 Apr 2023 14:48:38 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pmDQK-0000dF-Ke; Tue, 11 Apr 2023 14:48:36 +0200
Date:   Tue, 11 Apr 2023 14:48:36 +0200
From:   "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
To:     "petter@technux.se" <petter@technux.se>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "pkshih@realtek.com" <pkshih@realtek.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
Subject: Re: rtw88: rtw8822cu (LM842) -> failed to get tx report from firmware
Message-ID: <20230411124836.GM19113@pengutronix.de>
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 06, 2023 at 10:41:20AM +0000, petter@technux.se wrote:
> Hi,
> 
> I have seen a very similar issue as Andreas. It was found when
> streaming a mender file (using mender install <url> from my arm
> device. But I have also managed to reproduce a similar issue by
> flooding the interface using iperf. 
> 
> on target:
> $ sudo iperf -s -u
> 
> On host:
> $ iperf -c <ip> -u -b 200M -t 300
> 
> Then it will almost instantly get problems causing the lm842 dongle to stop working.

I just gave it a try. This works here.

Which Kernel version do you use? Do you have:

709f329ea51c2 wifi: rtw88: usb: drop now unnecessary URB size check
b30dbecf891fb wifi: rtw88: usb: send Zero length packets if necessary
3bcc9db63336e wifi: rtw88: usb: Set qsel correctly

They are contained in v6.2.2 and v6.3-rc1, but not in v6.2.

Also you need these, but you already mentioned you have them:

https://patchwork.kernel.org/project/linux-wireless/patch/20230404072508.578056-2-s.hauer@pengutronix.de/

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
