Return-Path: <linux-wireless+bounces-20765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8725A6DF16
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BC93AE9C7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4002A26156D;
	Mon, 24 Mar 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHHjaXtw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701E143736;
	Mon, 24 Mar 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831627; cv=none; b=Il4rwiPQ3xvunzYHvRFvX8tFIvxo/NtWxcaNM/dceOa5g+GSaYHX9EWGfS8OHfpxlrdnsei9u7h+GDxNEGEqrrLzMf4KtGh/XCb7pT1durdqvGJAV9vTT0kiRGeZ3Lan7ZbE+7S4VwcHAGGZu+kK8MXZoXVnvekGiYtYkK+vArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831627; c=relaxed/simple;
	bh=kcX2T/g0AnGTf5Imy3fSKgPokkajYpEdH6wSgTHTbno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7fFaVufJ/pWzP6jRwDi7ok0HlxqMMm0OwsUy39kEv85+N3M4UqND6zcbrzVD0s3LCHTF/UEKQk/s5sIw4GGdaptpJfDdiXJ0lKEdl7Zis9KhYvxdgppZN7t/q5h5O2INNVrYPOMyb98oghXoiglw9GUwmCLgATL0kuLIr2HH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHHjaXtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73FEC4CEE9;
	Mon, 24 Mar 2025 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742831626;
	bh=kcX2T/g0AnGTf5Imy3fSKgPokkajYpEdH6wSgTHTbno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vHHjaXtwkYE1xDaqvMljrcMz68CE9xIFDfIG5vHM1nOiIt3D9rzm1hbQQL5uP3h+b
	 iTcVNTE9j/WZ8Uu9RW8d7+gCB+s5IkhH+jFIT71rUDPGrEwWqBoUE5VI0vqq9Ovcyu
	 p3UZPr1Vq1YZdwyfJbc4BSEht5HD4USYiRRb1SJSuzBcpuThZPVbIgMPf/Whgb8GPt
	 zj7l82YYVPrOtXahDNXKLgmRhHzujKNt48c6Ly3kYosk58yYxmbDUtf+5OZ+a4AAQQ
	 FFgR/miw9BMRivUkdvC1KhMobz1OrXSmypa3jl8Ja0EdFZCUm5qoJ6IKOhQPNH9ZFR
	 6L2U+ULdnH+xg==
Date: Mon, 24 Mar 2025 08:53:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Johannes Berg
 <johannes.berg@intel.com>
Subject: Re: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
Message-ID: <20250324085340.46864b77@kernel.org>
In-Reply-To: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
References: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 13:49:39 +0100 Johannes Berg wrote:
> Someone mentioned today at netdevconf that we've run out of

Don't recall the mention, but I'd guess maybe Jason Xing during
his timestamping talk?  Change itself LGTM!

> tx_flags in the skb_shinfo(). Gain one bit back by removing
> the wifi bit. We should be able to do that because the only
> userspace application for it (hostapd) doesn't change the
> setting on the socket, it just uses different sockets, and
> normally doesn't even use this any more, sending the frames
> over nl80211 instead.

