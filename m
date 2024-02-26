Return-Path: <linux-wireless+bounces-4030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D68868200
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 21:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B9A1F249FB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67741C6B9;
	Mon, 26 Feb 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lBbPPmbs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12605405CE
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980036; cv=none; b=UnRW33BfCW93hdBu2jmQ5iQXC/jOtmck0h2vC1VNTbREDTWw43oqrN6LsQqDAh6CxRFATGguy8/wifVWMxQ+5wvI8nqg0jrGHWBehole+/RTldoMXWV3Zq3H2ENeXNJ7wfaSVA6xYTdqqtIStKcOvVmDhwVHGT8hIuJla9xJnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980036; c=relaxed/simple;
	bh=Z+j4aq1w9YbblyOod9/NaUWenbeuFWQ3YTniQq4E+As=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yka3D5kZ+ba76NCNlIWW5+OpoqptDrN2dJb38xvQfZ4xci8VqHH7DUbN8MjXBY6cEAbcGt+Qtp7GWdnbRE6gc+yMhAAR85x+MeeGFzLUmv4uQVtxN9WnT/XF2mEHwpu1kwD1KI7BdFy51s3MTmfGDUsu5mp0KZnikmsjFIW/VmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lBbPPmbs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QKcp2E002608;
	Mon, 26 Feb 2024 20:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0CTTzyf5c0o0CUjYZTNUpPtWcbvkvG3axZfXwX5A2IM=; b=lB
	bPPmbsOI4W6Kxz9Pw/R09e4oWhWhBkeoxpkReFuqaDHVgazOwHB+I2vlY6aRlOR6
	UsxQUWOLlc3/P9K2U3PQXCOdm0B4PNnLPjiuzrbrknbDgELLl3vJrKnPeBODWNhD
	VD8MWtLybJ33upEEw4yXdB4Y78ESAOevqfy7oviUGBDt7R2T+mo7FDqXIq9mSwuS
	XfyvZw2XA+VwR4AxCfw227UKm0aZxQoxx53qq7Zz774WGnEQPw5CIw2bNQVKUxV6
	W7pCnRE7uSS7BvHjZAMO0Ph3yC5LJPT26vT/TPkQSnCMLjQHSgMml1U9gLRBWERy
	oTmyHt9emT8HNdx+LyDw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxmj23f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 20:40:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QKeOoM025661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 20:40:24 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 12:40:24 -0800
Message-ID: <00db4b62-4cd4-474f-bbe9-33f64d5e3853@quicinc.com>
Date: Mon, 26 Feb 2024 12:40:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] wifi: ath11k: invert scan flag
 WMI_SCAN_FILTER_PROBE_REQ for QCA6390/WCN6855/QCA2066
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
 <20240226060203.2040444-6-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240226060203.2040444-6-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ebNtgn9_QpzVFVEqqVkrJZd0i8vWhIA-
X-Proofpoint-ORIG-GUID: ebNtgn9_QpzVFVEqqVkrJZd0i8vWhIA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260158

On 2/25/2024 10:02 PM, Kang Yang wrote:
> Current ROC scan will filter probe request. But probe request is
> necessary for P2P mode. A P2P device cannot be discovered by others if
> it doesn't respond to others' probe request.
> 
> So invert scan flag WMI_SCAN_FILTER_PROBE_REQ for
> QCA6390/WCN6855/QCA2066.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/wmi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index bbccddd7d729..1dd0cbdda199 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -2317,6 +2317,9 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
>  	ether_addr_copy(cmd->mac_addr.addr, params->mac_addr.addr);
>  	ether_addr_copy(cmd->mac_mask.addr, params->mac_mask.addr);
>  
> +	if (ar->ab->hw_params.single_pdev_only)
> +		cmd->scan_ctrl_flags ^=  WMI_SCAN_FILTER_PROBE_REQ;
> +

Why is this being done in WMI? Ideally WMI should just be doing host to
firmware translation, so seems this should be further up the stack, i.e.
in ath11k_mac_op_hw_scan() / ath11k_mac_op_remain_on_channel()

It also seems strange to invert the flag (which assumes a known starting
value) instead of just explicitly setting it to the required value.

>  	ptr += sizeof(*cmd);
>  
>  	len = params->num_chan * sizeof(u32);


