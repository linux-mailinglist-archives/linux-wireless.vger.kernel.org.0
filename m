Return-Path: <linux-wireless+bounces-38558-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /D/lBWVSR2qVWAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38558-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 08:10:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DFA6FEF92
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 08:10:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="TcqkF/Sd";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=XQRFJqfn;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38558-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38558-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4027430209FE
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5035677C;
	Fri,  3 Jul 2026 06:10:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24153630B7
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 06:10:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059022; cv=none; b=o9oU78G7zkqgKc1xVAwmlHjzTPsMnf2BSPeP9HSW6vx3TDFqL+jCavnUUM+xTs2o1N2LDjJLu1YSfcDevGidnhSnNenVc7heOie7UvAUulEZUW0kBIuyXyyctBLVgFBuxh71VUQlKEC7KKGWgM1ABPZkOznr/LEUIKJw3g8ywJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059022; c=relaxed/simple;
	bh=mkd1vWv5tHiSz3BDpy6xV7yKOzm+YCtkI/YICabXU24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvV/vwNDTl2DoSStcfgC2f5x6thV9vjmATINubVQrMds2XOHs9i6SmslUwFR8jcT7rj5eQ+n25Pxv2NzAhKS5oEsdzt40dBN/9ksC3kXWVKYn7gGRiBaxv4nGFy7/8RE1lztf/29h9ZMzLCX9BH2mMhAs1tkmhwyuKdpbJcPq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TcqkF/Sd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XQRFJqfn; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rsrm3147562
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 06:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	++XPPP0QRe3kJRFuS+h2UvRKvVMN5ddGc1ptzBceeAk=; b=TcqkF/SdDjtK8LEJ
	UIl3mVmaJP4WR228fhMH89/eahdLi0AzEAjAbduTu+rfiCjXGDefrsViwXdjYjA7
	lPpRRVBh4Wm2NXVhHRtsP/cQAB6A3v3g1cGQiuGzoVffUfnhNrr0yocmvvC9bHtV
	OGPCHW11wtgV6cAOT66/IucFAoLOzGIPnQuXd/yA1MQ6HmpkluodivkfyuMUGFmt
	tPqhPEtExBG2Z3i98VR54l8qI0O3PHRTmYzFmLV2Q9vYu8AP67u79IS0wzQ01bGc
	2l+dB4YgmirvVv3jexZOKl/kC2aasOcdU8Bsy6kQ4gvt70w8yfnRWsxifr+ftR2m
	nOjvZg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwvr3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 06:10:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-380a0925d7bso434150a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783059020; x=1783663820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++XPPP0QRe3kJRFuS+h2UvRKvVMN5ddGc1ptzBceeAk=;
        b=XQRFJqfnkBx6JFpIBg20ZBvfg5JV/S62gtUM42eDQymldmvZu9138tPG3Ond1aX55J
         M4W0lR5FeWWfx0RtYInwr7P0GhYerhdXlCLXVI2JByk6N3zuEWH5GBuaTBucWU0ifreO
         AcRFmruyBPGjkSX2bi6C/xgwP68fqUln8ES1d+BYezzrGvPdxAXHG4Bs3EvwzRkD4wk3
         vMq5GqOGKXmYxjjXhsGMA4MXnqau5ufoO4CY+bgZ+sCoPkda1Hf4DWSU/eVk3eCt3bWk
         UaVzoOLw6upBsMh1cj2zVpQ0x+VftiMOQgDHGYBqD9FgAoqeMEvZeOBhU3OJJVy/e9ay
         10EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783059020; x=1783663820;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++XPPP0QRe3kJRFuS+h2UvRKvVMN5ddGc1ptzBceeAk=;
        b=NLtFAr+rADGktQIflbaRkXI7HCaZWe36uo0LKnDV8Iu3r8dlrrznjeNSzAW0WxP1KP
         f4NOAL5hMx9up/r5SMdMQbu4AQxAWcUiazyc/8sMHA/IPmjuOvGAcNxbxuolJDaotIKI
         zszfUMU6KMlcZJc6/Gi5vKr/AzgvSHObK7Rt6ilzajVslUl7qUb4plU3EFTPR2Toius7
         nIWU6twtd8Jb70qmGjErPdgJpe+8reThG30Jn7icbsYI+508WeMfWFbULckZe+YWd0Tr
         34NRIVdUWjcwL0O/vh4IfAdZ4l8rs1jmeWKEOJoxn41FflkD301KAm6nGEdgnXG9qOul
         LOQg==
