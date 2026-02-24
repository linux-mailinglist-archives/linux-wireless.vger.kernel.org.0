Return-Path: <linux-wireless+bounces-32134-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL6ANj76nGmXMQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32134-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 02:09:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E8180694
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 02:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58723049720
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 01:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7171822756A;
	Tue, 24 Feb 2026 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qq64ew3e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395D1F92E;
	Tue, 24 Feb 2026 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771895355; cv=none; b=FlTsYXvHisayGUUNZOBig2oXp/XjE0mg6Z4LRRIqG4wX77cFaEJZfA2EQjTKu4OlrKPK8N4+7BnbVkrP4DHwHIYxsmD3aag+PevWNJJAZgqDVrux+b4Kmu6Xh/Ud/FM2d7PyrRKwH8EUqGGCAbPa76/QFOEuthTHwVLK23ZhYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771895355; c=relaxed/simple;
	bh=fio+o+++fJjafjkDSppcvv55Yp7+sBiKdZ/8VCyZoN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKHKdnkeWB8jBg10+Fzcn1+PYPh06rwCnSXPs/Y2Hniad0xzUiOk6hACUfwFKEPdmrnWyiXcvpETItg6ihswkDRNMi0LUfbVlSAmh4sYFDE8V5cXdsfdJRPCb+k1biQxgRV6ELkItzyF2XZfCGDn6suyJkmwoJ1mQHbnsWDXMn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qq64ew3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39FAC116C6;
	Tue, 24 Feb 2026 01:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771895354;
	bh=fio+o+++fJjafjkDSppcvv55Yp7+sBiKdZ/8VCyZoN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qq64ew3eFvxCI0NbqBD744/8xsVDUQUnMymuatUhGN7Xy8xAzkLa6cZDsicbR0gzt
	 mBDAXOFTiI8UpMoMOEgHBiVIJg1rKisqMvK86f4CEBWW+PuVoA0XhEMyQOUcDHNkIE
	 4W1HfdsuuQtqS1Hk0kpexUIw5PoHTg862QgPDv2c=
Date: Tue, 24 Feb 2026 02:09:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] wifi: rtw88: properly drop usb interface reference
 on error
Message-ID: <2026022459-robe-mutual-fc3d@gregkh>
References: <2026022333-periscope-unusual-f0a0@gregkh>
 <0a1b75853588468d87725e4d6aad8f22@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1b75853588468d87725e4d6aad8f22@realtek.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32134-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 351E8180694
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:46:02AM +0000, Ping-Ke Shih wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > If an error happens in the usb probe path, in rtw_usb_intf_init(), the
> > usb interface reference needs to be properly dropped, otherwise is is
> > incorrectly increased when returning to the USB core.
> > 
> > Cc: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/net/wireless/realtek/rtw88/usb.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> > index 433b06c8d8a6..36ac20039ce2 100644
> > --- a/drivers/net/wireless/realtek/rtw88/usb.c
> > +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> > @@ -1046,13 +1046,17 @@ static int rtw_usb_intf_init(struct rtw_dev *rtwdev,
> > 
> >         rtwusb->udev = udev;
> >         ret = rtw_usb_parse(rtwdev, intf);
> > -       if (ret)
> > +       if (ret) {
> > +               usb_put_dev(udev);
> >                 return ret;
> > +       }
> > 
> >         rtwusb->usb_data = kcalloc(RTW_USB_MAX_RXTX_COUNT, sizeof(u32),
> >                                    GFP_KERNEL);
> > -       if (!rtwusb->usb_data)
> > +       if (!rtwusb->usb_data) {
> > +               usb_put_dev(udev);
> >                 return -ENOMEM;
> > +       }
> > 
> >         usb_set_intfdata(intf, rtwdev->hw);
> > 
> 
> Since rtwusb->udev isn't used right after assignment in this function.
> Would it be simpler that moving usb_get_dev() downward like below?

What is even simpler, and easier, is to never call usb_get_dev() at all
anyway as it's not needed :)

I created that pattern a few decades ago when we thought that it was
going to be required, but as long as the usb interface is bound to the
driver, that pointer is going to be valid so there's no real need to
increment the reference count, except to feel good about doing it.

I'll gladly do that fix instead, if you want me to, I was just trying to
follow the style of the existing code and fix up the current bug.

> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index db60e142268d..6e5c9c6f3e00 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -1041,10 +1041,8 @@ static int rtw_usb_intf_init(struct rtw_dev *rtwdev,
>                              struct usb_interface *intf)
>  {
>         struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
> -       struct usb_device *udev = usb_get_dev(interface_to_usbdev(intf));
>         int ret;
> 
> -       rtwusb->udev = udev;
>         ret = rtw_usb_parse(rtwdev, intf);
>         if (ret)
>                 return ret;
> @@ -1054,6 +1052,8 @@ static int rtw_usb_intf_init(struct rtw_dev *rtwdev,
>         if (!rtwusb->usb_data)
>                 return -ENOMEM;
> 
> +       rtwusb->udev = usb_get_dev(interface_to_usbdev(intf));

That too works, or again, just drop the usb_get_dev() and usb_put_dev()
calls entirely.

thanks,

greg k-h

