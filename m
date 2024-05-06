Return-Path: <linux-wireless+bounces-7255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9368BD5FB
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F34B20A65
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F4415ADBE;
	Mon,  6 May 2024 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oXPINUF0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5A158873
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025586; cv=none; b=HE1FU35fE4iSrxLq67gUbQT8nhXxgd+kQngoTm3G7NimI7MbEbhLtRbGQoa70mNEY8ZuRdlPaHCQ3h3geCa7GeZzQAuBZZ433uktck/iJ7LwNqmgnMJDHAnAQBNWm6Ny2BdihM25Zxi7vcIRsY4WVzTUjOdNxvhSCO9w501Lt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025586; c=relaxed/simple;
	bh=RjELKrBwYzxauMZqdYXkfAbg5Mjeurz47M18RdS0ZG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LD6QCxwhmcNuyD3FHxZUMkQ7fAy2xRU8xPTbgmVNNE5DyVS16FPAy0OVVN+u1Rm59rfoDdsMZGdgEpcSXtBBXwdkmRLxvke7oPdKToF0CRUL7dUq+m4HqYOF3jZUtPGyRD3ZsnfniHDFx+sS5hRNguljL2bKfhT9zkGezYAG3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oXPINUF0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446HtbAG026861;
	Mon, 6 May 2024 19:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=znCC9Wj8UrFkjd8KrMGgvDVcqjr7DGjW5JkzK6S/3wE=; b=oX
	PINUF0NW5KB+fAaa8MeWh9+Fh5D9rxLg4MH2RYpbYdDbPfVJ6gF3N7Of4XgM/to2
	OkpnIkidVrYBG1Ofqr1Ucrjar2z2xluA+EwfJeCEkS7LSaCpktFVaA8rMekSbf5j
	twpG+eWmyvmQaYma4UDDm6aYE0fJY92ymGmEgFGdgZwqYwuzYtREgYZ4JBZpRA4m
	AzxpErIUIEJEz4RBP/xhbcH1rEIIEK/GOkZlvsfAvrHaQi5T+zX61B2NurdxO7w5
	/nhfTN++0H3WdDExO6j73SWEG5KxHbQK+4FglF4h7RUxtoH6ycT9FKqJzi2hH6LU
	WuJuQbFyrCl2keWzWzOg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxw9a972b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 19:59:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446JxTpt022143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 19:59:29 GMT
Received: from [10.110.82.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 May 2024
 12:59:29 -0700
Message-ID: <1dc900a6-b972-4a86-995c-c0b965792cdd@quicinc.com>
Date: Mon, 6 May 2024 12:59:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: avoid double SW2HW_MACID conversion
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240506173017.597715-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240506173017.597715-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _E_ur83NNsYkF3i1HgqtMcIRvL9YcWeJ
X-Proofpoint-ORIG-GUID: _E_ur83NNsYkF3i1HgqtMcIRvL9YcWeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_14,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=698 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060145

On 5/6/2024 10:30 AM, Karthikeyan Periyasamy wrote:
> Currently, ath12k_wmi_pdev_dma_ring_cfg() fails due to an invalid pdev_id
> parameter passed to the WMI_PDEV_DMA_RING_CFG_REQ_CMDID WMI command. This
> invalid pdev_id is caused by a double conversion of the MAC ID. Since the
> the caller of ath12k_wmi_pdev_dma_ring_cfg() already performs the MAC ID
> conversion, it is unnecessary to do it again within the function. To fix
> this, remove the software (SW) to hardware (HW) MAC ID conversion from
> ath12k_wmi_pdev_dma_ring_cfg() to avoid this redundant conversion.
> 
> Found in code review.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


