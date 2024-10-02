Return-Path: <linux-wireless+bounces-13427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C770B98DE53
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721D01F27E1D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB33567D;
	Wed,  2 Oct 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IYKM0DA5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610D10E9
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881527; cv=none; b=ijQhksC2sTkFvDAJSaxRXjOVnMRa4E/VpwKQvATFDqd9PadkPdr2g729IYCIzY119/RLNfZoW22rrame3Qv2cjxxi+5HUs8kowvYql9ytJNmpFeOqZqtv2cnsObxmG4pxWBgsECq2RGmu6UbA/qzrRjjHSatUIMzL+OykbnmCuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881527; c=relaxed/simple;
	bh=bjgwHpmEeATSyWavcbaJpsqXpUww08UiJJt7j0NFSzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OGbIxYV6qJdJUqjLp+TUCUZYE2cEjQDjgGwgZsqwAaXs4dbRWrw68Qh7k/JtEtJnKoM9mVrpZzbh8/C9DBXvrfAFhRdOPBX78VsGKzeKzZ55Q122lL4CRzVlU6skUto+6V03suCXSQyvQT6NB0LkJ4X0oM9QmA0t4T+oIwLm9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IYKM0DA5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4921pGBF027724;
	Wed, 2 Oct 2024 15:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NaBlM4b+XOV1nrl98gaeRfPRdMjGFr536y65kYNcF90=; b=IYKM0DA5/TFbXE3Q
	dKHBk+p4Z1aHrRRrWpsPkXp7QxjNbjXxTWkQu8LvuN/PcJ/B8hHo639IV4fM+4kP
	HywsuHiKNdcaK0VN5b779yjcrHp6la4v1og02wVUnDhoj7gLEph8HLmADX+uV0kX
	v0e8GeprrvOH0bW07zkeVo6ufwo4NyrPXavmY1Qg9cNjl2QWQNKXwzsN0f7rrcXC
	nWJLNbWO5sJ3zBJGIw31pWc41ji6/TrZTK67R0JTjx0vASmg+QNdK+yDrx9duwgg
	caf3D7z6lAwrEdqVXaLbf6P4x+rGEIeQhOCEsBbtonSC63wUoHJMl+CnaSTFoOQD
	asff3w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xte12kn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 15:05:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 492F5KFR000342
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Oct 2024 15:05:20 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 2 Oct 2024
 08:05:19 -0700
Message-ID: <a7fd77c9-2aa9-4d01-8857-3d79eb464ecb@quicinc.com>
Date: Wed, 2 Oct 2024 08:05:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Support BE OFDMA Pdev Rate Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
References: <20240930171705.596703-1-quic_rdevanat@quicinc.com>
 <20240930171705.596703-3-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240930171705.596703-3-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C-vgEK6CMfcuMdbNQ_JGr6eHWj5CFyxN
X-Proofpoint-GUID: C-vgEK6CMfcuMdbNQ_JGr6eHWj5CFyxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=915
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020110

On 9/30/2024 10:17 AM, Roopni Devanathan wrote:
> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> 
> Add support to request BE OFDMA pdev rate stats from firmware
> through HTT stats type 51. These stats give information such
> as number of spatial streams, bandwidth, MCS, etc.
> 
> Note: WCN7850 firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> does not support HTT stats type 51.
> 
> Sample output:
> -------------
> echo 51 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_TX_PDEV_RATE_STATS_BE_OFDMA_TLV:
> mac_id = 0
> be_ofdma_tx_ldpc = 0
> be_ofdma_tx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> be_ofdma_eht_sig_mcs =  0:0, 1:0, 2:0, 3:0
> be_ofdma_tx_ru_size =  26:0  52:0  52+26:0  106:0  106+26:0  242:0  484:0  484+242:0  996:0  996+484:0  996+484+242:0  996x2:0  996x2+484:0  996x3:0  996x3+484:0  996x4:0
> be_ofdma_tx_nss =  =  1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
> be_ofdma_tx_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> be_ofdma_tx_gi[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> be_ofdma_tx_gi[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> be_ofdma_tx_gi[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> be_ofdma_tx_gi[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


