Return-Path: <linux-wireless+bounces-23769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F94ACEF02
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8DE3ACFBF
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 12:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7723214813;
	Thu,  5 Jun 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="w+GQi1BB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3420C026;
	Thu,  5 Jun 2025 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749125701; cv=none; b=jZi5HSpZhY/qzA0KL3cxAZuPI0X7iV3cNzjQ2T13M2YvMtNHQpE+VPNZsmfmyXWvUjPDP7pXmrM0okgsPA2yoX40hRr/EAycC7OWDIiQ49UVhd5LFMXx07odOD/A3GZQFvx66jUre7hEI31LPuxhDrnVoCORMQdkMM3oYuohfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749125701; c=relaxed/simple;
	bh=uXPuySW/2mRvaR0v35BShBQ43Iwx1yz1Vo1lzg4NP84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myyvqUZ9BlrlKzcWugeYyUE919EfCFCGbByfOe7GxPPzsKm5bJFN6LOyUHCj24l+CPWdRnTuNEXGi8IaLx8oRH3BZeXxxnp+1M1ICqFyXsHf1hw1HMh0LBcVS4TRX84iq5NZfbnTUi9w/AMn38D8Zs4Iyn+pbSf1Rmbkg4qu74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=w+GQi1BB; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5187A22475;
	Thu,  5 Jun 2025 14:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1749125696;
	bh=sAXF4RHm4VzO/0RxTV4aH2pTUaWhFW39ZUyi8/v0sHI=; h=From:To:Subject;
	b=w+GQi1BBPUWOmXFPV0prb48zim6Mp7BVudEAFZN+QK6QIpXIlGkggqaXNvGPydqIh
	 SsEZdoxL8b6IpYXTnReYxIjHeKsqPh374zKnfxg2yborgSG5UIsBHAuYmajM0BLl0W
	 th+D5bumLID1jN5sp2bjBsRKs9Xqy2U/BWjd9yOY8mmxDD9To6/bKHeopaIVEBZCkY
	 C7mPPDRY9eii+D20pn6aeW0dx4/NQfYPKIeSrQFu1/FAoNBzC2JNyZNOL5fPm1wW6/
	 Ca6FcmwK49pOT5facDLiBnSZeWXo01Z/lU8lUMzLEY51sHO3TnMXzZw4eYi1zrwdGN
	 UF4PZnkNcc17g==
Date: Thu, 5 Jun 2025 14:14:52 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Chen <jeff.chen_1@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH wireless v1] Revert "wifi: mwifiex: Fix HT40 bandwidth
 issue."
Message-ID: <20250605121452.GA48603@francesco-nb>
References: <20250605100313.34014-1-francesco@dolcini.it>
 <0706792a7d08d7bcfdf7fa929cd5f1afc80e3f19.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0706792a7d08d7bcfdf7fa929cd5f1afc80e3f19.camel@sipsolutions.net>

On Thu, Jun 05, 2025 at 01:40:41PM +0200, Johannes Berg wrote:
> On Thu, 2025-06-05 at 12:03 +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > This reverts commit 34253084291cb210b251d64657958b8041ce4ab1.
> 
> I'm confused. If you want it reverted in wireless, this is the wrong
> sha1? If you want bit only reverted in stable, why are you tagging it
> for wireless?

Because I did a mistake :-( This is supposed to be reverted on Linus
tree, not just in stable, I'll send a v2 with this fixed, sorry.

Francesco


