Return-Path: <linux-wireless+bounces-8815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F690459E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 22:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1371C20A2F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9F8152E0A;
	Tue, 11 Jun 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d30kiRpB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91E39AEB
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136751; cv=none; b=lArh/P3tfAAaY7y7MLWvgsd3n7jt4rn+BlVx4VxsCfDs8rDukCnRyQ+NhUbk3pUX0jky22vf25yM9/5xSnu/QE6VHQ0a+jPFiX+8A0I7I1cC9RoK7UVGpM7siUOPAGvHnO64Li2sswfPDUuwNfgk6c9B74UcWGtslrEPh/7r0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136751; c=relaxed/simple;
	bh=UYX3mWaYiKYIDtoW/DeTMnBys2CoJZxHrQ63nDcC0lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eiBUM9cKLxhcZMbQtZqjCRlUBJ9sFVXG31yUIpSYMDJVtZ/Im7KdBCuHxor9Z63ni8VYgR/CcEArbGWNucVBSck+G8OLx3bmxQwlAk4VGtMGxyX+dFNbeKsnHLTOCi/SP9NqiM0U4KYqqKkLu0VsikAnr73IO1tasbruMY1LYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d30kiRpB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BF2UqQ006245;
	Tue, 11 Jun 2024 20:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YA66go1OLv9lBRcUBZWz6pC4YMCi3WcWl5KdoPejptw=; b=d30kiRpB8DS8uuAx
	CGsf8GGsnTciSqltIHG5S9CSaPmF65/jVD7m3eVCzu6uIZPrSCuQX5/3YKduhrGA
	4oC9vUfAUkvg60u//2R4jkTVQJb/dEYq8+MM/Oh4gOGPR8T1XqRo/7NULs1QhA8A
	rFs0/llYiH0ftr5Q5/jwssCTCw+OxRN888fqyYqtbBk0IRtK2RmhW4xFaMS+hEKf
	xrY5ov/NXIVdUrUZWYaCptqQA7UHHWxUQHOFJGkqfvTypTVp0D6upPpJqlpif2KQ
	7lNVSj6RrgK1PSTapQp1vmpcQ8xxYCwQo+HDAgPxu4ubyIMVMrr/s/GAa/Rd2cQp
	bFOkRw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnmyadf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 20:12:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BKCPT3017682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 20:12:25 GMT
Received: from [10.48.243.20] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 13:12:24 -0700
Message-ID: <8733cbe4-19cf-47d0-b95a-914f999117f5@quicinc.com>
Date: Tue, 11 Jun 2024 13:12:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: fix uninitialize symbol error on
 ath12k_peer_assoc_h_he()
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240611031017.297927-1-quic_aarasahu@quicinc.com>
 <20240611031017.297927-3-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240611031017.297927-3-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gJn_0yLTU8J3vGVd0Sd9JrDNHGAcEbqA
X-Proofpoint-ORIG-GUID: gJn_0yLTU8J3vGVd0Sd9JrDNHGAcEbqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110137

On 6/10/2024 8:10 PM, Aaradhana Sahu wrote:
> Smatch throws following errors
> 
> drivers/net/wireless/ath/ath12k/mac.c:1922 ath12k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.
> drivers/net/wireless/ath/ath12k/mac.c:1922 ath12k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_160'.
> drivers/net/wireless/ath/ath12k/mac.c:1924 ath12k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.
> 
> In ath12k_peer_assoc_h_he() rx_mcs_80 and rx_mcs_160 variables
> remain uninitialized in the following conditions:
> 1. Whenever the value of mcs_80 become equal to
>    IEEE80211_HE_MCS_NOT_SUPPORTED then rx_mcs_80 remains uninitialized.
> 2. Whenever phy capability is not supported 160 channel width and
>    value of mcs_160 become equal to IEEE80211_HE_MCS_NOT_SUPPORTED
>    then rx_mcs_160 remains uninitialized.
> 
> Initialize these variables during declaration.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


