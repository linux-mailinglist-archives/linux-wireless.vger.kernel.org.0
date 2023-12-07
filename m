Return-Path: <linux-wireless+bounces-525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE0A807F2C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 04:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8D11C20A37
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 03:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B174C7D;
	Thu,  7 Dec 2023 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EqB2DJHl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1961AD62
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 19:31:54 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6MTOv8032380;
	Thu, 7 Dec 2023 03:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zIA+ZnNaGmgLnZm9jrOoD4FcK/drU2Lm16D28iGXia4=;
 b=EqB2DJHl3qy//yNYzi4TCKSDfM2CLxBRUxLKtbRBFocapdYS9SOCiZkyT7TIxgdmNhak
 Hm8B9Oydi29zAJI5vU3XXnPK4HeMTawPDWu9ErYTjiHatXfnYpZ7rQBBs8YbNodwUn/z
 yW7quXNUC4Mxw9ElkloikmG9DeQXcs8e7JvfdqPjaX/zMNwLAEp/BZlBsd2Pslv+vjhp
 i5P/n/Y5Vda1bH2UET5xqGpdK/bNqu5hBnIhnl+VbRZv9odk88ey7LQQy8KJILddW/go
 xx5GpD2b5yF3cRDhtnDVJwRKijurT09zUQOnYSHxZHuKaQ4AAuQFsAMc5ej2KebmiFpc ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utrwq20cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 03:31:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B73Voq3005712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Dec 2023 03:31:50 GMT
Received: from [10.216.30.117] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 19:31:49 -0800
Message-ID: <189b7768-4783-48e9-9a3d-a986b70a2508@quicinc.com>
Date: Thu, 7 Dec 2023 09:01:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/12] wifi: ath11k: discard BSS_CHANGED_TXPOWER when
 EXT_TPC_REG_SUPPORT for 6 GHz
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
 <20231204081323.5582-13-quic_bqiang@quicinc.com>
 <33d629b1-674e-42c1-8969-18fa636d370c@quicinc.com>
 <2337a414-4aa2-47ad-8cc4-a631de15ea6f@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <2337a414-4aa2-47ad-8cc4-a631de15ea6f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: toB7FczcEyzUP4YmLTo_vocQuwRlTUi4
X-Proofpoint-GUID: toB7FczcEyzUP4YmLTo_vocQuwRlTUi4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_22,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070027

On 12/6/23 11:04, Baochen Qiang wrote:
> 
> 
> On 12/4/2023 11:53 PM, Aditya Kumar Singh wrote:
>> On 12/4/23 13:43, Baochen Qiang wrote:
>>> From: Wen Gong <quic_wgong@quicinc.com>
>>>
>>> When station is connected to a 6 GHz AP, it has 2 ways to configure
>>> the power limit to firmware. The first way is to send 2 WMI commands
>>> WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G to
>>> firmware, the second way is to send WMI_VDEV_SET_TPC_POWER_CMDID to
>>> firmware which include more parameters for power control.
>>>
>>> When firmware support SERVICE_EXT_TPC_REG, it means firmware support
>>> the second way for WMI_VDEV_SET_TPC_POWER_CMDID, then ath11k discard
>>> BSS_CHANGED_TXPOWER flag from mac80211 which is used to the first way
>>> for 6 GHz band and select the second way.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI 
>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>>>
>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>> ---
>> ...snip...
>>> @@ -3596,9 +3608,13 @@ static void 
>>> ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>>>       if (changed & BSS_CHANGED_TXPOWER) {
>>>           ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev_id %i txpower %d\n",
>>>                  arvif->vdev_id, info->txpower);
>>> -
>>> -        arvif->txpower = info->txpower;
>>> -        ath11k_mac_txpower_recalc(ar);
>>> +        if (ath11k_mac_supports_station_tpc(ar, arvif, 
>>> &info->chandef)) {
>>> +            ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
>>> +                   "discard tx power, change to set TPC power\n");
>>> +        } else {
>>> +            arvif->txpower = info->txpower;
>>> +            ath11k_mac_txpower_recalc(ar);
>>> +        }
>>
>> Could you check v6 once? I remember Wen told he would drop this check 
>> and let FW take the min value. If we do like this, then user could not 
>> set his own desired value even if that is well inside the reg limits.
> I did notice this comment in V6, but came out of a different opinion: it 
> is OK to discard the TX power here, because that will be sent to 
> firmware using WMI_VDEV_SET_TPC_POWER_CMDID command in another patch. 
> Please correct me if wrong.
Yeah that is correct but applies only during initial bring up. What if 
after client gets connected and user still wants to lower power level by 
giving command "iw wlanX set txpower fixed 1000" something like this? 
This time again it will be ignored but it won't be sent to FW.


