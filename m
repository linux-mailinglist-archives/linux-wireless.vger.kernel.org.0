Return-Path: <linux-wireless+bounces-18599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D54A2AD4B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 17:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BFC3A422C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 16:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061D81A5B99;
	Thu,  6 Feb 2025 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2QYuzA6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000C152E12;
	Thu,  6 Feb 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858073; cv=none; b=RdQa4qphUESgS5u6I7FNeSBelw7uSNvTxMYQ9W11N6aAEIy8BFIUCSRa528FF4LRolOtDaq6WKYIesgMud0p+r7wvJY5konKDqWmjGMWkEZ4ZEa9hW4VSLmazGg0vgc811G5tZlksz5dFE/W74tcko+T8S1q1ZyURNTUpGjadgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858073; c=relaxed/simple;
	bh=fdPogd0DZn/wN8YdHAKS1sSY2UcCeQ4kUijtvObuuCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gA6zdIRH41unqKMG5HATvmjshWCYo0gX+83hPvyaxMq1k/41oWxM0H88tUWWtYiGfWTUUJSY56CIuQjjlvg+TiQqazIT8RME3YZw+EpkvboVYL8EOQhtBLs/b5ecDk/HPU1iSTNVmGyuPHaKYrzrwYP3qr7cOwebISbstSbddZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2QYuzA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF677C4CEDD;
	Thu,  6 Feb 2025 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738858073;
	bh=fdPogd0DZn/wN8YdHAKS1sSY2UcCeQ4kUijtvObuuCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N2QYuzA6A1ULJs4C6WDMD2Azr5aQjaqY1zm72dmZAKmkbgim6PXYmdZJzxGQrzeIG
	 Lz4tGSgaP74b2Azd/afv6wLjjQiZyRQEuf7pEDK2YZqgcFqorY6Cj463uScz54s0Bg
	 9FwCWzWTdbCr/zzrbmh22WXCZHgDVlAIpCMoGtzg337GHsnVlk9oziow37yqwcvKxY
	 bl7i/yS4/y6F+6vXUTafSiiFGsRDFtLKtJYuqBMZMS1iJLlhEvOBRiC5qXKIIk72nE
	 wWf4KoRe8OrngWK2q2pE3lL4CahLuynsUP64uB6xK7kW0WMS+MGU6GhDReNhAVOrMh
	 05lOkmLeQOKrA==
Date: Thu, 6 Feb 2025 08:07:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 05/10] tools/net/ynl: add s8, s16 to valid
 scalars in ynl-gen-c
Message-ID: <20250206080752.0f012b9c@kernel.org>
In-Reply-To: <20250206092658.1383-6-donald.hunter@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
	<20250206092658.1383-6-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 09:26:53 +0000 Donald Hunter wrote:
> Add the missing s8 and s16 scalar types to the list of recognised
> scalars in ynl-gen-c.

Acked-by: Jakub Kicinski <kuba@kernel.org>

