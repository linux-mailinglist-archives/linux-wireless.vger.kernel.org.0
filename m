Return-Path: <linux-wireless+bounces-3040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB6E8471EC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 15:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C5E282531
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CB17C77;
	Fri,  2 Feb 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fGSSsawo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71129145335
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884159; cv=none; b=NYQnL2rFmPo+FeJlfOyQK6Pj8wfkY4jdSI04KrPmAtXpdGbY4XgmFpapZ0xcGNGHgeXfqMC94e7KflvnB81ztjZOYcaCaASBwgzFfhQ4TbrZVQm+tkNOAbxYbqbMBlPBqSdTKJpGMwG4Oke3YENwJHJRG5zsN0G0jd+LCA1AV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884159; c=relaxed/simple;
	bh=RrjzftBAnxph6AYjD6AUIDDCFWivd9y5iUJ/o0XAaIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hUf8aiTYMZLjV71tts1aIwO/517iZ9xWFGW0xIYUMTnFqBcs1ujRUOa5hVAyKCh1Dm1hSlZz9GHmJlbr7V7rcjZtSyeBWE5UhfMGbRWAp7qzU5RtbdyR23ahnmTIKgiEMi38PHwP8EJxJ89A5vEUpdAyCwWH3xQvmL/CZ74fv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fGSSsawo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412EDMIH010188;
	Fri, 2 Feb 2024 14:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hrtDiKQn0md62RSYfxqqKWElLHA9XM1xV+UcK+kClxY=; b=fG
	SSsawoP8NVGG8bIkxZfIjKCJvDIkkmqSkbHqALdhGe7RMGl25bav4E19O45jb39O
	W8cBDaMNwnjN6zKRKgYE6c7XLkxPu5UdZSWXUehyYTkQ8C0/YzFAk9g1s7OUcvc4
	vZ1UvKYXg272ergkJICwWe2PwPXfPLofMBsjIhbxUD3h6ZVbK4YQk9a4b1ptarE/
	acctGIbA00Jy3/FtI1Y3X5Sr1KNfYmurhQ1CPEj5gE+wSLnFXt6arNACyeTNGNhI
	C2FNVdcS0DdkMSSPgXcfyVqziU4fYqLVKPlm4GapsbQRWDbzujhobeBMRBcJUtPj
	Uzr9ex2SsWtef0zzTtgA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwm1je7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 14:29:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412ET751030699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 14:29:07 GMT
Received: from [10.216.55.87] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 06:29:05 -0800
Message-ID: <59bf33da-3b5d-b685-f9a8-0593b2d3d5e5@quicinc.com>
Date: Fri, 2 Feb 2024 19:58:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 09/13] wifi: ath12k: subscribe required word mask from
 rx tlv
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-10-quic_rajkbhag@quicinc.com>
 <87eddvt5j2.fsf@kernel.org>
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <87eddvt5j2.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dZ0nuDS6JZoDcSuou8mTdbNsi6A_0BAI
X-Proofpoint-ORIG-GUID: dZ0nuDS6JZoDcSuou8mTdbNsi6A_0BAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=861
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402020106

On 2/2/2024 5:57 PM, Kalle Valo wrote:
> Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:
> 
>> From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
>>
>> Most of the RX descriptors fields are currently not used in the
>> ath12k driver. Hence add support to selectively subscribe to the
>> required quad words (64 bits) within msdu_end and mpdu_start of
>> rx_desc.
>>
>> Add compact rx_desc structures and configure the bit mask for Rx TLVs
>> (msdu_end, mpdu_start, mpdu_end) via registers. With these registers
>> SW can configure to DMA the partial TLV struct to Rx buffer.
>>
>> Each TLV type has its own register to configure the mask value.
>> The mask value configured in register will indicate if a particular
>> QWORD has to be written to rx buffer or not i.e., if Nth bit is enabled
>> in the mask Nth QWORD will be written and it will not be written if the
>> bit is disabled in mask. While 0th bit indicates whether TLV tag will be
>> written or not.
>>
>> Advantages of Qword subscription of TLVs
>> - Avoid multiple cache-line misses as the all the required fields
>> of the TLV are within 128 bytes.
>> - Memory optimization as TLVs + DATA + SHINFO can fit in 2k buffer
>> even for 64 bit kernel.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
>> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> 
> [...]
> 
>> +static void
>> +ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
>> +{
>> +	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info10);
>> +
>> +	info = u32_replace_bits(info, len, RX_MSDU_END_INFO10_MSDU_LENGTH);
>> +	desc->u.qcn9274_compact.msdu_end.info10 = __cpu_to_le32(info);
>> +}
> 
> Don't we have le32_replace_bits()? That would simplify this function.
> 
> No need to resend because of this, but a followup patch cleaning this up
> would be nice.
> 

Thanks Kalle, for the suggestion. Would send follow-up patch for cleaning
this up.

