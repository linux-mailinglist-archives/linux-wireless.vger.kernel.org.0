Return-Path: <linux-wireless+bounces-35199-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CkxJaUt6GmYGQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35199-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 04:08:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F31441457
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 04:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E447B301C8A4
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1330BF70;
	Wed, 22 Apr 2026 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ls5H+sim";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LPvH9llm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61532F6920
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823594; cv=none; b=caTR4osHZsq1Hq0F6ffKhfK47ft/oAJ8uP9YuhkF2ljfndJQODPr4jfvaImkQIjY6/TqEQyFD0twaViqbWZTpEU+l0YuoX7y8eiyNYS/cGn/gJlRA6T9nlErHooJPRJMag30EoRQQaKa74EwGoPndkTFeUTojbTN1tJwyHW4xOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823594; c=relaxed/simple;
	bh=R/Iz2RAwQgHvZET6dqX5gNfKpOa1HfQw6wS8D/2b9rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBJfGJRQqRTYzioxdB3GVorOvW4ZVmSre+8mVaGDeR7daQIdmaX7oZV7q9lX36wvatZXNtMmsrz6mb/RSJOLpZKEJBwqECe4CwZ26lu07+VVYIaJKg9yE2aTebFVdXNWwSGBTTx4TmdqGeGcC8c2cm4cSn9LoSxW7qhqtWq4MAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ls5H+sim; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LPvH9llm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIaERL2936073
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 02:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CV7U3mQMJfVMAl6qflQ64fFOB5iGrhYZdBNtJgFLV5w=; b=ls5H+simo0txwsBu
	u3grL+mcbKlb9GCHvQwcJy/lXWGK7vb/JJtNAKMvkU2IrcIPPsBt/lQn8XBuuxK7
	2WbCVl3GYRKbImfHfhqKXf06Jxc2Ee6AZ66XxgCNfTyfvAABYCJQ/T9+EdtKjZ84
	QMtBBM54VAU9G+TmUBo1UmWvVqN32GKsmLxRDhp55M6c/qNuU4cmeEhA5tUZo9bb
	/hxIonzt6KFXtGmyi3Hs1yF0QnTE7m5kJd2CcNvAZGcIxtX50bXFeUiU6hY/hX7w
	+vvxN/zhB1cKwcuN+bnMCi2Kavo37ZMHd4GWrC+In8z3azBMEvh9lo+hIExHCZw1
	eieGOA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenk97c5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 02:06:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35dacc40f92so4856469a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 19:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776823591; x=1777428391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CV7U3mQMJfVMAl6qflQ64fFOB5iGrhYZdBNtJgFLV5w=;
        b=LPvH9llmwjtHUdSs/QeeT9SrcvEITl3Xszn9zpEDwG5JQEkPvEty4Os7zinUjlAtmB
         sOurcOKLD40f9zcGGJsqFgySu9RZvHZLBdbLAH4YCFhNbUx9RDb2KeqhrBoqlVi/ZAFa
         zdUREeCoCN2uF+ww82n7zDEbR9iRXbP6Q/pK1P0NEB3FqCX6ML+riY6H6/iKaWkPfctu
         3NTGdLvU+N7zmRl1tLx1EMnWeyaPbpVWLMY5C4GWT+nlUtQWzaAouXUpX1B/OuTi8prq
         45nAVxMOKzyPTkFhgasAkZ2lZohht2y6yZBUYQw729FLyIjnML3PEIhRlVgj+yX6uO0c
         8mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776823591; x=1777428391;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CV7U3mQMJfVMAl6qflQ64fFOB5iGrhYZdBNtJgFLV5w=;
        b=bhTup9cxOteVxiVgWegZZM+4GXw9jM8t56HYIFexF8xpMSIUwE1JW8AAv3ZFvSK2v1
         Z9nCM0VWSRh2QJXHZNE8CjSWtn/iv/2PHfvUeHUmdQLvYhUkVG0caCya6RPGaI7mEoMM
         AjOFBDmqVix/cc26/cUIWrlxWHuPGEDYfhucnCRXoCcHdd8kZd2nNp4r67kLfQopdaOO
         5hjduYULmHF0J+60ZgS4GNqt1o7rgzF2i0+p99y6Q9Ti+fXbOXDSfmDg/FpeHPd24Xye
         YxkI3kLQq2kzqEz6h5Q52fHJN9dsllFPjHG3pkCvG1gBTUev5CDhDbXtS3HxOnpwV2i6
         l+bg==
