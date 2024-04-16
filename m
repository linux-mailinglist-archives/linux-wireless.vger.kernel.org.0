Return-Path: <linux-wireless+bounces-6372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8B78A64E9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FD1F22AD9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB873199;
	Tue, 16 Apr 2024 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXNQpEAa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9171B50
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251965; cv=none; b=jWEz+p5kYf6WOPvOhub5tED4SgXHKaaZOwpIoOkn7cACbyY2l42SI+pzZkCDqcuVXTeME2ZR8VHpoPJdYGozXP77OLzrcO8GYp3N1UH3aK40ixi94Jw/8Rt38oU0cX/4++F21IIZTD93cfxlagcID3nUZty9fHj/qVGYxHl45ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251965; c=relaxed/simple;
	bh=Pr/5HGs/OWtfrjJ1CQ6MGyfV5QClGefOW002TIyUGy4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=fs/G1+G2527yQVSmrNTbg8CG3dQYP70qL4ZwGBgN8D3u8bnrTWNjRsstUmepf5KzCZptSB5zQF8O173a/rXqNsm1EAXadqXOb+r2P5EF0UNe7axnA8MmuppgfnrwyiqdbJ+124aBLB7VY7RJgsCP+X0LnCYuBjlG9a1g6PUnLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXNQpEAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6E1C113CE;
	Tue, 16 Apr 2024 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713251965;
	bh=Pr/5HGs/OWtfrjJ1CQ6MGyfV5QClGefOW002TIyUGy4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=gXNQpEAafVsoj6NDdvmOeCMGlQYwvZvH1V5/r6WwkESs38dSSrhbeSNTCKRJ08L4S
	 w1CdX8F2jKYLbyUflgmA/sTbymN5PodrSYUm/Vl20aKbVaFRLDUPgHL2KXDkjKsM9Z
	 L5/s9CRTdgcJ22fYLWfG740XlKb/TtufIZ3wLNps+KGp4QK5zO65p80ozvw/HpzIsJ
	 RCnSMkebKPWJIPTY3m5Aa6Tx6DD+Um4KYbiw75P3QSLguRJbgCTPAKw2mS4AhmVdPL
	 oSCUlQOK3qpr4LAWqYtsZkK1VpWW+7Gedqk8GHgjHh6pTqhse9yWkedmt6H/CPR4yj
	 +S6wOiza2pq+A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: dynamically update peer puncturing
 bitmap
 for STA
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240408083047.22548-1-quic_kangyang@quicinc.com>
References: <20240408083047.22548-1-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171325196269.4097708.17420156398205225314.kvalo@kernel.org>
Date: Tue, 16 Apr 2024 07:19:24 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> Every time EHT Operation element changed, mac80211 will parse it and
> extract the valid puncturing bitmap according to the bandwidth.
> 
> Current driver only update puncturing bitmap to firmware as vdev
> parameter. Which can only meet the needs of AP. But STA will also use
> it as peer parameter. If only update as vdev parameter, might cause
> firmware crash. QCN9274 is the same.
> 
> So update bandwidth and puncturing bitmap as peer parameters once they
> changed for STA. Then send them to the firmware by WMI event.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0531825408ce wifi: ath12k: dynamically update peer puncturing bitmap for STA

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240408083047.22548-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


