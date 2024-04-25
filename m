Return-Path: <linux-wireless+bounces-6883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1598B2ABA
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09EFDB2353C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23A155A2B;
	Thu, 25 Apr 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d96MU8ot"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DF155A27
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080464; cv=none; b=WXPrCHI5v7Wz8gzeVqRb/KTxoLv5ib+TXtuWRcGiB7AncEyO9MFkQfh5J+DoYptFosSFoZUvvV3aYv0+2sl87wiYxKtgJ0hrIlMRFnhhK0eXY7bkF/dDmlhsI5ZrfcfQIFGIcJ/mfa5ottGWCR3KX8N+tu6yx5zwb62UVPlJXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080464; c=relaxed/simple;
	bh=5s9odnUy7tv5Qvolz/8ZEYzyRqzCQlfn+NPIRAQ8NCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z569TIjVSkGEIqM/bdihY/GT+FX/i+9BW6BjNsoL2FKOXPCX4gyhHPGIJ6tVQJdgfelSrcOeAwk7E019838vCBGfk7De+i1uj0Ez6E+BDRA4zrJufrwXJOCJf4Fbdalrl+hBO1mCm9g7oJHGoQGrU17vP3TEMiiYdbl+mExmyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d96MU8ot; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PLOaZO021753;
	Thu, 25 Apr 2024 21:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EnRbJXSxeNX8PopLX+osZshnJCS8R10BWeACc7pKCPk=; b=d9
	6MU8ot+xcPtlBLDvIympZae28P/P/O8gjNbMTCuaGC0GwARmLZGoxjwn8LKsgupC
	Vyx5GciuZrUE8EjPEbaNSy4BwDGi+OciALvsQVCfxf9uBqfOX1qulPz4z8Ss6pc6
	abHsDiNv6Wy9fzf/UkthT0x0n+lqlBGRfcM5OFjSTVZLFewgWR9jiERgADT1gDmQ
	+tzT7EPAUt/EY0ck6Vlg7D7Bti2ZheB752YUo3sEDsKAZC23bHjLn5kFjOsJDwIh
	/NFPXJ0B0Q+jhNvmat4XgET+j9gbO0uRR/nnhVrc5hMoXBiCXbp+cXsDSEYV5YHp
	GYmiyt4LouC5pCGfU33w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenkkqwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:27:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLRcZt014449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:27:38 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:27:37 -0700
Message-ID: <65dc71bf-3385-4bef-8a4f-955457734e1e@quicinc.com>
Date: Thu, 25 Apr 2024 14:27:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] wifi: ath12k: Add helpers to get or set ath12k_hw
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <20240425055759.1181165-3-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425055759.1181165-3-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: od0SGSRxx1EL-rzRTHdYDTbYIZoLCeaW
X-Proofpoint-GUID: od0SGSRxx1EL-rzRTHdYDTbYIZoLCeaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=611 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250156

On 4/24/2024 10:57 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, one or more ath12k_hw is part of a device (ath12k_base) but
> in future, it would be part of device group abstraction (ath12k_hw_group),
> i.e., when multiple radios (ar) across different devices can be combined
> together in a device group (ath12k_hw_group).
> 
> In order to facilitate the above transition, introduce helpers such as
> ath12k_ab_to_ah() and ath12k_ab_set_ah() to get and set values of ath12k_hw
> respectively.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


