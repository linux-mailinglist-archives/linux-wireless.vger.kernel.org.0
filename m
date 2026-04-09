Return-Path: <linux-wireless+bounces-34541-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKFxJsaA12kcPAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34541-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 12:34:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC83C931D
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 12:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1F7B300CFDB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBD3394795;
	Thu,  9 Apr 2026 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p6ArpAUK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N6IQDiIH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C62BB13
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730882; cv=none; b=KedMRPrcyOaDy+uloirwvti5dDnxwA7FyIjzV4bFTg348BmKswfrlPoZ2LOW8vEqJbjR92j+X2uX/wnGcNPQSIwqMfJVTzta0KV6M+GG+Y6CtGiRyC466LwFjJctCTYAnC+XjFKZNRXww6+mIGYob7Kv/QbXNtXsagTSN4Z7O6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730882; c=relaxed/simple;
	bh=VnicBGML0IpF5ftuQw/0aytpe45nuXmTAsAcwSji9eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzfVIA1LxhoDCibr2Tg2KI3XyjAKKZ4wge84gPQyaTxzjEvMgtuvx9GCoHJ/vXRZXlxoQJU66UEkKja26YCA62rYoWhacWAkSiIxaVr4CvdRABe2QNhw/lk/cse2L18CpMDbCk+8ATXN1g4vP6HOEd/DNDUhr+yR5HHG3We5wzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p6ArpAUK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N6IQDiIH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6397MoPr4046994
	for <linux-wireless@vger.kernel.org>; Thu, 9 Apr 2026 10:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdMoz4hsQMm7TuH0erJhR4F5yshOZcv6Maouf1TQ3UE=; b=p6ArpAUKkNVRDQ3C
	skuvy2timXCI/IP5rMS9B2OnrAj92Vc+ivEE+M+n/Lul9aJYQ4zilrxDtCbOYVxk
	ZLd8O6vH9c5zHG4NSw5eu/S9syKD158CcZXNz0FARUunt0oXBRvmKRDBI7+8pfRY
	1PkT6vLJ9N547MRywcqTwz5xcefj2gDCXFM6aDXeO2EQPS+axYPl8w+CRd6aktHK
	ZrUmX9ZJEtwHaBeFadqzqw1GapTE++ARLUZu9LCG1O3xil9h/OdmFeB/XS63cVLh
	VE80vdnl2UWtTCMHCcsV7Q4vZ7yKjEPae2RCQkkMPbXvQOuZOwqbdDqKsmyLXK2T
	nx/j0Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtd73m7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 10:34:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82c7a84a43eso1081363b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 03:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775730878; x=1776335678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdMoz4hsQMm7TuH0erJhR4F5yshOZcv6Maouf1TQ3UE=;
        b=N6IQDiIH4fjub9948jyYeEpW93ClJUBVqtJ7Kw9eD+r3W7yv2mqdOBXG59jzRwzOQ5
         9aljRqsv6YULwfbJqY9P5gbHXCkGNhNYhIK6OYrA4dYKscjG18TDOPP4bgWUZvauS8fq
         RFdPGht/Lenjqi0xYupKiehlm354OC9/H3VV6qiSPj/5kvOuMuMYHrn9o+sWGWNR+jax
         9Igflka30KGZfiGtPXx8Y/GmLtImdmZwa+G3qlVYlLqqpZ0bdl3vS/U6itBVhnqQiKTe
         52wo6im42Y8msQFJ5pZJZ8zN33MOvCSFrnXm+cT88kzHBxlVMV/VEwKeI/oBnYXpZ2a2
         t1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775730878; x=1776335678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdMoz4hsQMm7TuH0erJhR4F5yshOZcv6Maouf1TQ3UE=;
        b=A8vsnGt6yrTY1G+6yE0A16nZpJmVvfhr3TVP4K/ubj8o+PBnN7ECjCHgqlskxS0S4b
         AYXVg907+GXwmVSYPWG5YpKRNtoXb0dLIC1v47Dcjqzlhdwh47NDFaoYrKRtGWr8yx52
         v1Q8Ewbn748w3VTmA3WPvvz1etTXNtFxOnvPoLTmTXzx1CVnoUDT4iHoLCIPQq5oNJFm
         a3+W7SrXNk2s+DYQZCBEdnMYfZAbbbREIqpKUs4cOz2misRqCWllJtsD/41p2SEin4zp
         OCNwnlVcnbfb3/6EoT+JYpeh5kkXMeSpaDQZ1lYy/HemnxNMTV45DttUaZ65XnBvAaNq
         TP8Q==
X-Gm-Message-State: AOJu0Yxk8cAa86h4RJ+hRPtBy537ROjZHijrm7okjnFNgXdNicwVHdIn
	VcZ/Pj6IJYbqKo+w8cwHe/9Zqc4kHnXJT190EoOYKhdL5OHnBv94HEmeEEvxjppfMIsGCGusd7J
	jUP3kQ4y1nyD/GNcqGG+glgl1VCSMCCKKOJ5vBKE6GRxl/Ud70yYuyWLzxYtEm21+sxvfz2cYwc
	aWMQ==
