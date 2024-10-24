Return-Path: <linux-wireless+bounces-14467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC19AE560
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 14:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221261F22F64
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3FA1D517E;
	Thu, 24 Oct 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egUOX+eW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852021B6CEE;
	Thu, 24 Oct 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774270; cv=none; b=L+j3inKvVAUDCkcFvhX6mNmY5z3WWyiTl7umOBc6TVwY6FzwLYwwpAugl7YgLNF37NQUCZtbMyav1oRGt5strfl2lie51RmeHjlCcxTFKxe//chFyinvvWWsoitnZxXJHT5zc4MVzuwbZQPNuVffx3eno6YvkiiVRGEFK+szNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774270; c=relaxed/simple;
	bh=11eghT2XM6A9UCg3foQEvZgI8vR3UuWQXU3FknKnd4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ObcNm28P9oU6R0hUinlC/f5smEsvLh3crjJdFRheiJzVu5itDl2FrUA4Zmri4DxVz8HELxhSSrrzdIO3Ro6RJvpaa1HUEP81U3KJg02+kEa8qMdTO/x0z61xHf4NUpL0QHtZIhwqt01gbRd2osuqKtb9uesr1TG/W4ednMZuMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egUOX+eW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A2FC4CEC7;
	Thu, 24 Oct 2024 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729774270;
	bh=11eghT2XM6A9UCg3foQEvZgI8vR3UuWQXU3FknKnd4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=egUOX+eWNry87Cog/fnjPuIxY+Xiy86qVsZuB0CQc3lAF4mqda+/dfqwIBZntDp+o
	 6+0Q75WpUKccH8UKJUEX4MsKz4p96cXT2A/Zn2Mf9znvxeQ2o+s9JfCPIgxQGnU6r2
	 TrRwC88+7843QQd5hh26pBO5yB0OP/XtHm+QCVaC3qT9wBYGrF4VVLC56NxPlfF5DE
	 UjEjsMkxKVwF58NFB4C/LtOeugkX4RXpjaISV9IahlyLSKyCioE2kJjfRqTP4BMqXa
	 dSEk05G+rqNin8ncIJTXa0IpTy1FNkCIpZp7fY59ZHVD+c43GkKKCnYlIPXWd9Gy5e
	 g83q2ZL368Sag==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 48EAF160B498; Thu, 24 Oct 2024 14:51:07 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH 1/2] net: netlink: add nla_get_*_default() accessors
In-Reply-To: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
References: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 24 Oct 2024 14:51:07 +0200
Message-ID: <87seslfyv8.fsf@toke.dk>
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
> There are quite a number of places that use patterns
> such as
>
>   if (attr)
>      val =3D nla_get_u16(attr);
>   else
>      val =3D DEFAULT;
>
> Add nla_get_u16_default() and friends like that to
> not have to type this out all the time.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I think this is an excellent idea! So typos/copy-paste errors aside:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

