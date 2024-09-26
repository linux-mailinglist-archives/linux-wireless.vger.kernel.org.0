Return-Path: <linux-wireless+bounces-13231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1BF987720
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 17:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAEB2872E7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACD915C128;
	Thu, 26 Sep 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHTsQPcS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FEB15B99D;
	Thu, 26 Sep 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366323; cv=none; b=Q0Z024gVYP278b96Nt9xsq1szqfdmkyW03euMkYK7QWxEweq1u/4hrVlw6NluItVJ7vzqTIuk6lD11OFU0PGfsE9RB98PDqAywjyFWt7BDBj6h0pY6QvGZ8OC+H6tGcrhNFli/dOLplYTR6keiVKXJ42vI6ukBGH2qxfhBRwWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366323; c=relaxed/simple;
	bh=igJ0G0OPnz/B3elCb/RuWY5dnt8N4bIiq+BlerzgzHw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aUDxV1FNXN4UcwoFvqwRnPK7iuAnvim8bNJNnN3cU6qRtaaZkcdLIYTCF7MC3kVelJB92pJMPJNpS4p0x0pTn1OIC8iYyPu04mQk6p44j767he2OhvJzyzTsehM84JXwsbpwNtBGP8+QH+Jod7TqhoH4ePvzgxrfRvmbPSwnArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHTsQPcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0ABC4CECE;
	Thu, 26 Sep 2024 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727366321;
	bh=igJ0G0OPnz/B3elCb/RuWY5dnt8N4bIiq+BlerzgzHw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bHTsQPcSbxg85P9pIQPwMha5ShcMWjEr/16SMRgqIGc0KVuAdbzGQqlSA3sdEFtsh
	 3maWznzVTHKHJO0pw13fpAHWusOih98hmsvwVVTKK9XrqwhyUZT987WGqV561PhFDK
	 qD/q603YAskungMGSk5lQ+8a6irk64cgCLQ0kpDOorQIwbyu56uWdUjdO/ManXyc5W
	 PszVvAFG/yhxfismT8Vr/bbp+R9fyLR0hylngWnCOwnxxNkkx5LEHu050RMiALBJ9+
	 psF+INAfbFocSty46NMOk95uBDe6GW+nuEi4dOff+V1avkzMsyc9BzGna602i4YqN7
	 0eMI67mlN0Pkw==
From: Kalle Valo <kvalo@kernel.org>
To: Vladislav Efanov <VEfanov@ispras.ru>
Cc: Johannes Berg <johannes@sipsolutions.net>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  "John W.
 Linville" <linville@tuxdriver.com>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  lvc-project@linuxtesting.org
Subject: Re: [PATCH] cfg80211: Convert WARN_ON() to warning message
References: <20240926133446.25445-1-VEfanov@ispras.ru>
Date: Thu, 26 Sep 2024 18:58:37 +0300
In-Reply-To: <20240926133446.25445-1-VEfanov@ispras.ru> (Vladislav Efanov's
	message of "Thu, 26 Sep 2024 16:34:38 +0300")
Message-ID: <874j629zki.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vladislav Efanov <VEfanov@ispras.ru> writes:

> syzkaller got the following warning:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9992 at net/wireless/ibss.c:36 __cfg80211_ibss
>
> This warning is the result of the race condition between the following
> events:
>
> event1                          event2                      event3
> __ieee80211_sta_join_ibss()        |                          |
> creates new cgf80211_bss           |                          |
> structure.                         |                          |
> Calls cfg80211_ibss_joined()       |                          |
> which will scheduled               |                          |
> new event_work.                    |                          |
>                          ieee80211_ibss_disconnect()          |
>                          is called due to connection          |
>                          dropped/ibss leaves to               |
>                          remove cfg80211_bss structure.       |
>                                                 event_work starts.
>                                           __cfg80211_ibss_joined()
>                                           is called and WARNING is
>                                           detected due to
>                                           cfg80211_bss structure was
>                                           removed by event2.
>
> It is a normal situation when connection is dropped during handshaking.
> So it looks reasonable to replace WARN_ON() with warning message to
> prevent false alarm.
>
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> Fixes: 04a773ade068 ("cfg80211/nl80211: add IBSS API")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> ---
>  net/wireless/ibss.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
> index e6fdb0b8187d..93c8bee12bdf 100644
> --- a/net/wireless/ibss.c
> +++ b/net/wireless/ibss.c
> @@ -34,8 +34,10 @@ void __cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
>  	bss = cfg80211_get_bss(wdev->wiphy, channel, bssid, NULL, 0,
>  			       IEEE80211_BSS_TYPE_IBSS, IEEE80211_PRIVACY_ANY);
>  
> -	if (WARN_ON(!bss))
> +	if (!bss) {
> +		pr_warn("cfg80211: cfg80211_bss with bssid %s not found.\n", bssid);
>  		return;
> +	}

If it's a normal case (disclaimer: didn't investigate that) the warning
message could be more descriptive. I suspect the user is just confused
after seeing that.

Also 'wifi:' missing from subject.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

