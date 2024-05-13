Return-Path: <linux-wireless+bounces-7618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF88C49C5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 00:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDB1282EA7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 22:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31484DE2;
	Mon, 13 May 2024 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a9hkNjQv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5A53E30
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640865; cv=none; b=DNFgurWZpfRgeD+SRnzWhkh8H6pKrrcFbKKYFDxRUcawoarBT8/S+zTk6EiCXNw4YD4cGhONP//3F5mJsbh4BFBRQ8eDJBuL4d7dWfL8+UYyUjrPBGW3H0ZxKisiL/Oliz2DeZTqMZRoDa/2eACjSqdHvrRXOSxXL+IT0/jFQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640865; c=relaxed/simple;
	bh=a9Yikbhg+id4hj0aqAVSXko9pJTpuhCL4Z3SW6m89v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TKRZ9hatkMNgDDJPto6a+vhBPzXl4IoZbjEL3McqZqGSw2QGdhcDJG3XIrQa4mvU2ykJ5OYBwszGFVW+7pjpXYkERK41o40RbQ6wWS4dJu09kzmV7pZEuYZ44CHlvx6tD7VhABzBTDRQmN3LtNGe0K00FtS0gj26KOxZw3nSmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a9hkNjQv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8VDL023872;
	Mon, 13 May 2024 22:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CncJtGREnQ5RH02DMYVG0hBNh0DM1JsO3/kiLkVh2ug=; b=a9
	hkNjQvYC+bBr6Z03u5eVcZ9g9JwvesVDM9R0x+6kXJ4LnYHgkS6UsUa2V+4H6Q5b
	5ZZSIN3cxfQO50JKj8g28beqf1mqisEevv4f5yVGPZGRHa3i59Knm4ui52lqoxPs
	9AMTpYfDuNN39ewbS4+/Ep2yuUPB4eQ1aqYrNVpsowOauKIPGqRNSq1oAllYLC5M
	mjJX+lZR2B7vRM+ayk/55l8YXJEqYEUW2TZS630f1C+YtGSozfHEO3syKg4P4Zfv
	PzSSrAbJmmA0lQkAS7Dph71tR1YP3OinLLrvKa5XKny9koiJX8lsT0Dw+dd/SuIH
	Q5wphThe6upor4+7veJA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y2125cqe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 22:54:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DMsCqN012703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 22:54:12 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 15:54:12 -0700
Message-ID: <bdf21778-9e40-4586-b214-01169c6def62@quicinc.com>
Date: Mon, 13 May 2024 15:54:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] wifi: ath12k: MBSSID and EMA AP support
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240508202912.11902-1-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508202912.11902-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 33pqYUE7iblcJHUndy-UZ1BbIeM5buYC
X-Proofpoint-ORIG-GUID: 33pqYUE7iblcJHUndy-UZ1BbIeM5buYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130156

On 5/8/2024 1:29 PM, Aloka Dixit wrote:
> Add support for multiple BSSID (MBSSID) and enhanced multi-BSSID
> advertisements (EMA) features in AP mode. Set extended capabilities,
> WMI resource configurations to advertise the driver support to
> userspace and to firmware. Configure each MBSSID profile by sending
> BSSID index, total BSS count to firmware. Retrieve and propagate
> MBSSID/EMA beacon templates to firmware. Set the arvif security
> parameters for non-transmitting profiles.
> 
> v2: Rebased v1 patches, no functional change.
> 
> Aloka Dixit (9):
>   wifi: ath12k: advertise driver capabilities for MBSSID and EMA
>   wifi: ath12k: configure MBSSID params in vdev create/start
>   wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
>   wifi: ath12k: create a structure for WMI vdev up parameters
>   wifi: ath12k: configure MBSSID parameters in AP mode
>   wifi: ath12k: refactor arvif security parameter configuration
>   wifi: ath12k: add MBSSID beacon support
>   wifi: ath12k: add EMA beacon support
>   wifi: ath12k: skip sending vdev down for channel switch
> 
>  drivers/net/wireless/ath/ath12k/hw.h  |   1 +
>  drivers/net/wireless/ath/ath12k/mac.c | 324 +++++++++++++++++++++-----
>  drivers/net/wireless/ath/ath12k/wmi.c |  40 +++-
>  drivers/net/wireless/ath/ath12k/wmi.h |  46 +++-
>  4 files changed, 345 insertions(+), 66 deletions(-)
> 
> 
> base-commit: 1025c616ee13372f3803b158abb1d87ef368ae3d
entire series still LGTM :)

