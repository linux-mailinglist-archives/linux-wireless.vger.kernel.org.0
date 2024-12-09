Return-Path: <linux-wireless+bounces-16026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0C89E8D22
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 09:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C769280A61
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 08:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938D0189B85;
	Mon,  9 Dec 2024 08:17:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533D215075
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732241; cv=none; b=GjDJ67tRQ5dbh5keXlFIfiE7lS08FtnlLOkzTpUOVfm+hW3G5DOLDNaBfT++JCi7sDqAoVqIA1IhE8V7mXP/zXtKWJEetjBlHaW9Iiv4cG6OQbusIbqmpjySlvJnGMpRSTeHdzaFjh1X6mQS0UAoipDD5cbcgasvdH0IZeAm9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732241; c=relaxed/simple;
	bh=Yfr2KvGs162TFvix7mRT+oKdohYAXvqJ5/uhyJ1r/To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c16pZO96Z7kWFIECS7sQ6pgmCCjgFK9eRDU6DEnnW4jIRgrCAcy4tKCj7OXj0V3iQG3V3ps37pJgMA7l7YyMw3x2utqmcnXzq+F5TZMiQLqNu1OVNO4Sze90vG1BdeKWe+8yDD2aubR95ishJVd78bNB6taUI/w9tm7hRj3rlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 111A868D0F; Mon,  9 Dec 2024 09:17:14 +0100 (CET)
Date: Mon, 9 Dec 2024 09:17:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
Message-ID: <20241209081714.GA25363@lst.de>
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com> <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com> <CAJ+vNU1-OZ3y4p2L+zf64AiVtUv70yZNqkT20jTxyE0_gJb6Jg@mail.gmail.com> <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com> <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I scrolled three pages before giving up as it was just quotes over
quotas.  Can you please write an email that contains whatever you're
trying to tell instead of just quotes?  Same for the person replying.


