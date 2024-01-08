Return-Path: <linux-wireless+bounces-1599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AF1827714
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 19:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDD1282B61
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D355467B;
	Mon,  8 Jan 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bs2dLzYY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52954737
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4089qBQe005802;
	Mon, 8 Jan 2024 18:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YU3didum3UBOOLyO8tJPrPFE5gi+WNpSx8aWIWV5psQ=; b=Bs
	2dLzYYAefpfexgfgVVo0RB9ZCH3T3mzD2hn0BTamKNwqfIcxD2eyUEv5jJh8Azmv
	Uf45eFnz0QuD9A2ovigKOQgeWzgmGsdJvkuWkjPkCy8gRBm5xW/HYFLH4IhXH8yq
	4ORfkUyfNXcv2rl6yf94JfIebBbAT5lVnUgfSgv8A9UAb5ITYXOQbaaIoTDUjE8b
	e0SIR8FBXL2MkNhGlqMLXoXa8zNBCsEA8eJvlFf6eo7FWEUVUnY//BvT2wb8EtRG
	T+t1/KHhynewryWFF3aI8c8EU7Q6QHWtbLIyGRAUTbkbqhNucMbhjPH1VFgpFU7e
	dsks84epUZQ3EgHUAZpA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbu2hfsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 18:10:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408IAQs6024511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 18:10:27 GMT
Received: from [10.110.42.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 10:10:26 -0800
Message-ID: <6c3ceb12-5154-4bc1-8cae-e8a05e7bd9e5@quicinc.com>
Date: Mon, 8 Jan 2024 10:10:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] wifi: ath12k: implement remain on channel for P2P
 mode
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240108082552.7227-1-quic_kangyang@quicinc.com>
 <20240108082552.7227-5-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240108082552.7227-5-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L_Fc5KXwPQgCBrHIv6LW7qHO6o0EyuN6
X-Proofpoint-ORIG-GUID: L_Fc5KXwPQgCBrHIv6LW7qHO6o0EyuN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=624 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401080154

On 1/8/2024 12:25 AM, Kang Yang wrote:
> Implement remain on channel for p2p mode in ath12k_ops:
>         ath12k_mac_op_remain_on_channel
>         ath12k_mac_op_cancel_remain_on_channel
> 
> P2P device can trigger ROC scan. Then keep listening or sending management
> frames on particular channels.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c |   1 +
Qualcomm Innovation Center copyright missing 2024

>  drivers/net/wireless/ath/ath12k/mac.c  | 113 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.c  |   4 +
>  3 files changed, 118 insertions(+)


