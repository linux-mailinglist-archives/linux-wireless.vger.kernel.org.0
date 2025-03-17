Return-Path: <linux-wireless+bounces-20433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03017A64C51
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576A116E882
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0E233141;
	Mon, 17 Mar 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hnFHJXhJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF519F133
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210472; cv=none; b=XCfI9Y4misfuwe4HBuGWgV0w/pzGeqlJoU//RqWS85ROReR3DeQaXGRwkBWpx1ABc1vLednN/+mxf0F3oA2Fl1ASIEDHzHs0xc1oTwJa6KzmZtOUu8G+fYm3vJNwONVif8/axODieNxj2tB2jAOIrVrKQ0Mr4p5Hc+8FqlPjq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210472; c=relaxed/simple;
	bh=UxrRMDIo5hLMMFoqT70xti5/uCUL6+CGxNljpBHqr0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W0TqtriLtBeaFu/gIS+5yIHp5bSSDwxVLke9dwoIntyww+MU/S/jZLlhc8hgXfIyEvVGL6nCYc/5xwtXGba2cAS6TFbrQNv+27XOnjaolEOrIVcCsGbdizSu3ZQBejxJlpsCIwFXEFHH71f0eUo13ErkYnI3sxBi7F0EjDNQlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hnFHJXhJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HATkpm029610;
	Mon, 17 Mar 2025 11:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zopIfx1QvRmMBFxpsSX1oY2tGRbAZ1qFtE0Rlrkda5c=; b=hnFHJXhJvYO2WpNa
	XcN9i1t0xWwhZRf1s3T3bYftc3c6bmtwfBHiOhPWLuv/bsb6pfy3F6pantRS4TI/
	JNA1H2nzAyxjh6K+uy63cGa02qFC6h62M35XwZa9xaJELI8yJ/TjW1+8imeDzoi3
	bGZ+VBCVog+lIWCBeTpv/KTXewCd/OriqCJMnDTZhxiQrAfbZwRf/xiNrtDGgpQB
	c8vF9wyenNjFjsORSWJSG9FdJ9l81MFFtuTLi4bYBP67yLnI9uqkx/E5QvF6qhrT
	pKOJthL2KZjSaDusl+rtyxltz6tDj4xpQLIzVxGRjo1tEHvRoGFxMhA4jfdhVvi+
	ZWAf1Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sxvffg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 11:19:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52HBJ25T003281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 11:19:02 GMT
Received: from [10.152.199.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Mar
 2025 04:19:00 -0700
Message-ID: <9fa954c2-f0fa-4237-840c-22e9eba8a307@quicinc.com>
Date: Mon, 17 Mar 2025 16:48:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 1/4] wifi: cfg80211: Add support to get
 EMLSR capabilities of non-AP MLD
To: Johannes Berg <johannes@sipsolutions.net>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Ramasamy
 Kaliappan" <quic_rkaliapp@quicinc.com>
References: <20250306062157.1185769-1-quic_ramess@quicinc.com>
 <20250306062157.1185769-2-quic_ramess@quicinc.com>
 <7cdc6950ba188625d691e8fd4726ef6872f6afa1.camel@sipsolutions.net>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <7cdc6950ba188625d691e8fd4726ef6872f6afa1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FQXSEhAEP_bntlaKrgv35hnK2ZZ0TXDY
X-Proofpoint-ORIG-GUID: FQXSEhAEP_bntlaKrgv35hnK2ZZ0TXDY
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d80527 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=tn7nk47zgIFjfK1QofoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170083



On 3/11/2025 3:18 PM, Johannes Berg wrote:
>>   
>> @@ -7095,7 +7096,8 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
>>   		if (params->ext_capab || params->link_sta_params.ht_capa ||
>>   		    params->link_sta_params.vht_capa ||
>>   		    params->link_sta_params.he_capa ||
>> -		    params->link_sta_params.eht_capa)
>> +		    params->link_sta_params.eht_capa ||
>> +		    params->eml_cap_present)
>>   			return -EINVAL;
>>   		if (params->sta_flags_mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
>>   			return -EINVAL;
>>
> 
> EMLSR doesn't make sense for TDLS stations either, does it?
> 

Spec doesn't speak anything about MLO between TDLS peers, we shall 
consider it as not applicable at this point.

Also, seems we need to exclude other sta types such as mesh too, as MLO 
is not applicable to Mesh as well. May be I'll add an exclusive case to 
restrict EMLSR change only for CFG80211_STA_AP_CLIENT.

-- 
Ramesh


