Return-Path: <linux-wireless+bounces-20767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A95A6DF5B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537511693C8
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62522620C5;
	Mon, 24 Mar 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEyqOvxO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4E2620C0;
	Mon, 24 Mar 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832745; cv=none; b=YybkF8kpB0Ew9i3hdZvgVpAFOKHsvHpudwZ5tJyppGIogVow/LADDjxRpJxwiJffXlbkNVcmL/torTMeI3YQEqsUlgS5ujOk14a/NtavVfmk1zJLa4cgiVrvnVmOiVpOuzOaUyN7fdfDNodFuneT7A5rmdRFuoJH4owxoVrCZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832745; c=relaxed/simple;
	bh=gStccQ0EDR0OkFVWbFv7FWvDMsauSV7A7WJ5wo50LVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VorNzmfa6sCvtv2u4h3MQAa+H7v6wCBleBCoij0pXF8kLvgxH/qetLQQZuquvt6k/A80cODIguuYSlx5l9O5Tp/NATuNdwR4nuQYAEyuBmbtxBg7OdKOHAgNEZmheGHjS3zgu95wkGdazkcw7u+n3uH8owICSP2sCX+9F/Ns2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEyqOvxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC45C4CEEA;
	Mon, 24 Mar 2025 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742832745;
	bh=gStccQ0EDR0OkFVWbFv7FWvDMsauSV7A7WJ5wo50LVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LEyqOvxOl/fILDoZjIbHUnyJqqvkGvNpVKt/iLIbdZdxiJKC/J8mippb928dssb0i
	 BRP1Z/79v2gO8EgYZvKVhUw3h+R9EdqIitz/gbVFUih2Z46euq1cu1Hj4t0ICIBvHq
	 TtCl7Se4+gzsvR0+H2Yl+dhlqanILo+AYxnReBtcoHA1kq3t6Q8Il9T1JzhGws3rRD
	 Ot9pNDsaAFnMhudDshV5X4xvBqcM/Pkpuw1n3i7WkVCqgqlKPHNYEkGWvbTDguEmIJ
	 2BoaWy3NoaPr44HAPHWpK4ZcROqLTYVI9Ha6/YEVod+idC+WIJmw4/8UBLefK+10yp
	 qK4GG9V6zJwvA==
Date: Mon, 24 Mar 2025 09:12:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
Message-ID: <20250324091219.235ca852@kernel.org>
In-Reply-To: <e0ac6ed58b71f0293ec576b45c8e2645c0695d52.camel@sipsolutions.net>
References: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
	<20250324085340.46864b77@kernel.org>
	<e0ac6ed58b71f0293ec576b45c8e2645c0695d52.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 16:57:52 +0100 Johannes Berg wrote:
> On Mon, 2025-03-24 at 08:53 -0700, Jakub Kicinski wrote:
> > On Thu, 13 Mar 2025 13:49:39 +0100 Johannes Berg wrote:  
> > > Someone mentioned today at netdevconf that we've run out of  
> > 
> > Don't recall the mention, but I'd guess maybe Jason Xing during
> > his timestamping talk?  Change itself LGTM!  
> 
> Yeah, I think so. Timing would be right too, his talk was around noon
> that day :)
> 
> I guess I can merge it through wireless for 6.16, unless you have any
> concerns? I can also resend it for net-next after the merge window
> closes, the wireless drivers/stack changes are almost certainly not
> going to have any conflicts, but overall it's trivial anyway.

6.16 makes sense; no preference on the tree, whichever's easier.

