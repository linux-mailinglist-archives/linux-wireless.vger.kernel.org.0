Return-Path: <linux-wireless+bounces-11365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFD950B0A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41551C234EA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305171F959;
	Tue, 13 Aug 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K2Q6gNjt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0FC200AE
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568596; cv=none; b=fXw8PuAVCW2ge2JdhJhX+FST1YeYW1x/9HKcSK04oT0+JSS2ODW+wBlnqIsfmkHko3uHVRS2IJs6BWOpT3JYH8aGKsR5iaqVRGqyMp6FrfiJgZiOe0IpCKEBD2ZG6xMCiYFN3oWMN7oByZFWtexJNrPj8LqQu3yqnCX+xgFxMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568596; c=relaxed/simple;
	bh=PX75izO9aecxamy15uswA2l3RQjmlFEV3I+OYYKTYyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OgSKbRiKOyOV9ogsUbUYRMXzuxf2yXjEfWQa1yQiqfb1EckCO1S6Ghf+2vW17lu1qfm2tPB4b7HD/iyJktItniSVr5dBxXTNIYajNPO/xVHESYAYoOtOEDNize5y9aZjw7XPjHEWjSMZw1MHEkSNZOAq1UjhqkZFSZR8bTSjDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K2Q6gNjt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DDOD8d011796;
	Tue, 13 Aug 2024 17:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KnjoxmDNnS/g/R1mmW3EOuYnSW6m/VaI+AVp5ndjqBI=; b=K2Q6gNjtRVKj6pAi
	zucw7OrcLM6mmjuAAnyAGAfXVG8ub+QZDtgnSKEOAPIi28yYRGeQDrRGbu6N82Ib
	T8t5sQIZGFCVqXv7rCf+BaggBEljqMfvwr46EsCfBzCVb7r1KdQn3s0aWogHRnuF
	oZpOLvvd1tnUYexPuMuVdfADP2Ba7KF2NMTuFwKggCHdBPk8lnIofHkG5QmX2H3C
	tZuYcGYnfYuVnuaJs9dDVRQorVtfL6NFC5ZmU/p93+sfMSn5F6BTe9ZtQjYA0szY
	cPoS8l5vUYVfVYpLZjrmynqas65gnq3m0zjIjGLcrPyd3Cl/ssbZK8pg5hH6TuVI
	v9LNsw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4108bc0rvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 17:03:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DH39NW024666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 17:03:09 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 10:03:09 -0700
Message-ID: <217ee6e8-38e4-41e5-aaa2-cedfa631f2d8@quicinc.com>
Date: Tue, 13 Aug 2024 10:03:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] wifi: ath12k: Adjust the timing to access ACPI
 table
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240809025055.6495-1-quic_lingbok@quicinc.com>
 <20240809025055.6495-4-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240809025055.6495-4-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8m5YULcxZocZFfVtm9u6FGOZp9IXyO_u
X-Proofpoint-GUID: 8m5YULcxZocZFfVtm9u6FGOZp9IXyO_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=819 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130124

On 8/8/2024 7:50 PM, Lingbo Kong wrote:
> Currently, the timing for accessing the ACPI table is inappropriate.
> 
> Due to special ACPI requirements, the ACPI table must be obtained before
> downloading the board data file. Therefore, adjust the timing for accessing
> the ACPI table accordingly.
> 
> This patch will not affect QCN9274, because only WCN7850 supports ACPI.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
> v2:
> no change
again you should have carried this forward
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


