Return-Path: <linux-wireless+bounces-13025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5897CE2E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 21:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3F9B2216F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C083FBA5;
	Thu, 19 Sep 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hcc4vcFY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992338F97;
	Thu, 19 Sep 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775025; cv=none; b=ZE9tAqa7lX6cDuCws35dZb+m/xpaq2GO6PuMhNqnw46/fausnvegnjr3F7pdzok6So2kocYq4GI71OtZWUy/6FyegXLqi7eHj29GfTpYSFYLzZwJ81CfKhHGgbNRG5viG1xtODavCBhZdrCXxejpsJy8Nhj0V0Df1MxtiNxU4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775025; c=relaxed/simple;
	bh=iIUGqBVutVd6oF0LF19hUqsIY4P/WifAKVLLOc856qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QoVs35U+XL+cJa5ibQkavhozMrf1glC4CiD0SbiDxRS7pOqu8XduNRPINhA2b0c8zBzbsF2WGx9MhO56F9MosEAXhJeZGTFQQAYFePupX329/OqGix89VBrl+KtO+NZVc4zsFILmjlic8xx49k0pQ3/8zyhA4y+qCGWi4JQmPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hcc4vcFY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JJ3sqT022731;
	Thu, 19 Sep 2024 19:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2LlHmBuJhnI0mJjpFJ8fk1fOR2r24z0SUFaihPrgAoQ=; b=Hcc4vcFYbQIYhjj6
	iBcPFWwQkS8GFeZB2HHMVTCp+bBaJ8V3Vfg/6l29gfqYq4kpw3AKclTt58jRxJeL
	DMxApIzok6zVNZ/11uW5k/d+07jGnrsYsPKactkTGp4QEEIkTkLTjYZidyEMMI2I
	BtD558yO6CbVJ2z4qkgrqNR6ew+f5wacw2mdnT1DxfZ1ioPK252buBoOrkMPvO4j
	xJK59bcpOhaqL7bmyuI+G+vIP0lJOHQSE1/aV8KNvy7aULfYA3U23tWBLvKdP6DX
	NiuH7CgwRp91NYpDw74zZknbiVeLsGSg6E8S1k6r/BJdFnAD0BGfEvuKEa9G4aRs
	I5/s6w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gnxjsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 19:42:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48JJglDA002356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 19:42:47 GMT
Received: from [10.111.182.77] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Sep
 2024 12:42:46 -0700
Message-ID: <9ebea291-df1e-4d2d-8f86-9a089542d895@quicinc.com>
Date: Thu, 19 Sep 2024 12:42:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: modify null check logic in
 ath11k_ce_rx_post_pipe()
To: Kalle Valo <kvalo@kernel.org>, Mikhail Lobanov <m.lobanov@rosalinux.ru>
CC: Jeff Johnson <jjohnson@kernel.org>,
        Govindaraj Saminathan
	<quic_gsamin@quicinc.com>,
        Miles Hu <milehu@codeaurora.org>,
        Sven Eckelmann
	<seckelmann@datto.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        John
 Crispin <john@phrozen.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <20240909150824.28195-1-m.lobanov@rosalinux.ru>
 <172676437762.281449.1201751345434084726.kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <172676437762.281449.1201751345434084726.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AK9etUJtDTTEjLSj3FxHT8qDWQpJHqA5
X-Proofpoint-ORIG-GUID: AK9etUJtDTTEjLSj3FxHT8qDWQpJHqA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=489 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190132

On 9/19/2024 9:46 AM, Kalle Valo wrote:
> Mikhail Lobanov <m.lobanov@rosalinux.ru> wrote:
> 
>> The previous logic in ath11k_ce_rx_post_pipe() incorrectly required both 
>> dest_ring and status_ring to be NULL in order to exit the function. 
>> This caused the function to continue even if only one of the pointers 
>> was NULL, potentially leading to null pointer dereferences in 
>> ath11k_ce_rx_buf_enqueue_pipe().
>>
>> Fix the condition by modifying the logic so that the function returns 
>> early if either dest_ring or status_ring is NULL.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
> 
> Jeff, what do you think?
> 
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

(could have just s/||/&&/ but this change is also ok)