X-Gm-Gg: AeBDievzrNSZS4mamWyCq/iRMzLTu+55J10WqzEYFK9Gt64Uu7YSeCwxqAsT0hOwsNh
	erBoGPcd8guTsEORRxok88jPGQ9+stGJtJqaVoWcU/UvcK3F5S0H9JCJRyjtMIvL5qTaAKzi0uY
	kIhLRwDPy46K3LWcKopf3/jr4aeq2V5/5VlYCcOoRVOLpb+jmu87BK9FNIMOO66dXKAJ4ilJUu/
	mkXDzOJRPiC8jjMWBe/AafjU5am8jd+Urk/QhOjRtQNZkQ7KCfkm8m3RvxTwepEmi5TwUvBjkWM
	wmQ5HvtLt8QkZSe4fO9cS5m9mzCeGol606n5zKX46h4D8pPlxTpLaRDGSs4YA7QeudPcZEG/kB6
	DWcg/VSdzT48VEvIiVjqsP7DUcqhtSf0rPMkfh1a3RQCUuL1yafCoDmUJ7JGEZA==
X-Received: by 2002:a05:6a00:3902:b0:824:a01f:6335 with SMTP id d2e1a72fcca58-82d0daa3ce1mr25079153b3a.22.1775730878371;
        Thu, 09 Apr 2026 03:34:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:3902:b0:824:a01f:6335 with SMTP id d2e1a72fcca58-82d0daa3ce1mr25079126b3a.22.1775730877757;
        Thu, 09 Apr 2026 03:34:37 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm24951395b3a.38.2026.04.09.03.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 03:34:37 -0700 (PDT)
Message-ID: <8009d39c-5033-4f87-a697-985297869e9a@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 16:04:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/5] wifi: ath12k: thermal throttling and cooling
 device support
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QoRuG1yd c=1 sm=1 tr=0 ts=69d780bf cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=H-Wgj3y7uwXhWPCsC4wA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: CEqWru9HWc_mgiTuNhLXsAOgVjSVVOsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5NCBTYWx0ZWRfX2VTxvo8J2NGi
 mqgADVTqJGZAHsDEcDdXzw8ZGNLE+XeQF2MS2AHxI5LJV7BKuZiZM3HNEI1x4/TKTjwdCKRaZFz
 4egT9AMO1fVPf82y6Gof3TuixWpQF9jmrqK1DQTAjxH+GJZo47fJDyEn8lm9o9P56rkZKrOA/XT
 NCk/cXt1pyNF4z13GNu0bTxnykBUoJOLnHOIcEo3riHf44xeCgv9UFOE1U5z4c/u+0LOKCpSxtg
 9gOdL/5TxSILjGTZd6qmxxOA+ACGy5B7srndtrRC0GTWguYeVL0hYA+QHk++wLiGWt5tArJXJw/
 o7AHAqLTFGEZbePEjzE0a1wl8d52kpn+fppRwU+lsJ3QmAfYMA/CeTXRIh2Sfn1buNh2Oh6NIsZ
 pcWAxhel0XU7sC3c37Xt9rcWB2tUEVPIBvETRqdwsKSUxbPebcdWbbvcNqmpUz+2Y7+aM7oQMes
 u/bM6yTfE/JbENSUh6w==
X-Proofpoint-GUID: CEqWru9HWc_mgiTuNhLXsAOgVjSVVOsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090094
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34541-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1ABC83C931D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/2026 7:54 PM, Maharaja Kennadyrajan wrote:
> Patch 1 handles the firmware stats event so we can track the current
> temperature and throttle level per pdev without spamming logs.
> 
> Patch 2 enables thermal throttling at bring-up and programs default level
> tables to firmware via WMI_THERM_THROT_SET_CONF_CMDID; the driver picks
> IPA/XFEM defaults based on the firmware WMI service bitmap, supports 4 or 5
> levels as advertised, and only fills optional fields (pout reduction,
> tx chain mask) when the corresponding WMI service bits are present.
> 
> Patch 3 refactors per-radio thermal hwmon cleanup to reduce code duplication and
> ensure consistent cleanup across thermal register and unregister paths.
> 
> Patch 4 reorders the group teardown logic symmetric for safe thermal sysfs cleanup.
> 
> Patch 5 exposes a thermal cooling device per radio so the kernel thermal
> framework or userspace can set the TX duty-cycle off percentage; writes
> are validated against the throttling state range and host state is kept in
> sync with successful firmware updates.
> 
> Examples:
> echo 40 > /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_stat
> cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_state
> cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/max_state
> 
> Maharaja Kennadyrajan (5):
>    wifi: ath12k: handle thermal throttle stats WMI event
>    wifi: ath12k: configure firmware thermal throttling via WMI
>    wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
>    wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
>    wifi: ath12k: add thermal cooling device support
> 
>   drivers/net/wireless/ath/ath12k/core.c    |  50 +++--
>   drivers/net/wireless/ath/ath12k/mac.c     |   9 +
>   drivers/net/wireless/ath/ath12k/thermal.c | 252 ++++++++++++++++++----
>   drivers/net/wireless/ath/ath12k/thermal.h |  35 +++
>   drivers/net/wireless/ath/ath12k/wmi.c     | 107 +++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h     |  50 +++++
>   6 files changed, 446 insertions(+), 57 deletions(-)
> 
> 

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

