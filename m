Return-Path: <linux-wireless+bounces-2909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C73844966
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F4287C15
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D2D38DF1;
	Wed, 31 Jan 2024 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S08OlFAM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADE208C1
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735242; cv=none; b=DE3g6Ll597QBF+wnV3/acgi/4BuENHFmQDnAQsYR9K4uFGX+/Ncbyhj6H5kgA/rAA9mDSh75BPsN49W7yGHARazfDcEmo/xl3vJGZe4bwU+jHkfPLNsDoMvsD/rADaf4EBZNmzLUkTeBuIlLJdGfxgD7F4VII9Npx5CaRCO0nd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735242; c=relaxed/simple;
	bh=B+s+8U0EXKUWHRe5fIw3rtbekFTUYg1S/ox6cGLjjdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qdq8IauHHfvLF76pQGI8lNMZ2BcVc7RU3OUmiitJwuR7Mx5WpO2F6oRQa5WlE3K9NnfibXf3yPi52XKuZW8tJhVGrwygtv824TCzcB+AnNP5CyTv1xmwM4Q2ZrtksdV0+y/GiEIv3ikiozu/T6zTc/r1Ca9V0USW4yUqMtYpbkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S08OlFAM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VEvKvQ024324;
	Wed, 31 Jan 2024 21:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QHWN2Q28zGqGNz9igTWjQzeUIYoh0yKit5iCUbr8xIo=; b=S0
	8OlFAMi/OTaKcgU0dJDSQeZBuxRI1fzjBjDkO54L+vTLInWgG/a3xk/J+JM7yAuv
	sTvL+UYx6uCUKwidyb5luhddGHLz2Mnl7UhjOhHYf09+X+K1lKMkUjEKSJcVuH6F
	6CU6GIp4IcuLMCTxE/CyEj+Duj+N3Y+fzJpqvv634FgZ4rJRtdFP4VAAQ1f2Cdpp
	7ubSIAy5UmJ6GCywHc5/DnkE7I+HtJsS76zpUTWY4Z/gf60VVm4bWL2eU9rzd7EH
	ZX8hEuTsHfsSukhHu0GWi7C7v9/MA4ElwiBwDL57WBmTZ4yJ74J4LjUorv3A2AzU
	DeeOeqpC8mEsI/pCguqQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyfnjteme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:07:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL7Gnk005464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:07:16 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:07:16 -0800
Message-ID: <2b18557b-c0a8-4525-a100-53e084046bec@quicinc.com>
Date: Wed, 31 Jan 2024 13:07:16 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] wifi: ath12k: remove hal_desc_sz from hw params
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-9-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-9-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z_LHD8GLJvirsJiMq2V2hYhhPTEoBg5h
X-Proofpoint-GUID: z_LHD8GLJvirsJiMq2V2hYhhPTEoBg5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=942 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310163

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> With word mask subscription support, the rx_desc structure will
> change. The fields in this structure rx_desc will be reduced to only
> the required fields. To make word mask subscription changes compatible
> with the older firmware version (firmware that does not support word
> mask subscription), two different structures of rx_desc will be
> required for the same hardware.
> 
> The hardware param hal_desc_sz value cannot be constant for the same
> hardware. It depends on the size of rx_desc structure which may
> change based on firmware capability to support word mask subscription.
> Hence, remove hal_desc_sz from hardware param and add hal_rx_ops
> to get the size of rx_desc in run time.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


