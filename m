Return-Path: <linux-wireless+bounces-613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7880BF10
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 03:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BC71F20D38
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 02:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BC0EAC9;
	Mon, 11 Dec 2023 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p3wwrV88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EEBD
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 18:26:10 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB1pJFS027756;
	Mon, 11 Dec 2023 02:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iQ5X4DUNJe0BI6nqEp4pBb9gnbMu/M+dpl7v2q5uUNg=; b=p3
	wwrV889jcshXc8KgKWH3NFQEwRfTsFoBYWnntG3D3rC5MAkxCBo/i3LpRQJXzXln
	IGTRu0S6eXptmeBqzLLl2ZQouuA1pimpRF4nQWMImCkiZJLvBRyn0961xi4k/4+8
	zg1l7D1FELEFM8F00+VPJL6xz7sC5a69xyG5mJL78FZ/3T0VtGAQDCja01jYkqyw
	WMJpMkMHrd6gEfWeE6sDK/GkL+Uvuz5SudrWeEVV1mRgrlYebdDtN9LneZF4Psn6
	yWMETyR8AH3On7rjI1m0Vw8IxeUhJhA4Fd1nYgcWGw04BF9vl9MHy8XyUI3gbOSo
	B/zbsjNO0JOo6Vc8K2zw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnuvj3a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 02:26:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB2Q5Vq032330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 02:26:05 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Dec
 2023 18:26:03 -0800
Message-ID: <06123d7c-8f70-4ab7-8e0d-e308caa612ec@quicinc.com>
Date: Mon, 11 Dec 2023 10:26:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/12] wifi: ath11k: discard BSS_CHANGED_TXPOWER when
 EXT_TPC_REG_SUPPORT for 6 GHz
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
 <20231204081323.5582-13-quic_bqiang@quicinc.com>
 <33d629b1-674e-42c1-8969-18fa636d370c@quicinc.com>
 <2337a414-4aa2-47ad-8cc4-a631de15ea6f@quicinc.com>
 <189b7768-4783-48e9-9a3d-a986b70a2508@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <189b7768-4783-48e9-9a3d-a986b70a2508@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U1KWPVRpuViI9vwSNLC_8BOp91i9-7QF
X-Proofpoint-ORIG-GUID: U1KWPVRpuViI9vwSNLC_8BOp91i9-7QF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110019



On 12/7/2023 11:31 AM, Aditya Kumar Singh wrote:
> On 12/6/23 11:04, Baochen Qiang wrote:
>>
>>
>> On 12/4/2023 11:53 PM, Aditya Kumar Singh wrote:
>>> On 12/4/23 13:43, Baochen Qiang wrote:
>>>> From: Wen Gong <quic_wgong@quicinc.com>
>>>>
>>>> When station is connected to a 6 GHz AP, it has 2 ways to configure
>>>> the power limit to firmware. The first way is to send 2 WMI commands
>>>> WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G to
>>>> firmware, the second way is to send WMI_VDEV_SET_TPC_POWER_CMDID to
>>>> firmware which include more parameters for power control.
>>>>
>>>> When firmware support SERVICE_EXT_TPC_REG, it means firmware support
>>>> the second way for WMI_VDEV_SET_TPC_POWER_CMDID, then ath11k discard
>>>> BSS_CHANGED_TXPOWER flag from mac80211 which is used to the first way
>>>> for 6 GHz band and select the second way.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI 
>>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>>>>
>>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>>> ---
>>> ...snip...
>>>> @@ -3596,9 +3608,13 @@ static void 
>>>> ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>>>>       if (changed & BSS_CHANGED_TXPOWER) {
>>>>           ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev_id %i txpower %d\n",
>>>>                  arvif->vdev_id, info->txpower);
>>>> -
>>>> -        arvif->txpower = info->txpower;
>>>> -        ath11k_mac_txpower_recalc(ar);
>>>> +        if (ath11k_mac_supports_station_tpc(ar, arvif, 
>>>> &info->chandef)) {
>>>> +            ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
>>>> +                   "discard tx power, change to set TPC power\n");
>>>> +        } else {
>>>> +            arvif->txpower = info->txpower;
>>>> +            ath11k_mac_txpower_recalc(ar);
>>>> +        }
>>>
>>> Could you check v6 once? I remember Wen told he would drop this check 
>>> and let FW take the min value. If we do like this, then user could 
>>> not set his own desired value even if that is well inside the reg 
>>> limits.
>> I did notice this comment in V6, but came out of a different opinion: 
>> it is OK to discard the TX power here, because that will be sent to 
>> firmware using WMI_VDEV_SET_TPC_POWER_CMDID command in another patch. 
>> Please correct me if wrong.
> Yeah that is correct but applies only during initial bring up. What if 
> after client gets connected and user still wants to lower power level by 
> giving command "iw wlanX set txpower fixed 1000" something like this? 
> This time again it will be ignored but it won't be sent to FW.
Exactly, will drop this patch in V9.
> 

