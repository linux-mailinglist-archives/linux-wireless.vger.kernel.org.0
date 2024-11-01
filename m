Return-Path: <linux-wireless+bounces-14803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE999B8AC9
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 06:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC141C2195E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 05:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BF1494BB;
	Fri,  1 Nov 2024 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+yPTUCT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8136B;
	Fri,  1 Nov 2024 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730440771; cv=none; b=EpKy5ktVTXfD6JJ9g6X4dRL6EPMTRVLBKwPxQzvPRHc6q4cCIrnFkqSmYCJaAGwK1R5q2z5X/kMzLX0NHwfQHWccve6UApJSJGd86zBIDPVr925JPHo/LOKpQztO8l+LzJE+0j26xSxXpTpaoIX8QE9H8kp0iRO1xzHy3rl9LDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730440771; c=relaxed/simple;
	bh=w8CJk0Lj+OggVkEl3e7Y2Zhv00G5Vs+rcrgZnjXssew=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VtMxc0pq5AR9ge3O284Q5EvFMsXyRWyFK+QEY1sZNhrh27OoREN2E1m+w/W39B7FTnN4u/XOpnLqa6pM1+DBh/ogQX3PF5vfaTX+vS+7wJIBEHWdxXT2OONulXtUZTASFJDU2q4nQhCyDwTVuFfojQQFn9DlGYruxhS2OWTjXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+yPTUCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1BFC4CECD;
	Fri,  1 Nov 2024 05:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730440771;
	bh=w8CJk0Lj+OggVkEl3e7Y2Zhv00G5Vs+rcrgZnjXssew=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=O+yPTUCTFB2BIFXBIu9ehOvcCY8X/sdl2BrhReB8zNlZBpPI1UUeQ5y8/bQNMmF/a
	 McwwnUwK4XkM6DJpsJvGnJfveubU3CjU0IOIxMjyf7rE2MY30quHqwK3V2g9iZENIl
	 mKVybqkBmNw+aaaxDmTfctspvSw7jKyWLlOvyTBSMu5mLcLqmnSmhKNc+qaQaG2N8y
	 B623zJxANjqLwo2v3Uuu5wzmuGQrYCqmGzn8mXPFSVk9fye2htMzXpA7C73V10jAgX
	 4en1jBzCi7wTLgZzJ2L3yDM26oNpPNqI25N2qZpuJLjNHFkyg4I5Dw3BOtAmZfh2+i
	 Nv2ptH0IotK5g==
From: Kalle Valo <kvalo@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: stas.yakovlev@gmail.com,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2 -next] wifi: ipw2x00: fix bad alignments
References: <20241101022215.6667-1-jiapeng.chong@linux.alibaba.com>
Date: Fri, 01 Nov 2024 07:59:28 +0200
In-Reply-To: <20241101022215.6667-1-jiapeng.chong@linux.alibaba.com> (Jiapeng
	Chong's message of "Fri, 1 Nov 2024 10:22:15 +0800")
Message-ID: <87cyjfze7z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:

> This patch fixes incorrect code alignment.
>
> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:871:2-3: code aligned with following code on line 882.
> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:886:2-3: code aligned with following code on line 900.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11381
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Replace the & in the if statement with &&. Add 'wifi: ' to subject.
>
>  .../net/wireless/intel/ipw2x00/libipw_rx.c    | 44 +++++++++----------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
> index 7e41cb7bbfe0..38731f67cb54 100644
> --- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
> +++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
> @@ -868,34 +868,34 @@ void libipw_rx_any(struct libipw_device *ieee,
>  	case IW_MODE_ADHOC:
>  		/* our BSS and not from/to DS */
>  		if (ether_addr_equal(hdr->addr3, ieee->bssid))
> -		if ((fc & (IEEE80211_FCTL_TODS+IEEE80211_FCTL_FROMDS)) == 0) {
> -			/* promisc: get all */
> -			if (ieee->dev->flags & IFF_PROMISC)
> -				is_packet_for_us = 1;
> -			/* to us */
> -			else if (ether_addr_equal(hdr->addr1, ieee->dev->dev_addr))
> -				is_packet_for_us = 1;
> -			/* mcast */
> -			else if (is_multicast_ether_addr(hdr->addr1))
> -				is_packet_for_us = 1;
> +			if ((fc && (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == 0) {

I meant instead of using two nested if statements you can use only one
if statement with '&&' operator.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

