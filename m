Return-Path: <linux-wireless+bounces-6687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E594F8AD38A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06042845C1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8B153BF4;
	Mon, 22 Apr 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lQsRyRlH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20031153BED
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808332; cv=none; b=NXy5Ds/qSVzkqkMRBxophkDuNXZsLawQO65wktCM+JkPeAP1mGLAQxvbSOdWXDX+JhEhO0Z0Mp/CeG6zsZejhvUykM5Gy54kwIM66vQcQlqyj1Cj+YX5IsiJnaF/owVpeTDZ7yCZvNG82WRE4gWFQJ/3pPrpy1uq2xffjBsCoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808332; c=relaxed/simple;
	bh=JsATsaMYs6lLM1pOXEbJzu3MLnVH+wpeLvDq5ETfLyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Es8E6yJJBbynF/7qROV2mmgZnMmLT8DjwMocFxLwPWa934WHpU9/F4DmxqwVzrUkfZH1lItWUvGN1pOt+9i17PgsF8VEIY3bvl6qYKtQ+H3U//noXBBw7X/wphiOwhObqzSO5zkwde77+4hW9JDCPzBiY6qdAlEKWMY8auwiK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lQsRyRlH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MFGcEh006832;
	Mon, 22 Apr 2024 17:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=35z046m/ubf15VcFNvSX9mgVEoxSwqcsu9Rds7gmzHk=; b=lQ
	sRyRlHKPjQEM/kcniLA6/OAzc2YINE9hMsQD8elUNnmuCHRFYCWCFMYRPeUU82Dg
	jfZMFMX39tsaXAtFdqKe5vF+pIyEebPWdoS4vU6jW1jGPLi0XllS9/59OgGfGIYQ
	N6KH9cSttzgDhYQUBf6oG2w61pwSbi8mHun36+yoUhikTzNjSPmX1SAOZR1VkoNn
	eYnv48yQzSu+use35v/Q5UUCYWGTDVUzOE37z15L3W9nLjGW275MMY8VNsYsR8jf
	YuyGuDWpZXbsHeIlnNmnWzyXhiOd5iXVqncQXxmV+Nc31E7OzyrJnMuD70qa9nik
	0EgaxWyc1UWGYaMtXP9g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnm1bhhkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:52:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MHq6bh029330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:52:06 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 10:52:05 -0700
Message-ID: <09726b6f-fa0d-48fe-90f8-2e63ab6bf019@quicinc.com>
Date: Mon, 22 Apr 2024 10:52:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] wifi: ath12k: no need to handle pktlog during
 suspend/resume
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <20240412060620.27519-8-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412060620.27519-8-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vMr5eV5dIj0rhVse2OD89Bep0zFbN4lm
X-Proofpoint-ORIG-GUID: vMr5eV5dIj0rhVse2OD89Bep0zFbN4lm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=655 lowpriorityscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220075

On 4/11/2024 11:06 PM, Baochen Qiang wrote:
> Currently pktlog is stopped in suspend callback and started in
> resume callback, and in either scenarios it's basically to
> delete/modify ab->mon_reap_timer and to purge related rings.
> For WCN7850 it's pointless because pktlog is not enabled: both
> ab->mon_reap_timer and those rings are not initialized.
> 
> So remove pktlog handling in suspend/resume callbacks. And
> further, remove these two functions and related callee because
> no one is calling them.
> 
> Other chips are not affected because now only WCN7850 supports
> suspend/resume.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


