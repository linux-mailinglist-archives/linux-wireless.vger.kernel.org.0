Return-Path: <linux-wireless+bounces-5122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76B886241
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 22:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB5E1F22024
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3B135403;
	Thu, 21 Mar 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U3euUY3A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F812B171
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055301; cv=none; b=r3eOvtpKmcbLdrpWruES6Ho31ohke5GLy9bBzVNjRzSKWpscB3gAjNTo5AE0cLZ6JDL28FbkvEflNo3cS7KByK2XB09rBzXxa6mZpdRYfnxZm3r3QTdiTFcs2cfueLjJbIGVnip0/ALGRJ80KRTuIEuW7xtZPMP+ZGJ8WtTH+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055301; c=relaxed/simple;
	bh=JpVNcP3REzWhvCbnmZ56Hh+NKGYjzq2r+3QwTAAvqmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S7t4int85EK9wIPPwBrwCOec5uiQGJKbE73Hy6uTEBjUuCsTud3Z9TkwCXWiv9qgDtSVJBJljgcoTWb8Lqs7p4pfEzDU2OS+iH6qmn4GzX+SBI745ncZGokhZhDWeovt9Slbd4tYKOHMfARWqXBWsqAtPIu7FoxSxtvcOMlwYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U3euUY3A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LKc3Xv028083;
	Thu, 21 Mar 2024 21:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uyppWcS8kKRb9nHQUOI18piwOw0wpgn/8HwrGeFyI0g=; b=U3
	euUY3AJeEju5i/yGzcrlW7GxWKgWkRLs6d0dtXnw8QeRtdIHhCZBjqY5Eam2KnIE
	Z8a12PBFyWj7qcI2pcgX9mxxbrnzORgtz3t1m/5EWeRBGkPjp0A7LUJyiQ6WnOhZ
	hst/ndgzdiEtj44XRAJniPJnzW+LNvRVUXYJACle6/+g+xQjbnBHOJkJTEPx3kCr
	ivByE56zSSifQOLEUKV2ZpP6Dd6SzWRGZU2hrs6MwqgGIdfdGe3jzXuAj86cinLD
	yOUYrfzX4cg/8uIutuDsx3KcUKGD3oKfa3LMNi7lvBn54FPvUKlyAA/gZlANB68F
	jCjkCHq6UcqOyqBV7b6w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0trh8704-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 21:08:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LL8EfP016372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 21:08:14 GMT
Received: from [10.110.74.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 14:08:13 -0700
Message-ID: <1a922799-6e48-44c4-9d82-850933aae81f@quicinc.com>
Date: Thu, 21 Mar 2024 14:08:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] wifi: ath12k: support get_survey mac op for
 single wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <20240320190943.3850106-13-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320190943.3850106-13-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QVIG6JCXf52L-ZVUvEIvVIfMIBtJFfvS
X-Proofpoint-ORIG-GUID: QVIG6JCXf52L-ZVUvEIvVIfMIBtJFfvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxlogscore=786 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210158

On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> The radio for which the survey info needs to be collected
> depends on the channel idx which could be based on the band.
> Use the idx to identify the appropriate sband since multiple
> bands could be combined for single wiphy case.
> 
> Also use the channel idx and sband to identify the corresponding
> radio on which the survey results needs to be populated.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


