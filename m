Return-Path: <linux-wireless+bounces-30138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B26CDFB52
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 13:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA6C6302035F
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6FA330B1D;
	Sat, 27 Dec 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GlBW141f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B4330B19;
	Sat, 27 Dec 2025 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766838355; cv=none; b=MANfzFIxbZZzqtp3SIRtbVwsx0HHY4apfVbaJXYEKr5dkrYEYskb/NLX1HTx5cAws6SkAUpqi5xOwpuZi9HwW3Gd7ejn88IfkxX/zylPhB7q2zbt850nCA+P8yy31VikrrqNAfmzNJY/dPojP3hoDgL1OaJvmOEHugYCMSVJNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766838355; c=relaxed/simple;
	bh=pcv7JOz90KS/ympIYL2/RwqEfc8myrTrNEU4bzskd+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyPZYpP0vwlqlJA/xU1wNZIoqA0pyFUB9QILvaOMDsezCbztHIRmiwZgG/kdIgJgyMkE9vduoRW/0/eHpfXM5d9JDIv8rLT+wsTVAEivOXHoHzV2r86uf5km9v/T2Ne117rky+41ZLY2FB3KJdZS3u60Q5e8N7/hKGx2Q74lmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GlBW141f; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766838350;
	bh=pcv7JOz90KS/ympIYL2/RwqEfc8myrTrNEU4bzskd+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlBW141f3JLD6koSAPz8P9KbFq1Dog8Nmf6ps5pJsuXAbuSnWRyFAlrvadAjjP04z
	 +wxDaTy7NhPvNbkCGcYFkXbMkb5B0irxegt72eUF4X9//2MvZiCciZn2jx6M7/+8Pc
	 rRV6+KsTH0/+t++aSjoN5VkqfnzDF82gueIC93qc=
Date: Sat, 27 Dec 2025 13:25:49 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: quan.zhou@mediatek.com, Felix Fietkau <nbd@nbd.name>, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-wireless@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linux-mediatek@lists.infradead.org, shuah <shuah@kernel.org>
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
Message-ID: <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>

Hi Shuah,

On 2025-12-27 02:07:24-0700, Shuah Khan wrote:
> mt7921e doesn't load on my primary laptopn on Linux 6.19-rc1 and problem
> still there on 6.19-rc2.

This should be a duplicate of
https://lore.kernel.org/all/CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com/

(...)


Thomas

