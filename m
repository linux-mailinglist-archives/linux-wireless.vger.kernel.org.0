Return-Path: <linux-wireless+bounces-7409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7FD8C1C58
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1793A1C20FE2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 02:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD113BAD2;
	Fri, 10 May 2024 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RoejC2Xl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35E13B79F
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307470; cv=none; b=dAiALYRpfLH8G66uXXx0Qz7mkx41n7BlCRp5zdMFeS+4GfOqYQviPTzBjbEAciEaR4+4qWpnjd/N6BMqH79BO3b/Fs/B8oIYDEeo8jmZzl5YSW92gLTZ9MXOuYhyy2VIGHtT1t2DtDQKYdcpfe/stHd5bLuoXz5JUKTMYhW8w/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307470; c=relaxed/simple;
	bh=jdOPDm74KVDQAJKCPCNxl2nVUDx6QbPOW5wqJE9gDIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ANWZc0Rpq6A8BfCrLU6s+bVoR+a7vrCJ7qZRl7rZNIXY03gYr/kvgfIB/XRuHlep1HKacKwoVRf2EreHa3bsym9qjCNLjk/sPeSEfvzB75KAwCB6IsFKzWwfc4UWJKGPgevbKKfJG5UfGz3icgcpdCQRQtK2+vgW6hlhcKwNdK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RoejC2Xl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1B6Ik000724;
	Fri, 10 May 2024 02:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7r9gKm0Ajz5X1tmDVy2x/04MjMN6iBNq73xhX32dIXk=; b=Ro
	ejC2XlxD2ySaeNXIzF760VpQxKzIZRLwDINTkZcBJtprmsIzjEwWngEp+kvnhbnx
	DnSkNv5MGwmrj/vIOgdwoKZCfeL4RjXVh+GClrHFF47rlrW84TRv2XgrOsLoFkK3
	fq8GECtHQwiOVkFKpCPz/RNVnKZGr9GR/G0Xc5ZA0gWYMkntP28DRxyu6HWS7TuM
	AMtOKrQIuB8WPDDLyBTwZNtVyT7ZTCSAkkNIfBHNF7zfjVE1xBpmtQ6DcZ3xKHpJ
	tyR5Hsn9uRgvuOOfv0MwbHCx56Wtg+Qqm3+0tJRBBk9ENUbkmAlWpUe1Ox0QLrv1
	P9HQHhiYBTW4JZm3cv0A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w0rbne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:17:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A2HcVv008845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:17:38 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 19:17:37 -0700
Message-ID: <eaf65a38-2e56-480e-9e05-2fc2a36160e1@quicinc.com>
Date: Thu, 9 May 2024 19:17:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set
 to mac_register api
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
 <20240507045702.2858954-6-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240507045702.2858954-6-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WjIXjCf14SjrKD2_jHnMb2nzyuo6EVC0
X-Proofpoint-ORIG-GUID: WjIXjCf14SjrKD2_jHnMb2nzyuo6EVC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_01,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100015

On 5/6/2024 9:56 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> When hardware device group abstraction is introduced, in future, a group
> abstraction is registered to mac80211 rather than a particular device.
> Hence, setting ATH12K_FLAG_REGISTERED in QMI firmware ready event might not
> be ideal.
> 
> Add changes to move set/unset of ATH12K_FLAG_REGISTERED flag inside
> ath12k_mac_register() and ath12k_mac_unregister() respectively.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


