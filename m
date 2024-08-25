Return-Path: <linux-wireless+bounces-11897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4787E95E2B3
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB65B2138E
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD53C55886;
	Sun, 25 Aug 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+SZxzMj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F3A5F;
	Sun, 25 Aug 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724574844; cv=none; b=ryXIHbaHJvXeaEGW9zu/nnyP3J7/p8ExQoeaBUwJzy95XCqxOT+HnMpuCydvU3taiwN0sLonmBbeiEry6B0tcv0TL4T/xaofzOj9ttmZ443HEGc+oWir8NfX8o42sZ3BqD0z5SeUOfzAuxxTgyyPJOUAkEHhC7eYgXFt35rPOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724574844; c=relaxed/simple;
	bh=u3+W8p/Is8iM+oDz8GIA+0dHRSNMz0iqZScB80VIfQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFsQRmZI2J97iNadwYK1qG3tidPexpOVWu8gDJCD2PLiMHAzgfnO/zvuqUIOf1pJfDbypjcD7URKkGRbDZxZwgTgiXAHYPrDgsQ9PeVfGXSfHjWY2JcyYekmPA01uJ+cuYMuuS7T4YVzgG12KKh+FGnwnrJfXVPuTnIFQnvmiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+SZxzMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3906BC32782;
	Sun, 25 Aug 2024 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724574843;
	bh=u3+W8p/Is8iM+oDz8GIA+0dHRSNMz0iqZScB80VIfQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+SZxzMj5dAd6q6wfAFECqei110sE9TcrArrT1OWLbaLpZhHwyL0dDESSku5LxvH0
	 XE+aMsoTiEQaPZudEvT+Y7iyLJcabE94c3Q8Eb2vlCvIvIzKNNoA6oMEwLE2SHBUOZ
	 jZrEV0QzQJfRsmQH32oaTu3vw/P3Rd6S5d371jEw=
Date: Sun, 25 Aug 2024 10:34:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] wifi: ath6kl: Check that the read operation returns a
 data length of 0
Message-ID: <2024082554-manatee-ashamed-12d5@gregkh>
References: <2024082507-clay-riveting-16f3@gregkh>
 <tencent_F3E6370A4B6C7467779367AE3CB3363E9609@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F3E6370A4B6C7467779367AE3CB3363E9609@qq.com>

On Sun, Aug 25, 2024 at 04:14:17PM +0800, Edward Adam Davis wrote:
> On Sun, 25 Aug 2024 09:25:37 +0200, Greg KH wrote:
> > > If the data length returned by the device is 0, the read operation
> > > should be considered a failure.
> > >
> > > Reported-and-tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  drivers/net/wireless/ath/ath6kl/usb.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> > > index 5220809841a6..2a89bab81b24 100644
> > > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > > @@ -1034,6 +1034,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
> > >  		ath6kl_err("Unable to read the bmi data from the device: %d\n",
> > >  			   ret);
> > >  		return ret;
> > > +	} else {
> > > +		ath6kl_err("Actual read the bmi data length is 0 from the device\n");
> > > +		return -EIO;
> > 
> > Close, but not quite there.  ath6kl_usb_submit_ctrl_in() needs to verify
> > that the actual amount of data was read that was asked for.  If a short
> > read happens (or a long one), then an error needs to propagate out, not
> > just 0.  See the "note:" line in that function for what needs to be
> > properly checked.
> > 
> > hope this helps,
> Thanks for your analysis.
> I have carefully read your analysis and I am not sure if the following
> understanding is appropriate:
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> index 2a89bab81b24..35884316a8c8 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -932,6 +932,15 @@ static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,
> 
>         kfree(buf);

First off, this should be using usb_control_msg_send() instead of having
to roll their own buffer handling, right?

> +       /* There are two types of read failure situations that need to be captured:
> +        * 1. short read: ret < size && ret >= 0
> +        * 2. long read: ret > size
> +        * */
> +       if (req == ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP && ret != size) {
> +               ath6kl_warn("Actual read the data length is: %d, but input size is %d\n", ret, size);
> +               return -EIO;
> +       }

If you switch to usb_control_msg_send() this logic gets a lot simpler.
Perhaps do that instead?

If not, then you need to check for "short writes" or zero writes, see
the documentation for usb_control_msg() for what it returns.  Your
comment is not correct here, there are 3 different return "states" that
you need to handle.

And why are you caring about what the req type is?

thanks,

greg k-h

