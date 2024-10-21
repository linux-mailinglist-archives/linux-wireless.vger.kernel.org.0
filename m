Return-Path: <linux-wireless+bounces-14255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE59A5FDB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 11:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48681F21970
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D67183CA5;
	Mon, 21 Oct 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QOnTnnKF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E3946C
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502483; cv=none; b=UWZb2eg7VBuHPHWC6Ks+TA3jIvSBVVAFImmukN5AMdhqE/CJGumXwXkkgG9yzbI/sANe4cyfvOMbUCuZpGqenCx8n5lxQkfW9rcmgkkDUdbiqWPNAucScWodVh4asENh+eVFJSYVmvKjSq/gbv+Y32C63dfg0yCuME0T5S1rn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502483; c=relaxed/simple;
	bh=CHJZBbyVc5Tlrf44Kv2+Cf3N8r334g7Xz6GMkB/HutE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZY2u8E67mw7odvkAsYTRLdhE9shYGr2xR0p9wvWsPanXMXRKdDcHCGu19nNb9VWofFYfhFYycdE7QwbJL9VEOkJRPAk6WW46yvq/MuDpYJYTy4Qv6LOH/kfffV9008eJ1uKNq+e9HZoaCATecv/7h+kJO5Mw8Q3zOH8yDEBKRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QOnTnnKF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8VoqX014285;
	Mon, 21 Oct 2024 09:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gzqwy4J6I5ZHt95NmhjTjIXEGtEdU1tw1bSphkPcuK4=; b=QOnTnnKF5Pnyhi9M
	3/ZTY7YVTB/RcDBuVor42/uCfRBzSkwq/sjHw/eS4KaeB6jr4USGV4/96ns1ewzw
	IB+FEdx/baSoQ4TT07fmcJNVa0x/Zps1yV6ElFkdolUIBoaoEks6dfaKxHTzfoih
	yT1wzbLJjKi62aKNpws8jZvRz/ugwPJnfDsUWjwkNvFOjDeOLRf02+frXVJYMngn
	AXs4qHiS7PjOu7jXEi9q7QRcOaQQUMSC2nhz6rDugKy4wj0e/yvIJ8UbzNJ2aBgq
	PXeFC1KYRntpJWnA6gitf1LIMLuUZNluIbS1W4Fk0NuhSiA70JgWRH42Nkwn+Yyo
	9nbR0Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd07a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 09:21:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49L9LFKq022672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 09:21:15 GMT
Received: from [10.253.15.238] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 02:21:14 -0700
Message-ID: <f605fb9a-28ad-4aa8-a66a-085a7229f629@quicinc.com>
Date: Mon, 21 Oct 2024 17:21:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] wifi: ath12k: delete NSS and TX power setting
 for monitor vdev
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
 <20241016065700.1090-9-quic_kangyang@quicinc.com> <871q09rgg8.fsf@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <871q09rgg8.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nB0Mo-FPjhbU1xs7yxx1c37v2dlr0dzV
X-Proofpoint-GUID: nB0Mo-FPjhbU1xs7yxx1c37v2dlr0dzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=671
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210067



On 10/21/2024 4:46 PM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> ath12k_mac_monitor_vdev_create() will set NSS and TX power for monitor
>> vdev. But this is not needed for monitor vdev.
>>
>> So delete them.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> 
> Does this fix any known issues? Or is just cleanup?

Clean up

> 


