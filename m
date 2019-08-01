Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A77D863
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfHAJVv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 05:21:51 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41819 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfHAJVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 05:21:51 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x719LgBr018940, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x719LgBr018940
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 1 Aug 2019 17:21:42 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0439.000; Thu, 1 Aug 2019 17:21:42 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "jano.vesely@gmail.com" <jano.vesely@gmail.com>
Subject: RE: [PATCH] rtw88: pci: enable MSI interrupt
Thread-Topic: [PATCH] rtw88: pci: enable MSI interrupt
Thread-Index: AQHVRsz7S+hWGWZ+/EW68pA5j53xh6bjDjWAgADwiMA=
Date:   Thu, 1 Aug 2019 09:21:41 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18855BB@RTITMBSVM04.realtek.com.tw>
References: <1564487414-9615-1-git-send-email-yhchuang@realtek.com>
 <20190730195703.GA224792@google.com>
In-Reply-To: <20190730195703.GA224792@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Subject: Re: [PATCH] rtw88: pci: enable MSI interrupt
> 
> Hi,
> 
> On Tue, Jul 30, 2019 at 07:50:14PM +0800, yhchuang@realtek.com wrote:
> > From: Yu-Yen Ting <steventing@realtek.com>
> >
> > MSI interrupt should be enabled on certain platform.
> >
> > Add a module parameter disable_msi to disable MSI interrupt,
> > driver will then use legacy interrupt instead.
> > And the interrupt mode is not able to change at run-time, so
> > the module parameter is read only.
> 
> Well, if we unbind/rebind the device, probe() will pick up the new
> value. e.g.:
> 
>   echo '0000:01:00.0' > /sys/bus/pci/drivers/rtw_pci/unbind
>   echo '0000:01:00.0' > /sys/bus/pci/drivers/rtw_pci/bind
> 
> So is it really necessary to mark read-only? I think there's a general
> understanding that module parameters are not always "immediately
> effective."


If there's a general understanding of not always effective immediately,
I think I can change the file mode to 0644.


> 
> > Tested-by: Ján Veselý <jano.vesely@gmail.com>
> > Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/pci.c | 51
> ++++++++++++++++++++++++++++++--
> >  drivers/net/wireless/realtek/rtw88/pci.h |  1 +
> >  2 files changed, 49 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/pci.c
> b/drivers/net/wireless/realtek/rtw88/pci.c
> > index 23dd06a..25410f6 100644
> > --- a/drivers/net/wireless/realtek/rtw88/pci.c
> > +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> > @@ -874,6 +878,7 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq,
> void *dev)
> >  	if (!rtwpci->irq_enabled)
> >  		goto out;
> >
> > +	rtw_pci_disable_interrupt(rtwdev, rtwpci);
> 
> Why exactly do you have to mask interrupts during the ISR? Is there a
> race in rtw_pci_irq_recognized() or something?


I think there is a race between SW and HW, if we do not stop the
IRQ first, write 1 clear will make the interrupt to be lost.


> 
> >  	rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
> >
> >  	if (irq_status[0] & IMR_MGNTDOK)
> 
> ...
> 
> 
> Otherwise, looks fine:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 


Yan-Hsuan
