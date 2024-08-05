Return-Path: <linux-wireless+bounces-10966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE99481CC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 20:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CE41F21CCB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A143166F11;
	Mon,  5 Aug 2024 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iwI4n5GA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4B1662F1;
	Mon,  5 Aug 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883032; cv=none; b=hBwa/pkARgdJD4P9QINvPJjQZeGe8PJM/kpwnm+nct9LFisaxwtBoqCo9LJFgAIkHnTdiBpKY6UDWdQny5Hj8Wzrfb1+k+Oy9tFpTthTaMLqV8U9rrrNnjxooLL70HSVJEfQWws7pgORr64Lsuo2QE9W+QbzHvVe80c3uOiFqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883032; c=relaxed/simple;
	bh=ezhztv0cTkSW4yrqRYBU+yMZep+pn3f9Wr5gRT9OAWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aehL3583VeXzbKH8QK8kVihXdUxO3MfSGjqp6o5W7kaISmGq31Q7agw9HSh+2/Kui/MddvtEyUJpHx+QymzUlafhubIjAMw5CmeEqU3Yr4qBDAjdTTDWoPFkHBT8OmdadEp2GtSmrTPCdlXcas3/ZK4BQtKClNIXxnKuHwCb8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iwI4n5GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67261C32782;
	Mon,  5 Aug 2024 18:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722883031;
	bh=ezhztv0cTkSW4yrqRYBU+yMZep+pn3f9Wr5gRT9OAWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwI4n5GA3N+f5A2mVhQRx5fNKPFpNMGNII24+sbuNImos7kMIhph7eSolRXzw/8RN
	 ZNJdNbl09RK2enK8NITAReRux7S7+rUHR91tslF2sRDOA2oxBOsa4hyiz15CZqV4tn
	 OXVoAuVLHCU5UVjJrrMwgNB680wAixIQ7PwDpzDk=
Date: Mon, 5 Aug 2024 20:37:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: LidongLI <wirelessdonghack@gmail.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	mark.esler@canonical.com, stf_xl@wp.pl
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <2024080516-wreath-captivity-f832@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240805083339.10356-1-wirelessdonghack@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805083339.10356-1-wirelessdonghack@gmail.com>

On Mon, Aug 05, 2024 at 04:33:39PM +0800, LidongLI wrote:
> ### Tips for Strengthening Your Argument
> 
> 1. **Provide Evidence**: Include logs, stack traces, or any crash reports that underscore the vulnerability's impact.
> 2. **Highlight Real-World Scenarios**: Describe how the vulnerability can be exploited in practical, real-world situations.
> 3. **Be Precise and Clear**: Use technical terminology appropriately and explain any assumptions or configurations required to trigger the vulnerability.
> 4. **Emphasize Risk**: Stress how easy it is for an attacker to achieve their goals once the Udev rule is modified, even if it's a non-default configuration.
> 
> Remember, the goal is to present the vulnerability convincingly as a security risk that needs to be tracked and addressed with a CVE assignment.

Note, please work with your professor who has assigned you this task to
not actually include the task assignment in the emails you send out.

This didn't help any :)

good luck on your grade!

greg k-h

