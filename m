Return-Path: <linux-wireless+bounces-14180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57969A2FAF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 23:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93D11C253C2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 21:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29813137C35;
	Thu, 17 Oct 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YFZB84d2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33912C484;
	Thu, 17 Oct 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200015; cv=none; b=QUJZnBuLrdmDAOz5e5Yhxo1mA/hpP1p3wrBmuiHWJZMQgnC5227WgOHFiQQLG5JUIGeHulhPWd+qoAC5sf9jNLS25UgIJntz2NKK/GAgj0TleZxjLlZdG5lmTgdEFZIH7laTca/6DWLi/XQ+nUpywNIhlpRpBi5D4CYJyWMG3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200015; c=relaxed/simple;
	bh=i0XVbpy2gKGS4KFF+LkQFmwVo2C2AX7dDD8y0VA4aSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EWAy0KR+XPFsc6xWnkg95NvzmffAJ5jmD/63VKinvfOhmmVtxugI15wF8+1EQJyHfiuepPawl0QJZQU6bVX+DM3Ots8hrbqeGyNqmwXQRktE2X9JrWqsJ6b49DKGL+WxaZbm2oJfyOjqQt6n9C0TqpIGB4NKbl0nu9OQ4/uG5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YFZB84d2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HHTlRT007469;
	Thu, 17 Oct 2024 21:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EgzWX3lAJO0pVbrTuiSnbfV5gKwhO6QNNnkK08goo8M=; b=YFZB84d2v1qH1Htw
	UfF+QgMeupdYNanXSchPKN/+jYPWEv9j5xX0Om5xL5cGvYEE8FvBviMKaOf/+krD
	hACPydno1tVAb4IDeV0mrKRTgLb/TdLiN1On5vfPg4ZDPvWU1s5cuf+ojkRuayZU
	XDOLZ3h3K5KZ5sLXRIaO+DadMLk+/UWMeN7T4dSXlxGeDY+2x9fsKpqlIJl+lMsP
	dPNBxoDaHDNVVxyJrOGN6vOzWUp1adR+eU382w/zLPlnkl+laVZVfN0xEidK8tfa
	Xo8Icx1r3mw62vk9n/yDLq0WtJxtVr/RwGdVSCblRgdiXViC4YmMEB8PwecV0dmN
	tqWd3A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mjy9m4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 21:19:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HLJr4u032130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 21:19:53 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 14:19:53 -0700
Message-ID: <f9422f76-4a9f-4b37-8a4e-271b1344668d@quicinc.com>
Date: Thu, 17 Oct 2024 14:19:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath10k: Implement ieee80211 flush_sta callback
To: Remi Pommarel <repk@triplefau.lt>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Cedric
 Veilleux <veilleux.cedric@gmail.com>
References: <cover.1728741827.git.repk@triplefau.lt>
 <481540132c62b16f6d823b7556c11a0ce68f5c58.1728741827.git.repk@triplefau.lt>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <481540132c62b16f6d823b7556c11a0ce68f5c58.1728741827.git.repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uD8FZ6wu9gkNiwA243Mig7dqLpYywc32
X-Proofpoint-ORIG-GUID: uD8FZ6wu9gkNiwA243Mig7dqLpYywc32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170143

On 10/12/2024 7:13 AM, Remi Pommarel wrote:
> When a STA reassociates, mac80211's _sta_info_move_state() waits for all
> pending frame to be flushed before removing the key (so that no frame
> get sent unencrypted after key removable [0]). When a driver does not
> implement the flush_sta callback, ieee80211_flush_queues() is called
> instead which effectively stops the whole queue until it is completely
> drained.
> 
> The ath10k driver configure all STAs of one vdev to share the same
> queue. So when flushing one STA this is the whole vdev queue that is
> blocked until completely drained causing Tx to other STA to also stall
> this whole time.
> 
> One easy way to reproduce the issue is to connect two STAs (STA0 and
> STA1) to an ath10k AP. While Generating a bunch of traffic from AP to
> STA0 (e.g. fping -l -p 20 <STA0-IP>) disconnect STA0 from AP without
> clean disassociation (e.g. remove power, reboot -f). Then as soon as
> STA0 is effectively disconnected from AP (either after inactivity
> timeout or forced with iw dev AP station del STA0), its queues get
> flushed using ieee80211_flush_queues(). This causes STA1 to suffer a
> connectivity stall for about 5 seconds (see ATH10K_FLUSH_TIMEOUT_HZ).
> 
> Implement a flush_sta callback in ath10k to wait only for a specific
> STA pending frames to be drained (without stopping the whole HW queue)
> to fix that.
> 
> [0]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
> 
> Reported-by: Cedric Veilleux <veilleux.cedric@gmail.com>

checkpatch.pl reports:
WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately followed by Closes: with a URL to the report

> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/net/wireless/ath/ath10k/core.h   |  4 +++
>  drivers/net/wireless/ath/ath10k/htt.h    |  4 +++
>  drivers/net/wireless/ath/ath10k/htt_tx.c | 32 ++++++++++++++++++
>  drivers/net/wireless/ath/ath10k/mac.c    | 43 +++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath10k/txrx.c   |  3 ++
>  5 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index 446dca74f06a..4709e4887efc 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -558,6 +558,10 @@ struct ath10k_sta {
>  	u8 rate_ctrl[ATH10K_TID_MAX];
>  	u32 rate_code[ATH10K_TID_MAX];
>  	int rtscts[ATH10K_TID_MAX];
> +	/* protects num_fw_queued */
> +	spinlock_t sta_tx_lock;
> +	wait_queue_head_t empty_tx_wq;
> +	unsigned int num_fw_queued;

is there a reason to prefer a spinlocked value instead of using an atomic without additional locking?


