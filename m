Return-Path: <linux-wireless+bounces-15190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A244B9C451C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 19:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A161F25961
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 18:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860DD1AA1FC;
	Mon, 11 Nov 2024 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGZ1QO1Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B91A2567;
	Mon, 11 Nov 2024 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350352; cv=none; b=DiVaqxH6oJdx3Y++AHnyQAMzR5V3dsL63om9LFW6l2ZgRqEvZNeJMSwdAQqgSQRCDvhbkokB2YR4KpUgvqKlKsoTIkVawOOOLZF2WBlfg1sqTdlwq0jthVvNNcrWWNot4gkw8fYqCToBACw0fdE6vrDlvN5WPvqv6dnFFXStgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350352; c=relaxed/simple;
	bh=m6RnQzTjzeLUIXctOT39qWK9ZuWdkcil+4kDnLcEvaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtydbuYMO9z69yGdxTQ6iplKuNVFG5VpCYCxZyUb4aCALLROW4DiKA0IzzEcwtC0YAP6Q747nCLAguFm8e9h4xIen3LP3IEsoVlzwb0EJqgQNZkNoYHZF3kgpdcZmx9gVkw0lHHN72cZTS0sWRnnQwlHOtLaWMYql5U4kjEXeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGZ1QO1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF48C4CECF;
	Mon, 11 Nov 2024 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350351;
	bh=m6RnQzTjzeLUIXctOT39qWK9ZuWdkcil+4kDnLcEvaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NGZ1QO1Z1Yk0jLMwzf3eIUBvbbWykGkvS1pafgtJ5lcLQEaVYzXgloz8wJDtc/BTK
	 OU+bgWyF61hV7ZfmmGvEp6n1Hpu/xAeLxt1aKMTo2tkLtBBj1pcEvS+0nolw6pEUoK
	 1HMnhwcy/Ynhq1uZ0cY0c43eoCNn9nZcZgTTWQ1dbxqCnq3bhIJljY2489njK0c8Yp
	 ni1zUyoZNs+KqYIz64kJGUGzb0uni27lf5ugwa5o16lnMbkUyOI1uigdK6d6U7T5Zc
	 r3RwlJYP1FrpexTJNCxkNHJOIRX/3j8brYDaZpxfQYdj95837uZ1kgTAy6QPGr4HX4
	 w6hDXbgREsX4Q==
Date: Mon, 11 Nov 2024 10:39:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Johannes Berg
 <johannes.berg@intel.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net: netlink: add nla_get_*_default()
 accessors
Message-ID: <20241111103910.37379ad8@kernel.org>
In-Reply-To: <20241108114145.acd2aadb03ac.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
References: <20241108114145.acd2aadb03ac.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  8 Nov 2024 11:41:44 +0100 Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> There are quite a number of places that use patterns
> such as
>=20
>   if (attr)
>      val =3D nla_get_u16(attr);
>   else
>      val =3D DEFAULT;
>=20
> Add nla_get_u16_default() and friends like that to
> not have to type this out all the time.
>=20
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Applied with some minor whitespace fixes, thanks!

