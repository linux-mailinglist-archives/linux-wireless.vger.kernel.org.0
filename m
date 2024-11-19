Return-Path: <linux-wireless+bounces-15515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C59D2E69
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E312CB2CA71
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322581D0F56;
	Tue, 19 Nov 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="of0VzLVV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144840BE0
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040261; cv=none; b=A7NSaxexRTva5xZWnQOjjW7FLSGG6ZrJPJ7BKUm4vHymrrRyl8VNKlXLc1HiBIvYoqYMDL5wzJ3fV6G/iBwtHFpBdf1fQSCQzwvwAeRQnCsVkfp7amqx/vqp8R7teaDIY4w+zmv1RS1vme6rb6DJLNPFFcCY+EwT8IGUwOtH2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040261; c=relaxed/simple;
	bh=XJEsrxqEaFuMfdZq8NRtKm6RzLRqj8pQABhd4iLMtD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ogCx05rHQcVZRoWlM/AbVWpmlXxoOAXaYGhuCMvQp6up9cvUYSTPgayoD6X1S90C/0mUZpTLBEltG2akOezTfJd0+x2PzAUL9GWCfXK1qmK/7vGv+kMQa37vV++eCF9t9Po34nJTUcFE6/vp4+9HxrQ9iywvM8Wcjs6PsHVulNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=of0VzLVV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJICtQu027393;
	Tue, 19 Nov 2024 18:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OA7MrYZlCaav4NenyipKox8rxFNAojc9AIoQx95kSxI=; b=of0VzLVVAORsAYX2
	c0redQBP1enn7UByQbrk6noJL4hAoPJxwYd/GOnoxJCMijTlsRJm5Przokwf9xlj
	qfZd9zZhTt6KpNvCRJddpc/o9/05BF4zCnpG8sZvZ3Bt2v7U41lrNKt1PQVfLqzw
	U7kDVHSnSPoDt/OQqEpxDRgw70NjSDa7QH24blPI8ElCF+MqWSnlq+HbrdCJ2xzc
	7Bo9dMZqMDuOJLV6nMfbhqZKRQsLVjfpdJlKoqNLavnaWhD2q9B+aWH1TF70qHdh
	vueOhFFtPbJXg7ugj81j7rsT/KtiNjfWnB5P9bW7qDuWRPpuW3MNbAWadreua1xJ
	qoi2aw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y6ugn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 18:17:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJIHVAP018488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 18:17:31 GMT
Received: from [10.111.176.82] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 10:17:30 -0800
Message-ID: <d8bb8bd5-c353-4a2b-b22b-5b24ba423e10@quicinc.com>
Date: Tue, 19 Nov 2024 10:17:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix endianness issue in struct
 hal_tlv_64_hdr
To: P Praneesh <quic_ppranees@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241119164516.756478-1-quic_ppranees@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241119164516.756478-1-quic_ppranees@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3FDQpSSGsHhyeGHr3i6s3S0ILxNxxoFY
X-Proofpoint-GUID: 3FDQpSSGsHhyeGHr3i6s3S0ILxNxxoFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=904
 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190136

On 11/19/2024 8:45 AM, P Praneesh wrote:
> struct hal_tlv_64_hdr has a 64-bit member that should be in little-endian
> format, but the current definition uses host byte order. Fix this by
> changing the definition and updating the corresponding helper functions
> used for the byte order conversion.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


