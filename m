Return-Path: <linux-wireless+bounces-38940-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0HuoIUiPVGpBnQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38940-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:10:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1A747D02
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:10:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=djAKuJfz;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=fx2K+MRk;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38940-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38940-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E23B3014C3D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6465D2D29C8;
	Mon, 13 Jul 2026 07:08:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7533E35C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:08:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926528; cv=none; b=DklhqjBmhnayv+WqBkzhOGWng5/hNW1oNQRg3ISUzTYyU8bGWVNidLC2Oa9Ljza5WNpiNj7u+Qh2tt9xd6t//DixWINLPIHxaH3Myl8SWKQTWyk+UDnSY3IVkEIkiXFhPI5gKmefsULTNtH/d9wXUp7CwHQXqDN9E7GgmG74fT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926528; c=relaxed/simple;
	bh=ee5j23bkRpA3eOnJyytZPQ54byxg+5gbYuIQcQjFI7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJ/G9idZI73rMOZehyn20cLdDx7k5eAvE4DNE+uK/7Qj0+L5o3RTmOWV9wMdiqFUOl/xAIDHmVZ7uU1ar9vw9ROOdbGjpxZlRbbfbmNkhtvrsYqV5rz7IMoTyR8Y5T9bKT4PUt2icjBdtKlpEvWJaRhFN2RIpS9qJ0trMYYNMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djAKuJfz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fx2K+MRk; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6O4ct649085
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4u/s5vioB7slJokzjYeAG8EE1aXJ4GsiGsD2uGu5Yak=; b=djAKuJfzIHL19nS2
	HVyqcGqzIh+2vEsjqbVWPi/+BaLGuFwbkKDfmYRyviOSPwR4O9fzv5GgCiltbl/H
	LX/9iSJON6ebP5vqgKswK38t6HXkFtlC+Nw1H3nhDUqgmNKalO14YgHG/fJmVb6a
	RQxXrgjqcQWRQtIRa2E9DWbfmshd8/p1LPWQO/KvFNj7jd3scfcMXTMV3PouymAZ
	tqCK5o2UiVGJ1N5z9CeOaHnoJVpzriFs/0wUXCTD7MFcezCYT0JbQgkFpP9wDnII
	PwiUoLADrcpV1nuWOWQY4H+3eS562QwWimmx/BPRjZcz9MZJ0N+In+wYRY85OJSM
	KbyuyA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr4sjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:08:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-845317fa7e6so5303035b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783926525; x=1784531325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4u/s5vioB7slJokzjYeAG8EE1aXJ4GsiGsD2uGu5Yak=;
        b=fx2K+MRkX7HS7vVcTexjdiy/hjbo9B2FN029YwR4hqY3hB4OfyeB95gDSuvtB6zqOU
         YgzQiXtzz/yewjb66+bbV27LXfOIPN5mj80DxJdc75zp26ir2mXsMJg9dNe2bAjvAYzq
         7yenBnUIX0UwoUlsqSgnPVVS0EzEc1PnJaeJaBeCKv8K595JWmbXkNlzP1Idw3QjjGqr
         BZI6GIfE4xgQpkWztoOzKjvu344GKINCzjhdcrjThnYnnCjUq7tgT0Ek9crL4pmMRIL5
         C87reEwZolhezVs0w62sI9iHvaV2RKuKmzJqdKQ3UBg5ThlANgLzWFeihFoAz025y4iD
         ZZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783926525; x=1784531325;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4u/s5vioB7slJokzjYeAG8EE1aXJ4GsiGsD2uGu5Yak=;
        b=ieSSlzZG3ceZJ61hPmk5nKLsFbqpSt+1jjORCmSIzJQeh9i3RB1qdCpsoPohjAG8Db
         2KtfUSJGzX/IDG6Uk73gDI5RC+qG2ANBn/+QBvl2EKZMvC6TVVBSG+jz/tsYYOyTEr3p
         61b/zMt6wuRm5KQ1t0FBoa6b8rw7rXCWdgZ27vspd4ZlQNuhlorAc5gg58eOgZLvu6N/
         coDxJkT+IUtc0q+5pW8EB+jaT52HWdt6roW3zYaKgE48MLgNAlyI0zdx6E826KHAx0C6
         qhpRS+4ZLH2tOip1U5n/843dt8iWLiCK1lfdBZglxD9lfnlE6wQ4SOJXJ1l+84etGSa1
         v5hg==
X-Gm-Message-State: AOJu0YzteHZrB1WUxlzGqx8S3weU2O0q/gfK5+DpQoozVrg2cpm8NoIp
	ItNmyQV+YXPCd6ArZAh6Wq72gE8I1aWuRqfV1vdoTHEsZLAfLmHFgO0jfb/CGXO2mrWEcE0leY3
	8ATkFBvmssWkhuIL0u7HN2BV3eai77EPPNoA1j2yGfxjxEs67Zq/bDQ/3+HAJAHF9h2JBtQ==
