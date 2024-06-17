Return-Path: <linux-wireless+bounces-9130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4690F90BB78
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 21:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B6D1C22819
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 19:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A62F510;
	Mon, 17 Jun 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gmzTtyRA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1118757C
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654155; cv=none; b=bRqV6EgwI4xFCX0O49C863BfmW8u9hQKdi2rt+dmBOftPZ5d2fCfGwtORj5U+Qsc2B+RYzVYXbJdtYyqg3cD/N9OiUuln+cUA/ROPZVQJG9lzBUSUkbemb1Fv1fVSpyNXoNQwQiMMs7uS/TXcQrAkCHBCCqOzZmbeqALUVfKM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654155; c=relaxed/simple;
	bh=QoYVkalE9APU3Y2SegfJ8liylC7C/vkDQV31i9MArso=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qFvRRHJFO3XHtJOgFyg1B6tYdtwQVZarOJ80XNQiDI4v2aigroguiWp44jA90Xw2Tv1QprJWdWrOxSeyg1oNXK/C0EKFQ1jYfq5lP0YBTrbfzM0DjiWnG6zL03kkO7nDSrw9cURwWFsU9swFbGT8SJsmp1fUuYx8WnRpbYc0ebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gmzTtyRA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HHwNsu014973;
	Mon, 17 Jun 2024 19:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CuVswXFHXWTi5e8DchogHfQo7934itdB+OvkV2FGV8k=; b=gmzTtyRAlvxIK/iz
	5nqGTNjNWU807m0px7iQsCa32TioSRotgXC0gPGTX8VdD2b52qfIRp28DWHMIM/Q
	P89G/zR3ni3e6epVSRUdy+omU+8JQyLGFLCIM+pRLR4zE4mUsCT76TOJa6SPDCCc
	L3k+FLtu4SOVbTaxHcBA6r7+UTVz3FU6ItPDCyCUXqOSv9CkfE6zAJ5IfhsAb2Xn
	LMmOoGToeKfB20CdIWyH4SwQDvjzQaqLsMuAfwvL2JYoiMHy/hvD940UxrsJaAPd
	W/UCPXGrxcQeuN8aXdipR6Q5Yl83PagGutbSsSSnrjSmHMJ4phqQpO8NEIqf6jzY
	8LRuMw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytt0tr7y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:55:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HJtmb6013609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:55:48 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 12:55:48 -0700
Message-ID: <bbacb79d-40cb-4ad6-ae4e-b68aa329e15e@quicinc.com>
Date: Mon, 17 Jun 2024 12:55:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth
 support
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240612234209.2324181-1-quic_pradeepc@quicinc.com>
 <0c17fa05-f9c5-4aa1-bede-6dbb17a754e2@quicinc.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <0c17fa05-f9c5-4aa1-bede-6dbb17a754e2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bRZMdpRsFt5aDj8MHk8V3Q-Ij_fh0yfk
X-Proofpoint-GUID: bRZMdpRsFt5aDj8MHk8V3Q-Ij_fh0yfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170153



