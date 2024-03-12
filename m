Return-Path: <linux-wireless+bounces-4588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721BE878E26
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 06:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6112823DC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 05:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667610A0F;
	Tue, 12 Mar 2024 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o7fEXDU3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDFB66F
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 05:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710220966; cv=none; b=V1drpvIgQgILoNPf0bK/+jq61jmUUIR03ehM+Q67EFgHNEupLqyu1Xe01EaBEydbRtgMYU13WZ37rPq6+Tpp657mtvLU7WSgFp+m/br+VhV+i9iQ2XX/6viX28Wu57FXgos5ACcfTOWeAMkA6tNcCIR/68dWTZR/tix+lnYE89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710220966; c=relaxed/simple;
	bh=4hOz6NTf53Efo77AsiGfCcVt7bcenj5aMIxcuCn6eT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TRHntdMPNNAGpquMZ6eTXI66JLEm0FHm9IambXtxMYHYeIvtnAI7mC1FipFjbzKH4IcCGpPknIMkC3Aw+MCs59SfCVhuNCMeuFuf2mdTFlk/ESxpmaAKx0AJNHYc0kvSpdQFyc0NxK3Vih51WBl/BXA15YFpKQ7XTeMtNz2xpYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o7fEXDU3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C4FUE2024327;
	Tue, 12 Mar 2024 05:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+iuDYozJEoJXFte+dvHwWqMUc6lkfhn7XcMXI+LUu9s=; b=o7
	fEXDU3pNTr+mPhijpQjeEYuvDVHU7QPcfoTl3w+MZiTDa9cCj0vnKAfQvqPPO2TL
	WKxe2pPjjz75onKNlqJRxZhX5RWe7PPJbZaYJBjQNp3pOZDMBYAMkFE9+IxLQGP4
	XRVmqyV78xCFKGZxcHqPAh1AIRMFMfcdPqbzTUNNLJjbQv3yrNvdqT1oOKEq6dqa
	CNrRH3NlanM1ZQ0gB8vm76n0f6dF28rNZY9z/T+CS3onLJOxkzG+ME2ktW5mKffT
	tSMdDwmPcIAzk4rOk8lWKlDzO2X+rrKgpsuVIL1dT8CzJrPqLDpE7Xb+j30K2UOw
	VtkOozkdktmkccgCxDLQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wt86tgwvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 05:22:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C5MAj5000689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 05:22:10 GMT
Received: from [10.253.9.188] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Mar
 2024 22:22:09 -0700
Message-ID: <45d4ae89-70ff-4103-ad9f-ece3660924d0@quicinc.com>
Date: Tue, 12 Mar 2024 13:22:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] wifi: ath11k: P2P support for
 QCA6390/WCN6855/QCA2066
Content-Language: en-US
To: <ath11k@lists.infradead.org>, Kalle Valo <kvalo@kernel.org>,
        Kalle Valo
	<quic_kvalo@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20240228093537.25052-1-quic_kangyang@quicinc.com>
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20240228093537.25052-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DlfCUc4Tl6mp7x3kcK-j9BbUWWGYgA86
X-Proofpoint-ORIG-GUID: DlfCUc4Tl6mp7x3kcK-j9BbUWWGYgA86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_04,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120040



On 2/28/2024 5:35 PM, Kang Yang wrote:
> Add P2P support for QCA6390/WCN6855/QCA2066.
> 
> v2:
>      1. patch #1, #4 and #6 have already been acked by Jeff.
>      2. patch #2: remove unnecessary initializer in
> ath11k_mac_setup_bcn_p2p_ie() and change judgement for P2P GO.
>      3. patch #3: verify the validity of descriptors number and remove
> blank line.
>      4. patch #5: change scan flag filter before
> ath11k_wmi_send_scan_start_cmd().
> 
> Kang Yang (6):
>    wifi: ath11k: change interface combination for P2P mode
>    wifi: ath11k: add P2P IE in beacon template
>    wifi: ath11k: implement handling of P2P NoA event
>    wifi: ath11k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
>    wifi: ath11k: change scan flag scan_f_filter_prb_req for
>      QCA6390/WCN6855/QCA2066
>    wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066


Hi, kalle:
	We have a customer request for P2P on ath11k. They need us to upstream 
P2P feature. So could you help process this patchset?



> 
>   drivers/net/wireless/ath/ath11k/Makefile |   3 +-
>   drivers/net/wireless/ath/ath11k/core.c   |  20 ++-
>   drivers/net/wireless/ath/ath11k/mac.c    | 166 ++++++++++++++++++-----
>   drivers/net/wireless/ath/ath11k/p2p.c    | 149 ++++++++++++++++++++
>   drivers/net/wireless/ath/ath11k/p2p.h    |  22 +++
>   drivers/net/wireless/ath/ath11k/wmi.c    | 107 ++++++++++++++-
>   drivers/net/wireless/ath/ath11k/wmi.h    |  42 +++++-
>   7 files changed, 471 insertions(+), 38 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath11k/p2p.c
>   create mode 100644 drivers/net/wireless/ath/ath11k/p2p.h
> 
> 
> base-commit: c39a5cfa0448f3afbee78373f16d87815a674f11

