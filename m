Return-Path: <linux-wireless+bounces-23747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB862ACED65
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 12:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDCC1731A6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB251FECDF;
	Thu,  5 Jun 2025 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld7ilh3P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFC1DDC1A;
	Thu,  5 Jun 2025 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749118632; cv=none; b=m/VYiHrQ0MYa1rcbCR96hipn6c2/tfQRIKaciXHH5UI/9fZxcQVZ+DtUeJ3ju/HHzx/Yv3iAf1/YAU8E+guj+7CtzhNdSVAV0HoO7s4232jGrSAo0aB9loNlo6jV+/Mc/AcGou8kBRatNGY2lLWcNOt99B48CdiaREsWLIiiEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749118632; c=relaxed/simple;
	bh=a6T6uy8JJqaAh2fWN1bXbqlR42gQ+U00pJPQTvacV20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKzaA5YGovAQCTAxV79Sa8GbkJBzEeWvEYGpzoEFIyUrhLayeVsGdXCNlsU8tUP3Gxc0ucm38xmWL5zc8smopVrndRaJoxNGhIo8zpBh814XgGdwi3AHg0qLPs9HQ7l8K3rct0OwppwgvTfD0baqib4hpgKhKd1/mU0oGeD2SRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld7ilh3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074DDC4CEE7;
	Thu,  5 Jun 2025 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749118632;
	bh=a6T6uy8JJqaAh2fWN1bXbqlR42gQ+U00pJPQTvacV20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ld7ilh3Plwes2xGUoCEz02MwqG898KcFcfG11jtm8kyHH1kG8NVkggqIVftn3lmmD
	 LIeDLh997sbEFy2dWy2hYI/xgoX9tu7RS6aJ+Z4oFWqM/W0aJKYUNJzusO4VVzWMJi
	 jEqaMgMl4EDX5Sq40ALuuQLQ45cqJoZ+i3EGaDYDGux9+HuU6pfN6roylCinu+2+7w
	 oXUT4HblMekgsEr7DNOpXHAjM6GA92BjspXswI+bS/7/2hxINIidtPj6OG29dk/Jpk
	 VrX4HN0XaxkIzi3Pfveui01npJpTFKHLiMDf9xknSUElHazUg6pFo56exbp9hc9T7B
	 Lds+h+lQDVlOA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uN7em-000000000rV-35Nq;
	Thu, 05 Jun 2025 12:17:09 +0200
Date: Thu, 5 Jun 2025 12:17:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
Message-ID: <aEFupJ_nd9ryaTVt@hovoldconsulting.com>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
 <50555c1a-c200-4ac0-8dfb-424ff121b41d@oss.qualcomm.com>
 <03354d56-ed21-47e0-a52e-14f559ff3bfb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03354d56-ed21-47e0-a52e-14f559ff3bfb@quicinc.com>

On Thu, Jun 05, 2025 at 12:01:29PM +0800, Miaoqing Pan wrote:
> On 6/5/2025 12:24 AM, Jeff Johnson wrote:
> > On 6/3/2025 7:34 PM, Miaoqing Pan wrote:
> >> We previously had extensive discussions on this topic in the
> >> https://lore.kernel.org/linux-wireless/ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com/
> >> thread. On my platform, dma_rmb() did not work as expected. The issue
> >> only disappeared after disabling PCIe endpoint relaxed ordering in
> >> firmware side. So it seems that HP was updated (Memory write) before
> >> descriptor (Memory write), which led to the problem.
> > 
> > Have all ath11k and ath12k firmware been updated to prevent this problem from
> > the firmware side?
> > 
> No, as this is not a widespread issue, and addressing it would require 
> modifying the core underlying modules of the firmware. Therefore, we 
> chose not to proceed with that approach but instead used the workaround 
> patch I previously submitted.

I strongly suggest you fix this at the firmware level rather than try to
work around it in the kernel to avoid playing whack-a-mole whenever a
new (hard to track down) bug shows up.

The barriers should be enough, but if they are not then the firmware
must be fixed.

Johan

