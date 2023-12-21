Return-Path: <linux-wireless+bounces-1172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A781BD23
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 18:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08D61F26CA6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4A627E2;
	Thu, 21 Dec 2023 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nic4msbx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550F59935;
	Thu, 21 Dec 2023 17:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155B1C433C8;
	Thu, 21 Dec 2023 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703179406;
	bh=bmqokF3kgu1a6y7OqSmf6SM3KbNzFnncTz3JQchWAOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nic4msbxsvkbFqIGsB/z1s4VTSD5Esv18EWksyK4vwrDnRWWu9H+LI5yM4RNI7waW
	 8nRIhRWI25YobSq22R1opZ0Djlj467GE+PWKesTnBi3t9aBlrkueYdFBMBg3BR5gnC
	 yO0hvIl9H1k/kNE8yIVRjkXaWqTSpxa/h7znbBt8F2p6iMSlasIL1dqNJ/20VWRzw3
	 tQ02g7cuvI2ek9J2Q+Obed8EyonvTSqQetQcfhUfwLrYDc7bIFpMK4u4QmEFDpBefI
	 B4Wm9Tv0tlbEbN8OGcvDBmA13j4bifGfvsQKpn0w3GKr/KR1w7o/2wa0OP3h3+/SY0
	 D+Fa5R+9C07Rw==
Date: Thu, 21 Dec 2023 18:23:19 +0100
From: Simon Horman <horms@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] wifi: mac80211: address some kerneldoc warnings
Message-ID: <20231221172319.GD1056991@kernel.org>
References: <87zfy4bhxo.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfy4bhxo.fsf@meer.lwn.net>

On Wed, Dec 20, 2023 at 03:57:55PM -0700, Jonathan Corbet wrote:
> include/net/mac80111.h contains a number of either excess or incorrect
> kerneldoc entries for structure members, leading to these warnings:
> 
>   ./include/net/mac80211.h:491: warning: Excess struct member 'rssi' description in 'ieee80211_event'
>   ./include/net/mac80211.h:491: warning: Excess struct member 'mlme' description in 'ieee80211_event'
>   ./include/net/mac80211.h:491: warning: Excess struct member 'ba' description in 'ieee80211_event'
>   ./include/net/mac80211.h:777: warning: Excess struct member 'ack_enabled' description in 'ieee80211_bss_conf'
>   ./include/net/mac80211.h:1222: warning: Excess struct member 'ampdu_ack_len' description in 'ieee80211_tx_info'
>   ./include/net/mac80211.h:1222: warning: Excess struct member 'ampdu_len' description in 'ieee80211_tx_info'
>   ./include/net/mac80211.h:1222: warning: Excess struct member 'ack_signal' description in 'ieee80211_tx_info'
>   ./include/net/mac80211.h:2920: warning: Excess struct member 'radiotap_he' description in 'ieee80211_hw'
> 
> Fix or remove the entries as needed.  This change removes 208 warnings from
> a "make htmldocs" build.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks Jonathan,

I verified that the above mentioned warnings are present in
next-20231221 without this patch, but not with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>


