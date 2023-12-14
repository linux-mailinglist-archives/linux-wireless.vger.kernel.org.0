Return-Path: <linux-wireless+bounces-811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE2A8138C1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 18:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B66D281920
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DC265EDA;
	Thu, 14 Dec 2023 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6AmvASW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88F565EB5;
	Thu, 14 Dec 2023 17:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B70C433C7;
	Thu, 14 Dec 2023 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702575471;
	bh=+k1oTZLKf37g4WffooUAC55HDL+rmFMDN3U8i/rtVU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6AmvASW+XeNZjPtnAPUQ72zBjRMSFOrB+9Z+rVRGHCyuCsZsM9JD9n3VrRjmrqty
	 /WMeinwgkYBNu9ihujrCOjkmqM2WK0X42oepdPYBdkb7/+dpWIw2dallmSkiuFxYpG
	 VeIReHaeC0PEEdTwKZXoeouVP/ZCt0AY1gXPOXlpj/xrPpCOH+j+eEtbCjYyUR/awr
	 +OLbNahXyCSctt579WHpFegoWY1YbdqwTByPIoA+4BGvSJWIncZF6zXPRJ3aKM5DqU
	 ME4Y6dVXVHZeraV3E5BVO5AuLGtWxv0qgtz4lMd+6t2uRi6t+ts4Gyn4RJSCCTSlKA
	 KRcL8oBNjDLXQ==
Date: Thu, 14 Dec 2023 17:37:46 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] wifi: nl80211: fix grammar & spellos
Message-ID: <20231214173746.GQ5817@kernel.org>
References: <20231213044315.19459-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213044315.19459-1-rdunlap@infradead.org>

On Tue, Dec 12, 2023 at 08:43:15PM -0800, Randy Dunlap wrote:
> Correct spelling as reported by codespell.
> Correct run-on sentences and other grammar issues.
> Add hyphenation of adjectives.
> Correct some punctuation.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>

Thanks Randy,

These changes look good to me.

And I see that with this patch applied codespell
no longer reports any non-false-positives for nl80211.h

Reviewed-by: Simon Horman <horms@kernel.org>


...

