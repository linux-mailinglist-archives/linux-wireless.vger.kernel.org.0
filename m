Return-Path: <linux-wireless+bounces-5037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886DB8818DD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B967F1C20DC7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D021100;
	Wed, 20 Mar 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gA9bEPAK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCD8592E
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968257; cv=none; b=TMm/FrrlF04Nyya/yipau4EnDS7WeD07iGDlHdAk69wd2xvveQmtPef7uRYZd/WuNXReNmDZpfDnD1vPbToU2XIkZbUJwKohFiFV6okm44eTEYdLiCpx4ljyByRQdeI5RGXN8lXFwxs/RanLkzFkc89evFgh8chT89oKvaFmn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968257; c=relaxed/simple;
	bh=rn7bDN9hkWiszByjaCGidPQmpx7u4+/aq8bFB32GF0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hTwIOkXmYUCZYBnF7w8yqDlUT+PcTvQz8Ska23yqci3kS5QJwt6Z/9VpugneQ4nIXLvBQegLq24GT5dt2azuRshTOXLmogJBHoJco4wI4FmhSCraTb7eSY0GEsvbuE3/VOI1rPZ/sbWsHSLgABez7ZGdBFfmUDWKyEjUnNYs3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gA9bEPAK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KKIK07031158;
	Wed, 20 Mar 2024 20:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SoZ2PW7G20OgJRJOmNL1B+KWiE8AzYNZxsthmP2LBs8=; b=gA
	9bEPAKGNe4yosNhE9sftGsRdOH9gSuswz5qLt3nCAW+Q3bHBrOkhlMzEJ4CRHwO6
	LDuSFCsXPSQvtnr4RfswxB9gwnFOFK7kcfBpD/EsT9MvINRkdjK3zWP02Zuszdth
	1D/HXxKeACf/wXzTk865VrYASn9EmUWNoujnBXqfYNCAXY0fdyZ/uOjfHuWa702I
	1k70Cr2/1c9ZBozP19TF6ty1Z2b+/iYcub6cqBKDqgTTpT4pvlAUN/8wewl76zsH
	ClLQ+xl7YZczg1TGjp95gSBgPV0oJCWVjLwIM3N3vxy3As+DxL61fxruIMdqzM7h
	qMX/QXfVyMd9oI25SSEw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x01jqgvjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 20:57:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KKvUwL009584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 20:57:30 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 13:57:30 -0700
Message-ID: <7592ebc4-c893-4d7a-936a-f1e00f88a27b@quicinc.com>
Date: Wed, 20 Mar 2024 13:57:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Add initial debugfs support in ath12k
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ramasamy Kaliappan
	<quic_rkaliapp@quicinc.com>
References: <20240320171305.655288-1-quic_rgnanase@quicinc.com>
 <20240320171305.655288-2-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320171305.655288-2-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 157yDBJO8K20aZhri4fpRmRg5kRACSVe
X-Proofpoint-ORIG-GUID: 157yDBJO8K20aZhri4fpRmRg5kRACSVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_11,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=891 mlxscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200167

On 3/20/2024 10:13 AM, Ramya Gnanasekar wrote:
> From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> 
> The initial debugfs infra bringup in ath12k driver and create the ath12k debugfs
> and soc-specific directories in /sys/kernel/debug/
> 
> For each ath12k device, directory will be created in <bus>-<devname>
> schema under ath12k root directory.
> 
> Example with one ath12k device:
> /sys/kernel/debug/ath12k/pci-0000:06:00.0
> 
> ath12k
> `-- pci-0000:06:00.0
>     |-- mac0
> 
> To enable ath12k debugfs support (CONFIG_ATH12K_DEBUGFS=y)
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


