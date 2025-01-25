Return-Path: <linux-wireless+bounces-17921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910DDA1C0FD
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 05:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63371889CEE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 04:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65237204683;
	Sat, 25 Jan 2025 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0URK9qC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CFD146A7A
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737780931; cv=none; b=Q3C+uOt+iPwBPKNGTdtNd1Va76c7MA84jSbfL4pJTRbVUlj+5E7QcES86JMSov6UVsHhbH5JX424w82pR9vgWByuhV9IbA8eAWdCi6qB+GgCwAGLYULCqY+zDKh+KnsG9iFsxi95LXOCBALPe/2jijxneEcggKD276jEeA3EA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737780931; c=relaxed/simple;
	bh=ngsfUtuUqemaXJr1TD+b9fBBr4SBlx6oR+8ZTkhlt8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sl641hXZF9A+1RN8z9RkI9MyRFOwoqiaXYE/eQwPJ9BOJ3FVldY0jeBw6Ao+CftDI/amAhOEKRnBjmm/6MVOSE7TTFPt8nHUZ8qGQnw28wmwonRDMhA43BeH578HChpfjW/nIPefFwV2qnDH1TRFRRvoOpxKvZiK+yYucp+QMh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0URK9qC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50P4bL02001179
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 04:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q/f+uBqE3qcvW351dPMd1CvKq4gspazuDatXFeQqMn8=; b=m0URK9qC+ZimcX3x
	Cwh8GCKYMsCiXPYwRuipHoAUxCEvySPlvklpswAyYMiHBdJnPW5/igCJRVIRlqkM
	Nt29jY+DKjsX7BsTkuLcWdM5x7rrY71T2J+Z/ELvpHxaLARnbPSfz5+9CW5dfc/6
	wkelHv5MA2e810eq5t/uZVybY28cK7OaG0yC8eNOmcUcRB+gPPsHPg+mPjWTtukH
	VRy7QbfJRyIeRihxKFMwSZpy2c/FXfAulwtA3ntbA9UpDwm7OXRj3W0Hy5J3Wan/
	KrMsCG0RidsOnrEsU0wDKifqBuAm+idwwFTch/P7ecJnCJdU+ZHulESm0roPt0ak
	Xoo/cA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs2hg0jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 04:55:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2167141e00eso58534205ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 20:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737780926; x=1738385726;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/f+uBqE3qcvW351dPMd1CvKq4gspazuDatXFeQqMn8=;
        b=me75Lwd6ZRcmlsDHSGpuDnEbVMMIl+lUr9YNMrF6iQbPugrrwpBt5OwwFqCp5KcyxW
         U37TtNBluqXiZWovQYg9sFUSi4pSLC9Rsp7v6s36hLj3VL3YpX1i4rFIMOi72MCycHE9
         knbxmvc7a/YKoGuy89upmfhiZon3HMdL8NsSkGtbzdqLP5trxo1T72VYzGA0aw+dXI17
         unCBAzwyUYDQy0tyy+4ouZsRZm0FsX874htY+JaF6U2gAwxIELG4n1BNckxo5h2r1fvs
         aQrWzeKMvILeyXQ8vGv+WPeiqLkFoG5O9yPXAOaEMY0aznTJryuS44mksurof4FIPjin
         qdxg==
X-Gm-Message-State: AOJu0YxgtOkfSp88n6+RMa4rH04FlYhDhOdxDj1AT5VAj40fqhofTAn9
	stCKxjBFCiPd+Ke47iBYOTUVpW6N5gwh+D1cIJ4ASd9zWBUn71/h252L48jD5oK9jD6gfvYp/FE
	ZNSQbohit2YYTcYP85BvEovcW+TJrk1bDWfQo9Bz9yKXtE65SC46Gc0UFAVlhREx+mn7XZDzECw
	==
X-Gm-Gg: ASbGncubrjBb91EK09e0EJMapjYAWjUBC9ES9hxc/QboSOyVg8MpmRcF96qCF6MoNns
	N4raS5lUdAkiK+coDSUDPsw/ccUiTZXgJB9vRMM1mMo1lujyAe4V9mwYb4eZ24VgbqraCzHkWcr
	0dunj+j2GJgSGgUCPlWiurf4+yUfUNrOc1Hj6/hFzM97M65noGB98QHHROQ/FyWzPcwWPcMalBc
	GvbNqsnnIXGv7nCgBIHWepApI9RluV3hU2QcTZ/Eq2/adY+qgvMLQPKuEhGPeoent3NkIuPp5j/
	wO1bJTemEttoSOrAOhgGrLaxWn2EQDekchA+vnO8kA==
X-Received: by 2002:a17:902:cec6:b0:216:5568:38c9 with SMTP id d9443c01a7336-21c35574ee8mr472207355ad.31.1737780926508;
        Fri, 24 Jan 2025 20:55:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjdiFhmKFZp+U7E0Nyrmz/UCSRKHVShQT1wvEl4yXVJ9h9Bbe/4DnM4EJRsKFjn8Wbq8DKcQ==
X-Received: by 2002:a17:902:cec6:b0:216:5568:38c9 with SMTP id d9443c01a7336-21c35574ee8mr472207205ad.31.1737780926076;
        Fri, 24 Jan 2025 20:55:26 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414db2asm24396635ad.169.2025.01.24.20.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 20:55:25 -0800 (PST)
Message-ID: <dd37c366-21f5-470b-9d4c-24ae2808c4bd@oss.qualcomm.com>
Date: Sat, 25 Jan 2025 10:25:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] wifi: ath12k: Avoid napi_sync before napi_enable
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Avula Sri Charan <quic_asrichar@quicinc.com>
References: <20250124090058.3194299-1-quic_tamizhr@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250124090058.3194299-1-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bsXb_Nzkf15UEzkOw07s6dqm09jA2F_K
X-Proofpoint-GUID: bsXb_Nzkf15UEzkOw07s6dqm09jA2F_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501250030

On 1/24/25 14:30, Tamizh Chelvam Raja wrote:
> From: Avula Sri Charan <quic_asrichar@quicinc.com>
> 
> In case of MHI error a reset work will be queued
> which will try napi_disable after napi_synchronize.

nit: always better to refer function name with () at end. I guess Jeff 
can fix in pending?

> 
> As the napi will be only enabled after qmi_firmware_ready
> event trying napi_synchronize before napi_enable will
> result in indefinite sleep in case of a firmware crash
> in QMI init sequence.
> 
> To avoid this introduce napi_enabled flag to check
> if napi is enabled or not before calling napi_synchronize.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

