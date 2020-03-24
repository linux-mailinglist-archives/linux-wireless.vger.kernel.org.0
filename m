Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A013190D8D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 13:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCXMcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 08:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbgCXMcc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 08:32:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885952070A;
        Tue, 24 Mar 2020 12:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585053152;
        bh=I4zHov14n7M/DuZob8alhpj/TYDh+wT0gdavajXveuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wzWOocarVx6V99QsL3UjWtbAlo/VPX6MGut1redIUpLxD+UMOlUcIlLo62SMW8mYB
         6XBSNBA5647a5IOMjqbKYuqJtU1YpYq9nXxp3YphKrPIZuqoGl712aFUB+tH4U2+pF
         yJcsN46EJyeCmn5I0+GxjEDoUK39Rwq/xMsogZg0=
Date:   Tue, 24 Mar 2020 13:32:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH resend 3] staging: rtl8188eu: Add rtw_led_enable module
 parameter
Message-ID: <20200324123229.GD2348009@kroah.com>
References: <97d2ef68a6bcb7d1ece978eef6315e95732ca39d.camel@hadess.net>
 <20200324113840.GA2322042@kroah.com>
 <7aa74127978a73359ae95cd193bb3092d4536118.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa74127978a73359ae95cd193bb3092d4536118.camel@hadess.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 24, 2020 at 12:47:01PM +0100, Bastien Nocera wrote:
> On Tue, 2020-03-24 at 12:38 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 24, 2020 at 11:36:00AM +0100, Bastien Nocera wrote:
> > > Make it possible to disable the LED, as it can be pretty annoying
> > > depending on where it's located.
> > > 
> > > See also https://github.com/lwfinger/rtl8188eu/pull/304 for the
> > > out-of-tree version.
> > > 
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > ---
> > >  drivers/staging/rtl8188eu/core/rtw_led.c      | 6 ++++++
> > >  drivers/staging/rtl8188eu/include/drv_types.h | 2 ++
> > >  drivers/staging/rtl8188eu/os_dep/os_intfs.c   | 5 +++++
> > >  3 files changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c
> > > b/drivers/staging/rtl8188eu/core/rtw_led.c
> > > index d1406cc99768..75a859accb7e 100644
> > > --- a/drivers/staging/rtl8188eu/core/rtw_led.c
> > > +++ b/drivers/staging/rtl8188eu/core/rtw_led.c
> > > @@ -467,10 +467,16 @@ void blink_handler(struct LED_871x *pLed)
> > >  
> > >  void led_control_8188eu(struct adapter *padapter, enum
> > > LED_CTL_MODE LedAction)
> > >  {
> > > +	struct registry_priv *registry_par;
> > > +
> > >  	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
> > >  	    !padapter->hw_init_completed)
> > >  		return;
> > >  
> > > +	registry_par = &padapter->registrypriv;
> > > +	if (!registry_par->led_enable)
> > > +		return;
> > > +
> > >  	if ((padapter->pwrctrlpriv.rf_pwrstate != rf_on &&
> > >  	     padapter->pwrctrlpriv.rfoff_reason > RF_CHANGE_BY_PS) &&
> > >  	    (LedAction == LED_CTL_TX || LedAction == LED_CTL_RX ||
> > > diff --git a/drivers/staging/rtl8188eu/include/drv_types.h
> > > b/drivers/staging/rtl8188eu/include/drv_types.h
> > > index 35c0946bc65d..4ca828141d3f 100644
> > > --- a/drivers/staging/rtl8188eu/include/drv_types.h
> > > +++ b/drivers/staging/rtl8188eu/include/drv_types.h
> > > @@ -67,6 +67,8 @@ struct registry_priv {
> > >  	u8	wmm_enable;
> > >  	u8	uapsd_enable;
> > >  
> > > +	u8	led_enable;
> > > +
> > >  	struct wlan_bssid_ex    dev_network;
> > >  
> > >  	u8	ht_enable;
> > > diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
> > > b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
> > > index 8907bf6bb7ff..ba55ae741215 100644
> > > --- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
> > > +++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
> > > @@ -47,6 +47,8 @@ static int rtw_acm_method;/*  0:By SW 1:By HW. */
> > >  static int rtw_wmm_enable = 1;/*  default is set to enable the
> > > wmm. */
> > >  static int rtw_uapsd_enable;
> > >  
> > > +static int rtw_led_enable = 1;
> > > +
> > >  static int rtw_ht_enable = 1;
> > >  /* 0 :disable, bit(0): enable 2.4g, bit(1): enable 5g */
> > >  static int rtw_cbw40_enable = 3;
> > > @@ -98,6 +100,7 @@ module_param(rtw_channel, int, 0644);
> > >  module_param(rtw_wmm_enable, int, 0644);
> > >  module_param(rtw_vrtl_carrier_sense, int, 0644);
> > >  module_param(rtw_vcs_type, int, 0644);
> > > +module_param(rtw_led_enable, int, 0644);
> > 
> > Ick, really?  No, no nee module parameters, this is not the 1990's.
> > 
> > This should be done on a per-device basis, using the correct apis.
> 
> What API?

Documentation/leds/index.rst should give you a good start :)

thanks,

greg k-h
