Return-Path: <linux-wireless+bounces-6878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26D8B2A6F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2D22811F3
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182F15380E;
	Thu, 25 Apr 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hfcZJ0n/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688A152E19
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079388; cv=none; b=lMpRn03/Mv3IrlE8RS0nJq4Xulxz6EdFXp67gbjQyVgUakQwBeEtMca3Syo8laDmnCpE5mp5DaBYHU6hfl90j+lVPBHvFwA7frH5zLenI3VeT31QB8Et5E2PwyNfWrAedmzNkFUUeeaEt9sEEDIK/xp6YKeaUaJM58ergn/+n+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079388; c=relaxed/simple;
	bh=b5UD1rPwuk/pzB5dV4rkipDjC0NbP76zw3f/ZsJ1UZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E4hfgmoXHnO0V1p95FO8ApV9mXCWE5CAYSVKa9jW11ssWAtrbwAUk3muxbbaAZHrinU3w37MJrQWequg/tiJr5NryW861YDmClYRTEJWGYYc2d2VFW1yY17kdkE6rUpnO5KczSV673B0PgRwxfybGGJRk4EaUiuENVMkt3f8VNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hfcZJ0n/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PGFwZP017320;
	Thu, 25 Apr 2024 21:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GvxRf/UXBGgOwTLlCEhY+OSGgozalwQK0VhYnFNEkj8=; b=hf
	cZJ0n/MeUVY3h6Juymu6XG4Ft1VnFTAOeUJqQulu07knNhktacACDZAZGG10PV2N
	F74R+KHDsfLmkCz5CISVAKeiBQu1c+0duZ70MdeuDsTYYJ8w6A/WSTeJigI6zUK6
	vhLb7VOMsAPTbx118xeaVUOgsp9a0pgvR7zwDZ02RzzKCCAJSlkEl5qCpZJUb4Yh
	NnR0wXQ7wT0DyG8k10pxdT4fX3AsyHpgRApWX/wtSeP9Q6dHd4LoNTn2qKcA2TUW
	B4B7MWXlUdxizoPOBuXrBDCVfW1CV0pNt369755Us3L9lC0jVLdxMks8YKbXKA6c
	z94LDIU1xp55N4+tEdkw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqthv0ks7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:09:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PL9VUS022770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:09:31 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:09:30 -0700
Message-ID: <f93764b1-808d-451e-b33c-076161dfee4e@quicinc.com>
Date: Thu, 25 Apr 2024 14:09:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] wifi: ath12k: Refactor the hardware recovery
 procedure
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240425090307.3233434-1-quic_periyasa@quicinc.com>
 <20240425090307.3233434-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425090307.3233434-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QI5yIEbqgcfXTqa8CHja2xYntMY4yH5N
X-Proofpoint-GUID: QI5yIEbqgcfXTqa8CHja2xYntMY4yH5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=606 malwarescore=0
 adultscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250153

On 4/25/2024 2:03 AM, Karthikeyan Periyasamy wrote:
> Currently, in multi-wiphy models, the recovery handler access mac80211
> HW from the radio/link structure. This will be incorrect for single wiphy
> model, as they will hold multiple link/radio structures. To fix this,
> access mac80211 HW based on the number of hardware in the SoC/chip. This
> approach makes the recovery handler compatible with both multi wiphy and
> single wiphy models.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


