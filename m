Return-Path: <linux-wireless+bounces-12803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E26975D52
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 00:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01FA285565
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 22:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB38186607;
	Wed, 11 Sep 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW8XFown"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699015442D;
	Wed, 11 Sep 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726094298; cv=none; b=W1gagPjIxuOL5d304xyHU2Osvbk8P2FbGKYZ6LIcMN3YXKc6lZnJsAIpQgzuw3/G/7ZV3Ne4xqGaU9SRCzeEUGr84ikD3Caqukx0QP4riSAsJfAlmmeHQGyiH4THp/TQjS9B/QL1lMwWwVYXVHcD9ePN20+2wCDmba6W3KiB+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726094298; c=relaxed/simple;
	bh=WZZRjMHs42kc4ejyrwwcK0I7wjv8P2rfbF3RRm4Ulhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/qSWaPruNQRAH5Z4ArVpT00ZYMgHnCnpqy3GQh+hxaPfiSXLoDSnbhYn4aiKukfrddP62mDyRYcrbXPeDsePrH76cVrsM39HIwnv4hRXxUMb/tjmlWYA/yrbte39+iz8hN3wF7V7RCehkExSCr3nnmonVptefvIl2/WzsQS+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW8XFown; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED98FC4CEC0;
	Wed, 11 Sep 2024 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726094298;
	bh=WZZRjMHs42kc4ejyrwwcK0I7wjv8P2rfbF3RRm4Ulhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WW8XFownp7B7v/cgyTTRqNxHbF7JoNaUr7QPgTLV8MamN1Kt7sL9CBAVAhdHYXTvp
	 BObXLQjo5zLTeZEJyIQuQXOFA5RkM+Z1tS9dIehii4eT0Nuj9n2PVIAu8V7FXBWxDi
	 v4oER4yu33eBpP9sLfWaQ9jsDYp1md2S+iIpo4Psl3HUZp0mOkfpniL89FQXaE07/p
	 cAU3i8hYoME0TUZFwTjIAcpKju8N5h2FBHmWmPNxhUGGBKPyiR+iquw/FDJ95ZUEiu
	 b/vmy2oZHaP4V+RTv6Hm4dzzv2TfiQ9EFkzxi0ItaHCTCj7NiLwShh8Om92cT9Bips
	 8ImfrHFMdzMgA==
Date: Wed, 11 Sep 2024 15:38:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-09-11
Message-ID: <20240911153817.0c150bc6@kernel.org>
In-Reply-To: <20240911153633.7a01a6c7@kernel.org>
References: <20240911084147.A205DC4AF0F@smtp.kernel.org>
	<20240911134521.7f510329@kernel.org>
	<87ikv1bz8e.fsf@kernel.org>
	<20240911153633.7a01a6c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 15:36:33 -0700 Jakub Kicinski wrote:
> > What's the deadline for these? Do you need the fixes tomorrow or can it
> > wait a week or two?  
> 
> It can wait, half of them are old anyway

Oh, that's because they are in staging :) I missed that.
But anyway, I don't think that a harmless, single compiler, 
W=1 warning is a blocker.

