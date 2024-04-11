Return-Path: <linux-wireless+bounces-6199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067BA8A1E55
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 20:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368031C245C2
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE915E81;
	Thu, 11 Apr 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KnqPfonD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89228482DF
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858801; cv=none; b=Wy6jPemlLekNGDn1n9MwZG/Me7hfiCZTG/+1c2y7cayHzTuyjsWBBLCQZLUa+cBe3ulJ1kYiMlzVPRtT6FpRW7lGfwuPw09bHoHgeP0RNnVkhxk7ZONGUyy+XxOaHlhJrQbDMrFI3VFsVenqshcOKRX6rUqR7QMLntat9VB6LyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858801; c=relaxed/simple;
	bh=N97ing0jdJmjmfsMmz1OggyjontnnWH52sDJqdo7+Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ck2VoxjcojRxOfCOb1p7Wky42QzUY9UGdbuoD66HI9w4etfzS2v6zLevmI/VAyw5Ea0f2YOkcBHt3nLD6FLkhHTSVec6zT0Qve08JxfX89zdKVmt/UYNJPblhzA64i95D4oclB8x/82SwOAleOIrYPc/aHcIYcIs9h2uqvDGugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KnqPfonD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BBJJx7023143;
	Thu, 11 Apr 2024 18:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oPJENQpcbZlHnfUCdMnZpgnWPlFpmzv57A7pRq6zI5c=; b=Kn
	qPfonDpJotl8diKfct6qQAkPiRpzJRVDZ2Q/SfCCO4dB9V1IB5FBvrkOIJffs/aW
	AC/VJj8q9F7QgsAbxZdGszhq1GdY6+ydToHlcaItCyhEHGea+OZJuWkT2yPfYTqv
	6RW9Gt1HOgOqpP4Q5yoYtRumsCdyy1wq4QZk89h8KkNJptt4Z4hIlp5hu5wkJmT0
	1MwFYaXWA1eyN3tiFy/xRqAYtIl83hr0kdr8fqS+YX8PaJIn8dFG/eg4TnuusXFE
	Ul9eEdd5jmt1opDISvm8+c2JfwVPm4YexqKXiq3lKyga+aveIuEPP52IZr79asaC
	fdDgEuo7b4X0U1C4un/A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xedugsctk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 18:06:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BI6QA3015263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 18:06:26 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 11:06:25 -0700
Message-ID: <21398952-062e-44f4-85e2-c3d13ec46c44@quicinc.com>
Date: Thu, 11 Apr 2024 11:06:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: use RCU when accessing struct
 inet6_dev::ac_list
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240411165516.4070649-1-kvalo@kernel.org>
 <20240411165516.4070649-2-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240411165516.4070649-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wdvaH-cUKOymmOrQEeVqNBzrfgKV6MGA
X-Proofpoint-ORIG-GUID: wdvaH-cUKOymmOrQEeVqNBzrfgKV6MGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404110132

On 4/11/2024 9:55 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Commit c3718936ec47 ("ipv6: anycast: complete RCU handling of struct
> ifacaddr6") converted struct inet6_dev::ac_list to use RCU but missed that
> ath11k also accesses this list. Now sparse warns:
> 
> drivers/net/wireless/ath/ath11k/mac.c:9145:21: warning: incorrect type in assignment (different address spaces)
> drivers/net/wireless/ath/ath11k/mac.c:9145:21:    expected struct ifacaddr6 *ifaca6
> drivers/net/wireless/ath/ath11k/mac.c:9145:21:    got struct ifacaddr6 [noderef] __rcu *ac_list
> drivers/net/wireless/ath/ath11k/mac.c:9145:53: warning: incorrect type in assignment (different address spaces)
> drivers/net/wireless/ath/ath11k/mac.c:9145:53:    expected struct ifacaddr6 *ifaca6
> drivers/net/wireless/ath/ath11k/mac.c:9145:53:    got struct ifacaddr6 [noderef] __rcu *aca_next
> 
> Fix it by using rtnl_dereference(). Also add a note that read_lock_bh() calls
> rcu_read_lock() which I was not aware of.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> 
> Fixes: c3718936ec47 ("ipv6: anycast: complete RCU handling of struct ifacaddr6")
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


