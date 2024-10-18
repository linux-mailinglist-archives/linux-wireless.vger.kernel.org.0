Return-Path: <linux-wireless+bounces-14195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B45CF9A348D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 07:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506D11F21339
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 05:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A21547C3;
	Fri, 18 Oct 2024 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CN/ods0L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6417279E
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230662; cv=none; b=Zqmj5XeiWCQoburtN8TDnQTXSJHVrEFQ+nsFeDXL9fa5tx8eLtpbIjYcb6Nwd1nPSNrFQK/q2SAS+/1z1isEWYazLweVlmp+ZmL5I/qXSkdGyGpV+RRqhD//FojsP2UzxSLySaWRmhn69/ZvrnGidhN8bQ0Y1CclX3NmvnqHnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230662; c=relaxed/simple;
	bh=1zs5+Rax3iPtfKO8n1YUk0aqD4vjljf3+ehkJ/bEzeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C8gLxfqG2CNT9X7YrbT1X0Qo+yUnGRqwLevSeFg8N4Fmg6vxhD91zYgyo0J3AAKLXi6StQICEzKOi4nwKmCxC95ST/bAfawSn128GwbM3OQpoL3zscvSEXPKtRop2/icze4QlYXD6slVi9BxWP28Bfx5LT5pkOHPUGMHJKiGgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CN/ods0L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HNPcUk017530;
	Fri, 18 Oct 2024 05:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LIvUrNOi92cI7d28+hfF+K/eCbVWhsXcoQHr20WizeM=; b=CN/ods0LZqwKguqy
	w3vVS+Aj3nT33TJfJBL8YnxMIye5EXpNBzWF+iOiPm0uVDmbxWv4gW8RtBZ72dfC
	RLbweYFQHovco/+NRGMUbl3gTrn0ZhNuekxyGVVq1X9WLQxP6IHJxoqUZO0aVEP0
	pQvZTEysjahOjyA7r+DhEDs0BFadsZoyN/p9xpy41xkUN/uob9ved8cmYWM/8mS0
	TKe9txEY6puba+UKPyCXZCixzh39lGvQ9+5f53bI4Qe8LNjpbX2q+008S25PhJCo
	1T1nAwI9rHwoFFJTPTG65NlMwP8L++ZX6X5aN23qYF6F5u2gFX/VuVz7XzhZgKdO
	TXXCxA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b0rx2tva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 05:50:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49I5owkI018598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 05:50:58 GMT
Received: from [10.253.14.84] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 22:50:56 -0700
Message-ID: <818aa658-6bca-4c36-a261-428b276f0dab@quicinc.com>
Date: Fri, 18 Oct 2024 13:50:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] wifi: ath12k: some fixes and clean up for monitor
 mode
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241018054620.2080-1-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20241018054620.2080-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: woOBg6DxTDfdBcRX1jEeIOOKbJMd_XTj
X-Proofpoint-ORIG-GUID: woOBg6DxTDfdBcRX1jEeIOOKbJMd_XTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180034



On 10/18/2024 1:46 PM, Kang Yang wrote:
> This patch set does some fixes and clean up for monitor mode.
> 
> v5:
>      1. rebase on tag: ath/ath12k-mlo.
>      2. remove patches which have conflicts with MLO branch.
> v4: rebase on tag: ath/main(ath-202410161539).
> v3: rebase on tag: ath/main(ath-202410111606).
> v2: rebase on tag: ath-202410072115.
> 
> Kang Yang (8):
>    wifi: ath12k: remove unused variable monitor_present
>    wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
>    wifi: ath12k: fix struct hal_rx_ppdu_start
>    wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
>    wifi: ath12k: fix struct hal_rx_mpdu_start
>    wifi: ath12k: delete NSS and TX power setting for monitor vdev
>    wifi: ath12k: use tail MSDU to get MSDU information
>    wifi: ath12k: fix A-MSDU indication in monitor mode
> 
>   drivers/net/wireless/ath/ath12k/core.h        |   9 +-
>   .../wireless/ath/ath12k/debugfs_htt_stats.c   |   8 --
>   drivers/net/wireless/ath/ath12k/dp_mon.c      | 107 ++++++++++--------
>   drivers/net/wireless/ath/ath12k/hal_rx.h      |  53 +++++----
>   drivers/net/wireless/ath/ath12k/mac.c         |  14 ---
>   5 files changed, 98 insertions(+), 93 deletions(-)
> 
> 
> base-commit: f7ffb7753c52eb06feaebb62c5f392e05fa3412b
Note:
Other three patches will continue to send public review when MLO is merged.
wifi: ath12k: optimize storage size for struct ath12k
wifi: ath12k: properly handling the state variables of monitor mode
wifi: ath12k: delete mon reap timer

I tired on (tag: ath12k-mlo-202410171313, origin/ath12k-mlo) and (tag: 
ath12k-mlo-qcn9274-202410171314, origin/ath12k-mlo-qcn9274). Both of 
them can directly apply this patch-set.


