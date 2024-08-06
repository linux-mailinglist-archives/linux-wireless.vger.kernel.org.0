Return-Path: <linux-wireless+bounces-10994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52184948978
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 08:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE7287760
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 06:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892281BC9F0;
	Tue,  6 Aug 2024 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XP2dHDNY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507031BC091;
	Tue,  6 Aug 2024 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926160; cv=none; b=RIqVunqOtsWDV4PcadBXrWr0RQTd81x404E7+/dM38uAa6cyqjDQ+RcHYF463FyMH5Fd3BzssTQorot3cJUDk7E4RYIOPmb4CkUbbydiZQM9BEOmf/CBfhHmQ3sjnqkwwpx3HbfGiqz8Ag0m5kH+DlJn/JIlBwU3B+rSYP5Vp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926160; c=relaxed/simple;
	bh=Vyqq27D34dcXAwchbQUjhglj5oY1UyMp0yUUqXMBL9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKdjBS5PANvFlgYXuZIGVx0KvWaEFdjnzhdB9jee/UbgPBkWD7DJYOWIQR1VRCDLTZUqJRpPkGCT2NsDTyXYQTO2JVHvZcpNlVZ/bM1QYDzVC6F3Av2U7uncdHxnIvL/vYfPuoKrSK+0bxBFJHouhrxGs60UThxRbegg5cRWZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XP2dHDNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43055C32786;
	Tue,  6 Aug 2024 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722926159;
	bh=Vyqq27D34dcXAwchbQUjhglj5oY1UyMp0yUUqXMBL9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XP2dHDNYjjomt6DXQyyghg6PHiaXLWGAiST1ISXBpTRqOkoYPlGhewkfKbojC3s16
	 pu8Z+LdK6jNbz+izkrevrxiBUYAAAJQUncBuPctcOA+KYL4OUXtYwHC3rlf6msGmjF
	 bN0tN0FFJ4Xf0ZP2GudNUvnsffPTDSSVsqXHGe6Y=
Date: Tue, 6 Aug 2024 08:35:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: LidongLI <wirelessdonghack@gmail.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	mark.esler@canonical.com, stf_xl@wp.pl
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <2024080640-slather-dictator-186f@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240806035433.20901-1-wirelessdonghack@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806035433.20901-1-wirelessdonghack@gmail.com>

On Tue, Aug 06, 2024 at 11:54:33AM +0800, LidongLI wrote:
> Our requirement is to assign a CVE for this "bug" because it is an issue within the kernel. Since it is a problem, it poses a potential risk. Therefore, we believe it is necessary to address it accordingly.

I know your school professors are making this a requirement for you, but
that is not _our_ requirement here, sorry.  Please work with your school
to find something else to work on.

> Because it involves a driver development error, we believe it is necessary and meaningful to address this issue.

I do not see the driver error yet, please submit a patch showing this
and we will be glad to review it.

thanks,

greg k-h

