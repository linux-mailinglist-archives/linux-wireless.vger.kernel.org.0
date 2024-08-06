Return-Path: <linux-wireless+bounces-10993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB794896D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 08:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106B8B23BBE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 06:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E061BBBD6;
	Tue,  6 Aug 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F2GAIrlc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73011C32;
	Tue,  6 Aug 2024 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926073; cv=none; b=gtCF7ZyvCxxOiu0X1IFQAJzjjD3kPJ4Be3XPvU/nPNk/SS3/CS6/LCeJHlmsW66wzuYNYK2RdagJBN3E7XN+QFp2AhNAYpn1FmVr8SX+jsyB8cPKW3zfR4ZT/KDuQhGxTc7EurYdLFWFCPAH/YgQMYh+PTEuRUGxgqFZJJbCvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926073; c=relaxed/simple;
	bh=6ny41v/q49fMjNsqi+mIAkC6G8FjCC31xWJaGYUQ200=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti+2X+ZsFk2VMzKjgYwQfcSPkEFe8GKMYsPzbOh91cM6Z1R73cEFDtYb/dUNmzlcIMTXjoFUYD/1daHAxTSZjH0Ku01nKjg9Hksqe92z/+yjcezOeBQaKoRch9eV5VS423TqIjtvCGZVCdrlU9i3rwaChdLD2LByURbcbtcomow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F2GAIrlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD881C32786;
	Tue,  6 Aug 2024 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722926072;
	bh=6ny41v/q49fMjNsqi+mIAkC6G8FjCC31xWJaGYUQ200=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2GAIrlcrxXc6TMYbdTnXK42ReHpcb9cXU5uN11s0Mi/IJYlxZg9ohGgPgF2RytFP
	 DrUeGkcYF1uoOHp4u4xbsiCzch1O5zq4MaG7iBGWfAgi+MIDVruFYAPHLqu8yadN9Q
	 adFptSJUivhMWy6u6x60GOxva0VjAsGs+yyeuvmI=
Date: Tue, 6 Aug 2024 08:34:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: LidongLI <wirelessdonghack@gmail.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	mark.esler@canonical.com, stf_xl@wp.pl
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <2024080640-senate-pushcart-c95e@gregkh>
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
> 
> Hi Ted,
> 
> Thank you for your detailed response.
> 
> An attacker doesn't need to create a udev rule in the user's path because that isn't feasible. We need to consider scenarios where certain special devices (embedded systems) are designed from the outset with RT2X00 wireless network cards included in the udev rules. This is because they need to perform custom or automated functions related to the embedded system's operations.
> 
> Therefore, what I want to emphasize is that while this vulnerability may not affect users who do not have udev rules configured, setting udev rules is not inherently insecure. It is a normal configuration. Without udev rules, USB devices cannot be properly invoked or perform additional functions under certain conditions. It's a necessary feature.
> 
> However, for users utilizing RT2X00 drivers with this normal configuration, it directly allows the execution of the script without sudo, leading to a system crash. This indicates that the RT2X00 driver itself has a vulnerability that needs to be addressed. A robust and secure kernel and driver should not crash or dereference a null pointer regardless of the script run or the permissions used. We tested other drivers and did not encounter similar issues.
> 
> I believe this issue should be considered from two aspects:
> 
> 1.The vulnerability indeed requires certain conditions to be triggered, but the configuration required is normal and necessary.

No, the configuration is not normal or necessary at all, there is no
such default udev rule, or system configuration that allows what you
have found to be triggered by a normal user without root permissions.

If you think there is a bug in the kernel here, wonderful, please submit
a kernel patch to resolve the issue and we will be glad to review it.

I don't have time to look into this until next week due to travel, so
unless someone else picks it up before then, nothing new is going to
happen on it.

thanks,

greg k-h

