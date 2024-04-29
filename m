Return-Path: <linux-wireless+bounces-7003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092648B60EA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 20:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EB628235E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CDD127E2A;
	Mon, 29 Apr 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GbofPrrU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594E8614C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414377; cv=none; b=Xj7OP4OnxXpE58euiA5b6nHnn6CuDBcNUABZhig412vH/1Xr/r2AKwxOVde5B/ZW9EBuUMy0f6rB+lUB+AXprndLGe91p9+/lpCC91rjRdDFH28Uns1hNfPFPTt191wJf+fbEI/wTkHh4rRzCRnOcf0xBuQwDMH0b4SYs7C6BGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414377; c=relaxed/simple;
	bh=bq5B3Szi6GFa6zLoqh/4W1bgsRBUOMYkD+MqFiqI4sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uyluLT+j8fbFC/zFnas6CllwVSYykBtFEjDNqhkGF6E1PbdyqIlP9RJMoSpzoOUs13jW13sZj0YHKjkuuGisJ8Ka8yuYU98xJqjzZlAIH3nygne7OsSvxPLtARfUnJDrTb3q5MosaWWVp63Zl9GhDnVUCTY7br2Xe992Vq9gDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GbofPrrU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TFQUqu026819;
	Mon, 29 Apr 2024 18:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ET2AF7MnhTJkIxUl0KoC2YIy+Id2W9y0QPi0t4QPA2w=; b=Gb
	ofPrrUEguuAjYZeoER7VgPvepvVQSusr54gk902muA9A9CrOZOwAAIw00JJYqIa6
	IcChs8mgF7CpjLNsQ6T8dD0NvEkxuGeF/bB5+8fAjl+27m089mpDnmQugX+cPspO
	XZgZcBhr2If2oiRqMp/TlogrWdBwh0poQaffUG0CQLQLdUusa7EBQHRKJxFHCwNE
	o+p885gIp3MTfX2aENu1kfjRT+OQ3N/UGlFfVLBhVxzt9cEOnnWOzqdFiyOvejxC
	EIh+aBwVhxdDQda3j51zdU7u2ZxJY3zs7iw9YtEg2rnB1gJqAtP2q4jiu1bp6n2M
	9KJ4i69knZHtkoAiP2XQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt5xkb5ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 18:12:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TICoSN006191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 18:12:50 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 11:12:49 -0700
Message-ID: <35f114c4-1ff7-4a4b-aadf-ed147f19e170@quicinc.com>
Date: Mon, 29 Apr 2024 11:12:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5] wifi: ath11k: skip status ring entry processing
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty
	<quic_vnaralas@quicinc.com>
References: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I4XlDA3evLPhq4-CIwhkaqXDILi6BAhW
X-Proofpoint-GUID: I4XlDA3evLPhq4-CIwhkaqXDILi6BAhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_16,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=947
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290117

On 4/29/2024 12:36 AM, Tamizh Chelvam Raja wrote:
> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> 
> If STATUS_BUFFER_DONE is not set for a monitor status ring entry,
> we don't process the status ring until STATUS_BUFFER_DONE set
> for that status ring entry.
> 
> During LMAC reset it may happen that hardware will not write
> STATUS_BUFFER_DONE tlv in status buffer, in that case we end up
> waiting for STATUS_BUFFER_DONE leading to backpressure on monitor
> status ring.
> 
> To fix the issue, when HP(Head Pointer) + 1 entry is peeked and if DMA
> is not done and if HP + 2 entry's DMA done is set,
> replenish HP + 1 entry and start processing in next interrupt.
> If HP + 2 entry's DMA done is not set, poll onto HP + 1 entry DMA
> done to be set.
> 
> Also, during monitor attach HP points to the end of the ring and
> TP(Tail Pointer) points to the start of the ring.
> Using ath11k_hal_srng_src_peek() may result in processing invalid buffer
> for the very first interrupt. Since, HW starts writing buffer from TP.
> 
> To avoid this issue call ath11k_hal_srng_src_next_peek() instead of
> calling ath11k_hal_srng_src_peek().
> 
> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Co-developed-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

however note...

> +
> +				/* If done status is missing:
> +				 * 1. As per MAC team's suggestion,
> +				 *    when HP + 1 entry is peeked and if DMA
> +				 *    is not done and if HP + 2 entry's DMA done
> +				 *    is set. skip HP + 1 entry and
> +				 *    start processing in next interrupt.
> +				 * 2. If HP + 2 entry's DMA done is not set,
> +				 *    poll onto HP + 1 entry DMA done to be set.
> +				 *    Check status for same buffer for next time
> +				 *    dp_rx_mon_status_srng_process
> +				 */
> +
> +				reap_status = ath11k_dp_rx_mon_handle_status_buf_done(ab, srng,
> +										      rx_ring);

ath11k-check reports:

drivers/net/wireless/ath/ath11k/dp_rx.c:3116: line length of 95 exceeds 90 columns
drivers/net/wireless/ath/ath11k/dp_rx.c:3117: line length of 95 exceeds 90 columns

Kalle, in this case we may want to make an exception since I don't think there
is a clean way to fix this other than refactoring.

FWIW I'd like to see this function refactored to avoid the excessive
indentation, but that should be a separate exercise.

/jeff

