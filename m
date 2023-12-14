Return-Path: <linux-wireless+bounces-781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D4181296F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 08:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4F0B20EFC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065A12E55;
	Thu, 14 Dec 2023 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Iv5JI9jN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0A18C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 23:34:13 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE54GG2012592;
	Thu, 14 Dec 2023 07:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Hn+spIbd9aUAVB0KRnUceRZGeqIDqFs4ZAfE9Wz0RPo=; b=Iv
	5JI9jNVwU/QjX0iEudmImaSb3fhGb9+dG+NVFahqaqhxGlSH+1RLlTuo99DUhCag
	r7wnBZLE9e4lHJTCEuKBR9FWJYnfj/iRdj07dZ2JILq1Hfc8fEzsuhwW+b/gYrcG
	FCvS+6bxX4Sw6jNjcEPsPwLekpTvBFGhymq8S/tMQsHzFLKP0+tTGg6QHRvrZBMF
	aYIEzCz+MxlB9gJDOjXFlO/m4/XoBDaWRhkoMahzM87qZ2A4WjXPqXaOWINUJcvE
	rrWhSwBXJIS5kiEj+3bXEHIFk18pOgEWbu6OGgRgzSE2I2c00vL2FY8JfRmQXH+P
	ZCy1cAN1vvj5TBDiV1tA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyqgt0p5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 07:34:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE7Y589002407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 07:34:05 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 23:34:04 -0800
Message-ID: <3a0855a7-f256-4f92-97d9-7a3308c5a69f@quicinc.com>
Date: Thu, 14 Dec 2023 13:04:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/12] wifi: ath11k: update regulatory rules when
 interface added
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231211062216.382164-1-quic_bqiang@quicinc.com>
 <20231211062216.382164-5-quic_bqiang@quicinc.com>
 <87882ad2-496b-4e7d-80d1-39d121f04ca3@quicinc.com>
 <e4e7ab59-8df8-4aa7-bc84-e8aca8aa3ce1@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <e4e7ab59-8df8-4aa7-bc84-e8aca8aa3ce1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mRyRQ_6u4tEijewE-c3rQtMaJz8ZJ2hU
X-Proofpoint-ORIG-GUID: mRyRQ_6u4tEijewE-c3rQtMaJz8ZJ2hU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140047

On 12/14/23 12:39, Baochen Qiang wrote:
> 
> 
> On 12/12/2023 1:20 AM, Aditya Kumar Singh wrote:
>> On 12/11/23 11:52, Baochen Qiang wrote:
>>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c 
>>> b/drivers/net/wireless/ath/ath11k/mac.c
>>> index 7f7b39817773..1e314fcab41b 100644
>>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>>> @@ -6943,6 +6943,14 @@ static int ath11k_mac_op_add_interface(struct 
>>> ieee80211_hw *hw,
>>>                       ret);
>>>       }
>>> +    if (ath11k_wmi_supports_6ghz_cc_ext(ar)) {
>>> +        struct cur_regulatory_info *reg_info;
>>> +
>>> +        reg_info = &ab->reg_info_store[ar->pdev_idx];
>>> +        ath11k_dbg(ab, ATH11K_DBG_MAC, "mac interface added to 
>>> change reg rules\n");
>>> +        ath11k_reg_handle_chan_list(ab, reg_info, 
>>> IEEE80211_REG_LPI_AP);
>>> +    }
>>> +
>> So we update the rules by default for AP. Then in next patch 5/12, 
>> once STA connects to AP, we put the proper power mode and refresh the 
>> rules.
>>
>> So if user wants to bring up 1 STA interface alone, in total 3 
>> regulatory updates will happen from driver to upper layer -
>> 1. During initial boot time
>> 2. During interface create time (above hunk)
>> 3. During channel context assignment (5/12 patch)
>>
>> Does this seem good? 3 times we would be changing regulatory rules and 
>> first 2 times we are doing the same thing.
> No, the first two times are not the same: as mentioned in the commit 
> log, at the first time when boot up, interface mode is not determined, 
> so the argument vdev_type is 0 when calling ath11k_reg_build_regd(), as 
> a result AP reg info is chosen. And for the second time, here when 
> adding interface, we know exactly the interface type, say a STA, 
> vdev_type is 2 when calling ath11k_reg_build_regd(), resulting in that 
> client reg info is chosen. see the changes to ath11k_reg_build_regd() in 
> patch 1/12.

Ah I see, sorry got confused a bit. Correct, it is different, but still 
updating 3 times, is it good? Just ponder once, otherwise fine.



