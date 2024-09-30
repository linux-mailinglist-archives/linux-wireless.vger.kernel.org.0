Return-Path: <linux-wireless+bounces-13344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FA598B0D6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 01:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72161F2300B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E371843155;
	Mon, 30 Sep 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VJGSo4al"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569523E479
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739073; cv=none; b=PSNYmhIboxVCfIVvUyyUBkqNMDLt4TomwNlMZi0kLCWlUNiM/I26j+1TRylsNvITuyNobWLFzbSX0vuMLL3vNvgTqCZlEEbs2CN8HorUTqKrUP7RZCvWB9e19dkqIqYQAvGbs6Wcsx1VKy5D5ezCstHEQ9fBNx3dMDFVkNywNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739073; c=relaxed/simple;
	bh=dcpCAFDotPIN6dmRwjsRUDvcoUNmK/A4zKNUcwRBsQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dsuJNouegmPRqGeQCqeHjej5dzwOQLUjHGzrVBNWeNhWmzpR2UYdk+qZOlPBjBUnoOVZxgZuJBG/s8nDHKNWnSBsgLtemZMu/d0yACNusr8lHqN/40tS7QLzs9vDKO6lS7gJ4iJqOse6dYxQ+xT6PAOF4M4g0vnWTKjyWAYb5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VJGSo4al; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBE0gw009627;
	Mon, 30 Sep 2024 23:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g/cDQjzh4qGDzjLmltCTd474s3Nxs2cjVK4dri4VguQ=; b=VJGSo4alaQMaA/Rr
	N7JhF7r+3ESx6OQ8u1OMDnE13gli2khbUOcWle/eq7Ziro5N0JOzOnP9z/USstvB
	SfQl9uWP31572D38+2zGVZDBf+w/pI32LG1Tcuf7E9XWu56i2wGN90bw3Qdvk0gs
	I4DXvrhW5HKRyGmWEX/C80tPM3e3opSLTUh8KDaVnaEHe99SBKm9UeiMXe1O5mu5
	k+unOytbOa/OQrOazWP6f6LOTrYqgPLRHrTg+PKCQZ4qhk9bIsJmpSU8CFY6mkfa
	1FtBqVbMpO1+oCW5Vvr8j2A6QJ3zZ5IgPI2sa7nWlxv0bddnKbaioyQH5bGYNre1
	mugmrw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xb38x88b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 23:31:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48UNV8iX022505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 23:31:08 GMT
Received: from [10.111.183.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Sep
 2024 16:31:07 -0700
Message-ID: <d722ec11-1282-47f3-8a3a-4dbff5d835e0@quicinc.com>
Date: Mon, 30 Sep 2024 16:31:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Support Pdev OBSS Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240919101812.941145-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240919101812.941145-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pTxdLYaRWl0gE7AYTcE7yRviFz-InPh1
X-Proofpoint-ORIG-GUID: pTxdLYaRWl0gE7AYTcE7yRviFz-InPh1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409300166

On 9/19/2024 3:18 AM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request pdev OBSS stats from firmware through stats
> type 23. These stats give information about PPDUs transmitted or
> tried to be transmitted in Spatial Reuse Groups(SRG), Parameterized
> Spatial Reuse(PSR) and non-PSR groups.
> 
> Sample output:
> -------------
> echo 23 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_PDEV_OBSS_PD_STATS_TLV:
> num_spatial_reuse_tx = 0
> num_spatial_reuse_opportunities = 0
> num_non_srg_opportunities = 0
> num_non_srg_ppdu_tried = 0
> .....
> 
> HTT_PDEV_OBSS_PD_PER_AC_STATS:
> Access Category 0 (best effort)
> num_non_srg_ppdu_tried = 0
> num_non_srg_ppdu_success = 0
> num_srg_ppdu_tried = 0
> num_srg_ppdu_success = 0
> 
> Access Category 1 (background)
> num_non_srg_ppdu_tried = 0
> num_non_srg_ppdu_success = 0
> num_srg_ppdu_tried = 0
> num_srg_ppdu_success = 0
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


