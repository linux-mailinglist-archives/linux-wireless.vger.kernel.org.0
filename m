Return-Path: <linux-wireless+bounces-8274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD778D3D07
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 18:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC92B223FE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911281C6B2;
	Wed, 29 May 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jvf/NLzD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA687181BA9
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000961; cv=none; b=O+2SvFmlj0lojPJfEcF3Je+YHT805iRf/6hJAiaaDUr0MpZgL127exdiPOgyBgLkrMc7+atw0/nfn/3UVrRL++5zQCM+gapPSM0bQaSK3Mqw5r2ZWgMOmQLNnttP1zxDI6PKRxNh09UMLBGE9Kri5dgRHPvdzq4PIdmIyX4dddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000961; c=relaxed/simple;
	bh=MYgLGWWeMs3SDN6U+7Mkm4kZu0fmUCmlErT423z2lpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fl7vAPMYvSxLf2eV6OAi6qq5vu3bdj9dc3HtbG7a0+Cbb+XqWyPLO/x4t0aopQVhmf8WfejzLpCEfR5A/Qi6ksRhYUkff9BS2w9VZmeK094uMyTst5o2a4lknFnao63A1SCkeoX+k5ZxN2aOcz/hvXvxAauYswGJBL2RKDFPzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jvf/NLzD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T9JHY9000950;
	Wed, 29 May 2024 16:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/12YApeDp+kDKnV0XEs7980x0VyQwKes3OhmC3PisJg=; b=jvf/NLzDZg6lliLd
	uyxTSKF/4+gK3ESEo4+GhfFKtgqHwXllFbl+cMptGD4DymWeI2wrsGpuT/NHqvcN
	jJPL4d41rqRe/9iTIxF1QIHQ+T91EaWPKzHiVTdISzt5wMCiI4KmjH+TNSx3dLsZ
	IfqPESxG1cH8xKUKXsPl/KCNnbv1vjJiMklhGQQYRqs0aKGAinDDSuI73FYAizCI
	Iw5Tnq2I793ZHSbLZuCKo1nk/WIN8qd3lJ2Ypv7wUw4iyUCDJxCuZiReZ439k5WW
	RhdzuKZ/7BB027MZC4l+aSWKGHzAsytaVt/65tUlvirXlUhyix7WqRpqHYG0Arfk
	9g+AzA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2pskq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:42:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TGgZtB001659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:42:35 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 09:42:34 -0700
Message-ID: <decaf472-bfbf-41f2-b745-e8646d0c1812@quicinc.com>
Date: Wed, 29 May 2024 09:42:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: add hw_link_id in ath12k_pdev
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240529054955.4105240-1-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529054955.4105240-1-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2oY57XwSnQ3k6U3ecTsAk9nxj8fgcomC
X-Proofpoint-ORIG-GUID: 2oY57XwSnQ3k6U3ecTsAk9nxj8fgcomC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290116

On 5/28/2024 10:49 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, hw_link_id is sent in WMI service ready event but it
> is not parsed anywhere.
> 
> But, in future, for multi-link operation, this parameter would be
> needed by many WMI commands such as WMI beacon template
> (WMI_BCN_TMPL_CMDID), WMI vdev start for Multi-link virtual AP
> interfaces (WMI_VDEV_START_REQUEST_CMDID), WMI peer assoc command
> (WMI_PEER_ASSOC_CMDID) for Multi-link peer and so on.
> 
> Hence, add changes to parse and store the hw_link_id received in
> WMI service ready event in ath12k_pdev structure.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


