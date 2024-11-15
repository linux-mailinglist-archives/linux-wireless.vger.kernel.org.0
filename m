Return-Path: <linux-wireless+bounces-15335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10179CF6E9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 22:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E881F21948
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 21:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29951E260C;
	Fri, 15 Nov 2024 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bKuk8XTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132681E22FE
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731705436; cv=none; b=WYW3tUJLeoqiZm3sUw80/OZ85jCDZgV8ZaRQrHNuthjecYUh7yuHZRenDTHV2w7srsFOq+KHvapCVNaXKxJ9XLQnnkXtUmX1oD9V26mZoO8vW8Idl1/5lQCGArgFTHTt9ztJm3nP77ktUsAFWTGVkZ4GoJnN9juZCODzCTiPp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731705436; c=relaxed/simple;
	bh=ItrJO6GnyTWKpkm0UVUIrNiT9AvyRUn//ZlyilbEqx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rx3NKn9y7CsZMdzib0f8rMFZomY/qxkaMYluT/U88XX2P7UX84yL848yHBuiSiXOdmcknUK31p0yY+hlH0qdlcGrT2TlMN7Wv9PoiSny+Mnq7rWSE0P8AZB0MV2mc2nvJir0bIDOgUhPc48T5nnM2+ipMfvp2dMVi/gwiV9SEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bKuk8XTT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFHJ9mf032612;
	Fri, 15 Nov 2024 21:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BDD4hDYSMtQB7r+4wOQB8dBNuLSOjGFor0EJalXUfXY=; b=bKuk8XTTSs4nimBj
	5q6kQSm1MJSdZrufwqwM9A5qUDH+3KgdqlZvMrUT0CBJ5vOyEz/NJupCe8oTywEu
	NV/sqGFa8fqkdHzHUCaw4e3YB5WL11gBwFCZ2oMhQRKRc3ksEeb52HS/6V4jb8WI
	xlEx5ASmfkjsgTSfStXztiNw03IYJ3jnEx0j4xqBGWN6/9RzMTTmI+Xa8BvrUYfB
	yOcyJTfdU8UbmEfYsMT/sO8vRTAn/Kr1SECuwgcIP9oi5bYwM6hotw1aHIfCdlrE
	cz70mW2it+RvvJr1B4jRPLzAK1JufS4QQoTHBuddsA7nJB1V34FI/8pIKCHGCKZ0
	uzJ+1g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wjqamnev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:17:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFLH9LB028316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:17:09 GMT
Received: from [10.111.176.23] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 13:17:09 -0800
Message-ID: <76039296-5677-4597-b3ea-a70c7832543d@quicinc.com>
Date: Fri, 15 Nov 2024 13:17:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] wifi: ath12k: Support SoC Common Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241115062854.1919672-1-quic_rdevanat@quicinc.com>
 <20241115062854.1919672-4-quic_rdevanat@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241115062854.1919672-4-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uCZKrM5iuJ0JvuiyzhfxNAEBGGzd0sfX
X-Proofpoint-ORIG-GUID: uCZKrM5iuJ0JvuiyzhfxNAEBGGzd0sfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 mlxlogscore=967 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150179

On 11/14/2024 10:28 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request SoC stat from firmware through HTT stat
> type 38. This stat gives drop count of SoC.
> 
> Note: MCC firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
> support tag HTT_STATS_SOC_TXRX_STATS_COMMON_TAG(125).
> 
> Sample output:
> -------------
> echo 38 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_SOC_COMMON_STATS_TLV:
> soc_drop_count = 0x0000000000000000
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


