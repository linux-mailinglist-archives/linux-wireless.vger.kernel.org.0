Return-Path: <linux-wireless+bounces-37535-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EIQnHOMCJ2r9pgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37535-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 19:58:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3F65978D
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 19:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="No7w/sbO";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RnvbaKID;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37535-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37535-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B6D4331083D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F493D16EF;
	Mon,  8 Jun 2026 17:08:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309BD3D3324
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 17:08:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938491; cv=none; b=DZU49YuafW33P/slHs+mHynIkkJKsZw77XdLMqoYvncGHBeUXMbujSEx5zv+PN5RWh8sS78UYm4A7ljK0Nead/D1emA9zPU2bHc1cZGh4EFB/OIFjW1gi6p0KHdl4OHwmtKvtCssCi8EBJ9L4ih2iecWz9FLNUR6tE1L9zRtqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938491; c=relaxed/simple;
	bh=nc1cmxpsgl3/es/BJBOVuqe0MVbXq9wQMoCkRBeSIuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHuKKRQCu/faokVQhyeDytDo7xQ9r1CWkLdY8tLRsUU/+YuhNPNUdBBNF3GHBWJ2bxnioiGQfhnvQQpj4TsN9PFbxZ4rxU0QO5SMXlM98U6RsmpoAAC8bQdRVPGx5/P7spuvRBa/UUZN9hmYHdipGG+8dOcyfI/KpXD5gtM8xWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=No7w/sbO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RnvbaKID; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFRik4041608
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 17:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9VWzrVKJ/7G/yNKAgeOFsr9jNdwkADnzd+yjssLBbFA=; b=No7w/sbO+TV262I2
	QQK9JQFlIHqWZUZKSlP+zmQmVIoE7o/neWttCkzgV2GW7vgPlg6TArlj0O+At03e
	SfOMk3pUG7PKsovrFq54kFOiIKD7i7PEP8DYuZpJNn6Oss2QEFPj7jmc4WtcFRSb
	c/D+wCOya27Pxca4uy3XbQ5U6Qqv6NiHRk4xGqIeE7tVCZpVHOnXzIY6IG7LNRrI
	T/AY8xR8D7B4TTKdXGi+zV9Vngw0zaYihmE6XLUU9T8W1prjCXi4OM9Dx6mR+Pu3
	8bJXdFjGoOrHqEz+BnMgTmNxxi4Zmiqx9dKXylTIJAbpdmMC9KUyLvkPcLVLk+tM
	gUYH4Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enwsv9erx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 17:08:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304ea1eea05so11624372eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780938488; x=1781543288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VWzrVKJ/7G/yNKAgeOFsr9jNdwkADnzd+yjssLBbFA=;
        b=RnvbaKIDMiGo/QWx5VQqGEXAJzoYtTyXLIsDdUtwSka3CAX66lWMW7KqQVVJARdex2
         Z+2T5W6IansviUjo585YOAb73mTASf+8Eucp870tMeH5XqJKiC5+NIOQRrqB0E1Wkfs8
         Ill3Mmy/yGnCjhk8rfnFZpzv8HuWnUIgKDjXSScwS5WvG0E7mi4g0vHLy+3W0hkh3MqS
         SKh2QuMJfq6vh7vvfLJWC8kE8QhmsML5Ozx4F+MKaePMA3CwUu6BmEXQBd+IlZQJZbWL
         jtEVUkojZOxf9saYdJzexySJN0a+C3S+gOhowSUM9VrI1Naso7F689VWW88RqZfo+VH+
         XxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938488; x=1781543288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VWzrVKJ/7G/yNKAgeOFsr9jNdwkADnzd+yjssLBbFA=;
        b=HgtiaVSvCfNs0xge+OJoQ0ZcnEYlcA/xoWx2r6Kl87SMXjz44R0tmrZMuw5HWD2FTP
         6mnjKvNrKbvikMKWKUG9iVodLWPIqmK26fpUOoodcHgkDV6ilBZ7CPk/Qgev4FXi9uRs
         ZtHt6XvlosNGoAEHyo/NSZBi5n3Vs5J7HS4rVSanslYbbbBEAvWuBL9KgyBVAK/ISYEw
         Sdmo+GWGuOmPfi44jDhU8Bmem1aK76QyFnKTchsaHlxyve4b1ESrpd4QBImF9N+BSgIp
         iugtnNKg0pQpi+o85NzDdnNnXV1sGs6WdVjUIiGhXvTh7qoomMpmPVpraciXNzvwRFFl
         Rh4g==
