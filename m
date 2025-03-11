Return-Path: <linux-wireless+bounces-20148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD0A5BAD3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 09:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0083AB39E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 08:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25312248AC;
	Tue, 11 Mar 2025 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WhT9zCpi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237B33E1;
	Tue, 11 Mar 2025 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681795; cv=none; b=LaDjAGpcE6zh1D+5OlENMeOQIZif0omf8SrHJEs1b/Xmq8Daxn2LMMd/SoSr/6CVju9y0q8dThE6TZvaCfbIG4RJj4QMlemOYeju1XvujWyo0xcGfljyY5I8uGKvzyHRMKF70cAojJ5jL+sIM1iKUQRw8IjqssEhvLIqdKWR4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681795; c=relaxed/simple;
	bh=XGhOe8fuEDWaYxavoCfM4Ttw0iW7dGdxc/+hd/biynk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VMOZzcXgy9kUosk4MwMR111PQWU95kAwygzG9/2GFUuy/P2golJY2/j+SDObJU1/oQBBVPqD4DXxUXR0XPg3GMQRxb6Q2oZXHFY0LBDPKgE253qK9NTzkSYjZ0K7hdCBrzBefaab+KI11dk0RVwoJIefD5k7uOn3dI+NIN4Rabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WhT9zCpi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7oJRI009265;
	Tue, 11 Mar 2025 08:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v0NKMUQKXKn/4hsWmllOKkwAuEuIvvOI01hYmoagsz8=; b=WhT9zCpiIdNFLuED
	d3/nVL7qvN5WUFwzPTbl9YBrz0PXH6VLevUgz5FO/svdn4KQsc0qXKQrFCTEolLB
	mYwdQfCo1uhQ+k0r7VoukaZ/qx7fSlFKMpqYS6y9ZHpB4Ioy0nlCxUOFJX5q4Jl6
	JVB0BnLmKlW3/UTNcI7V2Lrpb4/AdZBAKQwkkkXSh0vjAwb6uw8f7zNoW4JknjsQ
	YjUW/lMcHMkPnD0k0sZc4i/H9XHxGZUmM7yDiVwDGh1sEvQgsnH2WLHTk+Ss0nUU
	KZm9RZL8+tPa7mAG1k56AQwS514e+9S7WV2+kWF/H8x1sHagheAPutPCGKzNS/Kg
	j5bmFg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah4s03r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:29:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B8Tkr2012253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:29:46 GMT
Received: from [10.239.29.24] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Mar
 2025 01:29:44 -0700
Message-ID: <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
Date: Tue, 11 Mar 2025 16:29:42 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
To: Johan Hovold <johan@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <Z866cCj8SWyZjCoP@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=YYVH5xRf c=1 sm=1 tr=0 ts=67cff47b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=zvfRP35NZ5SxQhbWGWEA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: N17Se1jF52_h2D2k7tD-l38nPVcfbSgk
X-Proofpoint-ORIG-GUID: N17Se1jF52_h2D2k7tD-l38nPVcfbSgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110056



On 3/10/2025 6:09 PM, Johan Hovold wrote:
> On Mon, Mar 10, 2025 at 09:02:17AM +0800, Miaoqing Pan wrote:
>> A relatively unusual race condition occurs between host software
>> and hardware, where the host sees the updated destination ring head
>> pointer before the hardware updates the corresponding descriptor.
>> When this situation occurs, the length of the descriptor returns 0.
> 
> I still think this description is too vague and it doesn't explain how
> this race is even possible. It sounds like there's a bug somewhere in
> the driver or firmware, but if this really is an indication the hardware
> is broken as your reply here seems to suggest:
> 
> 	https://lore.kernel.org/lkml/bc187777-588c-4fa0-ba8c-847e91c78d43@quicinc.com/
> 
> then that too should be highlighted in the commit message (e.g. by
> describing this as "working around broken hardware").
> 
Ok, will do.

>> The current error handling method is to increment descriptor tail
>> pointer by 1, but 'sw_index' is not updated, causing descriptor and
>> skb to not correspond one-to-one, resulting in the following error:
>>
>> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
>> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
>>
>> To address this problem, temporarily skip processing the current
>> descriptor and handle it again next time. However, to prevent this
>> descriptor from continuously returning 0, use skb cb to set a flag.
>> If the length returns 0 again, this descriptor will be discarded.
> 
> The ath12k ring-buffer handling looks very similar. Do you need a
> corresponding workaround in ath12k_ce_completed_recv_next()? Or are you
> sure that this (hardware) bug only affects ath11k devices?
>   
Yes, will submit a similar patch.

>>   	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
>> -	if (*nbytes == 0) {
>> -		ret = -EIO;
>> -		goto err;
>> +	if (unlikely(*nbytes == 0)) {
>> +		struct ath11k_skb_rxcb *rxcb =
>> +			ATH11K_SKB_RXCB(pipe->dest_ring->skb[sw_index]);
>> +
>> +		/* A relatively unusual race condition occurs between host
>> +		 * software and hardware, where the host sees the updated
>> +		 * destination ring head pointer before the hardware updates
>> +		 * the corresponding descriptor.
>> +		 *
>> +		 * Temporarily skip processing the current descriptor and handle
>> +		 * it again next time. However, to prevent this descriptor from
>> +		 * continuously returning 0, set 'is_desc_len0' flag. If the
>> +		 * length returns 0 again, this descriptor will be discarded.
>> +		 */
>> +		if (!rxcb->is_desc_len0) {
>> +			rxcb->is_desc_len0 = true;
>> +			ret = -EIO;
>> +			goto err;
>> +		}
>>   	}
> 
> I'm still waiting for feedback from one user that can reproduce the
> ring-buffer corruption very easily, but another user mentioned seeing
> multiple zero-length descriptor warnings over the weekend when running
> with this patch:
> 
> 	ath11k_pci 0006:01:00.0: rxed invalid length (nbytes 0, max 2048)
> 
> Are there ever any valid reasons for seeing a zero-length descriptor
> (i.e. unrelated to the race at hand)? IIUC the warning would only be
> printed when processing such descriptors a second time (i.e. when
> is_desc_len0 is set).
> 

That's exactly the logic, only can see the warning in a second time. For 
the first time, ath12k_ce_completed_recv_next() returns '-EIO'.


