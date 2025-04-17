Return-Path: <linux-wireless+bounces-21679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02120A91F1A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 16:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFC844348A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE84241686;
	Thu, 17 Apr 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qPg4OLLv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62EF23F405;
	Thu, 17 Apr 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898815; cv=none; b=D/FR2vKmkIddBKdkCshZulxOY4aBA6bdlylJlUJ0ypXSssWQYYT9mQY3JLHOWThrt7NlXyb666S3bq2OUvzH7vJPAz4Y1lO3C1aaDDWSq9Q7NleSYAO2qefifjCs84j/7STlJ5QcNkMRcmp2ZqlMf0Fu64456+l+OaHBzpz8XdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898815; c=relaxed/simple;
	bh=G/CpQx30Y88MN+qzB2w8bRti8jNP9bRewg2JJFOLcI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDYWOg3zV8o7TTNMx1siB8CZtbmZ+i3FxPg70bln/zloH+1ERKJud5s1T+/60YzAkFyAtw+jr6/kjsk2THtpzj/TWi70H00xtfW0bv3aZu+zx9EhvLeGnuDmUZbjoNN0QBaTe9lyLUoWy3z8HQggRajIa2lQEUpThe/fXTE9jV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qPg4OLLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12418C4CEE4;
	Thu, 17 Apr 2025 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744898814;
	bh=G/CpQx30Y88MN+qzB2w8bRti8jNP9bRewg2JJFOLcI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPg4OLLvodaWzlYau0x/ye3YnMD8x5pVbIu2hP40u0NCB5x6K+UF6Z0yCeazYwFZn
	 bS/9vqiP+YFUPK08e1m4PnNvCxA8Zi6ehLJW9UWO7Zf6qmpO2vk9NOfco8G63Ce2ae
	 e+1yHz6R0Ny4jbnzd2OJXylfF1GxI6fdtOekHrMs=
Date: Thu, 17 Apr 2025 16:06:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: 6.14.y regression in ath11k
Message-ID: <2025041740-tableware-flight-b781@gregkh>
References: <cab8e07a-84fa-48f3-ac6f-382148b20744@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab8e07a-84fa-48f3-ac6f-382148b20744@kernel.org>

On Tue, Apr 15, 2025 at 05:11:04PM -0500, Mario Limonciello wrote:
> Hello,
> 
> Matt Schwartz (cc) found a regression in 6.14.2 that the Steam Deck OLED
> took 45s to find a network after suspend/resume waiting for a timeout.
> This was a regression from 6.14.1.
> 
> The regression happened because:
> 
> commit 933ab187e679 ("wifi: ath11k: update channel list in reg notifier
> instead reg worker")
> was backported to 6.14.y without the other commit in the series:
> 
> commit 02aae8e2f957 ("wifi: ath11k: update channel list in worker when wait
> flag is set")
> 
> Backporting commit 02aae8e2f957 ("wifi: ath11k: update channel list in
> worker when wait flag is set") to 6.14.2 fixes the regression.
> 
> Can you please take this commit back to stable too?

Now queued up, thanks.

greg k-h

