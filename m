Return-Path: <linux-wireless+bounces-14151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C499A24F4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD7D28990E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8B1DDA09;
	Thu, 17 Oct 2024 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmV7ieoA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE91DD540
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175164; cv=none; b=ipQ9FZWWL3R1VTcL7e7T/m7VdheswAXahmvmCPL4b5w6M2tJHtrAQKZRrtEYz0oI3XL5PziyQsKNKS1GxQEmElvyLMugGMP9BqIsc3TKoG5XoUQh6K52cu2KFhhwunf4bfPElS2MQbSggiuJos9p4oBkYWy2IFHpQ6ZFaIOdvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175164; c=relaxed/simple;
	bh=ICXkrsXNnojjdPLcTUdfr92shgtN7o7vqH9yRvnuhVs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=nTrFjrvYPTTlEdjsPTf8jQ1ZxlwMxhQfw8s/rfLXzSlX5ChiLteVE8WCyXGFtMhg15U3GhA2Tb5AhW5yFY12YWDmq2XdN9UHVUxc/649CbGSp6BNU0AyahauzqT/M5ZMazPf+DVqESI0D7WCnVqUwfCcRm1PQ9DWeASZ6WIqezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmV7ieoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E67EC4CEC7;
	Thu, 17 Oct 2024 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729175163;
	bh=ICXkrsXNnojjdPLcTUdfr92shgtN7o7vqH9yRvnuhVs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cmV7ieoASYhIh9KQ1UX3edFptGCC5G3yzJQusjGH9tL+W457eyXZZ8Yu3btqeMccN
	 YywWWQkNGHTAjL3cJhY6vvdVrQfslEATqA8SwhLUaklq6fjayuSxYYVxLVJR4M+pup
	 d9PG3HZ7rqvS93Pk3IV+Yvc0CnBDBNg5JIzNA39ruplH/Xt6d3ZXD5FnaSI8XapnTW
	 qJwC0SoUFLuvXjkCtiOaQTylz2I8c/lqOb5ahfKYgK7BBstcZxHm4DGZhN7t2HB6Ni
	 P2iGpul1xBx2i8YMGsZyMSx2CMj2CPgiWi1rcx7wyaBoWAoAVbNKRsXRGrIkL4B90s
	 h8DV2r+FCe/tw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-current-20241016
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <0ea819f9-d563-46c1-9a68-3800c81565dd@quicinc.com>
References: <0ea819f9-d563-46c1-9a68-3800c81565dd@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
 <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
 <quic_jjohnson@quicinc.com>, <quic_kvalo@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172917516046.799221.17034758455768979128.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 14:26:02 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The following changes since commit 2f833e8948d6c88a3a257d4e426c9897b4907d5a:
> 
>   Revert "wifi: ath11k: support hibernation" (2024-09-02 19:33:00 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20241016
> 
> for you to fetch changes up to befd716ed429b26eca7abde95da6195c548470de:
> 
>   wifi: ath11k: Fix invalid ring usage in full monitor mode (2024-10-16 07:30:31 -0700)
> 
> ----------------------------------------------------------------
> ath.git patches for v6.12-rc4
> 
> Fix two instances of memory leaks, one in ath10k and one in ath11k.
> 
> ----------------------------------------------------------------
> Manikanta Pubbisetty (1):
>       wifi: ath10k: Fix memory leak in management tx
> 
> Remi Pommarel (1):
>       wifi: ath11k: Fix invalid ring usage in full monitor mode
> 
>  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 7 ++++++-
>  drivers/net/wireless/ath/ath10k/wmi.c     | 2 ++
>  drivers/net/wireless/ath/ath11k/dp_rx.c   | 7 +++++--
>  3 files changed, 13 insertions(+), 3 deletions(-)

Pulled, thanks.

a940b3a1ad0f Merge tag 'ath-current-20241016' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/0ea819f9-d563-46c1-9a68-3800c81565dd@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


