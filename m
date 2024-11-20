Return-Path: <linux-wireless+bounces-15534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B13C29D3FB7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652D7B3462E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E5213B59E;
	Wed, 20 Nov 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSDbNf/3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194F482EF
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118230; cv=none; b=IjsxtUgOgH/1vryxfEZ3Ca0n5xt19SYtP7sTyLFETBI6jomxU94QyLlLOQd1KwzcPGgIa0SwHBdinbWlRPAG2YHOATlxPgO+PR78jYZwpKBcs74JdddyRiE/vdtTdKaNtnSTdb1d/ni942XbuKFbMlIH1sx1aBCtpgARpqPOlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118230; c=relaxed/simple;
	bh=9HtNhpAoeaZqWtQn9YJ4/BbDLRqxCH3IH1krL7hPBRA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Nws/YOCvoSl9RaHrFodbOa3lUKxYQdqkTFoHpGL8Kkqhn3MTbQ7Sdl8CoC16j+yTHJ/HL6v+oQ9IMgfRZeAAi+kYs7gjj68W40esCVbJnnhw3GnTxC7Y25pvPPdU4ab1q7QMHePDgeWpuvgmG7pZlLCFLzqg+9U3fgOUkx8WNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSDbNf/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D7EC4CECD;
	Wed, 20 Nov 2024 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732118230;
	bh=9HtNhpAoeaZqWtQn9YJ4/BbDLRqxCH3IH1krL7hPBRA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NSDbNf/3pQW24+VIO4wp+UMoU4Aw4Nf+Bmh9n1QBI1rNaO5GbekDGBdwqeGoTqS3e
	 +e52IW1JeAo9hI1akj06jFaO2idHlkPf4MpcPHM+qkYl26k4clCP+oiwc2VQRqyB+G
	 XxlkbF9MXWPTTA1+7CIqZ9qwiv7qIyy2EN3Bfkb7wbDJLjDDYLeszWc9Q6kTpM/nrl
	 8RS+mfOat4iE0/ftPuwmuSSDKIG72WYo1tYrGMBdnqguMl8/CmKEHp3zGtB4triBuN
	 NLh041UZDgGxcP5+qxAsX3GawdRo6ZNCP444uKceGS/dX3eWMniO4oabwrQdMEBNMF
	 +XrE21St/ZpPw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
References: <20241106142617.660901-1-kvalo@kernel.org>
	<20241106142617.660901-2-kvalo@kernel.org>
	<f75d7222-514b-4c6f-985d-e6ffd67e317a@quicinc.com>
	<877c984eym.fsf@kernel.org>
	<ffa411d1-89d3-4278-9f62-828c27c0afe0@quicinc.com>
Date: Wed, 20 Nov 2024 17:57:07 +0200
In-Reply-To: <ffa411d1-89d3-4278-9f62-828c27c0afe0@quicinc.com> (Baochen
	Qiang's message of "Wed, 13 Nov 2024 10:33:38 +0800")
Message-ID: <87frnlzyng.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

>>>> +	arsta->arvif = arvif;
>>>> +	arsta->ahsta = ahsta;
>>>> +	arsta->state = IEEE80211_STA_NONE;
>>>> +	wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
>>>> +
>>>> +	rcu_assign_pointer(ahsta->link[link_id], arsta);
>>>> +
>>>> +	synchronize_rcu();
>>>
>>> what are we waiting for here?
>> 
>> That's a good question. I didn't analyse that thoroughly but I'm just
>> making sure here that all readers have access to the new arsta before we
>> return to mac80211.
>
> why would readers have to access arsta BEFORE returning to mac80211?
> any potential race conditions?
>
> and even if it is necessary, how could synchronize_rcu() guarantee
> that? synchronize_rcu() is used to make sure all readers have exited
> from RCU read critical section, I don;t see how it could make sure a
> newly assigned entry get accessed.

Yeah, I'm not making any sense. I'll remove synchronize_rcu() in v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

