Return-Path: <linux-wireless+bounces-4450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE638874B3B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 10:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19C91C2180B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D0839F6;
	Thu,  7 Mar 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XyzFi1A5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DD839EF
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804856; cv=none; b=KAKsVMoSnoriyecDIlarrpLv5A70K0QWRAp51RaSbBpu18WXqCdn5YpEDufF9g/PDVs+wvoxX6Ni96JSIebfJncENolVybFg/KbvJubCZU1QYLOcQdoEeFOCnAh6AP7+ATjKUQdodiXcV1HfqTl57jEpHnPYX5YaYCdcxWJjhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804856; c=relaxed/simple;
	bh=C4cA2eMzqxQKt1xW0+RxsTQyTIVD3+oeNtUU+uXxNCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZgQMRGod9irpc/nYHtWdM+vdwGBkPDXF5lB/brYdT4A2cv6OASL7r32ZPjS6wNyVgqHiYpDg3t7V6BItbxEUHmTK6IkoaX8PFbN0T7kTE9wbGH7OoOMkt9Dazq/5IeEQwQDrNyFBonap0tu2im0+vo7pm+sMdGAqzKDN7DMSTWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XyzFi1A5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4277ndrm005292;
	Thu, 7 Mar 2024 09:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FIomtRaUEzhjsVAIwJkR52Eyfs5z54AAhKI/aKDbYY0=; b=Xy
	zFi1A54mtwp/Ps9OoV2JTadrC/JteOs5wMRJip8JbJmg0Tft0Q0D+6JbBsYXt1Ae
	gtaMZZhNjjIMw+YIgvbu30P7LBsbnAjDxAM8ActnNPUXeaE7nHcDjNFwhoEy2XEy
	Cn1XByStqL5lGUQvMRYzj2yZkZxcruiaNZTAXCaohzT8nSM/n72UUFeTJVBt/lE0
	kU3IP77y7Tgym5iRibUBwCAOVwLTkpWlmHKiarhC38BGe7NI0JfwXFJSA/LnCWo3
	BIm0eZZop/iglFeyO5rDffl8FVlhDMjpeOFtnK82FA2bCEYQMifAna6U7q9iHD9+
	qzSmofP8ZFm0V2fDRVHw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq9h8g71t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:47:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4279kq5w025326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 09:46:52 GMT
Received: from [10.253.39.187] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 01:46:48 -0800
Message-ID: <4536614a-7f4c-420f-b042-f71cf46ba08d@quicinc.com>
Date: Thu, 7 Mar 2024 17:46:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] wifi: ath12k: allow specific mgmt frame tx while
 vdev is not up
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-9-quic_kangyang@quicinc.com>
 <87il31r26k.fsf@kernel.org>
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87il31r26k.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IP3sIwhvg9s76rhdY2S_-3ps28NLUsLz
X-Proofpoint-ORIG-GUID: IP3sIwhvg9s76rhdY2S_-3ps28NLUsLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403070071



On 2/7/2024 12:24 AM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> In current code, the management frames must be sent after vdev is started.
>> But for P2P device, vdev won't start until P2P negotiation is done. So
>> this logic doesn't make sense for P2P device.
>>
>> Also use ar->conf_mutex to synchronize ar to avoid potential conflicts.
> 
> Please do locking changes in a separate followup patch, I removed this
> in the pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=d357dcb3cd0cd3bf57064dc673b5477d884454b3
> 
> I assume you are referring to ar->allocated_vdev_map and access to that
> indeed doesn't look consistent. Most of the places take conf->mutex but
> I see some places which it's accessed without the mutex, for example
> ath12k_mac_get_arvif_by_vdev_id() and ath12k_mac_get_ar_by_vdev_id().
> 


Hi, kalle:

I just take a look for ath12k_mac_get_arvif_by_vdev_id() and 
ath12k_mac_get_ar_by_vdev_id.

Both of them use rcu_read_lock(), so we don't need mutex_lock() anymore, 
right?

I also tried to add mutex_lock() for them, cannot work well:
[ 7804.291286] BUG: sleeping function called from invalid context at 
kernel/locking/mutex.c:585
[ 7804.291349] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, 
name: swapper/8
[ 7804.291358] preempt_count: 101, expected: 0
[ 7804.291366] RCU nest depth: 1, expected: 0
[ 7804.291374] 1 lock held by swapper/8/0:
……


> I recommend in the followup patch checking all the access to
> ar->allocated_vdev_map, fixing that if needed and adding documentation
> to struct ath12k::allocated_vdev_map how it's supposed to be protected.
> 


So i think the initial change is sufficient: just use mutex_lock() in
ath12k_mgmt_over_wmi_tx_work().


