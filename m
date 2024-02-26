Return-Path: <linux-wireless+bounces-4021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03589867FDE
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB611F2713F
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0B1D26A;
	Mon, 26 Feb 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mWCZzWwx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF441DFF7
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972381; cv=none; b=EFMO+Vz0jmpO9LJyyo8ONWS2U4QcX8hqdWqCsRwNU5ITplUWselOxmKay9LxePWnJb+gti4woonSuS+CLLsScG3HVhj49ELs7EfuEjeG5150iS0YwsAOxgJ1FSBqKoPDvR8kpPLUedIKylSHAQc0z4ZOiACk4iC+JF26sILYdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972381; c=relaxed/simple;
	bh=OnnkwJrqKAKsyUSQyAaCfmcv2faRZX7Bbmw7a3bUWm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AuShjbw06t+vg112c55+rsceLU6g8DNcncBY6QYvA9R2PWKKzqPzsZT1Oq7pbLVODZaf/8czB1UL9G8r5xZ6KF/Gqjj2v30sVq0XQoqDbIvleMj284B6RZhCB+ZcoPGoDKIUYP+/xXif/QZbpAdBpIbdoxJQj0RqOYMMnZCB2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mWCZzWwx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF8Jdg005073;
	Mon, 26 Feb 2024 18:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EMWU6TjUgTFNUJJWPrlwfz6A2PrP65e00G+YbvqB0SI=; b=mW
	CZzWwxdF6qkF+Hd4JxLGl07AZthUrDmbw634N5nYLhv7wxRbmNGjgxE681mf1Chv
	OVQTfe+texfBz7ohr1awh6hoSIKCTesRLZV+zbJhYwFxK1B0LcDd6fCpYZLDfzXQ
	E5QIO/r55ONMMz6+0J1cGw5i8HGUgKtmxndkl40b8E1rzkI2jRxTJfgLWE1LgEZg
	75H+TVv3LVmum21asvy6TlAN5DjfVdyAqZ/+0Lt4UL4WPz9wjGvBPrex2css6lRp
	tDQJY9pijZPmszcnjMNcTAnZWY5ze6ARBQpY6GmRwHLV7fTAg28QfGTRZGxBgsZV
	bo7rk2pMQyqiWI17Ov5A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxmhsc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:32:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QIWtRa019642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:32:55 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 10:32:55 -0800
Message-ID: <1eb47a6d-dddf-4bfc-8ee5-b47dbb87736c@quicinc.com>
Date: Mon, 26 Feb 2024 10:32:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: Refactor Rxdma buffer replinish
 argument
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240226162310.629162-1-quic_periyasa@quicinc.com>
 <20240226162310.629162-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240226162310.629162-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3Vqbm2D_XmPpWlYtFmcQ_VPWkCRWNt_O
X-Proofpoint-ORIG-GUID: 3Vqbm2D_XmPpWlYtFmcQ_VPWkCRWNt_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=566 impostorscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260141

On 2/26/2024 8:23 AM, Karthikeyan Periyasamy wrote:
> Currently, the Rxdma buffer replenish procedure implicitly retrieves the
> number of free entries when the caller passes req_entries as zero. This is
> helpful to replenishing the Rxdma ring when the caller is unaware of the
> number of entries to replenish. After the Rxdma ring is initialized, we
> can pass req_entries as zero to replenish all the free entry in the Rxdma
> ring. This change helps to align the argument req_entries to the used list
> entries for better code readability.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


