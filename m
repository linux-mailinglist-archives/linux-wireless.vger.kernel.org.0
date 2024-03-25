Return-Path: <linux-wireless+bounces-5176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E488A853
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F327C05F54
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29445137934;
	Mon, 25 Mar 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIpOvCvI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5112CD9B
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363912; cv=none; b=CsIV6RaNnl3d/IWLFtX0G+2JpmmBzLIRKQwT9zUNX0gaRIhlyX5cHK2Ici+xdan5l4RGqg5o1dRnSIt0jz/bi6bN7CRYKZaI+6zSYjHA0U4QlAQ+mGZSsWgpimt1MjAKfgZHWDgQ2ievYIvOXy7a9rUv+8NHBsQ5rojBpZRAR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363912; c=relaxed/simple;
	bh=lp35e7eS4CY1qdkvmPWtokuA6SAAw4yzmHLeOHp1kLI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=o1+0WkAAxieLTBvVG5yFpIQ79lDoz1HM8blAvpKKeMcYi+DICeI+bwvWrD3EboweRpo0pWU1rSLaVOKRymVmN3OLH5MumSHWNF1B81QlRMjOdu+jWGdWEy19Q+07L5D3HXSWbAyHWaEfOiOBE8BBsdBx7qclK3mG68EQYDWQ2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIpOvCvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21203C433C7;
	Mon, 25 Mar 2024 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711363911;
	bh=lp35e7eS4CY1qdkvmPWtokuA6SAAw4yzmHLeOHp1kLI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bIpOvCvIh06zMFKHw9i88lUgm12dkPjeXndvEQy6VsJbg0C7bs4J8Zki/a4I/yD5J
	 35w5BC6F5pd71LayK8ybCa2UPzIOTZbFucDAe1Wim+LU+kM8e/OHI+6Q8i9GIrCWzg
	 eK43BJiJubHwlff6rtMAVgul90mfBOf0wEze/TD6nxf/y/FVr3ttHu7H2DyGPY0a4R
	 tccj6tlFP+ryLKkp0N+nDlFjrOlXAw8L3Fw2sKMJUkQ7YQ3jRUIqFRS+dlf7ZPLUr9
	 5TGnSFF4BAxEbhX4hzkkjNtHSrQo6xskSqSn47M4K0YbPNVtxSuWIMhNznHA/1LGgU
	 aExLjX85Isb0A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] wifi: ath9k: ath9k_set_moredata(): fix sparse
 warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240320170656.3534265-2-kvalo@kernel.org>
References: <20240320170656.3534265-2-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: toke@toke.dk, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171136390925.1022746.16408802632389269104.kvalo@kernel.org>
Date: Mon, 25 Mar 2024 10:51:50 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Sparse warns:
> 
> drivers/net/wireless/ath/ath9k/xmit.c:1677:20: warning: incorrect type in initializer (different base types)
> drivers/net/wireless/ath/ath9k/xmit.c:1677:20:    expected unsigned short [usertype] mask
> drivers/net/wireless/ath/ath9k/xmit.c:1677:20:    got restricted __le16 [usertype]
> drivers/net/wireless/ath/ath9k/xmit.c:1681:17: warning: restricted __le16 degrades to integer
> drivers/net/wireless/ath/ath9k/xmit.c:1682:42: warning: restricted __le16 degrades to integer
> drivers/net/wireless/ath/ath9k/xmit.c:1682:36: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ath/ath9k/xmit.c:1682:36:    expected restricted __le16 [usertype] frame_control
> drivers/net/wireless/ath/ath9k/xmit.c:1682:36:    got int
> 
> Fix ath9k_set_moredata() to use __le16 with masks and use if statement instead
> of multiply operator.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>

3 patches applied to ath-next branch of ath.git, thanks.

e5f6c85ac16f wifi: ath9k: ath9k_set_moredata(): fix sparse warnings
a854028e7bd8 wifi: ath9k: fix ath9k_use_msi declaration
f09e3b774fe8 wifi: ath9k: eeprom: fix sparse endian warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240320170656.3534265-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


