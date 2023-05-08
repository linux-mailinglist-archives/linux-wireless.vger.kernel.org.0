Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809B76FA36D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjEHJf1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 05:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjEHJfZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 05:35:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA52A13A
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 02:35:24 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pvxH8-0001Rg-M1; Mon, 08 May 2023 11:35:22 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pvxH8-0001Sj-39; Mon, 08 May 2023 11:35:22 +0200
Date:   Mon, 8 May 2023 11:35:22 +0200
From:   "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [bug report] wifi: rtw88: usb: fix priority queue to endpoint
 mapping
Message-ID: <20230508093522.GV29365@pengutronix.de>
References: <c3f70197-829d-48ed-ae15-66a9de80fa90@kili.mountain>
 <ab52f337fdf842499912458efab7704c@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab52f337fdf842499912458efab7704c@realtek.com>
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

Hi Ping-Ke,

On Mon, May 08, 2023 at 02:39:19AM +0000, Ping-Ke Shih wrote:
> Hi Sascha,
> 
> > -----Original Message-----
> > From: Dan Carpenter <dan.carpenter@linaro.org>
> > Sent: Thursday, May 4, 2023 6:56 PM
> > To: s.hauer@pengutronix.de
> > Cc: linux-wireless@vger.kernel.org
> > Subject: [bug report] wifi: rtw88: usb: fix priority queue to endpoint mapping
> > 
> > Hello Sascha Hauer,
> > 
> > The patch a6f187f92bcc: "wifi: rtw88: usb: fix priority queue to
> > endpoint mapping" from Apr 17, 2023, leads to the following Smatch
> > static checker warning:
> > 
> > drivers/net/wireless/realtek/rtw88/usb.c:219 rtw_usb_parse() warn: assigning (-22) to unsigned variable
> > 'rtwusb->qsel_to_ep[8]'
> 
> [...]
> 
> >     218         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID7] = dma_mapping_to_ep(rqpn->dma_map_vo);
> > --> 219         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID8] = -EINVAL;
> > 
> > Can't save negative error codes to a u8.
> > 
> 
> return type of dma_mapping_to_ep() is 'int' and it also possibly returns -EINVAL, and
> rtwusb->qsel_to_ep[] is used by qsel_to_ep() that also use 'int' as return type. 
> Therefore, I would like to change type of qsel_to_ep[] from 'u8' to 'int'. Does it
> work to you?

Fine with me. I acked your patch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
