Return-Path: <linux-wireless+bounces-1068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C808198B2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 07:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799FA1C24908
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 06:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE80C946C;
	Wed, 20 Dec 2023 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbo2/DvG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E501F5F4;
	Wed, 20 Dec 2023 06:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF3BC433C7;
	Wed, 20 Dec 2023 06:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703054133;
	bh=lSLKKBYH94CYSNWb5usvPbjUUCyG+JLH6+SgLDKnqmU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fbo2/DvGJV6hSnLzsIE1z6p1ZBwwi08h6AI8tOQjHE7qFIl7uzGBbu52zKuRY3UOS
	 gGBjdciuFA69Ol9E5hETjcBjCEfwxi7GpArsOmMzHwjEmqlrJDrI+FipXbXozWuc/M
	 ic7+jr4tnIyPRHWcQjiXx8iBynF4EkEL35XdfkxEUOqs1bjPD24ic8AhcGBMFdpp0b
	 NyAeSjodC7b/6/3KCVl9k4b3fkVenqPLpUaE6IYm6KveJ+jLvtAXVRA6zRwRLxgmIY
	 Viw9SOXHHKbobo3vSxX6hwV5wXFiQcBC+lqPnYA5XAinhR+BokiHmmcDfweS14x6fi
	 G273OPQ2BEfIQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: address several kerneldoc warnings
References: <87plz1g2sc.fsf@meer.lwn.net>
Date: Wed, 20 Dec 2023 08:35:30 +0200
In-Reply-To: <87plz1g2sc.fsf@meer.lwn.net> (Jonathan Corbet's message of "Tue,
	19 Dec 2023 17:01:39 -0700")
Message-ID: <87jzp92xfx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> include/net/cfg80211.h includes a number of kerneldoc entries for struct
> members that do not exist, leading to these warnings:
>
>   ./include/net/cfg80211.h:3192: warning: Excess struct member 'band_pref' description in 'cfg80211_bss_selection'
>   ./include/net/cfg80211.h:3192: warning: Excess struct member 'adjust' description in 'cfg80211_bss_selection'
>   ./include/net/cfg80211.h:6181: warning: Excess struct member 'bssid' description in 'wireless_dev'
>   ./include/net/cfg80211.h:6181: warning: Excess struct member 'beacon_interval' description in 'wireless_dev'
>   ./include/net/cfg80211.h:7299: warning: Excess struct member 'bss' description in 'cfg80211_rx_assoc_resp_data'
>
> Remove and/or repair each entry to address the warnings and ensure a proper
> docs build for the affected structures.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

I try to periodically check for kerneldoc warnings in wireless trees but
I have never seen these. Am I missing something or did you do something
special (enable new warnings etc.)?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

