Return-Path: <linux-wireless+bounces-18200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57917A228DC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 07:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1D57A18EF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 06:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52FC33987;
	Thu, 30 Jan 2025 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YJk5vGY3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A02B660
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217746; cv=none; b=GtZ5KtjwotKetATiMbX130Ik6APeZRWdEOeLThaI9QQSyNvTFGbB3NuVwNJVJTfWlse8Ymn/dD+KAOSs5NEi6z1LJqcgEggliETwQ+Bx1AZwYN+HAWj5ZxCDWkrMl+nvZJA8/k+zyJXI+Eub/jL+8LOzix1Kv9n14H9wlpv+qPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217746; c=relaxed/simple;
	bh=7FfsN7AIqD4VSDczgQ+QK1YZ9oIyrL++V0WKDYve9hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z4HFqe8cE5c3s02pMigASOJOuq6QGaJS7eZuiwNahIaVOroCmZXABpFdIWwSgCR+f3ks9tG1wd9yGWCrzXRW3DP3FDwrktN1e0GHYLAgVcX1FMno53JWc+GmAv4AtHmXH0fRzL42EI1p5vBUg6aXQsyoKkDDpKo+44crRiVsjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YJk5vGY3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U5OX2e021554;
	Thu, 30 Jan 2025 06:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xenBW0R2iw2s6M7KQ5/o3QaR0uhPnOpNDNPs5oVhINY=; b=YJk5vGY3wqFzVZB1
	CLYUQtBsUbwvtvzdaF0BS8Zuyw3aMK4Rnr+WxS04Hb0E9PQeRq08T9bQw7bx41rq
	kvVIVxaYAYxeGwUWalWvTwotkB24YXdgCrB049RdmTzasCvgbtaAsQR0LGApjSzU
	KuZlsPmHksiV/OFnHI5Oon6jH2QmupcKrKgL2WMlfsHzyWmfrLxcF/zbhhVCfEBA
	DP2VlV6HXeThxta4GVusrGIynu2z78xb0UV7pBpPu5IAUPfdBbIgCQEp/QNxnsSP
	opBpDT6DcS6qzw9F5vK8ZXptiw9jYt5rGks6t0hdx0EuuWNt4byKXcpdwtdo3gCl
	nlECIQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g38kg2ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:15:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U6Fe05024417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:15:40 GMT
Received: from [10.50.27.147] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 22:15:38 -0800
Message-ID: <6e4a8158-fe9f-40b1-a133-c0df17fdd620@quicinc.com>
Date: Thu, 30 Jan 2025 11:45:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] wifi: ath12k: Add Support to Parse TPC Event from
 Firmware
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
References: <20250128111059.1690113-1-quic_rdevanat@quicinc.com>
 <20250128111059.1690113-2-quic_rdevanat@quicinc.com>
 <904c2c6e-c21b-4718-b60e-c29c60d80aa2@oss.qualcomm.com>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <904c2c6e-c21b-4718-b60e-c29c60d80aa2@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oYF0koWcutZZu6KspbD6o19Eol1ggQiH
X-Proofpoint-GUID: oYF0koWcutZZu6KspbD6o19Eol1ggQiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300046



On 1/30/2025 7:01 AM, Jeff Johnson wrote:
> On 1/28/2025 3:10 AM, Roopni Devanathan wrote:
> ...
>> +struct wmi_max_reg_power_allowed_params {
> 
> this seems to be misnamed. per the wmi naming convention _params are structs
> passed from firmware. you cannot pass a pointer to an array from firmware to
> host, you can only pass the array contents. hence seems this is a host-only
> struct and should be named _arg
> 
>> +	struct wmi_max_reg_power_fixed_params tpc_reg_pwr;
>> +	s16 *reg_pwr_array;
>> +};
>> +
>> +struct wmi_tpc_rates_array_fixed_params {
>> +	__le32 rate_array_type;
>> +	__le32 rate_array_len;
>> +} __packed;
>> +
>> +struct wmi_tpc_rates_array_params {
> 
> again seems this should be _arg
> 
>> +	struct wmi_tpc_rates_array_fixed_params tpc_rates_array;
>> +	s16 *rate_array;
>> +};
>> +
>> +struct wmi_tpc_ctl_pwr_fixed_params {
>> +	__le32 ctl_array_type;
>> +	__le32 ctl_array_len;
>> +	__le32 end_of_ctl_pwr;
>> +	__le32 ctl_pwr_count;
>> +	__le32 d1;
>> +	__le32 d2;
>> +	__le32 d3;
>> +	__le32 d4;
>> +} __packed;
>> +
>> +struct wmi_tpc_ctl_pwr_table_params {
> 
> again seems this should be _arg
> 
>> +	struct wmi_tpc_ctl_pwr_fixed_params tpc_ctl_pwr;
>> +	s8 *ctl_pwr_table;
>> +};
>> +
>> +struct wmi_tpc_stats_info {
> 
> same here
> 
>> +	u32 pdev_id;
>> +	u32 event_count;
>> +	u32 end_of_event;
>> +	u32 tlvs_rcvd;
>> +	struct wmi_max_reg_power_allowed_params max_reg_allowed_power;
>> +	struct wmi_tpc_rates_array_params rates_array1;
>> +	struct wmi_tpc_rates_array_params rates_array2;
>> +	struct wmi_tpc_config_params tpc_config;
>> +	struct wmi_tpc_ctl_pwr_table_params ctl_array;
>> +};
> 
> reminder from the top of the file:
> /* Naming conventions for structures:
>  *
>  * _cmd means that this is a firmware command sent from host to firmware.
>  *
>  * _event means that this is a firmware event sent from firmware to host
>  *
>  * _params is a structure which is embedded either into _cmd or _event (or
>  * both), it is not sent individually.
>  *
>  * _arg is used inside the host, the firmware does not see that at all.
>  */
> 
> 
Thanks for clarifying Jeff. I've sent a v6 addressing all these comments.

- Roopni.

