Return-Path: <linux-wireless+bounces-13516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789B99099C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 18:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E231C20EB4
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16721CACD8;
	Fri,  4 Oct 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N9bG6iZf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302B1CACC4
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060274; cv=none; b=YuuPawfdmm/SJfRi4Y6zaIe9Yh9lVm72S423ws7qqtQLMvENN3ALxdzfrj5S6wv/M+SeUknYuuNGUY4qyA9CdGfhEjiTXpuFpUNDbsydejsUSpqKonB/6Gxx/MsShpXiFfwLwRr67FxQg8sXPLXTFfnglx5H+lBMET1cmKp1J1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060274; c=relaxed/simple;
	bh=Hp5u27DaQfJoRWl1k0i5Bwmr5h+v1NDRLUp2ULptFZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CPOZWtgXzxibzMhE6YzLDfFSfbaibEMgNRn/X7lpMLv2xnRPwUqdtUqarz2EY8lGnuxPvEJiP4G8paqGha8LXAweMXX9oseH8vnfzc0cogrisb1wvWUvuJ8d8WblA/0Fw7kuGKNqQDIbpJm2C81PObXEsPlJGbC9Hfce5/hzDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N9bG6iZf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494ACDRa021335;
	Fri, 4 Oct 2024 16:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0IDXKvHiiMKFVRpUotWikxBR65niyfjG6UUhlpbZnmk=; b=N9bG6iZfQQBhgZMW
	Yglb4fPEL6w3uH6shomBkQJh0JdjdPq6bIXJp7vl+R4q/qFqstC/SbtqTEtaBAiM
	tfO1W40u6CWFKSfX2398N94hBwJZmceVwowYautl9e6g9LIROIqNMD0E8bPxPBun
	XQL+obf5a+SbwFUxwtckS8eaSeCprXS7ISF8GbuJvmmivJmOWoVsxbuF4jGyvjEk
	yEa0SV/s54m/7pD7HpY/3oM/j5crIgJlHpa0uL49vyDzvNKbc3fHvD39C0a5F1Vh
	C3X8BS50wjE3s4DnnpOjq5BLAw/wih0NiKGDR99LJ3snt9ZaKjKnRpcNpNVNDGrw
	n2mN4A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205parbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 16:44:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494GiRFc017070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 16:44:27 GMT
Received: from [10.111.183.136] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 09:44:27 -0700
Message-ID: <892bc362-9faf-45d8-ac8a-994e8c4bd19c@quicinc.com>
Date: Fri, 4 Oct 2024 09:44:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Fix CE offset address calculation for
 WCN6750 in SSR
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240927095825.22317-1-quic_bpothuno@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240927095825.22317-1-quic_bpothuno@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vop3Qs5sqe1Aof_SYKq_sAP29wqORJ8z
X-Proofpoint-ORIG-GUID: vop3Qs5sqe1Aof_SYKq_sAP29wqORJ8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040116

On 9/27/2024 2:58 AM, Balaji Pothunoori wrote:
> Currently, mem_ce and mem iomem addresses are used to calculate the
> CE offset address. mem_ce is initialized with mem address, and for
> targets where ce_remap is needed, mem_ce is remapped to a new address
> space during AHB probe.
> 
> For targets such as WCN6750 in which CE address space is same as WCSS
> address space (i.e. "ce_remap" hw_param is set to false), mem_ce and
> mem iomem addresses are same. In the initial SRNG setup for such targets,
> the CE offset address and hence CE register base addresses are
> calculated correctly in ath11k_hal_srng_init() as both mem and mem_ce
> are initialized with same iomem address.
> 
> Later, after the firmware download, mem is initialized with BAR address
> received in qmi_wlanfw_device_info_resp_msg_v01 QMI message, while mem_ce
> is not updated.
> 
> After initial setup success, during Subsystem Restart (SSR), as part
> of reinitialization, ath11k_hal_srng_init() will be called again,
> and CE offset address will be calculated incorrectly this time as mem_ce
> address was not updated. Due to the incorrect CE offset address,
> APPS accesses an invalid CE register address which leads to improper
> behavior in firmware after SSR is triggered.
> 
> To fix the above issue, update mem_ce to mem iomem address in
> ath11k_qmi_request_device_info() for targets which do not support
> ce_remap feature.
> 
> Fixes: b42b3678c91f("wifi: ath11k: remap ce register space for IPQ5018")

Not quite correct, missing space after the hash. Should be:
Fixes: b42b3678c91f ("wifi: ath11k: remap ce register space for IPQ5018")

hint: if you add the following to your git config file, you can issue the
command "git fixes <hash>" and it will emit the correct Fixes: tag.

[alias]
        fixes = show -q --format=fixes
[pretty]
        fixes = Fixes: %h (\"%s\")
[core]
        abbrev = 12

No need to resend to fix this -- I'll fix it in the pending branch

> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/qmi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index f477afd325de..7a22483b35cd 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2180,6 +2180,9 @@ static int ath11k_qmi_request_device_info(struct ath11k_base *ab)
>  	ab->mem = bar_addr_va;
>  	ab->mem_len = resp.bar_size;
>  
> +	if (!ab->hw_params.ce_remap)
> +		ab->mem_ce = ab->mem;
> +
>  	return 0;
>  out:
>  	return ret;


