Return-Path: <linux-wireless+bounces-11015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFCE949529
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72201F2805A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A78C82498;
	Tue,  6 Aug 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZPuEDhEb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8E4CB5B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960148; cv=none; b=kyNWWCgr9VJBOcEgmErGL/afmYHuAB/F+2s1VksVNI44ndbwf5Qbd7cGt2mhx2duXJiWCwlYZjULQLqMBFr01FJ6LeZ9mu1pGEFEsxwEjqz9wWXH9eqoUKrLu7TlGscN1YtRseUGBODeNna1E1VpUfg+JsOv8/kf+vxRlBuCoQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960148; c=relaxed/simple;
	bh=TOMcLfKEqEDWMjMI3BW8BIrIGt2bVGtz3NHB74r1yQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NT0xbyPvk1q/NeGgdOK+fDs7TSMVoJhRJrEXqLgJHOU3fGKPMjtmYamF1Zu2IDy4RjWV+Sd230v1t1sbdLW6IzVF/3nZK73auMhZOKFOm6Wvc5OS8XHTdgvnE0D3u6C7AD2dSaBKQanwfjmBZY8RzKLdUNg89K5KnZQ+w0iRnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZPuEDhEb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476BfYvD013610;
	Tue, 6 Aug 2024 16:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2OaG93OVWa3c/MU+QduFh7Ljn3vB5Sy+MTjdH+1YsF4=; b=ZPuEDhEbA7zgrHNR
	HXy8Q6UeXg4uRyVnl0T6UbE8DMCN1rHoy+tPJMZuDKd09NjbQN0fueJwaCKdg9/W
	SQeQEIEIx7WTmOKcHh/6SpDa2BsCmW/X8hDNYxyW7ENt507raGA4++UoPkIaVvY7
	0J5VL1fbGfgfhdufmi6HysEUoC1YO8WrAG6MPVkjEbZoPr1UZDpdn10s/xpVbgdL
	oRIsICSWeDOb122+tpNUvg1XsYlkw7ykJpvgfGFYQ3w90uLwG1VHzLABbVBtYp1a
	FbRyxic9V7WLsX74+DzU32uiWmtACdW5bDprauUGovditrfXO2GVuXr9yB3dE0Ee
	l8s45w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sdu97ua4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 16:02:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 476G2K7I014655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Aug 2024 16:02:20 GMT
Received: from [10.216.31.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 Aug 2024
 09:02:17 -0700
Message-ID: <1510a11a-c31c-4a05-80c0-bffa81fa340a@quicinc.com>
Date: Tue, 6 Aug 2024 21:32:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
To: Kalle Valo <kvalo@kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R
	<quic_srirrama@quicinc.com>
References: <20240711165511.3100433-1-quic_ramess@quicinc.com>
 <20240711165511.3100433-2-quic_ramess@quicinc.com>
 <87plql6djk.fsf@kernel.org>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <87plql6djk.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0e90sPM32qo_N9QhDSDSwFseHc6XlBH8
X-Proofpoint-GUID: 0e90sPM32qo_N9QhDSDSwFseHc6XlBH8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=820 suspectscore=0 malwarescore=0
 clxscore=1011 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408060112

On 8/6/24 17:58, Kalle Valo wrote:
> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
> 
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> To prepare the driver for MLO support, split the driver vif
>> data structure to scale for multiple links. This requires changing
>> the use of arvif to per link and not per hw which can now
>> comprise of multiple links.
>> Also since most configurations from mac80211 are done per link, do refactoring
>> of the driver functions to apply these configurations at link level.
> 
> Something I noticed while reviewing this patchset:
> 
>>   static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>   				       struct ieee80211_vif *vif)
>>   {
>> -	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>> +	struct ath12k_link_vif *arvif;
>>   	int i;
>>   
>> -	memset(arvif, 0, sizeof(*arvif));
>> +	mutex_lock(&ah->conf_mutex);
>> +	memset(ahvif, 0, sizeof(*ahvif));
> 
> Here we are we clearing ahvif so ahvif->deflink is NULL.

deflink is not a pointer member. It is statically defined inside ahvif. 
So basically this memsets the whole deflink memory region to 0.
> 
>> -	arvif->vif = vif;
>> +	ahvif->ah = ah;
>> +	ahvif->vif = vif;
>> +	arvif = &ahvif->deflink;
> 
> So here we assign arvif to NULL.

This would be a still valid pointer.
> 
>> +	arvif->ahvif = ahvif;
> 
> And because arvif is NULL this is a null pointer reference, right? Or am
> I missing something?

So since it is valid pointer, this is not a NULL pointer de-reference.

-- 
Aditya


