Return-Path: <linux-wireless+bounces-2747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF9584187D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9F1C2294B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB8364BD;
	Tue, 30 Jan 2024 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dK2QNPFj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69027364A7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578819; cv=none; b=t5ke3R886Fo1e566UBCYkE0Xl141qecXLe2E+g8k2mcijCqoHsNPyPP3MgLvDwvZBs3dqNSRHDi0QgSTV3Ytf4rGUNnQ1MkJT9Pv/GQy8WJi02Ab6LpMt2jSlkjX6hPe3o85RTulV+D8P32RJcbNwqkMfCQTquq1voS0Lncl0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578819; c=relaxed/simple;
	bh=YA8AD/2GGXrmNKirmvXyRgaZNlcCTdY9Qq7Fbjfrwps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VrISBR5/tXAaWCO4VgjAUhMK/Fv3GyY7a70MJeEM8QlPHfHW/xETwLPKDtmNpXmaVV6IXnYfqaMnlTK/mpCohtxilrRvu0R3UKGZxPx3iEMcl9h9lSwnb2cve1pERWdYgMrLgcuV6/iJG4PF6odtx9w9SNEj35W1JmSGi5GlwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dK2QNPFj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U0Te6r017714;
	Tue, 30 Jan 2024 01:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UitLKtE2RRds5hJpLbCTaQ/DQHIyeASdh/rzRuV196Q=; b=dK
	2QNPFjtGss70vepqP799x4Y3zABr/J7BJB6C9bAUKxkqyDLSNmngd1TFbgT2fBL1
	oRkJ3Gu5cM2USOdPwc/9XoW3aJ886oSYLyh8e6fHRodGyLm03xUImqRv+bwb68kB
	Wgd8SrTbfDg+bOLma0drV6ghThEczbetmx+IxNJ1ZdTHyPSJzOT/wu/Nc5zfFPBD
	PBRGTMsm+zp3c3/fWxNhhNlTDGMu1ubW092gXo+gV8z9XTpP6C0JQGkliTXzyfbD
	i+f6DZcFQuKNw5Ft6p3fEj0ao5nuWhuHf9yg2yPvqpw8AQg3rohia+goXj2Ibgc4
	iipQGkBGAptMc8TjCmLA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx23kautj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:40:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U1eD84018282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:40:13 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:40:12 -0800
Message-ID: <585ebc14-b3ef-4c09-99a4-b8b855add274@quicinc.com>
Date: Mon, 29 Jan 2024 17:40:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/11] wifi: ath12k: fix incorrect logic of calculating
 vdev_stats_id
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240129101453.368494-1-quic_kangyang@quicinc.com>
 <20240129101453.368494-9-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129101453.368494-9-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zChsi6YqFvG5ktdY8McyfBSrM2fZcAig
X-Proofpoint-GUID: zChsi6YqFvG5ktdY8McyfBSrM2fZcAig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=920
 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300009

On 1/29/2024 2:14 AM, Kang Yang wrote:
> During calculate vdev_stats_id, will compare vdev_stats_id with
> ATH12K_INVAL_VDEV_STATS_ID by '<='. If vdev_stats_id is relatively
> small, then assign ATH12K_INVAL_VDEV_STATS_ID to vdev_stats_id.
> 
> This logic is incorrect. Firstly, should use '>=' instead of '<=' to
> check if this u8 variable exceeds the max valid range.
> 
> Secondly, should use the maximum value as comparison value.
> 
> Correct comparison symbols and use the maximum value
> ATH12K_MAX_VDEV_STATS_ID for comparison.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


