Return-Path: <linux-wireless+bounces-38234-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xNQlCFHTQWpTuwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38234-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:07:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0436D577B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:07:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=d8bsqv3f;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=c6IwcDZx;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38234-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38234-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 295843006388
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BAC6FC5;
	Mon, 29 Jun 2026 02:07:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38940D568
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:07:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782698830; cv=none; b=d4l86rQSZ+AQQtclFoouAJ2XQ5EbGxlSqHHNfTRki59yVeHQhHZiLFO5l9gCA3ExOZI0GoFgQzvgurmGVHE1TfZnUxWtxGr/HX4m5HjIRIydVqh8QtaVhzwKm/4GvvqeMUVAuDm7+1dc1XNCM45G6i0Q84IypI+RS2dbi9zMB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782698830; c=relaxed/simple;
	bh=HT8mDoHqicQHe66yxCVT0pU7Xf9gOacxAsdaTEtTcqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdE1Yzl4u4eLSmeDgDWMIKF+fUcP9uDyqGRE57BUbysyPdKl4EP/fUi7HUGuJaqvErm94q4YrmVKBaPnptUxgwwu9zciiKgHj08hhLeTaD854lAUJyxRsVx3pd0J9Ol1riXccUJzXLY/y+Qa17EWFoXTjfEyTUlQZ/6xk2jBnxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8bsqv3f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c6IwcDZx; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM9eYP993273
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hSB0reBPDtDL99zajwr0RLPp3VzN+gGCdtccsuFCvQs=; b=d8bsqv3fLPk/qF2z
	tBG6Unqc6v3j5cJu8q8H4Lj3MOQEKHJKN4RK9zDk2QvwvUVYS8A0BtAcBssCERwp
	i/W/0RcZBuqBUbauvfOSaicb66OmnN5aFo9Ouuv1PYO8leX/4gOHy6qhgFCzYS4B
	h6RvWToBCwLNVW1t2Ei9wnUCfGVPPd/sGgfzBueKf9dk6bKNutsXEJFy476xpZtY
	jf8pBKCQL0AJGX49w1JwJR3SPxk5K1et76j7Fd/GUjqwgM18CSeq3G7CcJAfPnX/
	i2VUFG2ltDw8399bMVqd20d+nYh1VA97Lh1G4nSskGsD9G1UEj5Um1Tf+RTRtTmn
	StM05Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u7452a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:07:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37e4045395cso3127723a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 19:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782698827; x=1783303627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSB0reBPDtDL99zajwr0RLPp3VzN+gGCdtccsuFCvQs=;
        b=c6IwcDZxzGp7HrWfLT4YXJeiDKvwRT08A+kFjq7uv33MCkTuWB7FGY0QW9qz6r2ECj
         D3Rv5LASvrJqdySjmMIVagFbIqIqZsRO2hRWq9cadtINX59PtEax76TLTvm8q4pz7Qwt
         Wcm7c0EcuAFsduQMr32akSKBhYa8+4MZMzEv2TBUSYcDrX4X/ePhfcHUKOqZCt3OtI1l
         0yNEYBadlwI8I0s1+dniCU/Y0+BjV3cfjcOssX92huRFmOTRNGNUzoiZF/hFBo2c3IxB
         j4vMojS81ViAmSYHAczQRfSntP/5PGSn3gHtdvKFyXiaDH6xq5Uor/7j22w+vteldN+8
         sBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782698827; x=1783303627;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSB0reBPDtDL99zajwr0RLPp3VzN+gGCdtccsuFCvQs=;
        b=mKyUfYhy0Xb/rH3+wIZa7FzzSSgWC+r9sa4l8Cmym53xdBM9cRldlORZOinE5J/bt9
         +GvLUIOnU1clPIg/i43UOaH2Sa1oYDELpUApiaLbbKuDrN8jBQcjYSiRNuBjFKuYsV31
         tcADVUnx7j8vZ16H9e2VdUzGug2gz/IkjJiZD7bIyrL6A2L8HCFTmpOyYdAg2Ple6nUb
         oSq1FgSMDC76zv6cx1jms63+G6Ftl3psoPtnRZx3VFvGIDmGrLV+fxXotyM5NYYMaTQv
         HP4YApX/4kllLVFfKiuCq1UmBPUBAPJ+Y7KaPBid9P3ydbWjbgF/L9aohNWqZllgtjga
         QaJg==
