Return-Path: <linux-wireless+bounces-12555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A6796E233
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB331C221CC
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF74817C991;
	Thu,  5 Sep 2024 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LcDGCrHp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AD16F831
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561818; cv=none; b=ZNEC5GZlWAGeMzWlpU3u5e0pUhny4rETAeymSMFKtAOyzsqrbMdpN21HuvM02ogC3Irj9zhM8+mVCy1WPBXHgly6WhFisWpcDYsJn7jJFwhI/U4zeShxnBNw1/Epcu7eTxLP1yRuzVZ//Fkx4BtzK+79Uoj9py1M/yXF2RhVYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561818; c=relaxed/simple;
	bh=ZXZOYUr8Y4+2dX/dtwJcz7Ri225ABz/1FBmfFdhBW2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U1C3l7+tC0FYyfAkK84PymRorPfWCnITS1fZyWQp/9Y3mAojnQYCT8tC0mmMny32G+3p2PgCjzp7qoZAvN5wurfuHP8aMDouwCsGsPCW6oBsc7RkgSuPlAS7hVHEtaDhA87bhb/VeKAP+YEKik5DYn+SXhoXZUACft0RVmS0jVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LcDGCrHp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQ5Gb028369;
	Thu, 5 Sep 2024 18:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xXlTRihCCSqgPxuwcgPJYJ5eZgx3zxOwIMa6hYSFGC4=; b=LcDGCrHphfIVY2ma
	pgxA8R1tQI60+4XEEcGJOQlaYY1MEpO3/XXWMhErxAqgOVFsCX6/hyQhHWAVrw5t
	OFLLl3zN24sk8zKVfRBsOA0vvqtjEF4i0QOjNdA9SFyyi2cFOOEcGgDBsyOHWsIl
	uddaqXGe8V1+uNm+uNFSmBBIBmM2piPoWFz1+sX9ltejDGUNZ5mF4gVJgK9BGQvd
	r1dCFiZpba7izwKjPendYsT/9F/FYU+6FVDabSeayix4/oUr/BZx6eqduxt3+STG
	bnQ10Xtdc2Zz2pzOb5on0rCE0HYvSwtHMyDgtWO9OMOpz3fmDSeZi4JBSy2a1taK
	kUAQDw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu016e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 18:43:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 485IhVgt017714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 18:43:31 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 11:43:30 -0700
Message-ID: <6a01ed79-0061-463b-a858-8b955c0a9370@quicinc.com>
Date: Thu, 5 Sep 2024 11:43:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: add hw_params for Atheros QCA9377-7
To: Tomas Paukrt <tomaspaukrt@email.cz>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <5b0.ZbQt.6HOR0C2EfXi.1csPuN@seznam.cz>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <5b0.ZbQt.6HOR0C2EfXi.1csPuN@seznam.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aghexAE6FCd_MiZic4PLyJFxQ4FXCDIk
X-Proofpoint-GUID: aghexAE6FCd_MiZic4PLyJFxQ4FXCDIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_13,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=531 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409050139

On 9/5/2024 5:03 AM, Tomas Paukrt wrote:
> Add hw_params for modules based on Atheros QCA9377-7 chipset like
> 8devices BLUE bean or SparkLAN WUBQ-159ACN.
> 
> Tested-on: QCA9377 hw1.1 USB 0.0.0.111
> 
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


