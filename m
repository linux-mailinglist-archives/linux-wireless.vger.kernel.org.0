Return-Path: <linux-wireless+bounces-22106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFD6A9E002
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 08:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0701A832C5
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 06:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D5241664;
	Sun, 27 Apr 2025 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="ie5YftHH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C251192D97
	for <linux-wireless@vger.kernel.org>; Sun, 27 Apr 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745736347; cv=none; b=q2gEAYhNn9dLju9qDUPXCQz+CG8GeAqzZYGrHqrUzQSu3Nolv/PVMDrV8AkAONtXrd3jvSa/1fSqPJLPbht9nCa1ZaOplbMiuWBcvHq6Wn/sOA0uO0sVzCi/gPCy6tNp1m2tdD80nAQpbh1v7VuisIlY2ZYnQ8cykWI4AbX1Znw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745736347; c=relaxed/simple;
	bh=cP6/XJCXVqldEshjXYoc8yE5Oq3R5dY8qFB9/WC3g1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnyY090Y6VGcBTM+b5PqwK20BhbyDK7ZTwjhfrK0+qYdXt5qTqy3SVZ2QOGGn3RMciD2X/1Fs2UkfQjpJmFEFy5pjg2EcY2eK8EzZiGqxuMJan+a7rZNHucwahwbhcCgUfVJRgLDS0T5R0yBXkmPWjfLzMT9/bHru+/W7oNxgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=ie5YftHH; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 17292 invoked from network); 27 Apr 2025 08:39:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1745735941; bh=o3uXY+03fHMqEVm7xfc1m3HwM3CT7TcojXJU2tbxrfA=;
          h=From:To:Cc:Subject;
          b=ie5YftHHgYaGWXxljKQT+IURdnwlKkaXBpvqN124lcpaqyFuTYF3rQUBUZJPdS/Ip
           LT9lXqsla0AerdAd6slIu4XlXtkjJl1TYiloi99J77+2syjmq42Fe0vp+BzgVlkZhN
           inNgKhQmag6+Jx75X0Rqn5VxQ6sArK8ZzsivRzHTLRktD97WGW2Kz9m1AvuIp5C6JB
           er77cb2I8R5vjeXyRljAfqYV4WYnYgvkwhlWC4r4AIgFziyo6I7JqkqruMryXkLW4I
           wQ65e0K0CgkzOXYvugtgrdXlTZSiJPX636d3LBopgqC8s0GKBiNruJ+0Q0Dv8jZRpS
           04RjbOA5UK7XA==
Received: from 89-64-9-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <a.safin@rosa.ru>; 27 Apr 2025 08:39:01 +0200
Date: Sun, 27 Apr 2025 08:39:00 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Alexei Safin <a.safin@rosa.ru>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] iwlegacy: 4965: fix possible out-of-bounds access in
 il4965_tx_cmd_build_rate()
Message-ID: <20250427063900.GA48509@wp.pl>
References: <20250424185244.3562-1-a.safin@rosa.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424185244.3562-1-a.safin@rosa.ru>
X-WP-MailID: 3dfcb9b3360eb4c1b73ce68492ffa8f3
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [gSIx]                               

Hi

On Thu, Apr 24, 2025 at 09:52:44PM +0300, Alexei Safin wrote:
> Prevent out-of-bounds access in il4965_tx_cmd_build_rate() by rejecting
> rate_idx values greater than or equal to RATE_COUNT_LEGACY.
> 
> Use a correct bounds check to avoid accessing il_rates[] with
> an invalid index. The previous comparison allowed rate_idx to become
> equal to RATE_COUNT_LEGACY, which exceeds the array limit.

Thanks for the patch, however I think it's not correct.

The definitions are:

enum {
        RATE_1M_IDX = 0,
	...
	RATE_54M_INDEX,
	RATE_60M_INDEX,
	RATE_COUNT
        RATE_COUNT_LEGACY = RATE_COUNT - 1,     /* Excluding 60M */
}

extern const struct il_rate_info il_rates[RATE_COUNT];

> Replace the check 'rate_idx > RATE_COUNT_LEGACY' with
> 'rate_idx >= RATE_COUNT_LEGACY' to ensure memory safety.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

> Fixes: 7ac9a364c172 ("iwlegacy: move under intel directory")
> Signed-off-by: Alexei Safin <a.safin@rosa.ru>
> ---
> v2: change reciepent
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index 78dee8ccfebf..f60d9b9798c1 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -1572,7 +1572,7 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
>  	 */
>  	rate_idx = info->control.rates[0].idx;
>  	if ((info->control.rates[0].flags & IEEE80211_TX_RC_MCS) || rate_idx < 0
> -	    || rate_idx > RATE_COUNT_LEGACY)
> +	    || rate_idx >= RATE_COUNT_LEGACY)
>  		rate_idx = rate_lowest_index(&il->bands[info->band], sta);

.. so looks the check is fine already and changing it will induce a bug
for RATE_54M_INDEX.

Regards
Stanislaw

>  	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
>  	if (info->band == NL80211_BAND_5GHZ)
> -- 
> 2.39.5 (Apple Git-154)
> 

