Return-Path: <linux-wireless+bounces-3566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4782854152
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 02:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A0F1F2254D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86385290C;
	Wed, 14 Feb 2024 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avm30gpG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E62563;
	Wed, 14 Feb 2024 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874996; cv=none; b=FvEsGVJucM4Rqi7Bo8i3eKSVa4qVjiGfyTyjgLaej6csWTllcWwMTLR4/nDxxwqgiE7XEB4V3OdyALG4HBm0/7Sqd/OfqbYTB1iYDHeguW6lBK1oHoL2JIDnLFG+5bQxM2hADsqzM18gNV8GEOIZNhzyPWtcEzZi/4VyN1v+83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874996; c=relaxed/simple;
	bh=nR1F3sMgPwBtW+NSjhinkD81NF0kMwFliFyYB37a+jM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umGN6DaXeI18QcwkXu97doteFnaRZJwKSDzXiOq8GO4WPFbcGEVI5eALasVyp0rCwtrEqYJ9QpEHHBu+DfRIFdOKz3Ao+BpaQnx7mougpbgov/HlrPkmPm2tQU0aJ3Dswa51lUinRQUwC+Sqkg5xm1UpNpl9KhTvoWS/uTTnA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avm30gpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D48C433C7;
	Wed, 14 Feb 2024 01:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707874995;
	bh=nR1F3sMgPwBtW+NSjhinkD81NF0kMwFliFyYB37a+jM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=avm30gpGDtT3vSTkQx2OFWuteOYnXZ5oCuICoFvWSEX63RGPi5ZieVTbLg7gpukLv
	 zbiRVol9moPwQ47o16/T/ieXsfGkgarn+4h/SvL3ww3SuH9SxosuscHT2LrxBEoRXg
	 zMWAx70HF9YuoN7GXmB9io3kyz6ScHP0BxCTHKNFzbUfVLyZE6zVlHBvxprXaTX13q
	 nXfVUttVqWELTQZ63cjNjJlRUMh1TM96fSHltbA1tRKfRzRKjO4bY63z/mikhhzcda
	 IrGqdgku8NupanM44MiF+lc7sQU8bRRolncjHabx4BRU3+UnmAJ8GPNdm/MYv7N0w6
	 wb++Ui48BD5/w==
Date: Tue, 13 Feb 2024 17:43:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>, Vinayak Yadawad 
 <vinayak.yadawad@broadcom.com>, linux-wireless@vger.kernel.org,
 jithu.jance@broadcom.com, Arend van Spriel <arend.vanspriel@broadcom.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
Message-ID: <20240213174314.26982cd8@kernel.org>
In-Reply-To: <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
References: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	<87mss6f8jh.fsf@kernel.org>
	<2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 20:58:51 +0100 Johannes Berg wrote:
> And @Broadcom: we really _want_ you to contribute upstream. But that
> shouldn't be dumping APIs over the wall when you need them and letting
> us sort out everything else ...

I may be missing the point but is there any official way we can
designate level of vendor involvement? MAINTAINERS seems like 
the most basic, and we have

BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS
M:	Arend van Spriel <arend.vanspriel@broadcom.com>
L:	linux-wireless@vger.kernel.org
L:	brcm80211@lists.linux.dev
L:	brcm80211-dev-list.pdl@broadcom.com
S:	Supported
F:	drivers/net/wireless/broadcom/brcm80211/
F:	include/linux/platform_data/brcmfmac.h

where (for the uninitiated):

   Supported:	Someone is actually paid to look after this.

It doesn't seem like Arend is afforded much paid time "to look after
this".

On the Ethernet side I have a nebulous hope to require vendors who want
the "Supported" status to run our in-tree tests against their HW daily.
As a way to trigger the loss of status. Otherwise it's hard to catch
people drifting away.

