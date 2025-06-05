Return-Path: <linux-wireless+bounces-23736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3BCACEC3F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6949A7A9886
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0E205AC1;
	Thu,  5 Jun 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnKPlq/w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8F1E7C03;
	Thu,  5 Jun 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113058; cv=none; b=NxurVoSRTcollaoP/vbLskTcIoWgtmNvQkjpjvk3vvJTWclVcFbNfz2nGvJLe6bEStVbnah3w+/4lcteepcEuTNwn+eyvXbAzb2w6tK/M9IAoHuPzAwtjgEuI4rpRWkFQ4sIsZVVYZ9fHNZlQlIgeyPQ98oFoHv29JlsK+98QRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113058; c=relaxed/simple;
	bh=lBPuO1YMAGHxrbRVxdgi7NFW6/i2QW0+MHmlw7SzfA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioH+5gCxkJL4sd+y8USlCmzL+uAsx28jkiJXtWo2eFi7qoDsXWCXHhe+3QvTlSR2jTHRNu2qWrEMmgc33TaXDP4/KOsX+YKiayz1K7f4j8Rad1OngmqYszxx3ybGFTOWEpxBy5JVxvHf4UyVobkk30pW8Ez2/1/mx3d/6UeKh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnKPlq/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6572C4CEE7;
	Thu,  5 Jun 2025 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749113057;
	bh=lBPuO1YMAGHxrbRVxdgi7NFW6/i2QW0+MHmlw7SzfA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnKPlq/wkIofiLCU7TdIMb9gY/E7MMpIhWZYHFdiVmGDYra2IfjsdTs1X5/iv8x7t
	 lhtv2vQbCI/XMpTJ1PJQhxys2qYC2GSNHaONU3t+Aj030R7aXzrU6x76oaGZL5cxy3
	 oXUXh/8DSp8mRHIGLAUyGwYWjCTrzQdIMC+avYhhh6I0x5uB5302f+6sAzPDPVLJHH
	 tEcMTg596emvT8GS3N9yYyDhd/DLZOgh2rXIdgAhwAqCvzCIcdLSlYYhYTvP58+6//
	 JevDj7vd0nYanHLlJupTt3uuCwSML09ZMrAS9UJPmVD0tbbrlJl0YORQEIqJYrL52j
	 tBh7BNz0SJpHg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uN6Cs-000000007lv-3jMS;
	Thu, 05 Jun 2025 10:44:14 +0200
Date: Thu, 5 Jun 2025 10:44:14 +0200
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] wifi: ath12k: fix dest ring-buffer corruption
Message-ID: <aEFY3iz2gXtF_Dgx@hovoldconsulting.com>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <257bf9e9-f4b2-4ab9-804f-b895243c924d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257bf9e9-f4b2-4ab9-804f-b895243c924d@quicinc.com>

On Thu, Jun 05, 2025 at 04:37:13PM +0800, Baochen Qiang wrote:
> On 6/4/2025 10:45 PM, Johan Hovold wrote:
> > As a follow up to commit:
> > 
> > 	b67d2cf14ea ("wifi: ath12k: fix ring-buffer corruption")
> > 
> > add the remaining missing memory barriers to make sure that destination
> > ring descriptors are read after the head pointers to avoid using stale
> > data on weakly ordered architectures like aarch64.
> > 
> > Also switch back to plain accesses for the descriptor fields which is
> > sufficient after the memory barrier.
> > 
> > New in v2 are two patches that add the missing barriers also for source
> > rings and when updating the tail pointer for destination rings.
> > 
> > To avoid leaking ring details from the "hal" (lmac or non-lmac), the
> > barriers are added to the ath12k_hal_srng_access_end() helper. For
> 
> Could you elaborate? what do you mean by "leaking ring details from the 'hal'"?

The type of barrier needed depends on the type of the ring. If we add
the barrier directly in the caller, the caller would need to know what
kind of ring (lmac or non-lmac) it is operating on, something which is
currently abstracted away in the hal helpers.

> > symmetry I therefore moved also the dest ring barriers into
> > ath12k_hal_srng_access_begin() and made the barrier conditional.

Johan

