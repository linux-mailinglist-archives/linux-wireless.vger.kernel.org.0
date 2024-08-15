Return-Path: <linux-wireless+bounces-11497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2077953961
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 19:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A171C2296A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2C4AEE0;
	Thu, 15 Aug 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l8pULNb9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C552F70
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743797; cv=none; b=jumW2SWZUY8cRP7Go4xlW+lsOO+Ks/WG5imsBratBE/75TF+9m+86cJ38rfZOLmvQB6G8saDNlCN2MfybTPpohSCfT8IyDHViQhvZkAk8Ab1CpOlAHMQOfuCY6/+Xu5owXHtbnyg90Jo5Afheyz1D5opAaPw7Yci++lfR2D1QSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743797; c=relaxed/simple;
	bh=Fw0aVYsUrnbaPkgclFP3+g5LLOu0UpBlKbkPnh9OEK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sUPTN3P/F4HQ16hlW8pOKIY94eytO5rk5zaZYxE4kiMqdyQJmoqC/2g69YfOZAQNbHaqg1IcqayTO4bSvr4lddV5DLeJhblm/16WNXD8Qpg8dhgTtLfK53ZvwlyBCU7+6ZAdR+r8Qnm1n8/1DHnx40CaChdwxc3rK4G7lyK/IbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l8pULNb9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FBQWUR016519;
	Thu, 15 Aug 2024 17:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YU6l76peEOp8nvrzVe7v+0EcAYbfKcRMcNVu2KltyXA=; b=l8pULNb9Z3egNXiC
	FP99yp+9jC6JZfNQ1q/DBmDTMEIpggjfaS3L6FnyuVdqCseBdQ1lTt5RxEJqfsQF
	caYvM+9DoFl+HW76Dq/RxiLOLurnOhXZandTMGWfJtWnWeNNeV2+U1w6jYJkwSTS
	xi0z0+WOlheJrecffO3MLttcyK/I6VAeGiDc6rUsdkdoK/TG5618/GYxKdraxUrt
	qb6BSy2dYw8EJnlSrODqk11RWvRQaAkqSZYKC67tb1qIQk0YsAGuCWGYRufz1Y/3
	1uy6ZN77BlYTkjUaAhRe/vvcsHV5MwtdAHrl9x4gD4OFtk88v37vjpouna37W9lS
	0v/xhA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41134ejj2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 17:42:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47FHgvhT013319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 17:42:58 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 Aug
 2024 10:42:57 -0700
Message-ID: <9809b165-8d25-4984-a1dd-6fca28f1dda9@quicinc.com>
Date: Thu, 15 Aug 2024 10:42:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: cfg80211: Set the channel definition for the
 different Wi-Fi modes when starting CAC
To: Issam Hamdi <ih@simonwunderlich.de>, <kvalo@kernel.org>
CC: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <lkp@intel.com>, <llvm@lists.linux.dev>,
        <mathias.kretschmer@fit.fraunhofer.de>,
        <oe-kbuild-all@lists.linux.dev>
References: <87jzgiyxob.fsf@kernel.org>
 <20240815113213.3237491-1-ih@simonwunderlich.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240815113213.3237491-1-ih@simonwunderlich.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C34UADG99p0aQXKFmQJscYmpx-yKH_2v
X-Proofpoint-GUID: C34UADG99p0aQXKFmQJscYmpx-yKH_2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_10,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=203 clxscore=1011 mlxscore=1 spamscore=1 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150129

On 8/15/2024 4:32 AM, Issam Hamdi wrote:
> When starting CAC in a mode other than AP mode, it return a
> "WARNING: CPU: 0 PID: 63 at cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]"
> caused by the chandef.chan being null at the end of CAC.
> 
> Solution: Ensure the channel definition is set for the different modes
> when starting CAC to avoid getting a NULL 'chan' at the end of CAC.
> 
>  Call Trace:
>   ? show_regs.part.0+0x14/0x16
>   ? __warn+0x67/0xc0
>   ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
>   ? report_bug+0xa7/0x130
>   ? exc_overflow+0x30/0x30
>   ? handle_bug+0x27/0x50
>   ? exc_invalid_op+0x18/0x60
>   ? handle_exception+0xf6/0xf6
>   ? exc_overflow+0x30/0x30
>   ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
>   ? exc_overflow+0x30/0x30
>   ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
>   ? regulatory_propagate_dfs_state.cold+0x1b/0x4c [cfg80211]
>   ? cfg80211_propagate_cac_done_wk+0x1a/0x30 [cfg80211]
>   ? process_one_work+0x165/0x280
>   ? worker_thread+0x120/0x3f0
>   ? kthread+0xc2/0xf0
>   ? process_one_work+0x280/0x280
>   ? kthread_complete_and_exit+0x20/0x20
>   ? ret_from_fork+0x19/0x24
> 
> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
> Signed-off-by: Kretschmer Mathias <mathias.kretschmer@fit.fraunhofer.de>

who is this and why is their S-O-B here?
the last S-O-B should be the person who last touched the patch, which is you

please see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

