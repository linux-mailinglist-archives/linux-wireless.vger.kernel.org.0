Return-Path: <linux-wireless+bounces-5004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E2D8816A0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3DD1F23E1F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8315442057;
	Wed, 20 Mar 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CsZ2amSl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5421524B7
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956096; cv=none; b=abAJmzCk4g0vZmm4OC8nGiS5wpcNPhKp6i5vVjOFgH0A430jEgCrJBJwrjgVO4Lg984trisxRhVP8K2eGda4xGC0fRJb8DkPmcA6qLkJoP8V7wLH8Ofucyc3kOetiUX7ptnh3uz5yjYzRw9jviEzXGOTNzu46gEPoK4jBjAToxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956096; c=relaxed/simple;
	bh=hcYAXW0n1OsYKjdvz1TIjvrhoUmhFTCMn3CGkCm/1F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=urTGE0lAeeMHKpCIyX6D5mXBKHXhuNmdCfT8s6oy2vcFwsdEeqjhBwFfLzWz+LtyNeXjM2DNqGLRthk3QbTVEk7vbCCkgge2XLQ6pjDAeX6gS+HBASsYEe6RGiGfNno4ZPzDxy9ZmiLBUlr0TLG8OVjBRF6N6rVQOVV6MeTZPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CsZ2amSl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KHYoXQ022712;
	Wed, 20 Mar 2024 17:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bgKFrzQwIS+CypVR1nZSDPoIfZHHpAFfPAa7+jpjw5g=; b=Cs
	Z2amSl4PSoL8xfFFocbArpNk2PSBxQ0Qc/vRY9Lj9XuJrmBfVq9IT4fhubsdmgz2
	wIdC80uD6yKSNLhTYO5l0kZeoMCo2c9QmU3zbn0uAE/ckM0/Sq+gjybbhhakT9XU
	zkz9lMXN4hPpWHdeX/4yaPlOkhz2Gg7nljBJ8w+k3afV9CZ7Wi0AeokIqEJt7nz+
	h6pXihqHOhcb7LHzV5E+sV8qD/j2LXq5cCXzoKWoWlmICIO7Sc4LZ9MLtUeD2Li+
	dCFKmwtjNI5RA5Dxhni8/JHoZj5Z8FohVWEfJukTUPy/SD36AcVXrw9cmfQ6kWkU
	URiweDoG4QOI3kcSUnmw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x04ar800p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:34:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KHYaLJ000637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:34:36 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 10:34:36 -0700
Message-ID: <52a8a85f-4ee1-4739-ab8b-0e4914f0044d@quicinc.com>
Date: Wed, 20 Mar 2024 10:34:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath9k: ath9k_set_moredata(): fix sparse
 warnings
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <toke@toke.dk>
CC: <linux-wireless@vger.kernel.org>
References: <20240320170656.3534265-1-kvalo@kernel.org>
 <20240320170656.3534265-2-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320170656.3534265-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IYkR_sUzYFIMEaYTkInw8ifHf0qAF6rG
X-Proofpoint-ORIG-GUID: IYkR_sUzYFIMEaYTkInw8ifHf0qAF6rG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=737 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200141

On 3/20/2024 10:06 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Sparse warns:
> 
> drivers/net/wireless/ath/ath9k/xmit.c:1677:20: warning: incorrect type in initializer (different base types)
> drivers/net/wireless/ath/ath9k/xmit.c:1677:20:    expected unsigned short [usertype] mask
> drivers/net/wireless/ath/ath9k/xmit.c:1677:20:    got restricted __le16 [usertype]
> drivers/net/wireless/ath/ath9k/xmit.c:1681:17: warning: restricted __le16 degrades to integer
> drivers/net/wireless/ath/ath9k/xmit.c:1682:42: warning: restricted __le16 degrades to integer
> drivers/net/wireless/ath/ath9k/xmit.c:1682:36: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ath/ath9k/xmit.c:1682:36:    expected restricted __le16 [usertype] frame_control
> drivers/net/wireless/ath/ath9k/xmit.c:1682:36:    got int
> 
> Fix ath9k_set_moredata() to use __le16 with masks and use if statement instead
> of multiply operator.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



