Return-Path: <linux-wireless+bounces-10877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5794682F
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 08:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B7D282301
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 06:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A0F14C5AF;
	Sat,  3 Aug 2024 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gIVrN4DJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93918136350;
	Sat,  3 Aug 2024 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722666701; cv=none; b=LPDQRG7yEZzYxlkmYHuwcIOCN1LMSy6DUKEVytUGNaJaE2P2b/zET+w/93p9Gjng7NZqkO9ihcqm7e9hX6PI6QshOFb9x8eOc7h2Z7wcA7e8gWNog5j3gwQLVJbnp1eMDDA1SnDhQnwGL2sNHd/7z9aXZ39E9vL7CX8TdkePGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722666701; c=relaxed/simple;
	bh=WZSRR2bS9c6s6358D44/kwFOsADs6gQRBQQbB7+97Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1nrjsGbxe66i7RHYI30SMCqQH+vjLSwH63z8W+RCHrXJJMQVkPwve2BnohcLFg48MMtbdPa15koPqO+42ebBAqVo/CEgQBlfhdXAe9z7uDJKzfBtnWmPQTc5OdP+2TpR4OMKJiz7CbPTVlLV9bdt92Iv4ypsS0XZLpt4UO1ejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gIVrN4DJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C73C116B1;
	Sat,  3 Aug 2024 06:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722666701;
	bh=WZSRR2bS9c6s6358D44/kwFOsADs6gQRBQQbB7+97Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIVrN4DJA+fX0n5nA1HKKGualV3JtwDob2IzTdhty6KNxsuJ4NZN3IhYn2VTFgWLq
	 cJ/ZM24fVSieorngygPXF5DVCA6TX95+xWtueku+k8yiq6X4NCZi/QiaUTDZhwTgY1
	 OcrLLvYFrsmiwnZVeTPvmWtJNBnrz7toCIVGZ46I=
Date: Sat, 3 Aug 2024 08:31:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-usb@vger.kernel.org, Mark Esler <mark.esler@canonical.com>,
	color Ice <wirelessdonghack@gmail.com>, stf_xl@wp.pl,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <2024080359-getaway-concave-623e@gregkh>
References: <CAOV16XESCK0-sMENJFxvWiKqogBJ4PQwA2DvJBvWq-g+NtV8ow@mail.gmail.com>
 <ZqyWpovXcaAX2f5c@aeon>
 <87wmky7i3l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmky7i3l.fsf@kernel.org>

On Sat, Aug 03, 2024 at 12:03:26AM +0300, Kalle Valo wrote:
> Mark Esler <mark.esler@canonical.com> writes:
> 
> > On Fri, Aug 02, 2024 at 03:57:47PM +0800, color Ice wrote:
> >> Dear RT2X00 driver maintainers,
> >> 
> >> We have discovered a critical vulnerability in the RT2X00 driver. We
> >> recommend urgently submitting an update.
> >> 
> >> *Vulnerability Description*: When a PC is running Ubuntu 22.04 or 24.04,
> >> executing our proof of concept (POC) can directly cause a null pointer
> >> dereference or use-after-free (UAF). The systems we tested were:
> >> 
> >>    - *Description*: Ubuntu 22.04.4 LTS *Release*: 22.04
> >>    - *Description*: Ubuntu 24.04 LTS *Release*: 24.04
> >> 
> >> We tested network cards from the RT2870/RT3070/RT5370 series, which all
> >> belong to the RT2X00 driver group, and all were able to trigger the
> >> vulnerability. Additionally, executing the POC requires only user-level
> >> privileges. Debian systems are not affected.
> >
> > It is unclear if Ubuntu is the only affected distro.
> 
> It's also unclear how this works as there's no description about the
> issue. I'm not going to run any scripts and I don't know how python
> usb.core package works. I guess it needs root privileges to be able to
> send these USB commands?
> 
> If this really is a security vulnerability, here are the instructions
> how to report them:
> 
> https://docs.kernel.org/process/security-bugs.html

This is public now, so security@k.o doesn't matter anymore.  But it
should just be sent to the linux-usb mailing list, as this just looks
like "sending a USB random data causes problems."

But the odd thing is that you are sending data to a device that already
has a driver bound to it.  How is libusb allowing that to happen?
Shouldn't it require you to unbind the device from the driver first
before talking to it over usbfs?

thanks,

greg k-h

