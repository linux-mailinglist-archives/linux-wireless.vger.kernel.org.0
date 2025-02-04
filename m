Return-Path: <linux-wireless+bounces-18423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60522A27654
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 16:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9270163DD1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D62144A6;
	Tue,  4 Feb 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D4IRfwTl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4520C46D;
	Tue,  4 Feb 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683954; cv=none; b=WGwcIFNZpbuckt9NATN718rPiJ7Iv3N+2/fCod9s1jMNEsGm7b38frca/mwfTEJfGWs1EyswKg9Dw5ev+ABtxSdyrMLFIrEb1otiOyT0G8SqtQfA+UmWwe3UfH7YsrffzDr6bTiMpv7gBreasxVaHnYHYmF1vs573y3pqsZxulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683954; c=relaxed/simple;
	bh=C07sUUck6kA/CVKnuzDizMhHTlBqmB/a72rcHwwatnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kMZulOv455d8+No3pC0Be3VJ2SnUMQEcyIuH8ueYbSVgV44mQT+5CQM4bFtJO6jaIW2ZEOX+D9FKQPCFIdaIzjbIw3TF1Epvjdq0m+32GgqARUJg3I2Unl+k8ioGDhbJtGBZQTKjHc2niL+IEdIoYuOOU39BHt6OID45A8jiaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D4IRfwTl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514E1bbS032324;
	Tue, 4 Feb 2025 15:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SmzpwdylyuXyz1bRPWE37WvAaaUec0zu4cZfeZzC9No=; b=D4IRfwTlCpceS1ir
	/ODZ50ZkWM3TlEvxhhfguPE6L8mpoBNvNuF7udR0gB7k2Wz4OWjyPuOxuh4+KAt/
	2vGTclvQiuqE3FjbKGkLNoZMvQHhOlHIU1Cyh/ubQYpjDJs2pe9M3osT9pwRZbpD
	RX+qvSiWPMSiL438iw8VNnEd0xW3iL718R0Eqmy5E234svJk2sXNDTnuM+jQgzY1
	kGH0rRtIudMKTBK0WCgr5d6TkebUgj7Uzo93q1sAMsJG+H80sgY6yGkQ8foBVHm1
	7WJIEzmNtn2y7AcuwX8wGAu7vm/3L+DuflAzQldp44Tw5v4v31jv2DCytXJzKons
	gDWKzw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44km9wg8p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 15:45:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 514Fjlim026799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 15:45:47 GMT
Received: from [10.216.42.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Feb 2025
 07:45:43 -0800
Message-ID: <fe48c265-11e7-42ed-98e5-e55f89ca4021@quicinc.com>
Date: Tue, 4 Feb 2025 21:15:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/13] wifi: ath12k: add AHB driver support for IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-9-quic_rajkbhag@quicinc.com>
 <0f3efa0c-b5e0-44e4-850a-d63b0beeb0b8@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <0f3efa0c-b5e0-44e4-850a-d63b0beeb0b8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ns-NDlIQ4sr6ec7ZOrAiM70Z0xGM_EPY
X-Proofpoint-GUID: Ns-NDlIQ4sr6ec7ZOrAiM70Z0xGM_EPY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040122

