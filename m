Return-Path: <linux-wireless+bounces-10535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA1193CC02
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 02:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AEC1C215F0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 00:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0A763C;
	Fri, 26 Jul 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YageqaAQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900411C17
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953082; cv=none; b=fmHxzaBs4Lm/b/dbG/n5aNGP2N9xLXVFxYUgHPrGBvYXQWrpEcDV17X/u+5uDB/XI7mxBxABP6HFbdsyHtFz2Off0+1IoK35As43Pl3DTTs5mmkdRmvWBQcuaraHcVW/T2Hea7tDwli1vvLsRBKDHL5XfvEVXz3G4lICY/q25TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953082; c=relaxed/simple;
	bh=vjdss7ki7+RQhD4AeoZwLU7LHTiDtyeyEldA0pKZEMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gze8gDp1eaIdl/gnKOje59Qb5D6uF3uh9Sq0Wzd1cBP6IqbtDA5GKp5ChzgQ32wfF4tpmoUy7JHEEcsOGDSfArcAGaQ4zdlDueHJOyZ+yDstJc2YnojIcO7JWk+MwsX934UxuVPAnO2U3X6e8PZfplYra2gb7MN37DnO9TMFGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YageqaAQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PJ1LqX024250;
	Fri, 26 Jul 2024 00:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7c1qU95BUtwE0lPsqJ4yybXqIL2pPOipfIPE52BXWyM=; b=YageqaAQhe63sbq/
	/O0PziqF5YO89LkQ5N1deIhSMg0wJMBpz8/cLzFNlLaxQ3yPFLr0Pp3yTdOKuNOf
	6Rq8rdDme9kIjeFpILn+GyXde0+E23Mzqr54QGsYoSHu5fBMHY550AlSMHEY+RyL
	gzQOb1vU5eEWagIzznpNobJR5LdiUW4AUqiu6oJTkzH2YbP031UQiJLRhpiJjPao
	epjpQQTLup3gq/P7C1rxspEFYetzfr0Czis6PEH6qi2WBjgrTYa0R7DYlkxQIkr7
	F7lFhDNRXZTZ4+ycdjtBe/NC5m0GCTI7a5Q75U90ST5kSq1oEoxe4k/rEBkMh4sx
	QvygpQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487phnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:17:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q0Humm031106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:17:56 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 17:17:55 -0700
Message-ID: <2d958bc0-72a1-493b-a46a-356f8d89b696@quicinc.com>
Date: Thu, 25 Jul 2024 17:17:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] wifi: ath12k: properly handling the state variables
 of monitor mode
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-8-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240725120035.493-8-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MIgrLr1gXjGjZkk6WziUpYB4lymTnGYX
X-Proofpoint-GUID: MIgrLr1gXjGjZkk6WziUpYB4lymTnGYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_26,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=975
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407260000

On 7/25/2024 5:00 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> Now monitor mode has some status variables, such as monitor_started,
> monitor_vdev_created. They are not always handled correctly.
> 
> For monitor_started, it should be true when driver works in monitor
> mode, and should be false at other times.
> 
> For monitor_vdev_id, it should be -1 when driver doesn't work in monitor
> mode.
> 
> For monitor_vdev_created, it should be true after monitor vdev is
> created successfully and should be false at other times.
> 
> For monitor_conf_enabled, it should be true when mac80211 sets
> IEEE80211_CONF_MONITOR, and should be false at other times.
> 
> Handle those state variables according to above descriptions.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>



