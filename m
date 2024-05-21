Return-Path: <linux-wireless+bounces-7869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3292A8CA950
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560951C2090A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E03548EC;
	Tue, 21 May 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjQL6Ekz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F731548E0
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277779; cv=none; b=NVJbV3Ol4Ef2/ocF92OrABlwqNhCa/p17PXGWZlZJLAvN09RC/C7JVIfYvPxlzmINSfcINX+Ur2RM4UgApO/wh3hzvhmCCS36q3+IqF84+HPzuaxK2vhi4ZXiu1D7gzgRqojF76Z1CDZQ9+U/HBqRAzIxlZroedqV+JcnPza8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277779; c=relaxed/simple;
	bh=1pUKTv82FJURgsr0jI314SPDaLC5Gow+Yuxa7TBb6gY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Ek4jgaVdZU/cYMygtbU7EygV7VAUiO7xJQnAKLWr1+03ZA+jZyASlILtQcZcxHDfg85oCqc/8atqQjiRBLRuVSE0K6bWJV4EeADTD6B6iMibQO2mv4GIDFpVnQDy9BeHxBs7zZ0oz5patTbI/2yEeKdtg18MpMT7CAbIaMpN55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjQL6Ekz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052A8C2BD11;
	Tue, 21 May 2024 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716277779;
	bh=1pUKTv82FJURgsr0jI314SPDaLC5Gow+Yuxa7TBb6gY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WjQL6EkzTNzIp6IqPBUKkV7iuiiX5ozhGvm+nFryRRfFqIliH2UmoAk40dK9KLi4c
	 j64vVj/QuaFRyyARbZXnKBifbEcF+xAGEBesPHmTQLupqGu083n8W0z7epYulcU/fj
	 x4Cjkp1Ckm5vgUnBuRPJXZ3lPg6yJif9NbmmLUbS4ClDMm9+lwAjww8IMSQegtLSD4
	 EqiMLyFeN7gmDVuxtMkDIHCRha58MiVxLl0CXgDpAxaJQu5lOTXxHTRHKC/9Tnm0rq
	 cbugK7PhfEkbO2a77xzn5JimRoxd6TBSOoAsWN2rpyphtru3zaW3vl7PTG8JfbOen/
	 oqEaVpMtJr34g==
From: Kalle Valo <kvalo@kernel.org>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH v2 1/5] wifi: ath12k: Add support to enable
 debugfs_htt_stats
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
	<20240510050806.514126-2-quic_rgnanase@quicinc.com>
Date: Tue, 21 May 2024 10:49:36 +0300
In-Reply-To: <20240510050806.514126-2-quic_rgnanase@quicinc.com> (Ramya
	Gnanasekar's message of "Fri, 10 May 2024 10:38:02 +0530")
Message-ID: <87y183d2pb.fsf@kernel.org>
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
> Create debugfs_htt_stats file when ath12k debugfs support is enabled.
> Add basic ath12k_debugfs_htt_stats_init and handle htt_stats_type
> file operations.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

[...]

> +struct ath12k_dbg_htt_stats {
> +	enum ath12k_dbg_htt_ext_stats_type type;
> +	u32 cfg_param[4];
> +	/* protects shared stats req buffer */
> +	spinlock_t lock;
> +};

Is there a specific reason why a new lock is needed? Why not just use
struct ath12k::data_lock?

> +
>  struct ath12k_debug {
>  	struct dentry *debugfs_pdev;
> +	struct ath12k_dbg_htt_stats htt_stats;
>  };
>  
>  struct ath12k_per_peer_tx_stats {
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
> index 8d8ba951093b..30a80f04d824 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
> @@ -6,6 +6,7 @@
>  
>  #include "core.h"
>  #include "debugfs.h"
> +#include "debugfs_htt_stats.h"
>  
>  static ssize_t ath12k_write_simulate_radar(struct file *file,
>  					   const char __user *user_buf,
> @@ -87,4 +88,6 @@ void ath12k_debugfs_register(struct ath12k *ar)
>  				    ar->debug.debugfs_pdev, ar,
>  				    &fops_simulate_radar);
>  	}
> +
> +	ath12k_debugfs_htt_stats_init(ar);

Let's try to have consistent naming: ath12k_debugfs_htt_stats_register()

> +static ssize_t ath12k_read_htt_stats_type(struct file *file,
> +					  char __user *user_buf,
> +					  size_t count, loff_t *ppos)
> +{
> +	struct ath12k *ar = file->private_data;
> +	char buf[32];
> +	size_t len;
> +
> +	len = scnprintf(buf, sizeof(buf), "%u\n", ar->debug.htt_stats.type);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}

Access to ar->debug.htt_stats.type isn't protected in any way.

> +
> +static ssize_t ath12k_write_htt_stats_type(struct file *file,
> +					   const char __user *user_buf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct ath12k *ar = file->private_data;
> +	enum ath12k_dbg_htt_ext_stats_type type;
> +	unsigned int cfg_param[4] = {0};
> +	int num_args;
> +
> +	char *buf __free(kfree) = kzalloc(count, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(buf, user_buf, count))
> +		return -EFAULT;
> +
> +	num_args = sscanf(buf, "%u %u %u %u %u\n", &type, &cfg_param[0],
> +			  &cfg_param[1], &cfg_param[2], &cfg_param[3]);
> +	if (!num_args || num_args > 5)
> +		return -EINVAL;
> +
> +	if (type >= ATH12K_DBG_HTT_NUM_EXT_STATS)
> +		return -E2BIG;
> +
> +	if (type == ATH12K_DBG_HTT_EXT_STATS_RESET)
> +		return -EPERM;
> +
> +	ar->debug.htt_stats.type = type;
> +	ar->debug.htt_stats.cfg_param[0] = cfg_param[0];
> +	ar->debug.htt_stats.cfg_param[1] = cfg_param[1];
> +	ar->debug.htt_stats.cfg_param[2] = cfg_param[2];
> +	ar->debug.htt_stats.cfg_param[3] = cfg_param[3];
> +
> +	return count;
> +}

Same here with both type and cfg_param. Maybe it's ok to skip
protection, I didn't do analysis yet, but this makes me suspicious.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

