Return-Path: <linux-wireless+bounces-123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA787FA93B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 19:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373E9B20F10
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BA31A6E;
	Mon, 27 Nov 2023 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IN8gShE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C2D4D
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 10:49:21 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR8wSUO007676;
	Mon, 27 Nov 2023 18:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RPAoCY4Yz2IAN2+mroe9auOkhni0k+RBCqloksd9vA4=;
 b=IN8gShE+P0KvlvTrSTx/26HTKOhUksrjiCuN1/7TWISkWDSlG1pye5p8tSYa2Qjg5sMM
 o+/weMgLqlbUNAGykjUovBkIBL7sbbLVrHY4kFguQNEhj9rO59qX5QNbbS0F6+siYkLr
 zxmatxtZ8++JpN890gLE+ZzB7D4kZfdc9qItaGnx9iEtrAuiC9CB2lL2QzaaGakt3lwW
 X90Hr/RM6t6qPRidkLRHOboxoChy3aSqlhFqaDCgqbwu5winGUjtQ46WUqYCfR6tJ+WQ
 R1eeH1DCFFR7l4Z9DGm3cja4kAcNDvvdlpsHHewArrZ7oFnT00q+8grpRguValQTcCe7 LQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk69udh37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 18:49:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARIn7Sa005072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 18:49:07 GMT
Received: from [10.110.63.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 10:49:07 -0800
Message-ID: <c59e408f-1e44-4c23-b073-19f85cb28383@quicinc.com>
Date: Mon, 27 Nov 2023 10:49:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/8] wifi: ath11k: hibernation support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231127162022.518834-1-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231127162022.518834-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K4MWfMf1VtJWfZdNggP2cnN_KrJQzQM5
X-Proofpoint-GUID: K4MWfMf1VtJWfZdNggP2cnN_KrJQzQM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270129

On 11/27/2023 8:20 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Currently in ath11k we keep the firmware running on the WLAN device when the
> network interface (wlan0) is down. The problem is that this will break
> hibernation, obviously the firmware can't be running after the whole system is
> powered off. To power down the ath11k firmware for suspend/hibernation some
> changes both in MHI subsystem and ath11k is needed.
> 
> This patchset fixes a longstanding bug report about broken hibernation support:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=214649
> 
> This patchset is marked as RFC as it requires changes in MHI subsystem. Also
> this has been tested only on WCN6855, need to test also on more AP based
> chipsets like IPQ8074 and QCN9074.
> 
> The patches are also available at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath11k-hibernation-support
> 
> Earlier versions of this patchset have been tested by multiple users with
> positive results.
> 
> v2:
> 
> * rebase to ath-202311221826 (6.7.0-rc2-wt-ath+)
> 
> * 'bus: mhi: host: add mhi_power_down_no_destroy()': fix null state string for
>    DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE
> 
> * 'bus: mhi: host: add new interfaces to handle MHI channels
>   directly': fix typos in comments
> 
> * 'bus: mhi: host: add new interfaces to handle MHI channels directly': honour
>    initial autoqueue configuration
> 
> * 'bus: mhi: host: add new interfaces to handle MHI channels
>    directly': don't prepare/unprepare MHI devices that don't match
>    with a MHI client driver
> 
> * 'wifi: ath11k: remove MHI LOOPBACK channels': remove LOOPBACK channels for QCN9074 as well
> 
> v1: https://lore.kernel.org/mhi/20231110102202.3168243-1-kvalo@kernel.org/
> 
> Baochen Qiang (7):
>   bus: mhi: host: add mhi_power_down_no_destroy()
>   bus: mhi: host: add new interfaces to handle MHI channels directly
>   wifi: ath11k: handle irq enable/disable in several code path
>   wifi: ath11k: remove MHI LOOPBACK channels
>   wifi: ath11k: do not dump SRNG statistics during resume
>   wifi: ath11k: fix warning on DMA ring capabilities event
>   wifi: ath11k: support hibernation
> 
> Kalle Valo (1):
>   wifi: ath11k: thermal: don't try to register multiple times
> 
>  drivers/bus/mhi/host/init.c               |   1 +
>  drivers/bus/mhi/host/internal.h           |   1 +
>  drivers/bus/mhi/host/main.c               | 107 ++++++++++++++++++++++
>  drivers/bus/mhi/host/pm.c                 |  26 ++++--
>  drivers/net/wireless/ath/ath11k/ahb.c     |   8 +-
>  drivers/net/wireless/ath/ath11k/core.c    |  44 +++++----
>  drivers/net/wireless/ath/ath11k/core.h    |   2 +
>  drivers/net/wireless/ath/ath11k/hif.h     |  12 +--
>  drivers/net/wireless/ath/ath11k/mhi.c     |  77 ++++------------
>  drivers/net/wireless/ath/ath11k/mhi.h     |   4 +-
>  drivers/net/wireless/ath/ath11k/pci.c     |  55 +++++++++--
>  drivers/net/wireless/ath/ath11k/qmi.c     |   7 +-
>  drivers/net/wireless/ath/ath11k/thermal.c |   3 +
>  drivers/net/wireless/ath/ath11k/wmi.c     |   1 +
>  include/linux/mhi.h                       |  47 +++++++++-
>  15 files changed, 285 insertions(+), 110 deletions(-)
> 
> 
> base-commit: 16a212b4f33c4edd9ce9a9e0953b5389216e8ed9

Series LGTM. Will add appropriate tags when this is no longer RFC


