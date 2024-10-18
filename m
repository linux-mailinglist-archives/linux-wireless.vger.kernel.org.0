Return-Path: <linux-wireless+bounces-14217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF89A4398
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 18:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E401F24A0A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B6202F6B;
	Fri, 18 Oct 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U3oTuCvq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DE1D2B0E;
	Fri, 18 Oct 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268350; cv=none; b=E+AwptEMosoIoIWggnU6uKL4c1KKpAGsBFpUCt37B+RELk2mF9IwSwt+MlvQqG/SxXBRAic7CvRFbdlGaD07LATpY0GHrmB7QO0cnixNvCL58WGkj3hj3MR+3sdReuAHzwx77dvd1inPRjSMLNUreTCwYHa+QCWELX2dY2QJVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268350; c=relaxed/simple;
	bh=tcbRbVNMWQX8Cib3Qs1Uk8S03xO7ytk4ZwFHOcQ24H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q5vkDLB2d8JeiJ2CwDDg6NAmjCKZAqvkCD8/dhGhN6ZiAekVJZc5OtV3v06X5ndFYauQxERaHxP3CIt10f4Rjb3zc+g0IpYbqDxNs9WiuTZb677+OBxeqwXwMm2Ney6Nln1ojZFcEr5FxNxpq0vjVFk7LvhSZXMx+nhYWnrstSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U3oTuCvq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IBapIE019324;
	Fri, 18 Oct 2024 16:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X9yWHtce5E627XFATNma/BqkF4zKRZm72cz3DZRf6as=; b=U3oTuCvqdP/zwIO9
	YkbF1eide7r77GED2LvFs9rC6Ab1LbgvvCGBX/j0N8Yz2Y3unJHbV3YlrkaO+I07
	ZfOW3gyi2uejK3pvxVSy0IKHLec9f2xfHy/NM8i4D+5c/RmCmYQshsAlaT3afpbc
	9viHPGbPpUF5f/D8jYdO+WAvyd1APU6ZNhTt71tvOK1fV49+c/bC4tuXivnUfixv
	wq26cM1IyH7cYaSJPDmz9Hz7S01qgJKcB1koTrXxK3WQv8Pni7RG/RjehSQgcOa1
	beBL/PPTEJrVs9st8SjKYOvgKWatqf3KTNHelEbSu2Q1hzJ5WDjuBvS1k0TY0iUE
	WVNuJQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bexpa8jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 16:18:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IGIwrs022059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 16:18:58 GMT
Received: from [10.216.12.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 09:18:55 -0700
Message-ID: <753a6661-9d52-93da-23a4-d33dab4a396b@quicinc.com>
Date: Fri, 18 Oct 2024 21:48:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] wifi: ath10k: Flush only requested txq in
 ath10k_flush()
Content-Language: en-US
To: Remi Pommarel <repk@triplefau.lt>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Cedric
 Veilleux <veilleux.cedric@gmail.com>
References: <cover.1728741827.git.repk@triplefau.lt>
 <3baf9565d72291a0b730d9a53fc1ee9610dcc91f.1728741827.git.repk@triplefau.lt>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <3baf9565d72291a0b730d9a53fc1ee9610dcc91f.1728741827.git.repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z1Zm4QQINbQxOO4v76qhrGdKTnXXEbSa
X-Proofpoint-ORIG-GUID: z1Zm4QQINbQxOO4v76qhrGdKTnXXEbSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180104



On 10/12/2024 7:43 PM, Remi Pommarel wrote:
> The ieee80211 flush callback can be called to flush only part of all hw
> queues. The ath10k's flush callback implementation (i.e. ath10k_flush())
> was waiting for all pending frames of all queues to be flushed ignoring
> the queue parameter. Because only the queues to be flushed are stopped
> by mac80211, skb can still be queued to other queues meanwhile. Thus
> ath10k_flush() could fail (and wait 5sec holding ar->conf lock) even if
> the requested queues are flushed correctly.
> 
> A way to reproduce the issue is to use two different APs because
> each vdev has its own hw queue in ath10k. Connect STA0 to AP0 and STA1
> to AP1. Then generate traffic from AP0 to STA0 and kill STA0 without
> clean disassociation frame (e.g. unplug power cable, reboot -f, ...).
> Now if we were to flush AP1's queue, ath10k_flush() would fail (and
> effectively block 5 seconds with ar->conf or even wiphy's lock held)
> with the following warning:
> 
>   ath10k_pci 0000:01:00.0: failed to flush transmit queue (skip 0 ar-state 2): 0
> 
> Wait only for pending frames of the requested queues to be flushed in
> ath10k_flush() to avoid that long blocking.
> 
> Reported-by: Cedric Veilleux <veilleux.cedric@gmail.com>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>   drivers/net/wireless/ath/ath10k/htt.h    |  7 +++--
>   drivers/net/wireless/ath/ath10k/htt_tx.c | 18 ++++++++++---
>   drivers/net/wireless/ath/ath10k/mac.c    | 33 +++++++++++++++++-------
>   drivers/net/wireless/ath/ath10k/txrx.c   |  2 +-
>   4 files changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
> index d150f9330941..33054fc4d9fb 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.h
> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> @@ -1870,6 +1870,7 @@ struct ath10k_htt {
>   	spinlock_t tx_lock;
>   	int max_num_pending_tx;
>   	int num_pending_tx;
> +	int pending_per_queue[IEEE80211_MAX_QUEUES];

Something like num_pending_per_queue[] to align with the existing
packet counter looks better?

Vasanth

