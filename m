Return-Path: <linux-wireless+bounces-21033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB0A78204
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 20:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637803AEB7F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42020E6E2;
	Tue,  1 Apr 2025 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KFoLaM2v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544620AF67
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531738; cv=none; b=lUS8n5K5H4ONYLgwL2oR6kPLpV8PT1O+T9iW6D6jnhXhNVLBjVlnfab8DmOVqEKgL2wjdt4PizOOnZoH2sz4gc0C37lwuNvvesFj8gq4ldSyS43XOP4aIuTQ0PrhC+hjY8BqpljK1Qj5xzEHucMtxb80z1ZWu44c5nnGoXnpVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531738; c=relaxed/simple;
	bh=9JsbEqmscVsk/u4UtuDxNgvvINKcSgfjvX7HtHvlxbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OwEqLU/oGnx37dMK//qe6fXhZjGabxzpIeGBuMnYWscdIz4x8mfxY1QinOlGS7npZ3BmBecA8TIDkXZXIOuu6wyBuXnZBT0WGF4MvX8c9GY2BffYKhLf3bxqkRMPrct2nTiO2gHm52SKvfdDiR/9C265sWRvsqmI2fmKB9MY3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KFoLaM2v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531BQf12003381;
	Tue, 1 Apr 2025 18:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G/PpNSOWbV3gQOyOzGcf+qVtRhrsjKUXPC7D/sIA998=; b=KFoLaM2vIK/b9ZDO
	7/OqJ6p66bKMLlFMHZmDDyUBv397hOeQbCPPSsGKTleJaVM1q/EnNvv+nP0gqjI+
	xvGN/3IUO4azZgy4sMJaGLqgYCxbPmxevBDMaHOep4F0FisjYmPAwwpK2pxyrozJ
	SBnISDYSgqPCrBxgRIp/qMIgRD2eBvfIzyO4rQPYEcht2fjw8oLSg0K9N2CuIFoK
	4ooFr9Z18vpOol2TRgdcg3X/Dq/1ADTdNBc+c5d4Q32sqEP9JpmKqoWaj0KP1USw
	bY00OQCLguY/2Q6wQxK30kwJFDwFcOXT6fnbewvmnt/EsAeaY5juzk29sZ7L70e/
	Y7BHGQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45pa5brv59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 18:22:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 531IMCMA003350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Apr 2025 18:22:12 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 11:22:12 -0700
Message-ID: <5bdbeb98-7be3-461b-bc49-06b98e183ab6@quicinc.com>
Date: Tue, 1 Apr 2025 11:22:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V11 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth
 support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250220213025.2722206-1-quic_pradeepc@quicinc.com>
 <d4ed05c7-41a3-4f99-89f5-72d2f8050b24@oss.qualcomm.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <d4ed05c7-41a3-4f99-89f5-72d2f8050b24@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eqb41zC_ZrTXH3Z0G7dZh3UNWYFi4bKy
X-Authority-Analysis: v=2.4 cv=YqcPR5YX c=1 sm=1 tr=0 ts=67ec2ed5 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=I17clQHheAOnIKnWeAEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eqb41zC_ZrTXH3Z0G7dZh3UNWYFi4bKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_07,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=434 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010113


>> base-commit: f22471c17f5849b2f20e2c56ec9fcd9dd8d5bf28
> 
> Sorry, this has been stuck in my backlog, and now it no longer applies.
> Please rebase.
> 
> Applying: wifi: ath12k: push HE MU-MIMO params to hardware
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/mac.c
> M       drivers/net/wireless/ath/ath12k/mac.h
> M       drivers/net/wireless/ath/ath12k/wmi.h
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
> Auto-merging drivers/net/wireless/ath/ath12k/mac.h
> Auto-merging drivers/net/wireless/ath/ath12k/mac.c
> CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.c
> Recorded preimage for 'drivers/net/wireless/ath/ath12k/mac.c'
> error: Failed to merge in the changes.
> Patch failed at 0001 wifi: ath12k: push HE MU-MIMO params to hardware
> 

Sure Jeff, Let me rebase and submit v12

