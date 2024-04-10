Return-Path: <linux-wireless+bounces-6133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ED38A0147
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 22:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9CECB2772B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13EE180A76;
	Wed, 10 Apr 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kg/seMPZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179C181B94
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780767; cv=none; b=ZFy5o3oQyQmX/gLSfhp52I3hDtV6+dgkJP3JYXBT5eyjriEBCoqvi4uoWShqWR4bdrfO7H2f8GPPZUX3c75aPvd7Wwio9gsoiMxnEKM7pbKXC775Ma6YB47Cd+KBy3jBToJpmfAnBO0oqDUNZLnpFwgVNAWNRYcrdwFI0JUhNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780767; c=relaxed/simple;
	bh=vmyYPMdm6k3UYQ8X8iGZ8NpGrmiMxmghnMY4WbgEU6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AB3dK0RxNp1PpvQjrYMr96k7wm2iPjPiBSzMsiOre7BLL/Fq36Gp8WTM5pOaxzhOU3pR0+TzgjuSenPlRQuISsQpxhRegzV27hrlu2XMkxqvmCP4PXvv4Ufr7f7fOjJNVJSGjF2tJxrQZ0iGfngwwj/BokRzj2RTrwqRGcynSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kg/seMPZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AJuZIG006694;
	Wed, 10 Apr 2024 20:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=45ZHGLmzCQaKQWRaomwIknmzwGoAcMj+63Euzxd312I=; b=kg
	/seMPZWkvWTwLl9V+PYVVsJmOWgHW9k613LEuOfboSAbUMVEWXNFMbX734abqJc3
	G6pKQfoGNgpw6gtQTTyAzuem+bS3j98dCKSjzPmWZ3ABdp2J2ZkKmxCFA1EJhdJV
	ZNgKw9mzOn2bTIZB3cwMxdOZ1d1AP2ua7G1sqIxcbfjgZZaXP2mcpuR7q1gJO2Bw
	4ndvgVlCU3l8hQ37KlmDO8kTU4Iu96yKS8TYT2bfVcvAbmpBX+vGuKtJ0bMZs482
	Ke4EbjAwiv2YeO9iH++U4SBIHMF7TGh7OQq7QVgz4re7SNSeOVTFro6TtJTxv2fR
	+U5wq/wioVpiMI8n148g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdkv8mgc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 20:26:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AKQ0UN031299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 20:26:00 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 13:26:00 -0700
Message-ID: <c5dec609-493a-4246-b006-aa905edfdac3@quicinc.com>
Date: Wed, 10 Apr 2024 13:25:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup
 Failure
Content-Language: en-US
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240409190922.4180631-1-quic_nithp@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240409190922.4180631-1-quic_nithp@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NSLLVEXaV6FCj-3SCCtGBa_ssF0fNtt9
X-Proofpoint-GUID: NSLLVEXaV6FCj-3SCCtGBa_ssF0fNtt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_05,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=832 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100149

On 4/9/2024 12:09 PM, Nithyanantham Paramasivam wrote:
> We observe intermittent ping failures from the access point (AP) to
> station (STA) in any mode(AP-STA or Mesh) configured. Specifically,
> the transmission completion status is not received at Tx completion
> ring id-4(WBM2SW ring4) for the packets transmitted via TCL DATA
> ring id-3. This prevents freeing up Tx descriptors and leads
> to buffer exhaustion.
> 
> Currently, during initialization of the WBM2SW ring, we are directly
> mapping the ring number to the ring mask to obtain the ring mask
> group index. This approach is causing setup failures for WBM2SW
> ring-4. Similarly, during runtime, when receiving incoming
> transmission completion status, the validation of the ring number by
> mapping the interrupted ring mask. This is resulting in
> validation failure. Thereby preventing entry into the completion
> handler(ath12k_dp_tx_completion_handler()).
> 
> The existing design assumed that the ring numbers would always be
> sequential and could be directly mapped with the ring mask. However,
> this assumption does not hold true for WBM2SW ring-4. Therefore,
> modify the design such that, instead of mapping the ring number,
> the ring ID is mapped with the ring mask.
> 
> According to this design:
> 1. During initialization of the WBM2SW ring, mapping the ring ID
> to the ring mask will ensure obtaining the correct ring mask group
> ID.
> 2. During runtime, validating the interrupted ring mask group ID
> within the transmission completion group is sufficient. This
> approach allows the ring ID to be derived from the interrupted ring
> mask and enables entry into the completion handler.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


