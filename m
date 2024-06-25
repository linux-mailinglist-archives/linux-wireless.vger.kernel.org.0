Return-Path: <linux-wireless+bounces-9531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB91916BF7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 17:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCCB2883F3
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1CD17F4FC;
	Tue, 25 Jun 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEJ42l8g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8A17F4F9;
	Tue, 25 Jun 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327770; cv=none; b=TgIYWwRXjZ+6d2hrp4nDOU0708paviOOMAf38scLd5ih2f9utPU2ROki4dQMeH4LR+Z2h+JnPl1+SbPfmfOln/Wtofmc2B8CYGHSFzwNttfLxbl6nHJw0yxAtUTQsAIzX1dCAqSAX8A7liYY6vGNi4P4oBHnLYk4gbyNJJqwGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327770; c=relaxed/simple;
	bh=gQp1PmCHyGQ77qf5D9jrz9q7coboBiVr0Zb41/eD03w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZcNNLhUn6xVpq7CoyyevpXUv+j7de4NrzRmsBzOYTbREdejXlSqOVKpL4WTO+lySAJHsgD5Zg4HZv8XWXP9zLJ0rW7oKzbtkp634P9AS2GfEnwsSO/5p+91ngqP4mxndE1cyJIDFfRuMYKcSh8Bje5BbQ30ltzB9IoTmb0E5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEJ42l8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6396C32782;
	Tue, 25 Jun 2024 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327770;
	bh=gQp1PmCHyGQ77qf5D9jrz9q7coboBiVr0Zb41/eD03w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IEJ42l8gT3X8doXsnqHqTK8SMiUZG9cxuttYRdr72Jg+ZELp5cJ52er5K3gzhNkj8
	 8PojVEtgqXtNAaymeCQVTYJMpl1/L4viulb3dfpLubcTAGqBiHLF++E3y9cMUO5mpA
	 TSapdKD+XvhNE2fNPvIkTHEuUEAg1UXUvN+Lqurxo/YIXrZpo2WSgOIInAVHXIyjYR
	 hcM9lCgRLgPSnyyF6sGmHmv2nd+6rWBztxRu7umRKPFik+wzPC4L7Q3kwqGaF10EKe
	 aEJAAf14l6TlWwuPd+X7Xpb3GzIQmuQsn6ExkmdL5O//RogMJGQ0QeBlIoDLbgWp4V
	 6vdeshDRSSMBQ==
Date: Tue, 25 Jun 2024 08:02:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Koen Vandeputte
 <koen.vandeputte@citymesh.com>, <ath10k@lists.infradead.org>,
 linux-wireless <linux-wireless@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Kees Cook <keescook@chromium.org>
Subject: Re: ieee80211.h virtual_map splat
Message-ID: <20240625080248.32c3e03d@kernel.org>
In-Reply-To: <87o77pik7w.fsf@kernel.org>
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
	<c470e4ff-3f70-40f6-844a-f9614286509f@quicinc.com>
	<87o77pik7w.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 09:56:35 +0300 Kalle Valo wrote:
> > Adding netdev to the initial message in the thread.
> > https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/
> >
> > There was some discussion in the thread, with the observation that the splat 
> > is fixed by:
> > 2ae5c9248e06 ("wifi: mac80211: Use flexible array in struct ieee80211_tim_ie")
> >
> > Followed by discussion if this should be backported.
> >
> > Kees said that "netdev [...] maintainers have asked that contributors not 
> > include "Cc: stable" tags, as they want to evaluate for themselves whether 
> > patches should go to stable or not"  
> 
> BTW this rule doesn't apply to wireless subsystem. For wireless patches
> it's ok to "Cc: stable" in patches or anyone can send a request to
> stable maintainers to pick a patch.

It's an old rule. Quoting documentation:

  Stable tree
  ~~~~~~~~~~~
  
  While it used to be the case that netdev submissions were not supposed
  to carry explicit ``CC: stable@vger.kernel.org`` tags that is no longer
  the case today. Please follow the standard stable rules in
  :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`,
  and make sure you include appropriate Fixes tags!
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#stable-tree

