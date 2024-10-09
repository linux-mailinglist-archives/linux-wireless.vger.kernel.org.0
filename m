Return-Path: <linux-wireless+bounces-13737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F8995C14
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F716B239DE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB649370;
	Wed,  9 Oct 2024 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fCy9W5Jk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716636D
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728432470; cv=none; b=KmS498lEZOOEVEmHl3iB644xjuCUuAMjegvT1fOBskwKTJ4DUUmRfXpS4yNv0Y0F60snFuhhE26RI8l9pK/dSAyoh4wWH+/7HcIfcLI2RFShYHwPoFxfUXkHRumvYl+PRa1U8AEA+PGrUPpuN1T97f5Qir5apn/84OymNv6ENks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728432470; c=relaxed/simple;
	bh=sZTRIHh+xmGNSbPyFxiFC5keT2bV88b1N0LlOH3OmJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S1XxE3sGGvJ0uMvXqQPEH/NOdfAw+AKDZsqpSa/3LgvvopBNaNIdyOXBRkbIypFFSOWB8BZbAz/WhMtV+TGTqOh8dyZZgNEvsnXrJQ2LKl/wyjH9k8pIFkbQWo1qApC78aGM5nj+iFco9uymJyKCWLukrV2RLI+vQAlxjwHsYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fCy9W5Jk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498E7t4v010559;
	Wed, 9 Oct 2024 00:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UJ+c4vwFUZN9wVYMkMLmdRgOZf37ZiHqiqhHu5kQKlA=; b=fCy9W5JkBcsMoiO+
	osAijdE7+gkajOQ0Zqy/okdWVhNzdv56oAD/yw6qoxoPCVHAGuDCoFa3sLOtXN4+
	3oCrsqGcLXez9alaHjdmjtzRSdiTqFGzHhkr0CNVqjXJ2+2ZVdlfba6GTiMvh5yl
	fTtHLudC3YcL7xnso9tmYPcdI9xYSR44nz+1qdl9PSSqY9JAET1SLKjQ8og5xmZv
	6ezOfH9pm7T6FmHWmaxd9PLOi1dy931O7yA1KJg7MEwRBZS9GPBffK1R+aqiB44h
	rDJ16e369DUpJ/HP6T5/WVarGHg60Z6Rr2JiJISMIQahsy6h36mQ+zELx/AdcBPT
	nomAJA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424x7rtxqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 00:06:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49906XP7021932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Oct 2024 00:06:33 GMT
Received: from [10.48.240.101] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Oct 2024
 17:06:33 -0700
Message-ID: <11b8e952-25ed-405d-b730-4aa4f1ed7820@quicinc.com>
Date: Tue, 8 Oct 2024 17:06:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] wifi: ath12k: Support AST and Puncture Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241005112234.3379043-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241005112234.3379043-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YtyrqHR1-EDxSzbRexAWtxXiRK1_2BeA
X-Proofpoint-ORIG-GUID: YtyrqHR1-EDxSzbRexAWtxXiRK1_2BeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=950 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080157

On 10/5/2024 4:22 AM, Roopni Devanathan wrote:
> Add support to request HTT stats type 41 and 46 from firmware. These
> stats give Address Search Table(AST) entries stats and pdev puncture
> stats, respectively.
> 
> Depends-on:
> [PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
> Link: https://lore.kernel.org/all/20241004085915.1788951-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
> Link: https://lore.kernel.org/ath12k/20241005101816.3314728-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2] wifi: ath12k: Support Pdev OBSS Stats
> Link: https://lore.kernel.org/ath12k/20241005104206.3327143-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2] wifi: ath12k: Support DMAC Reset Stats
> Link: https://lore.kernel.org/ath12k/20241005105207.3350790-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
> Link: https://lore.kernel.org/ath12k/20241005111506.3361688-1-quic_rdevanat@quicinc.com/
> 
> Dinesh Karthikeyan (1):
>   wifi: ath12k: Support AST Entry Stats
> 
> Rajat Soni (1):
>   wifi: ath12k: Support pdev Puncture Stats
> 
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 194 ++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   |  56 +++++
>  drivers/net/wireless/ath/ath12k/dp.h          |  12 ++
>  3 files changed, 262 insertions(+)
> 
> 
> base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61
> prerequisite-patch-id: faf46024c8b5c094e201d392109e7f94dcecdd49
> prerequisite-patch-id: c4662f64bc7be141322b7e37145e52ea4ab4e182
> prerequisite-patch-id: 4d37990775694f110ce3e87096231fe8855f09f5
> prerequisite-patch-id: 5959fd18b497d29cad98d36dcce59a876ffe8ca2
> prerequisite-patch-id: ecac67f6fce1dd4d5089dbc3da840e311f6a7218
> prerequisite-patch-id: 0537ae604d2617e42bef13bfb791aad4d11bf6e1
> prerequisite-patch-id: da5a4e5cc3097994bfcba4b37680c90b0675ccf9
> prerequisite-patch-id: fcd0ce1adcc63e80c95e4636bd4614bd5b732ffa
> prerequisite-patch-id: a6303524834f6e01b2ae1469ee437d586dd5d522

FYI this patchset is not applying cleanly on top of the ath12k-mlo branch, and
hence I won't bring it into pending until after the ath12k-mlo branch has merged.


