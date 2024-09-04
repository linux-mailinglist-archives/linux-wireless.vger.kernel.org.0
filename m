Return-Path: <linux-wireless+bounces-12496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369AA96C42C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 18:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6F0282D45
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3A91DA319;
	Wed,  4 Sep 2024 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i2/9KbQG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70286E619
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467593; cv=none; b=gL2rUBXvtn2URwZbf4vWju4wR1a+3jaulwf2xHenHXiytWUjwJn9BgXsrgSxhJ41AxGBL9Uh60ha2f3J21w/xkBXdeYSpNCVkBd/pUuHCdhig1v+yfMoNaWfnYreSpeYJP2yXaIZrzTWaI4o8AMV49JMsCEixJGW5i4FHWVGV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467593; c=relaxed/simple;
	bh=FLsmmCKWoXYn1zuUtskcHRNidQ7ZpVetahaFPtDhCwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bJX7s2+Iqpj4yWFUuWx76p3T2sFJ0J5Ay4WivQsDhJnM77viQXuZQOGmR4q+gFNJfkY7tmNMX7IrnfFnGUh5yq8QJCBGR6saQmtpUUDFfx5x+OZFXMu3kxAKYPhwIwLxBzwn0imWF7c5gmQwRe7BHab5w+5JESiB0W1AKD/GZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i2/9KbQG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849WpXj018311;
	Wed, 4 Sep 2024 16:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QQnAX3W3NcLsytEHpL7Exp+94ycRPEnN9e3UhOWrF1w=; b=i2/9KbQGlhfP2AoS
	CBtarhZql0ppmwMz+AWgngmPfXcaU00S1z7lUDAykLj64Iwx7l7k1gtzSslf4bgj
	4bJPl/VHovNB7xAWgmQIrLn+pUngTxjPCNuQlXB0APRfsSQZsMaIQyJr09Fp3t5p
	nkqsZAqQUu6BRtisgIWFRjEFluiEEydL+/MDZ5/lj4XhcY4bZZtr2Km4lUHuGSPi
	uj+OKCgqY2xTbLDEUGM0fu5tfcO0QCYZtK+fVU23HdPNsYnADaB4AJTVICaoFIFW
	QlMrXUU5GzFIjHkg2g6dJaXs7r07dJ0WD7uImVId9quO9ys3exOHLqLw+BNq7ePQ
	xXt5iQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxudjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 16:33:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484GX6Xu017667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 16:33:06 GMT
Received: from [10.111.180.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 09:33:05 -0700
Message-ID: <f613591f-bca5-4481-99e8-d294703f67dc@quicinc.com>
Date: Wed, 4 Sep 2024 09:33:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: avoid deadlock during regulatory update in
 ath12k_regd_update()
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240830023901.204746-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240830023901.204746-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7KmdMan058zAROn1C-FW8Pg6ZUDOek2m
X-Proofpoint-ORIG-GUID: 7KmdMan058zAROn1C-FW8Pg6ZUDOek2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_14,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409040125

On 8/29/2024 7:39 PM, Baochen Qiang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Running this test in a loop it is easy to reproduce an rtnl deadlock:
> 
> iw reg set FI
> ifconfig wlan0 down
> 
> What happens is that thread A (workqueue) tries to update the regulatory:
> 
>     try to acquire the rtnl_lock of ar->regd_update_work
> 
>     rtnl_lock
>     ath12k_regd_update [ath12k]
>     ath12k_regd_update_work [ath12k]
>     process_one_work
>     worker_thread
>     kthread
>     ret_from_fork
> 
> And thread B (ifconfig) tries to stop the interface:
> 
>     try to cancel_work_sync(&ar->regd_update_work) in ath12k_mac_op_stop().
>     ifconfig  3109 [003]  2414.232506: probe:
> 
>     ath12k_mac_op_stop [ath12k]
>     drv_stop [mac80211]
>     ieee80211_do_stop [mac80211]
>     ieee80211_stop [mac80211]
> 
> The sequence of deadlock is:
> 
> 1. Thread B calls rtnl_lock().
> 
> 2. Thread A starts to run and calls rtnl_lock() from within
>    ath12k_regd_update_work(), then enters wait state because the lock is owned by

checkpatch complains that the commit description exceeds 75 columns

at a minimum you should avoid exceeding 80 columns

Kalle, do you want to reformat when you pull into pending?
Or are you ok with the current formatting?

>    thread B.
> 
> 3. Thread B tries to call cancel_work_sync(&ar->regd_update_work), but thread A is in
>    ath12k_regd_update_work() waiting for rtnl_lock(). So cancel_work_sync()
>    forever waits for ath12k_regd_update_work() to finish and we have a deadlock.
> 
> Change to use regulatory_set_wiphy_regd(), which is the asynchronous version of
> regulatory_set_wiphy_regd_sync(). This way rtnl & wiphy locks are not required so can
> be removed, and in the end the deadlock issue can be avoided.
> 
> But a side effect introduced by the asynchronous regd update is that, some essential
> information used in ath12k_reg_update_chan_list(), which would be called later in
> ath12k_regd_update(), might has not been updated by cfg80211, as a result wrong
> channel parameters sent to firmware.
> 
> To handle this side effect, move ath12k_reg_update_chan_list() to ath12k_reg_notifier(),
> and advertise WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER to cfg80211. This works because,
> in the process of the asynchronous regd update, after the new regd is processed,
> cfg80211 will notify ath12k by calling ath12k_reg_notifier(). Since all essential
> information is updated at that time, we are good to do channel list update.
> 
> Please note ath12k_reg_notifier() could also be called due to other reasons, like
> core/beacon/user hints etc. For them we are not allowed to call
> ath12k_reg_update_chan_list() because regd has not been updated. This is done by
> verifying  the initiator.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Co-developed-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
code change itself LGTM, so...
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


