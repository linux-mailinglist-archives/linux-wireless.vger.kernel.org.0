Return-Path: <linux-wireless+bounces-379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998DE80393B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 16:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536B6281066
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD352D036;
	Mon,  4 Dec 2023 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HQWXCafp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F7A4
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 07:53:28 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4BwXhd013443;
	Mon, 4 Dec 2023 15:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PgI9mC5H4unxLeCAaapB8iuEQRGbVrHuq+A9Bd3ltpU=;
 b=HQWXCafpeNcBAdKQRzDzfoKzH050v2dyyi7ZGARsCLmxb7lEhObf6ukbXahj3YQ0mq1h
 UUgSpibPlfvpBXcd6BORTpvmYEcOC4hbpyf4ICZKmqqxqNLqifJfQM2fvaf1kS3X5sy7
 SMMFsU40a1ph/aJEQKJJjvBVxFKDM7LpeVtPJUjsi57RyNTcO9joxvonV8CpDi8tjahs
 hnV0lhf3NGiZTsbdLQMLlGNO9nSABYMA/z11jCiaw72PtOOMWrz+6viN9Ss9K7YP5PLi
 ZgVS0TjS78iCOFCAdznV5kW+8yHXt94IU6JsnL1NO0lR1h36mVEi5kg0xT2cWJYYJCJ5 pw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usdfwgrrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 15:53:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4FrLTH029988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Dec 2023 15:53:21 GMT
Received: from [10.216.6.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 07:53:19 -0800
Message-ID: <33d629b1-674e-42c1-8969-18fa636d370c@quicinc.com>
Date: Mon, 4 Dec 2023 21:23:15 +0530
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
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
 <20231204081323.5582-13-quic_bqiang@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20231204081323.5582-13-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wOhkx1WRsm_FxJTKdwoN9YvnD5mhJB72
X-Proofpoint-ORIG-GUID: wOhkx1WRsm_FxJTKdwoN9YvnD5mhJB72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_15,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040120

On 12/4/23 13:43, Baochen Qiang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> When station is connected to a 6 GHz AP, it has 2 ways to configure
> the power limit to firmware. The first way is to send 2 WMI commands
> WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G to
> firmware, the second way is to send WMI_VDEV_SET_TPC_POWER_CMDID to
> firmware which include more parameters for power control.
> 
> When firmware support SERVICE_EXT_TPC_REG, it means firmware support
> the second way for WMI_VDEV_SET_TPC_POWER_CMDID, then ath11k discard
> BSS_CHANGED_TXPOWER flag from mac80211 which is used to the first way
> for 6 GHz band and select the second way.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
...snip...
> @@ -3596,9 +3608,13 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>   	if (changed & BSS_CHANGED_TXPOWER) {
>   		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev_id %i txpower %d\n",
>   			   arvif->vdev_id, info->txpower);
> -
> -		arvif->txpower = info->txpower;
> -		ath11k_mac_txpower_recalc(ar);
> +		if (ath11k_mac_supports_station_tpc(ar, arvif, &info->chandef)) {
> +			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
> +				   "discard tx power, change to set TPC power\n");
> +		} else {
> +			arvif->txpower = info->txpower;
> +			ath11k_mac_txpower_recalc(ar);
> +		}

Could you check v6 once? I remember Wen told he would drop this check 
and let FW take the min value. If we do like this, then user could not 
set his own desired value even if that is well inside the reg limits.


