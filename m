Return-Path: <linux-wireless+bounces-10536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1334A93CC03
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 02:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9FD1C216B6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 00:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B080B;
	Fri, 26 Jul 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EE+ujKsK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD73C30
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953082; cv=none; b=dWLPjgXbT238Hl/xuh7Z6iq1XMTL2c/oo/WVxGYSEckSF9e6IrcPrHrL8vugwKcW51ComMlFyXiTduvjWDB04Hp9a2Jj/9bF0lIw/vPwhOzgDSZ+jZUQI/wrV6YYwa+EzgSUEbIsy12CVkH1MVHpNp1NSVsZokp3rnyXRLvm7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953082; c=relaxed/simple;
	bh=L9iHidD/DKePkS/Fn7nQEcMUhc8WBb5gGA4ZhaZwk4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FWCPt9Q/cM3Ans0g+bzx6gNBNuJVHLX+SqBwQgisOyLCEcWdf6s6YsjVJhSx2K/onNwCO1gnYe3ZoC6v9wR0mYKl8r2LYLEFAKG63tAMC2AiZZ7tp+WwxuaJHg3Hp2Zd0qau+ETckzO7n+BNHk9840KKtNBrfSMBR0d8VfkUXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EE+ujKsK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PCSggj022278;
	Fri, 26 Jul 2024 00:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mnWBCEgHQjjYNc2dOABe44pvRzZ+SqFK1GB6/gt9VNs=; b=EE+ujKsKAzEFaRhT
	JVDBIQFAM6JFSjejQL7TiN2B9IJLM4HPw/jFojCv5dF5eUqHj6y7AgAMgiaVR56J
	7+jm12YOGGSaRFefNSnz44dHWrdN1AfFx2qMhPMr4FBrCQ2NnOKrxBy7s9JZViWk
	FISLr/m2sHBLm5EWJYlhwvklfjifnVCiKqkEjY6fmIqqtMed70lAH4t4aEmleEAJ
	w6CfwMe3pWla1bV4HarDWhqnhBXIWGD7UdJKH3bQcXZXsG2g2/OKASQc/QdRyxhu
	lMevMx7ppYWl4jrWtu0ccMcAR07vgO6sKc9OST8v02I8G6dGZZW9u0hagcWqkawS
	ux/68w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40k3g248ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:17:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q0HvL1004031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:17:57 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 17:17:57 -0700
Message-ID: <6b5a691d-3073-41fe-b728-5317bfe05a47@quicinc.com>
Date: Thu, 25 Jul 2024 17:17:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] wifi: ath12k: delete NSS and TX power setting for
 monitor vdev
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-9-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240725120035.493-9-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OUdXC3zoniFhKCOWjqyDi0FxLB3IU0Wf
X-Proofpoint-ORIG-GUID: OUdXC3zoniFhKCOWjqyDi0FxLB3IU0Wf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_26,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=752 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407250164

On 7/25/2024 5:00 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> ath12k_mac_monitor_vdev_create() will set NSS and TX power for monitor
> vdev. But this is not needed for monitor vdev.
> 
> So delete them.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>



