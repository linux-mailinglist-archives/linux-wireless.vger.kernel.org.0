Return-Path: <linux-wireless+bounces-22278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E346AAA4D68
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531A2179841
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FBF25D1E7;
	Wed, 30 Apr 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="qhqwZ2Tr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532425B660;
	Wed, 30 Apr 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019521; cv=none; b=dOM/A2hYrO7omvSKKR9I7BGYsD6p+iZ6N+HYd4cQvzvuWi3O9wEWKfYirahcv9AQtowMFafEWg6MTELY8pR8a0PrmredKHFn7sHHUW28EOJwSypVUfnaapW6hhyoZQntyB05t5HOiryMdAb2490ns5gNjYUiuxUQlrv/MJsHFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019521; c=relaxed/simple;
	bh=4xI2FfC5QlPZbaJ/Nrm4Yb/G1IL+bmRQYl1R67NObQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSkdzNhAFYzQ/prXMzxyxNYtLZXNld/2gk3paDcPpW5JZv9qS4lspyWyC8djk0HW6m5Pq+U5JCTMd1ZsAvWkON5DL/9Ao3T6rqLgmaa0LDwHj3p2H8yLXTT0KbgmkHPo1EkcUIZXA6S5IzmmVXZtRSUMIb1PdaMEQmciaMMPW2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=qhqwZ2Tr; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1746019509; bh=4xI2FfC5QlPZbaJ/Nrm4Yb/G1IL+bmRQYl1R67NObQg=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=qhqwZ2Tr6yYbE8THGIChkynfpQgSVDWZ8434EZ8KObNzHDSp2urS9IdxtUrVzyDkP
	 KLxKQ+TKIEYSkQPPUU0w6XwjfWDVHsow2A0HP4ogRu5pdDTFUMLjBz9KpiljevYFoN
	 wu9aFCMROJEnjkhcAZ13ESymcKSw2HI8QzYETmk8=
Date: Wed, 30 Apr 2025 15:25:08 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rtw-next v3 2/2] wifi: rtw89: Fix inadverent sharing of
 struct ieee80211_supported_band data
Message-ID: <bbxt6utodrn7ihxoaenv5elwh4gerlkglmzjfkctimwob5srzx@fe4lsb2aaa5l>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250429122916.1734879-1-megi@xff.cz>
 <20250429122916.1734879-3-megi@xff.cz>
 <7b2405f82b8f4b879d10453dde55a7f3@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b2405f82b8f4b879d10453dde55a7f3@realtek.com>

On Wed, Apr 30, 2025 at 12:16:47AM +0000, Ping-Ke Shih wrote:
> Ondřej Jirman <megi@xff.cz> wrote:
> > 
> > Internally wiphy writes to individual channels in this structure,
> > so we must not share one static definition of channel list between
> > multiple device instances, because that causes hard to debug
> > breakage.
> > 
> > For example, with two rtw89 driven devices in the system, channel
> > information may get incoherent, preventing channel use.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> Thanks for your prompt work. :-)

You're welcome. I like rtw89 supported cards very much for my home AP. I'm
glad I'll now be able to use multitudes of them in one router. :-D

Thanks for upstreaming and maintaining the Linux driver. My AP has been
working solidly for me since the driver gained AP support, which is
great, especially given how much development it's receiving.

Best regards,
	o.

