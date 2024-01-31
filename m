Return-Path: <linux-wireless+bounces-2914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3E1844972
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441A8B2854C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E41C38DE4;
	Wed, 31 Jan 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gKnpzvZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BD38DDB
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735317; cv=none; b=g9fqvkQr69dHrll07cRuvttdfBpddWH/S3ucvII/biETmPdDFABk7D4gDXbuAuNu6q2PQZ920tR7DOtgAqp1sCfbPl+0fTdLeE9EuXOv3Yll0Bh8EG4TAHY90xACnkxdR601O8Z4UbqXtHjRNB/shYAIE1Z76doUFYcnJx+FP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735317; c=relaxed/simple;
	bh=/d7H94SMRrmDjHy4EqbORCVRE06RS+wuolJFOIjdK00=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D98S9/sFTmDjIBNVfzAFIApR5Xqtee6KZsOjqkqKxg+i/ous5JCZGJXTt6MH3hVkwa+qDyfZQjzekKUr3q/DtYJxI62omzp3KQFZf4DmHjXRNZoQc827BWr3P2REczizcyLDw9FhYl10B66jySe3GWd+Et1CEYS4vK9WQUnrR+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gKnpzvZP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VCp5pi021169;
	Wed, 31 Jan 2024 21:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=y27dmeX92JcYJpz51a2V8WGnwnIinCCwMSgv2cesEVM=; b=gK
	npzvZPm/gHDicjzLCg5YKzkqabZ5tEpXe+t/QbjaoUuAfvh2/CFGTdE5/0oCE0wr
	HhTiYN1dr5eQFzpsAZOmj+253awqkyX+kt7xmxs2LKnBwOhEYtSQGsRxrcuId/uo
	tEGx2Yd9rM2ZvaENhOGrGTIJRU2xLWO4CzqlEHtMKZSXkprFhS4NwA6tdQ1zO7fa
	cWoP8namjBN19UNqrw2MG6nZWPpB1giu5LpF5ajvoTeOpnRSbPGsLwO/AbpjRqYZ
	ywaWlT9Zi5Is5WLLNVZqfWcJ3QqZvXAZbg/2hHaZYbaXPw1wvSvn3spyqQZAmwiN
	FK3kqpe6wZNxZmHTpfIQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyjas1v0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:08:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL8XuN004168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:08:33 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:08:32 -0800
Message-ID: <667978c4-9b5a-499f-9e39-7bb7d3be4d78@quicinc.com>
Date: Wed, 31 Jan 2024 13:08:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] wifi: ath12k: fix PCI read and write
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-12-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-12-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4Gc2kFh8aE5mu6MyYmEv56pjma8RbHUJ
X-Proofpoint-ORIG-GUID: 4Gc2kFh8aE5mu6MyYmEv56pjma8RbHUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=714 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310164

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> Currently, PCI read is failing for the registers belonging to
> SECURITY_CONTROL_WLAN registers. These registers read is required
> to read the board-id to identify the dual-mac QCN9274 hardware.
> 
> The failure is because, for these registers (SECURITY_CONTROL_WLAN)
> offset, ath12k_pci_get_window_start() returns window_start as 0. Due
> to this PCI read is done without PCI select window and with
> window_start offset as 0.
> 
> Hence, fix PCI read and write by doing PCI select window and by using
> the correct window_start offset - WINDOW_START for
> SECURITY_CONTROL_WLAN registers.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


