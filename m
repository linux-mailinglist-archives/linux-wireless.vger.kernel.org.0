Return-Path: <linux-wireless+bounces-2853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DA4842D12
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 20:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929481C23135
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174C7B3C3;
	Tue, 30 Jan 2024 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VdLwpHlv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B117B3DA
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643584; cv=none; b=MOuof3/L39oqQoKnfT8PHZ+K+ZVGDgb5uixVqxTLP+lvBER/5z+BWuauQOLmRzWIuffWVVDzNLrLpffsiJMDDIZDiXfKhR78GqMRqFrxWbTuUQFh0reF5POTxujAq920uCqOgGDKJ0fg7u1YGPY/A68Oy3GSdiF0uhQBR1p1AE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643584; c=relaxed/simple;
	bh=2hcS4gx8xG/OzhEXLY1mY3quXYACmdiy/wlh81sYVEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DD31+6PbpvYOJ0ftSloCjRoV8i7XzIiDOY5ROdaXluHUImkOh1JPjObTbGmtsnfKqbm63EONIq2hJzsUFTYqK4ovTryrZ6F1JWl/3fuVC23ri5u92zvjtN76J9mJW5sLGkr5VXmEF8AWt76bGFzBEnyQ6KduygsZvQdtYyNEV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VdLwpHlv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UJUI5X010226;
	Tue, 30 Jan 2024 19:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oBzds0B/EJQpxf86qnK/bhlQp7r65fM7oRzat/htx1g=; b=Vd
	LwpHlvB5JqJVaPXVdxJegfLyOGeRNfuFJNXyXeRoBRTzjviPM2+OMR+GwM8km6E8
	pA+zBvHDaOf2MLDddCxMU0/i+dvCBliDK25pGxINLf9p6RrfLyi9Zw1v8oEX+2N7
	o81JAakPwLFLR5ka020agEo0GT4b2e4TmMUZK41NEcGn5WxMDWJgFNNcrcM16Bl1
	p6K1frFBVN6bjgqVm1PDT76uSrrqRp+Vn8xv7ZRqT2LRe6E5ceKWVmhvitwtdAvj
	LlS+le9R6ksM8l2urplp+2GvVhni08HlBrVlB8OHOq1fWFyqRjnnro68bffvGXnR
	ra/E47/B9HV08P7KPe6A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvve1nmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 19:39:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UJdcKP020411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 19:39:38 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 11:39:37 -0800
Message-ID: <d01d6baf-2fa6-4e39-acc7-e891d6b9ea65@quicinc.com>
Date: Tue, 30 Jan 2024 11:39:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath12k: Refactor hardware recovery synchronous
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
 <20240130060838.3895599-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130060838.3895599-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -_WbOUSLNxTpzWgyiJQiQEWK9LihAuPU
X-Proofpoint-ORIG-GUID: -_WbOUSLNxTpzWgyiJQiQEWK9LihAuPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_09,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=300 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300146

On 1/29/2024 10:08 PM, Karthikeyan Periyasamy wrote:
> Currently, in multi wiphy models, radio/link level synchronization is
> sufficient for MAC hardware (ieee80211_hw) reconfigure/recovery procedures
> since each radio/link is exposed as a MAC hardware (ieee80211_hw). However,
> in single wiphy models, multiple radio/links is exposed as a MAC hardware
> (ieee80211_hw) through the driver hardware abstraction (ath12k_hw) layer.
> In such scenario, we need synchronization between the reconfigure/recovery
> callback operations (i.e., ath12k_core_post_reconfigure_recovery(),
> ieee80211_ops->start(), ieee80211_ops->reconfig_complete(),
> ieee80211_ops->stop()) at the driver hardware abstraction (ath12k_hw) layer
> instead of radio/link (ath12k) layer. Therefore, introduce a new mutex in
> the ath12k_hw layer. This approach ensures compatibility of the hardware
> recovery procedure with both multi wiphy models and future single wiphy
> models.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


