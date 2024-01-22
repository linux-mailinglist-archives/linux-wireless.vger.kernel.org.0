Return-Path: <linux-wireless+bounces-2346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABACF83737A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 21:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEF51C267C1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 20:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FCB3FE44;
	Mon, 22 Jan 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AYiQ5eZI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E31405C0
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953882; cv=none; b=dTVwGZB8oPQ/Hq8zlcfKHo8jkYszP88u54OAZsLyZMYTPtqi+B6kEBQAQ9KsoyI6djYClOaJ1vq0P5R9pGVLEdgmfEecsAHckSq6X6RT7Xm1GViVUNINg8n+hyFnGYMiOauRWy/giCb7uCB6TgXkRWwxWLJER07fRtcr6+4pHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953882; c=relaxed/simple;
	bh=NAza/jCaTWskKQI44nrF2IZOy+BkB8IgmZ2Dg2097Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BLknLO+OFX6AFmyANl4GxcDitfcO+kD2dt9nGBBC6Ukxcyfw9fDwH5LPlOJ1h7V5XQGEVfRWfduVMhgpJ9oF5DmsvRLr05Khd2kiaC5wTFNgmWHmas1hW4lfpBDhy1mzRfZzL8kKtC0vZmzmcGwnhh2gqkzGusUOixIUQnLKXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AYiQ5eZI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MDqQrs012522;
	Mon, 22 Jan 2024 20:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ilJ5msNuDNipkbaf3gyfAqtT0DsngW34MTqPZQWFNmQ=; b=AY
	iQ5eZIXcoEazz+b0iYU5N60UtGoPGTu/JUsimhRje2T9qBQqyJwTeWFIyeCt2j0d
	KXOmuLA+y2SExr7bly/iOM9T2896jC+iS1fJ/Kk861VAkhVtPwLkqAr8uIN9qPCK
	4vmfduf4Q3DRWoaw+dnsHudfDSED+F7TRmxCSTAHqhwHjOM8uNHfrKPX5dM8MEsL
	HuwpuzTilGIry2OtxkfQNRKiM/XlrVi1MQZg4X8Inv5ElaHsf9JzUZCgfidkZrAo
	I5RKVlyW8pztiEVUB8rdXWRYzAdiHojPwvrF0ruIzUo3NCDoDazfeRFCzTLf6QOn
	AV6dsAa4E/tnFewvj76Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vskn19uuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 20:04:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MK4XPT027301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 20:04:33 GMT
Received: from [10.110.26.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 12:04:33 -0800
Message-ID: <bbfc4752-0a54-4e8b-b5c3-86005ebaa834@quicinc.com>
Date: Mon, 22 Jan 2024 12:04:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] wifi: ath12k: P2P support for WCN7850
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240122113904.8938-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vuhP6DCjv8KyxTggxqss1d4TAguw_b7i
X-Proofpoint-ORIG-GUID: vuhP6DCjv8KyxTggxqss1d4TAguw_b7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220143

On 1/22/2024 3:38 AM, Kang Yang wrote:
> Add P2P support for WCN7850.
> 
> Kang Yang (10):
>   wifi: ath12k: change interface combination for P2P mode
>   wifi: ath12k: add P2P IE in beacon template
>   wifi: ath12k: implement handling of P2P NoA event
>   wifi: ath12k: implement remain on channel for P2P mode
>   wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
>   wifi: ath12k: allow specific mgmt frame tx while vdev is not up
>   wifi: ath12k: fix broken structure wmi_vdev_create_cmd
>   wifi: ath12k: move peer delete after vdev stop of station for WCN7850
>   wifi: ath12k: designating channel frequency for ROC scan
>   wifi: ath12k: advertise P2P dev support for WCN7850
> 
> v3: rebase on new ath-tag, use ath12k_ah_to_ar() get ar(Karthikeyan).
> v2:
>     1. add Tested-on tag of QCN9274.
>     2. update copyright in patch #1, #2, #4 and #10.
> 
>  drivers/net/wireless/ath/ath12k/Makefile |   3 +-
>  drivers/net/wireless/ath/ath12k/core.c   |   1 +
>  drivers/net/wireless/ath/ath12k/hw.c     |   7 +-
>  drivers/net/wireless/ath/ath12k/mac.c    | 366 +++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/p2p.c    | 142 +++++++++
>  drivers/net/wireless/ath/ath12k/p2p.h    |  23 ++
>  drivers/net/wireless/ath/ath12k/wmi.c    | 116 ++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h    |  50 +++-
>  8 files changed, 643 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/p2p.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/p2p.h
> 
> 
> base-commit: 8ff464a183f92836d7fd99edceef50a89d8ea797
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


