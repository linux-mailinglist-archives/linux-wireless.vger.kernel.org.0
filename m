Return-Path: <linux-wireless+bounces-7873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978BF8CA965
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE0928419C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1247E46522;
	Tue, 21 May 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqJAPeK2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAC1DA53
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278042; cv=none; b=X0T4HbomQQQ+qfgSjqRRHW46z91XGrQGPBt0l55O76Canp8N2C6l6lR/8LLlau01I8SjQlg2Dbe/YElNWh9RVHWFs4ss4MJ+HzcK0gsR9dX1OlBwAJo3gmzL/0SgVeqQaCd+bW9SilAT3zlWbUTO1BdkMq11i+5pFsOrHp/g6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278042; c=relaxed/simple;
	bh=d30O1iXiP/3oLi5EUYET0mR7EIn9+D7O3ZNh0bGwZfE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DeLReAFkXr9LpkrelvnD8t0Z+Y3by2u3l6hQUyhY+PAwH7HB/5tJb6VZdLsOymZH4eg7KRGE+qHrvQD/lb+zJiMg0DJW663CMp5L9BDcl6RG0t0DR6X+99/L/1qHVXRsM/lVFzYLuMfPvjo1+kFIx8GdEownRKp/0PNfr0WaeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqJAPeK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DB1C2BD11;
	Tue, 21 May 2024 07:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716278041;
	bh=d30O1iXiP/3oLi5EUYET0mR7EIn9+D7O3ZNh0bGwZfE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OqJAPeK2RX0K1Jlk924blA+4kRTR0WGfI+b08xWL1ESb3NEQnoMsQUmL8yAY0EUPI
	 chgCP8z9z9D9EO6yRCcJ9viWlI2evxidXxfIAmUcIR1pCHXpnckmXesxGOD1nk02N3
	 w3YIq8amga80Asqg335cC9juPKJYK5z1CnVhAAqP/m3cXa6vb2dQ8n0b3zf/aDXXhw
	 6x3L4JksH5d9nN+odVtT4SxNUi/Z2eq981qH0viXDEHTQKo4tenChWDWbsJeAn1mSW
	 aWVuOjIIwCnVTkpy7+TQ7JhUS+mxnip6TgaoYhN7zXgqLS/GS6kQi+WahEwhIWprhK
	 gFL9fOo5VnpkA==
From: Kalle Valo <kvalo@kernel.org>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH v2 2/5] wifi: ath12k: Add htt_stats_dump file ops support
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
	<20240510050806.514126-3-quic_rgnanase@quicinc.com>
Date: Tue, 21 May 2024 10:53:59 +0300
In-Reply-To: <20240510050806.514126-3-quic_rgnanase@quicinc.com> (Ramya
	Gnanasekar's message of "Fri, 10 May 2024 10:38:03 +0530")
Message-ID: <87ttird2i0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>
> Add dump_htt_stats file operation to dump the stats value requested
> for the requested stats_type.
> Stats sent from firmware will be cumulative. Hence add debugfs to reset
> the requested stats type.
>
> Example with one ath12k device:
>
> ath12k
> `-- pci-0000:06:00.0
>     |-- mac0
>         `-- htt_stats
>         |-- htt_stats_type
>         |-- htt_stats_reset
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h        |   2 +
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 202 ++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   |  30 +++
>  3 files changed, 234 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 3919bc828620..77c0842e5ab0 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -477,6 +477,8 @@ struct ath12k_fw_stats {
>  struct ath12k_dbg_htt_stats {
>  	enum ath12k_dbg_htt_ext_stats_type type;
>  	u32 cfg_param[4];
> +	u8 reset;
> +	struct debug_htt_stats_req *stats_req;

Please document with a code comment how these are protected

>  	/* protects shared stats req buffer */
>  	spinlock_t lock;

I'm guessing "stats req buffer" refers to struct
ath12k_dbg_htt_stats::stats_req. But at least in
ath12k_release_htt_stats() you are using conf_mutex for protection:

static int ath12k_release_htt_stats(struct inode *inode,
				    struct file *file)
{
	struct ath12k *ar = inode->i_private;

	mutex_lock(&ar->conf_mutex);
	kfree(file->private_data);
	ar->debug.htt_stats.stats_req = NULL;
	mutex_unlock(&ar->conf_mutex);

	return 0;
}

> +static int ath12k_debugfs_htt_stats_req(struct ath12k *ar)
> +{
> +	struct debug_htt_stats_req *stats_req = ar->debug.htt_stats.stats_req;
> +	enum ath12k_dbg_htt_ext_stats_type type = stats_req->type;
> +	u64 cookie;
> +	int ret, pdev_id = ar->pdev->pdev_id;
> +	struct htt_ext_stats_cfg_params cfg_params = { 0 };
> +
> +	init_completion(&stats_req->htt_stats_rcvd);
> +
> +	stats_req->done = false;
> +	stats_req->pdev_id = pdev_id;

The locking design is not clear for me yet but I suspect this function
needs:

	lockdep_assert_held(&ar->conf_mutex);

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

