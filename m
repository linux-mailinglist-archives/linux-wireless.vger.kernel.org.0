Return-Path: <linux-wireless+bounces-11513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C8A95414F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 07:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA361C21238
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 05:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B2C2837B;
	Fri, 16 Aug 2024 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9duNJnV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE13C24
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787275; cv=none; b=XV1i4wv4CgAvNTX9J/yREc2AQz0QUJhGcU8TFIg7FlWZI8Rmn+iVAfDZLKthwUHEoLAX+RhD2vxXon9NyCbmjWTKPaa1NnHEXnVsVq24fOlQl+5O5fTwVp2kTSRRAp71PizCqSGpvSlWvXPOsVqIrXKHjODUSK3/FCxJ21NE+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787275; c=relaxed/simple;
	bh=92a7aBdQFq48BVB/sYWG26/IpMudoG1+WVLK0hzRr10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nktwICVlinfvwFfOx54BNBH1kRhHRG+X1QWCxwlz90byzuz5DPGXx6X+9PlL5p4U3bUd8hhamRjy5nZqOMdCgRyKHZwe5e974yY0GTCqJdSGfUdh9p+eqK3NQdHWGb1XGz+3u2A+Yq4gUSlk20yrivVzO21PKh3veTTQUyO2/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9duNJnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9649C32782;
	Fri, 16 Aug 2024 05:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787275;
	bh=92a7aBdQFq48BVB/sYWG26/IpMudoG1+WVLK0hzRr10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t9duNJnVJ7P+DH+b6l+JT8NGnj1S2iEeUGZjJkMf6el9Sme+1InBdtqaR1Bra4LOm
	 CyYpDdl1cu5Sj962h5bHs3rxy4aJThbevEkrEBKbq8pB6lF2q5OlGZdnmCD49uzsXj
	 6Iut8iDT7+PiMm4rxmIIFBGxL0zDZGKgOqG0Qw92nZupfn/b14ZgwacVZ0AVbpdWvy
	 AL0Cp1uT57GLZ5Aaw+03mgRZHiSfXRvyKo2P6jXNUAyVJ/KhIGHDlI364li7xGafz9
	 pX2AfWObB0RYIwF7RvKJwK9o1THCM+auvpvwfUFk25gIns5gkUjlXR5rQGxFZMnTul
	 1aTzHb449esDg==
Message-ID: <68e114c3-0f0b-42a0-9397-69f8bc6d8f5b@kernel.org>
Date: Fri, 16 Aug 2024 07:47:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/18] wifi: ath12k: add AHB driver support for
 IPQ5332
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Balamurugan S
 <quic_bselvara@quicinc.com>, P Praneesh <quic_ppranees@quicinc.com>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
 <20240814094323.3927603-18-quic_rajkbhag@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240814094323.3927603-18-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 11:43, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Add Initial Ath12k AHB driver support for IPQ5332. IPQ5332 is AHB
> based IEEE802.11be 2 GHz 2x2 WiFi device.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---

...


> +
> +	of_id = of_match_device(ath12k_ahb_of_match, &pdev->dev);
> +	if (!of_id) {
> +		dev_err(&pdev->dev, "Failed to find matching device tree id\n");
> +		return -EINVAL;
> +	}
> +
> +	hw_rev = (enum ath12k_hw_rev)of_id->data;

