Return-Path: <linux-wireless+bounces-27983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC7BDFCFB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 19:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F25E1882EB9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901EA25333F;
	Wed, 15 Oct 2025 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ANUouhWa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7F1494D9
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548141; cv=none; b=QiXzdt6iGGgqYy4qMVkHFNyXaBikSMVmeBIqUSoJDD0Dp46s779Opu3206eo0mBa6+jAsfL2hF7MjSm0RPGT3QTFYaBQxsz1OImdwcvVr8LnKodhWU5MRmVly7UCcVsByACXr+iis5niikEdKiTa0mTIbkEvkzJJEz89bkBS8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548141; c=relaxed/simple;
	bh=yVHXTW0ufUh2VVNco5sropUrwwZSmW/dhlTgGamWo0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PrM5CoY1YJ0dBlMEsfFz+rOcgr9pSCY9CQOQm3yDTC2/TWLr/Sf035OSskM+9CGcIEe++2jQo4WEqxvcAqB42uWLFwYJyoajUZwJ3K5yerYnIPqjdCxEJTensFYQva8x95qt7cuDa0A8W0wbS6mH/Zk6QDryKuyCMhKlHpV6S/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ANUouhWa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAkmJx003752;
	Wed, 15 Oct 2025 17:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L0mSoRlLpDaN40s5WNZ83ZoT5qkolaF4K9pWwpg/NKk=; b=ANUouhWakYUuGMke
	38gy3J0r9j/zF2i1MLgeN8X5tO95j10UMwrJi4gITCXs1brfEhmeN8hifJfSnkpG
	YY9i9RWXewJ9SpY6QmbKNEsEIVnFjiqOtIueawPUiy7/rjHz/smbjmEW0yOlg+LY
	q3ISTfSGAxnXz3uzwtsfTTg0rZJC8ZTUzOgY2XIJJKD5wKLIOrfkXVtQRf5o7Wsc
	MfziwIdnlbhzBDb/Ih3zhm+gwcUG7h5wfYi1NL/E6TYsAt4+AsrSceP4gksHbVXt
	jVXv1NBAOljqmY8Oi5Q6A9kRoHe34r8Up0fY+PKjvzcws9532w4iIrtnNhKAYLOs
	ShWjCA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd95ce2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 17:08:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59FH8tGa028226
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 17:08:55 GMT
Received: from [10.216.18.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 15 Oct
 2025 10:08:53 -0700
Message-ID: <76d00875-6275-bff8-dedf-597290aa4d93@quicinc.com>
Date: Wed, 15 Oct 2025 22:38:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next V17 0/2] wifi: ath12k: fix TX and RX MCS
 configurations in VHT and HE modes
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
References: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fJ__42HrfLJH4aXil01pqQZhNIF6-R7h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX1OBW+o6iHgU4
 8mIreZsEL148sLh2YdrIjYfC4n2XkA5YxgCnVZD9Wa51PhV+xtw/OPaRwqmlkHu7AYzjJ+0ptq1
 aXRuiycLRDtkxIfaAEQjwUdHzXzs1mZxZezau8UM2Vv3eIRTwbCFYvfTutxy+nQmdnAhn+JE6de
 4mX/gh+c+RK4szmcZ7OOvoqtrguI82WqWBhB5uRU/mKMjJyjjdtgF506W/zFVtIdIh6CrNFxO5x
 4+svckzRAQwM/i/XW0JxEJstgipPcyXxprA5miSMJocJ2/c6kBQR32YTQ72qa/58zyxgRH25zfz
 7jpj/Mq5C1Tqi3fvld7wNQcCuHvqP6bIL8hEfUPefajRvTqXwTYqNTv428S7ez3zJl7/wI4n3hd
 INQWhlia/UvPN3gDD0oRBvFLhMoF6A==
X-Proofpoint-GUID: fJ__42HrfLJH4aXil01pqQZhNIF6-R7h
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68efd528 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=D1uBF46WTLVnaS-LX8QA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/10/2025 2:46 AM, Pradeep Kumar Chitrapu wrote:
> This is revision version for patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/
> 
> changes in v17:
>   - fix spelling in description.
>   - change wmi.c wmi.h copy right per guidelines.
>   - fix missing recalculation of v for TX MCS 160 in patch 2/2.
> 
> changes in v16:
>   - remove patches in series which hare accepted already
>     https://patchwork.kernel.org/project/linux-wireless/list/?series=977538&state=*
>   - Fix review comment on last revision https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/
>   - Add similar VHT related changes into separate patch.
> 
> Baochen Qiang (1):
>    wifi: ath12k: fix VHT MCS assignment
> 
> Pradeep Kumar Chitrapu (1):
>    wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 12 +++++-------
>   drivers/net/wireless/ath/ath12k/wmi.c | 11 +++++++----
>   drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
>   3 files changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

