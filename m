Return-Path: <linux-wireless+bounces-19811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFD4A50A2A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 19:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEB97A942B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7154A2512ED;
	Wed,  5 Mar 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AZ6Ndsgx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1B2505C4;
	Wed,  5 Mar 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200269; cv=none; b=Tiw2L271ipA640PUBfOT5DMFOlMJgVgbaDhoxctX709UD7C6Q2ucJfTylSjgne7G6ZQ4BqY5ONoEOdofz47IvUtJQaoV/dP48hGkwD4ndYsduBYJKMkuZZx3b0BCVdJaR5qLrlCNR3Zim2zKhqz/UK/giBJS2G94xQ9WXbwhdlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200269; c=relaxed/simple;
	bh=EXarJHStblqL/B0ERPnOKpsTIvdSkL3FI41o71M7wO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W5lby6uWDPmJ9qLoj/ehdGh4vZsITcs/3zzdTjygmjlv2gHT9fXZTqXOKt32ZL86dQ2N3xcn/gnaOIyJdPORj4HlTSU1rQFh766HLQyOKmgTRq44MiX6B+C4gJnLRYvMEn8g2hSdB/x0vB2JzPE1Ig8sVx4H3S4wzYGh4wgggAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AZ6Ndsgx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525AwF4I014538;
	Wed, 5 Mar 2025 18:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BA/2qFxYmbwcqPma/aszST1uYFQi7XJIrgTUYSCXqn0=; b=AZ6NdsgxLz10/jIE
	hmq/quYFORPRJoVJxfQUgvr/HgfOamr0gR/0yYrFTU4xS5F7KzSysc4+vL5La2lz
	26HTtbq2bGiyAFrm2DxbktYdPHebocAeJHjs0Jr2ZoFujxFXhGH+YxtWrWK2UAsW
	FHuOpj5hDb4uZ8iVWNcYINaGUAJIEJPsR6lg4Q/kVeXz8j2JYXUKe6i4l82gaDzE
	wv3jpLEggcVZMmHfRqVTvMmKNJk5erWh1Pv4flGKCDKlM5VVKyRQ2f7ubKI7JLfX
	fCT1BWHw1HS5ykQJn6BLv5XXQY9xeIFpjis05NIjX5/W0o1a6RKO4XpcQhyRQBWM
	DDC4Wg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6vpfpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 18:44:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 525IiHNt022904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 18:44:17 GMT
Received: from [10.216.44.194] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Mar 2025
 10:44:13 -0800
Message-ID: <0b0d9e1e-b968-4ffa-8f61-4ac2c02de3c3@quicinc.com>
Date: Thu, 6 Mar 2025 00:14:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/13] wifi: ath12k: add AHB driver support for IPQ5332
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-9-quic_rajkbhag@quicinc.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20250228184214.337119-9-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UwTuhe1qE4EUXdEibtT6ykrnurHBTNzB
X-Authority-Analysis: v=2.4 cv=LYfG6ifi c=1 sm=1 tr=0 ts=67c89b82 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=8wJXLLSO5PcA3Y4IdE0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UwTuhe1qE4EUXdEibtT6ykrnurHBTNzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050144

On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> +static int ath12k_ahb_probe(struct platform_device *pdev)
> +{
> +	struct ath12k_base *ab;
> +	const struct ath12k_hif_ops *hif_ops;
> +	enum ath12k_hw_rev hw_rev;
> +	u32 addr;
> +	int ret;
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set 32-bit coherent dma\n");
> +		return ret;
> +	}
> +
> +	ab = ath12k_core_alloc(&pdev->dev, sizeof(struct ath12k_ahb),
> +			       ATH12K_BUS_AHB);
> +	if (!ab)
> +		return -ENOMEM;
> +
> +	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);
> +	switch (hw_rev) {
> +	case ATH12K_HW_IPQ5332_HW10:
> +		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}

The ab should be freed before returning.
Will fix this memory leak in next version (v9).

