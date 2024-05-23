Return-Path: <linux-wireless+bounces-8012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29948CD559
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FF0280D15
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7A13B598;
	Thu, 23 May 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h0TqvFsA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BF1DFF0
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473100; cv=none; b=IAmyTp4rGOljyF0hiZ8UM0SvY/Xi0/TjYrLN9ABBvFy4Uvq3RnVTq1rR2Vxr3mmtLJxxGbLMStqG1QKihuoV5cAyqQDFiN96O0NbQ2q21T0iC8pnBdQSG4Z0nhVWSEhcmLhcWT7GKQVuTTMufZfVwhCXTiWW8laGn5hbqBEb1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473100; c=relaxed/simple;
	bh=0nVpjDayFvrV1pIG9y2HvOZU9Anezo1AbTe9rkbI810=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j4qEcmbYui0d6dup1txbhlg0AsnmOaHIHDKoUPcU4q699OgcTAYt9PFqWPmLCRQOfBcLCgNGGkljItcO9iJgei2QwPUOUaLnHgBl3ew8qQXL8A5by2P1R6AmZCoTZNjKz61CQKuoyavbBcgl74WTLRmJqRgAX7iUgA4UD/aqBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h0TqvFsA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NDn6Sp011549;
	Thu, 23 May 2024 14:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Xlb2wwmDklI9uhQ1sPkNoPtuaycQHaLukA2sibm1Qw=; b=h0TqvFsAqDZUBnJA
	b5+ge57acrUGQVZdhqSNQNEHZh/vh/lHGu47CmM6MxhfSg3+1JHh058MuxlFCifp
	Hsh3sSE9zjgRfi21s8ce9zTI15jmlkmbh9xCf0fneMk9O9ehfhuQxAp0Tj9g5lh0
	OiWdSHH/svTHI3ysJY8H0ZGzx0Utj/+/UQIvWFTCAFtKesLA8wMnLx0ERwB2lZhX
	fDrfaMhaHt0hhyTTWqI2OvOtEJ7BtrxCBoi11wgnv4pFcRlKHqLK6u1pphds7hP9
	eLoh0aTodQdUmRCR8rZ1X0NKOrsrX/BW+QXPlOz1Vf0oq6MFlXh+RTs0aE90EMDz
	4fyvgQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y9y29s9q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 14:04:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44NE4eBg000917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 14:04:40 GMT
Received: from [10.111.164.21] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 07:04:37 -0700
Message-ID: <ca9a3b1e-b115-4b28-b0fc-909baab5fdc4@quicinc.com>
Date: Thu, 23 May 2024 22:04:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] wifi: ath12k: Fix Pdev id in HTT stats request for
 WCN7850
To: Kalle Valo <kvalo@kernel.org>
CC: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
 <20240510050806.514126-4-quic_rgnanase@quicinc.com>
 <87pltfd2bt.fsf@kernel.org>
 <667cea80-9b62-4ca4-9d28-c5940582832a@quicinc.com>
 <87ed9sbscj.fsf@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <87ed9sbscj.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2tHz9MzBEA0vVE2OZ4na2iwiP_x6LNDw
X-Proofpoint-GUID: 2tHz9MzBEA0vVE2OZ4na2iwiP_x6LNDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_09,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=744
 mlxscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405230097



On 2024/5/23 20:55, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> writes:
> 
>>>> +struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k_base *ab)
>>>> +{
>>>> +	struct ath12k *ar;
>>>> +	struct ath12k_pdev *pdev;
>>>> +	struct ath12k_vif *arvif;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < ab->num_radios; i++) {
>>>> +		pdev = &ab->pdevs[i];
>>>> +		ar = pdev->ar;
>>>> +		list_for_each_entry(arvif, &ar->arvifs, list) {
>>>> +			if (arvif->is_up)
>>>> +				return arvif;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return NULL;
>>>> +}
>>> I'm not seeing any protection here, is that on purpose?
>>
>> you means there need to add lockdep_assert_held(&ar->conf_mutex)?
> 
> I mean what's the locking design here? Is it safe to concurrectly access
> ab->pdevs and arvif->is_up?
> 

oh, i've seen other places use ar->conf_mutex to protect when accessing 
arvif->is_up.

but according to the ath12k_mac_get_vif_up()'s call stack, the 
ath12k_write_htt_stats_reset() and ath12k_open_htt_stats() have already 
executed mutex_lock(&ar->conf_mutex);

so it's best to add lockdep_assert_held(&ar->conf_mutex) here to 
determine whether conf_mutex is obtained.

/lingbo kong

