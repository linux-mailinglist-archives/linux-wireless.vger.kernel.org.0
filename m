Return-Path: <linux-wireless+bounces-35106-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKaaLvDf5ml21gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35106-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:24:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A0F43578F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E7E5300D17D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 02:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3C279DC3;
	Tue, 21 Apr 2026 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXGMutNI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EcZYJ99i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE621DC985
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776738285; cv=none; b=XYy0UcsOY3sMn9w6xCaJwWvI4idS+nRgoatLRjxX4+l/+w8C0lvz89ShuYvnQKM5Oo8En6tVXV0t0sIv+GZ337/uixeSVhzGjRxAreltSdQ5+PimEI6SJCLrf3yuL3kUarrlO/J0Hh8aIBLJN+UaDw1ZfQzDOIeSqOt4shZtFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776738285; c=relaxed/simple;
	bh=YNb2SFORlhn/YxpS0j4l5RbZpApHeHgTwyLgZgxkwK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipB0ysSYvmznZ8FZgXiViQXMOtg/bWsr4hyK1tetFytZoB5NLDZn7tpSw9Nd66Cz+orO+snJ0PWRFApTBaGijx2BYS4iD9YTRU2CuVb165BEHE2PffIsPzy9ci1wMSF8Q5GGwVwNV6DvEAmQCMTun4oUmIIlTGLy0bapNJSRhc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XXGMutNI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EcZYJ99i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KHhZxe3015215
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kgDMVNCvXyKwwDfZlNFHIyKphSpxFtsaHkDWCwFQFHo=; b=XXGMutNId1A4XRpO
	h8g7wY+s0r/8gVyvi8Xh8E1wmNaLJibCWqnHY4FP8zLk/zy3rJuyfkK5fM0oDacZ
	T+1DQcrrrkdzIyO+85TrSbGMmBfXclWK9m1vznJeYalN1D3plaj2vkSPn3slVxTx
	ofq3O+AsSP9XIgHR8TiUIN6cHFLWx8Zg5vbCXT1NbQvljaCAf9RPXcXRIE36kghP
	r03WOddszcqoqQsB17qiLK4RZOu0QC/YWpc1WYgatDyNeLN26aQaO0biJegqSwSf
	COAaoZPr4hqWqQ8ZniXJQfCtwgqsCRW51AQ+81fLHMm6sXDN6JsRkpjy4wVe6Hvh
	feU92Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnjuktxa4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:24:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso5011586a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 19:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776738281; x=1777343081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgDMVNCvXyKwwDfZlNFHIyKphSpxFtsaHkDWCwFQFHo=;
        b=EcZYJ99idyn8Z0rH9CEWRubcMPUtDdBgSqc57JdELRpGU02Qd2j+ky/2doRhArOJv/
         K2UzVEmcVe6W2ejhI3aAgSr3pahwFcGKh00eE571CrRbktHpoqUbgePNndV36Sqfi7Ri
         Pgl9XfTP/JXCM6P+VnDYmBQgiGrljZKFEuI4ARnUrQRZyQJQKPHMeZCbEQF4+H3CpDmC
         DKlaktzrI08fQiQpvfWuftw7hFn/DmQui7cUeCYjPSYMrTD9a+mHMYjWCQcTMCvuobbg
         aCJEHydj71DXgL1SY0haKgHegO0+l+jWZ4AnWmKoc8iSpNjSa+uDKvKz95RsRb9VBYMe
         WOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776738281; x=1777343081;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgDMVNCvXyKwwDfZlNFHIyKphSpxFtsaHkDWCwFQFHo=;
        b=rp+1mKD9LdXjDM4NBFZhMSCQJaONIN7rKIZNMi285IvaBW4cyaBphvBcmorxTYApWB
         JQiycZw1DuHUmdfEmlY7khYgyi5I3NVwAIbV4JrvZVgZ+VsIdLG+8aEQiqQZ0u1Q/41S
         xWeTBC3HJ1fJxHwkmMPT3JqVQlo6E9U0HVlLCuGD/+/zq3qmZD+iuekCj1NKZ+xpsNhC
         hDngzSMT7aNS1txU4SXUGgaW68p3yvVKsWC3ic/chZ5hATa5CsBI55AZwwBykTDlfpjd
         /Z1RhGmhpuXRerMzS/2QrdR0pSWnLmLpJUOICpmc7YUA/gqAjuGCEX8PU4BYFeAlAcVE
         bzTw==
X-Forwarded-Encrypted: i=1; AFNElJ+pviIN1RVr2sqDtVTsDnhZIFJ35tV2nod0y8TWAYMhNzzBI08292bBd6RrjHwUkqI/fIyh2Bawz0O6mAcsxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtqrZR5V+4KnkVEu15/fq0302pGqaIW9O3WnBV4tX1ewMc79O7
	qQS3a+nzIuRE3YPc0Wz2nhZ+xW3EJDHzr8Jt1F3xhChOS/3yk0dzwyFQstEKvGr88axOtyr8jfn
	pTzEVQ7kZH9SqchMIARmDYK+ZhwG/JSfPYdg4oJQfUVXrBgmjA/+Hm0yMuj2DENOhCEX2tg==
