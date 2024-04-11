Return-Path: <linux-wireless+bounces-6154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4438A0C79
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF62C284E18
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D51144D20;
	Thu, 11 Apr 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWp11hQB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621613B2A8
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828026; cv=none; b=lGg02M2q1M4Am3LYRS85vCYghY+RvpHloJds7udzAPCej+pcWXRW9RQVPMvMItE1C7dBhPZYAiWiixNrRZ88ysn9aYZ/lYUnSe6tUzmGKGXaAmzAOoTS9waXrw0jBD9yWh4/6qoBIRNJvfAwNDQuCVNSoQalQVBKFR1IdsPksmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828026; c=relaxed/simple;
	bh=GC/DqxxpBatPJlbqgZHWoWw7lyNi3WC7bo6SMvypFWI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=k4R+OuJ21UaiYtXgnbKIpCeT5MwdEcyy3mvI3Zy7k6fhs9JBw+D5v4UUc187aPzQfdoMQ5HMDc9TbU53G3N3dtAhmS/pZ67FTQmgiczWaT7l+uBQkpySilPH7wXG0+GnVCq6yYT4+9i+BBOFbnEtnuOrszK668oSkUd/DwNs0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWp11hQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AD3C433C7;
	Thu, 11 Apr 2024 09:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712828026;
	bh=GC/DqxxpBatPJlbqgZHWoWw7lyNi3WC7bo6SMvypFWI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=TWp11hQBIcK/D7zoJPeOyF/lbX6o8+Xcd1V7+Nway/wtKbOrs0aNuqqTcdo5fWbUM
	 mEw9YbZKD9r7dy2JMU4VbcYeVF4LUtDR0UdfuBHMOzz/7COYtMIdVNvQ/BEHpid1tJ
	 LJ3Ep6/swo9/yQ20ugkYlhbNFa3RJO+RE1FBmGkUiX8Kab9/B8i+9NHUjPtTIQ3qKZ
	 SG60oDBwondLc5763eTp8VAXoHEHGuyirqZXZU7pn1TFdE97UB+XfuiF3jWHpVw0sn
	 vPn/S7oaJJ7LmGtUT4IfhiQMcKviePzjz+zjkgZeG4XL5z2CLXNtCZr7IoSpoKPE8J
	 XAG54QhMC0Rpg==
From: Kalle Valo <kvalo@kernel.org>
To: Nithyanantham P <quic_nithp@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: Re: [PATCH v2] wifi: ath12k: fix mac id extraction when MSDU
 spillover in rx error path
References: <20240329092432.873710-1-quic_nithp@quicinc.com>
Date: Thu, 11 Apr 2024 12:33:43 +0300
In-Reply-To: <20240329092432.873710-1-quic_nithp@quicinc.com> (Nithyanantham
	P.'s message of "Fri, 29 Mar 2024 14:54:32 +0530")
Message-ID: <87bk6gz1jc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nithyanantham P <quic_nithp@quicinc.com> writes:

> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>
> Currently, in the rx error data path, mac id is extracted from the
> last 64bits of MSDU end description tag for each entry received in
> the WBM error ring. Then, each entry will be updated into the MSDU
> list for further processing. The extracted mac id is valid when a
> single MSDU is not fragmented and received in the WBM error ring.
>
> In scenarios where the size of a single MSDU received exceeds the
> descriptor buffer size, resulting in fragmented or spillover MSDU
> entries into the WBM error ring. In this case, the extracted mac id
> from each spillover entry is invalid except the last spillover entry
> of the MSDU. This invalid mac id leads to packet rejection.
>
> To address this issue, check if the MSDU continuation flag is set,
> then extract the valid mac id from the last spillover entry.
> Propagate the valid mac id to all the spillover entries of the single
> MSDU in the temporary MSDU list(scatter_msdu_list). Then, update this
> into the MSDU list (msdu_list) for further processing.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Nithyanantham P <quic_nithp@quicinc.com>

[...]

> @@ -3807,16 +3816,50 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>  			continue;
>  		}
>  
> +		msdu_data = (struct hal_rx_desc *)msdu->data;
>  		rxcb->err_rel_src = err_info.err_rel_src;
>  		rxcb->err_code = err_info.err_code;
> -		rxcb->rx_desc = (struct hal_rx_desc *)msdu->data;
> -
> -		__skb_queue_tail(&msdu_list, msdu);
> -
>  		rxcb->is_first_msdu = err_info.first_msdu;
>  		rxcb->is_last_msdu = err_info.last_msdu;
>  		rxcb->is_continuation = err_info.continuation;
> +		rxcb->rx_desc = msdu_data;
> +
> +		if (err_info.continuation) {
> +			__skb_queue_tail(&scatter_msdu_list, msdu);
> +		} else {
> +			mac_id = ath12k_dp_rx_get_msdu_src_link(ab,
> +								msdu_data);
> +			if (mac_id >= MAX_RADIOS) {
> +				dev_kfree_skb_any(msdu);
> +
> +				/* In any case continuation bit is set
> +				 * in the previous record, cleanup scatter_msdu_list
> +				 */
> +				ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
> +				continue;
> +			}
> +
> +			if (!skb_queue_empty(&scatter_msdu_list)) {
> +				struct sk_buff *msdu;
> +
> +				skb_queue_walk(&scatter_msdu_list, msdu) {
> +					rxcb = ATH12K_SKB_RXCB(msdu);
> +					rxcb->mac_id = mac_id;
> +				}
> +
> +				skb_queue_splice_tail_init(&scatter_msdu_list,
> +							   &msdu_list);
> +			}
> +
> +			rxcb = ATH12K_SKB_RXCB(msdu);
> +			rxcb->mac_id = mac_id;
> +			__skb_queue_tail(&msdu_list, msdu);
> +		}
>  	}

The else branch can be avoided with continue. I did that in the pending
branch, please check my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6c677d91adad4817e7f6ef65a85331f52f0237ee

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

