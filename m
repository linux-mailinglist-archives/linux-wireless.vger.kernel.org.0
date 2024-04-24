Return-Path: <linux-wireless+bounces-6761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C658B0630
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 11:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295591F2262D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 09:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923F0158A39;
	Wed, 24 Apr 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNzwHM8g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCA1EF1A
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951565; cv=none; b=t1NzRRYOcO7ag57Umulb8zkQmsGX7KE1E9mxD4VIoXMkbKMQbs4q35iLxtde3luq1jkpGN4d086y3FDjmWJSIViu2M0hKKbQx2QdyMqBm5FuBXZ6pBBsUzz8+pmSzyVSKLILxHIu7kcJi1oAHMjad9AhpX5IDm5VN9fmN81W6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951565; c=relaxed/simple;
	bh=GUIlLkif8keejqDQqKOkW9EQrA1+ijV1H3EyKQjskfw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Q07KiI/WJtloFiOKMH8NYJnQc2J4ZGi11ckuFxBee+b0WwmJYKdawSb/sga1IyqI+CDf7mbssZ0XFchKfC8kg83PUDFcJMI7o0Pk7yC8ah69fb8W/IBaVB89XUsm99CLTp8nmYQvi5QY3QgTXlJkiWAz4ciNCHbicXW9jsXDsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNzwHM8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C2FC113CE;
	Wed, 24 Apr 2024 09:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713951564;
	bh=GUIlLkif8keejqDQqKOkW9EQrA1+ijV1H3EyKQjskfw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WNzwHM8gw8qQj5lZ9kTqaCfk+IsJoUwzTwOqm2LQleRnp1evX4zvo7ieb0J7NFL3W
	 rx2YlMTL32rBqESPwHshSYhc6BBYocL3kah1koOKQlCHgfHEj85gRlib3DfVBo54L/
	 n7Bt78Kswcv0jBNPiKcG8lVad/nghY5mJSVUnynz7JjPN2FH9IW7Ez2tJfqEEZRgBr
	 n8yqLp9ihF6LhcdzwvwiN1iau7V+cdYn01Zx5QlgEWKwmEj0oryF4ghGRE5GKf1rbL
	 AT6qwnNvOfOPhh27XQPy9sHVvtRWFNqlvXu1zu/lRhQXo/g/ZJ90FvTP3VIvemdxyH
	 ScPrYPy8znSCw==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
  ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/3] wifi: ath12k: Add lock to protect the hardware
 state
References: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
	<20240424065646.1666166-4-quic_periyasa@quicinc.com>
	<517caf852d37b3803bcf087a6b575f2ecdb5ba10.camel@sipsolutions.net>
Date: Wed, 24 Apr 2024 12:39:21 +0300
In-Reply-To: <517caf852d37b3803bcf087a6b575f2ecdb5ba10.camel@sipsolutions.net>
	(Johannes Berg's message of "Wed, 24 Apr 2024 09:28:20 +0200")
Message-ID: <87il07t7zq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2024-04-24 at 12:26 +0530, Karthikeyan Periyasamy wrote:
>> Currently, hardware state is not protected across the reconfigure
>> operations. However, in single wiphy models, multiple radio/links is
>> exposed as a MAC hardware (ieee80211_hw) through the driver hardware
>> abstraction (ath12k_hw) layer. In such scenario, we need to protect
>> hardware state across the multiple radio/link at the driver hardware
>> abstraction (ath12k_hw) layer. Therefore, introduce a new mutex in
>> the ath12k_hw layer.
>> 
>
> It's your driver, but ... it would seem _simpler_ to do locking across
> the hw with a single wiphy model, because everything (except currently
> for ath12k_core_reset and ath12k_core_restart) already holds the wiphy
> mutex. You can probably move those to wiphy work.
>
> I'd avoid doing lock explosion like we had in mac80211, it's going to
> come back and bite you eventually :)

Exactly. Swithing to use wiphy_lock() definitely one of my longterm
goals in ath12k. I already started working on switching ath12k to use
wiphy_lock() but IIRC I got blocked by not being able to call
wiphy_delayed_work_cancel() without taking wiphy_lock. One way to solve
that might be to convert WMI event handling to use wiphy work but didn't
have the time to work on that so I put it on the backborner. I should
resurrect that branch and submit it as RFC.

But for the time being I think we need to add another mutex to ath12k, I
don't want to block Karthikeyan for too long.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

