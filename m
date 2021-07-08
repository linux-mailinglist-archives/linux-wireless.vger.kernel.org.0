Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE293BF507
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jul 2021 07:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhGHF0r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jul 2021 01:26:47 -0400
Received: from mail.thinkpuffy.com ([198.13.45.55]:43435 "EHLO
        mail.thinkpuffy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhGHF0r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jul 2021 01:26:47 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 01:26:47 EDT
Received: from localhost (www.thinkpuffy.com [local])
        by www.thinkpuffy.com (OpenSMTPD) with ESMTPA id 10ce0ac7;
        Thu, 8 Jul 2021 14:17:24 +0900 (JST)
Date:   Thu, 8 Jul 2021 14:17:24 +0900
From:   Doug Brewer <brewer.doug@gmail.com>
To:     Pkshih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: rtw89: product id 0xa85a support on Linux?
Message-ID: <20210708051724.GA70093@www.com>
References: <20210704143510.GA5787@www.com>
 <8e844938463c470d9669247227db9c30@realtek.com>
 <CAG0V13RrjFP=+X32G+3ogo2LJbwcrZyoDeZ7LLBbVfR1JEWUyg@mail.gmail.com>
 <6b0788a110ef6382c803ccf18b27116f4634f3ba.camel@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b0788a110ef6382c803ccf18b27116f4634f3ba.camel@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 06, 2021 at 03:10:34AM +0000, Pkshih wrote:
> On Tue, 2021-07-06 at 08:56 +0800, Doug Brewer wrote:
> > On Mon, Jul 5, 2021 at 9:42 AM Pkshih <pkshih@realtek.com> wrote:
> > > > -----Original Message-----
> > > > From: Doug Brewer [mailto:brewerdoug@gmail.com]
> > > > Sent: Sunday, July 04, 2021 10:35 PM
> > > > To: linux-wireless@vger.kernel.org
> > > > Subject: rtw89: product id 0xa85a support on Linux?
> > > > 
> > > > Hello,
> > > > 
> > > > The HP Laptop 15s-eq2028ur have a Realtek 802.11ax device. lspci
> > > -n shows
> > > > 
> > > > 01:00.0 Network controller [0280]: Realtek Semiconductor Co.,
> > > Ltd. Device [10ec:
> > > > a85a]
> > > > 
> > > > I tried pkshih's rtw89 patchsets [1] and added PID to
> > > rtw89_pci_id_table.
> > > > Scanning works but cannot connect to access points.
> > > > dmesg shows like (hiding MAC address):
> > > > 
> > > > rtw89_pci 0000:01:00.0: Firmware version 0.13.8.0, cmd version 0,
> > > type 1
> > > > rtw89_pci 0000:01:00.0: Firmware version 0.13.8.0, cmd version 0,
> > > type 3
> > > > rtw89_pci 0000:01:00.0: chip rfe_type is 1
> > > > wlan0: authenticate with xx:xx:xx:xx:xx:xx
> > > > wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
> > > > wlan0: authenticated
> > > > wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
> > > > wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=0x411 status=0
> > > aid=1)
> > > > wlan0: associated
> > > > rtw89_pci 0000:01:00.0: c2h reg timeout
> > > > rtw89_pci 0000:01:00.0: FW does not process h2c registers
> > > > rtw89_pci 0000:01:00.0: timed out to flush queues
> > > > 
> > > > rtw89 will be the driver to support this wifi model? Thanks.
> > > > 
> > > 
> > > The ID 0xa85a is a variant of 8852AE, and rtw89 will support it
> > > later.
> > > I'll provide you a patch when I have a draft implementation.
> > 
> > Thanks! I'm happy to test your patch.
> > 
> 
> Before trying new patch, please upgrade your firmware to v0.13.24.0
> that you can download it via my github:
> 
> https://github.com/pkshih/linux-firmware/blob/a5b79c4790da3eb3690e23554225ef8db464f2c6/rtw89/rtw8852a_fw.bin
> 
> Then, check kernel log to confirm the version like dmesg you mentioned.
> 
> 
> The path of the attachment patch isn't full path, so please apply
> it with specified path drivers/net/wireless/realtek/rtw89/
> 
> 
> --
> Ping-Ke

I tested this out and I can confirm it works. Thanks Ping-Ke!
