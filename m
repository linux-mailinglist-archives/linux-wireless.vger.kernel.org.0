Return-Path: <linux-wireless+bounces-5002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D15988169D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66971F22F7F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA05A524B7;
	Wed, 20 Mar 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B6PCyZr4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF142057
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956089; cv=none; b=rRvhRdApTLwW4ptRhxkcOWclA/ye1q+dgpdK8fAkmhAzHGdwnyKPvrbX0P2i/1Y6kYCzlXBu50036H+/ZmPgnZxrwDRCpcle9xPjcv9+6m2Tu+1ME4cpYyatggxlAy8IHARbeqMJp47HvgTPd6slAsYIxCvDEmwaCFViiBIyyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956089; c=relaxed/simple;
	bh=qHMNpwbnYi/7e/eQ8nr4EuY0jZ93imGkImO7sqTHkkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UHko32jtggZfgD4QNAaWbJMf5A7xZNhZ49GwsZTwRWAjFOtQypwNQz9EBNgthaiKg5BmvTu1rP7k2U1h9B750p4Yl6GQaWX+uzYbK18FzbcJ9pp5+nbWL5wS3//iICYR4R2c9tx9By6soAmUaBIyHaCgugAGLszKW/dfzxggBUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B6PCyZr4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEm0j7007450;
	Wed, 20 Mar 2024 17:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tflTKR9p3aUMC4gWq9yp2v0OavWXBV3siZOV/n4iPGU=; b=B6
	PCyZr4vS/E5QGkUVf+T6H9UWr7wBvSrzc8Pmu2+PG7jABndEOFvb/2K/uMMKus8S
	FH0Z+eZlV0i+UhQ94iVXxnMAK/jLQx3HEh/zT2Q2rbRxdmXJvFQ2hnHHVOMh0Z6Y
	RCkyFvgWNs+FGOy45/qhvh9HL5pz1OGng3cjOlUK0kCLqfMFN4d3YpQABmRiZNhO
	hYdD8joOIdp2Tup8oSghyVCcb29aDscOPwVTA12cpeY+jhsh9TYietL5oQql3m/M
	CsyWh0lAR7C2o25nGs6Tpi5OPJzGnbYj9iTWd824uLjNZUuAkfqFe05I9QNbtUHe
	+X+Yu0vr91lAWmPeHOIA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x01br8h1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:34:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KHYcfj015709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:34:38 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 10:34:38 -0700
Message-ID: <1d9d6aaf-c27e-4eff-ad38-ca687ec861a7@quicinc.com>
Date: Wed, 20 Mar 2024 10:34:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath9k: fix ath9k_use_msi declaration
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <toke@toke.dk>
CC: <linux-wireless@vger.kernel.org>
References: <20240320170656.3534265-1-kvalo@kernel.org>
 <20240320170656.3534265-3-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320170656.3534265-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MssSgKJvnQZgqKOVrualokAgWbLiU8W0
X-Proofpoint-ORIG-GUID: MssSgKJvnQZgqKOVrualokAgWbLiU8W0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=678 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200141

On 3/20/2024 10:06 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Sparse warns:
> 
> drivers/net/wireless/ath/ath9k/init.c:79:5: warning: symbol 'ath9k_use_msi' was not declared. Should it be static?
> 
> Move the extern to ath9k.h so that it's visible in init.c.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


