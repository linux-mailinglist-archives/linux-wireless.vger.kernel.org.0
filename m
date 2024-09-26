Return-Path: <linux-wireless+bounces-13226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979AC987459
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 15:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C422E1C2276A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B18156CA;
	Thu, 26 Sep 2024 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="stWQKE3G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E749625;
	Thu, 26 Sep 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356930; cv=none; b=N8CkZPJCitwQwKX0E8G5yKUVfHhfySXxrEehk/CxG9xpv757o/LU7I72GiNezf3sUfs1lUZG8NeKUbb6DF6A8T2FskIlhbPaA5z14LKXsrDzs6NIDucL7IcNppEeSVD3mv9Pu7m3WCfsCPMRaMcP/yqVl0xx5N6PKJxQvum9Xn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356930; c=relaxed/simple;
	bh=IaMxC+9N92SX9T9Y7tx3d8OOlb5Ad/mVuekiOSJ5G7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nwbP0DvkCHN9KdA2Sj7qz6+TNXChaMpAn3AAPKSawYff0tXRsDjX2bYfDhL9cHv/ZdAqHVrUMXM9M9XGeId5EZRnqzxzYWB3P0fBoTZ9fXnTG2usChTZ2iOZ+6p1u7jUiPcR8d2/3nbR2xpgWndUSm9fZl8B/w72AkgF+dfvRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=stWQKE3G; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id EE77A40769D4;
	Thu, 26 Sep 2024 13:22:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EE77A40769D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727356927;
	bh=yawh3GGszpdNrF3MU3tfhGKDYKS35Ky/REs8lI1sF8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=stWQKE3GjAMOQreuxlqcnU2C9c2ewSk+KuwtTUmQnh+yTgwbieE96ZoaXpzGdKar8
	 nghzf9Nqq9OaeOTqULQLyDLynF1xG+rIRddllVByIxYUw6yNd+U4+eK48ARTtQl+um
	 TPAo2m2yfyztfaZa0jAt7K8TTU7Ti2de3tGymjdY=
Date: Thu, 26 Sep 2024 16:22:03 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: stable@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH stable 6.6] Revert "wifi: cfg80211: check wiphy mutex is
 held for wdev mutex"
Message-ID: <20240926-d4e2e149773a7f94dd5e7612-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240926003017.5427-1-pkshih@realtek.com>

The patch being reverted was also backported to 5.15 and 6.1 stables where
it's causing the same splats.
https://lore.kernel.org/stable/20240918-d150ee61d40b8f327d65bbf3-pchelkin@ispras.ru/

I've sent the reverts for those branches, too:
- 5.15 https://lore.kernel.org/stable/20240926131552.34898-1-pchelkin@ispras.ru/
- 6.1  https://lore.kernel.org/stable/20240926131437.34326-1-pchelkin@ispras.ru/

