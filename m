Return-Path: <linux-wireless+bounces-2969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7BB845EDA
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03EA1F2C708
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07C47C6CA;
	Thu,  1 Feb 2024 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m74nb8nb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9B7C6D1
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809723; cv=none; b=fnwvQCjQ6BvzbMhHnBhgKn+73RgSlYEzVmTrjdY5hdgtWKJzACn5lkJABXG8lNjdOiGfBChBYmAim8tPKGiDQeYeK7//rXBbq2K23zbNouklVhQtCD7xDyQs4Iu9VIbnFQSEz/L1a5DtBpIaiHzHJlDLdZ99Jl4S5fKWilfqatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809723; c=relaxed/simple;
	bh=m6EuXsuC/AqBy8cq9N5YxSe1xygdBzdT1zyIcES+xUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gdA5OFp7U/c13/GupkUs+pz2aJR+aSMjaxoO+OIbUMmPEP1vgpbonjIRCCMOYAGcUlp5eqjg5jeERaoc1plmov9Pgr6c24paGqWgTgcWIgjnL+j2E7Xi9LROL5kpEQ7k2VE0lzRvt7vS5xGCAuQnYTRzX/cL0AWr7PdDjKiNrPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m74nb8nb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4116PjSb015836;
	Thu, 1 Feb 2024 17:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hMseBjvnrHHdYkpAWPMC6Hdkqi93CwHfnUYtxaLgv38=; b=m7
	4nb8nb1i40q+t2ffOjs5HrTYB+FmyZ0uwjuK88jAa7NTgWz538KGJH8tn7chTwt0
	ZXJne8xpvje16V0IawZypQVHYnhkMqsrxD0kcyP8w1MKSSkiZCeO/BriMlVOVD92
	kx1TF0H/5LhhCtJ1QXhm4kjdlYvFUmhOflI+tMbVGDVcfB7ZjsNriwJIQsGVSPEb
	yu3x5AZ6FlV6Uy6AkdJdjeLrgZJiDL5BalaZBd8F4S2roOQIgYdGbmU3A057HCqk
	nCvpDd7eaOUPQDJtTD3tzlt34nYB+740tUKSob4JypOFSdRcfu45lYCrz9NzB1sM
	q0wF73x2sq81ERRACStQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0619hra3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:48:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411HmbMx016436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 17:48:37 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 09:48:36 -0800
Message-ID: <4e2a7ca6-af6c-4e69-905b-f27e1d34a001@quicinc.com>
Date: Thu, 1 Feb 2024 09:48:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: enable 802.11 power save mode in station
 mode
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240201035830.2534-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240201035830.2534-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M1MN37zIpTFZvpOniqxPv0GnMVRv4p2K
X-Proofpoint-ORIG-GUID: M1MN37zIpTFZvpOniqxPv0GnMVRv4p2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=359 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010138

On 1/31/2024 7:58 PM, Baochen Qiang wrote:
> To reduce power consumption enable 802.11 power save mode in
> station mode. This allows both radio and CPU to sleep more.
> 
> Only enable the mode on WCN7850, other chips don't support it
> for now.
> 
> To test that power save mode is running, run below command and
> check there is no NULL Data frame seen by a sniffer:
>         iw dev <inf> set power_save off
> 
> And run below command, then check there is a NULL Data frame
> in sniffer:
>         iw dev <inf> set power_save on
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


