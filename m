Return-Path: <linux-wireless+bounces-11899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E195E30A
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1922A1C20C92
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6049613DBB6;
	Sun, 25 Aug 2024 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IFBP60fv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07730801;
	Sun, 25 Aug 2024 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724585160; cv=none; b=CbSWd0esTatnnMXm0+LkWxu/DnCRifDMtszjkNrRWob0uQa5k/zFznldNcKDd7f5xzXBQXUPmt/GaS0t0C9F71FcT2AMTjvUDGzZ46zBN9sK8Tyet/6aju0D0G84ge+HM1r0Aayf29UQ+bju9o5MoQ4il/2UVJIPUooPP/fMy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724585160; c=relaxed/simple;
	bh=mfY+835+6x4vd1sUirZL47mKpUKMMBG2vJ2EWL/D5Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYGJ89aiwPfMlNcOB7ApjLXZiOKt28gcN9e9g318m5ky/cOHNoM2B/yO25Tr3JMBeVMnR5R3k66gTdW4j+G+tPxBPE0RtfaRxbKU9RgEDLbFVLt9rSkr2Wldoylq3pGnO6ACP8zSTsP/kDaYEGp93TbRlpJhVJXhnllxSlgJObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IFBP60fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F6EC32782;
	Sun, 25 Aug 2024 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724585159;
	bh=mfY+835+6x4vd1sUirZL47mKpUKMMBG2vJ2EWL/D5Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFBP60fvvTM0yH3/4f8Zpvpw2+W6JEY5ZhEr/8378rri9RxzMpV1PrfN+sL7z95/4
	 +KfRL8smkGwuirbzYisJQrOA63FxZkv69hE8LFM9S8fLyO14Qy3RiCgxxOB9QfCdjd
	 NGlE46m2oBN5MOzrDHcxCjYmX6TgDxMLZWbuktJk=
Date: Sun, 25 Aug 2024 13:25:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] wifi: ath6kl: Check that the read operation returns a
 data length of 0
Message-ID: <2024082501-tiling-prelaw-38d7@gregkh>
References: <2024082554-manatee-ashamed-12d5@gregkh>
 <tencent_89BAE8BB0933D89E1D1BD94B891BBD257208@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_89BAE8BB0933D89E1D1BD94B891BBD257208@qq.com>

On Sun, Aug 25, 2024 at 06:09:45PM +0800, Edward Adam Davis wrote:
> On Sun, 25 Aug 2024 10:34:00 +0200, Greg KH wrote:
> > On Sun, Aug 25, 2024 at 04:14:17PM +0800, Edward Adam Davis wrote:
> > > On Sun, 25 Aug 2024 09:25:37 +0200, Greg KH wrote:
> > > > > If the data length returned by the device is 0, the read operation
> > > > > should be considered a failure.
> > > > >
> > > > > Reported-and-tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> > > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > > ---
> > > > >  drivers/net/wireless/ath/ath6kl/usb.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> > > > > index 5220809841a6..2a89bab81b24 100644
> > > > > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > > > > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > > > > @@ -1034,6 +1034,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
> > > > >  		ath6kl_err("Unable to read the bmi data from the device: %d\n",
> > > > >  			   ret);
> > > > >  		return ret;
> > > > > +	} else {
> > > > > +		ath6kl_err("Actual read the bmi data length is 0 from the device\n");
> > > > > +		return -EIO;
> > > >
> > > > Close, but not quite there.  ath6kl_usb_submit_ctrl_in() needs to verify
> > > > that the actual amount of data was read that was asked for.  If a short
> > > > read happens (or a long one), then an error needs to propagate out, not
> > > > just 0.  See the "note:" line in that function for what needs to be
> > > > properly checked.
> > > >
> > > > hope this helps,
> > > Thanks for your analysis.
> > > I have carefully read your analysis and I am not sure if the following
> > > understanding is appropriate:
> > > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> > > index 2a89bab81b24..35884316a8c8 100644
> > > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > > @@ -932,6 +932,15 @@ static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,
> > >
> > >         kfree(buf);
> > 
> > First off, this should be using usb_control_msg_send() instead of having
> > to roll their own buffer handling, right?
> I couldn't figure it out with what you said. 

Meaning this kfree() should not be needed if you use
usb_control_msg_send() (nor the allocation above it.)

> ath6kl_usb_submit_ctrl_in() is similar to usb_control_msg_send(),
> both calling usb_control_msg() to communicate with USB devices.

Yes, it's close, but not quite the same.

> In the current issue, when executing an ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP
> read request, the length of the data returned from the device is 0, which
> is different from the expected length of the data to be read, resulting in
> a warning.
> 
> ath6kl_usb_submit_ctrl_in()--->
> 	usb_control_msg()--->
> 		usb_internal_control_msg()
> 
> usb_internal_control_msg() will return the length of the data returned from
> the device, usb_control_msg() return the length too, so in ath6kl_usb_submit_ctrl_in(),
> we can filter out incorrect data lengths by judging the value of ret, such
> as ret != Size situation.

Then just do that type of check for that type of read request in the
code that does that call, not 2-3 layers deeper, no need for making this
more complex than needed.

Try removing both of these functions and just call usb functions
directly.

thanks,

greg k-h

