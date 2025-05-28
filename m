Return-Path: <linux-wireless+bounces-23467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C686EAC67AC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 12:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FE3168AB9
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0012F217660;
	Wed, 28 May 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="IAKZU0ne"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD627A10D;
	Wed, 28 May 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429356; cv=none; b=mR9xIFoy1DhT/yG/mvthmQNMfRGj6Y3Qg7SqYT5gAwCSbadVzT5nAbDHooo/2/uXUQmhzxzsgbvKg4/N7/Xxh4De9h92MJONRv/WBtaI3sL4pOOnF6M+lHESGNTvdiXUBt7PeZufYopRBHaLaZrpQOjhvPNHtvicW1b1Ix9HliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429356; c=relaxed/simple;
	bh=2wB4/cPoFm3OXX9771W7ufP4Q/ZEn3+bk/2YQsFoIG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWv6JLkiY9GjyK3XDtlMV6Bff3tVUjhfHXVSyd0jO8PMpLKiKzrIlisPpkr3jikAdPlJ4E13Hmh+49HIYzmkaloUVsZBHrGRlL7J/E7+qpulmYtyBLIS/WwVVYVng7Tn08vJlVXcnMAEYR4qhrPqkqxmGRTdQYsKUUQ/VbCEYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=IAKZU0ne; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 6CD142061D;
	Wed, 28 May 2025 12:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1748429343;
	bh=ctWIGAfV+2xqbTqtd5B9TbgiUUECcoY8bn9T9Tj3nxc=; h=From:To:Subject;
	b=IAKZU0neYvPKCSVtv+bVLj/0A4wBhKSlf0gbnidjG6nAGwsZXj4XxshsuA022HFLV
	 oGjm3zSB44FBcY7ux6XQFvF8q3PoLNIU3l5Ky+05bp0NXEACe1ZMm/jOHfyk4mZuyw
	 3/XOxLu5syA6Dv7tlf3rUgFIOtSg2fNHYCuS33/nYz5CrvWth0nJ5zLNjHI3vOz49P
	 qrU8yhWncRjWSu93E8z52quGVBPMmaCtafBM+dZoTGm4B6pyUxHPEbYGkKaZPrpm0p
	 HOeKdeiOVQXoO70AuPQ+6745nZkUIPuXZ0T6OEl6GSfoDlmSIKhfWB2UGUJtYvnUE1
	 cfML0jlDBYKDA==
Date: Wed, 28 May 2025 12:48:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: rafael@beims.me
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: enable host mlme on sdio W8997 chipsets
Message-ID: <20250528104859.GA38749@francesco-nb>
References: <20250521101950.1220793-1-rafael@beims.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521101950.1220793-1-rafael@beims.me>

On Wed, May 21, 2025 at 07:19:34AM -0300, rafael@beims.me wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
> 
> Enable the host mlme flag for W8997 chipsets so WPA3 can be used.
> This feature depends on firmware support (V2 API key), which may not be
> available in all available firmwares.
> 
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


