Return-Path: <linux-wireless+bounces-18754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDAA30890
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 11:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4001A3A18CB
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602301F4609;
	Tue, 11 Feb 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMEb9CrJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0E1F4295;
	Tue, 11 Feb 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270016; cv=none; b=AIRXhD2A22GMuoHSxUD5EYDYTdrIM9a0fLdkSAb0yOlGJMbCwde60HyG1222XsYL6WNS6cvD5iUmjQAoKdQzxt5c+BAE3GDdCVEAf9Xi3dH0mBS3YbQuJGtXXq54zUDVhMHkVFoalTMTrtRRYRs9XaGr1UaIq7gZnOgSzk741t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270016; c=relaxed/simple;
	bh=ssieTa65rESGBzPddHOy7zTdi7chXx0sh9RpkeLEnJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOOjtkMLWK6KoPwiyIn+2GKdKq2wC65f0uxwm/7hhbNZmUYfKD7zp0Kq1E408lo86JZi5JWlNsDUhFW6zdNo/YPLOYn9dLuw+lZLWRLkxPmYLMuJ12Vuw3e5gEzBEhRUMDSzfWbkPSYpz6Mf/7PDvPhJOsuoKGCtueaBZeoLJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oMEb9CrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BC6C4CEE4;
	Tue, 11 Feb 2025 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739270016;
	bh=ssieTa65rESGBzPddHOy7zTdi7chXx0sh9RpkeLEnJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMEb9CrJZtTnSMPPD05ItOD3dcx0kaTtx0IozbvtOdtG3aOATHr+8pni8V0Kz/xVF
	 6ohT2dxQzI1nzIMjOhPvdzK080cvCmHfPYToHXJ5VfOG2Mc+RO+aYFl5tbgIE09XNW
	 OxxgqXwDf7+l4cLoxkdWvodQyWnTKgp4+ZRoCcTs=
Date: Tue, 11 Feb 2025 11:33:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zenm Chen <zenmchen@gmail.com>
Cc: stable@vger.kernel.org, pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6.12] wifi: rtw89: pci: disable PCIE wake bit when PCIE
 deinit
Message-ID: <2025021143-neurosis-snout-c9b3@gregkh>
References: <20250210063026.3128-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210063026.3128-1-zenmchen@gmail.com>

On Mon, Feb 10, 2025 at 02:30:26PM +0800, Zenm Chen wrote:
> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> [ Upstream commit 9c1df813e08832c3836c254bc8a2f83ff22dbc06 ]
> 
> The PCIE wake bit is to control PCIE wake signal to host. When PCIE is
> going down, clear this bit to prevent waking up host unexpectedly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Link: https://patch.msgid.link/20241111063835.15454-1-pkshih@realtek.com
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
> Some users of RTL8852BE chip may encounter a shutdown issue [1] and this
> upstream patch fixes it, so backport it to kernel 6.12.

It also needs to go to 6.13.y too, right?  Please provide backports for
both as we can not take them only for older kernels as you would have a
regression when upgrading.

thanks,

greg k-h

