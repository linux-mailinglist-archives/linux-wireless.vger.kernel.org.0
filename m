Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3F1D6198
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgEPOiL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 10:38:11 -0400
Received: from mail.kevlo.org ([220.134.220.36]:60397 "EHLO ns.kevlo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgEPOiL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 10:38:11 -0400
Received: from ns.kevlo.org (localhost [127.0.0.1])
        by ns.kevlo.org (8.15.2/8.15.2) with ESMTPS id 04GEIN8V009604
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 16 May 2020 22:18:23 +0800 (CST)
        (envelope-from kevlo@ns.kevlo.org)
Received: (from kevlo@localhost)
        by ns.kevlo.org (8.15.2/8.15.2/Submit) id 04GEINcF009603;
        Sat, 16 May 2020 22:18:23 +0800 (CST)
        (envelope-from kevlo)
Date:   Sat, 16 May 2020 22:18:22 +0800
From:   Kevin Lo <kevlo@kevlo.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtw88: no need to set registers for SDIO
Message-ID: <20200516141822.GA9585@ns.kevlo.org>
References: <20200515061153.GA15714@ns.kevlo.org>
 <9ba0e2a24a82436b9fe2595d86afccbc@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba0e2a24a82436b9fe2595d86afccbc@realtek.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 15, 2020 at 06:16:55AM +0000, Tony Chuang wrote:
> 
> Kevin Lo <kevlo@kevlo.org> writes:
> > Subject: [PATCH] rtw88: no need to set registers for SDIO
> > 
> > There's no need to set SDIO related registers when powering up/down the chip.
> > 
> > Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> > ---
> > diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > index b517af417e0e..5e0b7999bc8a 100644
> > --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > @@ -2092,16 +2092,6 @@ static const struct rtw_pwr_seq_cmd
> > trans_carddis_to_cardemu_8723d[] = {
> >  	 RTW_PWR_INTF_ALL_MSK,
> >  	 RTW_PWR_ADDR_MAC,
> >  	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(7), 0},
> > -	{0x0086,
> > -	 RTW_PWR_CUT_ALL_MSK,
> > -	 RTW_PWR_INTF_SDIO_MSK,
> > -	 RTW_PWR_ADDR_SDIO,
> > -	 RTW_PWR_CMD_WRITE, BIT(0), 0},
> > -	{0x0086,
> > -	 RTW_PWR_CUT_ALL_MSK,
> > -	 RTW_PWR_INTF_SDIO_MSK,
> > -	 RTW_PWR_ADDR_SDIO,
> > -	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
> >  	{0x004A,
> >  	 RTW_PWR_CUT_ALL_MSK,
> >  	 RTW_PWR_INTF_USB_MSK,
> 
> I don't think we should remove SDIO part in the power sequence.
> The power sequence parse will recognize the HCI interface. So the
> SDIO settings will not be applied at all. We can keep them here until
> the SDIO module is added and supported.

Well, I thought only usb devices will be supported by rtw88.
I'm happy to see rtw88 SDIO support, thanks.

> Yen-Hsuan
