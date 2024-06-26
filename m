Return-Path: <linux-wireless+bounces-9610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D9C9185DC
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 17:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91FAB2D2E5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1711850A9;
	Wed, 26 Jun 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ww/8UWnz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054018C338
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415857; cv=none; b=qskISpp5JE1ZyKLMhjN9CnlBGR/VxLeXmRFWKpK+rqDkRANveKFEL2fFOHHJPpV+r+3CKk+tWRN7RGrpJktszGH4vHNiG42l2ro5JNsmDo58a/7k4LybuGM2ISC6Fh2UxOO5mrVLDWbkc/Ad6+c/+sZL9SPBohfwVC0e9bwVU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415857; c=relaxed/simple;
	bh=dJISehPChNg280YDkqVRwTaeCEMcLLvokSJ26dLkvTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b5oDc5b0JzetWNtQ7B+8Ll3U5qMBGL8TLUEEuUVmRclBLOOTzUOWAoUKECWkgCuxY1eqYcujaQHA/BzWEeqCao7eurVUY0huXnoY2Mmg6nYjcTRX22fsUSMPatbJBC7ONxR9VBvAva7G1/sWhWJFs+MPELL7pmcTZTx5JIJCtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ww/8UWnz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfjkY029578;
	Wed, 26 Jun 2024 15:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AoVR0f8c5XaTly5lMjRvh2GcUnOM3ExOJ5sNDJHMFsc=; b=Ww/8UWnzXLjinOuH
	IBGSbvxE1yCkJq+/Nyo4JlPwZvTXD+bcF3417RmiY+PhBrTXFnOVvPIcqAXztRp2
	GzCN9+y8GxgM/RprYhJ5Z+9H+9POd790hp/sWQUwHAjQRkPiboNKzR3aYJ3kT2kI
	3OS8e2k60F86YJ3AVbWS1TPE8r9QQ4HfWxXftgPfGc5/c78WtXwozSn8L2xNmRFH
	s4vOVGP2NEbKdAnkvGsSfrPrhpywt1HaBL8rISdwisGo4Mzk5aiwKxkSd4brzOd/
	C9GVOXw1cKYqHdjkqXUuMO8LBl0vg6MkTXFCCaYRz94melA6q9k5n9l9Qi5/bm2C
	NPv7zw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6sp10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 15:30:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QFUnDt024866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 15:30:49 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 08:30:48 -0700
Message-ID: <bf4f7295-fb25-401b-b9ae-6c0fab758ce6@quicinc.com>
Date: Wed, 26 Jun 2024 08:30:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] MAINTAINERS: wifi: update ath.git location
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath10k@lists.infradead.org>,
        <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240626102632.1554485-1-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240626102632.1554485-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uBuSAKqJ3V8LeYN0z97DHBsI5P66HALB
X-Proofpoint-ORIG-GUID: uBuSAKqJ3V8LeYN0z97DHBsI5P66HALB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=886 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260114

On 6/26/2024 3:26 AM, Kalle Valo wrote:
> ath.git tree has moved to a new location. The old location will be an alias to
> the new location and will work at least until end of 2024, but best to update
> git trees already now.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


