Return-Path: <linux-wireless+bounces-18206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EB0A22959
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 08:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 916D77A05B0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F11953A1;
	Thu, 30 Jan 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS/T+YyM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B87483;
	Thu, 30 Jan 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738223848; cv=none; b=rhXrwQa3yUAf+gUBcSICHfkhcPJk7Nu54ucqYAoh6/wh5R+BK2RQzzh+p68NhNoKQ7EobDUgW25FepQk8PKSqGq4awQdMo4qlMLycSUVaHR8dmY8eMYERX/uL9pNlP6H19HFEIGklW1q0euuL1UhcVW55BOzWUfM3dIuSilEV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738223848; c=relaxed/simple;
	bh=BYlQq/pkwdQhlwIVZLdyRUVsHeIdBy2FiTDekNBGSFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIhulrwi6ZPMxlh1ZzNP9xIqRPc5W/PuhoPT/jHS75C3bufiok99n6Let1CLstYjJFiRHk+dpzmq3OMcRLBRC80nAB4dxsGFRfheZ0qIT3YFfrA/wj/bpEzlILk2qUsG6txw+yypTpsvxphPRGppYK6qDG8581YE3AJGyXRJDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS/T+YyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB3FC4CED2;
	Thu, 30 Jan 2025 07:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738223847;
	bh=BYlQq/pkwdQhlwIVZLdyRUVsHeIdBy2FiTDekNBGSFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mS/T+YyMkee7coIp+FFdMOANerJ9qn368Vg7D/Iqby5kMhU4Kc5Mn2lQ6eQe6Ga8h
	 DpvZAIcqVwS3cKamfPTB84JglBTd1D6xCErWIX8Ycmc/dgncXASb/igCkYPIXPCEAL
	 y1rbFMa2pdMqc5z+Op+Fv5kJ9sxXpwjXSCApmQdp3zBAuDBDO7nP0bVEnSUp/r8Nro
	 He3zXZwdoUNlj9hSV2A3Yqe2bsnlIYyqsFOhC/L78gQFXbOGDqUss7MjINHIiKn5i2
	 mZ60/ZkRJ38sC/wahtQFYZ5Xqnj69mObcZkTBOfaRG+43r3s8QGAsjzeS9qQ3RdmbX
	 LvqiVvzDXIQuA==
Message-ID: <0f3efa0c-b5e0-44e4-850a-d63b0beeb0b8@kernel.org>
Date: Thu, 30 Jan 2025 08:57:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/13] wifi: ath12k: add AHB driver support for IPQ5332
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Balamurugan S <quic_bselvara@quicinc.com>,
 P Praneesh <quic_ppranees@quicinc.com>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-9-quic_rajkbhag@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250130043508.1885026-9-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2025 05:35, Raj Kumar Bhagat wrote:
