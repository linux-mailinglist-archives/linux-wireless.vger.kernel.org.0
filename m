Return-Path: <linux-wireless+bounces-15552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 019AD9D4F5C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F99B295F8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACA91DB943;
	Thu, 21 Nov 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4JNW5KY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CC1D86C0
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200692; cv=none; b=JM7eZS2ylxV3Hs1SVDNtKi2OGFPg5QYrkwUhbzAlyd9zufJT+8vA7ElNBe8nC4CSE0ohX12zP/EsP4s9QidnfxNBjPSWeLBhsB/6GS1ROfqVWyZuJPx7YTuedDunO7OVMvoi4TA9SbtFCLiaVqmGfsaHPKYi83zYMNDrnvZfivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200692; c=relaxed/simple;
	bh=LngvGLFZC5Qou5Dlop/OMXQo8eWU8KDZaEVR0Requvs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AS5hFKxIMku60mokp7+oFQeTnHvTcZI9ZeRxen8a+Il7mevodP0qdge3AnIFROaRqRgP0Eu5oAgTjSNulA2CZNGKMETYEuaLQwLIquG9oRvm9eSPed6mmWzsQq+9qkqaQVROxFKpDEbjKlluHhNcey1Bx+M5AzcWNwZs2TxEUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4JNW5KY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DDCC4CECC;
	Thu, 21 Nov 2024 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732200692;
	bh=LngvGLFZC5Qou5Dlop/OMXQo8eWU8KDZaEVR0Requvs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=g4JNW5KYADtwNCUdxfO2dazs6BM0Eo6zK23MtkcpjV9Pl1nTUYiV2viZaolwCuS1h
	 xux8VSpZ0rvk0Pw2+Y26B9Co/1g/7hGViCDY4TJJIZw+W7MzJwlzdHWEY6QGeccmQa
	 1bPJZyysepzJIwqq0yH1JVCEa/+VUyLY77zM9ZyVilVneOVvSsBUhPh0tBpEpFudOA
	 KLHAXz3WeayeRjq+BVRMx4fDY0SD2vFWemOUsvYv/Ll9e15vmb7mUGP1ZFrVI+9Rbh
	 yAOB3FhI1eYDeCpr4J8eTuwT0QHR4NT23rlgT7y2GIvk4gog+mb/ooWNuGtEW/N9gG
	 gBxH4I4jBdnxg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
References: <20241106142617.660901-1-kvalo@kernel.org>
	<20241106142617.660901-2-kvalo@kernel.org>
	<2e706d58-5d83-4867-9963-c62441cdd4da@quicinc.com>
	<87y11o2x9h.fsf@kernel.org>
	<97f3f465-6ebd-4ca1-b672-4c8c7f42220d@quicinc.com>
	<87bjy9zonx.fsf@kernel.org>
	<d7a0d62c-4723-4e9f-a362-2ea51aaba3ed@quicinc.com>
Date: Thu, 21 Nov 2024 16:51:29 +0200
In-Reply-To: <d7a0d62c-4723-4e9f-a362-2ea51aaba3ed@quicinc.com> (Baochen
	Qiang's message of "Thu, 21 Nov 2024 11:35:30 +0800")
Message-ID: <87jzcwwsge.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

>> Ok, I think I now get what you mean. Does this look better:
>> 
>> static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
>> 					      struct ath12k_sta *ahsta,
>> 					      u8 link_id)
>> {
>> 	struct ath12k_link_sta *arsta;
>> 
>> 	lockdep_assert_wiphy(ah->hw->wiphy);
>> 
>> 	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
>> 		return;
>> 
>> 	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
>> 	if (WARN_ON(!arsta))
>> 		return;
>> 
>> 	ahsta->links_map &= ~BIT(link_id);
>> 	rcu_assign_pointer(ahsta->link[link_id], NULL);
>
> below synchronize_rcu() should be moved to here, such that any change
> to arsta can happen only AFTER all existing RCU readers finish
> accessing it.

Good point, I'll move it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