X-Gm-Gg: AfdE7clj5KUVtX0oiE5OUZK6kZdi8HPM3omFMq7xEHUA+95QeRILvlpB7GhHNOkFp6T
	4n3TF6iQ8w19ag0GT9+Kq2evAry/aLFdjzydhoDdDLHdqAnbDhR/vS3wlvbnOnDXKKSJClWEvjn
	QJ5BsC87nt4qCQRthDxaQmIbsXrATNATBjGd7ZVmyvNR6n+yWKRbsTF1SlCf3GMxibhkNfMpkBz
	3fPb33OnnlR3+6gF2+VilmfBCcOdM5DjZXPstArORlkwEaKP3JEjP7J8+0coXhJDL8q9sPbbsgE
	I4IokHMHbcTpPpJYm/eQQNRAYuCPd+r5bKcmiRkb8ZUrnjkwyRU8Hu5HECL7e5ZPPhxm5Ik4G+l
	CwX4uX2mMICCJhyIG3X+mMwaDuFXZBoSbwQRPSp45RRpyPWjpjzk=
X-Received: by 2002:a05:6a21:4593:b0:3bf:c49d:9183 with SMTP id adf61e73a8af0-3c110a10104mr7293973637.50.1783926525328;
        Mon, 13 Jul 2026 00:08:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:4593:b0:3bf:c49d:9183 with SMTP id adf61e73a8af0-3c110a10104mr7293947637.50.1783926524857;
        Mon, 13 Jul 2026 00:08:44 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm69540823eec.30.2026.07.13.00.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 00:08:44 -0700 (PDT)
Message-ID: <3c5a3c56-78d5-490d-9b14-c1100c2c0dcf@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:38:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Reduce RX SRNG interrupt timer
 threshold to 200us
To: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260622062324.758533-1-thiraviyam.mariyappan@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622062324.758533-1-thiraviyam.mariyappan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3MiBTYWx0ZWRfX0dFJO7VECfxp
 RvJlaCNdkyk6duvpbnTdhaI0/Rw2gMI0Y+xQ9SkHSatWfE7KPc62i4AdqYjqGEDV9CAU91v0woc
 UlBxyvkVSv4Ua2U5p/WCGeG9TVN9PBs=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a548efe cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6v9ovjmckxnE5_8N7CcA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: lCv81O_Ig4kB80JsqLO4varVNMjByRvZ
X-Proofpoint-ORIG-GUID: lCv81O_Ig4kB80JsqLO4varVNMjByRvZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3MiBTYWx0ZWRfX+FSti6dK/v/q
 WHA9NU9ou9TFaL2dPTKusTOV/EGLgp9TLkhc9qMA67A557fWl1USH47mAwYeM3COzwjJWbXKy8b
 CydxiW+nDLO9j7gR2N4qs6B/dAybGdAYXNjwoqGOxMkkNKw2eDsaI5PUviYsnngkPsexFXy6c9y
 1OAVs0XnmJYlcaq2ox5KYlyEs9aLxBse2jBX0drHZRNVANbYzivdgY1gPyD03igdMU735w+5N3p
 6n0gEN3u0hEGDmb7WcHMQMx9bp/EkTBkD3oLnapKwthVDrZOujKLJ13c2tbxlnAZCpvx49IWfz8
 4OPGDxtr0jRE7cbtzrLv0g/pp9yQNnOi7OJIk6BnFvQpNwKSy3tYNdZ42yC0nRqSn9VF8N30ZRn
 mDFj+mZTXy9cqCpqdqvvYyP5lVNJonJMm9XoVoX0LRk26+rrvVURA7LZgqAOagvhoBuNIS7O0qo
 nO+UHd+yN5u1HK2UVvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130072
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
	TAGGED_FROM(0.00)[bounces-38940-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:thiraviyam.mariyappan@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EF1A747D02

On 6/22/2026 11:53 AM, Thiraviyam Mariyappan wrote:
> Currently when RX traffic is low or intermittent, the RX SRNG interrupt
> mitigation logic defers packet processing for up to 500us via
> HAL_SRNG_INT_TIMER_THRESHOLD_RX.
> 
> This causes excessive RX servicing delay, leading to increased end-to-end
> latency and degraded TCP performance in low-concurrency scenarios.
> 
> In single-client single-stream TCP tests using 5G EHT160 (NSS 2x2) mode,
> throughput drops to ~400 Mbps DL and UL instead of the expected ~600 Mbps.
> 
> In addition, UDP UL end-to-end latency measured in 5G VHT80 (NSS 4x4) mode
> increases by up to ~48% (~570us versus ~270us) across frame sizes from
> 76 to 1518 bytes in uplink and bidirectional traffic, indicating delayed
> RX servicing under sparse traffic conditions.
> 
> To address this issue, reduce the RX SRNG interrupt timer threshold from
> 500us to 200us so that received packets are serviced more promptly under
> low-rate and intermittent RX traffic.
> 
> With this change, single-client single-stream TCP throughput in EHT160 is
> restored to expected levels ~600 Mbps TCP DL/UL and UDP UL end-to-end
> latency in VHT80 returns to baseline values ~270us across all tested frame
> sizes. Under high RX load, no throughput regression is observed, as RX
> rings are already serviced frequently. The primary implication is a modest
> increase in RX interrupt frequency under low traffic, with no observed
> functional, stability, or performance regressions on tested platforms.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>


