Return-Path: <linux-wireless+bounces-15152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D139C2674
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 21:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481E6282990
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5041C1F0F;
	Fri,  8 Nov 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9rD7wg3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5F1A9B2D;
	Fri,  8 Nov 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097537; cv=none; b=f/BcZXzDtKo556H/1OZnCIp9j451shG8c+kBTvdgLDL8qlzsVVXJxs53WKRXTRnJyIlH1jO9PBL6/lj89og7jgnYEBCdZLnAtyrr77xzGuToOS3e+0uEVSkZmOdsfB4guu3Sz0qWNCmQVstXXzY+JoDPTXPdq/3rTUA+0NQAnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097537; c=relaxed/simple;
	bh=+Xl/cg+YSPQ4F36iHrDkTgtkXj0x/P8d+1nghK/ZaPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sta3HvyQiSDuVtaCctrMxX3D/3ofGH6+bQG36ZdkGHwwtLkfQJUgxdktC3a11ISWIpnqe2m8bzd1p42eq1jf6/qrBhzB0GNpJYdzOdxIZVbcAkAWbMDchi7ReZMRaUsOrcuqnYaEKkh+BF43ee1ciyT6e5v7eW2SuNztinTYNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9rD7wg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8222C4CECD;
	Fri,  8 Nov 2024 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731097536;
	bh=+Xl/cg+YSPQ4F36iHrDkTgtkXj0x/P8d+1nghK/ZaPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H9rD7wg3KkFxhbL9HesalpVPl9Dzdwt2ujSbMGq//4CebXP1Ly7zgDLd5fKRHUVxO
	 mtBNxljuBDiNuJp+qp54isJNJfK3lzlbiZi8PxBELxRtMPa8B8eKuFKandP58UQob+
	 PDEBR08OSPH7IIV/9NQaFhTkKW2rVma3ibDkxDIVhgdux/gickj+pzxoG9is2FDzYy
	 YMl5HBmTW5Cj0ptMCS0iweEccTSIHAQg+HQjlBR6+i9mUT1q7k8DCullPN6+hqJK39
	 eZg+oXCiZQrSbls9MwF1+0UiEXfJJZwCQTQIBo6sPGW3o4A355EpDboKXS/RJp5SPQ
	 0rXM+ROl87jpA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 20A39164C7BF; Fri, 08 Nov 2024 21:25:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next v3 2/2] net: convert to nla_get_*_default()
In-Reply-To: <20241108114145.0580b8684e7f.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
References: <20241108114145.acd2aadb03ac.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
 <20241108114145.0580b8684e7f.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 08 Nov 2024 21:25:34 +0100
Message-ID: <87y11t5v7l.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Most of the original conversion is from the spatch below,
> but I edited some and left out other instances that were
> either buggy after conversion (where default values don't
> fit into the type) or just looked strange.

All of these LGTM! :)

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

