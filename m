Return-Path: <linux-wireless+bounces-21945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A41AA99F7F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 05:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A6B44643D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 03:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB9D198E63;
	Thu, 24 Apr 2025 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LjP+kysb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381242A82
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745464930; cv=none; b=apjbcSxxm9ZoWD+U9YfGbl5eWqNtroqTKRqvdtEF8OPU6S+nkVBot1LyNffiF0hGqE+ZHpQE/PXO4FTQUnuK9J4TxCk9oTy5DMNWMzuPkHviUCiaeVOhDnlzZ22F91aCg7KeU9jD/7SqH8unLwig8CRImUZuBPJ4MdX4gVafaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745464930; c=relaxed/simple;
	bh=0DQoqMYw3wEjVwfm0fXV3QrZVFvtLGOEGs8Mq+pul8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SY26pIaO4PJicK9OC1/l2Z5BO5vbXg/Fw/rZ86cSPVrR1nypHquB3ljBwcPmosP2bP946NyKSpJlkGYIzet5qB70GJERxxamd9Ee9l/h6/T+01zDk0N7IRKJ56KdHUqwqk7S6yOIiViCIzP0Hd8UhBXJtVvv5VgjAXBRdhyjpFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LjP+kysb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0FDQw031157;
	Thu, 24 Apr 2025 03:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JGah7OpiEjsMWBtUdpgvxJwO8vPqDsx1r3LbFa10pPs=; b=LjP+kysbyiNE9w5s
	ng+vMxNAIBNiQq2QZs+iG99R00LnwbyrLyVBM7LwZtFGQjI2MjZB1jf+s4INaB4E
	zc7fInzK3RYSSDoqpzGriiV4RqgnasGubU5j/710ohxI1yB+TdqvjyIMRmZ9IVCt
	tGdD1tPJkhEMxcO53vfPKMhWh0qaynl/a3V/XGyr4Zv5+cYdKnNXaztOJnuw4ZkJ
	UTjXDHV/xlfu/PFYc2zvJme/ucVtmLo0q9Aq2JGP1Q4+/LTxySASF8cMuGGESeZD
	QUBYIhN7vFBhPUH7ts+lAKBfc3kX57aFY4OPGKn/1KC9QcFFtPv2CJItya3FrwfJ
	DDbTVQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh5c2gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 03:22:03 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O3M2qX013725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 03:22:02 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 20:22:01 -0700
Message-ID: <8ff2ad2a-57ff-41c1-80d0-183997bb6326@quicinc.com>
Date: Thu, 24 Apr 2025 08:51:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 01/11] wifi: mac80211: add support
 towards MLO handling of station statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-2-quic_sarishar@quicinc.com>
 <253c8d56425a7549386fd6f0072293f608cb89eb.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <253c8d56425a7549386fd6f0072293f608cb89eb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAxOCBTYWx0ZWRfXwnVTXqAmQpZm E3++YaocATXm6aPvjwHtS3XHgeakFiOsIr9AmRB7bRliL8nC6oaMeiCfGktNqxeoUk01NXwxPsE +HjarXtHHt3Rc41dMCzTmcioMPXih0+kyBQ53ef1WdGeQ+dVSqqoAEOLTiXLlXzzgn0vopMVxss
 jsHOqAwHnLvNFkCbEOmN/ELiki0pNcDOKEXkOoMXjDSDhBF/G7nmuZlwJvIsFDamX4Ex10gCfXB 3hGYYZwYsTY5K70t5kf816KPZTIovXeTV38z584ZQzmW67mOSS046Z7ORhrjNLshRU9lxeDOfeW ni6LQ7OqgPACt205DDS8iiTNVdOpE4EdYC0RpqZJpkc+NmU0yShVSS/e2HZZbOkma/3mi1i1NLz
 Fg458Fa5aNVvlzsvSc74hPswf6JL/VFY09jXLWgpLw7B9yi/L/TscO22mRlAQstdKjlpfdtE
X-Proofpoint-GUID: Zzugg0_oMoPhHUwajUEpwGctHLg-kSPb
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=6809ae5b cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=88T_HVOLbFgadkYAZmkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Zzugg0_oMoPhHUwajUEpwGctHLg-kSPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=679
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240018

On 4/23/2025 10:05 PM, Johannes Berg wrote:
> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
> 
> 
>> -int ieee80211_ave_rssi(struct ieee80211_vif *vif)
>> +int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id)
>>   {
>>   	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>> +	struct ieee80211_link_data *link_data;
>>   
>>   	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
>>   		return 0;
>>   
>> -	return -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
>> +	if (link_id < 0)
>> +		link_data = &sdata->deflink;
>> +	else
>> +		link_data = wiphy_dereference(sdata->local->hw.wiphy,
>> +					      sdata->link[link_id]);
>> +
>> +	if (WARN_ON(!link_data))
>> +		return -99;
>>
> 
> nit: _ONCE? Not that important.
> 
> johannes

Sure, will change to WARN_ON_ONCE.

