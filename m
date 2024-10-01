Return-Path: <linux-wireless+bounces-13392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B707298C989
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 01:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4151F24619
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA8C1D4335;
	Tue,  1 Oct 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ei2CyyJA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98E1D432A
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825802; cv=none; b=B4BvWB83x+yhtoCUz/p9jg2YefwDPAiz81mniwk2sPZb+Ovd1Pe+pGJITHtioMAXDdtfPRiUK1alHH+DKjaTa4hky/ohDnQI+TF2gjSZoB86mEfPoMoI9echK8mTJhckOJbX1jQbSWNlMj4CL8Nb2vO7AIu2NkSHhf70lpC2O+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825802; c=relaxed/simple;
	bh=oiIfznLnfn9BRMAKIUK0sS5ChZXwdFmh1w56z2AlV4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OOfztK9Z9ENbxewQPEvxIqIZJxCt2VBNs/YOinC1LlfCQG35PS2Jg5DWwEZRJmUfrjx5pqvwLefo1s71EbP9z3VjoajT6Y8t+ixv9XSUXLcV1AXhdJrRwtAfczwrAsEH8NTAPTOtAgk7fyLksjQ5bep2Sf7NA3aKxK1BVilQ1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ei2CyyJA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491N7ZBT013853;
	Tue, 1 Oct 2024 23:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7hBtFRQ/pODJPlMZDaeE7XDB0qJUQKZqYSGjobKZhKU=; b=Ei2CyyJARHDXWJI6
	CrxSHN1mZNBgz/uAT5rZM8EFWrQ+3IVVaHnGaaugFJHLutG3gq7uz8QvhWZxIxav
	ZINP5kb/EQWXzVF6NJYKUB4Y8LfXRmnQqxj1m8jSXIzy55NiD8pahMssDjQM95ka
	t/Hyo6T51kB01+NxfNog5NNkiL4RfnIieHD28J58cAG54qPgNEoorDJQ5aDjfVH8
	j6BwC/ZtLan4PBtu5RfhWIxS2T4wOi9IeIofHBtu+2S4hY37CRCaWdD6INMBF+0r
	zt8Vr4q8Czju/z1sye9Lw4tt8aTH4SWN+g8dPSxR/Pwm7u+1zWhJJSZZo7jeaK9e
	5wJe9g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x94hj18t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 23:36:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 491NaQBl015538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 23:36:26 GMT
Received: from [10.111.183.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 16:36:25 -0700
Message-ID: <36130760-b396-4c4e-ad1a-dbe8415fdcb7@quicinc.com>
Date: Tue, 1 Oct 2024 16:36:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Support DMAC Reset Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
References: <20240926051110.2477814-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240926051110.2477814-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qwoguz48oYRNsv7ypag8f-xh4VipsMeM
X-Proofpoint-ORIG-GUID: qwoguz48oYRNsv7ypag8f-xh4VipsMeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010156

On 9/25/2024 10:11 PM, Roopni Devanathan wrote:
> From: Rajat Soni <quic_rajson@quicinc.com>
> 
> Add support to request DMAC reset stats from firmware through HTT stats
> type 45. These stats give debug SoC error stats such as reset count, reset
> time, engage time and count, disengage time and count and destination
> ring mask.
> 
> Sample output:
> -------------
> echo 45 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_DMAC_RESET_STATS_TLV:
> reset_count = 1
> reset_time_ms = 8036717648
> disengage_time_ms = 8036717648
> engage_time_ms = 8036717649
> disengage_count = 1
> engage_count = 1
> drain_dest_ring_mask = 0x0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


