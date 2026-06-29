Return-Path: <linux-wireless+bounces-38248-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AMvJBBMEQmrKygkAu9opvQ
	(envelope-from <linux-wireless+bounces-38248-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:35:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A56D60EE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:35:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bzOQbjMU;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Jjng5Lf+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38248-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38248-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A2E5300C599
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97B390C8A;
	Mon, 29 Jun 2026 05:34:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6082F4A0C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:34:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711294; cv=none; b=aGeOgo0Kpx73GqxQJbsoKsDUWjnd0OP+FTbXwWhrfyrmjjwhjxZlQNZSiKfcopQBbpHwYXalMRX9r61ukyt1Q65AJMI4ezTJnGuGqoyh9frGzpGgbu2IDf5CI+HAksjnk4Pp4l7TQBmW1/3go3Sed59ZVHVWmMZQfLb1DtbqDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711294; c=relaxed/simple;
	bh=ozpgyVllnFhcSVwM+1sb7KjGXfx9AE7xXOXzrs4GcQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdkBFAFl9kBglim1ztzhUsg6E45sErnIx1tyyfxWvhhB2F5TNIYyxMWg8a4OOVCD6cKnvdUilwcwwap24F0pj+hYdD/YJoVjuXBkfqpoGc2OxmNlQ7BbRwcWcrBUQTC5PSmVq+xXhciU6J3SsVhLYI7EKnP1TjHr3eFqnN7z7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bzOQbjMU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jjng5Lf+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NOn41719481
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CKTWLeN3e3A/Ktk3uDpD+5joHuoTDHafQ8MpylGrLvo=; b=bzOQbjMUYQa2PjoL
	DPZ2RdYeqpAEKF66HZ6Z9OLlLP0iViaLzzq9EygXzJyansqdp6DwtA/llO1rwFGB
	dabCQ0bINdbdYa5A3PH9lUQ3HDMhdATW5+iTcV3hg8uLMZV9gJABfV1oMTYu0KGJ
	IP5Fq6FCH9PxNZDNHlsC/SCFkyESDHA+zJ+YPQHh8z9bynaODhiCXdvAVVLxhLpH
	f3vlcM0fsIQsTveovK8DC/jSPy6MGGZq50ec34ibVTctDcD//9quq8jPWyHwdNWW
	4bQ+nYefXC5il0MULp9pYDBb5ZxK+VJaH/H4UID8g4dZbra3rjlzbdcKKa8+cwQ8
	o+xNgA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf4gqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:34:45 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-137f3465368so3068128c88.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 22:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782711285; x=1783316085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKTWLeN3e3A/Ktk3uDpD+5joHuoTDHafQ8MpylGrLvo=;
        b=Jjng5Lf+HMm5E+pIHgTJRIEnyjPw4g4ntnIePRow70IvUwtuY1TtMyIu8KhEZf7QMc
         tHdmA7cWI5wWXVwLAP6hyIbVI2FsmuiW0LxbK4XlBC/PXGDJHpIOz7uqhmY4oSnHR8vK
         HRgXzej382UIRa+o4tRCx4LKUXODMWcW2Nnsi9gRyUO1UkxhMAZlgTFYfS7M4A+rPyL6
         oALMXz+/PNSzm+0KQGstk7ZU9SRdYMfqCl5rHXarZZNGPuw81jg0evRFRcvF8f6HN3Fp
         aGroyifcKTvFVt9n3FOVfBtSp1VYjWTIRRmF77/2BRa+T6vcXbvuLkyObYFje4MQxZNJ
         JRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782711285; x=1783316085;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKTWLeN3e3A/Ktk3uDpD+5joHuoTDHafQ8MpylGrLvo=;
        b=LTVtoDDtLZdJ74KyIGvNf8Kpw9dG1Wo3VpP8h/NjnMjdUPm2z1m01yeGNpcv2Nnq4X
         tc2Ts3+YjEXvfZVeHOl/cjlZANk15XNOFZXQwUeX3wbpfmEkjSVHj4m4w81hirJjUi/5
         /kA3+oxc62DIE1G1HKBPhvaHk49+bdZrMXYoe1GxKOB7XGuZ3x+8/tUbr4SAPqzescT6
         XNGDkuAC8KxNU0Xyj2gN4xtr7wvYypVCLPrk1jMwWloJr4IWclaETO7zc44u3G/Gq8wJ
         okih9gFgexFGS/M8pBFjjmcDB0WBIsu/vBeJfUU9QsaJ06gzUvWyxmd74Qnclsf5CFPV
         8GmQ==
X-Gm-Message-State: AOJu0Yxc+krOt4Z4GhaGPvRDVoN9aWKUHZWsMbnQxUXheJX5Rxl9PYNZ
	B1RpPgivY6q0cLAhJJ3U0Nnf2jnHJ/3o4o0qQA/IjC9F7Ko6Pcm/fr0kX9MtX2dvrdE8ZvkAu5m
	yp+zhf45i6Hx0rSpEGssBtJ8IKVhnkcEP3WqGF6ZtPkgU952vlG5Q4hLS/nY5ixMHVWHcQw==
X-Gm-Gg: AfdE7ckjTe0fFV0gDpuLp9CXtugJEHV93meWDDjGzStKpQw3T/OdkRe5smzigz5spOU
	eTSM29VepIZL92yZhgh9ZfwDRVljFq+3Qa9eSyo3oXmVH/n7pNb6F+1Zg88GFZG0JrcW3azJ8yf
	qiIR8AJr/60f8deH/1pM2r3hGedhqaBoMd0xc4rxE6ufqzS0w5RpxAlLXwUp5VD+7NaqUe7aWl6
	qthbGZfXBMDFBbq9Ld4xl/Dm88OW5BHArPj/nzbhze8u11OiT/ccLQni5E/jpLzYXepP7nQ+ms7
	UGX6cf30agKDnzzmNK4lPRpFgOqfzcfc7JYzowQKR8dr9Se8dCkAaYeidpSbTiPZlJIgCkbvyK9
	PUG2FJKdeSfRQr33mCSkY+q1y1qmIsj4M0ucI2QullJ3cYa/I1No=
X-Received: by 2002:a05:701b:291c:b0:139:f2c6:519e with SMTP id a92af1059eb24-139f2c65646mr2828391c88.30.1782711285120;
        Sun, 28 Jun 2026 22:34:45 -0700 (PDT)
X-Received: by 2002:a05:701b:291c:b0:139:f2c6:519e with SMTP id a92af1059eb24-139f2c65646mr2828381c88.30.1782711284572;
        Sun, 28 Jun 2026 22:34:44 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d912197bsm70060396c88.15.2026.06.28.22.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 22:34:44 -0700 (PDT)
Message-ID: <fa3d454e-e125-4aed-99a0-48bba9debe31@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:04:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/2] wifi: ath12k: fix MLO peer delete race
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com>
 <20260617-ath12k-mlo-peer-delete-race-v1-2-ab3c4f455dfb@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260617-ath12k-mlo-peer-delete-race-v1-2-ab3c4f455dfb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NSBTYWx0ZWRfXz9jafzfTWsSH
 zZhaQpGouH70s0GLOUK1ev5qxx/xS3hf8Jj2K1ezYrypcn0AVYNVKhKoGSZvPNJBfja9e5kS4wd
 2daTHFcRMb4nkC7wQhD0b1XUKCwalGg=
