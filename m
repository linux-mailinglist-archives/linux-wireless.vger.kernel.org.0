Return-Path: <linux-wireless+bounces-18165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34689A223E6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 19:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE06D3A94E9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7256F1E0DD9;
	Wed, 29 Jan 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ChJ0xtB+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2D1E0DDF;
	Wed, 29 Jan 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175374; cv=none; b=UdM9s8Cyc12amfmfX7atBZPs+WUU3rvM6384CNaSeP0yQTGTbQs2HhWh3CLhUwbsqFGL825TW7zSCN4G0B/yPgqsTiMVcVVAldmNcRxJuMajonooY3V/l5fB5gtVZOtyScFbuE6gWEP+wjCpuixyzJ7siHeMyttmr+dq4XV94w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175374; c=relaxed/simple;
	bh=Hw/qf1LaktOinY9CWMVY1JmifUigp2zF91VLkQNym88=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IlCkXbFP0bk1LRs7OzWbXeaH+9JZjlh/X8dEV0K5BRVhVhRxOGceHKImumyohP4Wbmpfg2rrOsA7SiLndPMZ/cZkg/tWmLI0O+vKfcFDyQw+QH2TVGyHbI74iguuvRBQE1ep3VBX3PA/n/J7kkzHykbUJjWcrxw7Lvn7USQinqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ChJ0xtB+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8VgGP020758;
	Wed, 29 Jan 2025 18:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QhO5jdWFxnHnOhAyAmmxGgJbaHEfMWtf0lSLHWs5Vkg=; b=ChJ0xtB+Udrev8o8
	ZE7J3eHRZbPprY0Lzxu06ake1L8Ja66GZSU1vaMmHYLUyDA4/7P+EJ0+9pKtSGuI
	ly2Ef5wT8/gtxTylJw9ksKF2gbNWhp81AoDoJPY8N1rPdcDqHcrG4wLM440JtS1l
	tFiC4IrCtuBeNu8maWFOsZtmKo0FKmVAq43tBi/MI92hyDBEEdqOHc8/j/jMSZJO
	wmBqnqMk90UmZSNOHyqQcQ5HoaCE4lEjuwPfc0SzzVJb+A9O9JVw/IyLxtuppOad
	Foq/Wwh3knFojs35aiyeNOBpX+wdRxEftPthnp/0SsDeGx5SsNuoiHt7KCRYI09q
	uLOxXw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fgw8s6yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 18:29:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TITDE5001816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 18:29:13 GMT
Received: from [10.216.5.143] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 10:29:09 -0800
Message-ID: <329fd3ef-5385-47e9-9e5b-875488cf9766@quicinc.com>
Date: Wed, 29 Jan 2025 23:58:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/13] wifi: ath12k: add AHB driver support for IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
 <20241210074159.2637933-9-quic_rajkbhag@quicinc.com>
 <42feceb8-512a-4be3-aefa-116bbde000c1@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <42feceb8-512a-4be3-aefa-116bbde000c1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DTDWcfnxnMVy9zQyVxoM8TGd-qFNNysP
X-Proofpoint-ORIG-GUID: DTDWcfnxnMVy9zQyVxoM8TGd-qFNNysP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290145

On 12/10/2024 8:17 PM, Krzysztof Kozlowski wrote:
> On 10/12/2024 08:41, Raj Kumar Bhagat wrote:
>> From: Balamurugan S <quic_bselvara@quicinc.com>
>>
>> Add Initial Ath12k AHB driver support for IPQ5332. IPQ5332 is AHB
>> based IEEE802.11be 2 GHz 2x2 WiFi device.
>>
>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
>> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/ahb.c  | 878 +++++++++++++++++++++++++
>>  drivers/net/wireless/ath/ath12k/ahb.h  |  37 ++
>>  drivers/net/wireless/ath/ath12k/core.h |   4 +
>>  drivers/net/wireless/ath/ath12k/hal.h  |   1 +
>>  drivers/net/wireless/ath/ath12k/hw.h   |   1 +
>>  5 files changed, 921 insertions(+)
>>  create mode 100644 drivers/net/wireless/ath/ath12k/ahb.c
>>  create mode 100644 drivers/net/wireless/ath/ath12k/ahb.h
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
>> new file mode 100644
>> index 000000000000..fcd949faea9f
>> --- /dev/null
>> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
>> @@ -0,0 +1,878 @@
>> +// SPDX-License-Identifier: BSD-3-Clause-Clear
>> +/*
>> + * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/iommu.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
> 
> You don't use this header.
> 
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/remoteproc.h>
> 
> More headers here look unused.
> 

sure, will remove unused headers in next version.

>> +#include <linux/soc/qcom/smem.h>
>> +#include <linux/soc/qcom/smem_state.h>
>> +#include "ahb.h"
>> +#include "debug.h"
>> +#include "hif.h"
>> +
>> +static const struct of_device_id ath12k_ahb_of_match[] = {
>> +	{ .compatible = "qcom,ipq5332-wifi",
>> +	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
>> +	},
>> +	{ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, ath12k_ahb_of_match);
> 
> This goes to driver struct declaration. It is really unusual to see it
> in some other places.
> 
> 
>> +
>> +#define ATH12K_IRQ_CE0_OFFSET 4
>> +
> 
> 
> ...
> 
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
>> +		dev_err(&pdev->dev, "Unsupported device type %d\n", hw_rev);
> 
> You already print once in ath12k_ahb_get_hw_rev() and none of these can
> happen. No need to print impossible conditions at all. No need to print
> impossible things twice.
> 

sure, will drop this print.

>> +		return -EOPNOTSUPP;
>> +	}
>> +
> 
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
>> +		mem_node = of_find_node_by_name(NULL, "mlo_global_mem_0");
> 
> NAK. Incorrect name, not conforming to coding style. Undocumented ABI.
> 
> Drop all calls to of_find_node_by_name() or any other stuff like this.
> 

Sure, will remove all calls to - of_find_node_by_name()

>> +		if (!mem_node)
>> +			ab->single_chip_mlo_supp = false;
>> +	}
>> +
>> +	ret = ath12k_core_pre_init(ab);
>> +	if (ret)
>> +		goto err_core_free;
> 
> Best regards,
> Krzysztof


