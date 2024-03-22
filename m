Return-Path: <linux-wireless+bounces-5156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8271886FF0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 16:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83841C20887
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D453E22;
	Fri, 22 Mar 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ol4+qsG3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731F4AEC1
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122320; cv=none; b=DVwUb5ws281KUlGms+IooIXo6S16coXKkAFSS6ArZQsc5zvvB4ZPC7nc1eNSeqtjqvB5NDopApUIGokyJi+WSu+uIeoNMI4UQskRztRduY0xXXOdG4kx48BJtRffBnqWqRAzwsFc3kPIxLEBe4TiBdM2zQV0OtPnkyTRKzPp488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122320; c=relaxed/simple;
	bh=/GDx0bTLIsqlaI1Q/aIsrQ9MEdQey5eenOdEP7Kr+Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ryMsSqjarJ2scwvcgyFitFe2odeW06YkHMt/yy8uURzyq2GXYvGwz7pxKb+9V90Qu0TCUgfI2oWY8Rak0UJ+99JaZypVf7uxczt320Z+ZF/1Tkh7w1zERzh4ynp/YriGJ4+AoQY1G9qY6ePpUE4z3YRAW6H/+0R8bWz0w4VOmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ol4+qsG3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42MBPOMf021459;
	Fri, 22 Mar 2024 15:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fCTRfJLugi1U1gmWmTaMXjYjIO0ASWya5UlcfsnlHew=; b=ol
	4+qsG3fA+9iCxVkKotWF1I7YiFcspp8sHTDXNHf5wKYCEVsU6a/LohYTXxKCs89j
	aW5zIt0PxBOG/Ygqb4ReP3PpMfTFLNE1bKL51fDP1JF1aVZdpYMZX/2oZk3ZhujM
	2LQNmWxwjh3IKSqbrna+/ygQmq5x7NNZRRrK5cINEiT4OP908f7UZT/6zWEPfgAX
	/Z5RYIfSBsU7F11mXV0ehyi/eRhGQxMnFP2YZYUf/BVtsaj1ePdYuK/NnVtuuuzp
	X14aHQzPgCDKs2ejtbqO4wwPMfN7AWQsY+ao+V7WDLQyuJwwuSFn9RfjNaYA6tyk
	heJJ/lj4JAZpqSaDFjvg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0wy92h25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 15:45:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42MFicBF029779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 15:44:38 GMT
Received: from [10.110.74.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 22 Mar
 2024 08:44:37 -0700
Message-ID: <c4332e24-6e17-4a14-999e-71340873f67a@quicinc.com>
Date: Fri, 22 Mar 2024 08:44:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2]wifi: ath12k: Add firmware coredump collection support
Content-Language: en-US
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240322054231.467152-1-quic_ssreeela@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240322054231.467152-1-quic_ssreeela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 462cuQYZwofMS-FxibgT9vze_RHVi8vs
X-Proofpoint-ORIG-GUID: 462cuQYZwofMS-FxibgT9vze_RHVi8vs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=813 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403220113

On 3/21/2024 10:42 PM, Sowmiya Sree Elavalagan wrote:
> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is disabled by default and can
> be enabled using menuconfig. Dump collected for a radio is 55 MB
> approximately.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> ---
> v2:
>   - Fixed errors shown by ath12k-check

But introduced a new one:

drivers/net/wireless/ath/ath12k/coredump.c:1: Improper SPDX comment style for 'drivers/net/wireless/ath/ath12k/coredump.c', please use '//' instead
drivers/net/wireless/ath/ath12k/coredump.c:1: Missing or malformed SPDX-License-Identifier tag in line 1

Note that .h use /* */ and .c use // for SPDX comments

Also note that although this applies cleanly to ath-next, it does not apply cleanly to the pending branch, so it will eventually need to be rebased.


