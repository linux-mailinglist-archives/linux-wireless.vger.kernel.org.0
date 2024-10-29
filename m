Return-Path: <linux-wireless+bounces-14647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67A9B4E99
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE981C2248F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4076C194A52;
	Tue, 29 Oct 2024 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4fv32Nd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C81802;
	Tue, 29 Oct 2024 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217276; cv=none; b=vEzePzcMCi8xdeReMOf2bKK7WnhnPlJSiesc+GT765wseR6BvfSjtfqANUZ3xzQ3tM0yLy1im+lIdaYdGGGEkb7p6wkBvZCw7i4cSwtJC0A44iAcEF7Fc+kVa6Ztjv0SaZEtqoCso2R9QreBJH043t/H0eI03wrwFSEazTLj+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217276; c=relaxed/simple;
	bh=QDjJuagqPueoaO9qe7iRZRahabz0gXLUn1a9Tg70dsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcTbc2Y8eutzxMdXU1wAw6EH6rMRX+6S47dAwQe1Kf37+xoH53k2GGHGSsdGI5oYhdlGUfsBsHV92SkBo7EuaBqOR4gN33pcO+gq7nJqGzBtxh0g6qyVzqqDG7g0Apek0/CGLu+VQeNQwd3XBS/apwGx3E1ZfvKIqjVjczzd4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4fv32Nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F735C4CECD;
	Tue, 29 Oct 2024 15:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730217275;
	bh=QDjJuagqPueoaO9qe7iRZRahabz0gXLUn1a9Tg70dsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c4fv32NdrZjgiBoPyES77YM4ENU0phKBgFNKze9MWcShmVSIkfumuM9PMOzlbvUW0
	 toLhjRtpE6dn/q01Njqf4JOzRW6h8kmdb5OBa+2cjP8ctR5ySJlqkv64bgE9N3nlIP
	 +A8vCrL16MufKZEMLPS5FbjRzXJ7qUZrMZLEvd4fpfs9QRo6738cQfLfBevvghYNjf
	 4oiC0+KhWGX6p81KU6bjlk5vLBxaNS9XHGc0pqSO301SA7UhZUI7yDmmlmK+gH9H5O
	 LJxfqcoGNTh5pGZ8ZAaVuhdOSF5/O3nPSQDzbVuNp2xLGfiN+E0xSYtlP9nOhCUOHi
	 ldW5CYhOh8wMA==
Date: Tue, 29 Oct 2024 08:54:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Johannes Berg
 <johannes.berg@intel.com>
Subject: Re: [RFC PATCH 1/2] net: netlink: add nla_get_*_default() accessors
Message-ID: <20241029085434.432189ea@kernel.org>
In-Reply-To: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
References: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 13:18:06 +0200 Johannes Berg wrote:
> +#define MAKE_NLA_GET_DEFAULT(tp, fn)			\
> +static inline tp fn##_default(const struct nlattr *nla,	\
> +			      tp defvalue)		\
> +{							\
> +	if (!nla)					\
> +		return defvalue;			\
> +	return n(nla);					\
> +}
> +
> +MAKE_NLA_GET_DEFAULT(u8, nla_get_u8);
> +MAKE_NLA_GET_DEFAULT(u16, nla_get_u16);
> +MAKE_NLA_GET_DEFAULT(u32, nla_get_u32);
> +MAKE_NLA_GET_DEFAULT(u64, nla_get_u64);
> +MAKE_NLA_GET_DEFAULT(unsigned long, nla_get_msecs);
> +MAKE_NLA_GET_DEFAULT(s8, nla_get_s8);
> +MAKE_NLA_GET_DEFAULT(s16, nla_get_s16);
> +MAKE_NLA_GET_DEFAULT(s32, nla_get_s32);
> +MAKE_NLA_GET_DEFAULT(s64, nla_get_s64);
> +MAKE_NLA_GET_DEFAULT(s16, nla_get_le16);
> +MAKE_NLA_GET_DEFAULT(s32, nla_get_le32);
> +MAKE_NLA_GET_DEFAULT(s64, nla_get_le64);
> +MAKE_NLA_GET_DEFAULT(s16, nla_get_be16);
> +MAKE_NLA_GET_DEFAULT(s32, nla_get_be32);
> +MAKE_NLA_GET_DEFAULT(s64, nla_get_be64);

I'd vote to just spell out the accessors instead of hinding 
the definitions behind macros. Place them right after the
existing nla_get_* definition to make it more likely people
will notice them.

Either way:

Acked-by: Jakub Kicinski <kuba@kernel.org>

