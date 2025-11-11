Return-Path: <linux-wireless+bounces-28854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA62C4EF32
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 17:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 024164E1D0E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B9536A02E;
	Tue, 11 Nov 2025 16:13:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0243590CC;
	Tue, 11 Nov 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877611; cv=none; b=T3QYRB9ZWrVjGvbsBvT8X86ctTkQHj4GMSbPJJBN3eyJekpS+id1ADZSNMkPdVOfVFqpP8ZPYm6Az4QjFjdwwkNysgHYv7nGq3lgNPUWRBY0vhLUhrUHkN1mWhx1TP9QlT8Tk9EabXu2Uu9dk8tkOCRZo5jXM0pxWz9pqhvzND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877611; c=relaxed/simple;
	bh=9EUNThJ72fzEPiECWVkwXcbtQqJZfgLghn4IjhE9oMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApaRNeczubN557iKeAJricej7/GefFgu/DexkSehknHwGAh+GUThRZlLqHMFdqI42GEBfxqn8DJ6mDkNPgxRlJzeNX5eYJFPRuKPWifNF7Kk5J7CMRGlUIkEQ4ca+cvJk0AgvskjP5hSDoN+mSqwgH9Jo+uvea/tbonQnlFFTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id F3ECD7F75B; Tue, 11 Nov 2025 18:06:17 +0200 (EET)
Date: Tue, 11 Nov 2025 18:06:17 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Antony Kolitsos <zeusomighty@hotmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] wifi: mwl8k: inject DSSS Parameter Set element into
 beacons if missing
Message-ID: <aRNe-VdyGrvumVok@wantstofly.org>
References: <20251111100733.2825970-3-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111100733.2825970-3-paweldembicki@gmail.com>

On Tue, Nov 11, 2025 at 11:07:29AM +0100, Pawel Dembicki wrote:

> Some Marvell AP firmware used with mwl8k misbehaves when beacon frames
> do not contain a WLAN_EID_DS_PARAMS element with the current channel.
> It was reported on OpenWrt Github issues [0].
> 
> When hostapd/mac80211 omits DSSS Parameter Set from the beacon (which is
> valid on some bands), the firmware stops transmitting sane frames and RX
> status starts reporting bogus channel information. This makes AP mode
> unusable.
> 
> Newer Marvell drivers (mwlwifi [1]) hard-code DSSS Parameter Set into
> AP beacons for all chips, which suggests this is a firmware requirement
> rather than a mwl8k-specific quirk.
> 
> Mirror that behaviour in mwl8k: when setting the beacon, check if
> WLAN_EID_DS_PARAMS is present, and if not, extend the beacon and inject
> a DSSS Parameter Set element, using the current channel from
> hw->conf.chandef.chan.
> 
> Tested on Linksys EA4500 (88W8366).

Given that I was CCd on this email -- I no longer have the hardware to
test this, but I can believe that the firmware would have such an issue,
and you seem to know what you are doing, so this seems conceptually OK
to me, for whatever that is worth.

