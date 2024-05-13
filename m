Return-Path: <linux-wireless+bounces-7594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF98C42EE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E171F21814
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5C15381F;
	Mon, 13 May 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIynacKM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733C153580;
	Mon, 13 May 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609627; cv=none; b=Jx4PH/7bpFT+RJdyTFPKNV7UDZsIV9zVAmx8ildz+BYWjF900Qj3LdLg3JctvMYWAVtIjF+AeKGIoD35wnFGgaxkvbDj12ZZmTL+fKrcAnlxESNSl57PM5K6TM/1KkKIv7m3CosGe7gpc00JXBI6mcDwDzoZWO8r0C3l7/0Uqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609627; c=relaxed/simple;
	bh=enFo1Q6sy9LPBkEPmc/Y7IiWPlpY3AWCf3OHewvllx8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=tn8qxiqqhqvF2ZI5iBufo8/f+Tsnxxn4quCg2tIyflJu6+Z6KnBP8p5sO1hMu9dxCxiaErH9gRUXMsX2hYIiFpIlgeUvgQ5wU3BV42P9zKc1otgpCQIyBCoBlJRXCDw7itSGrj+P44T989ZJO5WvOO5GfMqDMRtFCVQM5gKx84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIynacKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FDCC32782;
	Mon, 13 May 2024 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609626;
	bh=enFo1Q6sy9LPBkEPmc/Y7IiWPlpY3AWCf3OHewvllx8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CIynacKMN88+mWnmzA2waduskLXgnxRPXIlGw4eCZfy2gEtl80l9h099oNKqcFc2C
	 WG+wYeUkGc14MoRa/ZnQKCsuAMDqtbEwk84MPHBMZEPtL3jAElTWR8HmQw4zagq0dO
	 RHmYsG/ehzMbUKnBH98YJrWqOLkSh25HoAZvUpZ2UdhgkijPpRjpOLJWlGbxFfmAFK
	 mWbPPtGbyu+evzS9gHzJlrSaOyp+7Npq4IeEJrxWjlIw70Z50byRcC3VVZ7pwar3cc
	 dUsh6xamq7ankTtbiseOLN92TH0jhH+qFGV8njCHCJfdbCOTDL3cJNSrFcSo9U4R9f
	 gcXJyKfHfnMqg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix misspelling of "dma" in
 num_rxmda_per_pdev
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240504-ath11k-num_rxmda_per_pdev-v1-1-7f97bced8495@quicinc.com>
References: <20240504-ath11k-num_rxmda_per_pdev-v1-1-7f97bced8495@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171560962350.1690511.13501217225200268236.kvalo@kernel.org>
Date: Mon, 13 May 2024 14:13:45 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The ath11k_hw_params member num_rxmda_per_pdev contains a misspelling
> of "dma" so fix it.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a6efa4ea0613 wifi: ath11k: fix misspelling of "dma" in num_rxmda_per_pdev

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240504-ath11k-num_rxmda_per_pdev-v1-1-7f97bced8495@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


