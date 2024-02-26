Return-Path: <linux-wireless+bounces-4023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D97867FFB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 19:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E29E28C421
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F25912D77D;
	Mon, 26 Feb 2024 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SNk8oGBz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E31292FF
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973122; cv=none; b=RkpaGAFS/4+FF7/fU11EaYvH6PEYS6+bl04HxAr8WHyu4askgE2XEWaBBwN/9gazzuZvo8mIPUywaX/vYedR+//Ksc6o1ibWR6fcPKHJ5lrM0AebsOx5vTEz+X441qUyREUeB2XiXXfK/pGFYSkDg3m1TOSwJ12vW8R/o7iSFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973122; c=relaxed/simple;
	bh=Aa63NvrpwDJUZql0INXu5eLH4YRVoUzu9lk2cnpJtW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hNb8NObdzAmaEZ6w9hxlyL+8LoNAfx0uYFYcPHsqTXd/vMiuwBta+XaUjyQ2sZ2Ndb+npSacSLZcaNLaCp1PRQyqoSgfLJWNIliwT4KrTSoMgZwJ0kKRcemVVAmCAvxX9lfXHvttLmRYwBgycacUGY9JVL58kVRQ4IYxDiAS06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SNk8oGBz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF8LlO025416;
	Mon, 26 Feb 2024 18:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pzgJ05ceTZ+mmQ/d1ecGYIdk3UARvMSpKghtJDV9fTM=; b=SN
	k8oGBzZSViyhj+k5xCzYCemJeIe8qeHKuDiLpML8A63ZYRJ1ARjhziOu2QSa6bLe
	XQ9evJSMD0AekCoT7Z7+3bZfYpwqXLaSPt4WCxdcAdtebnDp90WbuZUDh6ls4H1a
	pPM3o8Fw/v+9tVEJ7wm+cQ7FIAfym25HkwhbRcjYQJ73z7Nu1RTDCifK5l2l5bl9
	98zW6rhurgFKgKmZBxt79U66YydOh0EtXC3+EoudJzMoq3xex963CDQzd1JfVkOA
	dmH/IxN3JFIzJoeYD7zVae0O3V6ITmmCa43g9N+KECWCqQHlBYPO9pIS/0xvF2xC
	uYeBYiVnIVsXaHZ81d1Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxnht4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:45:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QIjAGa012406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:45:10 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 10:45:10 -0800
Message-ID: <987c8f9d-ca21-41c6-b7f0-5c66a636ddfc@quicinc.com>
Date: Mon, 26 Feb 2024 10:45:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: Refactor error handler of Rxdma
 replenish
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240226162310.629162-1-quic_periyasa@quicinc.com>
 <20240226162310.629162-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240226162310.629162-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MssdKHtk5_O4MDlNSZ-g48ZNqAeYWbJG
X-Proofpoint-GUID: MssdKHtk5_O4MDlNSZ-g48ZNqAeYWbJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=642 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260142

On 2/26/2024 8:23 AM, Karthikeyan Periyasamy wrote:
> The Rxdma replenish handler currently contains redundant code in both the
> success and error cases. To avoid the redundant code, implement a
> conditional jump mechanism by placing a goto statement to prevent
> unnecessary execution of the error handling code when the operation is
> successful. This change streamline the code readability and enhance its
> efficiency.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


