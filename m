Return-Path: <linux-wireless+bounces-5840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBCA8977F7
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24581F21192
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E5515350E;
	Wed,  3 Apr 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IhkENPo+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885AC152DEE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168226; cv=none; b=RTInBff7lgK5mET8RvzU16JWCQoi03o5SI5Bz9pVSNB4iRHbvSsZZ2Gxt2OpOys+Ex4PGu+3jWM3ws684iZTtfHX8VAM2hlVhgTZtuuBcOxXPZMjxvbL9BHsw/e4AnilYV3O0wBPQCFChkctapsLkrAHkEc2i1sUvPW2GIujaGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168226; c=relaxed/simple;
	bh=uUihCIYWvUwS04vLKcIdcTOCAvTDPnVaNGCs0lyIH38=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pIz5sQMZocCleg3ubju4o/zaPfXMUnGtwWOESP+bL2eKgM5mySrfmlpxCbHIgClfF6qeofikSPZPV6vFtMO5SZmSofgLDXCCbaVYGbULr9jvl/CEqgi2NUwXexw2p36zAazWfPSENqJC0S0j4TMtQFQAqtrJpHG1n1P0+ZUGJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IhkENPo+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433Hwpno027734;
	Wed, 3 Apr 2024 18:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=u1gg7BtXSbUOjl/vSQpIU9j111eSM4QBolwwCkYmX/8=; b=Ih
	kENPo+YK040rYMfxE0jOFp11SREmfpHvK3b25GGvIexC+TH+bRvsGdPDPZSGvNWo
	q7o0V/azbZbx6WJKsw1kfk5qJFNTcuqeiU7xTWMf24N5c3ZJVXQmLfe72BgM5yOm
	Ihwr8MHuzG8Q/Y9Rg0ZuX/vMMNrvkbBajY34g0uUGfP6weAcf/RwdwT7wq1/g+Nq
	jNhK60CugDgAegvnYOCybmuhs6b/fBRSUeVFHs3nEZaLp9PPyO7kfI4zNjquMywk
	RNCnc88kbdeveYm5t1ADjO+rtsIVYToNRs1J+y/HV9hTs5FUx7H69cEVHQMG6LSR
	YE86IaMSrCwoq1RYNt9w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8xnxt3a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 18:16:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433IGuLK023051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 18:16:56 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 11:16:56 -0700
Message-ID: <5eaef6a2-7bf9-490b-8edb-d9bd8ce5b5af@quicinc.com>
Date: Wed, 3 Apr 2024 11:16:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] wifi: ath12k: advertise driver capabilities for
 MBSSID and EMA
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
 <20240402210538.7308-2-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240402210538.7308-2-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TrbwhIpfFtKHmVL13qoeGXkjfduNzNKT
X-Proofpoint-GUID: TrbwhIpfFtKHmVL13qoeGXkjfduNzNKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_19,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=956 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030122

On 4/2/2024 2:05 PM, Aloka Dixit wrote:
> Advertise the driver support for multiple BSSID (MBSSID) and
> enhanced multi-BSSID advertisements (EMA) by setting extended
> capabilities.
> 
> Configure mbssid_max_interfaces and ema_max_profile_periodicity
> fields in structure wiphy which are used to advertise maximum number
> of interfaces and profile periodicity supported by the driver.
> 
> Add new WMI fields to configure maximum vdev count supported for
> MBSSID and profile periodicity in case of EMA.
> 
> Set WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET flag to allow
> firmware to track and update the DTIM counts for each nontransmitted
> profile.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>




