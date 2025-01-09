Return-Path: <linux-wireless+bounces-17227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE4A06DA6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 06:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D49B3A6A1E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 05:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C332144BB;
	Thu,  9 Jan 2025 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TY1mN72N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB852080C3
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736401122; cv=none; b=ZyieBiTr40JIQBDhkOP5+6eCR1U4snMvN/+oiuTHDYoPWl47DwwfmWWXNwgubuO7ISsjpNmpDoVKcUHV5bLaYYPhKTRM+JLIwuLHQBL+7QgaAhq5rt2gD0PXSh3TcCi5DO4zJylLFz80S6sn0sOop4ltMBfzs6XV/svCNdkZFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736401122; c=relaxed/simple;
	bh=yq+y3BZ1S1/t+G27hDbM2/Kzq1REoCUydLGfoM9jok8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HMrB8nffUqcAqtN+iRvoQgRrqzEjJqlQg0f7fHgN5KYX5Gs2ABgjrVAkp6x8kwpSPD909jzik+wjuVkiwfuzFqWebsRHayXQeY4tUWMbpt3TWDlpTxY01AkpSxJb9kelUNU6PUHigA2c5wQgWE3gD5WfAmQy7vLMBhiuGBECZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TY1mN72N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094BtSN018275;
	Thu, 9 Jan 2025 05:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3M05VNobMlqihLFY1hRX7+uDTC8lilZ5KVPx5Dp4B10=; b=TY1mN72NN+cgYEYZ
	Oomk7Xut7gMXBGcz/TE1pDj/JyiFqVXKvmFw+mCq+Kn6stH+eMsP+ljqaDtu3oz2
	j9FpDCIGtZIk/rCP6FvQ0bq4LPyz2blhxPNoTpFNY4lQoe62wjbswnF7cxjN7jpT
	9Qh6dSALH0slagoOoPEP7+ifK4ut0F8lnro8zzngchhhfjJBrRY83Hwq1L6xH7cN
	0XmZcjUTR1jXDN1n28vwbKhaQyXx/XOERwiqEeIRGPqSQBexHyrc+s82mVeGiBnF
	d9r02J3Gy2AIRhjvN1Ksjjs03pDnh7rW7iMWl/zYOPqRxDUeckgXhx/9Ap5aevmd
	LOqhlg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44277e0567-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 05:38:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5095caOZ028786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 05:38:36 GMT
Received: from [10.50.55.168] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 21:38:34 -0800
Message-ID: <c022493b-d009-4a1d-9fbd-219a3ecf84b6@quicinc.com>
Date: Thu, 9 Jan 2025 11:08:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Support Transmit Buffer OFDMA Stats
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Pradeep
 Kumar Chitrapu" <quic_pradeepc@quicinc.com>
References: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
 <20241128110949.3672364-3-quic_rdevanat@quicinc.com>
 <87jzb6flwz.fsf@kernel.org>
 <c776b5ee-0e25-4d21-be21-dd318ae33d1e@oss.qualcomm.com>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <c776b5ee-0e25-4d21-be21-dd318ae33d1e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5kPwMNzfZnLuQ4pgfP0bETfWbJwLXD5q
X-Proofpoint-GUID: 5kPwMNzfZnLuQ4pgfP0bETfWbJwLXD5q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=879 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090044



On 1/8/2025 5:08 AM, Jeff Johnson wrote:
> On 1/7/2025 11:45 AM, Kalle Valo wrote:
>> Roopni Devanathan <quic_rdevanat@quicinc.com> writes:
>>> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>>> +	len--;
>>> +	*(buf + len) = '\0';
>>
>> Please avoid pointer arithmetic, this is simpler:
>>
>> buf[len] = '\0';
>>
>> Or should it be just 0 instead of '\0'? Don't know which one is
>> preferred.
>>
> 
> well my take on this is we have a lot of similar pointer arithmetic already in
> this and other debugfs files, including all of the scnprintf(buf + len, ...)
> calls which could be scnprintf(&buf[len], ...). And we have existing instances
> of trailing comma suppression in:
> print_array_to_buf_index()
> ath12k_htt_print_txbf_ofdma_ax_ndpa_stats_tlv()
> ath12k_htt_print_txbf_ofdma_ax_ndp_stats_tlv()
> and others, all of which assign '\0'
> 
> so this code looks ok to me.
> 
> that said, while i've been reviewing the debugfs implementations I thought the
> code would look much cleaner if we had a wrapper function (or macro).
> 
> Note that the input to the current debugfs functions includes a struct
> debug_htt_stats_req *stats_req that maintains the buffer pointer and filled
> length. what if we had a wrapper that took just that, the format string, and
> the optional arguments, and all of the pointer arithmetic is encapsulated in
> that function, rather than being open coded?
> 
> so instead of:
> 	len += scnprintf(buf + len, buf_len - len, "some string"");
> have simply:
> 	ath12k_scnprintf(stats_req, "some string");
> 
> that function would extract the buffer pointer and current filled length from
> stats_req, calculate where to write the next string, call scnprintf() or
> vscnprintf() to write the string, and then update the current filled length in
> the stats_req. That would eliminate all of this housekeeping from the callers:
> buf + len
> buf_len - len
> len += scnprintf(..)
> 
> /jeff
> 

Since there are a lot of instances where this change is needed, can we raise a
separate patch for this? If that is okay, we can go ahead with the current
implementation in this patch.

