Return-Path: <linux-wireless+bounces-7288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F168BE5BE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 16:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B61D28C667
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D405115FA62;
	Tue,  7 May 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O4I0ksf5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E129161B43;
	Tue,  7 May 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091614; cv=none; b=NQo8qYph+4mXfFU12b8hOZ4FgkYzmNUPjfBCvw8UixN7Ai9cNVeRMzdLtyv6eRmrLswX/WNJM1Zyq7Yr5SvNHj3JtlIEU2T7kPwPbqq3p1kQ51Z+tvdxiUDzYIlo6IYolEz7vIHqv9yg8rJieN8WfmKa8YJBBdJmeRJVwIRgKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091614; c=relaxed/simple;
	bh=Z3k6GEHhInCxkkJ5sZ7Y9TpE/TSQpmHcEwiyM5m2L0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Brv+eUSttmxDkfrF75h4l+1zwCcgXaAgrVgIgT77lFs7g78F5Kfgoj8zBMF72OZGyEhDRvMy03maT5jyxEZ9NEBCN5Rch0aFPxa8QlR60tL+e+er3vKuQlF5/F+6SRz1N3erE8sdoop5A22/57m2umlDK/QcJwJ3HTAYO86/TwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O4I0ksf5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4477AHAO012181;
	Tue, 7 May 2024 14:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=f3WM8370/lnueAlT0eDtBR4HcsXIQHe1qxf55wjIXws=; b=O4
	I0ksf5MqLT5OPN92db1eBs0yjNfNtCFNARLYmukvc94v+jx4dIppyB58XxotsYok
	N7p5h43dEp2v/OtGhUA28Wr+drRumxwo96ufJbaBSFpsnZz+JzOSKA+sKfjBiSRZ
	IJ9FowjrAC+H42sdsU5Og6jIagrRfbNhxiUysPRbJ/05IKDLTg+XbuoexDYdbYu/
	xchzxQZo0S/6OaoYTHuXSL2Cm38QfsoXRYYXqcND9u0pHSCr39/DTo30qHTUrEvM
	K0Yv842uWllnJ8f8FTCH0fYSXJdSQD9W1ANAX/X9c1O1V6cs+YzhgHrxzYvd2px5
	CXqiLfBsg8QvwbnGVDSw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyf1097h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 14:20:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447EK2jQ027702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 14:20:02 GMT
Received: from [10.110.82.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 07:20:01 -0700
Message-ID: <c344144c-8593-474c-9e85-c957b3c8e5a9@quicinc.com>
Date: Tue, 7 May 2024 07:20:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: fix misspelling of "dma" in
 num_rxmda_per_pdev
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-1-44d2843a2857@quicinc.com>
 <171507926213.4120318.15441054563934456845.kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <171507926213.4120318.15441054563934456845.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7osSpe1tlQ_fInMWx3-yuMviDRsLzvHk
X-Proofpoint-GUID: 7osSpe1tlQ_fInMWx3-yuMviDRsLzvHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=621 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405070098

On 5/7/2024 3:54 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> 
>> The ath12k_hw_params member num_rxmda_per_pdev contains a misspelling
>> of "dma" so fix it.
>>
>> No functional changes, compile tested only.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> There was a trivial conflict in ath12k_dp_rx_pdev_srng_free(), please check my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=238d04b67c32e99181b0249bb847b11ce702960b
> 
LGTM


