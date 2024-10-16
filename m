Return-Path: <linux-wireless+bounces-14028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE40999FE67
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 03:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A431F24F87
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 01:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6911DDC9;
	Wed, 16 Oct 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gLmHhN2Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A74171A7
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043145; cv=none; b=hkD7aEbfCZm4MXIWEuXW+b8GnM96mYJtONP8a5mEZEQ0USQFKODsk3IFjqxmZEtcOAGtSsa0vYxGO0tAXk0TddC943Vl4CMg4Mn/J7lO5wHLrtBD4WLs0GvP23sCbKl/0vosB+RuWtpzOlLfiQNeLXktgvFs86+LSj/XmTEP0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043145; c=relaxed/simple;
	bh=qzOdsnMD/pLbwqQXYSplYLgkDIH401A/ZYUMSa0Zk2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FNVLAPCMkmxvVWzDZ0uDdeG3g07Y1Ab2vM988uD2SBkPoMFApwS+rA1PEQ+e0M0owb+13fkeN1LNhKRS//nNSAs+F6LkcE3ez+aDk2CVqGk9CaxTZGMa6G51GULOV2EdPbC0ONCM0Wda2rCkIdC7Qbyq9DYro/zxrqLSl9e6hp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gLmHhN2Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHc2tJ007494;
	Wed, 16 Oct 2024 01:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6eB3P0RUzugGcgI9oeHPWddAzZ0JTq97gXXPmH3Mkdk=; b=gLmHhN2ZB5YbNC2P
	wObpGGpS1H/RnHEkF8fwEy+NmfLrm5KvKnknemKH0frKevcb/Bz70ohLjkKqvk4t
	1C7UCdtOn9bW2ahjwOXHiwpFtMrNYELwjVXjgFJ3kwgpVpdTDxoumJG/C9FkW9cl
	K23tj1gMErArxv6tFqBtV2p+2g61art5gJYhRo4+K9Wn58XbOROb0CeoWPTav/mU
	Knr8HoTEpvuJer34Vy8MQuVIDO8UC8tcMEE6Vl/tXj2I3PN5xHwVNa7yipvSFBo8
	kkaJ7+xsUl+tQ/oYlGmL1LGBb63yXeog2heWqcO6a7J7ehuB7mLG10wqPWzzQDeL
	EXxmMA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mh52w9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 01:45:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G1jcYg004993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 01:45:38 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 18:45:38 -0700
Message-ID: <7ca286cc-5ee5-4fa3-af86-05b381dacd58@quicinc.com>
Date: Tue, 15 Oct 2024 18:45:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] wifi: ath11k: add srng->lock for ath11k_hal_srng_*
 in monitor mode
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241008053744.1070-1-quic_kangyang@quicinc.com>
 <20241008053744.1070-3-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241008053744.1070-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AObHifDSZCx91g1iyQed4S_bCw_MV9kh
X-Proofpoint-ORIG-GUID: AObHifDSZCx91g1iyQed4S_bCw_MV9kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=589
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160010

On 10/7/2024 10:37 PM, Kang Yang wrote:
> ath11k_hal_srng_* should be used with srng->lock to protect srng data.
> 
> For ath11k_dp_rx_mon_dest_process() and ath11k_dp_full_mon_process_rx(),
> they use ath11k_hal_srng_* for many times but never call srng->lock.
> 
> So when running (full) monitor mode, warning will occur:
> RIP: 0010:ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
> Call Trace:
>  ? ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
>  ath11k_dp_rx_process_mon_status+0xc45/0x1190 [ath11k]
>  ? idr_alloc_u32+0x97/0xd0
>  ath11k_dp_rx_process_mon_rings+0x32a/0x550 [ath11k]
>  ath11k_dp_service_srng+0x289/0x5a0 [ath11k]
>  ath11k_pcic_ext_grp_napi_poll+0x30/0xd0 [ath11k]
>  __napi_poll+0x30/0x1f0
>  net_rx_action+0x198/0x320
>  __do_softirq+0xdd/0x319
> 
> So add srng->lock for them to avoid such warnings.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

(note that since this has a locking change Kalle wants to review/approve so
I've assigned this series back to him in patchwork)


