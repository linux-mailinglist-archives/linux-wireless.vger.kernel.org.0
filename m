Return-Path: <linux-wireless+bounces-1741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89EE82B370
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0754B2566C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4D51C27;
	Thu, 11 Jan 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KAlwe+tq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8DF5102C
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BFnu8T032399;
	Thu, 11 Jan 2024 16:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N2sNZB4cSpH6FgygB6WuO8GBPp0dxDrjlQD69HUYZZ0=; b=KA
	lwe+tq0wkTqq1IMELKwFHsexAhn1CTQ5Oegd6Shfo9gmx/xaEdpWvH7n2sNkfaFX
	fRnHfsrzEo8I6zlb7uWvCqBvvx7qP/b0zhwgei7G4xez79p5f92OOp+8ZijjG3+U
	2b5ubk1UxlxqqiGV/opU5fFskL8tYHNhQLlkDNkIokf3WQ+UrPrsjGGpFbteTPfd
	AbCTzx/KUF8AMt1pdkpcaSIx1b28FCwfUZDunyMkIoRkyNQ6AaRKDkJTNVrgE/u6
	CcUP9nq0q7j00aEar4u6Ajx5eaAOu7mVeHPYYvpfcSxCHaaOheTuI6y2sMpOAgRW
	w1WRFmuEIGrQVSxPHt6g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjcsk15fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:55:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BGtmq8024190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:55:48 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 08:55:48 -0800
Message-ID: <f4ef8b0c-e2ee-4ced-b00a-8e58fc77ded4@quicinc.com>
Date: Thu, 11 Jan 2024 08:55:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: add processing for TWT enable event
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Lingbo Kong <quic_lingbok@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240103050926.14115-2-quic_lingbok@quicinc.com>
 <170498978118.916301.14993323516499040896.kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <170498978118.916301.14993323516499040896.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wQH5HAMJSCX9ojm-UYRyW_9_taw2GgzE
X-Proofpoint-GUID: wQH5HAMJSCX9ojm-UYRyW_9_taw2GgzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 mlxlogscore=859 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110132

On 1/11/2024 8:16 AM, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> wrote:
> 
>> When ath12k send TWT enable command to firmware, firmware will return a TWT
>> enable event to ath12k. Through the analysis of TWT enable event status, we
>> can easily obtain the status of TWT enable command. It can be more
>> convenient to debug TWT.
>>
>> This patch works with WCN7850 and QCN9274.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Fails to compile:
> 
> drivers/net/wireless/ath/ath12k/wmi.c: In function 'ath12k_wmi_twt_enable_event':
> drivers/net/wireless/ath/ath12k/wmi.c:6675:48: error: passing argument 2 of 'ath12k_wmi_tlv_parse_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
>  6675 |         tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
>       |                                             ~~~^~~~~~
>       |                                                |
>       |                                                unsigned char *
> drivers/net/wireless/ath/ath12k/wmi.c:367:44: note: expected 'struct sk_buff *' but argument is of type 'unsigned char *'
>   367 |                            struct sk_buff *skb, gfp_t gfp)
>       |                            ~~~~~~~~~~~~~~~~^~~
> drivers/net/wireless/ath/ath12k/wmi.c:6675:14: error: too many arguments to function 'ath12k_wmi_tlv_parse_alloc'
>  6675 |         tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
>       |              ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wmi.c:366:1: note: declared here
>   366 | ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wmi.c: In function 'ath12k_wmi_twt_disable_event':
> drivers/net/wireless/ath/ath12k/wmi.c:6704:48: error: passing argument 2 of 'ath12k_wmi_tlv_parse_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
>  6704 |         tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
>       |                                             ~~~^~~~~~
>       |                                                |
>       |                                                unsigned char *
> drivers/net/wireless/ath/ath12k/wmi.c:367:44: note: expected 'struct sk_buff *' but argument is of type 'unsigned char *'
>   367 |                            struct sk_buff *skb, gfp_t gfp)
>       |                            ~~~~~~~~~~~~~~~~^~~
> drivers/net/wireless/ath/ath12k/wmi.c:6704:14: error: too many arguments to function 'ath12k_wmi_tlv_parse_alloc'
>  6704 |         tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
>       |              ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wmi.c:366:1: note: declared here
>   366 | ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[7]: *** [scripts/Makefile.build:243: drivers/net/wireless/ath/ath12k/wmi.o] Error 1
> make[7]: *** Waiting for unfinished jobs....
> make[6]: *** [scripts/Makefile.build:480: drivers/net/wireless/ath/ath12k] Error 2
> make[5]: *** [scripts/Makefile.build:480: drivers/net/wireless/ath] Error 2
> make[4]: *** [scripts/Makefile.build:480: drivers/net/wireless] Error 2
> make[3]: *** [scripts/Makefile.build:480: drivers/net] Error 2
> make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
> make[1]: *** [/home/kvalo/projects/atheros/ath10k/src/ath/Makefile:1911: .] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
> 
> 2 patches set to Changes Requested.
> 
> 13509671 [1/2] wifi: ath12k: add processing for TWT enable event
> 13509673 [2/2] wifi: ath12k: add processing for TWT disable event
> 

This became a victim of the interface change in:
wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()

