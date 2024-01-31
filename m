Return-Path: <linux-wireless+bounces-2908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C02C844965
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF61B25093
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4D537708;
	Wed, 31 Jan 2024 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Iqf6BJpD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BE208C1
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735232; cv=none; b=OgEBPCZai0bmcpg4B07L0zj8jFO5dhioeBBGc2rCengmL7CcQv0vbv16Bp9nf2iK2pjx8X8wew3tJS2sc6i57elp5RY5/9gNjVZ+kKvMD2Kv4dMHgpBoxeIqdiopO+wikk2dvsvFCcUFrS87mGuuwUvIPrR2C8XEDrSfw+TO8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735232; c=relaxed/simple;
	bh=nfMVzaF2DHJLLLiFB2FHPR3IBTNrHzcKGrB/f+ST5FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hb0Y19eqVVlS4ckO5EHygS7ZemWup3CsPPAEnOKcxFm3lvpsLxNYOH1FNYTiwoUaIP39b8DBRejrNRVEYF+9kO5WgcSjHyYpXbPl+rFzr4bea9BxPhEhADg7kqUB1MexHTO2pzD2k7coLwA+NY7VrgWa7UvMdnkcSj3mzMkRIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Iqf6BJpD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VJOeKe010853;
	Wed, 31 Jan 2024 21:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2GIrl/SmW4ZjjHE6j7O6SjR+Wue61KRzdfe3ijAPxjw=; b=Iq
	f6BJpD4YpEtPASSWwvDLAcBsoVrs5tQMLcMlo+qjPDz4y/S6zwKVKDcjNgq+15fd
	AtO+X3xnJm6dVMmQxHOIKq875wBrnzKqzkxJ3tZgtu/McBWJ1ZMg0N6mXpYZzASp
	ufB/aSQFRn3eM0r7KeidIDVv2yG7++Te73EmMLge+G7nbzhpS6Vtn7D4i//g6QqU
	qZKIS7I7maxZGIHZrbUfwf1YDb+Q/2C+LNX6cq2TTWsEu98xIqPxXVFYFDe4/wKG
	wyqkuTrr4CMLoy7OkYvourME3EWyiDvxMrZ+dY8V/qCmsqE1hkIxIdJwV9RL14zO
	Fz+yuc7yWkyJ47VV81dQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyvb5g762-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:07:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL73RR032544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:07:03 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:07:03 -0800
Message-ID: <8f764296-4920-47ef-a361-91748ed72d59@quicinc.com>
Date: Wed, 31 Jan 2024 13:07:03 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] wifi: ath12k: split hal_ops to support RX TLVs
 word mask compaction
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-8-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-8-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gx4XDesbJNwNu1dVbhF02RUN-jH4GstG
X-Proofpoint-ORIG-GUID: Gx4XDesbJNwNu1dVbhF02RUN-jH4GstG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=911 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310163

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> With word mask subscription support, the rx_desc structure will
> change. The fields in this structure rx_desc will be reduced to only
> the required fields. To make word mask subscription changes compatible
> with the older firmware version (firmware that does not support word
> mask subscription), two different structures of rx_desc will be
> required for the same hardware.
> 
> Most of the hal_ops are directly related to rx_desc.
> 
> Hence, split hal_ops into operations that are independent of rx_desc
> (hal_ops) and the operations that are directly dependent on rx_desc
> (hal_rx_ops). These hal_rx_ops depend on both hardware and firmware
> hence move them out of hw_params.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


