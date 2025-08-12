Return-Path: <linux-wireless+bounces-26283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1549B21A94
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 04:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249311A26089
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 02:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6151218B47E;
	Tue, 12 Aug 2025 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J/VQYsfc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EE2D9ED9
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964276; cv=none; b=O/BH+E5Jxh3QBfsTW1R5NqgjfgkMSOvFNzD0vcNfiK58JI+5TiqGi70pBZkcL+NZoSuw/sPSFsNV8FzmjmJCwSW4aWYAeaN9Pnl+lYez1AMZCzbTBjjYkJ9TVLJsx394rXc2zZVCrU4jNLeidhn/ngBFSBYBzckLHbVTsDh6trA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964276; c=relaxed/simple;
	bh=I1HeNmR6KnNPwo8c6QEkiYQjP3cFLFeVjp9byzuRAn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pc10fa+l+jrQgg2XN4ulqXtV8lPOcyVjPlGA236AC1Ou5zMW/Rs/uGuH4ChrTcppjjLhel7ffOb+F13zJG9xFOeAolJFJYCRvzgpS/Fzl2loqXYccT83ih5vdbA9vrDzdipKSuJxWomfhNCi7xBjkiBm6hsKVfl/WVvb2k802Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J/VQYsfc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BJVY5q008265;
	Tue, 12 Aug 2025 02:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V+Xy4vrZmdYH3GIE79frPRqd0RIJm1rM+/odVc2an3E=; b=J/VQYsfcydaUuxrW
	vx96qdb3MSthYusc8uZNN/byEmYcr2Dgjp8pmfjQQ13m/36It8k7RIqv5abXoaYI
	Z0hGT0iQtagYjsVdLvTJuXCFNmS/Dvhw67nAHo9bSD/4sUq5+K5S/lNyVRBPe6Yx
	EQry1ZS1eBznkF7+jKoFvhN2vvsaM3p00Ent1oX2ihb7r9Px0SUqIh2XwqhVllt8
	eF9yuJHCB4vuZK6zker2xYLhKlzr10ckbSfa83HLymqADmPZWEdIWg4p5Eewf0wC
	XylzELcKgwwIC0MO2NQ05A71Os5wNktcxwb7vq1dcG5Dss/0AU3/9i9fDrU7Xy5Q
	ZhfQGQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjj8k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 02:04:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57C24TTl023406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 02:04:29 GMT
Received: from [10.133.33.20] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 11 Aug
 2025 19:04:28 -0700
Message-ID: <7b6f4d83-f068-4fd2-afd1-214255bbfc72@quicinc.com>
Date: Tue, 12 Aug 2025 10:04:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: report station mode per-chain
 signal strength
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250811112132.48946-1-quic_lingbok@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <20250811112132.48946-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX92+SVaQwXXPC
 zikLlto9pLvsXc/JOIbDvhdSOXOZ0gWwj1lE87D9utLUsu6IMPy3XFmwLNPNQMCjEVvqgbOYSnJ
 jX391RwdnekHS196BtKuoIJ03ZJ15mHJpND/Fa+KbmWe4EOCNJIpp+LUi3MS+InYcMZMUyfbyIp
 zItKS7eH5PUozCWeptsOUDSqS8vcwu7IP9FSHb+Z6ENWa1rbIJeWQFF1xev8VToFsutLJypfkrK
 DZCCTOTqwyHMac65fQbZ64DG5Plwf7FY21vQ2u1jDcx1sXSK7qSXJtl7TK9GKTz/N7qv7vVCQwR
 T8gM85+eW6Yd9+tn4nfCDoIPyBM2HgIfr4lVTOlCMow3YrbgPwrnz92aCkkAST5OwDntfYP/+nQ
 YWTYrdU0
X-Proofpoint-GUID: Se2B-9i0U0VjjvpLva9hjOh_HwV1RGtL
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689aa12e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=pN-lpjZd9i1dOjWOSwIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Se2B-9i0U0VjjvpLva9hjOh_HwV1RGtL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

please ignore this patch.

/lingbo
On 2025/8/11 19:21, Lingbo Kong wrote:
> Currently, command “iw wlan0 station dump” does not show per-chain signal
> strength.
> 
> This is because ath12k does not handle the num_per_chain_rssi and
> rssi_avg_beacon reported by firmware to ath12k.
> 
> To address this, update ath12k to send WMI_REQUEST_STATS_CMDID with the
> flag WMI_REQUEST_RSSI_PER_CHAIN_STAT to the firmware. Then, add logic to
> handle num_per_chain_rssi and rssi_avg_beacon in the
> ath12k_wmi_tlv_fw_stats_parse(), and assign the resulting per-chain signal
> strength to the chain_signal of struct station_info.
> 
> After that, "iw dev xxx station dump" shows the correct per-chain signal
> strength.
> Such as:
> 
> Station AA:BB:CC:DD:EE:FF (on wlan0)
>          inactive time:  212 ms
>          rx bytes:       10398
>          rx packets:     64
>          tx bytes:       4362
>          tx packets:     33
>          tx retries:     49
>          tx failed:      0
>          beacon loss:    0
>          beacon rx:      14
>          rx drop misc:   16
>          signal:         -45 [-51, -46] dBm
>          beacon signal avg:      -44 dBm
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219751
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
> v3:



