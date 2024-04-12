Return-Path: <linux-wireless+bounces-6232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B18A2A23
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 11:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344A31C21F57
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD21524B4;
	Fri, 12 Apr 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fTNjKwpn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAB50291
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911688; cv=none; b=TxuAfWdyDntEU7W9a1kdkRyqaP/dKs8bDtYOjs9OeekqANnu62LtI4de0P0mrNovBaILbUARXoSh6DRrdqJYHhNHfVuw22Ivh4TgS1SmUW7N5od6Vygx8hg5MKLjiq3YU9xmfV1vY0AlOgi0IPp7Qq7t9hbjP/qDNd7BSYpZeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911688; c=relaxed/simple;
	bh=Csy8ePGlwQW3MxE+ZDbqf+Bevxt/8T9IGPh08L6tzkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dfeWmdwoRok3NJIhbDJm0BbWTP6/dMVrqI6Xq9IZM0XYnFcy44AlzckTtL4t26oFrZ2QyX2qlj6jrloozSdxjtBQvc10umhYI7kebAzn0sfNWQhgwCwHOyvbV6D0ub7bCDZefWfIYAFpF0zpyyK91qSknVOTp1gOgsDm44KcO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fTNjKwpn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C2qSt4003950;
	Fri, 12 Apr 2024 08:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=t5cLl7udZXqmR3olquQpCmFNN1J7b1OOt0V9VWSBRDA=; b=fT
	NjKwpnSTUCXhP8Yi8l0DNVGba9Jbf+DbDVi8ycovWvnU+ib3NYykuKPo8D1GoP0K
	BUMbq3U9daGUAn4XuoDvHfx9YatLGAZwHI7OEmwDTfi6l2P+0Uu/UrBJWqF5G6LG
	H+TVNgPN96I5eKe6qXKHJKGEJlL/aKuccf/zFJT/EnSkRwzvagdolBPFQ7hsbizZ
	xTbXX4i4qV1mHPvGr6L+wvuXJ0uHWYpY4N/nCEH7m2Wk2SyoCekO86DHbIepw7ze
	+UJCE7LdLSVTRM/FaQzcmhNfeyXkdUl5yvIqitlQTTVk+80+VA/puAwAD/wyRCCX
	PXq7qFts23T4p1r+Ouxg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xev74rp4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 08:47:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C8ltKB024455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 08:47:55 GMT
Received: from [10.253.34.41] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 01:47:54 -0700
Message-ID: <6ee5664b-997b-45eb-89f9-5f75708c268a@quicinc.com>
Date: Fri, 12 Apr 2024 16:47:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: add support to handle beacon miss for
 WCN7850
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412025149.1211-1-quic_kangyang@quicinc.com>
 <D0HYXSPMY8JE.17YSACO3ROKKZ@gmail.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <D0HYXSPMY8JE.17YSACO3ROKKZ@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rKVHglC3yMz2N0dQ_6_iIcKQevvAx6gi
X-Proofpoint-ORIG-GUID: rKVHglC3yMz2N0dQ_6_iIcKQevvAx6gi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_05,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120063



On 4/12/2024 3:33 PM, Nicolas Escande wrote:
> On Fri Apr 12, 2024 at 4:51 AM CEST, kangyang wrote:
> [...]
>> @@ -5986,6 +6055,20 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
>>   	lockdep_assert_held(&ar->conf_mutex);
>>   
>>   	arvif->ar = ar;
>> +	arvif->vif = vif;
>> +
>> +	INIT_LIST_HEAD(&arvif->list);
>> +	INIT_DELAYED_WORK(&arvif->connection_loss_work,
>> +			  ath12k_mac_vif_sta_connection_loss_work);
>> +
> Is there a need to move the following part ?
> Isn't just adding the delay work enough ?


Just checked, you are right, but should add delay work in add_interface().

Will change in v3.


>> +	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
>> +		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
>> +		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
>> +		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
>> +		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
>> +		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
>> +	}
>> +
>>   	vdev_id = __ffs64(ab->free_vdev_map);
>>   	arvif->vdev_id = vdev_id;
>>   	arvif->vdev_subtype = WMI_VDEV_SUBTYPE_NONE;
>> @@ -6316,16 +6399,6 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>   
>>   	arvif->vif = vif;
>>   
>> -	INIT_LIST_HEAD(&arvif->list);
>> -
>> -	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
>> -		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
>> -		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
>> -		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
>> -		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
>> -		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
>> -	}
>> -
>>   	/* Allocate Default Queue now and reassign during actual vdev create */
>>   	vif->cab_queue = ATH12K_HW_DEFAULT_QUEUE;
>>   	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
> [...]
> 
> Thanks

