Return-Path: <linux-wireless+bounces-14181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5381A9A2FC4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 23:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182F32867C3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 21:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B691D271D;
	Thu, 17 Oct 2024 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gEUCZayO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418751D0496;
	Thu, 17 Oct 2024 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200291; cv=none; b=INxWL5/xXP4XxXesWUYnu7w6IC8SM9/HT1lUnvGrZA9Xishu5DKLfWxBUn9nOb71LgBsl9bsDKS84GgWCltcZ5khrJqvykDbYkP/GQgf+rLtyj3OLFLrOwZhyKS+8t0U6y90bE29894ztGwV2qXBjgJxCQafQpPqUMynncwcLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200291; c=relaxed/simple;
	bh=4WLylA54PqHzVxIYBP42QkGZxrXkEsWJPLBqN24fwJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=icTR3i5PzpAaHkXPMCaiCT3rqnmC8HHBd0fpDUH+NfOn9dzHji0GkvcRm6wEfveWFYnKKp6ANXr4IxEcjRIPx6IXgBFHiV0x2ROSIw9GIFKNFJ3dkaF6vc9E6S1lppHosNIxuOiDOHdPiEy41sLjYkcadUFyUe912hZfdLDw/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gEUCZayO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKJBAT027126;
	Thu, 17 Oct 2024 21:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EcSHCx2JQq3nN+Y3bskrGaIP8pxhfHO/tg8J4qfzDYw=; b=gEUCZayO0u3f8+aJ
	Z0GHNNfEq8TG9jZ2RXoDrpgx76HWegY8SBLeQP1WV7TlVl8ubaShSESiFnr5VOhO
	24CnHbHB/yAs3QJEShtlY43qiYdWXB+gyE4hOZA7UJRcMW4Pz3aThRMFUjma1meq
	DBpw/rgMVF9yI8Ht8gXqUoiMjGg4/n8Z5/70ZbEwMuQRI38xAPDQlBNJmCB0QywF
	OfDpAZw8xn2t4PRx3yT4onOykE4z6zqivRxtsCntfEbvvC5dQNg0sUIeQ/8ZUYdY
	brOmKZDhan877gMXF68S5kloxFY85ZyrhgVSAygPxnwxkteYJmyXn1PwpvH34Vez
	hQjzoQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ay8ja2kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 21:24:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HLOUBM015333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 21:24:30 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 14:24:30 -0700
Message-ID: <3ea462fe-3028-44c1-9be4-3d973d202bee@quicinc.com>
Date: Thu, 17 Oct 2024 14:24:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath10k: Flush only requested txq in
 ath10k_flush()
To: Remi Pommarel <repk@triplefau.lt>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Cedric
 Veilleux <veilleux.cedric@gmail.com>
References: <cover.1728741827.git.repk@triplefau.lt>
 <3baf9565d72291a0b730d9a53fc1ee9610dcc91f.1728741827.git.repk@triplefau.lt>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <3baf9565d72291a0b730d9a53fc1ee9610dcc91f.1728741827.git.repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vyzmtg9wNEvgzaCCeMrotrhKGEchehq4
X-Proofpoint-ORIG-GUID: vyzmtg9wNEvgzaCCeMrotrhKGEchehq4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=929 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170144

On 10/12/2024 7:13 AM, Remi Pommarel wrote:
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
>  ath10k_pci 0000:01:00.0: failed to flush transmit queue (skip 0 ar-state 2): 0
> 
> Wait only for pending frames of the requested queues to be flushed in
> ath10k_flush() to avoid that long blocking.
> 
> Reported-by: Cedric Veilleux <veilleux.cedric@gmail.com>

WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately followed by Closes: with a URL to the report

> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/net/wireless/ath/ath10k/htt.h    |  7 +++--
>  drivers/net/wireless/ath/ath10k/htt_tx.c | 18 ++++++++++---
>  drivers/net/wireless/ath/ath10k/mac.c    | 33 +++++++++++++++++-------
>  drivers/net/wireless/ath/ath10k/txrx.c   |  2 +-
>  4 files changed, 44 insertions(+), 16 deletions(-)


