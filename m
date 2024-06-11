Return-Path: <linux-wireless+bounces-8780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4270C9032EF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 08:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445AB1C22568
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 06:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F0818641;
	Tue, 11 Jun 2024 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HMl+NFfY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CF14287
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088393; cv=none; b=s6hLBcXKtS/l+lff4nXzz+1PlFv/17+ifOV+BC6XUvcDQAi6P28/glbc/TJhO4BgKGOOX0pUwKS4aOgrX+dCtQhPnhcRh7e0p8u62Tgq4o5I3laSzm61NYRIMb+jWPrTw0pTPvOZnSvZVS0bxkLyURhXOARKmJYg+BWdg8lBbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088393; c=relaxed/simple;
	bh=eHvi+f2OrYuRrPJU6ierVF/rCIghppWinoi324TnQPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cDx7qh/LBlrO+pvKLOkv72vm8I5fyP1qeduDXsIYQxeRw/Cg6t/RW0qKQYCO6aGELsb/PfkiT5jo7O4ZCfXgDDSFxtTF+Nl5uhsla4Y4F4jAxcN4XGWkFRufs2PvpyoD1NJRxon4DdVrtiQnXO1bU8s3rT4gCyZg6cca6BCPzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HMl+NFfY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B2D833008217;
	Tue, 11 Jun 2024 06:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YQPDtBtAsPMOn6fSkt3mYqCWAApAF/8Zk3HZYCLl8nc=; b=HMl+NFfYuMimcKdr
	daeqKE8IZdVbdZbyzh+Ad4c2mrqT2uj5SuMeOOsobmg3oPv5lc3+SZEgVfRT2Vx4
	rNIOi9iVdGJiA050X7F9WQKwTBbpzMTiRa3XOwqaGbEN88VH6p6f6fnI5OVJofAT
	50dctzF8kdlMHCk9GdRLuQf1AgdA9h8YtGAtEV89Aw2rAW13Edal3X8OQHmbarLa
	UWxrGMrz9iEZV3kNMJp0P+a4HAbOs+rGHPxLku3Kn/pvTheIucHni95fqgPa/5TF
	4GfSFbeeZU9HX0AGIc5G7NZf/blE/cEV5cSTIMP3tXTAUu9qqwmUTNys8fSZ9u/j
	PJMZIw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yme8rx25w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 06:46:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B6kAhH024849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 06:46:10 GMT
Received: from [10.216.19.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 23:46:08 -0700
Message-ID: <a07a490f-3611-4e03-8ea4-7ce9fc4e3889@quicinc.com>
Date: Tue, 11 Jun 2024 12:15:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: modify remain on channel for single wiphy
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240528082739.1226758-1-quic_ramess@quicinc.com>
 <878qzcq4uc.fsf@kernel.org>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <878qzcq4uc.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ki58VGm3q0pBSY4_d3tv8aYvCFMyEvTf
X-Proofpoint-GUID: Ki58VGm3q0pBSY4_d3tv8aYvCFMyEvTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_02,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110050



On 6/10/2024 7:26 PM, Kalle Valo wrote:
> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
> 
>> When multiple radios are advertised as a single wiphy which
>> supports various bands, vdev creation for the vif is deferred
>> until channel is assigned to it.
>> If a remain on channel(RoC) request is received from mac80211,
>> select the corresponding radio(ar) based on channel and create
>> a vdev on that radio to initiate an RoC scan.
>>
>> Note that on RoC completion this vdev is not deleted. If a new
>> RoC/hw scan request is seen on that same vif for a different band the
>> vdev will be deleted and created on the new radio supporting the
>> request.
>>
>> Also if the RoC scan is requested when the vdev is in started state,
>> no switching to new radio is allowed and RoC request can be accepted
>> only on channels within same radio.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> 
> I did some white space changes to the commit message.
> 
>> @@ -8416,12 +8416,63 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>>   	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>>   	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>>   	struct ath12k_wmi_scan_req_arg arg;
>> -	struct ath12k *ar;
>> +	struct ath12k *ar, *prev_ar;
>>   	u32 scan_time_msec;
>> +	bool create = true;
>>   	int ret;
>>   
>> -	ar = ath12k_ah_to_ar(ah, 0);
>> +	if (ah->num_radio == 1) {
>> +		WARN_ON(!arvif->is_created);
>> +		ar = ath12k_ah_to_ar(ah, 0);
>> +		goto scan;
>> +	}
>> +
>> +	ar = ath12k_mac_select_scan_device(hw, vif, chan->center_freq);
>> +	if (!ar)
>> +		return -EINVAL;
>> +
>> +	/* If the vif is already assigned to a specific vdev of an ar,
>> +	 * check whether its already started, vdev which is started
>> +	 * are not allowed to switch to a new radio.
>> +	 * If the vdev is not started, but was earlier created on a
>> +	 * different ar, delete that vdev and create a new one. We don't
>> +	 * delete at the scan stop as an optimization to avoid redundant
>> +	 * delete-create vdev's for the same ar, in case the request is
>> +	 * always on the same band for the vif
>> +	 */
>> +	if (arvif->is_created) {
>> +		if (WARN_ON(!arvif->ar))
>> +			return -EINVAL;
>> +
>> +		if (ar != arvif->ar && arvif->is_started)
>> +			return -EINVAL;
> 
> I wonder if -EBUSY would be more descriptive here? I changed to that in
> the pending branch.
> 
Yeah, landing here would mean that user has already started the 
interface on a radio(ar) and now requesting RoC on a channel that 
doesn't belong to it.
>> +		if (ar != arvif->ar) {
>> +			/* backup the previously used ar ptr, since the vdev delete
>> +			 * would assign the arvif->ar to NULL after the call
>> +			 */
>> +			prev_ar = arvif->ar;
>> +			mutex_lock(&prev_ar->conf_mutex);
>> +			ret = ath12k_mac_vdev_delete(prev_ar, vif);
>> +			mutex_unlock(&prev_ar->conf_mutex);
>> +			if (ret)
>> +				ath12k_warn(prev_ar->ab,
>> +					    "unable to delete scan vdev %d\n", ret);
> 
> Do we really want to continue if vdev_delete() fails? In the pending
> branch I added 'return ret' here and modified the warning message a bit.
> 
>> +		} else {
>> +			create = false;
>> +		}
>> +	}
>> +
>> +	if (create) {
>> +		mutex_lock(&ar->conf_mutex);
>> +		ret = ath12k_mac_vdev_create(ar, vif);
>> +		mutex_unlock(&ar->conf_mutex);
>> +		if (ret) {
>> +			ath12k_warn(ar->ab, "unable to create scan vdev %d\n", ret);
>> +			return -EINVAL;
>> +		}
> 
> Also here I modified the warning message a bit.
> 
> The pending commit here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=9b4ec32e921b34bd7a03d39cc0a75cba7e85dc02
> 
Changes looks fine for me, thanks a lot for Fixing them.

