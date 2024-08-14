Return-Path: <linux-wireless+bounces-11444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1883895221B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 20:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8151C21A96
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D8B1BBBC5;
	Wed, 14 Aug 2024 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pfCmW2Hk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA451BBBEC
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660688; cv=none; b=oJ9PRnuYyVzuSD1qJrey60pf848fteu1lBXf9+wFOlcRfoilEZozkW6Lg5Ts1kjSeZRfQm9IE3t/T2DnF28LNMUVXI91MSvWU7Aa5KIIfiEp/H8a8x9F0DlBJcljT+5muvigLHjV8ObqYHF0S1auVRGWpD3QQNWdQGrS2lmEOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660688; c=relaxed/simple;
	bh=YG/kCOOeMIdlb1HOBpKshmzAFHJj9yHbdWV9fdQhjfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AYlG2+hSwBr1z+emSbsh6zhwR1plJwY69X1M4ryRk79wzBRt7FpZJYo8/ZX//su1TpHfLMnki+iYU101AO6o7t/yuhfx87fU34YGALpiX0kp9gcMq6vXy9bSrLn4vRZzJgRMotyI3eBVq8TEgn1mqWtgYg2otX45qtocZODAjzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pfCmW2Hk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ECXoxR016991;
	Wed, 14 Aug 2024 18:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cLNiJmfcTB0/qV3Gx6fRNaSc8lttrODzxrMvl9Ky14c=; b=pfCmW2Hk96c2apPO
	EieqDbm2lGcWxDL6HikH4Q8sOeXWEB4kiLV5YY4tXQQbClM8UIi/lnP6qw9bZaHn
	VGFNRGvQrVan/oe5I1qCAZi6cnK9OP/yA/cfAVYGxJWpsTrB6Iw0IMGvfVk/eVFF
	zI9fdBlW1yZxMiB+ckeKiI1xDCNzhtPYHITI0ijeaz1OAmgo7BbAWNnRkmq9ad0o
	8i2Y5pIpgnxCFkSBufW5oi3S/G3Yfjm6+5JVrgTVNJKbTHzPccjuyTnP6Wi3Q3yw
	94jcP5f6FUN9u9HLZD0XIjg2Yps78lh5XyOrx36rwnwbwzolUucOLc3GyO6KMDul
	gK8RvA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410kywjf0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:38:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47EIc3KD005124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:38:03 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 11:38:03 -0700
Message-ID: <a5daacb9-1895-4f63-87dc-a4ac204e37bc@quicinc.com>
Date: Wed, 14 Aug 2024 11:38:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: Advertise multi device iface
 combination
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
 <20240814103423.3980958-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240814103423.3980958-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 56EHr85w5AFgCPjchbUCvNnpfKzZU5gz
X-Proofpoint-GUID: 56EHr85w5AFgCPjchbUCvNnpfKzZU5gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_14,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=730 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140127

On 8/14/2024 3:34 AM, Karthikeyan Periyasamy wrote:
> The prerequisite for MLO support in cfg80211/mac80211 requires that all
> the links participating in MLO belong to the same wiphy/ieee80211_hw.
> The driver needs to group multiple discrete hardware components, each
> acting as a link in MLO, under one wiphy. Consequently, the driver
> advertises multi-hardware device interface combination capabilities
> specific to the radio, including supported frequencies. The global
> interface combination represent the combined interface capabilities.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00183-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