X-Forwarded-Encrypted: i=1; AFNElJ9zCqL8IoxIt+SmXYxnzHyz1NcaSWGbIOevvjRTfLAHDVAD7jQg3c7U//vcZJTabR4QG22VUoGWuCr8iruC4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyq41dEeIrSFoglNhVv99rGoNlahSjFUVgeSValjCX0XByCLYJ
	Yld2N/clL9xjdi4vjCZkEsyGI4kyHHDB06gny6cW0cOo3+rIaw/1xoIJ8ntDhg9ZxK9Bf4Gt76u
	uA2ZDQLnPunhaYNMmN3u5kP0MxpYPxHL7TohD6xMgMVI6prVTfIq28Csc/yw13OzT3opglw==
X-Gm-Gg: AeBDietHjSmeVWMeNNbCNlzGXrh4Zrvn8XDtvFnpa8kUh07hYfV9AqfLm5Yb7/8YEMt
	km/38Q31TmXu0D137+Ntu4lVviI0lLSPRnkxgqqsADnX4zji2CoRnjjQr9ZnFhMfs/ipMpCBXyF
	diSADC5LTKW1EEiEqY1l6CUOQiwwh1f4Y/15zkoxIjP8SFz1ad4kLupMPHNvUeKRucXa7cjl3+M
	JekGKmPmpp91DDvpxmMKg2Y7/X20NaxYTorXeRNClC67y9jftZ5KYDZYWYDX7uGEcqAZEn/J5Pz
	eXPlmkKuxKjOb2KUz9W7GFYyxQmkQQaWx5Art9oRhsMWADXroPqHWESIYsJh3ln414WkRdgND6u
	pXYd58rCWL6iSKlVYw2n/fF7YiMjFrEvFqf2H0JyTpp7d330eU+Av48KTvAqsbOyD4deNweSGJp
	gSEHdK3ExrUj5HQC/mRUB8/x9fIB7iaA==
X-Received: by 2002:a17:90b:4ccf:b0:35f:b647:d973 with SMTP id 98e67ed59e1d1-36140229b13mr20344551a91.0.1776823590614;
        Tue, 21 Apr 2026 19:06:30 -0700 (PDT)
X-Received: by 2002:a17:90b:4ccf:b0:35f:b647:d973 with SMTP id 98e67ed59e1d1-36140229b13mr20344504a91.0.1776823590133;
        Tue, 21 Apr 2026 19:06:30 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614371a7c8sm14933809a91.5.2026.04.21.19.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 19:06:29 -0700 (PDT)
Message-ID: <dd79f106-9b68-4600-9094-d962e598199d@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 10:06:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on
 PREEMPT_RT
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org
Cc: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421172500.1050754-1-asas1asas200@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OBFI6XYLCPa7zvK8wEhGJNrBX5QaGmuw
X-Authority-Analysis: v=2.4 cv=SONykuvH c=1 sm=1 tr=0 ts=69e82d27 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=CW9kBp-o2NpbEht7vlgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: OBFI6XYLCPa7zvK8wEhGJNrBX5QaGmuw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxOSBTYWx0ZWRfX6nyxbfyeVebT
 8GOXE6j7dl+FKJ/cUNeWz9Swdnab/572JGbb4pdI5kjLR0RAfS5ByRyChpaIvnNoAQaWp8rf7be
 NLji1fPwxdP+QD6WVl66B+h3BmOeC36BlPjaMb+E4Lic1cZuuC4bP9/+3yXQ47rZUz9PigyDhoU
 lhrhlvm0QjWWDGldnLkd0JZjalj8zq4YQnIix+18KDF70Je6IlIR0YE8qXbKSQXb6yI+6tWVH5j
 NZlb6ToXswtfCSz5/Zv6uU68qU5gwI+x1M4pGUzb9Tte1k7oDhHqsRVbdsnrm0IV1y59PZQjlnv
 v0YDwARcEtW5veevElcbiu76X/xqXWGV5PRhfskcyDePxlb6NYEtLqmkkQS/UHjUNzOf0/wxkiC
 DwOaZa47YGCBNSbOmyQB6QBoySMrjPfTuIhUUKwAJffh/lNQpOfSkHR4HfksDa17jlo3c65TNJ4
 Nq+YTumRqKZ7lU/fQ0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220019
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35199-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E7F31441457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/22/2026 1:25 AM, Yu-Hsiang Tseng wrote:
> Two functions in ath12k assert that the caller holds an RCU read lock:
> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:
> 
>     WARN_ON(!rcu_read_lock_any_held());
> 
> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
> false positive splat whenever these functions are invoked from paths
> that do hold the RCU read lock (e.g. firmware stats processing or
> mac80211 interface iteration).
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
>   - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)())
>     and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
>     read lock, so these warnings are incorrect.
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
> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


