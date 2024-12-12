Return-Path: <linux-wireless+bounces-16311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8579EE85F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 15:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF33318839DD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 14:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3A2135BA;
	Thu, 12 Dec 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dij1jZYP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA42211706
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012453; cv=none; b=nIFDApGqQtyAHtw/TySaB13jpXWsOH5pPEK4uz1kOQrO1CIoyVotYNma1/Qv20IX3f/RmzbiVeFzRwHi0P3LrRI4OIIV+SWfy5RLjGQslxWuk4BAsOMTNN8VSvT6JJOW9xfnTZG8kccWqc8SS5S3qY04C9UFFn4eBeHtZO4sBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012453; c=relaxed/simple;
	bh=eyznZ2mkLy7ZoKxsgj/okX7js0JkRxEsD12qrlawO5E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nVU1lKCvaAmKxXTd+UCsodMzMZJ64CWLkVT0t77wJAA4ecTdN95REAisD3P+vKkaSXdTTqajboMeOUAe6CNuWFmXMwO3XPOwJXnZzp5Se59iWqfKAk7Ov2OUGe8VviDOxRBVoAEyjgba9F1UqLRRNAe6+KorMJYnvUpG9Le/zw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dij1jZYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA78C4CECE;
	Thu, 12 Dec 2024 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734012453;
	bh=eyznZ2mkLy7ZoKxsgj/okX7js0JkRxEsD12qrlawO5E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Dij1jZYPa+HRpr4w2vrwGi333lyWewebepgZTfUfOSF3UAhVlCf8zvSSj1PQrTt68
	 g/TMk1YidH56X1oZr4LrZYAT9/3jWtAz+bXZoIfo6Lkhc+ZNWnjsMWjhQ4jh03fTUD
	 YcQOwMG9rqCSMDJI5vI0Y2mtw8hbRWrQ5hU1kHv/NMBl/mwTiZTS3A9qiPBKDazY2i
	 djVV5iZ9hvxl+ASCa3nzZka5dLuR8sjwykJDA1CyiyH2sp6KvpdrxFa7IgcVmHecl7
	 RIDe5xGmpyoIDici4vu8DTQY5ECDWOX8s4LTsZ3reDdfax7yVKVvrDJSWrcyDtBdbx
	 dMtbh80V3Dl2w==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] wifi: ath11k: move update channel list to worker
 for wait flag
References: <20241129070714.226-1-quic_kangyang@quicinc.com>
	<20241129070714.226-3-quic_kangyang@quicinc.com>
Date: Thu, 12 Dec 2024 16:07:30 +0200
In-Reply-To: <20241129070714.226-3-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Fri, 29 Nov 2024 15:07:14 +0800")
Message-ID: <87y10lngf1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> From: Wen Gong <quic_wgong@quicinc.com>
>
> When wait flag is set for ath11k_reg_update_chan_list(), it will wait
> the completion of 11d/hw scan if 11d/hw scan is running.
>
> With the previous patch "wifi: ath11k: move update channel list from
> update reg worker to reg notifier", ath11k_reg_update_chan_list() will
> be called when reg_work is running. The global lock rtnl_lock will be
> held by reg_work in the meantime. If the wait_for_completion_timeout()
> is called due to 11d/hw scan is running, the occupation time of
> rtnl_lock will increase. This will increase blocking time for other
> threads if they want to use rtnl_lock.
>
> Move update channel list operation in ath11k_reg_update_chan_list() to
> a new worker, then the wait of completion of 11d/hw scan will not
> happen in reg_work and not increase the occupation time of the rtnl_lock.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Co-developed-by: Kang Yang <quic_kangyang@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

Same here, I think the commit message should be more or less rewritten.

> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -743,6 +743,10 @@ struct ath11k {
>  	struct completion bss_survey_done;
>  
>  	struct work_struct regd_update_work;
> +	struct work_struct channel_update_work;
> +	struct list_head channel_update_queue;
> +	/* protects channel_update_queue data */
> +	spinlock_t channel_update_lock;

Do you really need a new lock? Why not use data_lock?

> @@ -6318,6 +6320,15 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
>  	}
>  	spin_unlock_bh(&ar->data_lock);
>  
> +	spin_lock_bh(&ar->channel_update_lock);

Empty line here, please.

> +	while ((params = list_first_entry_or_null(&ar->channel_update_queue,
> +						  struct scan_chan_list_params,
> +						  list))) {
> +		list_del(&params->list);
> +		kfree(params);
> +	}

Here also empty line.

> +	spin_unlock_bh(&ar->channel_update_lock);
> +
>  	rcu_assign_pointer(ar->ab->pdevs_active[ar->pdev_idx], NULL);
>  
>  	synchronize_rcu();

[...]

> +void ath11k_regd_update_chan_list_work(struct work_struct *work)
> +{
> +	struct ath11k *ar = container_of(work, struct ath11k,
> +					 channel_update_work);
> +	struct scan_chan_list_params *params;
> +	struct list_head local_update_list;
> +	int left;
> +
> +	INIT_LIST_HEAD(&local_update_list);
> +
> +	spin_lock_bh(&ar->channel_update_lock);
> +	while ((params = list_first_entry_or_null(&ar->channel_update_queue,
> +						  struct scan_chan_list_params,
> +						  list))) {
> +		list_del(&params->list);
> +		list_add_tail(&params->list, &local_update_list);
> +	}
> +	spin_unlock_bh(&ar->channel_update_lock);

What about list_splice_tail_init() or similar?

> +
> +	while ((params = list_first_entry_or_null(&local_update_list,
> +						  struct scan_chan_list_params,
> +						  list))) {
> +		if (ar->state_11d != ATH11K_11D_IDLE) {
> +			left = wait_for_completion_timeout(&ar->completed_11d_scan,
> +							   ATH11K_SCAN_TIMEOUT_HZ);
> +			if (!left) {
> +				ath11k_dbg(ar->ab, ATH11K_DBG_REG,
> +					   "failed to receive 11d scan complete: timed out\n");
> +				ar->state_11d = ATH11K_11D_IDLE;
> +			}

Empty line here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

