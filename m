Return-Path: <linux-wireless+bounces-23918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0EDAD2FB0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 10:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07BB7A3DEB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5321ABD5;
	Tue, 10 Jun 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVv8fw4O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850D1DD9D3
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543407; cv=none; b=Mk7YGQeqJ1AmWv6u3R5Kd3oZwxQO72HVSVL7RUS2pkeVFrxi4BN/Q3kTANqs4L4JqqGmvJYmSwcg3YXV/QZFKEl5nLwjsQHlBjl8Sm/0TIxVL25+py2mTFvQw3qYwiT088oj/7VGZmBt/qT8jBHUs3wo1k2YhQZ721FCo7pKZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543407; c=relaxed/simple;
	bh=yLuTk1D3F+8fvhU0ILsHffISVNBXEXKhzaEuKpWC7nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtXe5TPZhn0fA9gHKOE0hlQqScdiBJG/ro+6eriCdUvL9s8teUpM8+CmjqVI4sYbQH0TBmcEqW0Nqag3X7YQRAFTmImD4vqJlDw8EA266exDNAniBQ0uqNiOyDdMKBL7xJNY0WfaBkJ8ywMt8ksyB0w/wNizDI9DWGYdvoZ0Dd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVv8fw4O; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo6024795a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 01:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749543404; x=1750148204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cv44LS1sjh21HGfbYeFYKcPOsKyzLkV/r1e8mW8y0Os=;
        b=oVv8fw4OcZH2hHsDspDDPb0Pt2Rqq4tVPHRGeOy9j3BMALzSuy7qg1G/IBpQjpNQK6
         wAE4EYdGibRdm75V1PfcNhWsAdNXG9eZ7QOzPZGvjRBqur5tqd49iH0Va6i1RTKbt2Ii
         lBZXbO3DJnWl5lk7VLOfB5LBLZogrEENFJsa5UlrvWr6IsksAn27WBH5s30dlwMJPDlE
         5u0tx4JYplbDWDbticV+ybUSCZARd5LSzaWM2Mt7qipO7S5qow0D9aq9Oj4T0v6pVJj0
         aw9lKxxXJ7shkO+tC8sF+B7nYe/3hp/GbDMNeOhAO8cOwmV0PArarPzWnoJHgDEwEFRF
         Fsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749543404; x=1750148204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv44LS1sjh21HGfbYeFYKcPOsKyzLkV/r1e8mW8y0Os=;
        b=MAUVggZk/UhKSONPY9q1tfYNHVhTJRlt2Gy52m4SdNFLZU2UMPk4TnImpOaVcujm7q
         T8ryAYmH5tKStO8+lWNldnQyHe12UMQA/PnMte/LmGT75/HgEzUUOxLIK4W0f4qQOCtS
         fWeVjWklajRzmWgAKPl73cdb+GcO+JNrvXzgexOOXRHA2boXDx8SzGGUUrCW5sZ56mJK
         CZMVbsXO4iOGV4wHGNOQIB6aqA1bUKrxF7G/eL0jyQe2OotJfcpuBQ79ANzYaLYfjp87
         +jeAnvWuxKrGk6Pe6Er7VUuDMp4fVPiBExQDLI4xJXpzHH9HlJLfXOw+9gPG7joAUoOM
         11tA==
X-Forwarded-Encrypted: i=1; AJvYcCXtapYYg7PXBvUXuoUGGxHlGOihetoIF+HHfQt9k8bNslzEgtfpzR2yRUTrzlP4eNoEmnGshj0b/KMeGo3hHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0CL0kvkuGcuY0KSwM3LV6OMA769ZNl9nrf6EtOBaNENon46pf
	E5WShNWpM4cH1GWPGS5NjUAP2dmKElJi1N0KPfyHiTPPcSUJY4FwzbQ7xHzXz46L5kg=
X-Gm-Gg: ASbGncvG0RwiEVcIzEzW7NEoAL/UASRqJA2MwzeaEJjKT3qwabNP8m335gGy0Z3MC3Y
	yfOzm5roMtxgrCfcJHBi/AZXTAyPKWTOW/lCuO7AdPcqULLTf7ZaJYz42lLyaXec2IZ7gDQ+1we
	WfRCQAaePigbMsF4mGvoivQB35akiM0XGlANziLqevsCK8qr1Y7zFfSmmrsNrk9mppTKRBdQVvY
	YfDOn+vqt9ej5rJ5mnqOgYEUa4g3V9F24YrJbzpCMYwaPqBQmsKPXKVcVEc4xtEblaW2iyfoN9N
	lP12VL+Le+Q0Nq9TW9y+bYme9IO+yOumH2XWqSYtTWc72nHh1rXutNA02a6E2bvnFQrtrA==
