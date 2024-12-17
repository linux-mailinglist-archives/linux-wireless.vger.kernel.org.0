Return-Path: <linux-wireless+bounces-16479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787F39F4E94
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 15:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4DA1894C78
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472DE1F706F;
	Tue, 17 Dec 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuAZVrqJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224221F63DD
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447194; cv=none; b=Nx93hl5Hr5r7NIpHK+fQM48en1x0bGW3J/EbvJJyBRmtk5eJgmL3rOyr5Au8Y2MwAIlemPiKiKvrC46jHdqMbduoVug6IiX9LmWbpi1fu28GwuSHYfA6kByY8lG1MKaJvtRlNBRnQtMNwcGRF1sXUkZcRsuBm9jzYV7AuPbyfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447194; c=relaxed/simple;
	bh=+F90y8yls9W+2OroXzCpT7EdDHjsL2jMmqwYVQ7bUCw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cgB3F5w9QyI+yXECAsxmCETCFH2PmpkuETAWZFHae+iseL/Xbt/s9uO3UzaJiAjFDHOnj5L2sNsncgFJJ5mnb4IoqwWXld6cRziTPDis3b8J7F2Ahc04YHCaMNQiiSfl+K6acmlmFG1Vzn1KVUu+B6fCM0Tu+2DS7ry50qrV6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuAZVrqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD638C4CED4;
	Tue, 17 Dec 2024 14:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447193;
	bh=+F90y8yls9W+2OroXzCpT7EdDHjsL2jMmqwYVQ7bUCw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OuAZVrqJXJn9gY7aiJM1N53OFgO7gnCfUrxldRA4Xfs/4NDkEq5MwQt2Bir94mQs8
	 jAvqKz+cWBHpsEpDSVtSrw+NVnnVMkA2qTFTYxuHMZmWtT3rLaMGbRY5ufEAoonJr2
	 5bIOW3VoJvK95r1c66aRHG2XsKYZnEZT3plxm8p6NKsEhmmWT2MTXHqkJEa+4kTCBp
	 2Xb/NuUJzObkrpqTbbDW0tV0mcVd7989okmPt9WneX5zyL7pis86Cmx+hPwPpqiHVZ
	 OdH0hJ0DaOILF0TM4NOy/pzN6NDILo82AP4xmJYxcfLdTRFOeaTsu2/SNAPj9rfa5J
	 Lxwpw1yE9cNFw==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] wifi: ath11k: move update channel list to worker
 when wait flag is set
References: <20241213093909.629-1-quic_kangyang@quicinc.com>
	<20241213093909.629-3-quic_kangyang@quicinc.com>
Date: Tue, 17 Dec 2024 16:53:11 +0200
In-Reply-To: <20241213093909.629-3-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Fri, 13 Dec 2024 17:39:09 +0800")
Message-ID: <87bjxamkdk.fsf@kernel.org>
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
> With previous patch "wifi: ath11k: move update channel list from update
> reg worker to reg notifier", ath11k_reg_update_chan_list() will be
> called during reg_process_self_managed_hint().
>
> reg_process_self_managed_hint() will hold rtnl_lock all the time.
> But ath11k_reg_update_chan_list() may increase the occupation time of
> rtnl_lock, because wait flag is set and wait_for_completion_timeout()
> will be called when 11d/hw scan is running.
>
> Should minimize the occupation time of rtnl_lock as much as possible.
>
> Move update channel list operation to a new worker, so that
> wait_for_completion_timeout() won't be called and will not increase the
> occupation time of rtnl_lock.

Maybe the last two paragraphs could be merged (and edited) like this:

We should minimize the occupation time of rtnl_lock as much as possible
to avoid interfering with rest of the system. So move the update channel
list operation to a new worker, so that wait_for_completion_timeout()
won't be called and will not increase the occupation time of rtnl_lock.

> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -685,7 +685,7 @@ struct ath11k {
>  	struct mutex conf_mutex;
>  	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
>  	 * vdev_stop_status info, scan data, ath11k_sta info, ath11k_vif info,
> -	 * channel context data, survey info, test mode data.
> +	 * channel context data, survey info, test mode data, channel_update_queue.
>  	 */
>  	spinlock_t data_lock;

Usually is best to add a comment the data you are protecting, in this
case the new fields in struct ath11k.

> @@ -743,6 +743,8 @@ struct ath11k {
>  	struct completion bss_survey_done;
>  
>  	struct work_struct regd_update_work;
> +	struct work_struct channel_update_work;
> +	struct list_head channel_update_queue;

So here add '/* protected with data_lock */' or similar before channel_update_queue.

> @@ -231,8 +206,16 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
>  		}
>  	}
>  
> -	ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
> -	kfree(params);
> +	if (wait) {
> +		spin_lock_bh(&ar->data_lock);
> +		list_add_tail(&params->list, &ar->channel_update_queue);
> +		spin_unlock_bh(&ar->data_lock);
> +
> +		queue_work(ar->ab->workqueue, &ar->channel_update_work);
> +	} else {
> +		ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
> +		kfree(params);
> +	}

You can avoid the else branch like this:

if (wait) {
	spin_lock_bh(&ar->data_lock);
	list_add_tail(&params->list, &ar->channel_update_queue);
	spin_unlock_bh(&ar->data_lock);

	queue_work(ar->ab->workqueue, &ar->channel_update_work);

        return 0;
}

ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
kfree(params);

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

