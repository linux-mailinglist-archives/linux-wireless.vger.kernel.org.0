Return-Path: <linux-wireless+bounces-35566-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJhZGOGo8WmYjQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35566-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:44:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167D48FE82
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36B31300D752
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8BE38644F;
	Wed, 29 Apr 2026 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ohfwEG1e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dc3dWc7j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152C34F247
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445084; cv=none; b=HpIVgR1eHQ1xM4d1p+ti3Qd0PRWHbSSLTW5sx3eoLd9OCRs6uIw2lvjLDEm/0akx9u/ijYzJ55WNruwzsNQQD1V4L2vv/87DUKGgvp+kuFY8r68kpR9Jk3dJlVNb92l6phUUWE3mbEPi/nGKmaEk4GEiGbGcCnyGhJrcdMNyRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445084; c=relaxed/simple;
	bh=JoeSN6KQy4Xm20gveMDSYGDVITX0TxffB6Zp+kINjZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoUxa12JWJH1auxCsqzo9p256adtUWwT1ukhhYCeiaRPeN7hVW7gFgBGYwXqAw6FYFSm2Sho1BryjKq8SzKBGw3i4AAQKe9imM2XYCCktG3QpZIY3KugO/701+FIQ/2X+9Gx7q3xMQDHF7u3Cd8QZGUP3mG8iG6hTKIfd2AU34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ohfwEG1e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dc3dWc7j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2P4Na2984630
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9FkfAicNK+xxJU0pMDfP1tqNhyH27XrC5vpFh8M2GdM=; b=ohfwEG1enYJL4IfD
	W3YZj9G6eK0Dt/SUFyNq9tj4mwdLioztK1JQ4fLUc56fuq7+37BDSjXCstJZoUDo
	t6Khf4Puam1vb+v/XJ2A7Mh4styly9wv3qanU7hgCyTnYGGznTlcM0UsDpD9LnTq
	6QREfYiGw6v61breFhvyxdatA6Sk1ge4MFIP/G9eq1JFOFnMXRMQ4GXlIxBkI/VP
	MXe7/QVuvF/tIVBzi6OvILColhNVJsVm1rYy8ewLlcoxLhsf+z36AuUa/BZx7Q2y
	Z3V06vL4Fz7hasRspxyyrf75RFJj6HExJ7ZDe19wjKoKwnbhSAHxL81y3MUxerYq
	9GsKhw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0u1tfry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:44:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35dacc40f92so12509692a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 23:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777445081; x=1778049881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FkfAicNK+xxJU0pMDfP1tqNhyH27XrC5vpFh8M2GdM=;
        b=dc3dWc7j9UPEFnXxHesK5D3PAfSo1h3viYqYLbASEJg51JPTHrptxfqlJd5drWYbbQ
         T5vSGVdk8IANaqU/goXQBCSfi+bUeIvY9kvHkvw6aC8nG6NKUyP3wlSByZ6kYWFcakPb
         xOBYMji0GzD0f/VKydao8CgpAYQfJ6FvfrhegWzWBgmqKfmCwwHlC+SsmWOK3Fz2q24F
         IHrtbWi+za3SDT6r4Icd5PcquFfvO4pztWWu6NzUoaDDKp5UDg9EvxTQW88jbPc7ZU5z
         ZJ41jmxl3iTg6rL807ZpPXHLqHTvRhJrrT4tY+Db5bwjDSfSxaY72f3du+N6GVPE8fdT
         vVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445081; x=1778049881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FkfAicNK+xxJU0pMDfP1tqNhyH27XrC5vpFh8M2GdM=;
        b=jIeTETLWnMKvy9Ft6ZSo1BahUNPmzgBERFivsvn4zHPf43aRb8azT77OPbxHNF+dqs
         pJ5xJSjmAZ3SSlRp3EyqNKN503BLBk/R/A9TAhov+EJYncIYp8XICtnRGkwkgnWHnft3
         oiwwpgHCxEd1HhKe3HL2yGiqF+mxfBVueArQNVlZetWfUbx8zJy9YLZ88Ww+nwEnWXxc
         iw286m/h4PxvGO21J1ZhkAFNqZnO/hPQIYFtc9dLfZiJl3rc8nlkoWoYr8GSZ7TN2DVr
         tO5lx+ZbklPg1AiR8BJfjj4NK5UJMWe9gW16U6zt7cu1WUFLmRS7j19giEgpbpdqAr/R
         Z37w==
X-Gm-Message-State: AOJu0Yw4eH+9U61L98b49u8CtFpEvD3iZXZF8i2/7628QDUjJaueXV9l
	S2MEHLtzrqap+enPFI5THaoOkV511PFX7gHx4tlcivfzm5/nWV8lalF/qerrssPpv+9LMadG+72
	+4aCOqvVZ9VN2OyMxJ/9XuxyVLYfrjrvABmtsQTbI8QUSgv2etHLUD6b9PCY3pZl+cgBeXQ==
