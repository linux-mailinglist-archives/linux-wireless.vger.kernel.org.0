Return-Path: <linux-wireless+bounces-8765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD93902777
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D67E282145
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6A143740;
	Mon, 10 Jun 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKI8bjW6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1739142E98
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718039431; cv=none; b=XyrY0+7+ePzx9NztUsEAK4eDDKGuH/j0NPNq7s3FRFTPBtsDjLsHx/76idDGJKJflhbmpSRqpZztCMWu31sv/NswlNOKoO5KYxbbbC1nKgrAQZ8obVAlytUnDCf4zA1kWjgqNefdpwtktECHrWw/kOnIpKvZcnzC6dmJw6kAKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718039431; c=relaxed/simple;
	bh=grP4NaktoAdLLafbOG3p1B0ZjNIfETFhaDCcjcytV7w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JNnmPBPD5RXhLWcPVN0zdabypnO0vLdA9ogIOZlutT52ZzX8+M65ayoZiMv/EUMujKQoZTw7rMt7xSMEwjx0Yi+wbbUHoRWVJdYPA/hHgA7sT5C9396KfhuDiWFsno4ZJHR937g6PmAgg7V2YqKiiknoRoqVHIIt5jxSWsipbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKI8bjW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39B6C2BBFC;
	Mon, 10 Jun 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718039430;
	bh=grP4NaktoAdLLafbOG3p1B0ZjNIfETFhaDCcjcytV7w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mKI8bjW6ye94YnKrVep3fgICKQ3i3KxA0sQGil0h4G2GQeUCRVnh3ELyf1ZZOPG42
	 ZWTuptvG+QxZRaXtw1DvXJh7u5bOuMhQR1wB770fCBAmJh0uP5wXjXirzByBfXtgFf
	 TvMUQfwCZvvdTymEhqGfCrUWXdoRfDCpTDitLPEbsp2/qEZddDStHRz3XXGJMRTIMy
	 bf9gfxhQm7257NPO/8Mkt8rnCOz8yv4hRHEfL2TvdMyo8qbqgY/Bua7p/V4vdDoyao
	 g56Sc3HK0mfNtQ0VNlUkwBlW5CEUy5g8k9WUe7mAfyudC79vpgssLpNZXl848mRYEy
	 rg3cDW0gzHzfw==
From: Kalle Valo <kvalo@kernel.org>
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Fix WARN_ON during firmware crash in
 split-phy
References: <20240529034405.2863150-1-quic_aarasahu@quicinc.com>
Date: Mon, 10 Jun 2024 20:10:27 +0300
In-Reply-To: <20240529034405.2863150-1-quic_aarasahu@quicinc.com> (Aaradhana
	Sahu's message of "Wed, 29 May 2024 09:14:05 +0530")
Message-ID: <87v82goha4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaradhana Sahu <quic_aarasahu@quicinc.com> writes:

> Whenever firmware is crashed in split-phy below WARN_ON triggered:
>
> ? __warn+0x7b/0x1a0
> ? drv_stop+0x1eb/0x210 [mac80211]
> ? report_bug+0x10b/0x200
> ? handle_bug+0x3f/0x70
> ? exc_invalid_op+0x13/0x60
> ? asm_exc_invalid_op+0x16/0x20
> ? drv_stop+0x1eb/0x210 [mac80211]
> ieee80211_do_stop+0x5ba/0x850 [mac80211]
> ieee80211_stop+0x51/0x180 [mac80211]
> __dev_close_many+0xb3/0x130
> dev_close_many+0xa3/0x180
> ? lock_release+0xde/0x420
> dev_close.part.147+0x5f/0xa0
> cfg80211_shutdown_all_interfaces+0x44/0xe0 [cfg80211]
> ieee80211_restart_work+0xf9/0x130 [mac80211]
> process_scheduled_works+0x377/0x6f0

This is just the stack trace, not the full warning. If you send me the
full warning I can add it to the commit message. Also it would be always
good to identify what warning it is exactly as line numbers can change
etc.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

