Return-Path: <linux-wireless+bounces-7645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7C8C57BF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 16:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BBF1F2281F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108E1448FD;
	Tue, 14 May 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ta9Kwbo8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1301448D7
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695976; cv=none; b=iS5vUJ1uCGdTKbnrmbUn2tgD8tqAlZDlbhSC8/ogkaT1M90UPDs5T7UwVpo+MuufDT0Mme6To51s3Pd3u9IE7UgoqrLfIEk5537ahDsnRPpAerxAm7wB8PGjG6IFySqW4yU74vWV6ajfvTbjOt1B0iRQn+fUI8C6p0a+wQ4tFl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695976; c=relaxed/simple;
	bh=M7lrzGU1HYr0HCZzUqRGPnydAR0p7+afk0BA3syK7Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sON4Zu6jCrN7gqy8WJmMYZAlxT4ziYvCrngbK40YAi0zopRXQPs2HW139AlEI0y+Rn9OEWwAUA1cVY8KU3lagrrVYNawtoZ9drzHoJtYkFcXm4WCwyWG8oRNP/8WrBKP4TrlzVy1RgGjP0ULtAGD2KM7gUamG/Gx6VhjG2EJwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ta9Kwbo8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44E86JB2004414;
	Tue, 14 May 2024 14:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TyjS2lBcKDMzZ5mgTKXn1k6ubIMh0kByQgkxnlUo1oE=; b=Ta
	9Kwbo8fjUrvPXRawrz+Wgr3/s4s4OPVxQXetyZYDZp2bKVWK+h9ZjxoOucSNHAx4
	3E1lLSFmwl3EI6px/mNeaOYwpDB3Up5cy0DeDsp+6+koANprD3WDU821tcvENwRz
	8KpT88zkSPiDQB2Uv6/C3Z5kAvVWr8eq6bFJfL4l5ru0Ag9ID/LcBoM4nFtdLK51
	VxgO24C8utmHMBkZEwDoIhk/FvePlsY4PdasgRNyQn3sSJGeFOjtKioKYaOjA5bM
	2AhMtn9QGeW7gXo8TnTGz/PWLx/SFCsuRthvFHZp401FAwtVgWs7AFPyVk8U4ebG
	GAX1jrgCknZi+Fy+/LCg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y3j28k3kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 14:12:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44EECe69010495
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 14:12:40 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 07:12:39 -0700
Message-ID: <9076663c-cfda-41a4-8580-6c922696b22c@quicinc.com>
Date: Tue, 14 May 2024 07:12:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix Smatch warnings on
 ath12k_core_suspend()
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240511095045.9623-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240511095045.9623-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eZKrZSYDHOMWqeXh2kXjMi3Ar0B0VzQ4
X-Proofpoint-GUID: eZKrZSYDHOMWqeXh2kXjMi3Ar0B0VzQ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_07,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140101

On 5/11/2024 2:50 AM, Baochen Qiang wrote:
> Smatch is throwing below warning:
> 
> Commit 692921ead832 ("wifi: ath12k: flush all packets before
> suspend") leads to the following Smatch static checker warning:
> 
> 	drivers/net/wireless/ath/ath12k/core.c:58 ath12k_core_suspend()
> 	warn: sleeping in atomic context
> 
> and also gives the reason:
> 
> drivers/net/wireless/ath/ath12k/core.c
>     48         int ret, i;
>     49
>     50         if (!ab->hw_params->supports_suspend)
>     51                 return -EOPNOTSUPP;
>     52
>     53         rcu_read_lock();
>                ^^^^^^^^^^^^^^^
> Disables preemption.
> 
>     54         for (i = 0; i < ab->num_radios; i++) {
>     55                 ar = ath12k_mac_get_ar_by_pdev_id(ab, i);
>     56                 if (!ar)
>     57                         continue;
> --> 58                 ret = ath12k_mac_wait_tx_complete(ar);
>                                         ^^^^^^^
> Sleeping in atomic context.
> 
>     59                 if (ret) {
>     60                         ath12k_warn(ab, "failed to wait tx complete: %d\n", ret);
>     61                         rcu_read_unlock();
>     62                         return ret;
>     63                 }
>     64         }
>     65         rcu_read_unlock();
> 
> But it is weird that no warning on this in run time even with
> CONFIG_DEBUG_ATOMIC_SLEEP=y. With some debug it is found that this is
> because: when system goes to suspend, ath12k_mac_op_stop() gets called
> where then in ath12k_mac_stop() ab->pdevs_active[ar->pdev_idx] is cleared.
> This results in ath12k_mac_get_ar_by_pdev_id() always returning a NULL ar,
> and thereby ath12k_mac_wait_tx_complete() never gets a chance to run.
> 
> Fix it by retrieving ar directly from ab->pdevs[].ar instead of using
> ath12k_mac_get_ar_by_pdev_id(). Since ab->pdevs[].ar is set at boot time
> and won't get cleared when suspend, ath12k_mac_wait_tx_complete() won't
> be skipped. In addition, with ath12k_mac_get_ar_by_pdev_id() removed,
> rcu_read_lock()/unlock() are not needed any more, so remove them. This
> also fixes the warning above.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Fixes: 692921ead832 ("wifi: ath12k: flush all packets before suspend")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/ath12k/7a96ca11-80b5-4751-8cfc-fa637f3aa63a@moroto.mountain/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

I still can't get my copy of smatch to find the original issue
[jjohnson:~ 63] smatch --version
v0.5.0-8639-gff1cc4d453ff

But obviously this fixes the issue, so...
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


