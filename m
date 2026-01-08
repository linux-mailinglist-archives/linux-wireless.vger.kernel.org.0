Return-Path: <linux-wireless+bounces-30536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 134C4D043F3
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DF7B308B744
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5C429822;
	Thu,  8 Jan 2026 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTPnrl9V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF442A10E;
	Thu,  8 Jan 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863995; cv=none; b=iYA8AMfW1RAdSt2qZJuS0Xeonh+TTS/9gY0un4UreTFrKoKRFTPkLvDfleTnbeInPb3bUN8MNkqVFkKBeR47GoMOA0J20+tRHYTEVBGmwEY7Kxni27mE1r0a4K3LzqpWYBZofsoffPlZHOAiAv9pfbxCaxPvHG8+m/OW4C6xhZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863995; c=relaxed/simple;
	bh=qL25UQgu73DpIJbh6YqYYEjDQmIvYBfMDMhKVBSF94A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWoGTvOppG3mj/TDVIPIjU6cS40Q5dZepwT9tpZyYklnfYIQVGzdRY5mtAKaKEy2HOHROeoWk0n2N3NgV1MXh+3VWH3Cfkxtt9sQJzBXZLo/QWfNS3wDjA0RsBmAukY8SWBCQsK0r2rWyzZrGdCL8sa75ywXY07zH2hhA0v952g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTPnrl9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEF7C116C6;
	Thu,  8 Jan 2026 09:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767863994;
	bh=qL25UQgu73DpIJbh6YqYYEjDQmIvYBfMDMhKVBSF94A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTPnrl9VwZVFdl/S5OUznG7CAk4EdX4jRTy58jBw11rt9YoUWRW0Rf5v6KuJgZcMS
	 PrGjizpO9ghTJJ5QKSGUQeMPEpwg/leAOpvoe3Q93lb+kt4uucsXvDAbqEwCng+XXV
	 5Tg4QZ49pBLpTb/TtMEB7cYwwA34H4y3cnpDs6zY=
Date: Thu, 8 Jan 2026 10:19:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Dylan E." <dylan.eskew@candelatech.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, sashal@kernel.org,
	jjohnson@kernel.org
Subject: Re: [BUG 6.18.2] Null Pointer Exception in Fair Scheduler
Message-ID: <2026010836-pony-driveway-65ab@gregkh>
References: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
 <e5cba37b-2bb5-46fb-b414-5cc6b2e894cf@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5cba37b-2bb5-46fb-b414-5cc6b2e894cf@candelatech.com>

On Tue, Jan 06, 2026 at 10:56:49AM -0800, Dylan E. wrote:
> Hello again,
> 
> On 6.18.3, I'm still seeing the scheduler NPE pop-up, though this one
> happened at shutdown. Looks to be an identical location to the previous
> stack trace.

I don't think the fix landed in 6.18.3, can you try 6.18.4?

thanks,

greg k-h

