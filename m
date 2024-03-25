Return-Path: <linux-wireless+bounces-5207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD888AA6B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4F51FA0879
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E779313FF5;
	Mon, 25 Mar 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OEJp/fGy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9F1FA4
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380290; cv=none; b=Ghqv6cetOcoe/rFbglEUZRRanZ8ja4VAoDqp9W0mtVnM6RnakP63QrZmmmtW0wBV/+PdVo5R0O41vwQ9H+dPDoLuNGKwugqeu7Ye50tiNv/t7xG44KymAg3k8ggP9Y6ueZvMgW/8xCWGgIpUR4yeGvh5CSi59czsP5RxgvlVEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380290; c=relaxed/simple;
	bh=PgVs21//b9Clxy0KuQ+15jpl+tmt2GCenaMumPwQAzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l1m/eFe9IWZknOeL9z5UpCQzu2XsWe001+rHS3uNnNJTjzGdNuLHl6Iw/LpfZRUtl5maeD2Mcr5jBR/9e3jwhne2UlKovu4K7uAcGFJGnAqhQVIqOBQKr1UxLEzFDVEcke6lSTOWh0rWezQb4OO98c52Hd1BbTQ7h+d2vT3U/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OEJp/fGy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PEOCr9015032;
	Mon, 25 Mar 2024 15:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qV6RR5vIX0x7hRKoxdsGao6SrRroi0frYPQc0eV9E7Q=; b=OE
	Jp/fGyR3F9LjC3D8cXrcGPdh1ZDZ00OW912JWNoPUV37e9rLkBbB4XpaEVhCQD9V
	Wwkmx2SU891anu6OEwjz3/DXG0w1gNZdfOrufj/W6pDNDFUCQn+cE9Ii9BOe9H6w
	qJywzCEwrPP/2IvIblU6wsp8FISfi331lR/nlyM7inG6Zjc2oRs5B6pX0Oj1hx8E
	pmPFmZDnLVc3/k0/UMsuedIlmrKbn6SeyHoEUPEjRn+RyJM3ut+Lfoz7N4akKpUz
	CN6+LIifR680LXcAE8a9B4AIrLQKHH3666iL4i4u0jelSwELJax77oOSC99XHORS
	/0SDwQBOUTUVLsQgLXYQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x31wsseea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:24:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PFOhXD009292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:24:43 GMT
Received: from [10.216.55.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 08:24:41 -0700
Message-ID: <e5fe8dc4-c44b-4734-906f-a9dcbb724bb1@quicinc.com>
Date: Mon, 25 Mar 2024 20:54:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] wifi: ath12k: scan statemachine changes for
 single wiphy
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <20240320190943.3850106-6-quic_ramess@quicinc.com>
 <85e7f591-ed52-4554-bd92-09086eaebcdb@quicinc.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <85e7f591-ed52-4554-bd92-09086eaebcdb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jzoHQfcM_1Vw4Nq_OKpo0pfJN1T9M3kb
X-Proofpoint-ORIG-GUID: jzoHQfcM_1Vw4Nq_OKpo0pfJN1T9M3kb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250085



On 3/22/2024 1:24 AM, Jeff Johnson wrote:
> On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> When multiple radios are advertised as a single wiphy which
>> supports various bands, a default scan request to mac80211
>> from cfg80211 will split the driver request based on band,
>> so each request will have channels belonging to the same band.
>> With this supported by default, the ath12k driver on receiving
>> this request checks for one of the channels in the request and
>> selects the corresponding radio(ar) on which the scan is going
>> to be performed and creates a vdev on that radio.
>>
>> Note that on scan completion this vdev is not deleted. If a new
>> scan request is seen on that same vif for a different band the
>> vdev will be deleted and created on the new radio supporting the
>> request. The vdev delete logic is refactored to have this done
>> dynamically.
>>
>> The reason for not deleting the vdev on scan stop is to avoid
>> repeated delete-create sequence if the scan is on the same band.
>> Also, during channel assign, new vdev creation can be optimized
>> as well.
>>
>> Also if the scan is requested when the vdev is in started state,
>> no switching to new radio is allowed and scan on channels only
>> within same radio is allowed.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 211 +++++++++++++++++++++-----
>>   1 file changed, 176 insertions(+), 35 deletions(-)
> ...
>> -static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
>> -					   struct ieee80211_vif *vif)
>> +static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
>>   {
>> -	struct ath12k *ar;
>>   	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> -	struct ath12k_base *ab;
>> +	struct ath12k_base *ab = ar->ab;
>>   	unsigned long time_left;
>>   	int ret;
>>   
>> -	if (!arvif->is_created)
>> -		return;
>> -
>> -	ar = arvif->ar;
>> -	ab = ar->ab;
>> -
>> -	mutex_lock(&ar->conf_mutex);
>> -
>> -	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
>> -		   arvif->vdev_id);
>> -
>> -	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
>> -		ret = ath12k_peer_delete(ar, arvif->vdev_id, vif->addr);
>> -		if (ret)
>> -			ath12k_warn(ab, "failed to submit AP self-peer removal on vdev %d: %d\n",
>> -				    arvif->vdev_id, ret);
>> -	}
>> -
>> +	lockdep_assert_held(&ar->conf_mutex);
>>   	reinit_completion(&ar->vdev_delete_done);
>>   
>>   	ret = ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
>>   	if (ret) {
>> -		ath12k_warn(ab, "failed to delete WMI vdev %d: %d\n",
>> +		ath12k_warn(ab, "failed to delete WMI scan vdev %d: %d\n",
> 
> this change seems strange. isn't ath12k_mac_vdev_delete() called from both the
> scan logic and from the normal ath12k_mac_op_remove_interface(), so it might
> not be a scan vdev that is being deleted?
> 
No, in Single wiphy, the vdev logic creation for an arvif is such that 
at any given point of time only one vdev is created for an arvif (either 
by ath12k_mac_op_add_intf/assign_chanctx/hw_scan).
Vdev created by mac_op_scan can either be re-used or deleted & 
re-created (on a different ar) by mac_op_assign_chanctx() if required.
Also once mac_op_assign_chanctx has started the vdev of an arvif, 
mac_op_hw_scan can only use that vdev. So mac_op_remove just simply 
deletes the one that is currently created.
>>   			    arvif->vdev_id, ret);
>>   		goto err_vdev_del;
>>   	}
> 

