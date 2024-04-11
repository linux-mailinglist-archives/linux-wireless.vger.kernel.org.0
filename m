Return-Path: <linux-wireless+bounces-6200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B728A1E5A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 20:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEA1288993
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2F4595B;
	Thu, 11 Apr 2024 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JZ8iHNVa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8F481D7
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858812; cv=none; b=bVXSIOI0k0Fpx1xflkLwUZSP+YWYYG5dqJ73W4ZKuM6IgGiFfGAzyeHfEdLk4b1tn0kioI0yC6u89Ue+jm2tnYYfHoBELbxugSCp6L57VScOfABznUF8crTSXSsDqOUh4qRnkWrUjE6FL0k07FDHiB1H0YOO+sFl0eucd0xKHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858812; c=relaxed/simple;
	bh=kGRhUbWShFDV0Fz3VQBUAFF9WI0CAljVqy9EJR0FwV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I+eoXowKSI+grvY3LV4YU8LU9gkJGDY/C7cExPmMaWhBNSZXeFk0Xnsz5hif2VJhbazw6vf9pkrkAos1YfDAqMbPhfGSbb2ZclkCDiCng+OyDSWK+lmvBeHSmHkXQdU+RUcsd/rWIMmDcbB2MR7rSjn+cYOklBM3xIZvLKOFjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JZ8iHNVa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BFtMlZ002958;
	Thu, 11 Apr 2024 18:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=w7EOp/O9vdOyJkRHXW087/jB816koTE/NdmPpRB0F18=; b=JZ
	8iHNVaG1QPhieRY1DWRsgH+RXX7HIblzeKnlKjti3cC4R3QaMjFQEonZ/fVVxnCH
	kZFLDcg1dw++GDvtyYfOlKpbHPED/CYYWcDsl86TvdMZvPCf1DHVIscFCF11YPqR
	9GzFF3k7dz9ZG8397FHaRExDP6uTZ1cFeXvvVRCGRHc4W4+6nYlwts103hD/Yf4Q
	zAorY1Hg+ywrS+YBk4LatMfREAFVT0OKy6RY488CxqihbzDJZmpUBn5yjcWQEORD
	WuqApaXdrXcOixy54M2N7gPQBQqoTh8owIBt/tUIU52I2KVqzrlpe/E1OeM7eUlH
	HAgadp/e7cnxJRhWry/A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe5ehujnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 18:06:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BI6i6h021315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 18:06:44 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 11:06:44 -0700
Message-ID: <8ee3c5c5-44aa-4c4c-bb10-3d29f49988c5@quicinc.com>
Date: Thu, 11 Apr 2024 11:06:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath11k: ath11k_mac_op_ipv6_changed(): use
 list_for_each_entry()
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240411165516.4070649-1-kvalo@kernel.org>
 <20240411165516.4070649-3-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240411165516.4070649-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fEbrFwgOprUF49347D5xI-13Wiwzw1eU
X-Proofpoint-ORIG-GUID: fEbrFwgOprUF49347D5xI-13Wiwzw1eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=813 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110132

On 4/11/2024 9:55 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Simplify the loop by using list_for_each_entry(). No functional changes.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