X-Gm-Message-State: AOJu0YxZN6uAMJlpEVzqqHnDDksIpojmjG1WsBjSOjkjRPTS4Db7MHNJ
	96QEjoyDWdJAMH1cpjLMvEQGUjUDCK0lsaZ516Qhn3RkfMq0YbfOu0naqffsLiPK+j97H1tEMvl
	JwmUrKN+w0wQaADaNwJW7xMoI+7dxJgSK/Ku56CerBWrFF/vQPUJYknYhcuemNfWUfCm9vw==
X-Gm-Gg: Acq92OEzkv+3wr/bl/5h7WQxbEXBT7R4klHn/1SYX5jsgsgJyhpHMPdx6krMYBjmVGs
	t1Z8tNGp9ewGI/RbfJ+Lgq9gI4WGyOUVbc5hyQSIHVKyFgWpNGwvgzZ8n/nL40Mm+xHe9rYeg3C
	6auPDiGDPTHj3EoDIcPYkI820CcGPlZVT0lv3osaGzprqYqE4OoG+cvjYMrWW5v1wD2r2ue8TIv
	/f+RT1PGTdsrAsuA96kjN82l6MzG6Uj0xB+qf8QKTS7IV7/YC0E4lUUQ2D8/DZurv5sG72fFibM
	sW3DItQPEIMlj6MTnnWe3JFlUWWCejP6UYADHGJsONcwTzhZqMo6d1AvruVZ7qAMBxSqTMiCZJ0
	mc7Nyn/XBnru8xTKJOJ7BeiTAA0Eka0uV5AqdKgoWwJcZwjeIkoWpvP2+zVBerVPl0tJll1tI9S
	/73Cxqbtae6fGO+knadka69CwQ
X-Received: by 2002:a05:7300:572a:b0:304:aca:35c5 with SMTP id 5a478bee46e88-3077b22c938mr8036368eec.23.1780938487937;
        Mon, 08 Jun 2026 10:08:07 -0700 (PDT)
X-Received: by 2002:a05:7300:572a:b0:304:aca:35c5 with SMTP id 5a478bee46e88-3077b22c938mr8036332eec.23.1780938487252;
        Mon, 08 Jun 2026 10:08:07 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df3b234sm22856903eec.23.2026.06.08.10.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 10:08:06 -0700 (PDT)
Message-ID: <973da9e9-3851-4e00-85d4-28140c039127@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:08:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath12k: fix NULL pointer dereference in rhash table
 destroy
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604071032.659009-1-jtornosm@redhat.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260604071032.659009-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HydKVwnz2dBejZ-GjoVUrTeJmk9ItF8U
X-Proofpoint-ORIG-GUID: HydKVwnz2dBejZ-GjoVUrTeJmk9ItF8U
X-Authority-Analysis: v=2.4 cv=dIaWXuZb c=1 sm=1 tr=0 ts=6a26f6f9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=jrdOLSfvXqH_YxhRKEcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MiBTYWx0ZWRfXyR19k3We4S6N
 gY3F5PPao3Gfi6tZEbEu4t5RldxeviuwEoWAqRIgwKdtmWeKAy5GK6bW4yQm/z/CKiZ2jKF3nnf
 NXleTf6464ODVSD2Ljkf55LgTk3HMQQhkI2IkUJD4694vAXVCbrxbw6DGc+foycOXUZyWoXYl0u
 j/fLXwPQcHS4Ap1DiJrdnerD3ro1JZC14GBKSYuzcLDlv+g1BhsbWeoMcqjk7DkayqOSPDgGroY
 M/JibC+ympessogsTT0AgD2lpMjsovIKnJySdDUnbweAQzGfD+E4hV+WMCMKuA8atDnntXniwIt
 UyYGuzLsHYpIhQ5AcY8L5z3HZsNnEWKoBk7lyNja42l03IDLb3JFCEP0daXyCfHncBkau4RON0n
 urtfSRC1EfEF4ycFK+NP0yEJ2zx3lObv1XqhbKpg7X9sbvJL2FfM9udoJv1GODuj20CTeYNXKK4
 YklNQws2OIwFQnO8Ogg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37535-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12C3F65978D

