Return-Path: <linux-wireless+bounces-2854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58610842D13
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 20:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850651C24E02
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 19:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5DF7B3DA;
	Tue, 30 Jan 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p5H11ov+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716127B3FA
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643586; cv=none; b=WZ8bX8ivT8ISwAMsZzyXnjO9AtydMGCfl224AgQ8n3H3wy4RdIESFVClte0y9YpoBkesXRX76VWeEpdJQjFJUdkkJeUc1VpF33p1FSuuy7IqckkHdc6qg/+iQu/VAJMR7rbNVc4cgmusbwQcFpkEDimc9IA84WBtXR4TKXnfe8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643586; c=relaxed/simple;
	bh=NtsVMVcGMkVBGoXDcPJaAF4R6znvjf95/AjJmVMrjQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jZbfOsCcnyjqjzSQxICnI7pR5LaO8cUx29KxdtoWpC0WUMl/PS9m8YjdR3blOIH195/BHVc8x2t/9gZtY7EvJd+Gr6ddck51tQb+9pj5Dydnht5GTuVhPmW604O9DmVMUItsk7kt9KFi/Itods3c4eAUqSC9o93SHkHFm9UeknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p5H11ov+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UJDEmp017907;
	Tue, 30 Jan 2024 19:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tCQIto8QgTKfD6R2WbeoOYijRkc9qs1t2QNAo7236fI=; b=p5
	H11ov+IZr5UyhUrRSvjKguf7T7hFwsqr92FX1xIW6A7uIzzapji1JTtSDiBe5ph1
	wY512380EwMZQ2Qs0RKuY9dKklyHUdGeTVuEsnMrE9LLdkjVPaSuMb6xb1T2AikM
	06G7hk5pcE+AWhHNBBqMAPmbRjeDXAUmv75LqLQcUXPXnovso/EW9V61j4F5auvx
	1zva7zW0p5iK4Sps1kMX2McY4ZfslQ45fxNVpeFwRfh61gj96aTv1giW0t1Q0aXB
	K0QNx5jap+SxOc8fHxvHZZSzgIwECHoq4Jj34qel0BazqDvTo5tFYW0Kwf0fy4aO
	ClPdDjEL0tUomMjhnrVg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxrq0a5je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 19:39:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UJdeFs024958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 19:39:40 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 11:39:39 -0800
Message-ID: <1525e3a8-3ae8-4f64-a562-43edbd73b532@quicinc.com>
Date: Tue, 30 Jan 2024 11:39:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: Refactor the hardware state
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
 <20240130060838.3895599-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130060838.3895599-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nz48oYyrSSsgXfeyH-UY-kPDwi1xiBwt
X-Proofpoint-GUID: Nz48oYyrSSsgXfeyH-UY-kPDwi1xiBwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_09,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxlogscore=455 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300146

On 1/29/2024 10:08 PM, Karthikeyan Periyasamy wrote:
> Currently, in multi wiphy models, the mac80211 hardware state is maintained
> within the radio/link structure. However, in single wiphy models, the
> mac80211 hardware state is needed at the hardware abstraction layer
> (ath12k_hw). Therefore, move the hardware state from the radio/link
> structure to the hardware abstraction layer (ath12k_hw). Additionally,
> update the naming convention of the state enums to enhance clarity and
> consistency.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


