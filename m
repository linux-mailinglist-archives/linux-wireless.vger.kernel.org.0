Return-Path: <linux-wireless+bounces-7071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC78B8007
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 20:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E667F1F21341
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 18:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD217F39A;
	Tue, 30 Apr 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lcy97az9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6317F38A
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502785; cv=none; b=tuQ24T6fKK4qjbuI1TK9V1laUym/76N+wdKEJbEl3JHwWg79ss8h4vKvkFxr7maIpxwwTIV98AcG+osXqtqqN058m8CyBvE/+H5V9Vv7L/wKuyiSb6Cva051tqw2+duVxx+N0t0YS/fyHwi5Ib4Yynio1SkdTCuEGbtzXzxAJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502785; c=relaxed/simple;
	bh=zIwW3GsQR0frV8urLqO4F+ktZcbv7CUlw83mPfQhCng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WS0HoVjqcxsbCWlhd1X10q9MoD9LWHf8LyO5DmcrRPghubp/mpCb5eLoxUEkQjK0t/jS9C95IbTQeXTJGpIxRTZ//PvmRgDU1qhdUH2JHYc8lqV3G+JbGCFkn5jNZcseG5jXFFdtCerXtPXfU5+aFEuOdigWJbqpmqTa7/6hSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lcy97az9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U7EVBg002570;
	Tue, 30 Apr 2024 18:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EY1aYXl51VMJ/Qu2qu0nSWPVGquuELHBI3klAietru4=; b=lc
	y97az97UNHvvr1IP0W+uUhTiEmfmNNeVZSMlyRbypL/eFTZg2M8iO7icP5VFA/vm
	zcvOBD8AI6pA43nO75vlFT9qaUX9njgDui4GdaT7zCIoTd9L1yGmiIJVj2s6vhtj
	Vslv+7Pk2V3Fc2aoH0hp6ghlVmrFDZdNJqTg37Vs91+iTX1Eb/hkdeQFUHOH4r+g
	pzd5VujJ70dRMRR46IMdv0fl86m2yVO6Q3edm4BFzHpfQSk1BnAHwzZLyCtHgN5L
	dxWSZTYBTW4ngKpfN15Ko6pWx5WxEnExj8S+aw+s7b3EwsFJtuB9KNTIYyTDX0V0
	mzejdaxIgpbV66y1iyhw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvux5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:46:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UIk5EH031278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:46:05 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 11:46:05 -0700
Message-ID: <67fdaee8-db68-4eae-897a-63d11f680103@quicinc.com>
Date: Tue, 30 Apr 2024 11:46:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: ath12k: add multi device support for WBM
 idle ring buffer setup
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
 <20240430165811.1377182-5-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430165811.1377182-5-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ronWkXfjNpaUhu9PtlZQvOeJ80EbNjeX
X-Proofpoint-GUID: ronWkXfjNpaUhu9PtlZQvOeJ80EbNjeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_11,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=756 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300134

On 4/30/2024 9:58 AM, Karthikeyan Periyasamy wrote:
> Currently, inter device MLO is not supported. Therefore, the WBM idle ring
> buffers choose the implicit return buffer manager (DEV0_IDLE_DESC_LIST).
> However, this implicit return buffer manager design not meeting the

Kalle, can you add the missing word in pending:
design *is* not meeting

> requirements to support inter device MLO. In inter device MLO, multiple
> devices participate. The device specific WBM idle ring buffers transmit
> to multiple device REO rings. To distinguish between device specific WBM
> idle buffers, the setup configuration need to choose a different return
> buffer manager based on the unique identifier (device index).
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