X-Google-Smtp-Source: AGHT+IHpCrdRekIe0QYCDgcZtAAoXKuOovlRwWiNArYZwW7mCqUJLOpQ8BUhEtpViMRKEjRU6TLGIA==
X-Received: by 2002:a17:907:1ca2:b0:add:fc26:c1c4 with SMTP id a640c23a62f3a-ade1a9ed855mr1546064966b.59.1749543403926;
        Tue, 10 Jun 2025 01:16:43 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db576basm689286766b.65.2025.06.10.01.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 01:16:41 -0700 (PDT)
Date: Tue, 10 Jun 2025 11:16:40 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: bjorn.andersson@oss.qualcomm.com
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Mahendran P <quic_mahep@quicinc.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: Avoid CPU busy-wait by handling VDEV_STAT
 and BCN_STAT
Message-ID: <aEfp6B97gwAeeOs3@linaro.org>
References: <20250609-ath12k-fw-stats-done-v1-1-2b3624656697@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-ath12k-fw-stats-done-v1-1-2b3624656697@oss.qualcomm.com>

On 25-06-09 22:06:22, Bjorn Andersson via B4 Relay wrote:
> From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 
> When the ath12k driver is built without CONFIG_ATH12K_DEBUG, the
> recently refactored stats code can cause any user space application
> (such at NetworkManager) to consume 100% CPU for 3 seconds, every time
> stats are read.
> 
> Commit 'b8a0d83fe4c7 ("wifi: ath12k: move firmware stats out of
> debugfs")' moved ath12k_debugfs_fw_stats_request() out of debugfs, by
> merging the additional logic into ath12k_mac_get_fw_stats().
> 
> Among the added responsibility of ath12k_mac_get_fw_stats() was the
> busy-wait for `fw_stats_done`.
> 
> Signalling of `fw_stats_done` happens when one of the
> WMI_REQUEST_PDEV_STAT, WMI_REQUEST_VDEV_STAT, and WMI_REQUEST_BCN_STAT
> messages are received, but the handling of the latter two commands remained
> in the debugfs code. As `fw_stats_done` isn't signalled, the calling
> processes will spin until the timeout (3 seconds) is reached.
> 
> Moving the handling of these two additional responses out of debugfs
> resolves the issue.
> 
> Fixes: b8a0d83fe4c7 ("wifi: ath12k: move firmware stats out of debugfs")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Tested on Dell XPS 13 9345.

