Return-Path: <linux-wireless+bounces-8027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E68CD88C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CFD2836A3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545CB17C8B;
	Thu, 23 May 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RpVxGEGo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7405CD304
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482346; cv=none; b=VKaL+UbfgGD486mX+6l2WKsRwGj6irF/j3S22b3jm4Dzxn6k3uo6lZ+3MgpzljZ/xPuMIM+EBt28244TesxBrS/iZW/2Q05ahcxkY0yV60nulZgg1qwaBKyFLIpAhDO98kZa7EfJjh4C0uVuR6KW4w1JiGkEmY31ALfeR1KXjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482346; c=relaxed/simple;
	bh=DI1tjUMJgGo7JLydCf2V71/j0M1mswkACxOgvvM4Q2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GfclRSVHJRDvI4Pt4LCaNFazXuoDcT8WnpTgsehydiNFqjIwKSnriHCrFaUDO2UazfybBX082A8FKcO5Ks0XIYWVR3UZapqBoGKtGFrJR3/0Sr/LyuMxUWyDevJlvOOCmtc6P95rhpk4DD46ax0hab2J2zALO+inrEeQ8QGnnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RpVxGEGo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NDcX6R014500;
	Thu, 23 May 2024 16:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KLbDo2BUgdUrUgLjmRHDmk8Xo/wBDZgUG77lNMmx2Ag=; b=RpVxGEGoq0voJRgJ
	FYndCdO3X9Rj+cSQX7/DcL4NyvH0YmgMTyy03sRQ37+3Q0QY+tLmO4Eha6Vntfrw
	4vNypicdWaIfyJmgN1JodroDxKhx0TP4DXzqsvLW5NwhJV8YYdFRDSyeHmkHiyYA
	2NoI66+ETsG4iE5f9lQTPZL92J4zJpKhbv6xiPsWJJIpw9lxxSpvVjdEeN3+algy
	FrHnUmz2rk3DDG8neIBjvZlsPug5q60rpRwFwMsaDJRFtSpHDaC9VqexxjgEpWOX
	f/00n+sXf8pve0DTWOCImM88SUSwr+AVoInwzIukCF2kIe7FZLIYl8nAbV6elCn2
	LuRwnw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y9y20hrh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 16:38:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44NGcw41025000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 16:38:58 GMT
Received: from [10.110.17.44] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 09:38:57 -0700
Message-ID: <fed84044-d53d-4409-8994-3e9f136e673a@quicinc.com>
Date: Thu, 23 May 2024 09:38:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] wifi: ath12k: add basic WoW functionalities
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240523033143.21677-1-quic_bqiang@quicinc.com>
 <20240523033143.21677-3-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240523033143.21677-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PvdZXiQ0oE-n75vC7GCaKsoFx6lEMNm6
X-Proofpoint-GUID: PvdZXiQ0oE-n75vC7GCaKsoFx6lEMNm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_09,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230115

On 5/22/2024 8:31 PM, Baochen Qiang wrote:
> Implement basic WoW functionalities such as magic-packet, disconnect
> and pattern. The logic is very similar to ath11k.
> 
> When WoW is configured, ath12k_core_suspend and ath12k_core_resume
> are skipped (by checking ar->state) as we are not allowed to power
> cycle firmware.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


