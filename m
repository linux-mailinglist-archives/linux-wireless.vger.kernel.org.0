Return-Path: <linux-wireless+bounces-808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE198136FC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D651C20A3A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70E60B9E;
	Thu, 14 Dec 2023 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FKNrKEjD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE1126
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 08:54:01 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BEGoKYO024003;
	Thu, 14 Dec 2023 16:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oVHWT6yzULOEBhIeWxrBXy0gU3nr/g5g5qK3WIioLV0=; b=FK
	NrKEjDi4c/+eNOoMc1C6qlfZ8xNAVy6eB2BmRISg+KMJfRgCfc28bC+4aDo+QnIx
	A0gFUYy43f1oQWoW6AVISCmDlqzqMC33xXBkpLgZ8ZKxTzh/QxRbEVJDeCDoaFtI
	ENjF7sxAuTMt00LeVKV5KUJQ9L/0ll2IZNrxbaH+XLQqdYfP/1JVe42EcIc3jgO1
	zRlUHpex0iEGU7tziMR0adm0H9o94WvSqiGUms31yIXYrrmz+WSVIBy2n9AfOT70
	YyIZ4ULZsEOyOoa3Kt2nYrzyUayygyxstH8YH/80xd+yA94EMvtxkF7+EycYC6w8
	ygHrld59lZCBB9UPYF+g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v05jqg0aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 16:53:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BEGrop7026390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 16:53:50 GMT
Received: from [10.110.36.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 08:53:49 -0800
Message-ID: <4f366e72-36bb-4e95-af1b-433005b3a92f@quicinc.com>
Date: Thu, 14 Dec 2023 08:53:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: workaround too long expansion sparse
 warnings
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231214161740.1582340-1-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231214161740.1582340-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1LXbdnIsEhG7-w5UHzsdYIzXiA5A_05d
X-Proofpoint-GUID: 1LXbdnIsEhG7-w5UHzsdYIzXiA5A_05d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=644 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140120

On 12/14/2023 8:17 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> In v6.7-rc1 sparse warns:
> 
> drivers/net/wireless/ath/ath11k/mac.c:4702:15: error: too long token expansion
> drivers/net/wireless/ath/ath11k/mac.c:4702:15: error: too long token expansion
> drivers/net/wireless/ath/ath11k/mac.c:8393:23: error: too long token expansion
> drivers/net/wireless/ath/ath11k/mac.c:8393:23: error: too long token expansion
> 
> Workaround the warnings by refactoring the code to a new function, which also
> reduces code duplication. And in the new function use max3() to make the code
> more readable.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


