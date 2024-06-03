Return-Path: <linux-wireless+bounces-8447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E298A8FA5EB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 00:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7D91F25BE7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04CD13CF8A;
	Mon,  3 Jun 2024 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hGbGvyi3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1113CA99
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454518; cv=none; b=RtQ02nY2KVYuD2lq/Gxdv+UAO7oz7v7Tw+UWPlFVyXGA2O9wj6khJ6xnhJkhciFu0GiuhJijkldT4aY1XCi8TE6R/KWwTu5EYARJ5hJzeaz+da/xAo3e3uNPjwX2StKY7INbQ1v4OS6tbLC2a/v9QbQCzY0OmbkPA/6fZpTAEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454518; c=relaxed/simple;
	bh=LWaesZtDAd+PfU6NBcgNwsFcFlK0yWCub039sCAvBXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ToZafchawEqr2pRupAh+yFJQVoUYJBiZ1WZELRI/F2j6zHMhbeodAsRfdYfBK6XkqSomcIU8vyRueZArBls7OF8VJlvOqz92OH/njcQEf5h9C6FEtaalPC0WESyz9P8d2lhGroosEuwZDjBK1Tf7ZNNgdzv7jP3DVTyCDJCeMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hGbGvyi3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453C1HKM014253;
	Mon, 3 Jun 2024 22:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vdz46IEtkWmC/nMGa3fMyLH+j2ZKNwQMSiUifjrCXe4=; b=hGbGvyi39TLeO8iD
	Sl0kHH6XtnnB+KwFzj4OjPjNU+oUqDM3nFiXk0ZcJyTNNHrRLcMpkd4TbaXhGeh8
	tZRl1ATn/b8mglb9aevZpNKdnq4fxcP3dTgQfTd016qj1JqM7V8X4sPI81HGd0Y0
	9UcU6+qsBOCFHtMiIVlIvfRglB2gJsV0IVgwAbSEm0XEjzaotouvaLA3Dx6PWkKa
	RLX9+K1cM0Tg0xjPvFRgZtuUURyovyG5OsaZFO08EsgmYxYd7gcjBC/6d8cLlOqT
	pY6sRY/agegu4vR8tS5gQFnBlni80QJiRaVvIENUpIMjq7Qt0Dl7HVIQ89zaEBsO
	vBWUIw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4d5b2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 22:41:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453Mfqpi008544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 22:41:52 GMT
Received: from [10.48.241.139] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 15:41:51 -0700
Message-ID: <0ab4a069-d728-4035-ace8-946a419da971@quicinc.com>
Date: Mon, 3 Jun 2024 15:41:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix wrong handling of CCMP256 and GCMP
 ciphers
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240531021228.2846-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240531021228.2846-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qjf91cpRFyQKz4sMbm2L5eOUy7pH3ZyU
X-Proofpoint-GUID: qjf91cpRFyQKz4sMbm2L5eOUy7pH3ZyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=944 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030184

On 5/30/2024 7:12 PM, Baochen Qiang wrote:
> Currently for CCMP256, GCMP128 and GCMP256 ciphers, in ath11k_install_key()
> IEEE80211_KEY_FLAG_GENERATE_IV_MGMT is not set. And in ath11k_mac_mgmt_tx_wmi()
> a length of IEEE80211_CCMP_MIC_LEN is reserved for all ciphers.
> 
> This results in unexpected management frame drop in case either of above 3 ciphers
> is used. The reason is, without IEEE80211_KEY_FLAG_GENERATE_IV_MGMT set, mac80211
> will not generate CCMP/GCMP headers in frame for ath11k. Also MIC length reserved
> is wrong. Such frame is dropped later by hardware:
> 
> ath11k_pci 0000:5a:00.0: mac tx mgmt frame, buf id 0
> ath11k_pci 0000:5a:00.0: mgmt tx compl ev pdev_id 1, desc_id 0, status 1
> 
> From user point of view, we have observed very low throughput due to this issue:
> action frames are all dropped so ADDBA response from DUT never reaches AP. AP
> can not use aggregation thus throughput is low.
> 
> Fix this by setting IEEE80211_KEY_FLAG_GENERATE_IV_MGMT flag and by reserving proper
> MIC length for those ciphers.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


