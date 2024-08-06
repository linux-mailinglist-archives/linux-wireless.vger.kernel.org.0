Return-Path: <linux-wireless+bounces-11003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F02948BAD
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 10:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31091F21669
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D791BD4E5;
	Tue,  6 Aug 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5qa+F+o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C664A;
	Tue,  6 Aug 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934379; cv=none; b=klPYgBT/e9AaHI3FaYZtgHledN44lRoOcYPNKqGeISDkO8qayLPBBhmaoMfEN68n9qtLiHqRXWzuB6F1tRhSY86tB/OkLIW7FficocW1mpP8vwKvTGpGiwbnKawGpbxZdpxUqeUTIPbIBYdnNy21BHqsJBLQZ3zfw8vf0GH7Hv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934379; c=relaxed/simple;
	bh=jLxtaqYwGejHVDr7TLr2wF+thWxAzyeocnesv8I+WjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfsDKyHEnhnuKRutD/LPBo7QyfLfZQvaI8oF96rEiqlHUB6f94LBF54OkNyQBgWTctgFefqx6r/OoncIElb249PtNRS6O7yGLRsc4aM6iA/tJTR/A2q9SW+q+vbOxuBpQWjb4AsKfYnSYSY9b3NwD9K3QvGcCEZ7NPP7FqrfYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5qa+F+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF260C32786;
	Tue,  6 Aug 2024 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722934379;
	bh=jLxtaqYwGejHVDr7TLr2wF+thWxAzyeocnesv8I+WjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5qa+F+o1iPppiI2xZ55esXGw/puFe5lAgM1SOXNIEuRgG5VJjXxGGKK8CehV7pER
	 XzcxjP96ZL7mouz7XSa7gyRnzzZCXBzy/gfOrKYzjIxpeKG910tyqOb298Gk0AjHcF
	 vTETQSiuIxmAxByPhlSmLTvbpbc95vCzTnIeYhEW4XWMt6uyRG0knTPjZqh1Dbhnf1
	 4sZsUYE529IeeSD5SeP5VpybqeQrMEdj0xW1frWGSJgdkf+hGW0tPZocUKoS6ZKZ0o
	 GL8R12u/YY9utt4aAhr4vpkysLv8PF6rV/ktNSSHq5iYdFzPO7tXtzBvrPcdHhUkJm
	 mQIHqBByrxNCg==
Date: Tue, 6 Aug 2024 09:52:54 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: stas.yakovlev@gmail.com, kvalo@kernel.org, gregkh@linuxfoundation.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/3] lib80211: Handle const struct lib80211_crypto_ops
 in lib80211
Message-ID: <20240806085254.GO2636630@kernel.org>
References: <cover.1722839425.git.christophe.jaillet@wanadoo.fr>
 <c74085e02f33a11327582b19c9f51c3236e85ae2.1722839425.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c74085e02f33a11327582b19c9f51c3236e85ae2.1722839425.git.christophe.jaillet@wanadoo.fr>

On Mon, Aug 05, 2024 at 08:40:37AM +0200, Christophe JAILLET wrote:
> lib80211_register_crypto_ops() and lib80211_unregister_crypto_ops() don't
> modify their "struct lib80211_crypto_ops *ops" argument. So, it can be
> declared as const.
> 
> Doing so, some adjustments are needed to also constify some date in
> "struct lib80211_crypt_data", "struct lib80211_crypto_alg" and the
> return value of lib80211_get_crypto_ops().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> Changes in v2:
>   - Update ipw2x00/libipw_wx.c as well   [Simon Horman]
> 
> v1: https://lore.kernel.org/all/d6306f7c76015653e9539ddbcd1ed74d1681a98f.1715443223.git.christophe.jaillet@wanadoo.fr/

Reviewed-by: Simon Horman <horms@kernel.org>


