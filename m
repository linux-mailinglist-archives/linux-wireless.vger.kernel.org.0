Return-Path: <linux-wireless+bounces-812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 373308138F2
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 18:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD855B2132C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1758C675B8;
	Thu, 14 Dec 2023 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd6x2p0s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B55B1EA;
	Thu, 14 Dec 2023 17:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA96C433C8;
	Thu, 14 Dec 2023 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702575699;
	bh=3bKhwMGmk3qYF0y/W7RZqBVoZoE6kBZruTQf+WtKjUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pd6x2p0sscS4Qoo6J8evWczOApCQzNSW3wNI8wBy9hvvmmJLsTkARIsw/xu+V08Jd
	 Q/Inpx0ieGWOTGjmNjCAwphTD3HUcDnpvzfEDOyJD6WMYKmBG4vkDlGuSC+FaAXiHI
	 etgNpnVUjxjIQMoyJPf+IJxh8jC9ZPNpMPM7xw9Fs+DoiRi5T3YzXwrX5XHj4m4F5t
	 2IKumO7+cqjMx2/HUWvBXiwhSf6d1qZXaOnerKXqT2umBnC1BC9rzxZpPiF16PmgAC
	 zyZ4GIWcWwq5MlvAJS9IhY+uiYNRFnvPOYhUN0EINB4VRuSfDPmCXHsMlq89OMv/Xv
	 WvzELCSotWezA==
Date: Thu, 14 Dec 2023 17:41:35 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] wifi: mac80211: rx.c: fix sentence grammar
Message-ID: <20231214174135.GR5817@kernel.org>
References: <20231213054800.22561-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213054800.22561-1-rdunlap@infradead.org>

On Tue, Dec 12, 2023 at 09:48:00PM -0800, Randy Dunlap wrote:
> Correct a run-on sentence by changing "," to ";".
> Add a subject in one sentence.
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
>  net/mac80211/rx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks Randy,

these changes look good to me.

Also, I checked and codespell doesn't report any errors in rx.c

Reviewed-by: Simon Horman <horms@kernel.org>

