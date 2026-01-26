Return-Path: <linux-wireless+bounces-31154-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNjXIlPOdmktWwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31154-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 03:15:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F276B83796
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 03:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97CBA300DDE3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 02:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6E27A47F;
	Mon, 26 Jan 2026 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lq1g+vHH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W8iMgL+/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4D2868AD
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393723; cv=none; b=ci2mjsXoJyL9mY1PJ7qLRyGnc9iSHdOHuTT5a19dIygfmhASTCYjn+ymggMZdANhICoJd895PbbUsdeID9tKvr1SCzecT73jI/xRRmgdXc2AJMr63uLIuWNzI95sY8ctIXbyIJg/MSUvFt0Y0yi+fItpdq1OxwAa+H5VhsBkRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393723; c=relaxed/simple;
	bh=w1GAQCf1HxThXzDyTuLGQBFSQXiEYFMA9Iwtcw41YCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtQsfN1EwljhFhXrZLYIrM9p8qaM3hAiBV5e7iAOp05GVFfefYQrrsfA10JWN/4XMFjw163OSlD+wxFt7+sH8t7T06GxsDWLwTEDsxFT2sPugDozBbhjBgBUR/36rfr9Kb7FUqi8Rxu+Ug4606qGaFlCndq6dOlec4xNMOK1UX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lq1g+vHH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W8iMgL+/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60P7CojR3596623
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 02:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zwtxPTrPGzWPOqfN7gVyzUfj/+vOMn7+smpYP5omEwk=; b=lq1g+vHHhH3UUkxI
	DXt6YiKzlnEE5G6NZdVZvGt0pSt44uoshy5CUi8upSvODrNGu3a6CM+SNvcXhmNs
	7LLdYf3mOvv+OTI1+G5JLuS+m2/HZW1H/rabifuJ3pPBPAsT/QS0iwu6HSxSC1nl
	PeloIFcPL12D2gpNO2NR8BDPKLsQFMhOGZk7GsI2uF4dgG56tNdwYfBfmrRI5MJ4
	7ti2wIUlRhFRFqk+LeBzYTjasFnAi010wI1qfNsJYHP1jYw7LcoPVNgUFCMz0CJ9
	AkIJ/clL8+VO131fY6OawF2mo1qVoniLG1sFBhH7447o8/9LMHIWFBCI/F/ZRq3T
	+ja++w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq3hb4a6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 02:15:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0a8c465c1so26453265ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 18:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769393719; x=1769998519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwtxPTrPGzWPOqfN7gVyzUfj/+vOMn7+smpYP5omEwk=;
        b=W8iMgL+/XbAM0BNocQNAyRjw/arubjqg08Add9+xLwCNY2iz5wzrsLplLsFthQjIqY
         FKrNI7n017Y5QqUCzbs+zLxKgvhn7dO3QUTfEe+9l7AJ9CoqeRmq1GoHGbB/YDqQBwQ8
         sjOwkCJDamvb0VNjPO68ze9QMrNANNSR6IaLqOrM/YUjepPffRyWUvqyEho54FL5GS7I
         LFoJq40m2wRWe/4jxGuUefcMDGSnLHXleQrhRZy6z1SoDtgcUzuUgVOehuBPo0pyHwSr
         5D+2eND7gRI0alROvv8DoVlSGPfmD0j0095toR7jDeL3qrcVpsH22AB9XbbgghJiutw4
         Mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769393719; x=1769998519;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwtxPTrPGzWPOqfN7gVyzUfj/+vOMn7+smpYP5omEwk=;
        b=CpGaZZsTYPPXBCTy6A0MjPC+Fgfb3u0LAFo8ZMu25cvpWU1K1vqH4AKgDP1IUPTIv5
         05sdB3MmYcmQecs4oxRJX9kkrUwcgESVYoKOcZSrP5N7m/pnaGUG6gLLjFQXZPainGaW
         nWwDYNvUMUr/nJa2RFBW5sBNA9pQrD4V3oFA21yIbUGQvKE/CutYdDqrbbBnjJGbCYD0
         ItGybaT4YzbHHC7LniUVkGq8h0HWkswS/FO5PmXFi+rvDcVEfpYWL8B8AJjo3i2mqMQN
         oTmIjzfUEb9FfhRIOm2p80hj+I80rhMS4BRxoYPotjTyPKsg8gAuheDxHKBC+Cyko553
         H/VQ==
X-Gm-Message-State: AOJu0YzTVfXywv4jraty0e13gxaPFOnq7GLD+edj4976o9Tchsggn8hC
	lh9KGfc5TJhmWq0mXTTOzrZ/I1rhKmQjnCY9KMAP5sigughqXvNUSkkzswRRxnBN0BcXR4DaOLG
	7XweH2c9wF3x0sLFmXsuE8D7OVAykIWD5KEsR7YlFSdMcn3eqc80Ub9OVLOOfVS64NFNvoQ==
