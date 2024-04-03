Return-Path: <linux-wireless+bounces-5842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7AF8978A6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F58B2F460
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C93515359B;
	Wed,  3 Apr 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oV2yz2jW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4191534F2
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168229; cv=none; b=DoIPTe19dzRBaEtbmXeNJ5SMKFkhqUyiQNnfE4IgiT7QH5RcFRUv5o7r7+vbz5ZhiZ9sEp4MCJOeGKtawcD8/OsdDqm4ew9VvvL0BZZuv9PL+L5zWORCjQAlV0Fp8+VNm1IubNMbRbVL1jdhf9319sFI261IHW3IwORoL41mA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168229; c=relaxed/simple;
	bh=Ytwqlqx3wAzvO43n/yUCtZf3xgZhVM5IOXmmP4p8rXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bKQHRsyDICSGQzW3XMVdmU1lRiZTbASUU4inkQcQEaHBUQRHIapn7cUfCkd7Kc6kx/LdQWovPimDKKvT4xfegMxRKpfTxSfRgyeIiZGYE9FzM7FUdu4ZhuynO8L8/8QmiAom9KsxrDKFSHKJSVt9Ax8NMWXimhFJYOLm2lCfGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oV2yz2jW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4338TxGO005870;
	Wed, 3 Apr 2024 18:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oWU6sccQnN13eum/VxOMH0n3LI+3M3mUrhV4+7h09jM=; b=oV
	2yz2jWHOeolr4+zjONRqG79mlXZCURqmUunS0QcXth2Ke8WALtU34kSxDjPddpKR
	6IXAx3DTn+tXTtJiCa6OTsWmiTk2Pty6M+TokroDXriw1d+8Vq+VolALHD/vrJDx
	cGlCAEaVCkK+olUvcOvxrE7vEiF9uv6EqiRHK9oUiadt3mUoxryRvS5MnkbiLB73
	Cx3agiieFhx37E8NIsx89kKqStsLzpWxtmwLzt+O9tLp1ynVzSKjXgrFQt0kKkS3
	Tqbtga1g+JAHxWD5yUuSmVLjUBvpQXN1TcFU0PKAkWNewuc8XR1jX/61NvCKV8nq
	RYFrbhHntbHQlePnTd3Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93n3hgq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 18:17:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433IH3D3021197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 18:17:03 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 11:17:02 -0700
Message-ID: <1350297e-8b74-414f-82d1-8492c5cf5a67@quicinc.com>
Date: Wed, 3 Apr 2024 11:17:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
 <20240402210538.7308-4-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240402210538.7308-4-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IVttWNBIwypHuGKthkw01L_NGL6on29K
X-Proofpoint-ORIG-GUID: IVttWNBIwypHuGKthkw01L_NGL6on29K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_19,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=573 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030122

On 4/2/2024 2:05 PM, Aloka Dixit wrote:
> Rename trans_bssid to tx_vdev_bssid to make it similar to vdev_bssid.
> 
> Rename profile_num to nontx_profile_cnt, and profile_idx to
> nontx_profile_idx which make it clear that these configurations
> correspond to nontransmitted MBSSID profiles.
> 
> These members are currently unused in the driver.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



