Return-Path: <linux-wireless+bounces-10921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C094759B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 08:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE211C209F2
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C499145345;
	Mon,  5 Aug 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cywugoWn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F313D26B;
	Mon,  5 Aug 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722840914; cv=none; b=fLOnfsx8J28atW4+f5MS9B32KlNs1rAOkEhIy/zdNfLivoMSeLYK7fzhYF/Z1q2DBpLcLmSa4EhdIjEGrjZUkxnvbOyCP7MrS0rdX2b9L3lhjPy/z4YLkLBY/UH8u5t685Bt7Ebkza8OeanVod9omyH8cWUrKZ7o27BcC7qx8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722840914; c=relaxed/simple;
	bh=RBq77n2Z7CLas5CJdnHsxhWTNoNe6rJNGtk8mVGVHIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU3Rjie8Je2uRsTfRCYpKUwmyPJsHG2B/EBhPuHSi6GbMIT9qcMuDjAM6494yn7GCyUjqxXFIk064EbS3001cNzPYe8AvXbgfHL82Hp+8wLG6gg8od/3m6GLLg/qAZ0jkwZXA57pdgnV5aFZ8ZmqPGgAeKXNfoUVeuBu/EsNfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cywugoWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238ADC4AF0B;
	Mon,  5 Aug 2024 06:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722840913;
	bh=RBq77n2Z7CLas5CJdnHsxhWTNoNe6rJNGtk8mVGVHIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cywugoWn1BOeUMK9fm+YRSBivKIRylg7a3SQF77akMWVtDL1j2VJActZDss8szA37
	 Q6ZfIMaJJTmS957P4UrMg4IQCV5+gJW4oW9SFmPwrdeui0o3FHVbdfwQW6yjANm5M4
	 8ffAB4IJmxzdWHop4FVxAc8IJuHOYqJUoV0S4xzQ=
Date: Mon, 5 Aug 2024 08:55:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: LidongLI <wirelessdonghack@gmail.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	mark.esler@canonical.com, stf_xl@wp.pl
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <2024080557-mouse-overload-bb56@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240805022030.1929100-1-wirelessdonghack@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805022030.1929100-1-wirelessdonghack@gmail.com>

On Mon, Aug 05, 2024 at 10:20:30AM +0800, LidongLI wrote:
> Hi Greg,
> 
> We tried it, and after configuring the udev rules, I can run the proof of concept (PoC) and reproduce the previous issue without using sudo
> 

What did you do exactly with a new udev rule?  Did you give it userspace
permission to unbind/reset the device?

As it is today, this requires root permissions and it looks to just be a
race with the existing kernel driver setting the device up and userspace
trying to reset the device at the same time, not anything that can
normally happen in a system from what I can tell.

thanks,

greg k-h

