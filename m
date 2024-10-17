Return-Path: <linux-wireless+bounces-14168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF219A2A7F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 19:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51089B22684
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480151DF733;
	Thu, 17 Oct 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TxnGQBTZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057331DE3A9
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185188; cv=none; b=ro9zXnWRi9NmYPJq/BZc1zAuqecPdQbYBSUNSqAwJJDRZf+cJdZMSUkDoZBEXzU8eaC8IRWUIztHsPM30i/IzxAXSx0toBaGKrR35StOrCqUZg8saDVNi6kyWpjM5CTXLag/+Au7Ox3ux0OcOlYFNt4vBdRq7mrNUC0gZd0+mOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185188; c=relaxed/simple;
	bh=FJSjW9i2SP2zfeLw/qq9KM1sp+j535z1/7J1D5yBGMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A0RsHc24ThstL44geWZ0b55VXvTa1YN1ZwMfs9T2/3z86z3iRji6KQGd/Gqe7LdxdGFRAedwvsHIUiN4To6zGsr0qORpsRWTDLU6didD+6InPSg75UXk6hSmocP2bAZgDG9gUpUrFBXuXzBjgVfcVna0o5p50fkf3/70jy1B/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TxnGQBTZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7DvpH031181;
	Thu, 17 Oct 2024 17:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	800lOmiQCPGqV4f8tLRDW5O3pBiFFA5P8PuCp2HARog=; b=TxnGQBTZdyLqUhPG
	rhlXKATzad9N8qI+vgdcep2XxzPlr2exYLRaIdtqjZY89V7iCsVGbGXIUV0J+AO3
	YpRQBSuDwVvbtLStgYZOyB+WDcFT0kt6SGN/olWq82hD04p2/IEsWali30Hc4sxl
	B9BOua4ceqXxrWu1jeZnf8ORojgm+MB21tV2tJNCQ7tYOzMNA5/eaTjPqKuG6lzh
	PE+0yFQAbI0b5TiB2NZnXe3miQzuT1juS8A50wcae+eJJVhQZWvglY4bbkDJBd2U
	EJ8iNqIGawkv/1Llxq4+Oxn2kyeGoYrjtDBLV+IM+hTBK5hz7V1ABZZN9pF8oZgp
	IWEDpA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8nq5ewg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 17:12:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HHCtXM023853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 17:12:55 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 10:12:55 -0700
Message-ID: <d91e0fad-8ce5-4b2b-8fb3-9c6465a34d2a@quicinc.com>
Date: Thu, 17 Oct 2024 10:12:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Support MBSSID Control Frame Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sidhanta Sahu
	<quic_sidhanta@quicinc.com>
References: <20241005112651.3379404-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241005112651.3379404-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b9udJR6CtWUxIG2cAaCfboytucXd4NKx
X-Proofpoint-GUID: b9udJR6CtWUxIG2cAaCfboytucXd4NKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=867 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170117

On 10/5/2024 4:26 AM, Roopni Devanathan wrote:
> From: Sidhanta Sahu <quic_sidhanta@quicinc.com>
> 
> Add support to request MBSSID control frame stats from firmware
> through HTT stats type 54. These stats give information such as
> basic trigger, BSR trigger, multi-user RTS and uplink MUMIMO
> trigger within and across various BSS.
> 
> Note: WCN7850 firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
> support HTT stats type 54.
> 
> Sample output:
> -------------
> echo 54 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_MBSSID_CTRL_FRAME_STATS_TLV:
> mac_id = 0
> basic_trigger_across_bss = 0
> basic_trigger_within_bss = 0
> bsr_trigger_across_bss = 0
> bsr_trigger_within_bss = 0
> mu_rts_across_bss = 0
> mu_rts_within_bss = 0
> ul_mumimo_trigger_across_bss = 0
> ul_mumimo_trigger_within_bss = 0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
> Depends-on:
> [PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
> Link: https://lore.kernel.org/all/20241004085915.1788951-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
> Link: https://lore.kernel.org/ath12k/20241005101816.3314728-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2] wifi: ath12k: Support Pdev OBSS Stats
> Link: https://lore.kernel.org/ath12k/20241005104206.3327143-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2] wifi: ath12k: Support DMAC Reset Stats
> Link: https://lore.kernel.org/ath12k/20241005105207.3350790-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
> Link: https://lore.kernel.org/ath12k/20241005111506.3361688-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2 0/2] wifi: ath12k: Support AST and Puncture Stats
> Link: https://lore.kernel.org/ath12k/20241005112234.3379043-1-quic_rdevanat@quicinc.com/

This last dependency is being deferred since it conflicts with the MLO branch,
and hence this patch is also being deferred.

Since all of the other dependencies are now merged, if you rebase so that you
remove this last dependency (and verify you don't conflict with MLO) then this
patch could be processed.

/jeff


