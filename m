Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A126FB1F7
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 15:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjEHNqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 09:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjEHNqa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 09:46:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2788935B3B
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 06:46:29 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pw1C7-0002EE-Jk; Mon, 08 May 2023 15:46:27 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pw1C6-0006W1-5l; Mon, 08 May 2023 15:46:26 +0200
Date:   Mon, 8 May 2023 15:46:26 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Petter Mabacker <petter@technux.se>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        tony0620emma@gmail.com
Subject: Re: rtw88: rtw8822cu (LM842) -> failed to get tx report from firmware
Message-ID: <20230508134626.GZ29365@pengutronix.de>
References: <20230411124836.GM19113@pengutronix.de>
 <20230508132901.44137-1-petter@technux.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508132901.44137-1-petter@technux.se>
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

On Mon, May 08, 2023 at 03:29:01PM +0200, Petter Mabacker wrote:
> I'm working with a Linux 6.1 based track, but with all the mentioned bug fixes cherry-picked to that track. They have all made the LM842 a lot more stabile, but the issue I see with "tx report failed" is currently blocking me from using the LM842, since the mender upgrade is a crucial part for my use-case.
> 
> I have been trying to find a better way to reproduce the issue, without any success so far. For me it takes just 10-30 sec with above mention flooding using iperf to at least trigger a similar case.
> 
> ...
> [  671.908527] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
> [  671.914632] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
> [  671.920750] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
> [  671.926792] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
> [  671.932924] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow

I am still not sure what to do about this. It happens with high RX load.
One way would be to just drop the log level of this message.
Otherwise this message should be harmless.

> 
> [  694.709045] rtw_8822cu 1-1:1.2: failed to get tx report from firmware
> 
> [  710.169496] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
> [  717.701235] rtw_8822cu 1-1:1.2: failed to send h2c command
> 
> I can also mention that I'm running this in a i.MX6 SoloX based board.
> 
> I will let you guys know if I find a better way to reproduce the
> issue. But if you have any good ideas what above error (that brings
> down the entire interface) really mean (for example does it indicate
> kernel or firmware issue), please feel free to share some information
> about it and it might help me in troubleshooting the issue further.

Please try reproducing this with a recent mainline vanilla kernel. It
shouldn't be too hard to bring up a i.MX6 board with a vanilla kernel.

Regards,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
