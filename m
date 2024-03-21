Return-Path: <linux-wireless+bounces-5118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC2886195
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 21:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56855283FEE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542379F0;
	Thu, 21 Mar 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S7EYDVTW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB76F4FA
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052659; cv=none; b=QuWHvuvDucnrhEPIapC2TJmAbpM7k8moQWfOPecyLeyh/YCrNb0fVjeDc0OCjTanB5SDgmXJh/xBF2m8gvIUmjNpBCtY70txpEGDcOVpX3DSKZin3iXwycCusLBlYQuIOA695Itf11DTpCi027IUiczuYKriQo6vPEs0S3NVd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052659; c=relaxed/simple;
	bh=Jh/JuSx1H9hE56r1uFrTJl1Wub4Lf7lhC/1ywX/MZPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sG5RMxE3pnlYshNkBjVNe07PfEZ5Y7tai1gMLZDFa4IevyMiwGDO8Nm15hsWjbXKEgHu8AL+OPfDnNMfV202AB2LQx+s0ZlDBhROwQVkgUdVEKtL/dM4Suy4OsCcHLsNiKmTxQYZ5tqMjTBpYVZOgmc6mwu9orGI190xyOgXIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S7EYDVTW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LJ64pY028676;
	Thu, 21 Mar 2024 20:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=aSC/hwgBiHdEXRtLyH9E+zGRrOtf2nwYRVkjGuq1Ym4=; b=S7
	EYDVTWFHCbrwqtM6n9G5rJkZT0qBmQB+Xuo9pb65dXawvn9pZ1UoSLKDgb9PaVh/
	L8xd/1VOy4s5HFY7ssFqSh4fy/ATBbnQoQqWl3NSuAJYvYj61wc5tw6fNEg0LmqX
	JnZvP6bYjPNgNlO2bD2l/x7PI4KkcPo+pINjuNoLH0biYAOgpMChWRuxc8w8s92b
	llPx7DM++RfJG6RxTnUX/WavnEIwUnUfGlNMp+l9YEzZE8Aojrv4yZfAfmYAzMYy
	MXsBYn9bVGXRsgL/g2gMzyZ9PAIAN0lBYcf3o8zSSi6V3vwaisJMyJ/83SQCANJi
	7NLBF1NkAXEt82W3ZvWw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0trh84t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:24:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LKOE8F014854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:24:14 GMT
Received: from [10.110.74.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 13:24:14 -0700
Message-ID: <23c3a9c9-b2fb-4d35-916b-94cdd96a62aa@quicinc.com>
Date: Thu, 21 Mar 2024 13:24:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] wifi: cfg80211/ath12k: Add support to rx retry
 stats
Content-Language: en-US
To: Hari Chandrakanthan <quic_haric@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.orgi>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240319134522.4021062-1-quic_haric@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zoZHw6SIRJkdHDv-UgS_D-t4mF7Td6Bi
X-Proofpoint-ORIG-GUID: zoZHw6SIRJkdHDv-UgS_D-t4mF7Td6Bi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1011 mlxlogscore=727 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210152

On 3/19/2024 6:45 AM, Hari Chandrakanthan wrote:
> This patch series adds support to count station level rx retries.
> 
> wifi: cfg80211/mac80211: Add support to rx retry stats
> wifi: ath12k: Add support to rx retry stats
> 
> Tested-on: QCN9274 hw1.0 PCI WLAN.WBE.1.2.1-00148-QCAHKSWPL_SILICONZ-1
> 
> Hari Chandrakanthan (2):
>   wifi: cfg80211/mac80211: Add support to rx retry stats
>   wifi: ath12k: Add support to rx retry stats
> 
>  drivers/net/wireless/ath/ath12k/core.h   | 1 +
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 8 ++++++++
>  drivers/net/wireless/ath/ath12k/hal_rx.h | 7 ++++++-
>  drivers/net/wireless/ath/ath12k/mac.c    | 3 +++
>  include/net/cfg80211.h                   | 2 ++
>  include/uapi/linux/nl80211.h             | 3 +++
>  net/mac80211/rx.c                        | 6 ++++++
>  net/mac80211/sta_info.c                  | 5 +++++
>  net/mac80211/sta_info.h                  | 1 +
>  net/wireless/nl80211.c                   | 1 +
>  10 files changed, 36 insertions(+), 1 deletion(-)
> 

Incorrectly sent to the ath11k list and not the ath12k list.
But please don't repost just due to that

cc'ing the ath12k list as an FYI