X-Proofpoint-GUID: Keyi_DMpIF7Qb0eWYfLEEvA3viAGZrUV
X-Proofpoint-ORIG-GUID: Keyi_DMpIF7Qb0eWYfLEEvA3viAGZrUV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NSBTYWx0ZWRfX4kuq15c4sGPq
 tActDZcyfbaT3ygTWlcmhzmtN390AxV3pOGpfl0pP38c5Mh8goaYt2CkDqIuZwoUwuFcZUZSB53
 F7a05E4MK30/Qkohbyvgk0g/GJamiqrJX5FAKEtOrxvnmIyNEJrcI7Ko9uIeNqkMlyI0/IVqmyO
 +BbD0AXblrbLAqAUCE90oeSdBYgmATDcZVzSwrjxTNph6/Ls4WTrc5jYSdxoaWpZk6X6CNNqPvK
 1LLczeIiIuI+FbxFkx3VjjEAWZLkGrOsAgY2hSW6t6eIJl65ooI8d8VtvxW/yVIdvGdXGBu0dMj
 w4VuVJsMOS2z80WJxXZdwvN05G/Ypd21zDTgVpbvBfe9NjwdNKOFoix+3hxBGoh1LJ3caVq3fLo
 pm5yrLvjg29OBnhT1SpYTc4CO6ryKQ2Bko5onMd0M38h+9SxfsmjEbAQYStfG+Zxp4eATRBM6NK
 kdlZhM6XAGSmujXL9hQ==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a4203f5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=aX2ajguDe-_I9IQFk3cA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38248-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 620A56D60EE

