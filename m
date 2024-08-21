Return-Path: <linux-wireless+bounces-11753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B50FA95A340
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9F71C213FC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7615098E;
	Wed, 21 Aug 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mZMv/hQL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A41AF4CC
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259365; cv=none; b=F+W3u4pCHiJifFHYl/NcvK8I1TCxRDZMUoDnykMISv/NAKcszChMsp6NxGe/rRGp3MwKS2PIizDPkwUKacQywGhic53EtlmXq2weQuTIEgxugMGLVZ4d44ACoRPO4kl7acBd8hFv/GWW2KJPKjzfpCNgXkTEyfYn3bsGfOTdd8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259365; c=relaxed/simple;
	bh=3hDvwKRFc9Bx68QN+OXSesV5BvtspGp/eJuYhuFew3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b6yYxhvTY0yyDlTvtNTc2jIDYaLkrJcWLSx5R+hAfpz9aulYyUZFuQv1Ak6YjT25PDpsJwdTvZjK/sgFowY69j0nirayDZiX0QB2qEvNDpKtLeHTBETXbwAGEsuCofh/j8/VbxABtO2wse7a+hmOOHHVS/8bi+gBS25ynLxqJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mZMv/hQL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LC4MBv004713;
	Wed, 21 Aug 2024 16:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P96IDu99mJPZI9Kvf4dTHrJ7IuC5XQUSJPfedBEbBWo=; b=mZMv/hQLVnA5oZYO
	P8zmUzPMORRwx7uNtXA54VthVw0UIpJ2G6OdVFYWMBJNHFCVdrwAOne8xblohLLv
	y5soorHKrJZ2Z2z9tmzNBBXV/4SWoBAG5iwdWPFDlWOydxO175H0U+7tVR+he1vD
	oPb4o+ZPx9BfYKJ8A7vpRkvOsYttPRvoqvWbviH3saReaFQeJskpQEkDwDeWlKrz
	dZMcVpM4+/clKfpw6uZwncjjxolxjv5rNjqeWE+6ortpFS3T1pZXiwO5TY5bHU9B
	3szHgqhGOMYy+l3REAVN4EetzbsqS0TGkao5IZIb+9h3PqsRetaUru8jjKCI26Y1
	wY0l3A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414v5cc7w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 16:55:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LGtuNL013085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 16:55:56 GMT
Received: from [10.111.179.139] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 09:55:55 -0700
Message-ID: <5ae832c0-8395-4d9b-a226-04255682c6d3@quicinc.com>
Date: Wed, 21 Aug 2024 09:55:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/4] wifi: ath12k: cleanup unneeded labels
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240821153728.2121600-1-kvalo@kernel.org>
 <20240821153728.2121600-3-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240821153728.2121600-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HVL60o7_TLSvGn6_Lvhl0hCcravD3S6X
X-Proofpoint-ORIG-GUID: HVL60o7_TLSvGn6_Lvhl0hCcravD3S6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=780 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210123

On 8/21/2024 8:37 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> After removing the conf_mutex in the previous patch there are no unnecessary

nit: s/ no / now /

> labels in mac.c. Sparse also warns one instance of it:
> 
> drivers/net/wireless/ath/ath12k/mac.c:6635:1: warning: statement expected after label
> 
> Remove the labels and instead use directly return.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>


