Return-Path: <linux-wireless+bounces-2754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8908419D5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 04:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98ED41F2429B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 03:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9DD37145;
	Tue, 30 Jan 2024 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VgZyaM1o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D812336B1D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583879; cv=none; b=DdGFcd1KYt3XReub6nKljrTZqx5dtmLfgUYilOlNA9a6raE+iiwpSN/gL1ymd1uQZB0tWH46ORZ3RT8vfqCKGfzyOUDAikp9TIhSeEb4LXH5slOdmXuwEDdSj78io/JL/OS5q/uLqgu1FZBwWrqiK0iL6SzanQhHaIomHrpojqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583879; c=relaxed/simple;
	bh=te39o2CHwuoAanLibkMtAfYd5IjEwxT9bpLlprgaBWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r4PROecbYOu1zTeG34rfL65VrmP1otIekg79DwwI5bChs0WHzU+NvBlGhQuUwmSsoOkOZ2j9vZY6hFMI9YjIlRTO8GqhpFsGAdb9Mp5uBx1ipbnqjleSlmsV5i26nnqLkL+sPx2u1ff0muyNbrKyDf/4GBd6VLntFPFUKdKr4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VgZyaM1o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U2dHgh032201;
	Tue, 30 Jan 2024 03:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hy1mojofQb2fgXLqaeUshtro03/8n9EMuA4i5ga1TQA=; b=Vg
	ZyaM1oij7RbH+D9jcT+FU49zgz/im3u52A0DykFxsOYWVR0uO4xZYvne4KFWa4B/
	wvBMv56quFgWEkwD/em+/nUxYBEPtojRhE/1wKnejCIqHa3IwyuTDaj85fpgHvJF
	2GQBZaJCe1soaeClan4I+SzxEPACnGdZtRwdczmojpxT3h52EAVIu9GwZA3abIJu
	+HaM3a665pM3Wi9H67/aUth2qNdI4LLARRc6JBk/2iLgEGDnQUsu7EbT0YLWQj79
	tGpHjHLj92aeR2SIo/DBk5WIDOFQnAJ61KwtVWvNSbIolJC1Q5q9eon/13fwiZb9
	G7z0H7u6b7RgZ/QKrjqA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxevds8tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 03:04:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U34YFr021842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 03:04:34 GMT
Received: from [10.216.39.255] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 19:04:32 -0800
Message-ID: <6a06c68d-0202-1b3e-8c9f-beee25856d56@quicinc.com>
Date: Tue, 30 Jan 2024 08:34:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 13/13] wifi: ath12k: disable QMI PHY capability learn
 in split-phy QCN9274
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-14-quic_rajkbhag@quicinc.com>
 <5f5a1a5f-cb04-4157-9464-ecd3d8611c8b@quicinc.com>
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <5f5a1a5f-cb04-4157-9464-ecd3d8611c8b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: crpjD41bEL5JVc-IOcNApQqhCJ245WiL
X-Proofpoint-ORIG-GUID: crpjD41bEL5JVc-IOcNApQqhCJ245WiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300019

On 1/30/2024 7:22 AM, Jeff Johnson wrote:
> On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
>> QMI PHY capability learn is used to get PHY count information to
>> support single/multi link operation (SLO/MLO) configuration. The
>> QCN9274 dualmac firmware currently do not support SLO/MLO, if two
>> PHYs are within the same chip. Due to this firmware crashes in
>> split-phy QCN9274, while bringing up AP with MLO parameter enabled
>> in QMI host capability request message.
> 
> Does this patch need a Fixes: tag?
> 

I do not think Fixes: tag is required, because Single-phy QCN9274 and
WCN7850 works fine. The issue is only with Split-phy QCN9274, and it not
yet part of upstream ath.git.

>>
>> The QMI PHY capability learn is not required for split-phy QCN9274,
>> if SLO/MLO is not supported within the same chip. Hence, disable QMI
>> PHY capability learn support in split-phy QCN9274.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/core.c | 1 +
>>  drivers/net/wireless/ath/ath12k/core.h | 5 +++++
>>  drivers/net/wireless/ath/ath12k/mhi.c  | 1 +
>>  drivers/net/wireless/ath/ath12k/qmi.c  | 3 +++
>>  4 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>> index ca3777c684b3..0d4640ff8d6f 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -1218,6 +1218,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>>  	ab->dev = dev;
>>  	ab->hif.bus = bus;
>>  	ab->qmi.num_radios = U8_MAX;
>> +	ab->slo_capable = true;
>>  
>>  	return ab;
>>  
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index f0a319ea57c1..a984171e4a08 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -842,6 +842,11 @@ struct ath12k_base {
>>  
>>  	const struct hal_rx_ops *hal_rx_ops;
>>  
>> +	/* slo_capable denotes if the single/multi link operation
>> +	 * is supported within the same chip (SoC).
>> +	 */
>> +	bool slo_capable;
>> +
>>  	/* must be last */
>>  	u8 drv_priv[] __aligned(sizeof(void *));
>>  };
>> diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
>> index 50b9e44504f7..adb8c3ec1950 100644
>> --- a/drivers/net/wireless/ath/ath12k/mhi.c
>> +++ b/drivers/net/wireless/ath/ath12k/mhi.c
>> @@ -385,6 +385,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
>>  				   "failed to read board id\n");
>>  		} else if (board_id & OTP_VALID_DUALMAC_BOARD_ID_MASK) {
>>  			dualmac = true;
>> +			ab->slo_capable = false;
>>  			ath12k_dbg(ab, ATH12K_DBG_BOOT,
>>  				   "dualmac fw selected for board id: %x\n", board_id);
>>  		}
>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>> index 0f0eaadc8418..92845ffff44a 100644
>> --- a/drivers/net/wireless/ath/ath12k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
>> @@ -2124,6 +2124,9 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>>  	struct qmi_txn txn;
>>  	int ret;
>>  
>> +	if (!ab->slo_capable)
>> +		goto out;
>> +
>>  	ret = qmi_txn_init(&ab->qmi.handle, &txn,
>>  			   qmi_wlanfw_phy_cap_resp_msg_v01_ei, &resp);
>>  	if (ret < 0)
> 


