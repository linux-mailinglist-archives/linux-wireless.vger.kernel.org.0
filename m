Return-Path: <linux-wireless+bounces-1598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C382770B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 19:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A252833C4
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A856B9B;
	Mon,  8 Jan 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ReTy7iDy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601156B98
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408GsJxX032565;
	Mon, 8 Jan 2024 18:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ExJy1HsthPXKtXdpCjDcwwZl22fBW64Xv58HlXJV0+I=; b=Re
	Ty7iDy2fjPr/k90ApLKwPmdmpK9SxW13O3Fh8fyW/UCE5x9JXCuC4Vv1NqbKV76i
	znr5k831ei9JtUmDmTxT3ABSYJJL3vKCc0/4Bu4O0LOm+lDkZLsFZE842ZqHb+WD
	oprv8cJXQN9pikBDbK1QGn7NVQTj907SSw2w+WwJrEjxOQ6SWHoZnJ3rr/YHmdvH
	ljvcoXCoJnSw+AvzrYHjtbGCpQN4NKW9ZIhHZJHNcb5yhOLis22JwSxrHUa6y939
	XYjgcl8Sq6L6x2+07uh7muloMacVvf1E64gMx2sItOFogzruwulq7c2KtymwbtJR
	G15847jOJ87FEqWebqwg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgkkh8dm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 18:03:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408I3STs021488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 18:03:28 GMT
Received: from [10.110.42.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 10:03:28 -0800
Message-ID: <e1ef292f-a331-40ff-a756-8df4549adb2a@quicinc.com>
Date: Mon, 8 Jan 2024 10:03:28 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] wifi: ath12k: advertise P2P dev support for WCN7850
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240108082552.7227-1-quic_kangyang@quicinc.com>
 <20240108082552.7227-11-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240108082552.7227-11-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wmoRmp-NRGMxT7C8yI-bVtK5j6NedTVQ
X-Proofpoint-ORIG-GUID: wmoRmp-NRGMxT7C8yI-bVtK5j6NedTVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=473
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080153

On 1/8/2024 12:25 AM, Kang Yang wrote:
> Now that all the necessary pieces are implemented we can enable P2P
> support for WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/hw.c  | 5 ++++-
Qualcomm Innovation Center copyright missing 2024

>  drivers/net/wireless/ath/ath12k/mac.c | 8 ++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)


