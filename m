Return-Path: <linux-wireless+bounces-6134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4DD8A014E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 22:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28722B21FEA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69556181BA1;
	Wed, 10 Apr 2024 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nr1al54Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE464181B97
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780914; cv=none; b=sAi/OI62xZ/ibS0irHhL4TaUMYt1OE89fZQsIVLS1ghA2jpfV6x0qRWXjgn17xt44Z/l0q8T7OOZrcrdflEJ9lL6WQs9PERCBf/H0zUEBTArDK+kdyn3lUsJVPQC8cK7nseJj3njqfUdijSiCUh9w81OQnZ3QtdviKFHmkPhDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780914; c=relaxed/simple;
	bh=kElUhNbIyDXepRG5zbEjBZPa8nGlSf/1zrBA1Pmo4aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AdrjXXy+QgW9gH5+XYkhNU3IKM8O06CYXufV+yQrjSShb5LIQHZJ4Y9gSEDYOWDJHEDgouUCRGd5woY0e2VkVN9x3su3e9wzqgFRLbzY9w8MSN3LojAcXaUfW3PDEgIC/H6F9Btq0qYgmd8TZwsJ6o4H3Etqq69EzyTfvrTaOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nr1al54Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AJJLrM013899;
	Wed, 10 Apr 2024 20:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OfOT7YtHzjgJWZHk9MM3kzt1Jqu6u6VgN+9Nmrt0B8E=; b=Nr
	1al54YYR7iYB2+58YeHXSKWL/qFzjwmHQOjFDzZTZMopCqPJkOsibLKwkiPiDlLt
	cuxi66Dk68mG6MgjoKfFDl5ord/pNHgjSRET5St/kfx0WHCkPBVug6nIvF9O6v00
	ybUHK2rbCWh+rW65l7N9dxwC5BkNqiYiWqV7rDgmEpeYbUluL1XHWGW/5gYWS71d
	SOiF7wBJIXmD8NVfmFNwhx2e8nyF6H8EC03drUFax4aX9TlO7uilkjEEq1TDy6Bj
	NOoduVlaVBVtbC22P2bDg/BKMptlyaJnggka+eSGC7Hcai6YafldbIpufyKzJqsH
	28mnrf5WCB6iTHfYIEMA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe0pw06nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 20:28:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AKSOmt003164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 20:28:24 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 13:28:24 -0700
Message-ID: <dff77529-3c1a-4d7d-8cfa-e0ae1820b1c5@quicinc.com>
Date: Wed, 10 Apr 2024 13:28:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: enable service flag for survey dump
 stats
Content-Language: en-US
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan
	<quic_tmariyap@quicinc.com>
References: <20240410085329.3649572-1-quic_kathirve@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240410085329.3649572-1-quic_kathirve@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wsBTnh6R4GBtLxFMeFuqHyXfRU8-QPWy
X-Proofpoint-ORIG-GUID: wsBTnh6R4GBtLxFMeFuqHyXfRU8-QPWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_05,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=784 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100149

On 4/10/2024 1:53 AM, Karthikeyan Kathirvel wrote:
> From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> 
> The survey dump statistics does not display channel RX and TX time
> properly because the survey flag is not enabled in the firmware service
> flag.
> 
> If firmware supports enable the service flag "bss_chan_info" in
> wmi_resource_config to fetch and print the stats for specific pdev.
> 
> Enabling WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 does not have any impact
> on WCN7850 since this bit is not utilized by the WCN7850 firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