On 6/4/2026 12:10 AM, Jose Ignacio Tornos Martinez wrote:
> When unbinding the ath12k driver, kernel NULL pointer dereferences
> occur in irq_work_sync() called from rhashtable_destroy().
> 
> Two hash tables are affected:
> 1. ath12k_link_sta hash table in ath12k_base
> 2. ath12k_dp_link_peer hash table in ath12k_dp
> 
> The issue happens because the destroy functions are called unconditionally
> in cleanup paths, but the hash tables are only initialized late in their
> respective init functions. If the device was never fully started or if the
> init functions failed before initializing the hash tables, the pointers
> will be NULL. The issues are always reproducible from a VM because the MSI
> addressing initialization is failing.

My preference would be to fix the logic so that the deinit is symmetric with
init, and if any stage of init fails, it should unwind whatever init occurred
up to that point. So this patch seems to be a bandage instead of an engineered
fix.

But I'll let the Qualcomm engineering team give their opinion.

> 
> Call trace for ath12k_link_sta_rhash_tbl_destroy:
>  RIP: irq_work_sync+0x1e/0x70
>  rhashtable_destroy+0x12/0x60
>  ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
>  ath12k_core_stop+0xe/0x80 [ath12k]
>  ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>  ath12k_pci_remove+0x60/0x110 [ath12k]
> 
> Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
>  RIP: irq_work_sync+0x1e/0x70
>  rhashtable_destroy+0x12/0x60
>  ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
>  ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
>  ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>  ath12k_pci_remove+0x60/0x110 [ath12k]
> 
> Fix this by adding NULL checks before calling rhashtable_destroy() in
> both destroy functions.
> 
> Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_peer.c | 5 +++++
>  drivers/net/wireless/ath/ath12k/peer.c    | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
> index a1100782d45e..38045564e223 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_peer.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
> @@ -275,9 +275,14 @@ int ath12k_dp_link_peer_rhash_tbl_init(struct ath12k_dp *dp)
>  void ath12k_dp_link_peer_rhash_tbl_destroy(struct ath12k_dp *dp)
>  {
>  	mutex_lock(&dp->link_peer_rhash_tbl_lock);
> +	if (!dp->rhead_peer_addr)
> +		goto unlock;

not a fan of this pattern.
if we go with a bandaid solution then i'd want to use guard(mutex) so that
there isn't a need for a cleanup goto -- we could just return like the patch below

> +
>  	rhashtable_destroy(dp->rhead_peer_addr);
>  	kfree(dp->rhead_peer_addr);
>  	dp->rhead_peer_addr = NULL;
> +
> +unlock:
>  	mutex_unlock(&dp->link_peer_rhash_tbl_lock);
>  }
>  
> diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
> index 2e875176baaa..80fee2ce68f1 100644
> --- a/drivers/net/wireless/ath/ath12k/peer.c
> +++ b/drivers/net/wireless/ath/ath12k/peer.c
> @@ -444,6 +444,9 @@ int ath12k_link_sta_rhash_tbl_init(struct ath12k_base *ab)
>  
>  void ath12k_link_sta_rhash_tbl_destroy(struct ath12k_base *ab)
>  {
> +	if (!ab->rhead_sta_addr)
> +		return;
> +
>  	rhashtable_destroy(ab->rhead_sta_addr);
>  	kfree(ab->rhead_sta_addr);
>  	ab->rhead_sta_addr = NULL;


