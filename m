Return-Path: <linux-wireless+bounces-15008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC79BF34C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 17:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F0FB24D52
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F00205E3C;
	Wed,  6 Nov 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VRvMv7Ae"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E473820605D
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910822; cv=none; b=AtZOzDNFz0ohGnwraeL37zoJg9ucIq1UHylgQeHe3hsbkOB82YUa3Xro4Yx6FWA/wECkGhEbHdQ/vysX0Aqgb3MN8AomZ3zuWClW6WKK7rhd+x8Uu9odbys1TM87RG4VZrZpcaTDcOtjXNsTtT7aMVNS10mpssghcwM0+QRhQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910822; c=relaxed/simple;
	bh=cjush3NHDEznQZiKw0oVzLf50tfGD91czZ1ODminrrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HTm8kVDIv8QnUsnIy2AHVJJLtJfZ6a3pU8K8UMmIBhrkF35TXsrUE7b33YLXcHktej7aprb9IzjrcmLEi516N8lye+eDAnJNm1SEKlNuG4JVsc2eTLltm7SCToOBwpqQ4WLDBv8NaKnNyIxD7hTkwhCA3o9p9EMjdjvmzFHh6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VRvMv7Ae; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A66vJTW003812;
	Wed, 6 Nov 2024 16:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FOBv98caloMnQ5eldDCXhGpaYdMfDY5H3PCOeAOxzN0=; b=VRvMv7Ae1QZUOD0I
	bGEU8hKE8M+quPDW4V3lmUP3SpHqLuBJ6IP5bYGgVH5oRdbvbxN6+/V3XM8CVzw7
	te+kUBsZWNRFVYtEqhXIfRKt18S69Noz8Ja955TR2T+R1zh1N4b1qFiGkO0mplB6
	5WIqLKgmMTLKt2A2WyRezDrXg4wQChGZoFlI0Yiu6XvUyyIW5/oGpcKitcTe5rm0
	5IGiNnaEcESsiruO/IcxE51qS1VBKqWO5IYK3BYJFgobZ404/ekNd5GCFI+pvedQ
	qzDYU13SlqZbknyflaGpQSqZyjWIVi3VSolacgevsD2tSAEcb+fq7VVaGGH7Z9kM
	3uG1Mw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qfdx4srm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 16:33:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6GXabu004756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 16:33:36 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 08:33:36 -0800
Message-ID: <395e1dfb-2918-4a97-84f1-c61a8ab68278@quicinc.com>
Date: Wed, 6 Nov 2024 08:33:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] wifi: ath12k: modify chanctx iterators for MLO
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
 <20241106142617.660901-7-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241106142617.660901-7-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PSNHGsb-1iFe9wRXdlGcOkk1cktjtEO7
X-Proofpoint-ORIG-GUID: PSNHGsb-1iFe9wRXdlGcOkk1cktjtEO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=641
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060129

On 11/6/2024 6:26 AM, Kalle Valo wrote:
> From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> 
> Currently ath12k's chanctx iterator functions use deflink of given ahvif and
> bss_conf of corresponding vif to make sure the iterator returns intended vif.
> An ML vif can have multiple affiliated links each having its own channel
> context, hence iterate through the links of the given ahvif and use the link
> objects (arvif and link_conf) to make sure the chan ctx iterator returns
> intended link of the given vif.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


