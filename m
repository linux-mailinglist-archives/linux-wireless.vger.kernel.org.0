Return-Path: <linux-wireless+bounces-2136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9B831159
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 03:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6341F23E8A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 02:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A092665A;
	Thu, 18 Jan 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ivMNd1Wv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A392573
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544514; cv=none; b=iNtYXO/AFMvEweurm/mq08ScSDid488Vk9ROx4YT9fACLJUiiAAGtAfjHl9EDBeZjrKozzHKOjnnYP8QZluIXurkmPxaZgyCNXyjMsQk19eRVHGJxWBNa88QFvo1QuEVx0jU/L3YRsr04eLtFEhNm7jppMGclzgajLzosP003vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544514; c=relaxed/simple;
	bh=hLjvoGeTiU9DRMX4wyLt3A3aVJfjQAauaz1b7MVZg0I=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=G0KNq+uvXW7hVlDU65/6KDNwjpWP9QCkN8HjppYozJD8eZm50frFMnQxi+21OA4qsci/W54jMR0pcm5evzAKJNDo/r5Ls6jXtay6m7FF66g4lxdvIZ+a+Za4yLP1EXiNKwnnVBMfGAp0CvmqzAF2RWwHfyboenH3TrZ8Yh3QODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ivMNd1Wv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I0sxiB010946;
	Thu, 18 Jan 2024 02:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rsomCbX7hSZoUAk1T+f3+Fxks88sbYfcTG6Oma0Lryg=; b=iv
	MNd1Wv49k5+yllRBwxSW9LYHkz+IkjhqY2Mmq5driBGgHXbdaGfAy4sypQ8zRPC5
	ugIaH4hCa/Mi9AeY24hThJJC9oqPUsCQQOxeMcijY8m6HV7yK2fXmsZB4szMBtSf
	To5eG/pQD47EAvXu4DELEI+uAhIepPAq6SelMyCk8LTgF9GhiWbZhmuW8S5dUeZK
	ybAO9nu9Ik36MJEXXdFXvL2pJJ4WW3R1DG1rq8hnRUqiziMpf5krqOkISDJ6CKvI
	nasHFhA6BPQVYk7TtV9xdo5g37JvHrl4khkZfF/1Ny5yk/Om9n5n+wsYOxJ7wBQM
	vvN53IVOtOvw60TwrLeA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp6p3tpe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 02:21:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40I2LlI0029578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 02:21:48 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 18:21:46 -0800
Message-ID: <cbf6f724-747d-4539-b9b4-dc3f39763148@quicinc.com>
Date: Thu, 18 Jan 2024 10:21:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] wifi: ath12k: some improvement to RX throughput
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231129020414.56425-1-quic_bqiang@quicinc.com>
 <874jfc5ayb.fsf@kernel.org>
 <6da888c4-be62-4373-8527-996dddb436f3@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <6da888c4-be62-4373-8527-996dddb436f3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eEiK0rFc87ZSCbKThw_tbJY3zKzRl9Uj
X-Proofpoint-ORIG-GUID: eEiK0rFc87ZSCbKThw_tbJY3zKzRl9Uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_14,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=732 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180014



On 1/17/2024 11:32 PM, Jeff Johnson wrote:
> On 1/17/2024 5:46 AM, Kalle Valo wrote:
>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>
>>> Some fields of hal_reo_update_rx_queue are wrongly
>>> defined, fix it in the first patch.
>>>
>>> Currently the maximum block ACK window size is 256,
>>> with the second patch, it is extended to BA1024.
>>>
>>> The small MAC buffer ring becomes the bottle neck
>>> in RX throughput test, so enlarge its size to get
>>> a better peak result. This is done is the third patch.
>>>
>>> With above three changes, more than 6% increase is
>>> seen in RX throughput test.
>>>
>>> v2:
>>>   1. wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
>>> 	no change.
>>>   2. wifi: ath12k: add support for BA1024
>>> 	a) s/doen/done
>>> 	b) update struct hal_rx_reo_queue_1k
>>>   3. wifi: ath12k: change MAC buffer ring size to 2048
>>> 	no change.
>>>
>>> Baochen Qiang (3):
>>>    wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
>>>    wifi: ath12k: add support for BA1024
>>>    wifi: ath12k: change MAC buffer ring size to 2048
>>
>> I had conflicts, please double check:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=1ee7c1872873d82a71e05a4e17cbf9a569bc8ec9
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=4d75db679457b5b7e04271f5174d9128d7d73ecf
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=db549be42740d286ee6ec8b2860b4e4789be2167
> 
> These look good to me, but Baochen should also confirm
> 
Also looks good to me.

