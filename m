Return-Path: <linux-wireless+bounces-8047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BCA8CE8F1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 18:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15089B216F4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC8C12F36D;
	Fri, 24 May 2024 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YuLnbvuw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE712F369
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569454; cv=none; b=OXHh03pwLZFhuEm07rRErFQQjVTH4yoq4/rOHbmjRy0SKbeXGtz3ycY0U1leJDx83orRgdlMkTlMPNeGWksF+pL3VDqhw0J7Z6HoQiuOyG9Fci2GYCjLopYqIwbrcpZnOqjY0ZksREvpMS5zaVJmKDdB1PRddVefmvueKsVI1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569454; c=relaxed/simple;
	bh=Bemoe2f3cLciJmuxo+V2XPvQV9bDENR3eE6M6ZO4iNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fpt9I3gDxdC4n9izSXDoqpCKs3VZzNW+x7vjGK+mczwexsNfUuddk51K92gkXtr+45BkrHzzyXBtM0LCcdE0I1BA3lXXoEwBIBKkXXks3GXVoSs9lqh1g1wVtPOT4qbj3h7qYovBJb6/G0yAxNC7ABnWLHcdbCTHCS2LBV1zlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YuLnbvuw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O9mrrg022712;
	Fri, 24 May 2024 16:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/2Ge9KB7TVvgVM4N9EFil0LVBRkxyJPe9a6Ku1xxX4Y=; b=YuLnbvuwtDPmLxSv
	tbNOYTf0ePzDN7Hk1YZ85jhy58YHNfG+tl5oy81MqMGBv1hG3IysOTuirbJ0RUnc
	fUZNOq1nFgc3zOKT5og/pIsbZE+kyCUdYN8Qq5ySi0sJPoVCm1BVpWGU0tCat1eq
	XEdOg8+RuLG4EXjqD+Mf1wyBZLansgsgG6Ty1R/aGaBtwAo5fxbyC5nmV5O2RBtk
	ojZSXhSBB2a5W5fcCUW3SZkA2QdVi1ZiTfZPqEnSHv6d9mGtSaOeRndw9vIg9QdA
	+j4JwFD94jDrO4Ynx2vO1w1rT/13WFThE74qZSjeG9rqTgdJYITUum5qaTocSdj1
	QkX8FA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa9u30j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 16:50:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OGokae007751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 16:50:46 GMT
Received: from [10.110.127.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 09:50:45 -0700
Message-ID: <5288c3cf-3255-4d2f-9066-13b52aed3057@quicinc.com>
Date: Fri, 24 May 2024 09:50:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix race due to setting
 ATH12K_FLAG_EXT_IRQ_ENABLED too early
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240524023642.37030-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240524023642.37030-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5uXlFDPvnOuabQiUWoEs8FjWRBgjBNEw
X-Proofpoint-ORIG-GUID: 5uXlFDPvnOuabQiUWoEs8FjWRBgjBNEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=704 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240118

On 5/23/2024 7:36 PM, Baochen Qiang wrote:
> Commit 5082b3e3027e ("wifi: ath11k: fix race due to setting
> ATH11K_FLAG_EXT_IRQ_ENABLED too early") fixes a race in ath11k
> driver. Since ath12k shares the same logic as ath11k, currently
> the race also exists in ath12k: in ath12k_pci_ext_irq_enable(),
> ATH12K_FLAG_EXT_IRQ_ENABLED is set before NAPI is enabled.
> In cases where only one MSI vector is allocated, this results
> in a race condition: after ATH12K_FLAG_EXT_IRQ_ENABLED is set
> but before NAPI enabled, CE interrupt breaks in. Since IRQ is
> shared by CE and data path, ath12k_pci_ext_interrupt_handler()
> is also called where we call disable_irq_nosync() to disable
> IRQ. Then napi_schedule() is called but it does nothing because
> NAPI is not enabled at that time, meaning that
> ath12k_pci_ext_grp_napi_poll() will never run, so we have
> no chance to call enable_irq() to enable IRQ back. Since IRQ
> is shared, all interrupts are disabled and we would finally
> get no response from target.
> 
> So port ath11k fix here, this is done by setting
> ATH12K_FLAG_EXT_IRQ_ENABLED after all NAPI and IRQ work are
> done. With the fix, we are sure that by the time
> ATH12K_FLAG_EXT_IRQ_ENABLED is set, NAPI is enabled.
> 
> Note that the fix above also introduce some side effects:
> if ath12k_pci_ext_interrupt_handler() breaks in after NAPI
> enabled but before ATH12K_FLAG_EXT_IRQ_ENABLED set, nothing
> will be done by the handler this time, the work will be
> postponed till the next time the IRQ fires.
> 
> This is found during code review.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


