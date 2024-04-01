Return-Path: <linux-wireless+bounces-5719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A789434B
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 19:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0892837AA
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488641DFF4;
	Mon,  1 Apr 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nVBufc06"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939541C0DE7
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990919; cv=none; b=GBE1PYX6lEGjiJ1X0MasZA0QAAs4QzM3ByGnFyQTnf2ak6d9B1bDA/UGhhHrK9GJuJ6KRvFgC5PJEDJ9jO+5FnTMHljlkyClo5m4E69jyEMBlV7BDfBME2zksyZcFnALvOUdHx19wHXWReq8y1azptOMANi9noKCxMgIJrBs9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990919; c=relaxed/simple;
	bh=kI35KCKUrq5G/gbTgYm+FVDfy8akRuINrhztfKkYWAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kl3MKP/CfBhBhGIpvHEO14HlGvcZ7Y22Ml//xtYlXzc7PYjFiGVcGJDRsi+GDsNRliaKANaeMWfOazC+72RimfJdhCVETlidrju6VQEZ+4I+zECeZRQimttTTFmeR//r6DWxO0rYR3VEETsUAB4mIxebmN3FZwi/OHZ2hr4Fq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nVBufc06; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431DcXhc023228;
	Mon, 1 Apr 2024 17:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PE2Nc7c3GRFlF8yi5FEfREO7LJ8807tkWTRXUcWL25o=; b=nV
	Bufc06etv0wXSABw7jkrQekzQQRTdMZUmU6vEWJVIpf6INZWNsP+y3VxoTTbs6Sk
	ItLNQNeSmEme2GXPE3UAMbXTRag0kYE2I+OmlZr9nfl/jQRM45v/v6bQUsgU/oAF
	Nqm4ktH2+4vFNDKDZhYaw+PswcrkuqSd0dwK380mR63qzO+idana9vDsA4L7ceC1
	waodlpF3GjGUgkKkSmaMQ1+NC6amgNb0wzO1bdJJgTzquxvf7dFWA1YS98OEIFix
	1L8SSbjuZzSxR4xv8RyDZ2HgVGOWCdh3cyc0JXwlXiy+/rVjEzwZyVclqpYFb5FM
	a/k0cu7b13XcIbtzVtPA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7r57179j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 17:01:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431H1qb6010562
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 17:01:52 GMT
Received: from [10.110.126.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 10:01:51 -0700
Message-ID: <dc3ee4aa-6fce-44d3-9095-b8b2846e1f4b@quicinc.com>
Date: Mon, 1 Apr 2024 10:01:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix flush failure in recovery scenarios
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240329015630.3019-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329015630.3019-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dHXjkQjfxOr8Jbf5V3hzERbwOF8Q1qL6
X-Proofpoint-ORIG-GUID: dHXjkQjfxOr8Jbf5V3hzERbwOF8Q1qL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404010120

On 3/28/2024 6:56 PM, Baochen Qiang wrote:
> Commit eaf9f17b861b ("wifi: ath12k: relocate ath12k_dp_pdev_pre_alloc()
> call") moves ath12k_dp_pdev_pre_alloc() from ath12k_core_start() to
> ath12k_mac_allocate(), resulting in ath12k_mac_flush() failure in
> recovery scenarios:
> 
> [ 6849.684104] ath12k_pci 0000:04:00.0: pdev 0 successfully recovered
> [ 6854.907320] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
> [ 6860.027353] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
> [ 6865.143385] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
> 
> This is because, with ath12k_dp_pdev_pre_alloc() moved to ath12k_mac_allocate(),
> dp->num_tx_pending is not reset due to ATH12K_FLAG_REGISTERED set in
> recovery scenarios.
> 
> So a possible fix would be to reset that counter at some proper point,
> just like the old design. But considering that the counter tracks number
> of packets pending to be freed or returned to mac80211, forcefully reset
> it might make it hard to expose some real issues. For example if somehow
> ath12k fails to free/return some TX packets, we don't know that because
> no warnings any more.
> 
> That is to say we should not reset that counter during recovery (which is
> already done due to above commit), instead should decrease it each time
> a packet is freed/returned. Currently almost each related function has
> this logic implemented, except ath12k_dp_cc_cleanup(). So add the same
> there to fix this issue.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Do we have QCN9274 test results?