> +static int ath12k_ahb_clock_init(struct ath12k_base *ab)
> +{
> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
> +	int ret;
> +
> +	ab_ahb->xo_clk = devm_clk_get(ab->dev, "xo");
> +	if (IS_ERR_OR_NULL(ab_ahb->xo_clk)) {

No, you are not supposed to use IS_ERR_OR_NULL(). That's indication of bug.

> +		ret = ab_ahb->xo_clk ? PTR_ERR(ab_ahb->xo_clk) : -ENODEV;

I don't understand this. It's the third time you are reimplementing
standard code in some odd way, different than all other drivers.

Read the description of this function. Can clk_get return NULL? Of
course not. This is so overcomplicated for no reason, I wonder if it is
actually buggy here.


> +		return dev_err_probe(&ab->pdev->dev, ret, "failed to get xo clock\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void ath12k_ahb_clock_deinit(struct ath12k_base *ab)
> +{
> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
> +
> +	devm_clk_put(ab->dev, ab_ahb->xo_clk);
> +	ab_ahb->xo_clk = NULL;
> +}
> +
> +static int ath12k_ahb_clock_enable(struct ath12k_base *ab)
> +{
> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(ab_ahb->xo_clk)) {
> +		ath12k_err(ab, "clock is not initialized\n");

NAK.

Sorry, this code makes no sense. This is some random code. This code
cannot be executed before probe. If it can: your driver is buggy, so fix
your driver.

After the probe(), this is never NULL as an error. Either you have here
valid pointer or you failed the probe.

This driver fails on basics of driver probing.

> +		return -EIO;
> +	}
> +
> +	ret = clk_prepare_enable(ab_ahb->xo_clk);
> +	if (ret) {
> +		ath12k_err(ab, "failed to enable gcc_xo_clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ath12k_ahb_clock_disable(struct ath12k_base *ab)
> +{
> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
> +
> +	clk_disable_unprepare(ab_ahb->xo_clk);

Don't create such wrappers for single clock. Does not help.

> +}
> +
> +static int ath12k_ahb_resource_init(struct ath12k_base *ab)
> +{
> +	struct platform_device *pdev = ab->pdev;
> +	struct resource *mem_res;
> +	int ret;
> +
> +	ab->mem = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
> +	if (IS_ERR(ab->mem)) {
> +		ret = dev_err_probe(&pdev->dev, PTR_ERR(ab->mem), "ioremap error\n");
> +		goto out;
> +	}
> +
> +	ab->mem_len = resource_size(mem_res);
> +
> +	if (ab->hw_params->ce_remap) {
> +		const struct ce_remap *ce_remap = ab->hw_params->ce_remap;
> +		/* CE register space is moved out of WCSS and the space is not
> +		 * contiguous, hence remapping the CE registers to a new space
> +		 * for accessing them.
> +		 */
> +		ab->mem_ce = ioremap(ce_remap->base, ce_remap->size);
> +		if (IS_ERR(ab->mem_ce)) {
> +			dev_err(&pdev->dev, "ce ioremap error\n");
> +			ret = -ENOMEM;
> +			goto err_mem_unmap;
> +		}
> +		ab->ce_remap = true;
> +		ab->ce_remap_base_addr = HAL_IPQ5332_CE_WFSS_REG_BASE;
> +	}
> +
> +	ret = ath12k_ahb_clock_init(ab);
> +	if (ret)
> +		goto err_mem_ce_unmap;
> +
> +	ret =  ath12k_ahb_clock_enable(ab);
> +	if (ret)
> +		goto err_clock_deinit;
> +
> +	return 0;
> +
> +err_clock_deinit:
> +	ath12k_ahb_clock_deinit(ab);
> +
> +err_mem_ce_unmap:
> +	if (ab->hw_params->ce_remap)
> +		iounmap(ab->mem_ce);
> +
> +err_mem_unmap:
> +	ab->mem_ce = NULL;
> +	devm_iounmap(ab->dev, ab->mem);
> +
> +out:
> +	ab->mem = NULL;
> +	return ret;
> +}
> +
> +static void ath12k_ahb_resource_deinit(struct ath12k_base *ab)
> +{
> +	if (ab->mem)
> +		devm_iounmap(ab->dev, ab->mem);
> +
> +	if (ab->mem_ce)
> +		iounmap(ab->mem_ce);
> +
> +	ab->mem = NULL;
> +	ab->mem_ce = NULL;
> +
> +	ath12k_ahb_clock_disable(ab);
> +	ath12k_ahb_clock_deinit(ab);
> +}
> +
> +static enum ath12k_hw_rev ath12k_ahb_get_hw_rev(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id;
> +
> +	of_id = of_match_device(ath12k_ahb_of_match, &pdev->dev);
> +	if (!of_id) {
> +		dev_err(&pdev->dev, "Failed to find matching device tree id\n");
> +		return -EINVAL;
> +	}
> +
> +	return (enum ath12k_hw_rev)of_id->data;

You just open-coded of_device_get_match_data().

> +}
> +
> +static int ath12k_ahb_probe(struct platform_device *pdev)
> +{
> +	struct ath12k_base *ab;
> +	const struct ath12k_hif_ops *hif_ops;
> +	struct device_node *mem_node;
> +	enum ath12k_hw_rev hw_rev;
> +	u32 addr;
> +	int ret;
> +
> +	hw_rev = ath12k_ahb_get_hw_rev(pdev);
> +	switch (hw_rev) {
> +	case ATH12K_HW_IPQ5332_HW10:
> +		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set 32-bit coherent dma\n");
> +		return ret;
> +	}
> +
> +	ab = ath12k_core_alloc(&pdev->dev, sizeof(struct ath12k_ahb),
> +			       ATH12K_BUS_AHB);
> +	if (!ab) {
> +		dev_err(&pdev->dev, "failed to allocate ath12k base\n");

No, driver never prints allocation errors. You are duplicating existing
core printk.


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
> +
> +		/* If the platform supports fixed memory, then it should define/
> +		 * reserve MLO global memory in DT to support Multi Link Operation
> +		 * (IEEE 802.11be).
> +		 * If MLO global memory is not reserved in fixed memory mode, then
> +		 * MLO cannot be supported.
> +		 */
> +		mem_node = ath12k_core_get_reserved_mem_by_name(ab, "mlo-global-mem");
> +		if (!mem_node)
> +			ab->single_chip_mlo_supp = false;
> +		else
> +			of_node_put(mem_node);
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

You should rather explain why you cannot use one callback for both. Why
this has to be duplicated?

> +	ath12k_ahb_remove_prepare(ab);
> +
> +	if (!(test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)))
> +		goto free_resources;
> +
> +	ath12k_core_deinit(ab);

And why this is actually different order than remove().

You
Best regards,
Krzysztof

