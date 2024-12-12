Return-Path: <linux-wireless+bounces-16290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A729EE020
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 08:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C761881CFC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B81185B67;
	Thu, 12 Dec 2024 07:18:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C52259485
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987935; cv=none; b=MYbJfMpvmqgSSdE5Qiy2Cz+ex2ySKTC2i0cUObnojEEpABhkt+/Yo7EkynRz60ABHv8fVBOI1i+eaIOgf4WGIdzoH9WpZbL1/QfLztV/pMxsAY2robegkwG1QNE0TEj9Z7b7MgMutpFZLN3+JeFxdwVAdIu5Q9zTXPj8r+zux8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987935; c=relaxed/simple;
	bh=ureIN7gk8qiX/gfigB7a9KWHcqcUaVkWXDUpl1YVAqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBb1ZJKCOjvTZY7jMUtGaoboIKn+8VzNfr4K6lXh7nlAyCnWBumXebOwY2s9aWU8LBhseki7aGDSguABgngHKm9byYLADEkhvzaAAdM6y45y7lhgfR5MV4/oHoHRwL7KiFd9L2oaqAWnr11JeypZXW8VxJetOzCnrcWuPkgRgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21C0068D07; Thu, 12 Dec 2024 08:18:49 +0100 (CET)
Date: Thu, 12 Dec 2024 08:18:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Tim Harvey <tharvey@gateworks.com>,
	Christoph Hellwig <hch@lst.de>, ath11k@lists.infradead.org,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
Message-ID: <20241212071848.GB6638@lst.de>
References: <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com> <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com> <20241209081714.GA25363@lst.de> <593c0d63-d8fd-4439-a57a-97340212c197@arm.com> <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com> <20241210041133.GA17116@lst.de> <CAJ+vNU03Cqsc+O5anwmvJW8Wfd-06LbDMVHjxVFdixf01ZLczQ@mail.gmail.com> <5fe372df-ae51-4a8b-9fa3-a4a0ea2d33e3@quicinc.com> <9b2e8ffa-ba2c-46da-a478-eb1fb44b693e@arm.com> <80992ae5-e329-4a34-94c8-9345b2e8a9a0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80992ae5-e329-4a34-94c8-9345b2e8a9a0@quicinc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 01:24:45PM +0800, Baochen Qiang wrote:
> yeah, you are right, Robin. didn't know there are convenient interfaces
> like these already.

FYI, the DMA-API documentation says pretty straight forward to not
use the streaming API and documents these interfaces.  But maybe it's
not clear enough, so I'm open to suggestions on how to make it more
obvious.


