Return-Path: <linux-wireless+bounces-7854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E308CA51F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 01:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A309B222C7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 23:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E359E138486;
	Mon, 20 May 2024 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KAaB1uTL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C80137742
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248336; cv=none; b=brq3+2dTV/vbLuPLN15eyMtWBmMACh/HP07WctS6vhfLps+J7rAL6nJgcp2ADTXIwYf/C+6NHVnQeXa/VkLyHnCntWysWJQJbTSBdWOksejjmVOcDGZZoJVBg01a+gH3GFvqq8AxKTVpiIHsk6EeoIj5eaf40BDlRRDgbmNRZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248336; c=relaxed/simple;
	bh=YVhHHmfNGl+4/B8tmptdw7iTrFi4HkX3dZ7uREvkPhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bIvUBbCZ+eA1hk05zWy85f60TlR/r0qK1qp7k1Pc/WQ9iXcjqp+guc59FcnVEoTVX8THsewfg6MhcOM5fAYqRq/G2a+6BD0I3sZL6tiOoDOA/vSfE6JLvWRy56QqMogXnHaMG6V6VdRoFKnQkcBP53AcyG4Mu0NU2Oq0pNmp+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KAaB1uTL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KBlfnQ001074;
	Mon, 20 May 2024 23:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ig5V5BQs2PpkzOOIlwVTg7SFzIYBDf48K5nHT/ulhBI=; b=KA
	aB1uTLKJeyUUJYZZM/sEVCHkznldO+FEOuYuIif4nAxyWonK3ecC5onUfNP5mGXO
	EQ9ASqj/sDsYYf1RdL8LzSBvPRz7YH9nUsNOWcMkdf/e9lmT8aqQOf6fsBvofKnI
	QH933SFK07zRsPqrcm8DrsSWfsQHiaMmzpyrNWL1jIbU5mhNehZzxzfnBgmQqhJP
	L/P1gU8249G3JA1d/EjcervlNq5GiRyAmabgehjz0w9dzGZmKHV5c/xa00PKQSWA
	5ExFHC7P4AuFgz3e4wI2VaYWkQW9h25eTHjGjg/36ewvu/hytod+BOw6l1hhNgAc
	JqFsxFiDinE0S9r0RSlg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n3w50js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 23:38:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KNcoHN014478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 23:38:50 GMT
Received: from [10.110.17.44] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 16:38:50 -0700
Message-ID: <d483cf66-433e-4414-b195-a7f4d54e6f0e@quicinc.com>
Date: Mon, 20 May 2024 16:38:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: fix firmware crash during reo reinject
Content-Language: en-US
To: P Praneesh <quic_ppranees@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240520070045.631029-1-quic_ppranees@quicinc.com>
 <20240520070045.631029-4-quic_ppranees@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240520070045.631029-4-quic_ppranees@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6-r6UuHgobrl7c6NeV19hKnQesNxBKtv
X-Proofpoint-GUID: 6-r6UuHgobrl7c6NeV19hKnQesNxBKtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=754 suspectscore=0
 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200188

On 5/20/2024 12:00 AM, P Praneesh wrote:
> When handling fragmented packets, the ath12k driver reassembles each
> fragment into a normal packet and then reinjects it into the HW ring.
> However, a firmware crash occurs during this reinjection process.
> The issue arises because the driver populates peer metadata in
> reo_ent_ring->queue_addr_lo, while the firmware expects the physical
> address obtained from the corresponding peer’s queue descriptor. Fix it
> by filling peer's queue descriptor's physical address in queue_addr_lo.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


