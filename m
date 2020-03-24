Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4C190CB3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 12:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgCXLrH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 07:47:07 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57363 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgCXLrH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 07:47:07 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 73EEEFF815;
        Tue, 24 Mar 2020 11:47:02 +0000 (UTC)
Message-ID: <7aa74127978a73359ae95cd193bb3092d4536118.camel@hadess.net>
Subject: Re: [PATCH resend 3] staging: rtl8188eu: Add rtw_led_enable module
 parameter
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Date:   Tue, 24 Mar 2020 12:47:01 +0100
In-Reply-To: <20200324113840.GA2322042@kroah.com>
References: <97d2ef68a6bcb7d1ece978eef6315e95732ca39d.camel@hadess.net>
         <20200324113840.GA2322042@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0 (3.36.0-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-24 at 12:38 +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 24, 2020 at 11:36:00AM +0100, Bastien Nocera wrote:
> > Make it possible to disable the LED, as it can be pretty annoying
> > depending on where it's located.
> > 
> > See also https://github.com/lwfinger/rtl8188eu/pull/304 for the
> > out-of-tree version.
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/staging/rtl8188eu/core/rtw_led.c      | 6 ++++++
> >  drivers/staging/rtl8188eu/include/drv_types.h | 2 ++
> >  drivers/staging/rtl8188eu/os_dep/os_intfs.c   | 5 +++++
> >  3 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c
> > b/drivers/staging/rtl8188eu/core/rtw_led.c
> > index d1406cc99768..75a859accb7e 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_led.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_led.c
> > @@ -467,10 +467,16 @@ void blink_handler(struct LED_871x *pLed)
> >  
> >  void led_control_8188eu(struct adapter *padapter, enum
> > LED_CTL_MODE LedAction)
> >  {
> > +	struct registry_priv *registry_par;
> > +
> >  	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
> >  	    !padapter->hw_init_completed)
> >  		return;
> >  
> > +	registry_par = &padapter->registrypriv;
> > +	if (!registry_par->led_enable)
> > +		return;
> > +
> >  	if ((padapter->pwrctrlpriv.rf_pwrstate != rf_on &&
> >  	     padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) &&
> >  	    (LedAction == LED_CTL_TX || LedAction == LED_CTL_RX ||
> > diff --git a/drivers/staging/rtl8188eu/include/drv_types.h
> > b/drivers/staging/rtl8188eu/include/drv_types.h
> > index 35c0946bc65d..4ca828141d3f 100644
> > --- a/drivers/staging/rtl8188eu/include/drv_types.h
> > +++ b/drivers/staging/rtl8188eu/include/drv_types.h
> > @@ -67,6 +67,8 @@ struct registry_priv {
> >  	u8	wmm_enable;
> >  	u8	uapsd_enable;
> >  
> > +	u8	led_enable;
> > +
> >  	struct wlan_bssid_ex    dev_network;
> >  
> >  	u8	ht_enable;
> > diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
> > b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
> > index 8907bf6bb7ff..ba55ae741215 100644
> > --- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
> > +++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
> > @@ -47,6 +47,8 @@ static int rtw_acm_method;/*  0:By SW 1:By HW. */
> >  static int rtw_wmm_enable = 1;/*  default is set to enable the
> > wmm. */
> >  static int rtw_uapsd_enable;
> >  
> > +static int rtw_led_enable = 1;
> > +
> >  static int rtw_ht_enable = 1;
> >  /* 0 :disable, bit(0): enable 2.4g, bit(1): enable 5g */
> >  static int rtw_cbw40_enable = 3;
> > @@ -98,6 +100,7 @@ module_param(rtw_channel, int, 0644);
> >  module_param(rtw_wmm_enable, int, 0644);
> >  module_param(rtw_vrtl_carrier_sense, int, 0644);
> >  module_param(rtw_vcs_type, int, 0644);
> > +module_param(rtw_led_enable, int, 0644);
> 
> Ick, really?  No, no nee module parameters, this is not the 1990's.
> 
> This should be done on a per-device basis, using the correct apis.

What API?

