Return-Path: <linux-wireless+bounces-5843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 270FD8977FA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D710E2858C6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBB153518;
	Wed,  3 Apr 2024 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WK2+UiOX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5A1534F2
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168232; cv=none; b=HrhI0DbWHH8jpXZCFMSgLC0Stp2fULpVai9e6Q6z5/fqMdGP/+bdlbZ3jt/6vpDt5odzF3xm+eOTbj0v0kA8XQzVJh9wkoEVwaKJymvLKcWwygoBDq8iWLkpegYmPn2Fb4hTt7U0ugyOv/iHhkg7/jofoJsFE63HcgWEqrBqUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168232; c=relaxed/simple;
	bh=ZyGCBh23lyEtR/s2KNa1O70iv+hEnmnEahG9ZHNvdCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mj5Oq7Hz1GuOPeQ3NYqiwdh5LHrJ7BWn2ItIG0OcJ8qASkgdGfCWsSiaVPcZn1vLG7WpyrPme20rdP8sSvBBfEpbyL+IwWDBR/EPKwCcikk7x/4ZPRjl4oSsOc0pPPKBDB2mLQkqNjLxQjFAOA5o2WLmqHMwUujMFOfLUwjgavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WK2+UiOX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433CAHOF025635;
	Wed, 3 Apr 2024 18:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5KMiA296Ptd+9tb2LFiHnnw/Lhb+ppX8TnWQIk0J4KU=; b=WK
	2+UiOXiNtX4k/LZy1XWnH6AvpUF/PiN18XQcf2A3ruWo5dxHzkXq8TwBse5NXRJt
	9fAnTbsetGHWCS5N3dQH7V5JFq3wR3WmKU61kGmGf2HzJd2z1Uv/KGUKwiKcvyHb
	bPbk2icolYXiQCHSw0tPo9NvMjRDGx8ylvKyoN/kcnfusqQbeY7bLROzg5KUy6hB
	DaxuLhGB5JUE1Q81rPZ7pWLZz1eR54kFeVI2Zlt9BgcosCfr4q2Rv6nUG8wSs3Tq
	AcHiCuBRsu1bM6milngBWHGpHbfxcXG85P/eHySAA6Xbv/pGOi67S5jgYCGURsoW
	Tp0LDJGmOMJCyqN6OqlA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93pw9fcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 18:17:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433IH6XD021240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 18:17:06 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 11:17:05 -0700
Message-ID: <cdc839f8-0898-4bbc-bdf2-b06ec76e071b@quicinc.com>
Date: Wed, 3 Apr 2024 11:17:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] wifi: ath12k: create a structure for WMI vdev up
 parameters
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
 <20240402210538.7308-5-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240402210538.7308-5-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y3eUFeXgeMulK9_jnSXt8m1OX1DSkMsM
X-Proofpoint-ORIG-GUID: y3eUFeXgeMulK9_jnSXt8m1OX1DSkMsM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_19,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=586
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404030122

On 4/2/2024 2:05 PM, Aloka Dixit wrote:
> Host needs to send multiple BSSID configurations to firmware for
> each vdev in ath12k_wmi_vdev_up() for AP mode. This function accepts
> individual input parameters hence any new argument will require changes
> to all callers. Most of these will use default value (0 or NULL).
> Create a structure for the function arguments and include objects with
> all members initialized to zero to minimize future changes.
> 
> Tested-on : QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



