Return-Path: <linux-wireless+bounces-17580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B038A131C8
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 04:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F1D3A5880
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 03:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C522612;
	Thu, 16 Jan 2025 03:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mp/293++"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA1225D6
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736998539; cv=none; b=Cwtb1wgHdG1cL9d2VjKGM0E6NCaFElkv/bUgXLH21sGjvQGkYaGn7vC1d3p9KvKOMmn9vNWmObm5ePRfbkZbOZMNbJ7MtcCqffeHTISOSsq6/HLdvwjKUAut7VCnkZTNTbWB4MUYvGZLwFcaugaN/6htbzZbm49i27/7hWXgamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736998539; c=relaxed/simple;
	bh=O7CxqwbaCejS3PXPKrWKyCcEVnDj047Yyp1lrQADH4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lYv3E27kYxETb7rnJKLEKpwwFJI/DcAEonqhCiPlcxaLhC+NvVC9rtgFDwPFwi0sLwZ2QHwHX1mhClQUzamojnuyksRxp2fR7foT6CE4+UqGbj4n4rs+RyWrt8i7+eSYh3wfrTxyhYl/dt15H2q0ZokCKCfZRUdhykTt1dvjPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mp/293++; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FKrgGA009825;
	Thu, 16 Jan 2025 03:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pKEMTFQnE6LXHriQanUkRbslR6ox7gFNHELOXEQx7Hg=; b=mp/293++PwiwCuaD
	IidLynvDN8iioXzkHj4yw8pj5/dX/XIgW1pd1hs2y/GKrZjpbtAtSG1Y9+qzPsIj
	b+xtpLkg24m32FxrtZ/9bsc+ffeygQupfRej3fl66iFz6uIM9VJkoZMwArJTFvmL
	eVK9KO3k3mizyjvFvLy6/yIgbc4cdo0LISgYp8KKNYkL24w/zFB2f4+z05+lFUe+
	dDOsiqfpNdikljyOHLGQc/UlKT5o1Ma6T1Ae0fLIiIqo+ym/bSoVwCnZkzK61pLT
	mQZkLXA1jeiwyHIzgmCtynHwl175R/WrWLogsC6Ty8u7VLtVdOrJxy167vltCD7X
	xXYWEQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446mf2gr0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 03:35:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50G3ZWS0017600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 03:35:32 GMT
Received: from [10.216.35.176] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 Jan
 2025 19:35:31 -0800
Message-ID: <6abe8c92-d3e0-40f4-8af7-67bf863c868f@quicinc.com>
Date: Thu, 16 Jan 2025 09:05:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fetch regdb.bin file from board-2.bin
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250116032835.118397-1-quic_aarasahu@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250116032835.118397-1-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8v5r94HlrK9SCvu-762vYQ68GQh-VmOw
X-Proofpoint-GUID: 8v5r94HlrK9SCvu-762vYQ68GQh-VmOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_01,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=901 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160022

On 1/16/25 08:58, Aaradhana Sahu wrote:
> Currently, ath12k_core_fetch_regdb() finds regdb.bin file through
> board id's but in board-2.bin file regdb.bin file is present with
> default board id because of which regdb.bin is not fetched.
> 
> Add support to fetch regdb.bin file from board-2.bin through
> default board id.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu<quic_aarasahu@quicinc.com>

Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

-- 
Aditya

