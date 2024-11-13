Return-Path: <linux-wireless+bounces-15280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511119C7D1B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 21:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D76283BD6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F820103C;
	Wed, 13 Nov 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mBGwe5Gw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B43189F45
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530758; cv=none; b=m+Sqqsl2B2Jtg2RQCgGTPImtgslTdqdf7U/tcts+nypPBeehAilwJchGDKt7ODTVLISDp6o4CkaGJ3tNYtFNHFS4/c1n6YRXzdYKOPQNes225PfpSgwcEPM6PtjmGBW94PCbvECe6gd7k8VpvrVp02qMB4MKZzyEX8sSNE9jzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530758; c=relaxed/simple;
	bh=SIzCrLQwChCvDN0QT17aBq/N4H5G4bgd0X2oAMZwOv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=topz64iGEXWLBlynS1Ak/fUdX8mFJuOaKPxl2uagsChxC+tsfxPi1kH/VIkHD183wA8nMFd99v9UCLfoi1tpyhM/dz49mssmBtQUubMskhoqpLKZ6/cBO266cJnmYhuXFDA0KvEPp/Sa05Ri1jLCBI9gQ5siIVMOjsIsIhO1XoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mBGwe5Gw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADHxgiU027022;
	Wed, 13 Nov 2024 20:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lr8r7RYSll6wbkuXNkdfUly12aqqfyacJTDVeodYpWg=; b=mBGwe5GwRTu/NU0q
	zemVysqPZh1Hd7NAvj98qJS8XJ/hb85iJIroWs/jlw1Rv9ANmK3rlu2WuCRl4pII
	NcN3KAtB8A634F0HX3QTNNy81UWCq/z8DTNQa62KI2eqeyFfULGNHv9fpJGR4+Py
	EoaRsE3y0dVsk3Jtvl5q74KQnE3CoRmZTJE4snMuG+oT73IjuMgQ7304KYtUtVJu
	sr2fCDfTNneJlJvRKvjyWdo5Rwzg3NeWpA2QeYxfInwIRbUzF7ExTXOT2CqC3iM9
	7swvn1ZXrDygBuT/i254z467PY9A44ffq5TD5VDmuPQcmJ6zo1g4yvxrNJgq5FUn
	NoIsOQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w10jrec4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 20:45:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADKjoH8027919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 20:45:50 GMT
Received: from [10.48.243.207] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 12:45:49 -0800
Message-ID: <b40b21cc-2c82-426e-9194-404b21b7e3bf@quicinc.com>
Date: Wed, 13 Nov 2024 12:45:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] wifi: ath12k: Support Downlink Pager Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241113072707.3377341-1-quic_rdevanat@quicinc.com>
 <20241113072707.3377341-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241113072707.3377341-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TBaIBlohfPu6mHryVJA3e2jZiFAQ_nPX
X-Proofpoint-GUID: TBaIBlohfPu6mHryVJA3e2jZiFAQ_nPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=965
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130170

On 11/12/2024 11:27 PM, Roopni Devanathan wrote:
...
> +	dword_lock = u32_get_bits(stat_buf->info2,
> +				  ATH12K_HTT_DLPAGER_TOTAL_LOCK_PAGES_INFO2);
> +	dword_unlock = u32_get_bits(stat_buf->info2,
> +				    ATH12K_HTT_DLPAGER_TOTAL_FREE_PAGES_INFO2);

drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2615:43: warning: incorrect type in argument 1 (different base types)
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2615:43:    expected unsigned int [usertype] v
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2615:43:    got restricted __le32 const [usertype] info2
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2617:45: warning: incorrect type in argument 1 (different base types)
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2617:45:    expected unsigned int [usertype] v
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2617:45:    got restricted __le32 const [usertype] info2

Note that previously Kalle suggested:
There's le32_get_bits() so you can simplify this function quite a lot.

So s/u32_get_bits/le32_get_bits/ in your new code


