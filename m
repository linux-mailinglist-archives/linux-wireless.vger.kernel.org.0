Return-Path: <linux-wireless+bounces-2905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B32844962
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF8E28A3EA
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210C37708;
	Wed, 31 Jan 2024 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nzCLlz7l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499539843
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735171; cv=none; b=BErNbIqULX/6ilMKorL17dhS3JdDT6B6D9T5DVqccQuTnsDjFITmGXWpKSAhDAo3KbreslAONWM6jORO38fhchyWGLWj0IpETqXhEy0rSpOrsTeH2QW7JWUDz/pEboYyIDon1KMf7wQcdMDOWz4kTOQflHRFO5Rx82WyL1Wp0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735171; c=relaxed/simple;
	bh=9qx6tqSW94CW/cPGdWUdIbBVmXfcE8hobxnQfyD9FdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eWUifrukqk0wAYhtOiBdRQmsBzOCludmU8xyQtBnTABkWqgDDv1saVR+bbtMgJDWICUl80/TLsoa2KCBlSN69K8w8JtZOgGWGyyo0EXxuswXzAbtxpTIGjOpnHCHfNSqJJ/Q4fz/mPZZpfogpiCO8xrrOhqk9aS97BppXswtcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nzCLlz7l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VEmaqd030302;
	Wed, 31 Jan 2024 21:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NKFRoyFdpL1ZkS24i3Mmdw1JWY+0mjzaQtfjURT0XNY=; b=nz
	CLlz7lhP3+ByHlSWe18qcqUzBHuLhg84rqEdRu1gO2WQ+WY0eUpiJ8RgBIryDOyA
	POEN0p3lWbzjzoiiAo0r70Z29L3PG8htJTuo8Lv3ch9qr0vAEkAknZPzTjF+RAtz
	/WNHJJMbGS09x41Cj2oXMrvwz4/XGZgzQF0jbUXLYCzxPiOM0i7Na1tUorvfoSDc
	E3rDImH83sZQfag3mA0kllngWGNLOc/tC1b1OrNaQIoNfNdR5vfUsLM4A9rEzKfv
	QBc0SylNxD516O2+DbgRyxwftVAp5Y3wZQMLUeb4YaGDnChzBfQBybyvwmUhvbNK
	iPVEjYILBbsv+ZH9X7SQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyq0ds6u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:06:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL64sH007497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:06:04 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:06:04 -0800
Message-ID: <8a39295d-d30b-41c4-82f1-2eeab3565863@quicinc.com>
Date: Wed, 31 Jan 2024 13:06:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] wifi: ath12k: fix fetching MCBC flag for QCN9274
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-5-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-5-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E18crAfyek__07v8PG24qOT1LT-54si9
X-Proofpoint-ORIG-GUID: E18crAfyek__07v8PG24qOT1LT-54si9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxlogscore=963
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401310163

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> In QCN9274, RX packet's multicast and broadcast(MCBC) flag is fetched
> from RX descriptor's msdu_end info5 member but it is not correct
> for QCN9274. Due to this with encryption, ARP request packet is wrongly
> marked as MCBC packet and it is sent to mac80211 without setting
> RX_FLAG_PN_VALIDATED & RX_FLAG_DECRYPTED flag. This results in packet
> getting dropped in mac80211. Hence ping initiated from station to AP
> fails.
> 
> Fix this by fetching correct MCBC flag in case of QCN9274.
> For QC9274 MCBC flag should be fetched from RX descriptor's mpdu_start
> info6 member.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 8f04852e90cb ("wifi: ath12k: Use msdu_end to check MCBC")
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


