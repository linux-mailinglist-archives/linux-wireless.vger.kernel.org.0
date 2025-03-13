Return-Path: <linux-wireless+bounces-20327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE37A5FA85
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 16:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CFF3AF234
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEDC267F7D;
	Thu, 13 Mar 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfygOIBn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8513AA2F;
	Thu, 13 Mar 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881469; cv=none; b=UNxCGlIEE+hVt9bNtTT0uXYItlrFzA8MCYWOywGeZeLHc6a5xRak1i2P4TFTrtUZ5Yn0j1phlxUXr87ITgLXiQwrBcF2734KLzOx3YnOMbxzvufSmnFG6CAhqmBqSJpIcDSyOGTOI9Tvwgs2aUeH+HUWQBpqS3OAde3+xI4pwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881469; c=relaxed/simple;
	bh=8xF8Ve++MFLvn3va/Rkql+bAxSWGx5T39bOEbMiYWV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umN390nSe9zL+NNTE/G23dr4ySTTFREqbMHKy/RFSvmU15wLTNVgE+Dmv4ABtcOicQwi39nqzF/8IDLuD73ahESjLy/VuwPWU85Wr8QBs7X7zuoNk0CwzRtnRSLS1Qa/NLyd6fKlWwsLorIQwbXtJudwGdnZEQ3QPqu9dc/6QoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfygOIBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A190C4CEEA;
	Thu, 13 Mar 2025 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741881469;
	bh=8xF8Ve++MFLvn3va/Rkql+bAxSWGx5T39bOEbMiYWV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfygOIBn+MElPBdc8pLT3Y2c7WzZIBn7MwCaeyRVq8JDPiauPA9nRZiYIya9SUAxU
	 /uGdfziFVrBA9My39MJlD4IakdbB4AcT3vpHhycx3vscpZhSpfTIFKdQGRa/eo+I+B
	 mJICM4n7Z9F1wzVsXv7FSgcTjJAq99Z65T5PNPbXuD7kDCAdVfxlzduSa0iICnXkE2
	 IBei5DyA3F1zZboSFbuByEpXXdC8Gre4XW5jp2qNooksCDufLa/jGl3lTxA9cOT0/O
	 GcafZDMAJNjtosrTrQQJkO4+ZYMBl+F+vHFWCNzKKIkQe+ZSJ4PXbHNeZLg+9/h1UW
	 zvUlnzxXZxBTg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tskwM-000000000Xu-0yWw;
	Thu, 13 Mar 2025 16:57:46 +0100
Date: Thu, 13 Mar 2025 16:57:46 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z9MAehaipGtwge8p@hovoldconsulting.com>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8251fc50-5df4-4a3f-91bf-40c09c33cf6e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8251fc50-5df4-4a3f-91bf-40c09c33cf6e@quicinc.com>

On Thu, Mar 13, 2025 at 09:41:51AM +0800, Miaoqing Pan wrote:
> On 3/13/2025 12:43 AM, Johan Hovold wrote:

> > I've taken a closer look at the driver and it seems like we're missing a
> > read barrier to make sure that the updated descriptor is not read until
> > after the head pointer.
> > 
> > Miaoqing, could you try the below patch with your reproducer and see if
> > it is enough to fix the corruption?
>
> Sure, the stress test is running.

Thanks.

> > If so I can resend with the warning removed and include a corresponding
> > fix for ath12k (it looks like there are further places where barriers
> > are missing too).

> If the DMA read barrier works, do you think my submitted patch series is 
> still needed? Because the error handling is incorrect.

Yeah, it would still be good to fix up the error handling even if you
don't expect to ever see a descriptor with length 0.

But unless the device is doing something wrong here, there shouldn't be
a need for peeking at the descriptor and retrying.

Johan

