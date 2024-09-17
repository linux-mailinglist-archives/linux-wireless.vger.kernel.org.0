Return-Path: <linux-wireless+bounces-12918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3505497B19B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 16:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5CA285CD1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E46176ABA;
	Tue, 17 Sep 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a3utGVtT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E8176AD8
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584674; cv=none; b=JB2oSpiOGTubGNA/dwx7LMM6WBMJ82KXDRvRGopGhW9lxQ/tRhKKKTHFn4Mb1YWUKAGRZbkU17mx76joHzZyhcVrVHIW1KsHDaK5iRgWvIJzSWNvUcGXPNE6Hf4F1po2CMfd7s3ojkZolf90tfSLoVk9ldKuVgkcOZ4TJtbE1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584674; c=relaxed/simple;
	bh=mhoOEJeOY/wf/skh1PHv9ckoKPNSylOQPG/bfh2rBLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QQy6+auCJhCRmmE1BsRVt1DJr7WqiIS64mmspQVwzeIlsTXhUZWjqJMx4NG/ALPxpMmKE0DrTUKl8y9HFD3UtKxUAzBESZMzCxCoTxNGfwF/ZSe1szKF4HVgCSPPNJNZNowj36zn3T793bMga5bGdAWjyCFEv8KQ6yupaAQ1HaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a3utGVtT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H1jtkB025608;
	Tue, 17 Sep 2024 14:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nbGtzBxAlbgIm97/cNG5R95eJg4LGVDNeZiOuoQsdeo=; b=a3utGVtTiv7KuxKg
	6rV4WxhArV1rnBGWL4fOdVMS8cIXA/VgAy14kQvLYNhOYICRF69c5SMrTy6mdKK5
	4AvISucjpqWVrgOPoC8Dd1R/YhoPvhNua3PIFCHtxAlEirY0zwuemmkRiOaLymAV
	JpdAVSmCC0timpxRus86tEk70KyNY27Yy1uN5H1cTM+pMtAFVB+gW2k3004BLXq9
	/KjDk8cgqHw/sGRk0eVTyrkGVyECWWi4j6LP2bfCgVX4oOIhq1T3bR9sfvGNHpK/
	dNazGhpcXpihxzuMYZZTSygncLMlbIXLSGETJIfq3wjvZnAky0pA9lfTzwKFmOQE
	1cucVg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gcy1bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 14:51:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48HEp8pC018585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 14:51:08 GMT
Received: from [10.111.182.118] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Sep
 2024 07:51:07 -0700
Message-ID: <0279cc0e-c225-468f-b228-f1910f95f2d7@quicinc.com>
Date: Tue, 17 Sep 2024 07:51:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath11k: move update channel list from update
 reg worker to reg notifier
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240906033200.472-1-quic_kangyang@quicinc.com>
 <20240906033200.472-2-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240906033200.472-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nlQz5mmP7YQ__PnCCt76GHs9BNOjUneg
X-Proofpoint-GUID: nlQz5mmP7YQ__PnCCt76GHs9BNOjUneg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170106

On 9/5/2024 8:31 PM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Currently ath11k call regulatory_set_wiphy_regd() in ath11k_regd_update()
> to notify the reg domain change to cfg80211 and update channel list by
> reg_work, then ath11k immediately update channel list to firmware by
> ath11k_reg_update_chan_list(). 
> 
> callstack:
> ath11k_regd_update
> ->regulatory_set_wiphy_regd
>            -> schedule_work(&reg_work)
> -> ath11k_reg_update_chan_list
> 
> They are running in two threads, it leads the channel list data out of
> sync caused by muti-threads without synchronization. At this time,
> ath11k may update wrong channel list to firmware because the reg_work
> still running or even hasn't started yet.
> 
> The correct flow is after reg_work update the channel list according to
> new reg domain, ath11k call ath11k_reg_update_chan_list() and update the
> new channel list to firmware.
> 
> reg_call_notifier()(finally it will call ath11k_reg_notifier()) will be
> called to by reg_work to notify ath11k when it finishes the channel
> list update. So at this time, call ath11k_reg_update_chan_list() in
> reg_call_notifier() with initiator type NL80211_REGDOM_SET_BY_DRIVER.
> Then ath11k_reg_update_chan_list() will use the correct channel list.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


