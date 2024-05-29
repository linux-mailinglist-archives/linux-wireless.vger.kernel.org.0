Return-Path: <linux-wireless+bounces-8273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC81D8D3CE6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777741F27589
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C365225AE;
	Wed, 29 May 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GIsaY+/J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3FE576
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000363; cv=none; b=eGf8ivJA9u7jxRe68oN+6k6abgCEO99OCVVA3mYtzdgrCv3LeTsSIdnCcm8DZOzkTtggmYmyVcHcfXyU7nlVCiD/RDO/weTuJ95zjt1pL/RsIH9wB5pYq+sCOwzC7ObAo/I2Mj574dOw0sSm4vNYc/xcAchVZEI0bXohf/H39Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000363; c=relaxed/simple;
	bh=fxFgEZr38WAVfrp2Td/I5kFJotdEYUFOhEGu5WGBDdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fMbSvMpCQjG8pmvgeASHgtqt0SjBuyowHlV7iQIzDicMKG3IpmdVsp2JcsE7m3GOc3m7nOkLX4kFCZxPK+gwFNqmvkgLB2syjAcyI29vHr8Qo5sC60JhO1Hsx+Pk0qfcKJqYQb1HqIHky+B6+Rbd4i1caglgMNJI2x5yKL/Bvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GIsaY+/J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TBGj7Y018130;
	Wed, 29 May 2024 16:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GcbpX5c5QniOODrVoHtbsCIRxrVUpkToVewsQMFoqmI=; b=GIsaY+/JvuTPaJWi
	+9cSu8WDuLq0fxOhJO7DFayR+9u54N95g9nEDgpxwdxlabRg9lahSxI/APKvtv5m
	FeLLJfqLJSMrujkUQmD3Bu7kyfMX4sSFnVo7striMk9yPC2hGrmwVsBWzf4IFThW
	rbXzHxVru8HfEd2yeIKJDpr8fq9mGFtpKzJT0q+1XZNNOTp4vHU9PUlmafvx28f0
	uMpubqt2V1jSPTkthToDnzZNvkqQ7u/gRbdXRoTq85r3b5400Mj9QLYCV+ZuuRQK
	kOvY9147rqmL0xr/9wSJUBtCRuFloP9a/zR+0yA+D5OTbUilFfpWbHACZ2rx4dtT
	1rcHUg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qhg8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:32:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TGWNap021639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:32:23 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 09:32:23 -0700
Message-ID: <6c95d8e2-c8f7-4ef4-ad17-46480bca27fd@quicinc.com>
Date: Wed, 29 May 2024 09:32:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix WARN_ON during firmware crash in
 split-phy
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240529034405.2863150-1-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529034405.2863150-1-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i4a54sxiXLBKIm1dPrERTf-FKp8ZtFxy
X-Proofpoint-ORIG-GUID: i4a54sxiXLBKIm1dPrERTf-FKp8ZtFxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290115

On 5/28/2024 8:44 PM, Aaradhana Sahu wrote:
> Whenever firmware is crashed in split-phy below WARN_ON triggered:
> 
> ? __warn+0x7b/0x1a0
> ? drv_stop+0x1eb/0x210 [mac80211]
> ? report_bug+0x10b/0x200
> ? handle_bug+0x3f/0x70
> ? exc_invalid_op+0x13/0x60
> ? asm_exc_invalid_op+0x16/0x20
> ? drv_stop+0x1eb/0x210 [mac80211]
> ieee80211_do_stop+0x5ba/0x850 [mac80211]
> ieee80211_stop+0x51/0x180 [mac80211]
> __dev_close_many+0xb3/0x130
> dev_close_many+0xa3/0x180
> ? lock_release+0xde/0x420
> dev_close.part.147+0x5f/0xa0
> cfg80211_shutdown_all_interfaces+0x44/0xe0 [cfg80211]
> ieee80211_restart_work+0xf9/0x130 [mac80211]
> process_scheduled_works+0x377/0x6f0
> 
> The sequence of WARN_ON is:
> Thread 1:
> -Firmware crash calls ath12k_core_reset().
> -Call ieee80211_restart_hw() inside
>  ath12k_core_post_reconfigure_recovery() which schedules worker
>  for both hardware.
> -Wait for completion of ab->recovery_start.
> 
> Thread 2 (worker thread):
> -One hardware acquires rtnl_lock() inside ieee80211_restart_hw() and
>  calls ath12k_mac_wait_reconfigure() into ath12k_mac_op_start().
> -Hardware is waiting for ab->reconfigure_complete but at this time
>  recovery_start_count value is 1 because another worker thread
>  (local->restart_work) is still waiting for rtnl_lock().
>  recovery_start_count is not equal to number of radios
>  (2 in split-phy). So ab->recovery_start complete does not set
>  due to this, thread 1 is still waiting and not able to perform
>  hif power down up and firmware reload.
> -Wait timeout happens for ab->reconfigure_complete and comeback
>  to caller (ath12k_mac_op_start()) and sends WMI command to
>  crashed firmware and gets error.
> -This returns error to drv_start() and local->started is set to false.
> -Hardware calls cfg80211_shutdown_all_interfaces() after receiving error
>  inside ieee80211_restart_work() and goes to drv_stop(), here we trigger
>  WARN_ON as local->started is false.
> 
> To fix this issue call ieee80211_restart_hw() after firmware has been
> reloaded. Now, each hardware can send WMI command to firmware
> successfully. With this fix we don't need to wait for
> ab->recovery_start completion so remove
> ath12k_mac_wait_reconfigure().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


