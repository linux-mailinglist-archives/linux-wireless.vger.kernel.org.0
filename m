Return-Path: <linux-wireless+bounces-18220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC5EA230CE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90ED188923D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F491E9B1A;
	Thu, 30 Jan 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLG3dHKw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B21E9B19
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249565; cv=none; b=dEWI6dLKoRALb8sLHOOnbPCoDuVrn9f95qxyXTtauEXFoKl4YP6c7TDvGKEpFvMhJufItfVw0neI6/O6NViWabnOJB6haYL2N5Y3rTYVFNEstxGSgmgWk11zBmZinHnlXU3f+IjPMq2+1uFwDsNrttfL9T9p1gELvERAuW1UqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249565; c=relaxed/simple;
	bh=m8O1+Jxn4sYWG1PpKDtLtU3xBPy/tTU9TRDPR2NtmP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2NR0A/O2/lejQyybDVU8MK8+WfPxFqO4vOYy5NORWItOELKZDyOLBYFNd8z/OFsC8OOQdHSHm+9WuUJIJav027HIrB4dWb03/iVtomtP3/Atn2tZAuYAzVTfTMgyq/Td3kOL/Z54mQjM0yGdZ50XQsAT2/vCZCptptQHC29N+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLG3dHKw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U9J9ZB002095
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 15:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MzgOHo4QYuDJoNHCjDaUQbI1mKIJTtDENiPvY5AnCw4=; b=GLG3dHKwZciIhzDX
	6JRpjvpLXljjyFU1FxigvCV+wfrBdLjY3LlAz8iVFSQ3BdU1R0gxPRnuGWgo1Sxk
	1dd4RHB8nS+FUCg/bQtYSSIF8xT0NHdlb1aVemfyv9BuOuI7GIYNDLqNiZFYuNfp
	VPYBJaScJuxLxXwebUfDp+htt6BTaUV7zXerXI8+MYiKOAWbWasFyPJ/QNWdzLWZ
	3UNWmhQJkfFmf/kK3LZiWI3C68KPB76bKx1Ogu0WZNDf2UPm66Z15NmXmtCYNGyh
	sDAcCABxRq2c6sMR28B7Y/nYFkBS+T3gdfZfcWVx7wnwCDptrBClDIN4PAVN/OQu
	Xu5iWQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g6pbgsd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 15:06:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso3883499a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 07:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738249561; x=1738854361;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzgOHo4QYuDJoNHCjDaUQbI1mKIJTtDENiPvY5AnCw4=;
        b=Nw/WZ88o2PfObEBy4REnCVKhMwoMyDXonKN7RkNs2ReKyeWb1p2IQGNpmbqLaXP1JH
         knQSjqFvy1qmpdb0BeLbM296W04IUPFpUJeFc9gD/zzbujydRx3wJXsi74xTgxWWrsvq
         MRolIjTrYKNdERTzJ8vAM1wpwe9+ix/VoRq9kmMzeqglGryvOsSTtkTw3XDq8QhHu8jL
         gZJCBL5y3t2qcTXStnXFJBQEom6TZ+0Y5FlKDpfL0yJ8c7BIpt1bqivTznprXkjMIJtd
         EinIbaZpl1bzf1IT38G1w4iESUEwLFY0zh5SC8EKWIgSl3Sv3ahDy3KQEXpr3TtveEoX
         4L7g==
X-Gm-Message-State: AOJu0Yw1u0lHJhSx8HvxS2aF8MQiJYtvtnoMsY+DfKpJ/xozBV0WcbeQ
	QKKyUpdjE5lyA9DQd6mdnfHjqy/kOFPTaqzpSSLzKs+mV9OzT2LHdpeqRK/tnkP0uE83ZdJEXpP
	TrUDQlMXimrggmlYdCP1hyw77hjDXI8RaFbkFjOGfsyQTYODNXUNqsGfIko9330Arkw==
X-Gm-Gg: ASbGncs3yLCpmznGQDc/ZaloHGk1CIT+8OeItvZ3GtE2jQs5+XQql9sWzv+ybyuzfSM
	rzHT7AC9r/PlBh2pmiuyMEfpSIfw5L2e/sHdqVN7rmvwTuYP1+YVDkkAieilKH6B75C+fmqF5he
	4pnnViFyqM7BumDuuljnsKnrtV9hlofkVfp0EajN+XZaOeUevYpoGbquGymIf+O0CrCHxqOdbEK
	2/Zu/xa/H9VlkqtTlWGaYsXNWkIVvVmPPJF1q45sPKdyfvmpfWPDqnPU/dPX5TvBWLULCUHPX43
	e+JNhmLckHqn9gLyo2Ck5Orw9dImIph7WT5tBSOtj8Osw821ISSqoTa9+p6sYuoz+LbYI/a1NA=
	=
X-Received: by 2002:a05:6a00:388:b0:725:d64c:f122 with SMTP id d2e1a72fcca58-72fe2ccbc83mr5582698b3a.2.1738249560644;
        Thu, 30 Jan 2025 07:06:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZJOtFuOthZ1xpjDBt60v7h4CpA3Phg2tECzGuyjHVsd95FEciWhbGWItjAKyhqnv5DillyQ==
X-Received: by 2002:a05:6a00:388:b0:725:d64c:f122 with SMTP id d2e1a72fcca58-72fe2ccbc83mr5582663b3a.2.1738249560184;
        Thu, 30 Jan 2025 07:06:00 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe653a9f3sm1541750b3a.75.2025.01.30.07.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 07:05:59 -0800 (PST)
Message-ID: <b155f782-feea-4b99-8edd-e499e313294e@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 07:05:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] wifi: ath12k: Avoid napi_sync before napi_enable
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Avula Sri Charan <quic_asrichar@quicinc.com>
References: <20250124090058.3194299-1-quic_tamizhr@quicinc.com>
 <dd37c366-21f5-470b-9d4c-24ae2808c4bd@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dd37c366-21f5-470b-9d4c-24ae2808c4bd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZoQGJTDNpZzg-6Hyocjr80QhyoZQfQR5
X-Proofpoint-ORIG-GUID: ZoQGJTDNpZzg-6Hyocjr80QhyoZQfQR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300114

On 1/24/2025 8:55 PM, Aditya Kumar Singh wrote:
> On 1/24/25 14:30, Tamizh Chelvam Raja wrote:
>> From: Avula Sri Charan <quic_asrichar@quicinc.com>
>>
>> In case of MHI error a reset work will be queued
>> which will try napi_disable after napi_synchronize.
> 
> nit: always better to refer function name with () at end. I guess Jeff 
> can fix in pending?

I fixed this, as well as did some other grammar & formatting fixes.

Please check:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=a644c8784220b7d5dd0a10a45c5e6779605778a5

> 
>>
>> As the napi will be only enabled after qmi_firmware_ready
>> event trying napi_synchronize before napi_enable will
>> result in indefinite sleep in case of a firmware crash
>> in QMI init sequence.
>>
>> To avoid this introduce napi_enabled flag to check
>> if napi is enabled or not before calling napi_synchronize.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
>> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>> ---
> 
> Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 


