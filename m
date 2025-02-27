Return-Path: <linux-wireless+bounces-19524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77217A4755E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 06:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7862D3A9D5F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 05:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6121E8356;
	Thu, 27 Feb 2025 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hj8KAKGu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA11E8325
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635277; cv=none; b=AXnrk6Jbf+CvJpQ2z7N5VGzc47lXgcA7MFN8ozprApqVUz+ikCbJ8IpnIYpD8p0NqRlNkhtQ8pFv2itLEj7i9OPLqSU4zTYGLz6XyUkhz501l9qQGwW4qgV+7x2ZnYjBpINqxA3JpD+gzfp46A9HPxeC/I7kswDn8Ae5PvL/+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635277; c=relaxed/simple;
	bh=47IselIIfFSUHNfm9rt1hsGwciNtaqufGepLlH4V9A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MY2lppdPyGCytD2pX5lHfWc6X0nBMj9FJEk/SR0sgepdfyHaXD34LfbzKVXihKGtV8sYrSq5+43rmhzT+0u0X8Vk8gW4GOFGhN/CDOBmKaR47v/46pe+YpZsHm2iDsOCb2pcYcqeuIu9ecSJJaWydTtnLzJzF9F8fUgz5lbJdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hj8KAKGu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QKOL6F015373;
	Thu, 27 Feb 2025 05:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d0AkrBzDCTp7nsYD2IW69Z942FfJk5/WWRudL2bE0h0=; b=Hj8KAKGucUkX+riF
	cizC3CMaba45L5ZjmDKDw4t31yhglQDDZ54tOErJ0qwxM4QdrwNJnhUWu9eswadV
	jqEQGYN95//9gerdU61SFi4Knx9QtEWyo6hfGoBUqjFMeKg1QRzFev6v7kb3YNBx
	7JhrNjqC+2PCRdnNSBStYdzv0uWekEw2Va3LeiF7PxL4KYIukc4GjUzt/Dr4etQA
	UslO2EEbdVmRwCwaf8sN25zwMcqfAWZyIoQ2BUVDS33a42x0tib/Whs0rexIHn1l
	C2fBdwbqgQd0rcwyzlfxsHQzTqxSYfRJBqlphOI4/9LhPHoQ00WEtaquBzFyo92r
	LKVQew==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnmepg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 05:47:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51R5lbrv010172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 05:47:37 GMT
Received: from [10.216.32.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Feb
 2025 21:47:35 -0800
Message-ID: <5a7a3578-7315-7e3a-e8b5-b69bbfe9fc74@quicinc.com>
Date: Thu, 27 Feb 2025 11:17:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/5] wifi: ath12k: pass tx arvif for MBSSID and EMA
 beacon generation
Content-Language: en-US
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20250210182718.408891-1-aloka.dixit@oss.qualcomm.com>
 <20250210182718.408891-5-aloka.dixit@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250210182718.408891-5-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: almI9gwK5E8P5Nz_9BNEJ3F4YvDJOJ2w
X-Proofpoint-ORIG-GUID: almI9gwK5E8P5Nz_9BNEJ3F4YvDJOJ2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=869 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270043



On 2/10/2025 11:57 PM, Aloka Dixit wrote:
> Add new input parameter to ath12k_mac_setup_bcn_tmpl_ema() for
> 'tx_arvif' as the caller ath12k_mac_setup_bcn_tmpl() already
> stores it locally. Avoid duplicate retrieval.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

