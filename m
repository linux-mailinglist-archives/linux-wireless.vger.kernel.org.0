Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F395737CC5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFUHs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 03:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjFUHs5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 03:48:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90348170C
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 00:48:55 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qBsa7-000569-2S; Wed, 21 Jun 2023 09:48:47 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qBsa5-0003T6-Oy; Wed, 21 Jun 2023 09:48:45 +0200
Date:   Wed, 21 Jun 2023 09:48:45 +0200
From:   "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/3] [v3] wifi: rtw88: remove unused USB bulkout size set
Message-ID: <20230621074845.GO18491@pengutronix.de>
References: <20230616085917.60662-1-dmantipov@yandex.ru>
 <20230616085917.60662-3-dmantipov@yandex.ru>
 <5ecd668942f44275953081ae63acc57c@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecd668942f44275953081ae63acc57c@realtek.com>
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

On Tue, Jun 20, 2023 at 03:49:19AM +0000, Ping-Ke Shih wrote:
> // add rtw88 USB author Sascha for his comments.
> 
> > -----Original Message-----
> > From: Dmitry Antipov <dmantipov@yandex.ru>
> > Sent: Friday, June 16, 2023 4:59 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> > Subject: [PATCH 3/3] [v3] wifi: rtw88: remove unused USB bulkout size set
> > 
> > Drop no longer used 'bulkout_size' of 'struct rtw_usb'
> > and related macros from usb.h, but preserve sanity check
> > in 'rtw_usb_parse()'. This follows commit 462c8db6a011
> > ("wifi: rtw88: usb: drop now unnecessary URB size check").
> > 
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> > ---
> >  drivers/net/wireless/realtek/rtw88/usb.c | 5 -----
> >  drivers/net/wireless/realtek/rtw88/usb.h | 5 -----
> >  2 files changed, 10 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> > index 6862338b1d51..40e614f58349 100644
> > --- a/drivers/net/wireless/realtek/rtw88/usb.c
> > +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> > @@ -186,13 +186,8 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
> >         switch (usbd->speed) {
> >         case USB_SPEED_LOW:
> >         case USB_SPEED_FULL:
> > -               rtwusb->bulkout_size = RTW_USB_FULL_SPEED_BULK_SIZE;
> > -               break;
> >         case USB_SPEED_HIGH:
> > -               rtwusb->bulkout_size = RTW_USB_HIGH_SPEED_BULK_SIZE;
> > -               break;
> >         case USB_SPEED_SUPER:
> > -               rtwusb->bulkout_size = RTW_USB_SUPER_SPEED_BULK_SIZE;
> >                 break;
> >         default:
> >                 rtw_err(rtwdev, "failed to detect usb speed\n");
> 
> If we decide to remove rtwusb->bulkout_size, I suggest to remove whole
> switch..case chunk.

I didn't realize rtwusb->bulkout_size becomes unused with 462c8db6a011.
Removing this field makes sense and in that case: +1 for removing the
switch/case as well.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
