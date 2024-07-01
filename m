Return-Path: <linux-wireless+bounces-9800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D125191EB6A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872731F22312
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 23:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78EA171652;
	Mon,  1 Jul 2024 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lmeV0J0W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1F2F29
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877306; cv=none; b=oh+9zTmcfcAlDl1igS+m9sjb0Uxs2EACOcXjkHobNzvndZ4nOSwSemR1WTpxlatSUfyUXmpMCa3p24bI6kh7dHbzmqd9ZZ+Xx7rGEmrwBynbYzJrTG9nYjrdfaNm8UdsNStXkz6Lty2Juz3L/4/32WLIkC6A8ZwOecopGM7TpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877306; c=relaxed/simple;
	bh=fZt/pTSe+rZlkvfF+cW2a6SWy4kD8VGFqbzzwtN5AdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LyXmP84JChVRZSQ3H0Sl6eUhJ6WQbjp/DT7ucYcMs0i2kQv4N1yiB/l7SQQQdidYnwWFcVyjccpq4iu8S7Zw+8K23a7LdIfqAcS1UZimJH/mJi6kcDdoaVua2ljKpzA/31+EHeSl8TmTzhmGy3zqRnOn2TER4mitym8NACAabe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lmeV0J0W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461JBDJR027778;
	Mon, 1 Jul 2024 23:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1QNSvlUkFnua3wR7wSATZ0ytr3hC3zgYVs3BeRoZkaU=; b=lmeV0J0WID99SRZf
	okU6maolMIaAwVx3Qlp+FXCwrdl7S0QyrGVadoe6H9M/XKu/9woZ6oMV8DVmmw7D
	4WotBcCK+dDXkiDLvlS2Rgcl2BddLQeBbFj8/9PxOTVpRZtIDqOCIJz9WmFsffgZ
	/G4EtuVRtLeXcZ4hNdCTHS+3Bb4A0KQ2f4gj8kbVCVlGq7g1jHq2aCGFJnp8lzuL
	cPF4mgjBnZusWK8C0qLD73Uz5NfNweCeGhegNm4U+ILmqEVJn6RcjNvw1Evo/u7P
	6pzdMi8E2FKyWBfFEqM0hixDJW04eOMXdUvYEOF6/4OWyVNc+BSMyJru9qsPH0mu
	feKhLw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027mnnwr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:41:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461NfciL020582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 23:41:38 GMT
Received: from [10.48.245.148] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 16:41:37 -0700
Message-ID: <86fe0a4c-d8fd-440f-8c6f-55e4cf4755a0@quicinc.com>
Date: Mon, 1 Jul 2024 16:41:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/8] wifi: ath12k: Refactor core start api
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240628095139.292952-1-quic_hprem@quicinc.com>
 <20240628095139.292952-2-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240628095139.292952-2-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3g-XbqOAkQKq8AT2SM7ZofmkLsNXV8pE
X-Proofpoint-GUID: 3g-XbqOAkQKq8AT2SM7ZofmkLsNXV8pE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=768 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010176

On 6/28/2024 2:51 AM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Hardware device group abstraction would be introduced, in future,
> where radios across different devices can be grouped together to
> support multi-link operation and register as a device group to mac80211.
> 
> Currently, ath12k_mac_allocate() and ath12k_mac_register() APIs are part
> of ath12k_core_start() and ath12k_core_pdev_create() respectively and are
> based on per device (ath12k_base). These APIs can be decoupled and moved
> out to ath12k_core_qmi_firmware_ready() itself.
> 
> This refactor would be helpful for device group abstraction when mac80211
> allocate and register will be changed from per device (ath12k_base) to
> per device group (ath12k_hw_group).
> 
> Add changes to move allocate and register APIs from existing one and modify
> corresponding deinit sequence.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



