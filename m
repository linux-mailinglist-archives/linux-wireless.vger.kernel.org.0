Return-Path: <linux-wireless+bounces-5256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98B988B469
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 23:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B330809A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D57757FE;
	Mon, 25 Mar 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="exkyQ0dO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA36CDD6
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406696; cv=none; b=hJYhS621oGYSRIe6K0E9+xesC1jexeseR4BgJ3P9gBNLGfk6xLjmM7INbrT5j6p6bTJh/r1V7zQIoWfRNEjuMq1i4whg9Z9Vzs8c0zZN22QfnIKdurhf50kbWEVWf8ySZZTFPWKhiszwAbZqyO8UE1ZYIgzzfYrUiJIO4MSqVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406696; c=relaxed/simple;
	bh=PB+1A+wIISjSdKBll8aXb4bOytihS23qA1GABQNhzDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sBFF7SNVxo36apcrLBKzIPbKLs21O7V5AHa6zmmoUmyDeb9CsZKwSBlG7zoYUfNx/8a6exNoksrqXLoVMchNHOj2A6XOlG3FWkcUJlz7bMDxjZ3Op7QEItIi35y8SgKesZkHvMy1pQoxBCsuJRDGkfXHz0O1WehV51WG/+Jc0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=exkyQ0dO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PMWfHw008681;
	Mon, 25 Mar 2024 22:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=96QpIKrsOWtLUP3b8N40oUypnGaD4yUJt1O3Rffcu+k=; b=ex
	kyQ0dOfE1GiFY/eZ8hdSIomAN9bVA6Bgnr8AEMNtNmAtQLhyfOMDpefGsZkkAKtY
	mq1OJW1HldvgRihnpQbw7N17+5YbYFvSuK8beDj13Jgm3mhnllX9rpzeQqw2p6oG
	CqZ6yTMDYA13hIMImw/u1rDkIwGr66dcc5tktjvBQ9/1hqvZXxmwSguORwfd3XSW
	jyMKg6huWvG6Q3nFHnvzPZPitF3+pT7tXs4ecnWvrAPpgptJHNIm/4xGnyJBu4PA
	8/dqZAD5WPY8WE8h0XIUqF0Ps1ODcbTBWcBJn7iJh7n/wONpDN33DTAHA+BkZfgk
	kf1n69Rg3qgdFbEw1iSg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3huu01d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 22:44:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PMiUkI032221
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 22:44:30 GMT
Received: from [10.110.28.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 15:44:30 -0700
Message-ID: <a2723de0-802f-4121-82ea-f197f86a18bd@quicinc.com>
Date: Mon, 25 Mar 2024 15:44:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: use kvcalloc() for codel vars
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Miriam Rachel Korenblit
	<miriam.rachel.korenblit@intel.com>
References: <20240325150509.9195643699e4.I1b94b17abc809491080d6312f31ce6b5decdd446@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240325150509.9195643699e4.I1b94b17abc809491080d6312f31ce6b5decdd446@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4mwebgJwCq8JJHT3dRqN7RNRaSvsbiY6
X-Proofpoint-ORIG-GUID: 4mwebgJwCq8JJHT3dRqN7RNRaSvsbiY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_24,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=564 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250143

On 3/25/2024 7:05 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This is a big array, but it's only used by software and
> need not be contiguous in memory. Use kvcalloc() since
> it's so big (order 5 allocation).
> 
> Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


