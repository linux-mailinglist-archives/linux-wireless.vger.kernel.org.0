Return-Path: <linux-wireless+bounces-10836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC15945289
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 20:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FEA1F22F0B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A9148837;
	Thu,  1 Aug 2024 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o+CH3zrJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE8F143883;
	Thu,  1 Aug 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535481; cv=none; b=dp8305lr8fwk7hj6aAz964ywYnww9qohVlt+6IORw5ho0fIXLfjmI8I/uCiyUIhaH8iNxDt5Yv4jMNZpgpJ/eAsW3dFLsJeWzzyoHuZ2wTZgEFZFn2JCL0d1f6IXydcCOVLMWhJnEqy6V+OIyBL3QtF6am12f/DCJIzygkuUVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535481; c=relaxed/simple;
	bh=cH5O8QiIh1LNhgdV3UtAkZi6YOaIQekGxk6tJCmeQsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RJ5a1uX7SmVLPqljWBDRbwlvlW6fHpvcNAsVLQzY88wh9JmZApM8UYVz2v4pu0hwwgkj//yNEhk0gnYaF6+SyU0zrTx4+Oa/ownXQUwd+1opIBUoUg5/+YfnM+klyGspOK3WSIac67NID/SLacwlc/ujsUcH1ohOpFKgAw7PyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o+CH3zrJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471DaXRd009760;
	Thu, 1 Aug 2024 18:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F7t5aVOhj6Q1ibrEd1qk710pa7WF0I6LbO14rBFk+Ro=; b=o+CH3zrJXFqiMuv8
	12DGJciphGdirFpRecfOq5sQNDdeDJQjzaJW9c2qr2XmT5sSMVrYcRNOl2+nHGsc
	HC+6LWNpH89MCgER37v+dojmjmmCh94v9ypYop4z7yHQAmyvvwY8JA8pvOvBQrKb
	fa5LE6Q8mGAdUOUrSJTaDGYVsMPt+G4PUZaE7cbrLS6AjG9nbzcBaA7BnyGZqdSi
	5reOO4hkz+sB5+/xzqcXceM9SVg7phodu/rb6REmRzzHFuwEjiOLJqgLm65yu69d
	2hBnQrv/BiWXsFQUjX9rHXuw1WAV2cf9HmuTbbc2fWCbppamU0sERWbNVpnBUCxz
	wqOjaA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qugakmg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 18:04:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 471I4MMd014399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 18:04:22 GMT
Received: from [10.111.177.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 11:04:19 -0700
Message-ID: <90077fb2-42e0-42ab-b5a1-b4b73ff201d5@quicinc.com>
Date: Thu, 1 Aug 2024 11:04:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit path
 for WCN7850
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <kernel@quicinc.com>, <netdev@vger.kernel.org>
References: <20240715023814.20242-1-quic_bqiang@quicinc.com>
 <87ed788enl.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87ed788enl.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V9qNnuJ1iNOVT6vWZzAeZ3Q2VeC-fxPx
X-Proofpoint-ORIG-GUID: V9qNnuJ1iNOVT6vWZzAeZ3Q2VeC-fxPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_16,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408010119

On 8/1/2024 8:07 AM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> In transmit path, it is likely that the iova is not aligned to PCIe TLP
>> max payload size, which is 128 for WCN7850. Normally in such cases hardware
>> is expected to split the packet into several parts in a manner such that
>> they, other than the first one, have aligned iova. However due to hardware
>> limitations, WCN7850 does not behave like that properly with some specific
>> unaligned iova in transmit path. This easily results in target hang in a
>> KPI transmit test: packet send/receive failure, WMI command send timeout
>> etc. Also fatal error seen in PCIe level:
>>
>> 	...
>> 	Capabilities: ...
>> 		...
>> 		DevSta: ... FatalErr+ ...
>> 		...
>> 	...
>>
>> Work around this by manually moving/reallocating payload buffer such that
>> we can map it to a 128 bytes aligned iova. The moving requires sufficient
>> head room or tail room in skb: for the former we can do ourselves a favor
>> by asking some extra bytes when registering with mac80211, while for the
>> latter we can do nothing.
>>
>> Moving/reallocating buffer consumes additional CPU cycles, but the good news
>> is that an aligned iova increases PCIe efficiency. In my tests on some X86
>> platforms the KPI results are almost consistent.
>>
>> Since this is seen only with WCN7850, add a new hardware parameter to
>> differentiate from others.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> [...]
> 
>> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> @@ -162,6 +162,60 @@ static int ath12k_dp_prepare_htt_metadata(struct sk_buff *skb)
>>  	return 0;
>>  }
>>  
>> +static void ath12k_dp_tx_move_payload(struct sk_buff *skb,
>> +				      unsigned long delta,
>> +				      bool head)
>> +{
>> +	unsigned long len = skb->len;
>> +
>> +	if (head) {
>> +		skb_push(skb, delta);
>> +		memmove(skb->data, skb->data + delta, len);
>> +		skb_trim(skb, len);>> +	} else {
>> +		skb_put(skb, delta);
>> +		memmove(skb->data + delta, skb->data, len);
>> +		skb_pull(skb, delta);
>> +	}
>> +}
> 
> I'm nitpicking, but usually booleans like the head variable here don't
> help with readability. Having two separate functions would be easier to
> read, but this is fine as it's so small.
> 
>> @@ -279,6 +334,23 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
>>  		goto fail_remove_tx_buf;
>>  	}
>>  
>> +	if (iova_mask &&
>> +	    (unsigned long)skb->data & iova_mask) {
>> +		ret = ath12k_dp_tx_align_payload(ab, &skb);
>> +		if (ret) {
>> +			dev_warn_once(ab->dev, "failed to align TX buffer %d\n", ret);
> 
> Why dev_warn_once()? I changed it to ath12k_warn() in the pending
> branch.

My concern was that if this is an ongoing issue that you'd end up spamming the
kernel log. But I guess the rate limiting will reduce the spam to no more than
10 logs in a 5 second interval

> 
>> --- a/drivers/net/wireless/ath/ath12k/hw.h
>> +++ b/drivers/net/wireless/ath/ath12k/hw.h
>> @@ -96,6 +96,8 @@
>>  #define ATH12K_M3_FILE			"m3.bin"
>>  #define ATH12K_REGDB_FILE_NAME		"regdb.bin"
>>  
>> +#define PCIE_MAX_PAYLOAD_SIZE		128
> 
> PCIE prefix implies that this is in PCI subsystem. I renamed it to
> ATH12K_PCIE_MAX_PAYLOAD_SIZE.
> 
> Please check my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=b603c1e0d94fb1eb0576ef48ebe37c8c1ce86328

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



