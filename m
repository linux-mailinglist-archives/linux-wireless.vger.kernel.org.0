Return-Path: <linux-wireless+bounces-17775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F46A179C7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B91F3A6578
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71611A8F9B;
	Tue, 21 Jan 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XOacLwHX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C741BD9CE
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450234; cv=none; b=D2pQVgEMf2vd7kBjRxFYxAUwWJ8kB65f1gJAgzyhuiHY0iXr+wRJwa98YeYY6hNeKY10rb8iGcFlFwJMIGZPxxYwZvUJhcP4iMqAwDiwlErHpAPP+yIeRnG/iTk6/R/4CSfNXO/6Z2qDL7KOKUNfigcZwSSPXxPmbgs/+kftJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450234; c=relaxed/simple;
	bh=YATcEClw4S64iRgfzR7UllcLeudEed7Sd2g4LGidQvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=csKGhZgHVOMV+nejAePDcMmsNGw0GvqF4/oI2sC4fKpr1WJ85htxMS3nXiHvG5+auilF0JXQrgCsO58okKfP4RlpHupg2ceyfvqjdXXiyV5FK/2WKRkVYQ4J4jC4RJBzYVmFUTTHCK00TEfIedhcsDKH/qzQ5d8CuhTk8/4+hho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XOacLwHX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8YlbI019356;
	Tue, 21 Jan 2025 09:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Ngsf6pE6RxloFaystJ2T5yhCoZODdfOLR1IQLbOuj0=; b=XOacLwHX7chazdFx
	u61cz0qpOPmnvVl6g6aNjJIR6/FkScjfOob+qzJkQKVLGVYT2/Gnh/dDiyhCRyxB
	lkBuePxjCaTy3ctfelSHY9y9zGAoVC8nN5i/ojnS+HBFTfgo9vAILnd8zjvv4fGi
	uypbnc9TAsV4k/H3ZQkWba4qUzTerJ2f0fBw+KlirWBoHK1F4D8XneEp4gg6h8s8
	p0R4350cos33vtGhprYqF3mPEzshVw+EZjAt78BhnZ0zPWFTLVoK1yZ0vs6UJ/OG
	2Gg91no0X4KOxYQ2hQ7ai6+cCQsk6Hq7VVVXpDCVCuvKnI2svA3FZXdZN982s/8+
	AM6gxw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a2wwgtfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:03:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L93ov3000872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:03:50 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 Jan
 2025 01:03:48 -0800
Message-ID: <bb4e2001-dea8-4efc-ae3a-babcce8acb0f@quicinc.com>
Date: Tue, 21 Jan 2025 14:33:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] wifi: ath11k: update channel list in worker when
 wait flag is set
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250117061737.1921-1-quic_kangyang@quicinc.com>
 <20250117061737.1921-3-quic_kangyang@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250117061737.1921-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ebZGbjWj3i8OSfszsqJH1meI1etkCwRz
X-Proofpoint-GUID: ebZGbjWj3i8OSfszsqJH1meI1etkCwRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210074

On 1/17/25 11:47, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> With previous patch "wifi: ath11k: move update channel list from update
> reg worker to reg notifier", ath11k_reg_update_chan_list() will be
> called during reg_process_self_managed_hint().
> 
> reg_process_self_managed_hint() will hold rtnl_lock all the time.
> But ath11k_reg_update_chan_list() may increase the occupation time of
> rtnl_lock, because when wait flag is set, wait_for_completion_timeout()
> will be called during 11d/hw scan.
> 
> Should minimize the occupation time of rtnl_lock as much as possible
> to avoid interfering with rest of the system. So move the update channel
> list operation to a new worker, so that wait_for_completion_timeout()
> won't be called and will not increase the occupation time of rtnl_lock.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Co-developed-by: Kang Yang <quic_kangyang@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>


-- 
Aditya

