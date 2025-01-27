Return-Path: <linux-wireless+bounces-18003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F38EA1D23C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 09:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D296E165E21
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 08:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDA616F8E9;
	Mon, 27 Jan 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MvcO682u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1661547FE
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737965843; cv=none; b=JvpgRNCTpxbXrvmy7vBo1CTjFvRI5ys7bD+3dI/diX4KRPhqwj3mQSiR4p5Ns2jjmUAVGRRNZE/4s73Z4lnBK9mlhI0CQsm7XvohSEFGLpqpY9ThMyY5jHh19F+8kp5LJEKP9ju1V+UruYvz3l9nl7oYdMl69fgF34/3tcNqIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737965843; c=relaxed/simple;
	bh=pZym4sRb4W42yAjnG6o5/eAkGB1toJJeOqgTFISCAKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WDYBs/dwHgncksTd+HcYukWTaji3YBl8exp3X1N9Oip+3mOWtRIQSibN2A7qDrKDycD63rZTMt6dxJPDce+35sTW7P2T6T/nXdemxIjIivgq70bj9vLTqFfLYWsqoeDs+zB3e/0UsjUgBHqHJxGQhM52H0JaMH+ifL84xGLCENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MvcO682u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R4kQeY017978;
	Mon, 27 Jan 2025 08:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pKCVBoOMeYxKknxOyIELRERWHgMA6M9zhiI4293+LGA=; b=MvcO682uje907YcY
	pRjPDyrvccyZid0KUxsd2hSNFVqCUyK4ORd68bVHcvxXVVBqzz/34i4dSqHDHW2D
	xjO2XE1OVrcY/h24GAVIyH0ysamotqe2IBgy/yntJ/3JAXT1LQR5lZaBaTdP3pwL
	ayGdJ7WkweGcDp4OgNzeQGLLTZLQIdT4Xp5YPnIcjcc+VRlyWwd5QjGQ2OvyPVHY
	7nPu3zm7YVTPCM8o6BMoTMss8mONuuTHAohtpcdN++Y+TZttcXuRY/0P463FujOp
	bQZJyDLjAlQcyFnEWhBOebydQP4rwru7YRuVKkOqjkC/X2DCDrr/TLK5J3p5ns1y
	qpdqvA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e3dr0dab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 08:17:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50R8HJ5Y004329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 08:17:19 GMT
Received: from [10.253.73.203] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 Jan
 2025 00:17:17 -0800
Message-ID: <cd0fa235-67a6-445a-aa4e-12df222728e1@quicinc.com>
Date: Mon, 27 Jan 2025 16:17:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] wifi: ath12k: Add new features to ACPI
To: <ath12k@lists.infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250113074810.29729-1-quic_lingbok@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <20250113074810.29729-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rt4x0HwdH8tPulJj_Wo_XK91XvhCgkyP
X-Proofpoint-GUID: Rt4x0HwdH8tPulJj_Wo_XK91XvhCgkyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=968 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501270066



On 2025/1/13 15:48, Lingbo Kong wrote:
> By reading ACPI tables, implement a method to obtain the ACPI functions
> Bitmap, enable or disable specific features based on ACPI Bitflags and
> download board data files based on ACPI board data filename extensions.
> 
> v4:
> 1.rebase to 0c5fcd9069dd
> 
> v3:
> 1.change some function name.
> 
> v2:
> 1.support functions for cases where CONFIG_ACPI is disabled
> 
> Lingbo Kong (4):
>    wifi: ath12k: Add support for obtaining the buffer type ACPI function
>      bitmap
>    wifi: ath12k: Add Support for enabling or disabling specific features
>      based on ACPI bitflag
>    wifi: ath12k: Adjust the timing to access ACPI table
>    wifi: ath12k: Add support for reading variant from ACPI to download
>      board data file
> 
>   drivers/net/wireless/ath/ath12k/acpi.c | 200 +++++++++++++++++++------
>   drivers/net/wireless/ath/ath12k/acpi.h |  38 +++++
>   drivers/net/wireless/ath/ath12k/core.c |   8 +-
>   drivers/net/wireless/ath/ath12k/core.h |   7 +
>   drivers/net/wireless/ath/ath12k/mac.c  |   3 +-
>   drivers/net/wireless/ath/ath12k/qmi.c  |   9 ++
>   6 files changed, 217 insertions(+), 48 deletions(-)
> 
> 
> base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256

hi jeff,
do you have any updates on this patchset?🙂

/lingbo

