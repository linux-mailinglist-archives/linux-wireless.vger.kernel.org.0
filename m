Return-Path: <linux-wireless+bounces-5493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463088908C9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FBA1C23554
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203C3CF73;
	Thu, 28 Mar 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti6Tw9mM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5211849;
	Thu, 28 Mar 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652261; cv=none; b=AiOWxdUOtasvU/lVGm3tjh1InbmkR7HDv/O8uYKYI+dVYrlimIzhvAGXFb3hqbaOdluCUki9rPiFpiPsT1Sc0HbhZq2dUcSuwSfeVYitxxO0HvBqW+cd31rUQ9QWe8wfGGGez8/NJDNEUIWEkg33NB/AKy1qjj9w/XE8pkJm6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652261; c=relaxed/simple;
	bh=g8MZoSOBw83lfy1GQGN+fYvIbwsa4mnyeiq8LMMUAbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBJFPvo6RZOpe/TNOm6Y90BC6MiXrObRhjbR6j+0oARoGoI5KpzlvIRYtoD0YAsSZZ9Dyic+dta6X73nVeqVI1DdvNapPbss/wnc3M7ziObh0f/y8JClqrOouFjYHDoZ/gHCwwa+8DTO4qZR/EuAPMCGFXG/ZwBnYT9qjICvKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti6Tw9mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43B2C433C7;
	Thu, 28 Mar 2024 18:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711652261;
	bh=g8MZoSOBw83lfy1GQGN+fYvIbwsa4mnyeiq8LMMUAbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ti6Tw9mMMkTBavcMr86LzhVafkUKbgTXs+DJ6l9HnvUJFa5/xg1SngxeY7S0O+Uul
	 uNPxj6Nm9l3lBPwl+KOM8IHUD8F74Ok4LxdD8acbvwlx6y/18dnrr0rgOExUPDQfrB
	 s0T7Hw0h6TJcZUNzHAsZd+fAPfpZczhpHXwFyrFU2hy0dO9Nuyj+m6cIXO/NQmRr49
	 ix6BypTQQpIvqDWp+hWwKWEha/TEU+mQfG/jnEjUTc4PblbILf7d/OfV3tgshCbxQY
	 kwsvK1xr4+AKzxzfvZdZ+KHUpCNz61MxWnF063i3bTp9g9iw0cs5a6ddzmC42e9Ex4
	 E1HRQ1jqvy4zQ==
Date: Thu, 28 Mar 2024 11:57:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, Vasanthakumar
 Thiagarajan <quic_vthiagar@quicinc.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
Message-ID: <20240328115739.78ec5650@kernel.org>
In-Reply-To: <485ca445f0f0c47179a338df2538e74d520627ad.camel@sipsolutions.net>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	<20240328072916.1164195-3-quic_periyasa@quicinc.com>
	<6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
	<9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
	<9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
	<20240328114903.1d0c8af9@kernel.org>
	<485ca445f0f0c47179a338df2538e74d520627ad.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 19:53:33 +0100 Johannes Berg wrote:
> I suppose we could even define a
> 
> nla_for_each_type(..., type)

That's probably a good idea for the kernel! We already have a bunch of
the loops with the if (type != DESIRED) continue, as you mentioned.

