Return-Path: <linux-wireless+bounces-10306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B300A9340C9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 18:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4F71F21263
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D315B181325;
	Wed, 17 Jul 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QsxAn2YE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE11802AC
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235172; cv=none; b=A0Z2oGN/UzgncNlpyNiQ5bUPV/Eit4W4De3L/mFtf4kU2u+TtBgDRkTic0uq+n3PuYlwOzIPGUWnpcEe7eEta8Tr/WpOaRD0L6zVQE2Rbju/5XW6wXKhfDG9XvzZrZ0EHSdcmC5yXjNNSgM+pzP0mrZQEPhBLWD+28wxF4s9Zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235172; c=relaxed/simple;
	bh=sKa8WMZBEWeqGNYz20mm4uVdpYUsuf6ldxeH0MnkZ9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MZehgwtyItb99S/nZdB2k8ropaiv/CBZtWVL9Xb0dftf4aCkJAUvR/NzaXe/bjZkvUGkKg59L9mqrJC4tf6bKDbwCo6ATtB1u08XVRUTUcgXcv9i5NTlY62dJ/khzo3KlutdOzgkyNzR0HnxuqYBdvfNdUiWO5nhcZ2E/OTj7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QsxAn2YE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HE0naL012817;
	Wed, 17 Jul 2024 16:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t4rW/6mSWW2E0z5XDoFlQ9MYyQg6nQBpf1P8FOUMtx4=; b=QsxAn2YEdWO7HCiq
	fRo0FqciTARB/hU+p240m7VnhCO2zgh9pE3G8y1cLj9qffeWGEphR0gsy5bG328H
	MU0q5AdcbGV9eehbU6Dti+pBHFXU0OZd2m35bVAayAsYPGuX+dChiuNTaEVMrj1T
	MFAAagKo38syDHBFRwhH85AKBiZTjetwGVirC7+HGzpU4g3hP1CyMGwVPYY6abIr
	qd5sz9xKfOKczy/wYxO9HMLRFfrf+UDhDfpfxTu34PiEaORd/2+wCRWrBC4+fiKG
	aJQP1uG1fkqtfildN8GhYtFUsGJk2T/01CUr1a22OajjCT4ZWnIzykjHcfuYoir7
	dmYjbg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfwb4tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 16:52:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HGqjBO010660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 16:52:45 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 09:52:45 -0700
Message-ID: <cc96cdaf-9a20-44c4-b409-d568e48b05b7@quicinc.com>
Date: Wed, 17 Jul 2024 09:52:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: ath12k: Add support for obtaining the buffer
 type ACPI function bitmap
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240717111023.78798-1-quic_lingbok@quicinc.com>
 <20240717111023.78798-2-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240717111023.78798-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FvRPSpvNsgAgGpWZXpPEVV00coQW1L9o
X-Proofpoint-ORIG-GUID: FvRPSpvNsgAgGpWZXpPEVV00coQW1L9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=621 impostorscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170128

On 7/17/2024 4:10 AM, Lingbo Kong wrote:
> Currently, ath12k does not support obtaining the buffer type ACPI function
> bitmap.
> 
> To solve this issue, change the code to support obtaining the buffer type
> ACPI function bitmap.
> 
> This patch will not affect QCN9274, because only WCN7850 supports ACPI.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


