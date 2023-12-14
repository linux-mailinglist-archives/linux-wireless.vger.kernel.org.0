Return-Path: <linux-wireless+bounces-805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2357581367B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D161C20C8F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 16:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10160BA9;
	Thu, 14 Dec 2023 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTv3fVXj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97D60BA6
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 16:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34495C433C8;
	Thu, 14 Dec 2023 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702572043;
	bh=7q4xziHGQZPDQMbjsW2etL7QNNmAAzU2B1pJxrK6e9U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WTv3fVXjIgFvGu1uedym2kbxmcukkRvuBgsdXQTg1ZeOWfiQM6AnWogT8AtbWMdXW
	 1W/bqxkYc+ixqbsVPUjPPMG88tKGOcK02WhUqzuvU9BVCrQWdw/NU1lExdMim2WrqW
	 eIF91R+a2Lba91Mm3ERSN4DM6yuomlcNjZyvYy/LuHFwq7E4eGcGGZuGSTWLYqI+At
	 u8iGMqVCugdDaR5L1bE8KlBUrEz7oAZF+l4GTLmn7p8F76MO4eftL5SCsHE7pJH4CD
	 AYvZBKveayrKsGFXMyoWJxzjvzl8Cd2HHeAyim7VNMjUpeTBNfhWgIk3Qd2qeEkyNU
	 CkUA0zweHLYNg==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  linux-wireless@vger.kernel.org,
    ath11k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath11k: refactor ath11k_wmi_tlv_parse_alloc()
References: <20231214161117.75145-1-dmantipov@yandex.ru>
Date: Thu, 14 Dec 2023 18:40:38 +0200
In-Reply-To: <20231214161117.75145-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Thu, 14 Dec 2023 19:11:14 +0300")
Message-ID: <87fs04n3eh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Since 'ath11k_wmi_tlv_parse_alloc()' always operates on
> 'skb->data, skb->len' tuple, it may be simplified to pass
> the only 'skb' argument instead (which also implies
> refactoring of 'ath11k_pull_bcn_tx_status_ev()' and
> 'ath11k_pull_chan_info_ev()' in the same way). Compile
> tested only.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/ath/ath11k/testmode.c |  2 +-
>  drivers/net/wireless/ath/ath11k/wmi.c      | 73 +++++++++++-----------
>  drivers/net/wireless/ath/ath11k/wmi.h      |  4 +-
>  3 files changed, 39 insertions(+), 40 deletions(-)

Please Cc ath11k list for all ath11k patches, added it now. No need to
resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

