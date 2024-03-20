Return-Path: <linux-wireless+bounces-5003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD6588169E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15291F2353F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956536A340;
	Wed, 20 Mar 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IDpcbX5m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A042057
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956094; cv=none; b=Mz+Yf2D2bA8jj0QN7H6pNb7LyKyvBtLb0hrkVBhMkn1OEAKrRw0kY97HuvqFxgnMhoaw0Gu/z0PW18tIN7vP8/AfIjGX1zXXQZ7kQDd9bcX7TVyDtx25bRSW1xMuyV7mU6oS1rJHqT8cLr91EYUXIQDnGDTnCDl93PRWmyBz/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956094; c=relaxed/simple;
	bh=6D63zrc4peaTGO0XUdDfG7kz4TZYX4e4icRVgxlHiUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=btn0wnkdtpV7S1OksmbwJl8K2XdiJg768Vz3fQwECN0Ujs6kR34ue5rHSFinFkJocaD5Etw/6dfPtPqmC5wPM9hbg382vqHDFKsWNF6HRUqU7Up2UCiqdYcPEsGETirM3bXFJtr2VvGejdmRFLdupWo+TeYHlJ5E7T7qQzOhrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IDpcbX5m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KGNHt6009707;
	Wed, 20 Mar 2024 17:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=w2YTLzOQl6HyNg5Sur5xVOaQiqejhRBOi1cSWdmlUyo=; b=ID
	pcbX5mmo3V7h6gnhrB1UEcDn7uAAIr0f0XhaMAoMRfVzqRG0oRPTASlyxu9epDEY
	Mgsh721vukeprEyC06QwFj6neMEJzcOF12VB8I8Hf3B1Y4/JZAxv9FePD3MQv1kF
	SGCxXHUyKJftYm9mJA1mtwRK5H08zah9V5GIQ4fc3pKDDy/Z5kZf9VE6Vj+yLsqs
	Su+ghdu4TLqr9lefoAR2l4f07fGXVLxHXYetVPDPlo6/I8JEF5TBUDtJCMqiMSAG
	yj+2Tte/JBMwPQVCyMa2EekqZ3OUBb4E+2mrITy9AEQ80GZd3E9FS5nWHRbSBSez
	q3YzQyXYz4ey2CsA5Lpw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x038xr5hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:34:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KHYfQN022897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:34:41 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 10:34:41 -0700
Message-ID: <85a2701f-4c61-47da-8892-80d80b484b66@quicinc.com>
Date: Wed, 20 Mar 2024 10:34:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath9k: eeprom: fix sparse endian warnings
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <toke@toke.dk>
CC: <linux-wireless@vger.kernel.org>
References: <20240320170656.3534265-1-kvalo@kernel.org>
 <20240320170656.3534265-4-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320170656.3534265-4-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5GQLW7ol46WYrIQF7J9q96XaIQFa-GQN
X-Proofpoint-ORIG-GUID: 5GQLW7ol46WYrIQF7J9q96XaIQFa-GQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=713
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200141

On 3/20/2024 10:06 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Sparse warns:
> 
> drivers/net/wireless/ath/ath9k/eeprom_9287.c:82:9: warning: cast to restricted __le16
> drivers/net/wireless/ath/ath9k/eeprom_9287.c:82:9: warning: cast from restricted __le32
> drivers/net/wireless/ath/ath9k/eeprom_9287.c:83:9: warning: cast to restricted __le16
> drivers/net/wireless/ath/ath9k/eeprom_9287.c:83:9: warning: cast from restricted __le32
> drivers/net/wireless/ath/ath9k/eeprom_def.c:138:9: warning: cast to restricted __le16
> drivers/net/wireless/ath/ath9k/eeprom_def.c:138:9: warning: cast from restricted __le32
> drivers/net/wireless/ath/ath9k/eeprom_def.c:139:9: warning: cast to restricted __le16
> drivers/net/wireless/ath/ath9k/eeprom_def.c:139:9: warning: cast from restricted __le32
> drivers/net/wireless/ath/ath9k/eeprom_def.c:140:9: warning: cast to restricted __le16
> drivers/net/wireless/ath/ath9k/eeprom_def.c:140:9: warning: cast from restricted __le32
> drivers/net/wireless/ath/ath9k/eeprom_4k.c:79:9: warning: cast to restricted __le16
> drivers/net/wireless/ath/ath9k/eeprom_4k.c:79:9: warning: cast from restricted __le32
> 
> antCtrlChain is an array of __le32 so le32_to_cpu() needs to be used.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


