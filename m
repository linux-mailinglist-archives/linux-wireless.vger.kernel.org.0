Return-Path: <linux-wireless+bounces-7056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582048B7B44
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E43B233D2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C6152799;
	Tue, 30 Apr 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BR6UIp7l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B412C491
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490068; cv=none; b=n/LPeNmPaCr5rfnPQD/2jqGDWxms706+R36NnYX1q1dxXZnM1Vs8SoS3rNCXIo8wagOhtsQL71wGJieNg93a73sa0OhV9SY1yl2QUBX5I/r5QhwPE3hJbeElSdjtHTmmitvminGaEMc3vfbR3Exz18swwkSjRtK1NegoknFA0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490068; c=relaxed/simple;
	bh=gxDUM0FdwmvoIw9hMFqq0Sj5yL40KzW7xYVp1TpmdQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V2g0Ly6CWtoUKc8dNtmdJrAh0E9+btjyJWIxGiJk047J1dIWt6CEjoJtUQR+1+UjCunptYzkwRYwnx+WAqC4wS//dQxYDsYFmP4FdBw0vd/n9U+Qqe4fJshmHpXd5gO2WszlHwM7dPO1QCDVRGnQAyVBhF+YdNJhEHIySSG0NnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BR6UIp7l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UBLMxa005772;
	Tue, 30 Apr 2024 15:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BovKqYsHOlN/fkcFtWHYlqka+3aJqkEDksOokCh45lk=; b=BR
	6UIp7lbR1KQMfhZi0aZL0FJ8e9ztQdBq1AzLJQ9MZ73aJKq6OduGePZZ8OTczBrX
	39q2PXnoo2zIGjyDIBktVAX/hiWklssTGdO15UnO9Q9ktuV43hXbMFXF3Me49Sv8
	aft7i+tliC5L0nZNYNbLKP44+bXqlFl7LaJSEfkfRuQPYoY475kSs1f6ILN4Z/ui
	S6Uvr+dPT4fhSxwMfuUIPWGblgwrrbIg0a2j3y0lRnQxEZtZEjZi/31OsxpLUV4m
	9z+/CmOiivBoeQQ9Hk5aC/bv2oSzyFr12uXnB14C/8yyFb3+UI3ySYTE9EeYZfGr
	Gal58iGUYUmnr6cy4Jmw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtyptgk4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 15:14:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UFEHeG012880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 15:14:17 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 08:14:17 -0700
Message-ID: <4f9abe89-a004-45e8-b369-5c2b39bff440@quicinc.com>
Date: Tue, 30 Apr 2024 08:14:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5] wifi: ath11k: skip status ring entry processing
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Venkateswara
 Naralasetty" <quic_vnaralas@quicinc.com>
References: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
 <35f114c4-1ff7-4a4b-aadf-ed147f19e170@quicinc.com>
 <87cyq7ota5.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87cyq7ota5.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IxOl8azAW5fZFLpzJN6DJ9ThyKNjs4Nl
X-Proofpoint-ORIG-GUID: IxOl8azAW5fZFLpzJN6DJ9ThyKNjs4Nl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=910
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300108

On 4/30/2024 6:48 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 4/29/2024 12:36 AM, Tamizh Chelvam Raja wrote:
>>
>>> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>>>
>>> If STATUS_BUFFER_DONE is not set for a monitor status ring entry,
>>> we don't process the status ring until STATUS_BUFFER_DONE set
>>> for that status ring entry.
>>>
>>> During LMAC reset it may happen that hardware will not write
>>> STATUS_BUFFER_DONE tlv in status buffer, in that case we end up
>>> waiting for STATUS_BUFFER_DONE leading to backpressure on monitor
>>> status ring.
>>>
>>> To fix the issue, when HP(Head Pointer) + 1 entry is peeked and if DMA
>>> is not done and if HP + 2 entry's DMA done is set,
>>> replenish HP + 1 entry and start processing in next interrupt.
>>> If HP + 2 entry's DMA done is not set, poll onto HP + 1 entry DMA
>>> done to be set.
>>>
>>> Also, during monitor attach HP points to the end of the ring and
>>> TP(Tail Pointer) points to the start of the ring.
>>> Using ath11k_hal_srng_src_peek() may result in processing invalid buffer
>>> for the very first interrupt. Since, HW starts writing buffer from TP.
>>>
>>> To avoid this issue call ath11k_hal_srng_src_next_peek() instead of
>>> calling ath11k_hal_srng_src_peek().
>>>
>>> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>>> Co-developed-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>>> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
>> however note...
>>
>>> +
>>> +				/* If done status is missing:
>>> +				 * 1. As per MAC team's suggestion,
>>> +				 *    when HP + 1 entry is peeked and if DMA
>>> +				 *    is not done and if HP + 2 entry's DMA done
>>> +				 *    is set. skip HP + 1 entry and
>>> +				 *    start processing in next interrupt.
>>> +				 * 2. If HP + 2 entry's DMA done is not set,
>>> +				 *    poll onto HP + 1 entry DMA done to be set.
>>> +				 *    Check status for same buffer for next time
>>> +				 *    dp_rx_mon_status_srng_process
>>> +				 */
>>> +
>>> + reap_status = ath11k_dp_rx_mon_handle_status_buf_done(ab, srng,
>>> + rx_ring);
>>
>> ath11k-check reports:
>>
>> drivers/net/wireless/ath/ath11k/dp_rx.c:3116: line length of 95 exceeds 90 columns
>> drivers/net/wireless/ath/ath11k/dp_rx.c:3117: line length of 95 exceeds 90 columns
> 
> Tamizh, please ALWAYS run ath11k-check. We are wasting time for trivial
> stuff like this.
> 
>> Kalle, in this case we may want to make an exception since I don't think there
>> is a clean way to fix this other than refactoring.
> 
> The new function name looked quite long so I shortened it to
> ath11k_dp_rx_mon_buf_done() and the warning is now gone. Does that look
> reasonable name?
> 
> Also I removed one unrelated change and removed unnecessary else. Please
> check my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6e88d559268779107715008c51e006f7a5f62045

So looking at the 'pending' change I have the observation that
ath11k_dp_rx_mon_buf_done() only returns one of two values:
DP_MON_STATUS_NO_DMA
DP_MON_STATUS_REPLINISH

And the return value handling has explicit handling for those values, without
any logic for other values:
+				if (reap_status == DP_MON_STATUS_NO_DMA)
+					continue;
+
+				if (reap_status == DP_MON_STATUS_REPLINISH) {

if we only expect these two values to ever be returned, then we could remove
the testing for DP_MON_STATUS_REPLINISH since, it it isn't NO_DMA then it must
be REPLINISH

Also after this patch is merged, can we have a spelling correcting patch:
s/REPLINISH/REPLENISH/

+					ath11k_warn(ab, "mon status DONE not set %lx, buf_id %d\n",
+						    FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl),
+						    buf_id);

I don't think we should log anything here. we already warn before calling the
new function. if we get here it means the next buffer had DONE set so we can
replenish the current buffer