Tested-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/net/wireless/ath/ath12k/debugfs.c | 58 --------------------------
>  drivers/net/wireless/ath/ath12k/debugfs.h |  7 ----
>  drivers/net/wireless/ath/ath12k/wmi.c     | 67 +++++++++++++++++++++++++++----
>  3 files changed, 60 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
> index dd624d73b8b2714e77c9d89b5a52f7b3fcb02951..23da93afaa5c25e806c9859dbbdd796afd23d78a 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
> @@ -1251,64 +1251,6 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
>  	 */
>  }
>  
> -void
> -ath12k_debugfs_fw_stats_process(struct ath12k *ar,
> -				struct ath12k_fw_stats *stats)
> -{
> -	struct ath12k_base *ab = ar->ab;
> -	struct ath12k_pdev *pdev;
> -	bool is_end;
> -	static unsigned int num_vdev, num_bcn;
> -	size_t total_vdevs_started = 0;
> -	int i;
> -
> -	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
> -		if (list_empty(&stats->vdevs)) {
> -			ath12k_warn(ab, "empty vdev stats");
> -			return;
> -		}
> -		/* FW sends all the active VDEV stats irrespective of PDEV,
> -		 * hence limit until the count of all VDEVs started
> -		 */
> -		rcu_read_lock();
> -		for (i = 0; i < ab->num_radios; i++) {
> -			pdev = rcu_dereference(ab->pdevs_active[i]);
> -			if (pdev && pdev->ar)
> -				total_vdevs_started += pdev->ar->num_started_vdevs;
> -		}
> -		rcu_read_unlock();
> -
> -		is_end = ((++num_vdev) == total_vdevs_started);
> -
> -		list_splice_tail_init(&stats->vdevs,
> -				      &ar->fw_stats.vdevs);
> -
> -		if (is_end) {
> -			ar->fw_stats.fw_stats_done = true;
> -			num_vdev = 0;
> -		}
> -		return;
> -	}
> -	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
> -		if (list_empty(&stats->bcn)) {
> -			ath12k_warn(ab, "empty beacon stats");
> -			return;
> -		}
> -		/* Mark end until we reached the count of all started VDEVs
> -		 * within the PDEV
> -		 */
> -		is_end = ((++num_bcn) == ar->num_started_vdevs);
> -
> -		list_splice_tail_init(&stats->bcn,
> -				      &ar->fw_stats.bcn);
> -
> -		if (is_end) {
> -			ar->fw_stats.fw_stats_done = true;
> -			num_bcn = 0;
> -		}
> -	}
> -}
> -
>  static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
>  {
>  	struct ath12k *ar = inode->i_private;
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
> index ebef7dace3448e4bdf2d6cb155d089267315172c..21641a8a03460c6cc1b34929a353e5605bb834ce 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs.h
> +++ b/drivers/net/wireless/ath/ath12k/debugfs.h
> @@ -12,8 +12,6 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab);
>  void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
>  void ath12k_debugfs_register(struct ath12k *ar);
>  void ath12k_debugfs_unregister(struct ath12k *ar);
> -void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
> -				     struct ath12k_fw_stats *stats);
>  void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
>  			       struct ieee80211_vif *vif);
>  void ath12k_debugfs_pdev_create(struct ath12k_base *ab);
> @@ -126,11 +124,6 @@ static inline void ath12k_debugfs_unregister(struct ath12k *ar)
>  {
>  }
>  
> -static inline void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
> -						   struct ath12k_fw_stats *stats)
> -{
> -}
> -
>  static inline bool ath12k_debugfs_is_extd_rx_stats_enabled(struct ath12k *ar)
>  {
>  	return false;
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 60e2444fe08cefa39ae218d07eb9736d2a0c982b..2d2444417e2b2d9281754d113f2b073034e27739 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -7626,6 +7626,63 @@ static int ath12k_wmi_pull_fw_stats(struct ath12k_base *ab, struct sk_buff *skb,
>  				   &parse);
>  }
>  
> +static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
> +					struct ath12k_fw_stats *stats)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_pdev *pdev;
> +	bool is_end;
> +	static unsigned int num_vdev, num_bcn;
> +	size_t total_vdevs_started = 0;
> +	int i;
> +
> +	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
> +		if (list_empty(&stats->vdevs)) {
> +			ath12k_warn(ab, "empty vdev stats");
> +			return;
> +		}
> +		/* FW sends all the active VDEV stats irrespective of PDEV,
> +		 * hence limit until the count of all VDEVs started
> +		 */
> +		rcu_read_lock();
> +		for (i = 0; i < ab->num_radios; i++) {
> +			pdev = rcu_dereference(ab->pdevs_active[i]);
> +			if (pdev && pdev->ar)
> +				total_vdevs_started += pdev->ar->num_started_vdevs;
> +		}
> +		rcu_read_unlock();
> +
> +		is_end = ((++num_vdev) == total_vdevs_started);
> +
> +		list_splice_tail_init(&stats->vdevs,
> +				      &ar->fw_stats.vdevs);
> +
> +		if (is_end) {
> +			ar->fw_stats.fw_stats_done = true;
> +			num_vdev = 0;
> +		}
> +		return;
> +	}
> +	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
> +		if (list_empty(&stats->bcn)) {
> +			ath12k_warn(ab, "empty beacon stats");
> +			return;
> +		}
> +		/* Mark end until we reached the count of all started VDEVs
> +		 * within the PDEV
> +		 */
> +		is_end = ((++num_bcn) == ar->num_started_vdevs);
> +
> +		list_splice_tail_init(&stats->bcn,
> +				      &ar->fw_stats.bcn);
> +
> +		if (is_end) {
> +			ar->fw_stats.fw_stats_done = true;
> +			num_bcn = 0;
> +		}
> +	}
> +}
> +
>  static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
>  {
>  	struct ath12k_fw_stats stats = {};
> @@ -7655,19 +7712,15 @@ static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *sk
>  
>  	spin_lock_bh(&ar->data_lock);
>  
> -	/* WMI_REQUEST_PDEV_STAT can be requested via .get_txpower mac ops or via
> -	 * debugfs fw stats. Therefore, processing it separately.
> -	 */
> +	/* Handle WMI_REQUEST_PDEV_STAT status update */
>  	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
>  		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
>  		ar->fw_stats.fw_stats_done = true;
>  		goto complete;
>  	}
>  
> -	/* WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT are currently requested only
> -	 * via debugfs fw stats. Hence, processing these in debugfs context.
> -	 */
> -	ath12k_debugfs_fw_stats_process(ar, &stats);
> +	/* Handle WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT updates. */
> +	ath12k_wmi_fw_stats_process(ar, &stats);
>  
>  complete:
>  	complete(&ar->fw_stats_complete);
> 
> ---
> base-commit: 4f27f06ec12190c7c62c722e99ab6243dea81a94
> change-id: 20250609-ath12k-fw-stats-done-dca8bf77a7da
> 
> Best regards,
> -- 
> Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 
> 
> 

