Return-Path: <linux-wireless+bounces-14793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34599B807C
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111E11C21DE9
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60051BD009;
	Thu, 31 Oct 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ou4ucsEo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15B16BE1C
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393117; cv=none; b=R8O6fZsWIWouKJ/j/WmWEsTqBqscUjysQWzTklqQA+E8biW/5UvERbEVf/R7s1NbXBNvtJ40CmrWVxC8G8lIN/RdM7Gvm52noaGfXsPOoG+HT3VYiy09AHF2sa1q5IkdMDf1CTke2BpklQr++nlM9P0Q430qTshuUal10AgpvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393117; c=relaxed/simple;
	bh=8i3ic6kordsQczVYul7fBoObdURPdAy1hsWIi1cbvhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I7iO38rs5DUlips5x/5rBboIdFbka8RV7Gq3JUjwrVMinO9wQPPidXJ2gCWY/835ZNAqDy04HTMG5FZQERy1jRZkMJSdgqtlqK86jQ0DDw0lvGxS0roUUra4CDOvS3w1D+lB8uupSr98o3RE4ALCq+t2Tmxjuh1aH8EoxGv+4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ou4ucsEo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VDMHEU027403;
	Thu, 31 Oct 2024 16:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DAR39LrXvYxTV/DMCKVwA/tT+QC4Y9AGkQ0zqWcpqlM=; b=Ou4ucsEoZEltxFDt
	GFvdbQ43oHpF2UCff9J3ifTGgeX1Q2Ny7wY+6kUYdZsWzYk8Vldhhf27rhqGLdAn
	+iiGr4CSG1G2+bQyJNnzagt/L6Rz5JIXOdsewRsf/t+y0tvzzo92ggL95PmV63Tr
	ZN5kyxzI3n0aFaI6PfyiqoSrI4Xad7Rdpe294jTgpDrgokixCT6EP6feY4ptZNaa
	sy7o8dnEeJiFGwa/YUL+SWn2NLpApPmiDFBk2O06wj3Ll5sIKP/+LtE9oabe1Qu6
	epbazYG0TxNmqVZcBypOD6MmZ7x21pt4S5kz6MVSRUpC2Gp0HEiRV1CjLqR1nWfZ
	SwEbvA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k1p37mgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 16:45:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49VGj91h025026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 16:45:09 GMT
Received: from [10.48.242.225] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 31 Oct
 2024 09:45:08 -0700
Message-ID: <95911a1e-db8c-4aba-939b-7dbd95c99ea8@quicinc.com>
Date: Thu, 31 Oct 2024 09:45:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Fix unexpected return buffer manager error
 for WCN6750/WCN6855
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241030114625.2416942-1-quic_bpothuno@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241030114625.2416942-1-quic_bpothuno@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3yGu4kOqbSYFeDnZBdtx6zafy2VFe6bQ
X-Proofpoint-ORIG-GUID: 3yGu4kOqbSYFeDnZBdtx6zafy2VFe6bQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=695 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310127

On 10/30/2024 4:46 AM, Balaji Pothunoori wrote:
> The following error messages were encountered while parsing fragmented RX
> packets for WCN6750/WCN6855:
> 
> ath11k 17a10040.wifi: invalid return buffer manager 4
> 
> This issue arose due to a hardcoded check for HAL_RX_BUF_RBM_SW3_BM
> introduced in 'commit 71c748b5e01e ("ath11k: Fix unexpected return buffer
> manager error for QCA6390")'
> 
> For WCN6750 and WCN6855, the return buffer manager ID should be
> HAL_RX_BUF_RBM_SW1_BM. The incorrect conditional check caused fragmented
> packets to be dropped, resulting in the above error log.
> 
> Fix this by adding a check for HAL_RX_BUF_RBM_SW1_BM.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00258-QCAMSLSWPL-1
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Fixes: 71c748b5e01e ("ath11k: Fix unexpected return buffer manager error for QCA6390")
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


