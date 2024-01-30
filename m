Return-Path: <linux-wireless+bounces-2749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA48418B3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26D01F21AA4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 01:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C336133;
	Tue, 30 Jan 2024 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IMuOezrU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1E36131
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579580; cv=none; b=eNh5WglW27kJIm73Kubkdc59DuXPlwkCnnvcpBij5u6TUWMwh1jEsishIhfzJ6NkHeYrQRPQLqN9YGW/D6N1x/OvAbLe+kssaORiBbpajonSAskHsvgH/k0/uAT9AK8ZsmEGakTHwSLlQD1ZW7olnvmG9LbWDmPPyGsvDLpU46Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579580; c=relaxed/simple;
	bh=CD0iNqlR9MVo06YteK5T3jGoLG8sIKfhQP+8+oNcKao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=odFguaBdL1EP6nkX0P7vKoJrZKr3l/p/E3SQSNDQWjTazqH9rawN1vqJCxWXDPc0Hz0xwnXWD3bZXHqFLs13drQ0dNhL9MINmRqGTUPUx54sUbH67ia+FYrjcx30KLWwGdw/A49J1fLlxrVn2Lxfte2iFceOYdZX+LMi8l2t+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IMuOezrU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U18HJH012458;
	Tue, 30 Jan 2024 01:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hYfh/w8TLV2rHhLSyAU63soji5PBAK3sl7fLfpp7pak=; b=IM
	uOezrUV2ZE2etAHivLYSTRZ9Trnrux4VKMDxhbbuOqGgMHZMPZQ01+xX2688lyX5
	J+uN//pvyng/zzb47rwrQ3vPTsCc23P4x3VZI7tszIx0InKz5DhZhF1lLJZCVCSX
	OawhemVRAlVCCTHCwwPk+lQgNSEhhbt925LZ1HSrTAD/fsJKkXojri8RM0ZnELcy
	yhHJYZVvS5kQ3VLKKgCYqu5mgDbOFSe7Xfgm4gz8t6geNKSMCNj9fwPic3Tiz3y1
	dzLbE05EmGfRU4VrjBnUxr593r1zqksYNZltgad9C9oYIp+jdym1e6c0UKdLU+AA
	UZwAdeo8SOoY51N7OEIg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t9tuww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:52:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U1qr1d027528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:52:53 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:52:52 -0800
Message-ID: <5f5a1a5f-cb04-4157-9464-ecd3d8611c8b@quicinc.com>
Date: Mon, 29 Jan 2024 17:52:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] wifi: ath12k: disable QMI PHY capability learn
 in split-phy QCN9274
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-14-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-14-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q1eBJgfOAODl9vh5Zg-ZSAjH3kjs1iPM
X-Proofpoint-ORIG-GUID: Q1eBJgfOAODl9vh5Zg-ZSAjH3kjs1iPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401300011

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> QMI PHY capability learn is used to get PHY count information to
> support single/multi link operation (SLO/MLO) configuration. The
> QCN9274 dualmac firmware currently do not support SLO/MLO, if two
> PHYs are within the same chip. Due to this firmware crashes in
> split-phy QCN9274, while bringing up AP with MLO parameter enabled
> in QMI host capability request message.

Does this patch need a Fixes: tag?

> 
> The QMI PHY capability learn is not required for split-phy QCN9274,
> if SLO/MLO is not supported within the same chip. Hence, disable QMI
> PHY capability learn support in split-phy QCN9274.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 1 +
>  drivers/net/wireless/ath/ath12k/core.h | 5 +++++
>  drivers/net/wireless/ath/ath12k/mhi.c  | 1 +
>  drivers/net/wireless/ath/ath12k/qmi.c  | 3 +++
>  4 files changed, 10 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index ca3777c684b3..0d4640ff8d6f 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1218,6 +1218,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  	ab->dev = dev;
>  	ab->hif.bus = bus;
>  	ab->qmi.num_radios = U8_MAX;
> +	ab->slo_capable = true;
>  
>  	return ab;
>  
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index f0a319ea57c1..a984171e4a08 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -842,6 +842,11 @@ struct ath12k_base {
>  
>  	const struct hal_rx_ops *hal_rx_ops;
>  
> +	/* slo_capable denotes if the single/multi link operation
> +	 * is supported within the same chip (SoC).
> +	 */
> +	bool slo_capable;
> +
>  	/* must be last */
>  	u8 drv_priv[] __aligned(sizeof(void *));
>  };
> diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
> index 50b9e44504f7..adb8c3ec1950 100644
> --- a/drivers/net/wireless/ath/ath12k/mhi.c
> +++ b/drivers/net/wireless/ath/ath12k/mhi.c
> @@ -385,6 +385,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
>  				   "failed to read board id\n");
>  		} else if (board_id & OTP_VALID_DUALMAC_BOARD_ID_MASK) {
>  			dualmac = true;
> +			ab->slo_capable = false;
>  			ath12k_dbg(ab, ATH12K_DBG_BOOT,
>  				   "dualmac fw selected for board id: %x\n", board_id);
>  		}
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
> index 0f0eaadc8418..92845ffff44a 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.c
> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
> @@ -2124,6 +2124,9 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>  	struct qmi_txn txn;
>  	int ret;
>  
> +	if (!ab->slo_capable)
> +		goto out;
> +
>  	ret = qmi_txn_init(&ab->qmi.handle, &txn,
>  			   qmi_wlanfw_phy_cap_resp_msg_v01_ei, &resp);
>  	if (ret < 0)


