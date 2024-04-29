Return-Path: <linux-wireless+bounces-7008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC98B64C1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 23:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE02280FB4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 21:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4C71836FE;
	Mon, 29 Apr 2024 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A1tIpemn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497391836E9
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427092; cv=none; b=eCcNVi1I5cEM8EMAY7FrnbvYpSbf9MGr8O2sDGI9fPj9yXJXiogZobV1sy4KWozYwpBzDI0GoIGNL/INaiO3ZiSQRjZp/lukAXca4qkykImpnjbRYoKoRdMrOYBSmpS8p9p+TyHzPa0Mvb3vY/9IdP9sncyZ9U5lUP3CuxyLJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427092; c=relaxed/simple;
	bh=2YbYaOeNyvUmL36wnw7LcidlMWu2FqsJRPb6u/rMBok=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EgsRy+ca3Jx4IyuXH9WU7Up40TZ3CUdkV1nqe6q/YNeUGVMmW3eQr9Cms4yLBIo26/+/6BkgePZiHxEpEHiLIXdsAQhDJ0FEoisSoTHN3bN6HE497XEqg2ZdqJfQhRKO0vdodErwCS7RiEgOMf5rI/pBz8TqG/3FF8L10bZFEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A1tIpemn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TKcN6E028847;
	Mon, 29 Apr 2024 21:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XpIeHW6fUF/BuzX8tEY1fvllpjPSiv3liE/wa/D3ZLg=; b=A1
	tIpemn7fm2g/85vvVwi37G/y9hG9QYBzQvQ3y+WL4R5xq+O2eezbxDff4fFqJFYU
	GceK7XPkssKvXfXQhHKQPMIA7i0gFA21139GpZI8N+wlwJal1qf144HRHLo/DZpK
	fwfvI8OS9L+Ej2frw4kVHfDhfExw5moj2Xns7mgSlA39vPknShRm4iqUoCmm1GLA
	VnP9YpTr+K378joY4nXxP1SIU38lQf5afl53Qbhj0j3eRwM3ibCrOrgKbialm9TB
	rx8kWAngnG5NFFkA+WxLDN2HkHVOzG/pS+P34pQ4gPnTr6KF8QA0i5nGsY6GPcK8
	+mtiuHsemRIg50vtl6cA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtg51ryce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 21:44:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TLicXv006608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 21:44:38 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 14:44:37 -0700
Message-ID: <107ed720-f735-4878-9486-9b88b9dbe3e9@quicinc.com>
Date: Mon, 29 Apr 2024 14:44:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/3] wifi: ath12k: Remove unsupported and unused ring
 configurations
Content-Language: en-US
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240429072039.711706-1-quic_tamizhr@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240429072039.711706-1-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LCYKfokfbpGK-3VXu5Jl31NayrVb6__c
X-Proofpoint-ORIG-GUID: LCYKfokfbpGK-3VXu5Jl31NayrVb6__c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_19,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290144

On 4/29/2024 12:20 AM, Tamizh Chelvam Raja wrote:
> Currently in driver doing memory allocation for tx_monitor,
> tcl_cmd_ring and tcl_status ring. Here driver support for
> tx_monitor mode is not there and memory for tcl_cmd and tcl_status
> rings are allocated by firmware and it uses that memory instead of
> host allocated. So avoid these unused ring setup configuration.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Tamizh Chelvam Raja (3):
>   wifi: ath12k: fix calling correct function for rx monitor mode
>   wifi: ath12k: Remove unsupported tx monitor handling
>   wifi: ath12k: Remove unused tcl_*_ring configuration
> 
> v3:
>   * Addressed Karthikeyan's review comment of modifying
>     ath12k_dp_tx_htt_rx_monitor_mode_ring_config in correct place.
> 
> v2:
>  * Rebased on top of ToT
> 
>  drivers/net/wireless/ath/ath12k/dp.c     | 16 -------
>  drivers/net/wireless/ath/ath12k/dp.h     |  2 -
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +----------------
>  drivers/net/wireless/ath/ath12k/dp_rx.c  | 56 ------------------------
>  drivers/net/wireless/ath/ath12k/dp_tx.c  | 44 +------------------
>  drivers/net/wireless/ath/ath12k/dp_tx.h  |  1 -
>  6 files changed, 2 insertions(+), 157 deletions(-)

My Qualcomm Innovation Center copyright checker reports:
drivers/net/wireless/ath/ath12k/dp_tx.h copyright missing 2024

> 
> 
> base-commit: bf99bc7423e18aa3475ef00a7a6fb773c31ce6df


