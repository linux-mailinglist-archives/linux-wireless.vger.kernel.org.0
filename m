Return-Path: <linux-wireless+bounces-15492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650CA9D1FE0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 07:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072171F226CF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 06:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98A2A1B2;
	Tue, 19 Nov 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dMEX2x7k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63952B9A6
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996224; cv=none; b=burwWmFGw+0OWjQcHY+e50JW6A9nTtxzDHQtPIaG3YE9TGqHg7wR7rJTib1V/fvE27IO1B/AtLzhzb6hdExu6CHGnVqtj116iocQM6vXm0bO4Cnl+tM1EPl+id7SHD2xJNPdv6jVQsesIaS4gL0My5CGyjDdNvvujoJoxlfoadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996224; c=relaxed/simple;
	bh=CjoBMa5cXItghjiZM8K8z5FGQTL+4sKS8/nkXQ4Omko=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bkfYlhau9vXUC3OiCAbDoiXFy0XM1D1Zb107qixD3v6xmHVVjI22oYGEMmawbhwWwxQ+TYi79V60lP7q4zDepUuWVz7Z3rgWl3nEndWlhHBzBKtCgtKuzl9MPQMX3+KeT2lWOCZoGn/WzncxPediIhmXHM22XqLPCoJ8vVUkktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dMEX2x7k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGH3B9029026;
	Tue, 19 Nov 2024 06:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GhpF2Bb0bvyGsJHV8rhghw89ehnvPLxevLX8kAIOksk=; b=dMEX2x7kSB5FieQm
	EJPbl5rgudvNhBfUN48OM6SDX1A1U/s4Y+od3NgQFxCgK6fAC834GRPUQ5tqg5n9
	cHgTx4FMFDvC7YpuWXIXK9f8oGx9O3+B8k/DoqSw6aHCKGDSKUyFbURgYRFc7ioS
	561EDBtYTVU08hK4y+C80tEfMfc2/qKlIaGNxnC3YYCKY6+MZBI9t8mUXe9aGl3F
	LlWWS8lwPP9dyvRLemMreAiAA1GLfqG4ZobEJCZ9bFG+F3fZk0o5Pj46yvYnUxbN
	iRLXi+1oWVY025wLYP+krjVY1kVsXnfVsmBR5IsNTBbSt0novmBr8GKdsGhPdOwh
	Pteq5Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y81jbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ63e8h006875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:40 GMT
Received: from [10.111.176.82] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 22:03:40 -0800
Message-ID: <66cd6940-fbc0-49c9-86d3-6a827338aee1@quicinc.com>
Date: Mon, 18 Nov 2024 22:03:40 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] wifi: ath12k: cleanup Rx peer statistics structure
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
 <20241119003248.1579567-4-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241119003248.1579567-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JGE504_uR7kHTNIRGR2TYbAcZXBHbGAk
X-Proofpoint-GUID: JGE504_uR7kHTNIRGR2TYbAcZXBHbGAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=760 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190044

On 11/18/2024 4:32 PM, Karthikeyan Periyasamy wrote:
> Currently, unused fields are present in the Rx peer statistics
> structure. These fields are already present in the same structure
> under the ath12k_rx_peer_rate_stats container structure. Therefore,
> remove the unused fields from the Rx peer statistics structure.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