X-Gm-Message-State: AOJu0Yz1tN/SwR+OlAAmVORrrXRurll7xFNMx4A5RM7K3xj74CSAtHD+
	uBy9l2AoJ1ZGYMl6US9bCFXCXKps0ULaNHPMXOFc4Nfm9x6tp2KmYGarxYZUdneDNw5uvvsazCc
	41gkS34rHLhnwUkuFF0FYFra8uL6aexhqXLXvZC9jsSe91XiR1K7a05+E6Bg80HzuSr4tmDvT0r
	SeXA==
X-Gm-Gg: AfdE7ckCEbe7VJReiKsvZ89FLAwdyodscmRCbHkuyMdz/kGnl0wmm0+zujXnuDQhQJ/
	TJPLkmhlF59u7NyPgEJrDP4mgz7Vpl8qSbq9whLULVIFIOOfpiNHjFFgei2M2Fs7SjXdLgmTqAC
	cBOF0AXp0xvHL341xBoOBT1F7S0JSy+qcNZEwvULkoqp+xb2hS+PS8kAk2Cc/elOcyzpYlr97u1
	PUAoBAuAbF20njXcbMdChv4QcFy3A3L1lbHlaA9QahGKi1Zzq2V7S6LDT72Muc9JBQiUqkZw6fP
	+fKGOkVnQcCo7k71N940q2PRdnT8lzK/0vy0cRNiUHwJ/KCvtl4dhWRLqDzlEKmdt3Y7egNfn81
	EhN5hYH9SNjmaY1LHMmPo0Qq3886U3It+QXSOin9GbEh5J6EEQvE=
X-Received: by 2002:a17:90a:d888:b0:381:270c:4dd1 with SMTP id 98e67ed59e1d1-381270c525amr1564653a91.20.1783059019695;
        Thu, 02 Jul 2026 23:10:19 -0700 (PDT)
X-Received: by 2002:a17:90a:d888:b0:381:270c:4dd1 with SMTP id 98e67ed59e1d1-381270c525amr1564603a91.20.1783059019187;
        Thu, 02 Jul 2026 23:10:19 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b86ef6asm18069022eec.13.2026.07.02.23.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 23:10:18 -0700 (PDT)
Message-ID: <f432e443-7df5-4727-a64c-b9460d8c7487@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 11:40:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix low MLO RX throughput on
 WCN7850
To: Yingying Tang <yingying.tang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
References: <20260610053315.2249912-1-yingying.tang@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610053315.2249912-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9iesD4zt39vKzdbee_YJVJyQGYNPu4v0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1NiBTYWx0ZWRfX7iw3a1isAf6B
 bMM+9ZAAfHFN/JclsWoaXVCfR/iDIYoPHZBO+5J2uYlOGM0Vpqe91HSD2SFpKd+Fu/lQBgc0vO1
 FBKXNH05Hm95LLRRhZhFcP627vShLRSirpOA3jPlXU9E1ef22fwBNkILaU01+d5sj2Vr/s8kjlP
 Vf4pBInF3taq94J7YP1zCCoiC+w0PKfabkctsXjyU6RpRzMPcopVyUS9MEEIcY9wIunqTGJkEk4
 ZLQr3iacYEX5C68uXOfd5dPbasECdEhlqwhVQLGccWWwvR6IF1xUBHYYNQMT7kfIbpkkbElI0eT
 mcPZDs+Efibt2T7arOc8oEe477rowgLgEWsoCvoFBdtiCVKc4+qB+Dl8rA8WqmQAKlvrMnBBqSu
 n+AVJHHzgPbR420D3gw/R/wn+bRDD1rdfU/JcYyZDo6PMjjyog064qIPMx/YnyWokzbfphLRR6q
 gn5GZoJ/vhUaLv4n8qQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1NiBTYWx0ZWRfXyUJvNPtNdr8B
 qFDCohTRyvAg/5RSFYVZ+lIXIVwRmuM3f2gCkGvgXMYKp6f3rDvNwpd+yt20WSI+EXYl/kA0+y+
 KUaqML1Y36KBuCnoAM8t+R98leOukVw=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a47524c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=OnWgCjIbBKlE7jiPxrkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 9iesD4zt39vKzdbee_YJVJyQGYNPu4v0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38558-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yingying.tang@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:yintang@qti.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69DFA6FEF92

