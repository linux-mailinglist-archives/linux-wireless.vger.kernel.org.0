Return-Path: <linux-wireless+bounces-10820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15DA944EC3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 17:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C1D1F22ABC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 15:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E714413B287;
	Thu,  1 Aug 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWbSPhKz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED4F130A47;
	Thu,  1 Aug 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524881; cv=none; b=gQt4EiEkdhkO/1nVB0fk6cbnm+lUoUe8zQ6XryA3GJedPRcDingjR4pYk7r1rlCfg7X5DT5MGPh/mXUarhjVRTb6oBIcmZhniZuT5v9MTxr7X1IwNZ0sy5X4BQ2QRJ7vPnOm/fFJ876ZuIkP2bAYtPfbzlO3rnx5FVqCKI+reTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524881; c=relaxed/simple;
	bh=iubcbZDOWuaOtrwRjZEqiG4hMbLkd3IFWhnJGzWd94k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tR57CyBC38Th0svtNw1TyBt+4TnarzxYUmee9+Q0rGqQlpYSdC8nIXqqB80HmZw7i5I4KLIsrHJhzqKuCu0txl/sI5n7EX7UOqJc9JLANVXGpHAZZHvFkseq/jU9BOgLUVu+bwLvaudLHZNE9PSGXulHvS+wPK5nh/4bbf/t4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWbSPhKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BFCC32786;
	Thu,  1 Aug 2024 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524881;
	bh=iubcbZDOWuaOtrwRjZEqiG4hMbLkd3IFWhnJGzWd94k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MWbSPhKzRZAkCp1R/fruWbJiyTLqgerwsWIXcJgsJRJDvqGQpiHleO4xv89zMGUwi
	 2LrkVKvaxIHL6NsR27bW/2vu9iRO4LUp/ycuzEnLjMwLmHOP2P5p9r9CHguY1RTjcD
	 8/g7zUxyfzLrw+HvP27shxLqClrnWPBNmzC2eCkcrIFb1icKoKi/TQE9vv5hCVadxs
	 Na0yo3HThSWcwJJcIl7KbLiUJe76+vJofkfqaRXvRfDnEHE2Hvj8Qp80QfwbZGaDeX
	 w8mougg74N3wHtAAt+P0BefMszbuoC3kqBq92F126lO6Gb1m6GwxESRUuXHqoKEZoX
	 3y1zgQjyO1c2A==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  <kernel@quicinc.com>,  <netdev@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit
 path for WCN7850
References: <20240715023814.20242-1-quic_bqiang@quicinc.com>
Date: Thu, 01 Aug 2024 18:07:58 +0300
In-Reply-To: <20240715023814.20242-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Mon, 15 Jul 2024 10:38:14 +0800")
Message-ID: <87ed788enl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> In transmit path, it is likely that the iova is not aligned to PCIe TLP
> max payload size, which is 128 for WCN7850. Normally in such cases hardware
> is expected to split the packet into several parts in a manner such that
> they, other than the first one, have aligned iova. However due to hardware
> limitations, WCN7850 does not behave like that properly with some specific
> unaligned iova in transmit path. This easily results in target hang in a
> KPI transmit test: packet send/receive failure, WMI command send timeout
> etc. Also fatal error seen in PCIe level:
>
> 	...
> 	Capabilities: ...
> 		...
> 		DevSta: ... FatalErr+ ...
> 		...
> 	...
>
> Work around this by manually moving/reallocating payload buffer such that
> we can map it to a 128 bytes aligned iova. The moving requires sufficient
> head room or tail room in skb: for the former we can do ourselves a favor
> by asking some extra bytes when registering with mac80211, while for the
> latter we can do nothing.
>
> Moving/reallocating buffer consumes additional CPU cycles, but the good news
> is that an aligned iova increases PCIe efficiency. In my tests on some X86
> platforms the KPI results are almost consistent.
>
> Since this is seen only with WCN7850, add a new hardware parameter to
> differentiate from others.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -162,6 +162,60 @@ static int ath12k_dp_prepare_htt_metadata(struct sk_buff *skb)
>  	return 0;
>  }
>  
> +static void ath12k_dp_tx_move_payload(struct sk_buff *skb,
> +				      unsigned long delta,
> +				      bool head)
> +{
> +	unsigned long len = skb->len;
> +
> +	if (head) {
> +		skb_push(skb, delta);
> +		memmove(skb->data, skb->data + delta, len);
> +		skb_trim(skb, len);
> +	} else {
> +		skb_put(skb, delta);
> +		memmove(skb->data + delta, skb->data, len);
> +		skb_pull(skb, delta);
> +	}
> +}

I'm nitpicking, but usually booleans like the head variable here don't
help with readability. Having two separate functions would be easier to
read, but this is fine as it's so small.

> @@ -279,6 +334,23 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
>  		goto fail_remove_tx_buf;
>  	}
>  
> +	if (iova_mask &&
> +	    (unsigned long)skb->data & iova_mask) {
> +		ret = ath12k_dp_tx_align_payload(ab, &skb);
> +		if (ret) {
> +			dev_warn_once(ab->dev, "failed to align TX buffer %d\n", ret);

Why dev_warn_once()? I changed it to ath12k_warn() in the pending
branch.

> --- a/drivers/net/wireless/ath/ath12k/hw.h
> +++ b/drivers/net/wireless/ath/ath12k/hw.h
> @@ -96,6 +96,8 @@
>  #define ATH12K_M3_FILE			"m3.bin"
>  #define ATH12K_REGDB_FILE_NAME		"regdb.bin"
>  
> +#define PCIE_MAX_PAYLOAD_SIZE		128

PCIE prefix implies that this is in PCI subsystem. I renamed it to
ATH12K_PCIE_MAX_PAYLOAD_SIZE.

Please check my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=b603c1e0d94fb1eb0576ef48ebe37c8c1ce86328

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

