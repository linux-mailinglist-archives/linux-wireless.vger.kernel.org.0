Return-Path: <linux-wireless+bounces-16923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B639FEBA9
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 00:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920641882F68
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 23:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96719CC29;
	Mon, 30 Dec 2024 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hm8HkZZZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12438199EB0
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735601565; cv=none; b=dFKB4V26cvHJzNiIX7EGieYq1CWA/MrowX8AeyCyAYbcxuzIRDpUZuwBTpVgwTvTSBeId1WdinKlJiesdF2NblQoMwZcH7LTWZVipdrOzo/FMAUJ41T0jQonzwNOrLexcnnBjkZgPl5YDxybmHv0JynAdPP2Tr5uUs4ISlcZ/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735601565; c=relaxed/simple;
	bh=qenp8J8QtyCl8ybQiGc3OVS6EMiltrx78iFh4y3ce0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jDRSXnNCuLWoFOGhTUXX0T/9Nd+rQzucHijuE+GaSV99V6H9uqi4VS8Z1tuFrwKCWJAz1Q3rs5sM24PwljbWYxTp9MisC0zSxwuONyqAy+lDD09Ti3LRPWLnfztAmorxhyDraz4sC8bd6J7xONiImmzAE2PDFFV8Bh0KHRK3SXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hm8HkZZZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU9LGTj024765;
	Mon, 30 Dec 2024 23:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gF2oit23BqN+ZuEYMmkrbqJQNU/DCDWsR/0uILwAslA=; b=Hm8HkZZZz23RBAcH
	mFg1IbYGxY7FmwhvN7akYUR/UFx5LMv7fgMT025KRwVVkwtAt/3P5qmwqkCe+fJ2
	th3mHGu9nCFC2uHczQ/BXckWBvdfZ1YL5ohCl5evoqnTt/aivpX0rRifg8EB1LK2
	ThKr0j4xHw1SdY1JAZsgFQZtkeupkmaDrOZNbG3csHJ9mX1N2e5OjRBz9l5I0DhG
	sNyYCPQIrbJNmzkGEwAtKqXti/6lSYYIUqQ5DlKUeYZidaVAollG+R1J9a/c++WK
	6yGksoDig0OHqrH5wQ6WEQ1AE8LQwVLyL0zCCaQAZsi4+LHaywM6iKbpuxROuKRH
	LBaBOg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43urt89ktv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 23:32:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BUNWd8x025756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 23:32:39 GMT
Received: from [10.111.179.20] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Dec
 2024 15:32:39 -0800
Message-ID: <63f53058-3fd1-4e95-82d3-9c1bb1fdfa5b@quicinc.com>
Date: Mon, 30 Dec 2024 15:32:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] wifi: ath12k: some fixes and clean up for
 monitor mode
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241017031056.1714-1-quic_kangyang@quicinc.com>
 <9a928610-aa89-40e6-b5fd-0dd8cf5a3a3d@quicinc.com>
 <f42041c6-bc6d-4b0a-b25c-a3656a55fd2d@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <f42041c6-bc6d-4b0a-b25c-a3656a55fd2d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S8ndM5hQNNi10C7jVoJC-YSSBOqrMf45
X-Proofpoint-ORIG-GUID: S8ndM5hQNNi10C7jVoJC-YSSBOqrMf45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412300202

On 12/23/2024 6:55 PM, Kang Yang wrote:
> 
> 
> On 10/18/2024 4:43 AM, Jeff Johnson wrote:
>> On 10/16/2024 8:10 PM, Kang Yang wrote:
>>> This patch set does some fixes and clean up for monitor mode.
>>>
>>> v4: rebase on tag: ath/main(ath-202410161539).
>>> v3: rebase on tag: ath/main(ath-202410111606).
>>> v2: rebase on tag: ath-202410072115.
>>>
>>> Kang Yang (11):
>>>    wifi: ath12k: remove unused variable monitor_present
>>>    wifi: ath12k: optimize storage size for struct ath12k
>>>    wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
>>>    wifi: ath12k: fix struct hal_rx_ppdu_start
>>>    wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
>>>    wifi: ath12k: fix struct hal_rx_mpdu_start
>>>    wifi: ath12k: properly handling the state variables of monitor mode
>>>    wifi: ath12k: delete NSS and TX power setting for monitor vdev
>>>    wifi: ath12k: use tail MSDU to get MSDU information
>>>    wifi: ath12k: fix A-MSDU indication in monitor mode
>>>    wifi: ath12k: delete mon reap timer
>>>
>>>   drivers/net/wireless/ath/ath12k/core.c   |   5 ++
>>>   drivers/net/wireless/ath/ath12k/core.h   |  23 +++--
>>>   drivers/net/wireless/ath/ath12k/dp.c     |  25 ------
>>>   drivers/net/wireless/ath/ath12k/dp_mon.c | 107 +++++++++++++----------
>>>   drivers/net/wireless/ath/ath12k/hal_rx.h |  53 ++++++-----
>>>   drivers/net/wireless/ath/ath12k/mac.c    |  24 +++--
>>>   6 files changed, 115 insertions(+), 122 deletions(-)
>>>
>>>
>>> base-commit: fa934bf3e0a825ee09f035c6580af513187d59a2
>>
>> This series looks ok to me, but it conflicts with the MLO branch so I'll defer
>> this until the MLO branch is merged. Note that some of these fixes may not
>> conflict, so feel free to submit ones that don't conflict as individual patches.
> 
> Hi, jeff, MLO branch is merged, and 8/11 of this patch-set are merged. 
> So how should i send the reset part? From v5, or from v1?
> 
Use v5 and comment about the patches that have already been merged


