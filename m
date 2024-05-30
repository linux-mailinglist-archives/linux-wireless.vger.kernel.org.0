Return-Path: <linux-wireless+bounces-8319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8584C8D4F6B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49191C22761
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22161EA8D;
	Thu, 30 May 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W76rWAWo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF21DA23
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084170; cv=none; b=L5o/7kaFziC2XTvMzhX4lnNd/6uMNNR/Yw7CBoZjpecmmLODp7OVp4ABhVq/qz6nQUSCx7a8zS/GjOXrz2ZG6M8ub/425CTmTlEa0jDU88ItD+m1I8QDJExe8ts9D60DWSuBiZu08C5mQrs5FQPsduPCm4UzsjnTP7PqKc5QV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084170; c=relaxed/simple;
	bh=0mrtFxmnKphhdbbAOAMZrrK6ThPiZ89bJ1wLJ4t9xeo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=FCaE2Fnkm39Pzif8WdiR0aRaxgWDaO5Zs79iMPqB6/JRkxU/31U/OB6+m3Sx/Yg1SNEBcvDrkG5TYRkqDsR60zobQmucyVj88SEeIsfQIpv6ITKzYkKTM/W3YqpuvY/xx8yIsnOPmHrKTqDsbFoUCi9jGWaj/H4Nw76wTvpuMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W76rWAWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE0BC2BBFC;
	Thu, 30 May 2024 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717084170;
	bh=0mrtFxmnKphhdbbAOAMZrrK6ThPiZ89bJ1wLJ4t9xeo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=W76rWAWoP3T8RGwrFN/CxV0OdpVHAqWicn7MredWG0uzT6yQpW7Yja1EnaHXfSJWU
	 7ydZFyB2pKrbuFjMPMwAfZG+6OUA2qkwdllIvCCI436XIHFhekbWO89oQhX7wk67KB
	 F0uEgeeCiMdYm949G62X9iOH2IZ9MtT7MVudtHvCm6cCqj+/hmwyC+mS9/4lw7WCHv
	 wUPhYIwaoC0KAEyk+7Y3jMwvy1qiy7vgSnzyjT1x24oDfCDNdCn+Rk5fjfqHOOi74N
	 i5hztsvCq6pb0X5L33ynTbQmDZoQy9vboF5jviz3cxoqRObZJ2QlatGIxuYy+Kcznh
	 QfU5IzLQac5Zw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix memory leak in
 ath12k_dp_rx_peer_frag_setup()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240526124226.24661-1-quic_bqiang@quicinc.com>
References: <20240526124226.24661-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171708416720.182911.5669999040960213709.kvalo@kernel.org>
Date: Thu, 30 May 2024 15:49:28 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently the resource allocated by crypto_alloc_shash() is not
> freed in case ath12k_peer_find() fails, resulting in memory leak.
> 
> Add crypto_free_shash() to fix it.
> 
> This is found during code review, compile tested only.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3d6004154318 wifi: ath12k: fix memory leak in ath12k_dp_rx_peer_frag_setup()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240526124226.24661-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


