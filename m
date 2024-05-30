Return-Path: <linux-wireless+bounces-8323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63328D5173
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 19:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116DF2894C5
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 17:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726AC225D7;
	Thu, 30 May 2024 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VWQHWtHl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547246B91
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091151; cv=none; b=Y/fiAO8mr6CWnKsVBYTK2tZIul82m/X2EwP+FbBZEch1bpaXkUWD1DjeUq7ELNWUP9l+rEXwzaXC8cijw1eWzA7WGB7AfVIh7VqYD+JDhhHlUKA4r+68OlB42h0iveFKViCPFzBE1xd10hvwl0U4LgXWEpEBjzWRPZtgdTOAICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091151; c=relaxed/simple;
	bh=LYWB7Ixo/Wr8/GCNmUE5ue0+R2uIASOvu8V/y7Sk+sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OQxBbjxhr6HTjOA3sOA9+1ZNOKfSulBbc9TeOYQTlA2WGeSMpklj9PcOgg9d0dDKlwrKMaNaCc8BRJNDJMy8HdGn2fkfUII1jj1JjobEOWd/EA1fnHO15s4q7pzvjSWp6V8eEwSXjUPRA7xE4qVrUkoULpHk9mgi9XagI73G3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VWQHWtHl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UGs35V016256;
	Thu, 30 May 2024 17:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hqp7b5gbPUCb7BDBFGZkeznY8F+QiHQQD47HaDihL2U=; b=VWQHWtHlUg17SFV8
	tpbqA4MpggsKVsby/EUOk5W6VDdsKCkntuiTmLI1/gS5OE6kf9ECnwXC6W/pTNus
	D21yJKKjsY2xcnOlRRgYEoG9mEm981zP6uVxQ2XGSojBjBE/ItqW1jfb3wdqfA15
	zHt4X/6Gdw1U6O8T8ICDg4BKKHBHQNZZ3JzQlkfyK5Ra5+edX9a9zrz3nGrC9Iz2
	HWNpdVfuYNMcPE4c0ss6lQ4EMVul2iouPd463ppQqvEGcgLjBg9ts5He/V3JLLvR
	5JyxCs9jaYz/ScBM7w4BgmiYePzYGOUOCShlW0rdhz7jZXHaVqfUmab+CZyj/yXC
	AO4ijA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2nmt6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 17:45:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UHjhN4008552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 17:45:43 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 10:45:42 -0700
Message-ID: <cb66c4b2-eb8b-4698-bc31-1c0410c81588@quicinc.com>
Date: Thu, 30 May 2024 10:45:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] wifi: ath12k: add support for WoW
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240530072714.25671-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1rjXjWoqT08SEwotlQCJ_vSf5Bdg41LR
X-Proofpoint-GUID: 1rjXjWoqT08SEwotlQCJ_vSf5Bdg41LR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=892 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405300132

On 5/30/2024 12:27 AM, Baochen Qiang wrote:
> Add support for WoW (Wakeup on Wireless) funtionalities, this including
> magic-pattern, net-detect, disconnect and patterns, HW data filter, ARP
> and NS offload, GTK rekey offload.
> 
> Also enable keepalive before suspend to avoid unexpected kick out by AP.
> 
> v3:
>  - wifi: ath12k: add ATH12K_DBG_WOW log level
> 	1. new addition.
>  - wifi: ath12k: support ARP and NS offload
> 	1. move ipv6 infomation parse to ath12k_wow_arp_ns_offload() to
> 	   avoid memory leak issue.
> 	2. move ARP/NS related definition from core.h to wmi.h
> 	3. rename ath12k_arp_ns_offlaod to wmi_arp_ns_offload_arg
> 	4. rename some macros
>  - wifi: ath12k: support GTK rekey offload
> 	1. add rcu_read_lock/unlock in ath12k_wmi_gtk_offload_status_event()
> 
> 
> v2:
>  - [2/7] wifi: ath12k: add basic WoW functionalities
>         1. In ath12k_wow_convert_8023_to_80211(), change to use 'size_t'
>            instead of 'int' to make GCC happy
>  - [5/7] wifi: ath12k: support ARP and NS offload
>         1. In ath12k_mac_arvif_get_arp_ns_offload(), change to use
>            GFP_ATOMIC to fix kernel crash due to sleep in invalid context
>  - rebased on ToT
> 
> Baochen Qiang (8):
>   wifi: ath12k: add ATH12K_DBG_WOW log level
>   wifi: ath12k: implement WoW enable and wakeup commands
>   wifi: ath12k: add basic WoW functionalities
>   wifi: ath12k: add WoW net-detect functionality
>   wifi: ath12k: implement hardware data filter
>   wifi: ath12k: support ARP and NS offload
>   wifi: ath12k: support GTK rekey offload
>   wifi: ath12k: handle keepalive during WoWLAN suspend and resume
> 
>  drivers/net/wireless/ath/ath12k/Makefile |    1 +
>  drivers/net/wireless/ath/ath12k/core.c   |   48 +-
>  drivers/net/wireless/ath/ath12k/core.h   |   20 +
>  drivers/net/wireless/ath/ath12k/debug.h  |    1 +

My Qualcomm Innovation Center copyright checker reports:
drivers/net/wireless/ath/ath12k/debug.h copyright missing 2024

>  drivers/net/wireless/ath/ath12k/htc.c    |    6 +
>  drivers/net/wireless/ath/ath12k/mac.c    |  110 +++
>  drivers/net/wireless/ath/ath12k/mac.h    |    4 +
>  drivers/net/wireless/ath/ath12k/wmi.c    |  720 +++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h    |  578 ++++++++++++
>  drivers/net/wireless/ath/ath12k/wow.c    | 1012 ++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wow.h    |   62 ++
>  11 files changed, 2554 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/wow.h
> 
> 
> base-commit: 2580be9ee6f5d97d6763b5d4ae4f9c0383fdf130