On 6/10/2026 11:03 AM, Yingying Tang wrote:
> Commit [1] introduced a regression causing severely degraded MLO RX
> throughput on WCN7850.
> 
> On WCN7850, there is only a single ar instance, but MLO uses two
> link IDs. ath12k_dp_peer->hw_links[] is indexed using ar->hw_link_id,
> which causes both MLO link IDs to be stored at the same index.
> 
> As a result, an incorrect link ID is assigned to MSDUs in
> ath12k_dp_rx_deliver_msdu(), leading to severe MLO RX throughput loss.
> 
> Different chipsets identify the per-MSDU link differently:
> 
>    - On QCN9274 / IPQ5332, the host owns multiple ar instances and the
>      per-MSDU hw_link_id from the RX descriptor maps cleanly through
>      dp_peer->hw_links[hw_link_id] to the IEEE link_id.
> 
>    - On single-ar chipsets like WCN7850 / QCC2072, there is only one ar
>      instance for both MLO links, so dp_peer->hw_links[] has just one
>      valid slot and cannot be used to distinguish the two links. To
>      resolve the link, walk dp_peer->link_peers[] and match by
>      rxcb->peer_id, which on the link_peer side identifies the link
>      peer for the MSDU.
> 
> Add a new hw_op set_rx_link_id() so each chipset resolves the link
> on the RX fast path using whatever signal it actually has, and let
> the op itself decide whether to populate rx_status::link_valid and
> rx_status::link_id:
> 
>    QCN9274 / IPQ5332 : always derive link_id from
>                        dp_peer->hw_links[rxcb->hw_link_id] and set
>                        link_valid.
>    WCN7850 / QCC2072 : walk the link_peers[] of dp_peer to find the
>                        link_peer whose peer_id matches rxcb->peer_id,
>                        and set link_valid only when a match is found.
>                        Otherwise leave link_valid clear so that
>                        mac80211 can fall back to its own link
>                        resolution path (via addr2 / deflink).
> 
> For WCN7850 / QCC2072, walking dp_peer->link_peers[] is bounded by
> the number of links actually populated, so introduce a link_peers_map
> bitmap (unsigned long) in struct ath12k_dp_peer that tracks populated
> slots and use for_each_set_bit() to iterate. Non-MLO clients hit one
> slot, current MLO clients hit two; the full ATH12K_NUM_MAX_LINKS
> array is never scanned. The bitmap is maintained with WRITE_ONCE() on
> the write side (under dp_hw->peer_lock) paired with READ_ONCE() on
> both the lockless RX read side and the write-side RMW for KCSAN
> correctness.
> 
> Also guard the dp_peer dereference in ath12k_mac_peer_cleanup_all()
> with a NULL check, since peer->dp_peer can be NULL for self-peers or
> peers not yet fully assigned, the pre-existing rcu_assign_pointer()
> call there had the same latent issue.
> 
> This restores the correct link ID on WCN7850 without changing the
> QCN9274 / IPQ5332 data path, which keeps its O(1) hw_links[]
> indexing.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 11157e0910fd ("wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths") # [1]
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

