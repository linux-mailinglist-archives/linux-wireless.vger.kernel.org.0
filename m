Return-Path: <linux-wireless+bounces-18224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA838A232F3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 18:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BEF3A50AA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A74C7C;
	Thu, 30 Jan 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RwRIXQEM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D426289
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258399; cv=none; b=ihVdH+H3lqyUwBWZpXKjnVEC7bdlTxDD737UuGRfT56Ja6y6lVL1TOx+S5yPpsN+bvFlel0ZfOYCINeFr+Vg2Nqhx2O7ahBs6Egf6M5fGv3AJacgi8wqXWW6WtZJ0HPdDSvIh12WKu6hLZetp/PBkNEvUFdeRMg8vfARZ9lsyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258399; c=relaxed/simple;
	bh=pgwwWSjJaXBfz/Iq9i1FDU5rbzsnT0gYrUY61TRlKHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UH5fMSS6y7zjrWPB1zzi84rnMsl/caI2niQCKoqlj4+VQMFuUDitaddzLP4JMTEf1Gu8Ise0k44b1l5/8uJyUdm5y5xHmRVcGGJxzceqkr8vucheKYYyKU7PARW5m7g4O0mbZadqIUx5eY6wJu8WqEkqbVnomOnj/ffXQyaEPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RwRIXQEM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U9LhAN015160;
	Thu, 30 Jan 2025 17:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eYmQqKs/Ne01PIQhPGvRWliO2qJVYCPyCpjjna+biIM=; b=RwRIXQEMMiuim1W1
	okB0/bJ4iC8S5K0DbYnrFV9aKqjjLKSF28KPsPKmhCFXOYYYoZKXLjJqAZN7Mj+t
	8c4Qr85HifSjW57QU+ptIrt1QIItyr0sXeVBe7pfmXo/74Ftbaaz7/JEDPzSzqUY
	TcZqjPfeh8MaVjYw17kIgJmPzlRd9Z+YMHSYQmYZJOeJ0bAf8AoLYJP84aw9Yl3c
	4fMCg53D31xUGkpsLh4/mnvAUKbtzs+H/qnq/J2U2sGMl/ca1YEbIgKk+4p/lukQ
	JSKnJhaxf0atgwfXZDk1S3jXmpU8ypu2vgCVZXzx2Wr7loctr4uMk6Qz8NNV/HGu
	f+HdBw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g6qqh5p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 17:33:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50UHX9LI010375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 17:33:09 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 Jan
 2025 09:33:06 -0800
Message-ID: <13987b22-15ee-f8b4-36f4-2375fe5a811e@quicinc.com>
Date: Thu, 30 Jan 2025 23:03:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] wifi: ath12k: fix ath12k_hal_tx_cmd_ext_desc_setup()
 info1 override
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250127071306.1454699-1-nico.escande@gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250127071306.1454699-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6S1Kh0AG1combFUjeApj7JSBOiueaLYX
X-Proofpoint-ORIG-GUID: 6S1Kh0AG1combFUjeApj7JSBOiueaLYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=990 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300133



On 1/27/2025 12:43 PM, Nicolas Escande wrote:
> Since inception there is an obvious typo laying around in
> ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding
> flags to tcl_ext_cmd->info1, we initialize + override. This will be needed
> in the future to make broadcast frames work with ethernet encapsulation.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
> v2:
>    - removed spurious 'fbx' from title
>    - removed fixes tag as the problem it fixes is not yet enabled mainstream
>      see https://lore.kernel.org/linux-wireless/23d62bef-2393-4232-93ff-82ca4dbc4524@oss.qualcomm.com/
> v1:
>    - initial version
> ---
>   drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index e0b85f959cd4a..00437736e0322 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -117,7 +117,7 @@ static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
>   			       le32_encode_bits(ti->data_len,
>   						HAL_TX_MSDU_EXT_INFO1_BUF_LEN);
>   
> -	tcl_ext_cmd->info1 = le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
> +	tcl_ext_cmd->info1 |= le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
>   				le32_encode_bits(ti->encap_type,
>   						 HAL_TX_MSDU_EXT_INFO1_ENCAP_TYPE) |
>   				le32_encode_bits(ti->encrypt_type,

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

