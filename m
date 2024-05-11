Return-Path: <linux-wireless+bounces-7502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2208C3078
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 11:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED30B20C92
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B053610B;
	Sat, 11 May 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCWiW1bL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A192F26;
	Sat, 11 May 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715421277; cv=none; b=jHGfONtRoaUZsgW9R/UPdWnXzcnoaqIxCpP8XV4lyZfE/EcHUYbKQR9XP4Abrd0kPupjT2aGo5Upqdq+E1+oJvN8AKIjM56Xk6EB3sIJE4YTaU3n1UC5Eg2auBRBe67ucqR2/J2unPM+5rNEyxQ7QPa1oES8f4H14rJ1s0wSr/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715421277; c=relaxed/simple;
	bh=ZQQRlOIbe5G3/XXT9O32i9R08P6Fbwe16RrU6g6dlrA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eLlI5u1Qq609fi3zuqUwcfMxQr9Q9g8zvSwuwzDEKbHxGfBmH1hzRw+eqresy9ebM+jiDH1VgKE9VeUVS9gFU6j7jon3B2KjiIa0s/xI6Bn6zYxN+bZlJy/FBnojwK/HE6RNmtInf+uaWZYV4fA839QdPCHsszwtfJbUDkH1WBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCWiW1bL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A08C2BBFC;
	Sat, 11 May 2024 09:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715421277;
	bh=ZQQRlOIbe5G3/XXT9O32i9R08P6Fbwe16RrU6g6dlrA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=SCWiW1bLFKC0bFGAcGB+g9dUz4zN0VElcdHdlKb+t+nEHHLZCQfzR129GzFjvg9VZ
	 R00GatA/AfK55ay5Z07rywf0nEmCi20P0arjv8F+wLoE1+1tlr1uPQongkMSxuPxqw
	 f2mVJhmyPI03e4iQAdC6FwDChg+yFimLjO8j/WthYOA+XY6Nj7ew428xpPJRyS+I92
	 BZW+rTjO1JsA4OPTmOM3CN47KZtvIUrcFmOh2LlW8Dd3HC3YChE1NIrr6Hrp7CBBXz
	 E5zK6yVEWrxXbY8QHXkaWfOT9qJgucLkDELvtlmZyvBLbjDLpCvQlXE/jBbiL5kDkG
	 xmqedPriZsqtw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
    regressions@lists.linux.dev
Subject: Re: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage
 when connecting to 6 GHz AP
References: <20240424064019.4847-1-quic_bqiang@quicinc.com>
Date: Sat, 11 May 2024 12:54:33 +0300
In-Reply-To: <20240424064019.4847-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Wed, 24 Apr 2024 14:40:19 +0800")
Message-ID: <87wmo0k71i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
> ath11k fails to connect to 6 GHz AP.
>
> This is because currently ath11k checks AP's power type in
> ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
> However with above commit power type is not available until ASSOC stage.
> As a result power type check fails and therefore connection fails.
>
> Fix this by moving power type check to ASSOC stage, also move regulatory
> rules update there because it depends on power type.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>
> Fixes: bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Oh, this fell through the cracks. Commit bc8a0fac8677 was introduced in
v6.9-rc1 so I should have sent this to v6.9 but it's too late now. I'll
need to queue this for v6.10 via wireless tree.

Adding the regression also to regzbot:

#regzbot introduced: bc8a0fac8677
#regzbot title: ath11k: connection to 6 GHz AP fails

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