X-Gm-Gg: AZuq6aIcXwvXEI8l3zJRQ3hIk9Bu4VAmS2uTa7GzR3MW6sPcLveQx4paLuvV8APyEE0
	UaEe5vuMsRxW/73BEjBgycZkXb+EEopxyY4Uku9sGKQQn6zLefRukCwYg1f1QgxeW6cBpRFwoHK
	7NbA5B157A7EbxLhksSChENsU3bD88hHa8E+cTyL4sGkV9yZ/dFSQuRM7xafKTYrXCNhkTi+R9b
	ZBmW5nL7ZfNRY+C9r4EOQfi78YsbZJaCKZUR5WzPtU+ZYT9dgm+EfjJdgEvC5TcLcAjsQ9ODdc5
	Gv3xElKOco8YiffubYvEBj7UQK8Wf4bjbqy7bbboKs3twP4ObvUD5l3JTp2OmDGixDuG5SX+sOK
	VxzJcUQL8YDnwY51/yt6UGM0Y9hUOg+i1+DFug/Dh/E2RjGjtC22PCz4e84m8jIAmDe3yH8xMNS
	HR/d2iDLs=
X-Received: by 2002:a17:902:c94d:b0:294:f6e5:b91a with SMTP id d9443c01a7336-2a845502f26mr29584615ad.13.1769393719329;
        Sun, 25 Jan 2026 18:15:19 -0800 (PST)
X-Received: by 2002:a17:902:c94d:b0:294:f6e5:b91a with SMTP id d9443c01a7336-2a845502f26mr29584355ad.13.1769393718834;
        Sun, 25 Jan 2026 18:15:18 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f97ba6sm76776135ad.50.2026.01.25.18.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 18:15:18 -0800 (PST)
Message-ID: <86af03f9-3823-4561-95ec-8b15ed88249c@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 10:15:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: fix lock protection in
 ath10k_wmi_event_peer_sta_ps_state_chg()
To: Ziyi Guo <n7l8m4@u.northwestern.edu>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260123175611.767731-1-n7l8m4@u.northwestern.edu>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123175611.767731-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDAxNyBTYWx0ZWRfX0qX2nW9jNNSv
 9CEKIeGV5cuJK6OKvYiaeug7S2pvvkmYAdvrxsdVYdbeElNWVVg6CU3ZJ57QSEwcPI4pBLOR0UX
 wl56oghkzDz5NI4xjUt4uUMDXcUMDiIAT/m3jfG6ObgjVFaQ/PO4QaF/pIIZvWF1LtwlF3U5Nb2
 imBY5HqgkaIBtTUdhSha1O8oQeA27rfjLCJOqUZZ6fjGqlQ8NaR4GqeVy1bw4u6d6Jtk+RlCxux
 EF+G1KnKBUkFNf0I1BnJb4RLMmorNvnhp1HcnqSCDieZYnvkk/KbIVQuSxFyV1mUnxF0Car6NvK
 aGWkeMFYG82Frb4QuFaAK1bXIJxHnX3JBS4KeNFuncSPGfiswoXJFkLvMEUxwa5W9XkJ47G7xMS
 UuzhhSgBlcY7HC3RnC8RFSwuqZPdIHTd4qQAqPpSwFWFF0YMYuRlXca0VGPJkI/uITCTdGffSki
 oznANT3ZDA9w5lPQOyA==
X-Proofpoint-ORIG-GUID: FNboQD8hqK8JxsYk06kUr3x9BPCw0xlQ
X-Proofpoint-GUID: FNboQD8hqK8JxsYk06kUr3x9BPCw0xlQ
X-Authority-Analysis: v=2.4 cv=c/imgB9l c=1 sm=1 tr=0 ts=6976ce38 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=27jATeYspuGomxVIXMEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260017
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31154-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,northwestern.edu:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F276B83796
X-Rspamd-Action: no action



On 1/24/2026 1:56 AM, Ziyi Guo wrote:
> ath10k_wmi_event_peer_sta_ps_state_chg() uses lockdep_assert_held() to
> assert that ar->data_lock should be held by the caller, but neither
> ath10k_wmi_10_2_op_rx() nor ath10k_wmi_10_4_op_rx() acquire this lock
> before calling this function.
> 
> The field arsta->peer_ps_state is documented as protected by
> ar->data_lock in core.h, and other accessors (ath10k_peer_ps_state_disable,
> ath10k_dbg_sta_read_peer_ps_state) properly acquire this lock.

there is another instance in ath10k_sta_state() where the lock is not acquired, but I
guess that is OK since during the NOTEXIST -> NONE transition no race is expected.

> 
> Add spin_lock_bh()/spin_unlock_bh() around the peer_ps_state update,
> and remove the lockdep_assert_held() to be aligned with new locking,
> following the pattern used by other WMI event handlers in the driver.
> 
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
> v2:
>  - Remove lockdep_assert_held() as suggested, since
>    we are now taking the lock internally.
> 
>  drivers/net/wireless/ath/ath10k/wmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index b4aad6604d6d..061a2fa8f00f 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -5289,7 +5289,6 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
>  	struct ath10k_sta *arsta;
>  	u8 peer_addr[ETH_ALEN];
>  
> -	lockdep_assert_held(&ar->data_lock);
>  
>  	ev = (struct wmi_peer_sta_ps_state_chg_event *)skb->data;
>  	ether_addr_copy(peer_addr, ev->peer_macaddr.addr);
> @@ -5305,7 +5304,9 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
>  	}
>  
>  	arsta = (struct ath10k_sta *)sta->drv_priv;
> +	spin_lock_bh(&ar->data_lock);
>  	arsta->peer_ps_state = __le32_to_cpu(ev->peer_ps_state);
> +	spin_unlock_bh(&ar->data_lock);
>  
>  exit:
>  	rcu_read_unlock();

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


