Return-Path: <linux-wireless+bounces-5720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9C894414
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 19:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F12CB20A5F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A034487BC;
	Mon,  1 Apr 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oIR2037B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4D40876
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991674; cv=none; b=ZqdDR9heFM5Jto9shwBV3su4F6kv+TDtmPuHsKMNR8GFVjp8FCILv6SieiMa8xsXgo2Sw2f+lAtojHTeUm2aZYrvEu3kVhaY/3wKBvPg5oLrwBuc8WjJHBrvhGdoYjwtNG7VrybYl62jkHXCAcc2q8/EX/KwpldJk/NuFzU/aSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991674; c=relaxed/simple;
	bh=Sy+HBaXLANu8ncc4LMnWbbi7Xpayf500FSYPA/QNY5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hKAT6+bO4udI17Nffb0UfeIXwNchnlHwTREVc0qvvvCZUD0/+8oUGBz/QrbnQ+ygPv6xoWIEdaPdUmzfqpDsTLPnQ4kSSPa0jzRhbNSvlpDpV/ZM1S7PPGedQjpbig6we+7KGCQOhuxk8CI0AwINccEFTORA8O7f/UVvBQ68giQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oIR2037B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431DjZnT032055;
	Mon, 1 Apr 2024 17:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JzMJKu3kDtrKznyitm04aDX08Vo3adc5zsrc8ZGbZHE=; b=oI
	R2037BQpUQqJ/9ApTkqXo6yLjxa8Ey9RyRY1afLCAOR+kH1QVeV9qahdwto1qVUw
	LDijGqmw/nOn1qn+GAlMP0zg7YRuyd95yQLALSgWj3nOVqebO3AGe2kQu24Sp4X/
	+Q29wXycDdt3I+XA3SY/MSsc1YbWz55tbIU46tWE6l42fxDD8QymiP5Dgtt3ov96
	mSNbJ+mf33nNENTYD7RVkRpSV9bEjcuvfUA7WWes6WE31emE94Q0MaaSUAr3M7cj
	vF8wt6w5mjsuK1qqKvqMOrVh0kLL7gBdHS7UAS304EwoO41K9bj+Xev9JKKOB50v
	5Vp1sBaT5XcLcd5uZV1A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7r0hhbf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 17:14:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431HDull021238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 17:13:56 GMT
Received: from [10.110.126.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 10:13:56 -0700
Message-ID: <bb0dcf9c-43ed-4547-ac8d-0112b2cea94e@quicinc.com>
Date: Mon, 1 Apr 2024 10:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix mac id extraction when MSDU
 spillover in rx error path
Content-Language: en-US
To: Nithyanantham P <quic_nithp@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240329092432.873710-1-quic_nithp@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329092432.873710-1-quic_nithp@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OPlDKUg_NmFOlYHK0MZC7QtkUEaznKMF
X-Proofpoint-ORIG-GUID: OPlDKUg_NmFOlYHK0MZC7QtkUEaznKMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=274 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404010122

On 3/29/2024 2:24 AM, Nithyanantham P wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, in the rx error data path, mac id is extracted from the
> last 64bits of MSDU end description tag for each entry received in
> the WBM error ring. Then, each entry will be updated into the MSDU
> list for further processing. The extracted mac id is valid when a
> single MSDU is not fragmented and received in the WBM error ring.
> 
> In scenarios where the size of a single MSDU received exceeds the
> descriptor buffer size, resulting in fragmented or spillover MSDU
> entries into the WBM error ring. In this case, the extracted mac id
> from each spillover entry is invalid except the last spillover entry
> of the MSDU. This invalid mac id leads to packet rejection.
> 
> To address this issue, check if the MSDU continuation flag is set,
> then extract the valid mac id from the last spillover entry.
> Propagate the valid mac id to all the spillover entries of the single
> MSDU in the temporary MSDU list(scatter_msdu_list). Then, update this
> into the MSDU list (msdu_list) for further processing.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Nithyanantham P <quic_nithp@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



