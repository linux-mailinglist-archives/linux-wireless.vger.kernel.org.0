Return-Path: <linux-wireless+bounces-6299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814308A47B3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 07:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E40282BC6
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A194D5672;
	Mon, 15 Apr 2024 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vg6ubj8o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1732F5234
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713160294; cv=none; b=u1HCGzIJpWjK0ZaCoLqWfc1rx/Lxm16xC5jVLfbf6CF6fhW0/gNyFsrAwVPZBD7ISOGPoz3wzB6UevJkuCeZ/8I2pQac/ugPMD/QD6wMJ2+6OcqVhCCoyHV/YmITbS1ttMpeSnMpYRckVjLivrPS6Qg6jBQWpizs0EXiOzYbth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713160294; c=relaxed/simple;
	bh=OTWxRHt8QwWgTqCXncnzTirlCDGmERppaIa2f6JBMaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QH1OZDmLh8p+5DVKtFewwHRo66/pHdv4CCSVL4KoJY3KIbj+mAlSQOoklcSIijPPBI1dXETFUowKOuyNIVtzJiyKS0AVXFs5KMRBc5l8A+Fjo0C7xdND0A4xnv1TuMeE2UUPVj/3AWNZl5z2qMkwwyvRNCet/NYjWu/unuTWhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vg6ubj8o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F3wbcU010411;
	Mon, 15 Apr 2024 05:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=w5+tUN4C4jg3ZaTthoSN+BkkmuK9D3uVFpoJmF2w3Bw=; b=Vg
	6ubj8o8pq/kAvhH0vn60nkhRFiGcGuhNwiISQTQIABHxDofs2C7tdYzfsQf1+IEt
	S2iRpGZ9c9bvPl0TI4vN/lMiqzIqubucpDfasLCYZp+tDnjKnL72hXMVpmcNuR6X
	IIl8F80IfsCkWsHs7Of8j85/+BMcct6LqRuQxW8NYrPuh/pMHzd9JApBTpHGmHj0
	NpdLsK6DmjEr+33GfFgmIW+cdTwecmn7UsFH3N9TgwvTAyYcvDu0ytRGzYaxUEpo
	0TZtbQ/Hs5GNKddj316lEWW9j3BkG5aN8+YRIIHi7RqTQdwYXfSPvN7PhEVhkLQ9
	16bdg5sZPNDEkwoMXCnw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfkbdjtqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 05:51:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43F5pTGR022710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 05:51:29 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Apr
 2024 22:51:27 -0700
Message-ID: <76ef11b2-c477-ff11-df72-e8d934c00831@quicinc.com>
Date: Mon, 15 Apr 2024 13:51:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/10] wifi: ath12k: support suspend/resume
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TuFSr1x7ZQfxrAUHdds4go3yNf-e-xCD
X-Proofpoint-GUID: TuFSr1x7ZQfxrAUHdds4go3yNf-e-xCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150035


On 4/13/2024 2:05 AM, Jeff Johnson wrote:
> On 4/11/2024 11:06 PM, Baochen Qiang wrote:
>> Now that the MHI&QRTR patches [1] are merged, we can add
>> suspend/resume support for ath12k.
>>
>> The whole design is quite similar to that in ath11k: firmware
>> is powered down when going to suspend and powered up when
>> resume, this makes hibernation work as well in addition to
>> suspend.
>>
>> To summary, this series first does some preparations in the
>> first 8 patches. Then in patch [9/10] suspend/resume callbacks
>> are implemented. And at last in [10/10] we enable suspend/resume
>> functionality for WCN7850 because it's the only chip supporting
>> it for now.
>>
>> [1] https://lore.kernel.org/linux-wireless/20240305021320.3367-1-quic_bqiang@quicinc.com/
>>
>> Baochen Qiang (10):
>>   wifi: ath12k: rearrange IRQ enable/disable in reset path
>>   wifi: ath12k: remove MHI LOOPBACK channels
>>   wifi: ath12k: do not dump SRNG statistics during resume
>>   wifi: ath12k: fix warning on DMA ring capabilities event
>>   wifi: ath12k: decrease MHI channel buffer length to 8KB
>>   wifi: ath12k: flush all packets before suspend
>>   wifi: ath12k: no need to handle pktlog during suspend/resume
>>   wifi: ath12k: avoid stopping mac80211 queues in ath12k_core_restart()
>>   wifi: ath12k: support suspend/resume
>>   wifi: ath12k: change supports_suspend to true for WCN7850
>>
>>  drivers/net/wireless/ath/ath12k/core.c  | 108 ++++++++++++++----------
>>  drivers/net/wireless/ath/ath12k/core.h  |   4 +
>>  drivers/net/wireless/ath/ath12k/dp_rx.c |  48 -----------
>>  drivers/net/wireless/ath/ath12k/dp_rx.h |   2 -
> My Qualcomm Innovation Center copyright checker reports:
> drivers/net/wireless/ath/ath12k/dp_rx.h copyright missing 2024
Got it.
>
>>  drivers/net/wireless/ath/ath12k/hif.h   |  14 ++-
>>  drivers/net/wireless/ath/ath12k/hw.c    |   2 +-
>>  drivers/net/wireless/ath/ath12k/mac.c   |  28 ++++--
>>  drivers/net/wireless/ath/ath12k/mac.h   |   1 +
>>  drivers/net/wireless/ath/ath12k/mhi.c   |  91 +++++++-------------
>>  drivers/net/wireless/ath/ath12k/mhi.h   |   5 +-
>>  drivers/net/wireless/ath/ath12k/pci.c   |  41 +++++++--
>>  drivers/net/wireless/ath/ath12k/pci.h   |   2 +-
>>  drivers/net/wireless/ath/ath12k/qmi.c   |   3 +-
>>  drivers/net/wireless/ath/ath12k/wmi.c   |   1 +
>>  14 files changed, 175 insertions(+), 175 deletions(-)
>>
>>
>> base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
> patch 6 of this series conflicts with:
> wifi: ath12k: add support to handle beacon miss for WCN7850
>
> So I was not able to take this series into my local verification tree
>
> patch 7 of this series conflicts with:
> wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path
>
> So this conflicts with a patch already in the pending branch
>
> So FYI at some point you'll need to rebase.

So I should rebase after these two patches got merged in master branch?


