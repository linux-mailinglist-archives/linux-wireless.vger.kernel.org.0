Return-Path: <linux-wireless+bounces-11626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F20957247
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 19:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC571C224FF
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEBA187FF1;
	Mon, 19 Aug 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3Zbqp7H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C049620;
	Mon, 19 Aug 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089423; cv=none; b=fzPTdWqSHGnJgLFfmbGjz09NyZagw4MyDpHTQw7sCksc3uwHWQ4FeXXqgBMqScmMedujfnowTxwMhmH1/92dIB4AmJNqk1RD4LmVb4h9LI853hfIChuat15MZ/LcITv+s0QJzgfELTMtvKmOcBQKh3VcDq/nKa04ve7XquVfR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089423; c=relaxed/simple;
	bh=8jlBsEeoFQY1BVBdnmMedzjxDJV4JpKNTH4RvvcF9JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaqsJDxmJaSPm1wYArtrPULX6l7iVaP+Opr9+CtzW7ObKYiugdGPiAqSx/rPibYa5nMUUQs6kUiZzJgkhF/WYwhisHaCFTiQb9+czBbqagsuwYiEtf3jpBQuypCRp30Osqad8CRaVoRdAPJ2efAlf7IBog1ksYoRT5QkZ8bQjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3Zbqp7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43521C32782;
	Mon, 19 Aug 2024 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724089422;
	bh=8jlBsEeoFQY1BVBdnmMedzjxDJV4JpKNTH4RvvcF9JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3Zbqp7HXLkoy0iXmT8VFPiDC57xPOzwKuUwhyp+7+78dC8XV0hQGYG0cK+5xEpEI
	 LZBbiLCUz5TOAbrppJq+hMfMNd8Q0mHeDZHifGPw6avJ8OJQFvDeqsbq+HsnNG+q/H
	 JGU0TmKxhiuuKOYa4MyuhSTtacUdBnQVnf3Eigow=
Date: Mon, 19 Aug 2024 19:43:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: color Ice <wirelessdonghack@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, mark.esler@canonical.com,
	stf_xl@wp.pl, tytso@mit.edu
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <2024081904-encircle-crayon-8d16@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240814055816.2786467-1-wirelessdonghack@gmail.com>
 <91e19cf3-216b-48ac-a93d-f920dd2a7668@rowland.harvard.edu>
 <CAOV16XEsgkLWz3rOQsAdve-qKsPEDw-QxJNoo4hJfXdLnowHfw@mail.gmail.com>
 <2024081946-designate-dioxide-c59d@gregkh>
 <CAOV16XFYeWdT4tSpLWoE+pCVsNERXKJQCJvJovrfsgMn1PMzbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOV16XFYeWdT4tSpLWoE+pCVsNERXKJQCJvJovrfsgMn1PMzbA@mail.gmail.com>

On Mon, Aug 19, 2024 at 11:11:10PM +0800, color Ice wrote:
> On some TP-Link routers or routers running OpenWrt, as well as Raspberry Pi
> devices with a headless setup and BeagleBone boards, certain USB
> configurations are required by default. These devices typically grant
> higher permissions to USB by default. Therefore, on certain devices, I can
> run a PoC without using sudo. This explains why there are some inherent
> risk scenarios when declaring this vulnerability, as there are many Linux
> distributions applied to different embedded devices.

I suggest filing bugs with those distros/system images so that they
properly remove the ability for users to reset any random USB device
this way.  If any user can disconnect any driver from any device, that's
not a good system...

Also, why not dig into the code and try to come up with a fix while
waiting?  The code is all there for everyone to read and resolve, that
way you get the proper credit for fixing the issue as well.

thanks,

greg k-h

