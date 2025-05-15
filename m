Return-Path: <linux-wireless+bounces-23025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB57AB8DEE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB64117B8B9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8851D54EF;
	Thu, 15 May 2025 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CNw/STc3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89267207DE2;
	Thu, 15 May 2025 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330627; cv=none; b=bnnXK7mZYDHdjK9aizFqXrzX0OJ1JK2T8XE6ntDOrmejDhAvf3me+Fr7/iTj/rglS92GlKjwSDFk5zhSxTOSMxcZFNojBTadG8uogDv8124Y06Zc47PtBSiOdbYDyEc2YwFQ/ueNK+kauYkflJ/zTxCvdP1B4LbVtBtuTAlvmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330627; c=relaxed/simple;
	bh=nlxANpg2iMYjjUATUblVQZtJXcfsP6FSXK2spRfUtCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=faNpIv7jmxfGvvwP3eSgwsFVU9ZAQqSmX/yZvbJda6ZcF/vgtLAMpaunplN1SViClJySfqQFLk3lXMLZ8lxg/KSTDIDu2Ql/3x6r82izi0AJLDfzAa6qM5KNF8zms8b4P37AAgu+Px6HPPvXvbsWLhcckWBTGAk+/GPAbZQBbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CNw/STc3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFBbT018190;
	Thu, 15 May 2025 17:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	28kQjLma94V279htA/iRUZ04/rNy/zv5ChEU82zgGeo=; b=CNw/STc3afD4WTn1
	yh1dl7t7QFwPNjMuYDbE5m0vbCJNcQ2+kKFi+wmEQ6xllgQY7/s622i/BnsiTZsX
	OVHEC9Tg4u1W6Ts6tJmda6GiIpOxRkdlIS6E7IKnIr+p7BKjkHIkXXcxAM/H34pM
	prk5+iN520le/vuPo0/99hgTbjJdxSY/IfNHowzVvT5n0Rk84CA1amZLkoMnIA7K
	5aWqA/MmoEX3wxcJCbvbpnS08KOph9Qvgs7RMEY7ywCtei6y61QeOOfZfiiWYNec
	+xUB7LB51atfYoJrJhBirOXaIDuijD8Eo6QT2bQqXosTnX5d+9SGaVvlevnTp1+w
	GP8AMw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnq2qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:36:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FHathE025188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:36:55 GMT
Received: from [10.216.54.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 10:36:52 -0700
Message-ID: <45758365-5f5a-6650-ed30-1c394b9b81de@quicinc.com>
Date: Thu, 15 May 2025 23:06:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: clean-up during wrong ath11k_crypto_mode
Content-Language: en-US
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, <jjohnson@kernel.org>
CC: <~lkcamp/patches@lists.sr.ht>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250515004258.87234-1-rodrigo.gobbi.7@gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250515004258.87234-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PReVneVIMXdp61uFzSqd7vfdKRfVb5QO
X-Authority-Analysis: v=2.4 cv=aIbwqa9m c=1 sm=1 tr=0 ts=68262638 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8
 a=FEClEzSTKUsJnvQcYz4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PReVneVIMXdp61uFzSqd7vfdKRfVb5QO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3NCBTYWx0ZWRfX8I8f056ANsqr
 89fH4uIJyLmC3HgoVn3Rvx6Zl36BTt/61BiOID4jxePEQCkmxYxnCD+G6iaJXrkt5tUqC5shWQM
 ZUMMmMAO71IL2LJIwTeEaHwyKRKZEHJNzyyeKpxw4utPrrg0iUx/H1ntsfs5c5oitrIsCWAPGfg
 WfYdFss4T8UaGhgyqdHvON1OzjFqOaLbfxK1btisN5S/Xnvc37NQyY+aeN9SbwKBNx+rxKnFfue
 ATij+b85fLQ9uh2Y8/C9uFIq7iz1yy3CtQt8uh69AWthwR9O3bWtYpEUMtOrtOBcwLdurP3fmm2
 hJjCh/Pvse8Qj1zXRwfiYqP7S6R5n6OQAZiacRNjePLmeRCP9yrdsh3VxYlQboWQlBm+XGhxh5H
 6gcIaJrmUgLpnGiPhGNgryOjGQyA7im7Qx7DJuTl+wpg6NmRtHeWr2x5ZVxnI5ImJy4qAmgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=957 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1011 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150174



On 5/15/2025 6:10 AM, Rodrigo Gobbi wrote:
> if ath11k_crypto_mode is invalid (not ATH11K_CRYPT_MODE_SW/ATH11K_CRYPT_MODE_HW),
> ath11k_core_qmi_firmware_ready() will not undo some actions that was previously
> started/configured. It's reasonable to undo things during this condition, despite
> the value used at ath11k_crypto_mode not being valid in this case.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Smatch got the following error:
> 
> drivers/net/wireless/ath/ath11k/core.c:2166 ath11k_core_qmi_firmware_ready() warn: missing unwind goto?
> 

This warning message can be included in the commit message itself.

> When the ath11k_crypto_mode, which is a module param, is not
> ATH11K_CRYPT_MODE_SW/HW, clean-up actions are not triggered.
> Considering the whole ath11k_core_qmi_firmware_ready() function,
> during potential errors, those actions are properly triggered.
> I'm suggesting a little change over the default case to clean things up.
> Tks and regards.

This can be dropped as it does not provide any additional information.

Vasanth