X-Gm-Gg: AeBDievM9KpDZxMRBs6tbCRYQ5gpWO+bJeIYG+rakrUNgqGqDl09VAsDszZuqdYwIvV
	+2nJc9iRHXhr9hJgKksPUzf2zKJzXgvB+TRqbR275005TPHlvnXfzst8KIC4d5Rn8o50HSLiAqE
	aQQP9dLZ3rfGml+uBfqShHTANeTehfF1ZA4z3kDia3iDgU5R+Dmbb8JHH+WscWy3LZQ18cwhx0o
	0t8Z/tam8PXjdtpCJGOxWB01QzoaOo1XOD+Y/eb+HnZkUmbqKKH4ZXeT2LFLGCkGepEdLNupqVp
	NQLDXJi0CxV0X8WAzizBD8Cb0K6Kv6WVNpwdiPBbS/iIAJvuERtQ34WXbLsKIAbUXNyQ6HBCrhp
	Rg08opPcar+tW7UtKSz+eis6rLa7uCorWPbJpCPaPiNItLnsP1BsAkbrLTZLgU4cOUFe66GwhTm
	/pFZuc+mhfsWwTwEp7GWEg90qG5PduGw==
X-Received: by 2002:a17:90a:d604:b0:35b:952c:43ab with SMTP id 98e67ed59e1d1-361401eb6e8mr11315822a91.4.1776738281301;
        Mon, 20 Apr 2026 19:24:41 -0700 (PDT)
X-Received: by 2002:a17:90a:d604:b0:35b:952c:43ab with SMTP id 98e67ed59e1d1-361401eb6e8mr11315799a91.4.1776738280743;
        Mon, 20 Apr 2026 19:24:40 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc593bsm14924248a91.1.2026.04.20.19.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 19:24:40 -0700 (PDT)
Message-ID: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 10:24:36 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix false positive RCU warning on
 PREEMPT_RT
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org
Cc: Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260420161049.695518-1-asas1asas200@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260420161049.695518-1-asas1asas200@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: y3sK1bYl9wbjb9wAMjUlH5kKQoEVgCB1
X-Proofpoint-ORIG-GUID: y3sK1bYl9wbjb9wAMjUlH5kKQoEVgCB1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAyMSBTYWx0ZWRfXwr8IV46kFsSY
 ZWC6JFxZMEZmofN7GSWyPo9eY65Mea/WeqItZbfbwgofblAWrx3yzTYmsgjzDoDYvT8VRHmmo+D
 OU7xt8OMGkyLNW7qDi7/qaz+ki0j2zLOzSoy9a4QP6YdxcTWYov06nq0usXEAs3+lNM79tq/ktG
 48bTY/EdCDjhrZnq+uxoYKKnfYmG7BRJeKPEdCGpy8xWCs9bees1ZgPB8R6J50lcPdfkln5QjHU
 cfnK/G+tJZ7D0zTSQ0kM8CGfc9PPQAqb3ZJLXlYgC4meI/TL5w0Hg7qgp74qN3zNhpL1a5C1ETR
 wFcwDCxuyXcWkluo2/pryiQVWv7RtRA/EOL/98f/HcOK68hllov+jYIaodGGNzENMvy14x11O4x
 3HG7dCNMrGXSs8QAS+5ztCnVj7+j2c5GjTLdD/J9HokvYV+WGwPQcTlQdalIO4cZE9yFcZJAlOo
 Jn3f1D26WMZdt3Rw6pg==
X-Authority-Analysis: v=2.4 cv=WuUb99fv c=1 sm=1 tr=0 ts=69e6dfea cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=yypq-u40hovQB3Eki34A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_05,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210021
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35106-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09A0F43578F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/21/2026 12:10 AM, Yu-Hsiang Tseng wrote:
> ath12k_mac_get_arvif() asserts that the caller holds an RCU read lock:
> 
>     WARN_ON(!rcu_read_lock_any_held());
> 
> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
> false positive splat whenever firmware stats events are processed,
> even though the caller does hold the RCU read lock.
> 
> Root cause:
> 
>   - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
>     returns !preemptible() as a proxy for "in an RCU read section".
> 
>   - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
>     task can therefore be preemptible while legitimately holding an
>     RCU read lock.
> 
>   - ath12k_wmi_tlv_rssi_chain_parse() holds the RCU read lock via
>     guard(rcu)() before calling ath12k_mac_get_arvif(), so the
>     warning is incorrect.
> 
> Typical splat seen on a WCN7850 station with periodic fw stats
> processing:
> 
>   WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
>     ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
>   Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
>   Call Trace:
>    ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
>    ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
>    ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
>    ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
>    ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
>    ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
>    ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]
> 
> Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
> debug_lockdep_rcu_enabled() and therefore compiles out entirely
> when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
> full lockdep-based check.
> 
> Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index fbdfe6424fd7..a772a5b6adc9 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -788,7 +788,8 @@ struct ath12k_link_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
>  
>  	/* To use the arvif returned, caller must have held rcu read lock.
>  	 */
> -	WARN_ON(!rcu_read_lock_any_held());
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
> +			 "RCU read lock not held");

should the instance in ath12k_p2p_noa_update_vdev_iter() also need to be replaced?

>  	arvif_iter.vdev_id = vdev_id;
>  	arvif_iter.ar = ar;
>  