On 1/30/2025 1:27 PM, Krzysztof Kozlowski wrote:
> On 30/01/2025 05:35, Raj Kumar Bhagat wrote:
>> +static int ath12k_ahb_clock_init(struct ath12k_base *ab)
>> +{
>> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
>> +	int ret;
>> +
>> +	ab_ahb->xo_clk = devm_clk_get(ab->dev, "xo");
>> +	if (IS_ERR_OR_NULL(ab_ahb->xo_clk)) {
> 
> No, you are not supposed to use IS_ERR_OR_NULL(). That's indication of bug.
> 
>> +		ret = ab_ahb->xo_clk ? PTR_ERR(ab_ahb->xo_clk) : -ENODEV;
> 
> I don't understand this. It's the third time you are reimplementing
> standard code in some odd way, different than all other drivers.
> 
> Read the description of this function. Can clk_get return NULL? Of
> course not. This is so overcomplicated for no reason, I wonder if it is
> actually buggy here.
> 

My bad, will update in next version.

> 
>> +		return dev_err_probe(&ab->pdev->dev, ret, "failed to get xo clock\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void ath12k_ahb_clock_deinit(struct ath12k_base *ab)
>> +{
>> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
>> +
>> +	devm_clk_put(ab->dev, ab_ahb->xo_clk);
>> +	ab_ahb->xo_clk = NULL;
>> +}
>> +
>> +static int ath12k_ahb_clock_enable(struct ath12k_base *ab)
>> +{
>> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
>> +	int ret;
>> +
>> +	if (IS_ERR_OR_NULL(ab_ahb->xo_clk)) {
>> +		ath12k_err(ab, "clock is not initialized\n");
> 
> NAK.
> 
> Sorry, this code makes no sense. This is some random code. This code
> cannot be executed before probe. If it can: your driver is buggy, so fix
> your driver.
> 
> After the probe(), this is never NULL as an error. Either you have here
> valid pointer or you failed the probe.
> 
> This driver fails on basics of driver probing.
> 

Will remove the above code in next version.

>> +		return -EIO;
>> +	}
>> +
>> +	ret = clk_prepare_enable(ab_ahb->xo_clk);
>> +	if (ret) {
>> +		ath12k_err(ab, "failed to enable gcc_xo_clk: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void ath12k_ahb_clock_disable(struct ath12k_base *ab)
>> +{
>> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
>> +
>> +	clk_disable_unprepare(ab_ahb->xo_clk);
> 
> Don't create such wrappers for single clock. Does not help.
> 

Sure, will remove the wrapper.

>> +}
>> +
>> +static int ath12k_ahb_resource_init(struct ath12k_base *ab)
>> +{
>> +	struct platform_device *pdev = ab->pdev;
>> +	struct resource *mem_res;
>> +	int ret;
>> +
>> +	ab->mem = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
>> +	if (IS_ERR(ab->mem)) {
>> +		ret = dev_err_probe(&pdev->dev, PTR_ERR(ab->mem), "ioremap error\n");
>> +		goto out;
>> +	}
>> +
>> +	ab->mem_len = resource_size(mem_res);
>> +
>> +	if (ab->hw_params->ce_remap) {
>> +		const struct ce_remap *ce_remap = ab->hw_params->ce_remap;
>> +		/* CE register space is moved out of WCSS and the space is not
>> +		 * contiguous, hence remapping the CE registers to a new space
>> +		 * for accessing them.
>> +		 */
>> +		ab->mem_ce = ioremap(ce_remap->base, ce_remap->size);
>> +		if (IS_ERR(ab->mem_ce)) {
>> +			dev_err(&pdev->dev, "ce ioremap error\n");
>> +			ret = -ENOMEM;
>> +			goto err_mem_unmap;
>> +		}
>> +		ab->ce_remap = true;
>> +		ab->ce_remap_base_addr = HAL_IPQ5332_CE_WFSS_REG_BASE;
>> +	}
>> +
>> +	ret = ath12k_ahb_clock_init(ab);
>> +	if (ret)
>> +		goto err_mem_ce_unmap;
>> +
>> +	ret =  ath12k_ahb_clock_enable(ab);
>> +	if (ret)
>> +		goto err_clock_deinit;
>> +
>> +	return 0;
>> +
>> +err_clock_deinit:
>> +	ath12k_ahb_clock_deinit(ab);
>> +
>> +err_mem_ce_unmap:
>> +	if (ab->hw_params->ce_remap)
>> +		iounmap(ab->mem_ce);
>> +
>> +err_mem_unmap:
>> +	ab->mem_ce = NULL;
>> +	devm_iounmap(ab->dev, ab->mem);
>> +
>> +out:
>> +	ab->mem = NULL;
>> +	return ret;
>> +}
>> +
>> +static void ath12k_ahb_resource_deinit(struct ath12k_base *ab)
>> +{
>> +	if (ab->mem)
>> +		devm_iounmap(ab->dev, ab->mem);
>> +
>> +	if (ab->mem_ce)
>> +		iounmap(ab->mem_ce);
>> +
>> +	ab->mem = NULL;
>> +	ab->mem_ce = NULL;
>> +
>> +	ath12k_ahb_clock_disable(ab);
>> +	ath12k_ahb_clock_deinit(ab);
>> +}
>> +
>> +static enum ath12k_hw_rev ath12k_ahb_get_hw_rev(struct platform_device *pdev)
>> +{
>> +	const struct of_device_id *of_id;
>> +
>> +	of_id = of_match_device(ath12k_ahb_of_match, &pdev->dev);
>> +	if (!of_id) {
>> +		dev_err(&pdev->dev, "Failed to find matching device tree id\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return (enum ath12k_hw_rev)of_id->data;
> 
> You just open-coded of_device_get_match_data().
> 

Thanks, will use of_device_get_match_data() in next version.

>> +}
>> +
>> +static int ath12k_ahb_probe(struct platform_device *pdev)
>> +{
>> +	struct ath12k_base *ab;
>> +	const struct ath12k_hif_ops *hif_ops;
>> +	struct device_node *mem_node;
>> +	enum ath12k_hw_rev hw_rev;
>> +	u32 addr;
>> +	int ret;
>> +
>> +	hw_rev = ath12k_ahb_get_hw_rev(pdev);
>> +	switch (hw_rev) {
>> +	case ATH12K_HW_IPQ5332_HW10:
>> +		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to set 32-bit coherent dma\n");
>> +		return ret;
>> +	}
>> +
>> +	ab = ath12k_core_alloc(&pdev->dev, sizeof(struct ath12k_ahb),
>> +			       ATH12K_BUS_AHB);
>> +	if (!ab) {
>> +		dev_err(&pdev->dev, "failed to allocate ath12k base\n");
> 
> No, driver never prints allocation errors. You are duplicating existing
> core printk.
> 

Thanks, will remove this error print.

> 
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ab->hif.ops = hif_ops;
>> +	ab->pdev = pdev;
>> +	ab->hw_rev = hw_rev;
>> +	platform_set_drvdata(pdev, ab);
>> +
>> +	/* Set fixed_mem_region to true for platforms that support fixed memory
>> +	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
>> +	 * need not to allocate memory.
>> +	 */
>> +	if (!of_property_read_u32(ab->dev->of_node, "memory-region", &addr)) {
>> +		set_bit(ATH12K_FLAG_FIXED_MEM_REGION, &ab->dev_flags);
>> +
>> +		/* If the platform supports fixed memory, then it should define/
>> +		 * reserve MLO global memory in DT to support Multi Link Operation
>> +		 * (IEEE 802.11be).
>> +		 * If MLO global memory is not reserved in fixed memory mode, then
>> +		 * MLO cannot be supported.
>> +		 */
>> +		mem_node = ath12k_core_get_reserved_mem_by_name(ab, "mlo-global-mem");
>> +		if (!mem_node)
>> +			ab->single_chip_mlo_supp = false;
>> +		else
>> +			of_node_put(mem_node);
>> +	}
>> +
>> +	ret = ath12k_core_pre_init(ab);
>> +	if (ret)
>> +		goto err_core_free;
>> +
>> +	ret = ath12k_ahb_resource_init(ab);
>> +	if (ret)
>> +		goto err_core_free;
>> +
>> +	ret = ath12k_hal_srng_init(ab);
>> +	if (ret)
>> +		goto err_resource_deinit;
>> +
>> +	ret = ath12k_ce_alloc_pipes(ab);
>> +	if (ret) {
>> +		ath12k_err(ab, "failed to allocate ce pipes: %d\n", ret);
>> +		goto err_hal_srng_deinit;
>> +	}
>> +
>> +	ath12k_ahb_init_qmi_ce_config(ab);
>> +
>> +	ret = ath12k_ahb_config_irq(ab);
>> +	if (ret) {
>> +		ath12k_err(ab, "failed to configure irq: %d\n", ret);
>> +		goto err_ce_free;
>> +	}
>> +
>> +	ret = ath12k_core_init(ab);
>> +	if (ret) {
>> +		ath12k_err(ab, "failed to init core: %d\n", ret);
>> +		goto err_ce_free;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_ce_free:
>> +	ath12k_ce_free_pipes(ab);
>> +
>> +err_hal_srng_deinit:
>> +	ath12k_hal_srng_deinit(ab);
>> +
>> +err_resource_deinit:
>> +	ath12k_ahb_resource_deinit(ab);
>> +
>> +err_core_free:
>> +	ath12k_core_free(ab);
>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	return ret;
>> +}
>> +
>> +static void ath12k_ahb_remove_prepare(struct ath12k_base *ab)
>> +{
>> +	unsigned long left;
>> +
>> +	if (test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags)) {
>> +		left = wait_for_completion_timeout(&ab->driver_recovery,
>> +						   ATH12K_AHB_RECOVERY_TIMEOUT);
>> +		if (!left)
>> +			ath12k_warn(ab, "failed to receive recovery response completion\n");
>> +	}
>> +
>> +	set_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags);
>> +	cancel_work_sync(&ab->restart_work);
>> +	cancel_work_sync(&ab->qmi.event_work);
>> +}
>> +
>> +static void ath12k_ahb_free_resources(struct ath12k_base *ab)
>> +{
>> +	struct platform_device *pdev = ab->pdev;
>> +
>> +	ath12k_hal_srng_deinit(ab);
>> +	ath12k_ce_free_pipes(ab);
>> +	ath12k_ahb_resource_deinit(ab);
>> +	ath12k_core_free(ab);
>> +	platform_set_drvdata(pdev, NULL);
>> +}
>> +
>> +static void ath12k_ahb_remove(struct platform_device *pdev)
>> +{
>> +	struct ath12k_base *ab = platform_get_drvdata(pdev);
>> +
>> +	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
>> +		ath12k_qmi_deinit_service(ab);
>> +		goto qmi_fail;
>> +	}
>> +
>> +	ath12k_ahb_remove_prepare(ab);
>> +	ath12k_core_deinit(ab);
>> +
>> +qmi_fail:
>> +	ath12k_ahb_free_resources(ab);
>> +}
>> +
>> +static void ath12k_ahb_shutdown(struct platform_device *pdev)
>> +{
>> +	struct ath12k_base *ab = platform_get_drvdata(pdev);
>> +
>> +	/* platform shutdown() & remove() are mutually exclusive.
>> +	 * remove() is invoked during rmmod & shutdown() during
>> +	 * system reboot/shutdown.
>> +	 */
> 
> You should rather explain why you cannot use one callback for both. Why
> this has to be duplicated?
> 
>> +	ath12k_ahb_remove_prepare(ab);
>> +
>> +	if (!(test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)))
>> +		goto free_resources;
>> +
>> +	ath12k_core_deinit(ab);
> 
> And why this is actually different order than remove().
> 

The .shutdown() is not required for IPQ5332 wifi. In the next version
will remove the shutdown callback.

