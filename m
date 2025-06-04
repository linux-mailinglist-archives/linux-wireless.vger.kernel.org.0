Return-Path: <linux-wireless+bounces-23674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30FDACD82A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 08:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EBA7A2616
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 06:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E2322D4E9;
	Wed,  4 Jun 2025 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxe/+MNy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825061FCFF1;
	Wed,  4 Jun 2025 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749020344; cv=none; b=a5m15W8jY2OzRLMKixtO5sNE9wGbDg6o6XILsnoPvCQWsCoW6R3eVTl1s909JpnbQMX8DXogDDWnlqKh3nDnftG8I2Tx7baq4D6XdI04IVFc0FrH37MaIzV64tej6up1BVtggcfRn0uvfqmAT5UewA10yYapyBI7qMiPAPmlMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749020344; c=relaxed/simple;
	bh=4ool76+h1avcafnskE13QYqw2AH9ovgrTOZlRy9qy/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdEKrlmr2JB0qaB2bVIeME8cB47CPc8t7knep2TZP0Tc8FJ+GfThVHjykVsiRitAfAsayPt38RXeWTkTjcmwlh4buboWLWAXk1MTJm+JanQAtH4cJCjsGofoZxoOF5sVTvKH5MU2ee4vYRiVDrqb/1G/mr831jY68ALODNmB2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxe/+MNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA577C4CEE7;
	Wed,  4 Jun 2025 06:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749020344;
	bh=4ool76+h1avcafnskE13QYqw2AH9ovgrTOZlRy9qy/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxe/+MNyLJK2XBp+DPCdAolW1uXjLECZndM1av0cBQ3NFB4bfJ9G/B50FtMPNM5Tg
	 lQjURFC/E1w00f+3YhVciE7pv/AVMQAryUhTb+k/T4vtP9+EpPKu3ysuspARoMZymX
	 K/mkhP9iD5LgIMnYG5zmdAp9I7S0aWt9O9KEqanhMfZznfT6XSrdrhc5jNNGnTFgoc
	 MCQMHe24bmwDCuGq4oNh7GNY/QJ3JUVUFZrKNi3MfMibO49ytzt9Adjner7WDZWuE1
	 fuk0+AwQ40uhZ0Q3sUY+vqxYZXUMncZeZ4NVFOzbsI/NgYErzaZskoLu1jHsF5ujMb
	 q+ebW7suBpNvw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uMi5U-000000004PS-0kaw;
	Wed, 04 Jun 2025 08:59:00 +0200
Date: Wed, 4 Jun 2025 08:59:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
Message-ID: <aD_utNk4q23ewRAC@hovoldconsulting.com>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <b303ba1c-b521-44b4-9afc-cf1766f549ee@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b303ba1c-b521-44b4-9afc-cf1766f549ee@quicinc.com>

On Wed, Jun 04, 2025 at 10:16:23AM +0800, Baochen Qiang wrote:
> On 6/3/2025 7:51 PM, Johan Hovold wrote:
> > On Tue, Jun 03, 2025 at 06:52:37PM +0800, Baochen Qiang wrote:
> >> On 6/2/2025 4:03 PM, Johan Hovold wrote:
> > 
> >>> No, the barrier is needed between reading the head pointer and accessing
> >>> descriptor fields, that's what matters.
> >>>
> >>> You can still end up with reading stale descriptor data even when
> >>> ath11k_hal_srng_dst_get_next_entry() returns non-NULL due to speculation
> >>> (that's what happens on the X13s).
> >>
> >> The fact is that a dma_rmb() does not even prevent speculation, no matter where it is
> >> placed, right?
> > 
> > It prevents the speculated load from being used.
> 
> Sorry, still not get it. To my knowledge whether the speculated load (steps 3 and 4) would
> get used depends on whether the condition check pass in step 2. How does a dma_rmb() make
> any difference in this process?

It orders the two loads from the device so that the descriptor is not
(speculatively) loaded before the head pointer.

When the CPU sees the updated head pointer it may otherwise proceed with
using stale descriptor data. The barrier prevents this.

Johan

