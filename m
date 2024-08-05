Return-Path: <linux-wireless+bounces-10965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08699481AA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6978328F4BC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2C1607AB;
	Mon,  5 Aug 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GkvWWGpU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A313A884;
	Mon,  5 Aug 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882798; cv=none; b=j/jJz7iP+BX5cjRDEG48zP+aISVvCjhshN6ph0pEPtF46qqMVvdNRdTbi57c2D3gsXGzEHst6Ne+4aHLTIWSS+X8OPHOIMasJt0yPSI2qLAxfHNajd/Qx3pHDYP4gRRdDv+r1ui8ItGW98FMNB1CQBMCqWe7qAF9U+omy3McsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882798; c=relaxed/simple;
	bh=hfnuvnnigu7GiBMzTH5MQC/YrBHLtcuKAlxu0YESuEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXeyj3YnaEWlHDAmxVSFl7g0l6G8kj0g9Cja5bTgfCamBsb/9ubF38Q+f/i9gZJsDdl49mvapkBkhfAuOlNfIUNhcACSiDr//VPx7dOG/mK97Ri7iAw/6tv0tupFn5eKQo51Go3wQ68Gz7lr+9sWTk46Np9+ZIlxFBBE+v8Jn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GkvWWGpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C74C32782;
	Mon,  5 Aug 2024 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722882798;
	bh=hfnuvnnigu7GiBMzTH5MQC/YrBHLtcuKAlxu0YESuEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkvWWGpU2qINFWAdNFOGLg6oOluylwW9MsvU6LMidtTQDMAck05PIjla8yrfyO6Sy
	 Qvq7aYHi1V+vgjPbnP67V8qlZXp4eVy2TEbAsM0vsKmuFnmBb7tiT3VYRL12kjKsz0
	 bVQvsvSuTgop+ZkRrsU2ufsph66qEvYwaPdwWXhU=
Date: Mon, 5 Aug 2024 20:33:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: LidongLI <wirelessdonghack@gmail.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	mark.esler@canonical.com, stf_xl@wp.pl
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <2024080507-unclog-spirited-e74b@gregkh>
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
> 
> Dear Greg,
> 
> Thank you for your response and for considering the details I've provided so far. I would like to offer further clarification on the vulnerability and why it warrants assigning a CVE.
> 
> ### Detailed Description of Vulnerability
> 
> 1. **Root Cause and Exploitability**:
>     - The vulnerability in question can be triggered by sending specific data packets to a device driver, causing a Null Pointer Dereference in the kernel. This results in a complete system crash and reboot.

Are you sure it's the sending random data and not the reset that is
causing this?  You also are attempting to send confused data while the
driver is binding, so of course it is going to get confused, how could
it not?

>     - While initially it appears to require root privileges, altering the Udev rules allows for exploiting this vulnerability from a non-root user space, significantly lowering the barrier for potential exploitation.

Exactly what udev rule changes are required?  And as that requires root
permission, that is not really that big of an issue, right?

> 2. **Impact on Systems**:   
>     - The root cause is a race condition between the userspace resetting the device and the kernel driver initializing it. This is not an edge case but a common scenario that could occur in systems where devices are frequently reset or reinitialized.
>     - By manipulating Udev rules, an attacker can create a persistent and repeatable method to exploit the vulnerability, leading to Denial of Service (DoS) conditions. This can be particularly disruptive in production environments, impacting servers, IoT devices, and embedded systems relying on Ubuntu.

If you can change udev rules, you own the machine, this is not a kernel
issue.  Again, there is a reason why normal users can't do this.

> 3. **Practical Implications**:
>     - The fact that this can be achieved through Udev rules modification is significant because it demonstrates a path to escalate privileges and attack vectors that can be exploited in real-world scenarios.
>     - Systems that are exposed to user-space applications needing device resets or control operations could be particularly vulnerable, especially in multi-user environments.
> 
> ### Experimental Evidence
> ### Setting Up Udev Rules: Granting Permissions to Your USB Device Without Using sudo
> 
> To grant permissions to your USB device without using `sudo`, you need to create a udev rules file. Follow these steps:
> 
> #### Create the Udev Rules File:
> 
> 1. Open a terminal and create the udev rules file with the following command:
> 
>  
>    sudo nano /etc/udev/rules.d/99-usb.rules
>    
> 
> 2. Add the rule: In the file, add the following content. Replace `YOUR_VENDOR_ID` and `YOUR_PRODUCT_ID` with your device's vendor ID and product ID.
> 
>    
>    SUBSYSTEM=="usb", ATTR{idVendor}=="148f", ATTR{idProduct}=="3070", MODE="0666"

So you are allowing any user to read/write to the device at the same
time the driver is bound to it, but again, you had to be root to allow
this to happen.

So unless a normal user can do this, with the default permissions, this
is just going to be a normal "fix up the usb driver to allow confused
data to not confuse it" which is a normal thing.  USB drivers were never
originally designed to allow for malicious devices.  We have slowly
changed this over time to allow for semi-malicious USB configuration
data to be handled properly, but we have not said "USB devices are not
fully trusted" yet.  If we want to do that, we need to do a lot of work
as that is not how Linux (or really any operating system) is designed at
the moment.

Again, we will be glad to fix up the individual bugs here as found, but
it's not a major issue as it's just something that someone with root
permissions can do to a machine, along with thousands of worse things :)

thanks,

greg k-h

