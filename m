Return-Path: <linux-wireless+bounces-22383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230AAA8296
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 22:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47F23B3F51
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 20:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20507269CE0;
	Sat,  3 May 2025 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFe7t5/k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB518DB18;
	Sat,  3 May 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302863; cv=none; b=UDF9Zu3hGM8aKm+eeQ9wAgrD1QqEJCokdfbElZCgjjMNBDQNZ1x9AWM+uMTAG78VHfnjoYiDjKY79wX68Q3NCGtvCyf6gcV1jch8NqtnBaqN0H2fs+ruCLjKdipPsDMFm+No+UeKg9Fxd5FE4IRzCMRRwA1aSodhI5aMcpVZzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302863; c=relaxed/simple;
	bh=5qfdHU4QKRdeBHcuAAzl/0hDZRG+8CSgRLabUYVr9KY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRBdSqkc6QJRX16RqvlehQM1AtPUMIH97X6XyBdkO6xZuOwkgSJ4vQ/+gXQNuFFEnuEW6c3+tbWhvbkCbVu5msJLRRukOq00X1LzRK5W5Y2Pxfm9Sb/qt+ZZRI9XxRDKlmj/MTL6jTSetaeBH/5TVkUOdNAlXzRdU+9A/2SExkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFe7t5/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E1AC4CEE3;
	Sat,  3 May 2025 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302860;
	bh=5qfdHU4QKRdeBHcuAAzl/0hDZRG+8CSgRLabUYVr9KY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qFe7t5/knsU5HoiTDbnj3TIv9oCE7+eo+3Or8ojjzEobwgHHPokLh7P3iRaSDK5Sa
	 ZIcoDlYNe4LhJW4MXC0arJ3DDSggHoBqnYUOdFlAbUNm/GHo+Xl//SCJ1Zt10eryTU
	 q4Dv/CBedHLp5A9EFeXYRAGkHBIIBUV3qV2UYduTlqUyLpkrv/qPmNZmBKgpcGN7AC
	 I5Nz7QYIbGT2U7WGUSEJNgWxMxFkd0ASJHsVc0YmCBB8hTQOhrE8XiFjB4wrKydD4d
	 WhZsqpAp66GpEqlOrAKl4W8lnMOWtvQFG6+iMSSUcQhR+OSaJuu6+J4ztlU4fGiyYX
	 M/p7ym859yLyQ==
Date: Sat, 3 May 2025 13:07:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v5 10/10] netlink: specs: wireless: add a spec
 for nl80211
Message-ID: <20250503130739.1c94d433@kernel.org>
In-Reply-To: <20250211120127.84858-11-donald.hunter@gmail.com>
References: <20250211120127.84858-1-donald.hunter@gmail.com>
	<20250211120127.84858-11-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 12:01:27 +0000 Donald Hunter wrote:
> +    name: ieee80211-mcs-info
> +    type: struct
> +    members:
> +      -
> +        name: rx-mask
> +        type: binary
> +        len: 10
> +      -
> +        name: rx-highest
> +        type: u16
> +        byte-order: little-endian
> +      -
> +        name: tx-params
> +        type: u8
> +      -
> +        name: reserved
> +        type: binary
> +        len: 3

Looks like we have 3 structs in the Netlink spec:
 - ieee80211-ht-cap
 - ieee80211-mcs-info
 - ieee80211-vht-mcs-info
which are defined in include/linux/ieee80211.h rather than the uAPI,
but we do use them in Netlink attrs. I'm guessing these come from 
the IEEE spec so there is no ambiguity?

I'm trying to figure out what to do with them in the C codegen
for YNL. Normally we assume all structs used by the spec are defined
in the headers. We can add an annotation to render the definition
in user space code, but I wonder if this omission is really intentional?
Wouldn't it be generally useful to user space to expose the types 
in uAPI?