Just use wrapper to get match data.
> +
> +	switch (hw_rev) {
> +	case ATH12K_HW_IPQ5332_HW10:
> +		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Unsupported device type %d\n", hw_rev);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set 32-bit consistent dma\n");
> +		return ret;
> +	}
> +
> +	ab = ath12k_core_alloc(&pdev->dev, sizeof(struct ath12k_ahb),
> +			       ATH12K_BUS_AHB);
> +	if (!ab) {
> +		dev_err(&pdev->dev, "failed to allocate ath12k base\n");
> +		return -ENOMEM;
> +	}
> +
> +	ab->hif.ops = hif_ops;
> +	ab->pdev = pdev;
> +	ab->hw_rev = hw_rev;
> +	platform_set_drvdata(pdev, ab);
> +
> +	/* Set fixed_mem_region to true for platforms that support fixed memory
> +	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
> +	 * need not to allocate memory.
> +	 */
> +	if (!of_property_read_u32(ab->dev->of_node, "memory-region", &addr)) {
> +		set_bit(ATH12K_FLAG_FIXED_MEM_REGION, &ab->dev_flags);
> +		mem_node = of_find_node_by_name(NULL, "mlo_global_mem_0");
> +		if (!mem_node)
> +			ab->mlo_capable_flags = 0;
> +	}
> +
> +	ret = ath12k_core_pre_init(ab);
> +	if (ret)
> +		goto err_core_free;
> +
> +	ret = ath12k_ahb_resource_init(ab);
> +	if (ret)
> +		goto err_core_free;
> +
> +	ret = ath12k_hal_srng_init(ab);
> +	if (ret)
> +		goto err_resource_deinit;
> +
> +	ret = ath12k_ce_alloc_pipes(ab);
> +	if (ret) {
> +		ath12k_err(ab, "failed to allocate ce pipes: %d\n", ret);
> +		goto err_hal_srng_deinit;
> +	}
> +
> +	ath12k_ahb_init_qmi_ce_config(ab);
> +
> +	ret = ath12k_core_get_rproc(ab);
> +	if (ret) {
> +		ath12k_err(ab, "failed to get rproc: %d\n", ret);
> +		goto err_ce_free;
> +	}
> +
> +	ret = ath12k_ahb_config_irq(ab);
> +	if (ret) {
> +		ath12k_err(ab, "failed to configure irq: %d\n", ret);
> +		goto err_ce_free;
> +	}
> +
> +	ret = ath12k_core_init(ab);
> +	if (ret) {
> +		ath12k_err(ab, "failed to init core: %d\n", ret);
> +		goto err_ce_free;
> +	}
> +
> +	return 0;
> +
> +err_ce_free:
> +	ath12k_ce_free_pipes(ab);
> +
> +err_hal_srng_deinit:
> +	ath12k_hal_srng_deinit(ab);
> +
> +err_resource_deinit:
> +	ath12k_ahb_resource_deinit(ab);
> +
> +err_core_free:
> +	ath12k_core_free(ab);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return ret;
> +}
> +
> +static void ath12k_ahb_remove_prepare(struct ath12k_base *ab)
> +{
> +	unsigned long left;
> +
> +	if (test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags)) {
> +		left = wait_for_completion_timeout(&ab->driver_recovery,
> +						   ATH12K_AHB_RECOVERY_TIMEOUT);
> +		if (!left)
> +			ath12k_warn(ab, "failed to receive recovery response completion\n");
> +	}
> +
> +	set_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags);
> +	cancel_work_sync(&ab->restart_work);
> +	cancel_work_sync(&ab->qmi.event_work);
> +}
> +
> +static void ath12k_ahb_free_resources(struct ath12k_base *ab)
> +{
> +	struct platform_device *pdev = ab->pdev;
> +
> +	ath12k_ahb_free_irq(ab);
> +	ath12k_hal_srng_deinit(ab);
> +	ath12k_ce_free_pipes(ab);
> +	ath12k_ahb_resource_deinit(ab);
> +	ath12k_core_free(ab);
> +	platform_set_drvdata(pdev, NULL);
> +}
> +
> +static void ath12k_ahb_remove(struct platform_device *pdev)
> +{
> +	struct ath12k_base *ab = platform_get_drvdata(pdev);
> +
> +	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
> +		ath12k_ahb_power_down(ab, false);
> +		ath12k_qmi_deinit_service(ab);
> +		goto qmi_fail;
> +	}
> +
> +	ath12k_ahb_remove_prepare(ab);
> +	ath12k_core_deinit(ab);
> +
> +qmi_fail:
> +	ath12k_ahb_free_resources(ab);
> +}
> +
> +static void ath12k_ahb_shutdown(struct platform_device *pdev)
> +{
> +	struct ath12k_base *ab = platform_get_drvdata(pdev);
> +
> +	/* platform shutdown() & remove() are mutually exclusive.
> +	 * remove() is invoked during rmmod & shutdown() during
> +	 * system reboot/shutdown.
> +	 */
> +	ath12k_ahb_remove_prepare(ab);
> +
> +	if (!(test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)))
> +		goto free_resources;
> +
> +	ath12k_core_deinit(ab);
> +
> +free_resources:
> +	ath12k_ahb_free_resources(ab);

Why? It's shutdown, we do not care about cleanup. Why do you need this
shutdown callback in the first place?


Best regards,
Krzysztof


