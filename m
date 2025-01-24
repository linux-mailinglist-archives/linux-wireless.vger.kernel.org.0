Return-Path: <linux-wireless+bounces-17874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55EBA1AE17
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 02:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BBE1694BC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE560890;
	Fri, 24 Jan 2025 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UfUIQ3/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B94C91
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737680948; cv=none; b=driAEF/cRF4Vc7V2i/nZrTruxcurnb7Ig4ykz1FCODn9lqAhn5ZoFWFaqFHTqijRS9luavbebNH5fB9WWtlGqN2hA4CM3psTiy6FczZ2maN5VxffCFcylReL8gFLu0IbD7CtWdlYc5MR7YBzmW/UDajrvOZs2Yv22xrXQTUYdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737680948; c=relaxed/simple;
	bh=xo1wD6cBQ+DwYQEvZ1znQhrhUeL79Ey9pJ2NAEKDeNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J/i55MnG21+Eyhi6AlyvSvn1B3nIpl1+x5aosuGk98HeCeFzZQy7IBwMSmjuRsR8n5fIA9CVHBPhCvSiE5ocmlydBXi787MxPOA81bOM7iGVVmIAh6gSi7UGR/0zLl1gtYzz+C0kxcGcQfYPdKeqfwilCXmJ6h0WBQ8IXJMwcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UfUIQ3/o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NLt8Vw023520;
	Fri, 24 Jan 2025 01:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u+/Nzf+wQsYK4CUtFVQexhSIKfVhWoImWUHWAyJwQrE=; b=UfUIQ3/o3It+BhsE
	pKTNKfj3c71tqc+VBzgoDDFlMiK18fH5nHhcpb+KrrvJ20hcXsVq0aQXXFDKwPGE
	GkrwjvVtTNkt0Edrp8WeZdqxti1M97cVJUkaN70RvD4ukOi2PDOqlrJYLPjFrpyZ
	rCFeD01b9JJwcV/0Sk5aNqdRp42b+FhCkY0fUQNvtv8NnwtKDFF58qCUN1jH4rPQ
	Q2M7Ux3W3XevLOD7Y5M2SpZaAYBps+dffXkGJ9hIOXetrgi2poqrd8ZeImnE33k4
	MN27LiaN96T5THWfLrDtlgdLlRV+hBBZS8dPzc1AerXvepXT7U7JPCbF/WMDNCqn
	eTkDpA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bx3u89h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 01:09:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O191bG023699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 01:09:01 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 17:09:00 -0800
Message-ID: <5861c953-436e-4f36-ae8b-5ef52fceb3b6@quicinc.com>
Date: Thu, 23 Jan 2025 17:09:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: <mbizon@freebox.fr>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
 <f5c6d874e9d7682d52c5ed107a0ede952b5cf53f.camel@freebox.fr>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <f5c6d874e9d7682d52c5ed107a0ede952b5cf53f.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IF9h6XQi_JKhNPLwxIosI5ztGv9CIsC7
X-Proofpoint-ORIG-GUID: IF9h6XQi_JKhNPLwxIosI5ztGv9CIsC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_10,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxlogscore=768 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240006



On 1/23/2025 3:06 AM, Maxime Bizon wrote:
> 
> On Mon, 2025-01-13 at 16:38 -0800, Pradeep Kumar Chitrapu wrote:
> 
> Hello,
>   
>> @@ -8376,10 +8637,13 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>   
>>          for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
>>                  arvif->bitrate_mask.control[i].legacy = 0xffffffff;
>> +               arvif->bitrate_mask.control[i].gi = NL80211_TXRATE_FORCE_SGI;
> 
> can you explain why it's not NL80211_TXRATE_DEFAULT_GI ?
> 
Hi Maxime

I believe, this is default GI based on device capability of HE for 
ath11k or EHT for ath12k.
>>                  memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
>>                         sizeof(arvif->bitrate_mask.control[i].ht_mcs));
>>                  memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
>>                         sizeof(arvif->bitrate_mask.control[i].vht_mcs));
>> +               memset(arvif->bitrate_mask.control[i].he_mcs, 0xff,
>> +                      sizeof(arvif->bitrate_mask.control[i].he_mcs));
>>          }
>>   
> 
> 
> The same initialization of he_mcs is missing in the ath12k_mac_assign_link_vif()
> 

Thanks for notifying..will fix it in next revision

