Return-Path: <linux-wireless+bounces-3970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDC5861B33
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 19:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8FB286B45
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B62212BEAE;
	Fri, 23 Feb 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dG8KTtsU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37B12AAD7
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711872; cv=none; b=CVrhLnjzvsoEwX+F8Ki7PuQrjyzYcZGAp+1jWmHOAZrvUm5rgnYgXVTySDlHat1ZopigXGRyrFZRn+1xe3joo59kmOOmIEd0m8RZ6bZqBwl/0AeoMdkv9MxR/6p8kYiNVXQE63YeJQq0q/4GPru609hvL0+FJzWxBpInArmNx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711872; c=relaxed/simple;
	bh=jxd8FKTEhZjFpTZUvG3yGXBd9N2fYeucKGF4NlAscoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A5vtkLgLbwpLXQMu4rEzs6+mLshTMvzAAvyC9dLi+4plyDor7xsW5ma33E+hR8C3jN1skZcnaHErrbcwIhmonvdowACcxEldLyHbnyfVkJSDpEzwPDRmFJgwLyc0G/EqpML4M6vQYOU3ETslUSAwrdby+Tbeq/5t2TvsyMX4Ve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dG8KTtsU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N6wkl4025091;
	Fri, 23 Feb 2024 18:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4veztuq0nbr+6eP96SMUiNpeVsWoA09x4TohJonoSk0=; b=dG
	8KTtsUFoXFErX2VODxchl6CO0DB2mPZA89Nl6rxtyIlXmYE26ONDklIp4vOA/3zH
	FHHxPt30xMt+JvZzRDgqUQje9xqI4/4Vwf2KErK25+eBfAVU2T7GO7i7qpscMhLR
	ozcNhPPrLB6eR5/rt9WllwefDX2bxWipaPn4odEfc1llnXFqXbgXKJ4rZLf0Xnm1
	tyj82rdeup7jJlOwmgMjRxVxXYDXS8EWJyvHSEbVruXmO9ak4KGpRF/sRTOnPfOe
	LoOndOd3SrTUuvbhgGktkGxED5mKqqoj/m99dHFMHLJVKemlqwJS4wqMWIvFtRhN
	g9FTfAI3Dkpp8+52q9vQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weg88t7jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 18:11:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NIB0LH012195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 18:11:00 GMT
Received: from [10.110.104.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 10:11:00 -0800
Message-ID: <f9e4b895-cf77-49a9-951b-05118ff5f633@quicinc.com>
Date: Fri, 23 Feb 2024 10:10:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: add rcu lock for ath12k_wmi_p2p_noa_event()
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240223054505.438839-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240223054505.438839-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vazHD-7QDz4mfzOlSwSNqtvoJZOyeMch
X-Proofpoint-GUID: vazHD-7QDz4mfzOlSwSNqtvoJZOyeMch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_04,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=696
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230133

On 2/22/2024 9:45 PM, Kang Yang wrote:
> Warning will appear when running P2P GO:
> 
> WARNING: suspicious RCU usage
> drivers/net/wireless/ath/ath12k/mac.c:583 suspicious rcu_dereference_check() usage!
> other info that might help us debug this:
> rcu_scheduler_active = 2, debug_locks = 1
> no locks held by swapper/0/0.
> stack backtrace:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc4-wt-ath+ #4
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x82/0xa0
>  dump_stack+0x14/0x20
>  lockdep_rcu_suspicious+0x214/0x3b0
>  ath12k_mac_get_ar_by_vdev_id+0x192/0x220 [ath12k]
>  ath12k_wmi_op_rx+0x2d7/0x1b40 [ath12k]
> 
> ath12k_mac_get_ar_by_vdev_id() requires its callers to have called
> rcu_read_lock(), but in ath12k_wmi_p2p_noa_event() it is called without
> doing so, and hence the warning was triggered.
> 
> Add rcu_read_lock() and rcu_read_unlock() to avoid warning.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 9411eecb60cb ("wifi: ath12k: implement handling of P2P NoA event")
> Reported-by: Kalle Valo <quic_kvalo@quicinc.com>
> Closes: https://lore.kernel.org/linux-wireless/87o7cusyvw.fsf@kernel.org/
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


