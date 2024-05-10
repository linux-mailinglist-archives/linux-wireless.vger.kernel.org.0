Return-Path: <linux-wireless+bounces-7411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC098C1C5E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57632282D96
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 02:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F913B5B3;
	Fri, 10 May 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GDnqxvVA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175133EE
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307732; cv=none; b=lv2JYs8LmLNRFm8ofCRrPRKvOInlYa72VMi3fg3CPiMEDYK2XwpNW5z9m7v+P8flM9EVz291gO8U84I25F37Dhr3y8KemCQCp2gX5idi6Bnrc1hWloJDDwJvTeok/rkI4tL82VaWWfFgUU8MSHdEI/+iXEquMHP2SEBp2ZPJtbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307732; c=relaxed/simple;
	bh=73qboclS3IwSJCuV9/Uxq9LUnDLFiEM/ALRB9/1F75M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NI8tYKnk5i7NIb/tukwa/5GVn9xUxx42UoX3RRUEgKpn8A+9G5IS6g36LwtXMVyA0G5nNzMSns8i9aA/8L3miUB4BIyuuWuqjnuMFYNu440yKl4UpkZSmucBlR8x28AxQmtVMohomveqA1QzGqGVIllX8VCeAgqE9qtHI4s48pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GDnqxvVA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1B9ZG001792;
	Fri, 10 May 2024 02:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LFoiDNY+q5HD898UIGCJd9pjDpqAOVz3EDFIcZXEsSQ=; b=GD
	nqxvVAcqVT9fx+fVpPPDd1tsYb6RMjceLY/bThdLxSJfittGZ2srd0PGoQ8c2CRZ
	PiyQs+zC0K1iP7TRToYV5EEcKLRn5CvpWSa8T6eFh4ZfoNoLTUruFkuXUVevvsv9
	9HN0hWGPDdPYwVtCoTSJrWS3tbcoiUS6YUoQ8cqOtMup7uGGcm2M5ailIpVcoEaT
	3niIzdWzJSqFd2XL+HQ7Sw/98MsLU5aB8xy+bJ8CXkggJQO8SjAL7tcVuJKFXbzt
	L1JIiJV67UU93i66AtTK64/TDDN61BsQzYAh0UEq/xZJ4l5uuEFUfJKV1G8DBTuD
	OArz4W5J3QykUBD7tU5Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w10bw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:22:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A2M6co029015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:22:06 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 19:22:05 -0700
Message-ID: <5b1361e2-020b-4b86-84c7-d4caba802813@quicinc.com>
Date: Thu, 9 May 2024 19:22:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] wifi: ath12k: refactor core start based on
 hardware group
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
 <20240507045702.2858954-8-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240507045702.2858954-8-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F5xAclvkKaDJDpKSu6enpf92pPif1Dmq
X-Proofpoint-GUID: F5xAclvkKaDJDpKSu6enpf92pPif1Dmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_01,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=792
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100015

On 5/6/2024 9:57 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, mac allocate/register and core_pdev_create are initiated
> immediately when QMI firmware ready event is received for a particular
> device.
> 
> With hardware device group abstraction, QMI firmware ready event can be
> received simultaneously for different devices in the group and so, it
> should not be registered immediately rather it has to be deferred until
> all devices in the group has received QMI firmware ready.
> 
> To handle this, refactor the code of core start to move the following
> apis inside a wrapper ath12k_core_hw_group_start()
>         * ath12k_mac_allocate()
>         * ath12k_core_pdev_create()
>         * ath12k_core_rfkill_config()
>         * ath12k_mac_register()
>         * ath12k_hif_irq_enable()
> 
> similarly, move the corresponding destroy/unregister/disable apis
> inside wrapper ath12k_core_hw_group_stop()
> 
> Add the device flags to indicate pdev created and IRQ enabled which would
> be helpful for device clean up during failure cases.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