On 6/17/2026 2:58 PM, Baochen Qiang wrote:
> ath12k_peer_mlo_link_peers_delete() sends WMI peer_delete for every
> link before waiting for any peer_unmap / peer_delete_resp event. The
> shared per-radio completion ar->peer_delete_done could not
> disambiguate which peer a response was for: every call to
> ath12k_peer_delete_send() did
> reinit_completion(&ar->peer_delete_done), so when an event for the
> first link arrived between two sends it raised the count to 1 and
> the second send promptly cleared it; the wait for the second link
> then timed out with
> 
>      Timeout in receiving peer delete response
> 
> Replace the shared completion with a per-radio waiter list, with
> each pending ath12k_peer_delete() caller queueing an
> ath12k_peer_delete_wait carrying its (vdev_id, addr) and a private
> struct completion. ath12k_peer_delete_resp_event() matches the
> response against the list under ar->data_lock and signals the
> matching waiter.
> 
> Also correct the endian conversion in ath12k_peer_delete_resp_event()
> logging, and add the missing \n in some logging.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3
> 
> Fixes: 8e6f8bc28603 ("wifi: ath12k: Add MLO station state change handling")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.c |   2 +-
>   drivers/net/wireless/ath/ath12k/core.h |   5 +-
>   drivers/net/wireless/ath/ath12k/mac.c  |   2 +-
>   drivers/net/wireless/ath/ath12k/peer.c | 130 ++++++++++++++++++++++++++-------
>   drivers/net/wireless/ath/ath12k/peer.h |  19 ++++-
>   drivers/net/wireless/ath/ath12k/wmi.c  |  16 ++--
>   6 files changed, 136 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 742d4fd1b598..f71650039292 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c

{ ... }

> diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
> index 49d89796bc46..3dc720a3dc12 100644
> --- a/drivers/net/wireless/ath/ath12k/peer.h
> +++ b/drivers/net/wireless/ath/ath12k/peer.h
> @@ -9,13 +9,28 @@
>   
>   #include "dp_peer.h"
>   
> +struct ath12k_peer_delete_wait {
> +	struct list_head list;
> +	u32 vdev_id;
> +	u8 addr[ETH_ALEN];
> +	struct completion done;
> +};
> +
> +void ath12k_peer_delete_wait_register(struct ath12k *ar,
> +				      struct ath12k_peer_delete_wait *wait,
> +				      u32 vdev_id, const u8 *addr);
> +void ath12k_peer_delete_wait_unregister(struct ath12k *ar,
> +					struct ath12k_peer_delete_wait *wait);


The struct and functions appear to be used only within peer.c and are 
not referenced elsewhere. Could the function be made static in peer.c ?

> +void ath12k_peer_delete_resp_signal(struct ath12k *ar, u32 vdev_id, const u8 *addr);
> +void ath12k_peer_delete_wait_flush(struct ath12k *ar);


--
Ramesh

