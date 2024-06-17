Return-Path: <linux-wireless+bounces-9131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0E890BC4E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 22:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02A11F22C15
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64287535C8;
	Mon, 17 Jun 2024 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CQD2SL/x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D3188CB6
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657124; cv=none; b=TqIZ21W9PC2zrZOV2rpKuOZqEVgtiefY4NmirO0i2x06H1q1rAM/DhW+uj1DXKcQiO+zpNOiLz4cSopCIy6YqTMJB+rrnwoxcKggAX30brPxWjPBJsn9s4ABbV3ukj9G7r98HHBdVyu/xpTTfJbFZ2rYncKgvdKYHqaGZ+ibCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657124; c=relaxed/simple;
	bh=J4ubByzIoptrektGmedIZCo3+LYUzHyTLIsaq0W2Bgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iKupjDAg6i7MN5zjuBLKlb5MtVkwFwGPSHJnkv2ZUxdxRQP/ud24H34jNV41yLPrNihY/ZBKhszk5fsnZUONOfnTUGSRyUaSMTorkXXmNMgFZH2VbvFZxcSEQOY09ogq2QP1d8nOMLRGhFrNCYA/XUHtRj2Ix5CtBpWRTufDE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CQD2SL/x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HHwImc014941;
	Mon, 17 Jun 2024 20:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3YN7NHZW+6uHWZKmosTZLK4M6tHvYcvfLDbi+rjPgSc=; b=CQD2SL/xWNtVaLMG
	FXwid78TBtJhXVjyf9ulGxrrLMFo8Iw8L1d/Xj1w4Yk+6n6pMqCYhUcFiOg2W76Z
	9DbDWBaU22Y6ezGg/CIgG0WH5daPjZ+vyyGf7mnf2MQiNOG7XenAN90lMAs8TYxS
	T/ZAunNPE/ZKnkRBijmUcTiEamKqczflN32w2jGceR53S82ZI/9IfdEMMW+9IoCL
	zGRq13V/Qr6JCogQZgfrCMR3YC9x1AdQBJroEGaku+N1HCn1yicU8RVm9lkzdXjn
	OghUvrwBuXuxIvrkjpuornFM37hFvh736UBdn7ZHWziLmKmBlm2mneymDKa1XWAL
	W+tBbQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytt0trcbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 20:45:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HKjHNP000625
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 20:45:17 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 13:45:16 -0700
Message-ID: <4abc7320-0deb-44f5-8abf-6043021117c3@quicinc.com>
Date: Mon, 17 Jun 2024 13:45:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] wifi: ath12k: Add support to enable
 debugfs_htt_stats
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240614063404.2659089-1-quic_rgnanase@quicinc.com>
 <20240614063404.2659089-2-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240614063404.2659089-2-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: amy8cTRrsgIK3p8qWK-_AqpYbZPNFVEp
X-Proofpoint-GUID: amy8cTRrsgIK3p8qWK-_AqpYbZPNFVEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=617 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170160

On 6/13/2024 11:34 PM, Ramya Gnanasekar wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Create debugfs_htt_stats file when ath12k debugfs support is enabled.
> Add basic ath12k_debugfs_htt_stats_register and handle htt_stats_type
> file operations.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


