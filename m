Return-Path: <linux-wireless+bounces-17190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DFDA05745
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 10:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B697A2E57
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 09:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9902A1A8413;
	Wed,  8 Jan 2025 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guRLpCOB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514D19F42D
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329622; cv=none; b=pZJKI89gdf2U6XfHtWCcSYUnu600byqfrU5rbA1pUNQTVhjWVciMW3f6hIBsC7KDUZSZ9lafqkjRavST5CqxDgjTuapJeGNGhVCrg7jt1781Qn5H8juMn3bzs9AnulkREffZYsEtXvlAjURulPmkrWxQMezQ2jFMxYysOi569lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329622; c=relaxed/simple;
	bh=KWNsPCfqO9/2m/mTXBmlfe8OilNN6stsaRNoqlVx2iY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=A3bX+SJmHxHHXQsXQpT6m88zSu63C+0Dv+19ZMzN3o3Vdxpugv94cPmJYVtQsgmbHrM4YXqMbIZGd0KtVXpK+VXPdOoKfE8LByRPQIq7FjSc14pAmgN+avJV6pNbUCf4LmNVYpsbNbcxsHCowVvYKckvzHgzTqb0v51TGTLzJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guRLpCOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEB7C4CEE0;
	Wed,  8 Jan 2025 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736329622;
	bh=KWNsPCfqO9/2m/mTXBmlfe8OilNN6stsaRNoqlVx2iY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=guRLpCOBmlIvvekLtna3SaDjA+ddQ+uDwLmPeVHp1G8XUN9AqXwWTQPPd7KwteI38
	 MkvogRjMbxXDNxekui72C4HPo/q98P55nt4h/gOVz37ntQBcVvOkBlVpMg9d0FJJMq
	 Aw8rjcBDcF9+QSoCeT+D1vGCautbPAyfbv4y51qdhL6BEqu47AlV/RpU0qxz6maFul
	 9vPJZ8Ce16izmmljpmrm3dmlGj5JoQKaLSkfIHHEgnQuBxi37iT2w9DaJfwImfRKFz
	 D4Wo08KhCBAIyoF7+IaGubP3XOZC4GJPuUPr8aVBx0g/dXM6sNlV3CR6W1lOxPypor
	 zqSrlMNqsAWCQ==
From: Kalle Valo <kvalo@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: shayne.chen@mediatek.com,  linux-wireless@vger.kernel.org,
  nbd@nbd.name,  lorenzo@kernel.org,  ryder.lee@mediatek.com,
  evelyn.tsai@mediatek.com,  linux-mediatek@lists.infradead.org
Subject: Re: Aw: Aw: [PATCH wireless] wifi: mt76: mt7996: fix invalid
 interface combinations
References: <20241007135133.5336-1-shayne.chen@mediatek.com>
	<trinity-67c63297-52b5-4d2c-bcdd-1e86936c4b26-1728494589152@3c-app-gmx-bap26>
	<trinity-0eec3a68-fc9a-4ec6-8c95-1cd58f3bcff8-1735990797237@trinity-msg-rest-gmx-gmx-live-bbc95d94c-9m2wx>
Date: Wed, 08 Jan 2025 11:46:58 +0200
In-Reply-To: <trinity-0eec3a68-fc9a-4ec6-8c95-1cd58f3bcff8-1735990797237@trinity-msg-rest-gmx-gmx-live-bbc95d94c-9m2wx>
	(Frank Wunderlich's message of "Sat, 4 Jan 2025 11:39:57 +0000")
Message-ID: <87frltr625.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Frank Wunderlich <frank-w@public-files.de> writes:

> Hi
>
> this seems still not merged to next.
>
> can wireless/mtk Maintainer please pick this up?
>
>> Gesendet: Mittwoch, 9. Oktober 2024 um 19:23
>> Betreff: Aw: [PATCH wireless] wifi: mt76: mt7996: fix invalid interface combinations
>>
>> Hi Shayne
>>
>> > Gesendet: Montag, 07. Oktober 2024 um 15:51 Uhr
>> > Von: "Shayne Chen" <shayne.chen@mediatek.com>
>> > Betreff: [PATCH wireless] wifi: mt76: mt7996: fix invalid interface combinations
>> >
>> > Setting beacon_int_min_gcd and NL80211_IFTYPE_ADHOC in the same interface
>> > combination is invalid, which will trigger the following warning trace
>> > and get error returned from wiphy_register().
>> >
>> > [   10.080325] Call trace:
>> > [   10.082761]  wiphy_register+0xc4/0x76c [cfg80211]
>> > [   10.087465]  ieee80211_register_hw+0x800/0xac4 [mac80211]
>> > [   10.092868]  mt76_register_device+0x16c/0x2c0 [mt76]
>> > [   10.097829]  mt7996_register_device+0x740/0x844 [mt7996e]
>> >
>> > Fix this by removing unused adhoc iftype.
>> >
>> > Fixes: 948f65249868 ("wifi: mt76: mt7996: advertize beacon_int_min_gcd")
>> > Reported-by: Frank Wunderlich <frank-w@public-files.de>
>> > Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
>>
>> thx for the patch. I can confirm it fixes the issue/trace.
>
> if tested-by is necessary:
>
> Tested-By: Frank Wunderlich <frank-w@public-files.de>

Felix, should I take this directly to wireless-next? Ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