On 6/17/2024 11:46 AM, Jeff Johnson wrote:
> On 6/12/2024 4:42 PM, Pradeep Kumar Chitrapu wrote:
>> Add support for
>> 1. enabling MU-MIMO in HE and EHT modes from hardware
>> 2. setting fixed HE rate/GI/LTF
>> 3. 160 MHz bandwidth in HE mode
>> 4. extended NSS bandwidth support
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> changes in v7:
>>   - rebase and remove patch 01/10 which was merged already.
>>
>> changes in v6:
>>   - Change comment in patch 01/10 to represent only AP mode
>>     implementation.
>>
>> changes in v5:
>>   - Fix column length to 80 in patch 01/10
>>   - Fix advertises spelling in patch 09/10
>>   - Fix choosing spelling in patch 10/10
>>
>> changes in v4:
>>   - Fix ath12k-check warnings in patch 2/10 and 7/10
>>   - remove "hostapd" reference in patches 2/10 and 3/10
>>   - remove redundant prerequisite-patch-id's in cover letter
>>
>> changes in v3:
>>   - address review comments for fixing ath12k-check issues.
>>
>> changes in v2:
>>   - Amend mac80211 patch description as the patch is not specific
>>     to AP mode.
>>   - Amend EHT MU-MIMO patch description to specify future support
>>     for STA mode.
>>
>> Pradeep Kumar Chitrapu (9):
>>    wifi: ath12k: push HE MU-MIMO params to hardware
>>    wifi: ath12k: push EHT MU-MIMO params to hardware
>>    wifi: ath12k: move HE MCS mapper to a separate function
>>    wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
>>    wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
>>    wifi: ath12k: add support for setting fixed HE rate/GI/LTF
>>    wifi: ath12k: clean up 80P80 support
>>    wifi: ath12k: add support for 160 MHz bandwidth
>>    wifi: ath12k: add extended NSS bandwidth support for 160 MHz
>>
>>   drivers/net/wireless/ath/ath12k/core.h |    2 +
>>   drivers/net/wireless/ath/ath12k/mac.c  | 1052 ++++++++++++++++++++----
>>   drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>>   drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
>>   drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
>>   5 files changed, 985 insertions(+), 208 deletions(-)
>>
>>
>> base-commit: e72048809ec7355a947415ae6836d2eb7fdcda39
> 
> This series produces the following warnings when applied to ath-202406171110
> 
> In function 'ath12k_peer_assoc_h_he',
>      inlined from 'ath12k_peer_assoc_prepare' at drivers/net/wireless/ath/ath12k/mac.c:2951:2:
> drivers/net/wireless/ath/ath12k/mac.c:2357:21: warning: 'ath12k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
>   2357 |                 v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
>        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/mac.c:2357:21: note: referencing argument 2 of type 'const u16[8]' {aka 'const short unsigned int[8]'}
> drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_peer_assoc_prepare':
> drivers/net/wireless/ath/ath12k/mac.c:2139:12: note: in a call to function 'ath12k_peer_assoc_h_he_limit'
>   2139 | static u16 ath12k_peer_assoc_h_he_limit(u16 tx_mcs_set,
>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function 'ath12k_peer_assoc_h_he',
>      inlined from 'ath12k_peer_assoc_prepare' at drivers/net/wireless/ath/ath12k/mac.c:2951:2:
> drivers/net/wireless/ath/ath12k/mac.c:2370:21: warning: 'ath12k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
>   2370 |                 v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
>        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/mac.c:2370:21: note: referencing argument 2 of type 'const u16[8]' {aka 'const short unsigned int[8]'}
> drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_peer_assoc_prepare':
> drivers/net/wireless/ath/ath12k/mac.c:2139:12: note: in a call to function 'ath12k_peer_assoc_h_he_limit'
>   2139 | static u16 ath12k_peer_assoc_h_he_limit(u16 tx_mcs_set,
>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function 'ath12k_peer_assoc_h_he',
>      inlined from 'ath12k_peer_assoc_prepare' at drivers/net/wireless/ath/ath12k/mac.c:2951:2:
> drivers/net/wireless/ath/ath12k/mac.c:2370:21: warning: 'ath12k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
>   2370 |                 v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
>        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/mac.c:2370:21: note: referencing argument 2 of type 'const u16[8]' {aka 'const short unsigned int[8]'}
> drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_peer_assoc_prepare':
> drivers/net/wireless/ath/ath12k/mac.c:2139:12: note: in a call to function 'ath12k_peer_assoc_h_he_limit'
>   2139 | static u16 ath12k_peer_assoc_h_he_limit(u16 tx_mcs_set,
>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
Thanks Jeff, ath12k-check issues must be resolved on V3..
Let me check and confirm and fix any issues and resubmit V8