X-Gm-Gg: AeBDietQ6KjwZ+mYZSN7/HepmsBmm5HHvAsyd48JVssK1pGCHzxYNE53YunjPUT2bJI
	F/04onkluFBkwANM1kEJZ4iuMSJuPkR7parjsiXUUvVpi7Mt6kIec7FsZula7Itlco9oxdObw9o
	fPrxD0nPgwf2RkcjfbJSTyJsL7Z+MNbxAieE0fXz3wOFl7c570Sf6axVj3JyzYzSTMAqtzL79lI
	xdODnbg9lMvJKVZn6gGq9BgjATOVTVzHaKE0kuHJ8K0EJ1h6IkhR7XWPiA/vgJiVBW3tljuZ65n
	P2JPnYv2RWBJhzQ6UqFJC28TSxKh+hlrfhFneZlzVXeHeJqmUnaT+JXcAgqsi6QfxsFQasdP9rs
	Za6jc8tDCBTMVF3GvjVg/lfHhCp4Ppbrqx0TqkXa/4jeoRf3jInv4jDwVCLdYs1c9N5DpAJUH
X-Received: by 2002:a17:90a:fc4d:b0:35b:e690:c5ad with SMTP id 98e67ed59e1d1-36492064122mr6713258a91.25.1777445081341;
        Tue, 28 Apr 2026 23:44:41 -0700 (PDT)
X-Received: by 2002:a17:90a:fc4d:b0:35b:e690:c5ad with SMTP id 98e67ed59e1d1-36492064122mr6713235a91.25.1777445080906;
        Tue, 28 Apr 2026 23:44:40 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a4180219sm1159604a91.5.2026.04.28.23.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 23:44:40 -0700 (PDT)
Message-ID: <e2f56f43-9795-4930-a5b0-d3e21e9b336c@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:14:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix peer_id usage in normal RX
 path
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260427-ath12k-fix-peer-id-source-v1-1-b5f701fb8e88@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260427-ath12k-fix-peer-id-source-v1-1-b5f701fb8e88@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AypZDs6S0QMCUr59veky0mhz2ehfFVMt
X-Proofpoint-ORIG-GUID: AypZDs6S0QMCUr59veky0mhz2ehfFVMt
X-Authority-Analysis: v=2.4 cv=aPPAb79m c=1 sm=1 tr=0 ts=69f1a8da cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1ZjfdqP5A_V7aTamSN4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NCBTYWx0ZWRfX3xuHViDKUF6h
 Es5ntgvGdm3HiolxtK75CnED7+jG7xQug15Nya+tleXQfBaIxNw06SgQwf8CeQ/r/0SBDnvuuOc
 HJvIYpdP46IPMSfOr6Y1u+wrgQJBPFa9ltTvzi03vTRHQuNmVCTTwuatx7Jwolt5PQNYwV6aWS8
 jC0wp6RrWqkPn56xAVeipA7SnirQd1blxcGJeXRusvfIAirjj76C9YRcOJso4FUCU8n1G2zHlcz
 FP94MdO1+YXJFCkD8CBsPj3kmi9cDBwirQz+kKlFyv/rqAmFTyYnGLtOF+Lcy7RrBcO8JKmU3fi
 xfi8rnsjUPshpCPbbTfreoyVSk6o9/zPXwR3UHGRgRVujcx9e8QbI4gTV3Aj0hImpBgCzIYV/sS
 K7/f9uUIikz8VMbobbUYRYBZB/XaKU+2VVu1OSP4eadZQjE5DkTkwlMj/w282Tg4tAXW+ETf2y4
 0HX688z7fhtjd2gGgLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290064
X-Rspamd-Queue-Id: 5167D48FE82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35566-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/27/2026 11:21 AM, Baochen Qiang wrote:
> ath12k_dp_rx_deliver_msdu() currently uses hal_rx_desc_data::peer_id
> parsed from mpdu_start descriptor to do peer lookup. However In an A-MSDU
> aggregation scenario, hardware only populates mpdu_start descriptor for
> the first sub-msdu, but not the following ones. In that case peer_id could
> be invalid, leading to peer lookup failure:
> 
> ath12k_wifi7_pci 0000:06:00.0: rx skb 00000000c391c041 len 1532 peer (null) 0 ucast sn 0 eht320 rate_idx 12 vht_nss 2 freq 6105 band 3 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0
> 
> As a result pubsta is NULL and parts of ieee80211_rx_status structure are
> left uninitialized, which may cause unexpected behavior.
> 
> Fix it by switching the normal RX path to use ath12k_skb_rxcb::peer_id
> which is parsed from REO ring's rx_mpdu_desc and is always valid.
> 
> hal_rx_desc_data::peer_id is still used in
> ath12k_wifi7_dp_rx_frag_h_mpdu(), which is safe since A-MSDU
> aggregation does not occur for fragmented frames. Similarly,
> ath12k_skb_rxcb::peer_id may be overwritten by hal_rx_desc_data::peer_id
> in ath12k_wifi7_dp_rx_h_mpdu(), which only handles non-aggregated
> multicast/broadcast traffic.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 11157e0910fd ("wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>




