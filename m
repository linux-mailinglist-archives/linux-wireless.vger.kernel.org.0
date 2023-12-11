Return-Path: <linux-wireless+bounces-615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AEF80C027
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 04:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876E32807F3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 03:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24345168C6;
	Mon, 11 Dec 2023 03:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fpA5C2ow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB49ED
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 19:55:46 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB3k7xV032083;
	Mon, 11 Dec 2023 03:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QSC79UzKC/zcRuptrIKTZ+OC5PqBy2cQjRqmGD1l5S0=; b=fp
	A5C2owPIhhcpmYrhMwsLT1N+nNf7YCsP8eWNAXJK9LPHTgK2o5+GQxQPKgk4VYT7
	SzJY4TwjJK9b+6Pwz9Tl6wjRtMiaBTXPhzCo4ZSrShjF1OKyvmEdwDm9oR18psqG
	ODI5bVo3/6DYJ0nDyd9hHQcsg2INcZFnkLFPn1weCBgC586YrbmuR+YVHX5bKB1Y
	2UWhBwd3i+bSEavYWYR35lQVHPF7TGbBLaCiJ9smssKuTvvcqk8nT5pzD05ypeZz
	b+MhE6YsrFymDQay8g3zvLY3DRL7RKwZ/Da977g2DDfmjGyAA7VCb4XteVBQNbZy
	87DEPzqYgplTM/cEs/Ig==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnnst59g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 03:55:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB3tfYw017746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 03:55:41 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Dec
 2023 19:55:40 -0800
Message-ID: <07d346b6-d8e7-458c-a8c3-4f0d901d22c9@quicinc.com>
Date: Mon, 11 Dec 2023 11:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/12] wifi: ath11k: update regulatory rules when
 interface added
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
 <20231204081323.5582-5-quic_bqiang@quicinc.com>
 <d3cad84f-2795-40c6-9e8b-2dd3c2ddd73b@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <d3cad84f-2795-40c6-9e8b-2dd3c2ddd73b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4iMzHUtJEoeGM6-oN9KHTmy9xR3VCrKg
X-Proofpoint-GUID: 4iMzHUtJEoeGM6-oN9KHTmy9xR3VCrKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312110031



On 12/7/2023 11:15 AM, Aditya Kumar Singh wrote:
> On 12/4/23 13:43, Baochen Qiang wrote:
> 
>> --- a/drivers/net/wireless/ath/ath11k/mac.h
>> +++ b/drivers/net/wireless/ath/ath11k/mac.h
>> @@ -156,7 +156,6 @@ struct ath11k_vif 
>> *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
>>   u8 ath11k_mac_get_target_pdev_id(struct ath11k *ar);
>>   u8 ath11k_mac_get_target_pdev_id_from_vif(struct ath11k_vif *arvif);
>>   struct ath11k_vif *ath11k_mac_get_vif_up(struct ath11k_base *ab);
>> -
> 
> Irrelevant change?
> 
>>   struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, 
>> u32 vdev_id);
>>   struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, 
>> u32 pdev_id);
>>   void ath11k_mac_drain_tx(struct ath11k *ar);
>> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c 
>> b/drivers/net/wireless/ath/ath11k/wmi.c
>> index 6f0a35fcc9c1..9a0568676a74 100644
>> --- a/drivers/net/wireless/ath/ath11k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
>> @@ -9858,3 +9858,9 @@ int ath11k_wmi_sta_keepalive(struct ath11k *ar,
>>       return ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
>>   }
>> +
>> +bool ath11k_wmi_supports_6ghz_cc_ext(struct ath11k *ar)
>> +{
>> +    return (test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
>> +             ar->ab->wmi_ab.svc_map)) && ar->supports_6ghz;
> 
> What is the use of first parenthesis? I don't see a closing one after 
> ar->supports_6ghz so its just guarding test_bit() which is not required.
> I believe intention here was to guard whole expression?
I don't see an need to guard the whole expression or the test_bit(), so 
will drop extra parenthesis in V9.

