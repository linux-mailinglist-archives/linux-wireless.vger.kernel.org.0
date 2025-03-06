Return-Path: <linux-wireless+bounces-19839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A024A54278
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 06:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725EE1892150
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 05:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5804217E473;
	Thu,  6 Mar 2025 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fk2lm5ac"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C128938DFC
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240588; cv=none; b=VW6BCRly5jgvy3iKdX/FhWq36iw7WGjG2ro2GoZckM5r2PmGETuY3Du7EBtfuHHWRA9s0nUafJPOjMoiQZLGapwKMolrETkDU8vgXiFNlpeyBctpfCnK0Y7+WZuc0vdfVUU5+JVAHLadRMMDlzCY8aCNSrI5/74BRbHxYGDQeKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240588; c=relaxed/simple;
	bh=kCP9+EBpY1BMfmqiYs/ht1Tv+4abuXLmWA6eiYbiwgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KFQuMlo8tAQKCRj0f6FQU253sx3gF3U0REEDzn3Ibb5LiG/fhWKBN5dsGL9q72k0Ou+8Ux6uaCB+uOTdAbHLoyApjZvw3JHV3+DAcodBDtQ8fmMfwsmFFwP9J0E99Gy0RPfD7FFgQg02jjxbU9VDDo+rk813ELOXqx8DpIV6xb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fk2lm5ac; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525KNg4r023663;
	Thu, 6 Mar 2025 05:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DNoyYSURkPvdYAyBl1ersfHcq6fQT1ykjNO8WNKhaok=; b=Fk2lm5acT0oS7qvt
	X1W4QqnNJHzVTxom7IxMlsPd9hfUcv40Sv/61XH6iL/b8qZBQbBvgDgXxoKW9Sum
	S/Vs/vaADYtGY5Z9BJWP3FI+FH0nGHnNqDJJI2TF1GC/OaIIRB4DLwjdhOLcZAfo
	dOMOuHFg1CeWcYxpBjVQo5QcQzEgS9cseEOm77/JXJJZMjecUkItpQrknxx5INHa
	WM9WLYbhApBgvlgyQHs7cHc3ugk9/qHhvxk9fmWQxcLNpovCfVvNeK+QtzCn51lK
	ihBDrmiSz+HVWyhDsLk9E15wsDs66LpJvEoEkDZgCildR+kS8z4IzLd1xLx3/5i+
	DQ6NDw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t7xc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:56:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5265uEdU008085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Mar 2025 05:56:14 GMT
Received: from [10.50.16.15] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Mar 2025
 21:56:11 -0800
Message-ID: <4c4a20b3-acb7-492f-9e8e-ee357118ffef@quicinc.com>
Date: Thu, 6 Mar 2025 11:26:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 4/4] wifi: ath12k: update EMLSR
 capabilities of ML Station
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Ramasamy
 Kaliappan" <quic_rkaliapp@quicinc.com>
References: <20250303221843.1809753-1-quic_ramess@quicinc.com>
 <20250303221843.1809753-5-quic_ramess@quicinc.com>
 <addc9245-cfa1-4137-bb27-99beda42a147@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <addc9245-cfa1-4137-bb27-99beda42a147@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=I/ufRMgg c=1 sm=1 tr=0 ts=67c938ff cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=C65UpspZ_Kq9X2i2-EIA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: P-OQUGjzylazI5MckUaIpyZZ5Zj3TLJp
X-Proofpoint-ORIG-GUID: P-OQUGjzylazI5MckUaIpyZZ5Zj3TLJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060041



On 3/4/2025 5:03 AM, Jeff Johnson wrote:
> On 3/3/2025 2:18 PM, Rameshkumar Sundaram wrote:
>> From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> ...
>> +	if (u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_SUPP)) {
>> +		/* Padding delay */
>> +		eml_delay = ieee80211_emlsr_pad_delay_in_us(eml_cap);
>> +		ml_params->emlsr_padding_delay_us = cpu_to_le32(eml_delay);
>> +		/* Transition delay */
>> +		eml_delay = ieee80211_emlsr_trans_delay_in_us(eml_cap);
>> +		ml_params->emlsr_trans_delay_us = cpu_to_le32(eml_delay);
>> +		/* Transition timeout */
>> +		eml_trans_timeout = ieee80211_eml_trans_timeout_in_us(eml_cap);
>> +		ml_params->emlsr_trans_timeout_us = cpu_to_le32(eml_trans_timeout);
>> +		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi peer (%pM) emlsr padding delay %u, trans delay %u trans timeout %u",
>> +			   arg->peer_mac, ml_params->emlsr_padding_delay_us,
>> +			   ml_params->emlsr_trans_delay_us,
>> +			   ml_params->emlsr_trans_timeout_us);
> 
> it seems wrong to print the values converted to LE if the host is BE.
> suggest instead you cache all 3 host values and print those instead.
> 

Sure Jeff, will add separate variables and use them in print statement.

-- 
Ramesh


