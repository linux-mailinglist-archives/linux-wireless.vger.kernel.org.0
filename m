Return-Path: <linux-wireless+bounces-6944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D58B48DB
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Apr 2024 00:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E469D1C20B7C
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 22:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6350A73;
	Sat, 27 Apr 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VohSSa96"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC61E54D
	for <linux-wireless@vger.kernel.org>; Sat, 27 Apr 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714257978; cv=none; b=Kz54NEykbiZjaQoa5PR8x6J8rRsmB3FRKEOyvc6Y+rv6+mNI1TiaQfNDgoTG055JPj9BhKHutju0IOfmrSEn6o5uQynm6hSfrpbPvUbf/M/Hx1wxiFddwVA0RL7bOnPH5dqIYm3/O4+L/h/t8dhXnIKF6lp5Li6ZYACK55I72+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714257978; c=relaxed/simple;
	bh=yxsRpPQi1f0WbPAt34qqYC3tr3Jql0RoGwu/g7uJ3iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h7RaAe3hzEwJA+Jf5LUxfKyfddyr/yH15whxnXQGvSREBB3TyUMqEPdFiHIhqosz12r2cZwLFi94ZdcwixOkZL5s84w5ndifzean95RTB+6qRisRp2gXWBCdyXQAAFxqmjJLnvutOsax1l29GH6i4p6v6xwk1wcMz50Aef+sZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VohSSa96; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43RMk3dl012914;
	Sat, 27 Apr 2024 22:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=44xxfJtOsHmK/8rspywyrfc8Y5MiR+Ebqvd5b3xlx/Y=; b=Vo
	hSSa965Z5daqZpCmzJHOrqInl1PO0fORhLltx6AHqEHfzbOh7REAfuHsIadIPp+Y
	M8hU+zFcdYq8qqpEdCcgQ5L9q9yRwQ6jiTh09drfs7fYCxTEVkfigI2oWmQoOFay
	WNQHjVhLF8iIalKYQz+tpk7CaKqDwpMjOgtaof1tPy/uTMeqT9/gWausT6SrSfq1
	M5MykftuFP1ACyHdjbwim0pPF77eLJEX+YGNuFVZhSgpmHfpr+X8oxhWzj07ziZr
	d+y3rVYaQbLyrIHxvcMJZ7O/eBL2iXKfYtbwa30TpuII2wl2Q2lE8/avJ4zF66ZZ
	Pl+gAUx1PFvKSZgo3BeQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrpqrs6b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 22:46:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43RMk1Ve032294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 22:46:01 GMT
Received: from [10.110.48.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 27 Apr
 2024 15:46:01 -0700
Message-ID: <c8812227-ae90-4bbe-9fd3-425b61e36838@quicinc.com>
Date: Sat, 27 Apr 2024 15:46:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] wifi: ath11k: skip status ring entry processing
Content-Language: en-US
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty
	<quic_vnaralas@quicinc.com>,
        kernel test robot <lkp@intel.com>
References: <20240427091248.2013946-1-quic_tamizhr@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240427091248.2013946-1-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WQ3E0SGEn0RO1c_nW-U1XYCxuJzdiWEw
X-Proofpoint-ORIG-GUID: WQ3E0SGEn0RO1c_nW-U1XYCxuJzdiWEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_22,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=626 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404270170

On 4/27/2024 2:12 AM, Tamizh Chelvam Raja wrote:
> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> 
> If STATUS_BUFFER_DONE is not set for a monitor status ring entry,
> we don't process the status ring until STATUS_BUFFER_DONE set
> for that status ring entry.
> 
> During LMAC reset it may happen that hardware will not write
> STATUS_BUFFER_DONE tlv in status buffer, in that case we end up
> waiting for STATUS_BUFFER_DONE leading to backpressure on monitor
> status ring.
> 
> To fix the issue, when HP(Head Pointer) + 1 entry is peeked and if DMA
> is not done and if HP + 2 entry's DMA done is set,
> replenish HP + 1 entry and start processing in next interrupt.
> If HP + 2 entry's DMA done is not set, poll onto HP + 1 entry DMA
> done to be set.
> 
> Also, during monitor attach HP points to the end of the ring and
> TP(Tail Pointer) points to the start of the ring.
> Using ath11k_hal_srng_src_peek() may result in processing invalid buffer
> for the very first interrupt. Since, HW starts writing buffer from TP.
> 
> To avoid this issue call ath11k_hal_srng_src_next_peek() instead of
> calling ath11k_hal_srng_src_peek().
> 
> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202303281719.CvnPkOiK-lkp@intel.com/

I believe these are misleading. LKP didn't find the problem you are fixing, it
found a problem in the implementation of the patch.
So I would move these below the "---" so the LKP knows the issue it found is
fixed, but the git history isn't itself isn't misleading

> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Co-developed-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> ---
> v3:
>   * Rebased on top of ToT
> v2:
>   * Fixed compilation warning Reported-by: kernel test robot <lkp@intel.com>
> 
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 88 ++++++++++++++++++++++---
>  drivers/net/wireless/ath/ath11k/hal.c   | 14 ++++
>  drivers/net/wireless/ath/ath11k/hal.h   |  2 +

My Qualcomm Innovation Center copyright checker reports:
drivers/net/wireless/ath/ath11k/dp_rx.c copyright missing 2024
drivers/net/wireless/ath/ath11k/hal.c copyright missing 2024


