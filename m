Return-Path: <linux-wireless+bounces-3868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB5985E422
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9922851A0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAB982D9E;
	Wed, 21 Feb 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NlBdQAIP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1B33F7
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535655; cv=none; b=CXgzvXP5BLnCwumWVcQW5P6E2jPAdEpTfbsRtgd2w+N39AFdVcOoIcTjuG+kIgrmamK329BQN9aI81cdIHLm2RksxiVK2bdtsIfsJmjbencbUyWlbUeWyD/cyf7FSU/KcNcol9oxSaLdKV75d07Q8HekLtQsvgpZtDRuTVdVkAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535655; c=relaxed/simple;
	bh=oq3BVzyKL4pX8Fels2I4k6Cgsc/vImOaUDSQEQ+koL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cgyvFIkY5v0pWMbyiCiyPvNnt9Dxn6fqyj6znCq1mSFh7o8L3PWpenXhUGX/uJmhmHSVk7FdMK9FuO/4/dGC52RAFNLdem8062NDaRvg6jQefFwpyE7Vt9oBHyxWZF44fzWLRKIxuZGe9ZnjSOUs7hyHCrFaFzwwAhSn9/NQJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NlBdQAIP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LAkMg6012320;
	Wed, 21 Feb 2024 17:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=plmbNxFEeErYIpNW0lrqzWets2YIhkCXmrTlnzgpF/0=; b=Nl
	BdQAIPWNb1PVr9aLZ2aOCXcRc2+Nx5EcJfwyKg3gg7nHzz/IAq0OZPru3ihKEJR/
	9a/wM84MKqH/3liVKc98tg0icxsS96yM97eyNInGTA51Ma3bl/0PJ6qGKOYYq2EJ
	08GyQeHB/0/UaeXHdfmqKKrPDr7up+THhXmz/nSB0SJx2Jnn4syUtSfqqpLNn0Qn
	1TvxJW4UsN6u8LYcA1nM/S+UxFVmMqPcuInsTpbXCTroXbMNfbLxISPMMBZ3QigE
	/clDB77SJ0wNqkPlydRKPqjMVCkheXxbkhjUCwFIcysfwrsJF3UtPsyidBFj3v7p
	y5wLBzbcZUNmZmC0dvqg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfqa0x1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:14:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LHE9g4024506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:14:09 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 09:14:08 -0800
Message-ID: <084e6d40-dae5-46cb-8541-a3b2708747a0@quicinc.com>
Date: Wed, 21 Feb 2024 09:14:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] wifi: ath11k: remove MHI LOOPBACK channels
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
 <20240221024725.10057-3-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240221024725.10057-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q6IJYTKKfKyFueiXSvp7wcaup6D0ADIo
X-Proofpoint-ORIG-GUID: Q6IJYTKKfKyFueiXSvp7wcaup6D0ADIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210133

On 2/20/2024 6:47 PM, Baochen Qiang wrote:
> There is no driver to match these two channels, so
> remove them. This fixes warnings from MHI subsystem during suspend:
> 
> mhi mhi0_LOOPBACK: 1: Failed to reset channel, still resetting
> mhi mhi0_LOOPBACK: 0: Failed to reset channel, still resetting
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


