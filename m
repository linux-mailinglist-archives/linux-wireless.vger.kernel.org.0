Return-Path: <linux-wireless+bounces-8006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058358CD254
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8331F21BE0
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F513BC23;
	Thu, 23 May 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ig7WbGCk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E51E4A0
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467709; cv=none; b=lvUxBeqK0u6lQloDScAvFu5uvSkgrGjHswNR/SayeK/ZkGVw3ErwJn3g3Bl15jjJVlh9igROUmTtV1zHqd1jhemmuqZj9ZlRIwC32IDmjgVCalsEEk/rkw2nEl5gIemfBWhB+8n3bgCbSmxnpc4m9zBnB/p+gShRWmc0HO61CNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467709; c=relaxed/simple;
	bh=lKBY1fPuiEWtljrkRULZpvT0G4+ycBfSeD2CL9UJ8GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DhqE8B7mKq+qgCFMYdy4GZYqa3+QBitcnOywTrJGGg5jUF8rcUgIdd6PlvZ+c8eIv2wgPBrgqv2XlIi8S8Ebgk/dmlyPdt6dED9Z8e6UIHYeOCr4XC7lABad0Jp9bPPtmvrAKtJohXrkpJ0D96o6yTjEb585waIWj96lakbiLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ig7WbGCk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N4bGfO016987;
	Thu, 23 May 2024 12:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	neeT+MSnzUXdAVDbknPxIq3Mmqtbo3Id/s1ti+eEzyQ=; b=ig7WbGCklBUlqTdB
	zk9Qny29R+nV92G9iaeATV4IhDoJ+IcOq5k8ntReFirR+vs9mHmX+PG+hEezHQv6
	GxewyWZ4vXNMUO/4Rzd+GrAQeYdB5FDTlMMPxXI99chGvlAsctOKyrLExblkiI2d
	irMDpbpksNTx7duXVIFcUSxCqYBw2KNuIH9l2hJRY+eYq0y092moW6ZWrcEwsAJ3
	KHAi+vT+8hX9vFos5t97Yj6lTsK4FyFH+7OseleUaff9X0aWFA1lWCeOcXgaMRG+
	VaFcKe/vWhpf2wWWjqts8kZ/0guI4ExB6l4dEpftAh1VB3UlZQ7cxw07+4+aC1kw
	SCBsCQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y9xxe132m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 12:34:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44NCYvuL014132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 12:34:57 GMT
Received: from [10.111.164.21] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 05:34:54 -0700
Message-ID: <667cea80-9b62-4ca4-9d28-c5940582832a@quicinc.com>
Date: Thu, 23 May 2024 20:34:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] wifi: ath12k: Fix Pdev id in HTT stats request for
 WCN7850
To: Kalle Valo <kvalo@kernel.org>,
        Ramya Gnanasekar
	<quic_rgnanase@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
 <20240510050806.514126-4-quic_rgnanase@quicinc.com>
 <87pltfd2bt.fsf@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <87pltfd2bt.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M_CjQGxzG1d3pelguyx2s44pdlNcLWGQ
X-Proofpoint-ORIG-GUID: M_CjQGxzG1d3pelguyx2s44pdlNcLWGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_07,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230086



On 2024/5/21 15:57, Kalle Valo wrote:
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> 
>> From: Lingbo Kong <quic_lingbok@quicinc.com>
>>
>> Pdev id from mac phy capabilities will be sent as a part of
>> HTT stats request to firmware. This causes issue with single pdev
>> devices where fimrware does not respond to the stats request
>> sent from host.
>>
>> Single pdev devices firmware expects pdev id as 1 for 5GHz/6GHz
>> phy and 2 for 2GHz band. Handle pdev id for single phy device
>> while sending HTT stats request message to firmware.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> 
> [...]
> 
>> @@ -1029,7 +1030,12 @@ ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
>>   	memset(cmd, 0, sizeof(*cmd));
>>   	cmd->hdr.msg_type = HTT_H2T_MSG_TYPE_EXT_STATS_CFG;
>>   
>> -	cmd->hdr.pdev_mask = 1 << ar->pdev->pdev_id;
>> +	if (ab->hw_params->single_pdev_only)
>> +		pdev_id = ath12k_mac_get_target_pdev_id(ar);
>> +	else
>> +		pdev_id = ar->pdev->pdev_id;
> 
> Wouldn't it be cleaner to have the single_pdev_only check in
> ath12k_mac_get_target_pdev_id()?
> 

yes, i'll put the single_pdev_only check in 
ath12k_mac_get_target_pdev_id() function.

>> +struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k_base *ab)
>> +{
>> +	struct ath12k *ar;
>> +	struct ath12k_pdev *pdev;
>> +	struct ath12k_vif *arvif;
>> +	int i;
>> +
>> +	for (i = 0; i < ab->num_radios; i++) {
>> +		pdev = &ab->pdevs[i];
>> +		ar = pdev->ar;
>> +		list_for_each_entry(arvif, &ar->arvifs, list) {
>> +			if (arvif->is_up)
>> +				return arvif;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
> 
> I'm not seeing any protection here, is that on purpose?
> 

you means there need to add lockdep_assert_held(&ar->conf_mutex)?

>> +u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar)
>> +{
>> +	struct ath12k_vif *arvif;
>> +
>> +	arvif = ath12k_mac_get_vif_up(ar->ab);
>> +
>> +	if (arvif)
>> +		return ath12k_mac_get_target_pdev_id_from_vif(arvif);
>> +	else
>> +		return ar->ab->fw_pdev[0].pdev_id;
>> +}
> 
> No need to have else after return.
> 

