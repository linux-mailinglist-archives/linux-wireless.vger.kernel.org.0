Return-Path: <linux-wireless+bounces-8718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DE3901095
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2024 10:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0217F1F21CE3
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2024 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0029176FA5;
	Sat,  8 Jun 2024 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIdk0qU1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5D1804F;
	Sat,  8 Jun 2024 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837147; cv=none; b=FOHGgPEGDa3Jr7+J9O5gbIE/1uNW0uHnuAP/ORRF2AyCFBwUZzn6gK6M1SzJzdlJtTF4PmdBMb98ht9wT1yA+e2Tz8jEO9i+C66CfuHnQJaWPp4d08TZ94vKnUdoE4w+YXv7QgA8LxWrA9Ac76OfrAiX490ZWlbAapXwre9f24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837147; c=relaxed/simple;
	bh=24tDD36HVuI2oihqADVxd0qgj8DcFJMhkdUILfG4Ur8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV4WOl3Ur4kr9REZZmojnFsiQViYz/srVDxeedZ1TRFetzRtr+ea4lepVd9SK2XUsAlq0dt76l+DnsE0Xg92uqpxTfL/RumqMt4pnHVzG8UPgqRe73wUm4WjZbWNsU6UTMOM3Y/c0042ixReF6JJsSSE5ytWf7J/Qw7zCraDMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIdk0qU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E12C2BD11;
	Sat,  8 Jun 2024 08:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837147;
	bh=24tDD36HVuI2oihqADVxd0qgj8DcFJMhkdUILfG4Ur8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIdk0qU1+4V4zdMJpeNKvJl1jF8ckNizSgs+7bAgEsDilbQvZ+ovuzBaOTO+TwT6e
	 VXmRjYiM5vSLGbRdgyaOgDgd8bOQnXRuBuxpbJ9EQnymIilpL26QfZ55xcvoxk1tbQ
	 YCIij3HAgh2qkjQuh0kFSlKT/JiPKeT6IL7ZVVIQEWJ4jKSWkw8+5DgQUx/LoDQVXi
	 50dKf0UH6VJOxgXXyX9JdxpPtcweW3kEsg10uZSb7T8jNp/s4FDLkq9nNb7Q9aaI2A
	 G8mcIAda4qgmixgfxzvLUGV8MyJysMTUUhfBRnY1F0txHoH26q8fabk5EVaUr+IxPF
	 osbj55M87GWNA==
Date: Sat, 8 Jun 2024 09:59:02 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	sbhatta@marvell.com,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wifi-next 1/2] wifi: mac80211: Move stats allocation to
 core
Message-ID: <20240608085902.GK27689@kernel.org>
References: <20240607102045.235071-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607102045.235071-1-leitao@debian.org>

On Fri, Jun 07, 2024 at 03:20:43AM -0700, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core instead
> of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Move mac80211 driver to leverage the core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


