Return-Path: <linux-wireless+bounces-10276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C9933448
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 00:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F461F22C30
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF47581D;
	Tue, 16 Jul 2024 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AWpNZGxf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4014386B
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169545; cv=none; b=ipnuTnFGliqLzWr+A5ZoXdnXZX5tcNaKJ5LCW9/LbNYvUiN9Da1FuVVX/m7kmcPlPi6ZCu+Omrhh7K1OCdrnbje82F8IyDWOmLzq/3OeiKtWitgwaVxY+njroVEggZwRzuQccL8LmTUApLRnqn0i74b9XuaGTt7Uz82Glbsr7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169545; c=relaxed/simple;
	bh=/bsIQxkHAZm+zKtG0OW7cQ2t2aqPkyHZ48D8K6NO37U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gi3i+MFrHIgC7gDlerNNVttz2RyIw4IeMH6/lUHovcvKLWWmHUWmMydHjZ5x/dj+IF9xMd8JzdDLFB2K0VsZShKcpziSLTTOUSnPoFaggCm2DPTFoBa/udsWQbcuecKBj2EGmDPoFu01B10sGnvDNXg/FNxG4vlKvwPIuf/tcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AWpNZGxf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHf3R3027005;
	Tue, 16 Jul 2024 22:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FFsT2dcLrvoehxrf9nAtedp6V/lFWAB5CNhPv+iWuXE=; b=AWpNZGxf41eFpuVl
	F3RRjglcGy/8VnyHT9qS4PC0dkoXM+VR6dzqhJu04eOUVCyIT3T0pT/kvgYbumMb
	dXdStndyEDSu+/7yg2G5mAtzCcM9nr3YwgchUC8ih+7yBf0ROnTgDfwsFAMhrXcN
	SW5VJirLDfWv5ITTSh6D1eT3GpRPq6FrCnxlUt+aktmwa2oqQYo2KUgFNwqPn2sN
	0wFgyYdI5/2y9R9/uka8EfjzJQS2RPrO6VvJ1J/HdPCfCuwV7dHAwrbQrnSny7Od
	zzI5NYbyLjCFt2tQ5TvWhTON0x2wHp5d0xT0fI+dC3w52wL9/UAjltlUgoQzjOd5
	BH4S4Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs0hdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 22:39:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46GMd0Hh010143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 22:39:00 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 15:39:00 -0700
Message-ID: <05af9fe2-043f-40f9-b2a9-68b98ad82328@quicinc.com>
Date: Tue, 16 Jul 2024 15:38:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: restore ASPM for supported hardwares only
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240709055817.3371406-1-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240709055817.3371406-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xl-8f4Pd9T_0S56B6oD08lM2_uUVlvJl
X-Proofpoint-GUID: xl-8f4Pd9T_0S56B6oD08lM2_uUVlvJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-16_02,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=974
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160166

On 7/8/2024 10:58 PM, Aditya Kumar Singh wrote:
> During PCI based hardware device start up, ASPM is disabled for all. And
> once firmware is ready, it is restored back. However, not all hardwares
> (for example QCN9274) supports ASPM. Hence there is a need to conditionally
> restore ASPM back. Or else, for such hardwares, issue can be seen during
> sending and receiving packets.
> 
> Introduce a new hardware param supports_aspm which identifies whether a
> given hardware supports ASPM or not and then accordingly restore it.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