X-Gm-Message-State: AOJu0YyCe4aWsOxoAR7OPmKGqsSB/13jtABmSth/5IPuOKVu+VlVZf7J
	giOO+JyCrLqM0uKBWdJ+viv260v/7yhSFeHUGqdLlvy954n3nLVAnMrkqazbs7bWzzLWooI2NtT
	xERuvH+6hpa2YNQR9StQ5tHS9uShPB1tjYXkKpaUtOXwe+qcvNTSEGrk7zXiiy3qwxy97OA==
X-Gm-Gg: AfdE7cnYXOPw3nFjHUan73k7lPTIb+DVnsXzse47bGNTD55vGHq5PnzpvpDOWeAQeDm
	3Yazy9mMET2RZVaq+m6XPtge1fzYUGfp7DaTt4BHoCmWLhVsiOsaqQ9as7+tIVcN2K1auviZkEy
	0Bty2Rp69YL8p/ONR+PYNABPaFzHCxZyI2gCWD6w81eFQWXfuhtMQbGb8NhFftvv60g010xqug0
	OdeqxUP6Te7xLhyXPBNnj5e3efx4WPcH+Jliekfy8XelSOtB9u3oy7cYDehKBQRYvXEG3xdDmhq
	Jog8wVO6yisKADnss/vRXGb2FUhrQMJFUjsm1pmbYJf3aGeYuNflRVxYkvZZ5XgJGMqpYqivh6C
	61u3neqNRIQNbsz9GIZtr1HlMnTtBj2EexpnzgXu9bW3a5IsO0bD8hiya/KHy2RZPcywRPaHU6X
	DzMxrRsg==
X-Received: by 2002:a17:90b:5109:b0:37f:9ce1:cdb3 with SMTP id 98e67ed59e1d1-37f9ce221e2mr6559146a91.33.1782698827294;
        Sun, 28 Jun 2026 19:07:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5109:b0:37f:9ce1:cdb3 with SMTP id 98e67ed59e1d1-37f9ce221e2mr6559124a91.33.1782698826868;
        Sun, 28 Jun 2026 19:07:06 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0d10sm6787856a12.21.2026.06.28.19.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 19:07:06 -0700 (PDT)
Message-ID: <ead6f52e-79f1-48be-b068-2e3240717b6c@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:07:03 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: correct monitor destination
 ring size
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260616062342.4079796-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260616062342.4079796-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAxNSBTYWx0ZWRfX4HKFSMyOH9C5
 p98UkrlstkIJW11j9Fh4zL0pfS4TuSLkDao0+PzvlhWutaNYI/dou37LG7WYbKx7CuwLwAL2Vj6
 BCn4FC2zSdHpu5vz+WzJXwdeemTHMSY=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41d34c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Fhynap_7OlJaTk1KeccA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: zgbfum8TOg9yPrAeocg-O94DWJQg3rH-
X-Proofpoint-ORIG-GUID: zgbfum8TOg9yPrAeocg-O94DWJQg3rH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAxNSBTYWx0ZWRfX/kCo1vCrNySv
 EzVtWtfDfm/l3kMl6TkYi87bVF/E4M+lNCiLUNdEfo9Xaoa+Y4L4Tbn8eYuS6vs4fxbyUwLlGjx
 PS9pUvAvtFL6KbpoDgPfT/TMreElngVquJBm69yhfLwWshdiUFAqNPh4GeK5jp2nQ0lRIJ5K7WM
 N04AFVcpb6HTp3QIx621vqbB8P5TQES3gWkxGstUQ2dSXPjXeEkamsuwtvmjca1J7orfXQjKYsN
 uMxOdm2fh8LIPq8mhV9SsV5TPrQiKrD5Xr8Ymh7+UvCYr2PetgvjmxThWYW6BM57s3tz/ZQuwiQ
 5vNW1v+auVrRB3yoI97jnP1j0iuIgfQGrr3eoOAvXye19jFIe3DsDGYEcLO2iIgcyFtweFWw2dF
 uAi6lzOcH016Qet2ibYHF3rTy0w4KbBdneAWnsMFq6duSOl1oFcSFbI8K12M+QzIZCI599ijPF3
 PL8X9ZYmTfX901nwxug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290015
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38234-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C0436D577B



On 6/16/2026 2:23 PM, Aaradhana Sahu wrote:
> The default memory profile configures rxdma_monitor_dst_ring_size as 8092,
> which is a typo. The intended value is 8192, consistent with all other ring
> sizes in the table being powers of two.
> 
> Correct the monitor destination ring size to 8192.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Fixes: defae535dd63 ("wifi: ath12k: Add a table of parameters entries impacting memory consumption")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

