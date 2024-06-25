Return-Path: <linux-wireless+bounces-9555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3EC917075
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 20:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C605F1F21D1B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE80217B516;
	Tue, 25 Jun 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W3vK82Et"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569717C230
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341034; cv=none; b=aRvxKJEJ3BW1e+2iqbsivVQUDzDA5EkqIpH0pbmT7JnqjVMs8DOoMGO44k3JBxhE2mv4Q8LM8YUnmVlazklCEPkPYgfJJf9xTWQUK86TbB8EK1oVJE/c7iU0kMIsOG9T/OngFarryRbA3DZsZnPwMmMQdsqahdnZ+UFu5gbeFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341034; c=relaxed/simple;
	bh=TeRPwaXbJCHJQj+gQioxlj5o6xY9Fmg7zOoZB7ZlqlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N/44k3x87WeSNNf47kS+QN4bjr+bVavyjVVv9gyVFu+nY2PmIJ6Bwl3J9bW1HlTbRtOwwxFFvK8clCGJT0u5Q/I0qJh22ihPIi/M2kLYtdiAsCAuh1yAFRvLiLZef1H5Vm2nf3qB4TV41hNeoX1xjMk18WfB39dreC+49W6IxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W3vK82Et; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIQCwq018135;
	Tue, 25 Jun 2024 18:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5tVd3OdaxcchaIgoC58Qv9yaniayKiXDuba5kI8nGew=; b=W3vK82EtvOHJiIFh
	n3gyWLIiSVoGXwe0XHjN6PX5Hqmd+qEGv6+hMsYFnXxXy9xgzCPNnxxOp7rCYrUC
	IOYzTVP4EnfOMxlVyJ+eOV2LKBwj1Zkq4flygnolDxOncB7mxmfvbjDUCYJ8GlS4
	EhfVZRhJWbrtIzJTT0ZJ5gU3lRtBXhRRhI6lAesXCkT21g5YMhznigfcBrVFJFIM
	zhi5vrJnDe5Fdtu7FGd6MOe73x2t2dbX7V3Pj6Hiux2rZXZ0vZkc9heWJQoIW8dt
	Y4wd9kpxRG/+p/RiL+mhppey+xEEv/y3YiaKZv0nqtnklumeN0YY6UveRw8N6PkD
	gayHSw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6qb87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 18:43:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PIhl54032658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 18:43:47 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 11:43:47 -0700
Message-ID: <c9d54e32-396b-4a76-b507-aef9b4863f3f@quicinc.com>
Date: Tue, 25 Jun 2024 11:43:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] wifi: ath: create common testmode_i.h file for ath
 drivers
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
 <20240624095305.37189-2-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240624095305.37189-2-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LkcsasvmKDR5KXWmJBFGNhQ5SMit8o2a
X-Proofpoint-ORIG-GUID: LkcsasvmKDR5KXWmJBFGNhQ5SMit8o2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_13,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=319 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250137

On 6/24/2024 2:53 AM, Aaradhana Sahu wrote:
> User space application requires that the testmode interface
> is exactly same between ath drivers. Move testmode_i.h file
> in ath directory to ensure that all ath driver uses same testmode
> interface instead of duplicating testmode_i.h for each ath drivers.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


