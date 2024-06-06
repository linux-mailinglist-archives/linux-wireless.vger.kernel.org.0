Return-Path: <linux-wireless+bounces-8610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9358FE70A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B772838A1
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187119598A;
	Thu,  6 Jun 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmcG1K3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB13195B0C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679048; cv=none; b=L4eCdyt5VUWbmXDLkH7TGlMbCy+dGWyFy0VAeu/oTvqwR5dOwdqE2n1DfiNtIKlvy7i7nNmh2pu+XfJubtF1yCBSHvbgCMVbt6gAOg2WiLxZRxPaUciFoWghkDKWRXTetQ+BmaKpM6HUrTjFroih5J2qOM1iKavPJcgPk8jtMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679048; c=relaxed/simple;
	bh=oLN/PQHH+GwmUKU1YirPBfQYc0rGJjuyGvIzizBGKPc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=T/O+Co/7WC6m5ilflx60g7MdEFfsMNhygFHi/+HHcY33F7tReLP5MrLvb2TgBbqDR0y7S2iERK8HUxoVGL7vtxGWSjZriJTbZZHikLzC9jrvn3xyB8YQhrdXqdxJ8bRaeGOko9OXBcYpdvgbXIQyY6SoU6sK9xVvSypzQMPTa7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmcG1K3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44591C2BD10;
	Thu,  6 Jun 2024 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717679048;
	bh=oLN/PQHH+GwmUKU1YirPBfQYc0rGJjuyGvIzizBGKPc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KmcG1K3RRO6XZL8MpVWMW0ZeNX3aENLbWwq50mtAdkvwzdJF+7pYCcgSQao2iigyL
	 KTF6mNUTSXXhc8njqvlNxsRDvVj35+3RU2npykK/iZvzEeU+FqTc+mp9VYNXethR+G
	 gPSP6geCa0wAiaIeVZN0P5jRsNiIn0KXQ6dSUeHNEa/r0J27OcHGOSvjGvNqs0wWT7
	 4CTTjVy4wKLQpnjE9t+dpc3R1HqbeU6ASDVtOQZWC7KnevS4VK/L2qAMsnMAMy0/zB
	 gVQJMyMzfT9XwL6owGJAZ5DpGdw+w7bdhn+9fTb3M0IEwIFoo7GaunLaB+wsa4N9mk
	 qPzzaSIHsI9Kg==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: Re: [PATCH v8 7/8] wifi: ath12k: refactor core start based on
 hardware group
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
	<20240531180411.1149605-8-quic_hprem@quicinc.com>
Date: Thu, 06 Jun 2024 16:04:05 +0300
In-Reply-To: <20240531180411.1149605-8-quic_hprem@quicinc.com> (Harshitha
	Prem's message of "Fri, 31 May 2024 23:34:10 +0530")
Message-ID: <87plsuql2y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harshitha Prem <quic_hprem@quicinc.com> writes:

> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>
> Currently, mac allocate/register and core_pdev_create are initiated
> immediately when QMI firmware ready event is received for a particular
> device.
>
> With hardware device group abstraction, QMI firmware ready event can be
> received simultaneously for different devices in the group and so, it
> should not be registered immediately rather it has to be deferred until
> all devices in the group has received QMI firmware ready.
>
> To handle this, refactor the code of core start to move the following
> apis inside a wrapper ath12k_core_hw_group_start()
>         * ath12k_mac_allocate()
>         * ath12k_core_pdev_create()
>         * ath12k_core_rfkill_config()
>         * ath12k_mac_register()
>         * ath12k_hif_irq_enable()
>
> similarly, move the corresponding destroy/unregister/disable apis
> inside wrapper ath12k_core_hw_group_stop()
>
> Add the device flags to indicate pdev created and IRQ enabled which would
> be helpful for device clean up during failure cases.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 210 +++++++++++++++++++------
>  drivers/net/wireless/ath/ath12k/core.h |  32 ++++
>  2 files changed, 191 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index ebe31cbb6435..90c70dbfc50a 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -563,6 +563,9 @@ u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab)
>  
>  static void ath12k_core_stop(struct ath12k_base *ab)
>  {
> +	clear_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags);
> +	ath12k_dec_num_core_started(ab);
> +
>  	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
>  		ath12k_qmi_firmware_stop(ab);
>  
> @@ -689,11 +692,15 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
>  		return ret;
>  	}
>  
> +	set_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags);
> +
>  	return 0;
>  }
>  
>  static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
>  {
> +	clear_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags);
> +
>  	ath12k_dp_pdev_free(ab);
>  }
>  
> @@ -702,6 +709,8 @@ static int ath12k_core_start(struct ath12k_base *ab,
>  {
>  	int ret;
>  
> +	lockdep_assert_held(&ab->core_lock);
> +
>  	ret = ath12k_wmi_attach(ab);
>  	if (ret) {
>  		ath12k_err(ab, "failed to attach wmi: %d\n", ret);
> @@ -795,6 +804,12 @@ static int ath12k_core_start(struct ath12k_base *ab,
>  		/* ACPI is optional so continue in case of an error */
>  		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
>  
> +	if (!test_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags)) {
> +		/* Indicate the core start in the appropriate group */
> +		ath12k_inc_num_core_started(ab);
> +		set_bit(ATH12K_FLAG_CORE_STARTED, &ab->dev_flags);
> +	}
> +
>  	return 0;
>  
>  err_reo_cleanup:
> @@ -806,6 +821,108 @@ static int ath12k_core_start(struct ath12k_base *ab,
>  	return ret;
>  }
>  
> +static void ath12k_core_device_cleanup(struct ath12k_base *ab)
> +{
> +	mutex_lock(&ab->core_lock);
> +
> +	if (test_and_clear_bit(ATH12K_FLAG_CORE_HIF_IRQ_ENABLED, &ab->dev_flags))
> +		ath12k_hif_irq_disable(ab);
> +
> +	if (test_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags))
> +		ath12k_core_pdev_destroy(ab);
> +
> +	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
> +		ath12k_mac_unregister(ab);
> +		ath12k_mac_destroy(ab);
> +	}
> +
> +	mutex_unlock(&ab->core_lock);
> +}

This patch is just abusing flags and because of that we have spaghetti
code. I have been disliking use of enum ath12k_dev_flags before but this
is just looks too much. I am wondering do we need to cleanup the ath12k
architecture first, reduce the usage of flags and then revisit this
patchset?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

