Return-Path: <linux-wireless+bounces-813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208CA8138FB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 18:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAA71F21A59
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A23675C9;
	Thu, 14 Dec 2023 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNVf2RTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FE5B1EA;
	Thu, 14 Dec 2023 17:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8DCC433C7;
	Thu, 14 Dec 2023 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702575808;
	bh=k1rMfnU/ORh38LLCrYOhIG4r7XuMnb1yik3k1ndJZTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNVf2RTTvfL+P9qGKShJzMLyaYQyfqfOKMhLwGcA0i0UzhhuKs6ysmTzi0A/f1a9l
	 0SN03SYoyM0GY+Fe50X1C/BLEF6jEBGvZEE0I4lhtC2trbWkeF69Kr0oL28KzMb5bL
	 gVLHrXSaMDipcm5nMx7UW/TUO+hNYhkQhHhYkVnRWJFah0j60GkMQ6nrBHLE0pOCKb
	 rGDBPA0Sam7tvB5ccGUFPLacYJfBUuNIplwtAAJ5oPwu4jhNh1t4z12V9EG6H3TNJ+
	 itF0wuxvhSKafk0y6KPfBLSeRtD1m2QrQ0ZCEh7gMhZIfJQyvXPCLS+Sfd3SRTC6YM
	 GTVWr3Fhntm+g==
Date: Thu, 14 Dec 2023 17:43:23 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] wifi: mac80211: sta_info.c: fix sentence grammar
Message-ID: <20231214174323.GS5817@kernel.org>
References: <20231213054809.23475-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213054809.23475-1-rdunlap@infradead.org>

On Tue, Dec 12, 2023 at 09:48:09PM -0800, Randy Dunlap wrote:
> Correct run-on sentences by changing "," to ";".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mac80211/sta_info.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks Randy,

these changes look good to me.

Also, I checked and codespell does not report any errors in sta_info.c

Reviewed-by: Simon Horman <horms@kernel.org>

...

