Return-Path: <linux-wireless+bounces-38638-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fjf1AbGtSmrwFwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38638-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 21:17:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6C70AF2D
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 21:17:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RYYoPstc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=KLMxYOTS;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38638-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38638-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5442F301D312
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jul 2026 19:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446E3A1A35;
	Sun,  5 Jul 2026 19:15:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278C3A1E80
	for <linux-wireless@vger.kernel.org>; Sun,  5 Jul 2026 19:15:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278914; cv=none; b=l5R+hxGBM2GKQ0cvhlqdZvWHUaWX+IFxAYqE461DeNTPDOlbZ+NEzgDUK7Rh1MBf6oPFab+W9vaV6hd27S+WEUGN3DmWlV//s7lh/7CDcusSvHLWAORibxhGTPit2TB1fV4LBIqs599RTt9ynAv3HZ+sWgLom4y6Rn3CKfrrZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278914; c=relaxed/simple;
	bh=44lM3DRPYiy11Cw67gCIsslslOmao7q+J1d0JTufAW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1aQBq1l4lZdsIPTz355cCZKNHOwpPoLJ/DCRgon1tdHFPcKV9Ik3SpxuUzSyJWDhwNTnDdQm3bFcMobCfoChFWv8ugy+stLHAMO87sP3I0udcp11MA4BDGEXuPYdH/houyTFL9Sf+eZf10V2yZgtePvkPmr+XHpS4NV9a/nwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYYoPstc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KLMxYOTS; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HiYSm2169693
	for <linux-wireless@vger.kernel.org>; Sun, 5 Jul 2026 19:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JzHURdlTBy4HGtMk9pPhO21TM4DbHArmKo3PXiJCc4k=; b=RYYoPstc/ElDH0lQ
	+9fg1uQrsS0yv/soaDeKupGZTFCQ4bqXSRUZbtYo1LjUlL/9osR7Y08YMWl8BYyF
	4GZCWEd/IeHOKcrAfTOHWuiP6SQn3l4LcVpsS8T2yT5mCAmHn9tVP4azsSQAhFV6
	Tu0AgiRGkle6VATOVPsBbNUInpeUP8Zg1P9QHRt+plhYFTAQLVHZENXC4Yc7QKhB
	Oot0k/6BeP7Opqy9XxUjQnkLDK9rnlZhXlWrOG0XFRnJz5hmma14wKXFWSstn/jl
	kgBkKXAOMVT7RLlymwWiZ1dviuUQbl3coHy5nZUp6fjVLC1UPB274OnQHGQQLQ36
	9tOkkg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8k7g3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 19:15:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cae134ab3aso39833765ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783278911; x=1783883711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzHURdlTBy4HGtMk9pPhO21TM4DbHArmKo3PXiJCc4k=;
        b=KLMxYOTSFh44OyRyzZo7IJvu45c/gNgXjKSHDJAOGM6h0EQzdgonygcOHBa3p+fpKI
         4w7CMCIbR0CxXJiYtwEAyiVddi2fMoGyOvU/dNc/3m0ctB2Hip8HYMSQz3iSw0qO22sk
         h8F9jHKUB4qVYA90iHtKlvQ5L3swcNGW5XcPc4OwduOrFrbwNhOhlDMa9Ytr2acC6x65
         PmsdAPX5cSg4o4bnnOaV1cLr4CZ3KvOVUQVGroIhvteuPpA0Mc9BvKPTnowfaeCfv2Ze
         bj57iBIO5/D6doJIgH5EtgxWMfItWArTeoP0lP5krb4mkLqoeyGnCgYJpx/AZpu/yRcd
         Y8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278911; x=1783883711;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzHURdlTBy4HGtMk9pPhO21TM4DbHArmKo3PXiJCc4k=;
        b=Bz1+ZSgjxbUp4BrvBx7db6EHl49vlb1kgAsqKtyVP4B4ydO+BwchIanf3A7D4Y1IXL
         qt02M8tJ3hHsso+OpwlmQEfGHO5VJd3hlKGTML3V3OcrE7ILgJt+oxj8NmxNVKZNXOCQ
         uje7G6WkyjZPiSJeAU2rZDd3Qv1jw8SU8JpH0VF1ABWu/oqTRCv9iQ4kcY5KAZ/tDTH+
         N9J+LIwRYmZB0iE1Evf/hIsHwtVurqd+gQefAU765V1a+wLMN/WhbHXs5kBlEzckU86O
         QOHs4gJw7erjwJvQSX0Z0GWFLjHdtdc56OaGet3oE2R3SUQxgtR+M7nxOFcQ2W1et2zp
         CCXw==
X-Gm-Message-State: AOJu0YyOlSRVZ0LjnoVKHM5ecHJ83RJPA9QmHfmC7hQ9k3a6UT4N72pI
	eIvZAoojND+nAXPFgG+nxv5Lm9m7EnH29yyO9h9bloRFOMSLZs4upwp5ciuqmiUKyNM0/K6x8/R
	gZ29E15fPn1K8Ev0dm1XVoC52ozoLiW1t6/N8cBpZV1VRDYSBjkIwq5kOF73js7mmEtKL5A==
X-Gm-Gg: AfdE7cnEqY55p+bCVPzzbkrMOtQ5bMDT8KH11T5tTFtCbk1sVUVKlifLww4JuwE5bIN
	Or/s1Ec/u84osnIRbmfl7E4Iv8kdluOvDeUppmDrhJPRiuI5gRioMjVfCao6wCPBfZmQKJxLk2M
	4BBf2Bzu+3Q8Zu22nS0+VE/+eac9vTf7QdqblLa/5e4pDxN7jd1iQpQK2Y8fK5HTcDZDMVWi4qo
	A9ua/9smNJ8zB+HikOW9lMYQ/0S/01EQ8V/fAIZoC7h3zFgcHKUz6tDFFvc4ya98MrB1M7RYcxJ
	wjSyx+J3qtpuvSxpsImz0AjZ0xyXqotLXXQM4CmLpUsAh2BrRzeBeiEAiEo0kh2JhVAlFZfmr/3
	wetHWtk4C7Wfr2rUCyReOLou6+WFDHzDpvIKXWY6YnWdGF+luE9h9bgGs8agfvVwEDNHe
X-Received: by 2002:a17:903:3202:b0:2ca:d151:382d with SMTP id d9443c01a7336-2cbb9e38d1cmr78130925ad.14.1783278910469;
        Sun, 05 Jul 2026 12:15:10 -0700 (PDT)
X-Received: by 2002:a17:903:3202:b0:2ca:d151:382d with SMTP id d9443c01a7336-2cbb9e38d1cmr78130605ad.14.1783278909958;
        Sun, 05 Jul 2026 12:15:09 -0700 (PDT)
Received: from [192.168.1.11] (222.sub-97-215-84.myvzw.com. [97.215.84.222])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b492a088fsm31335582c88.15.2026.07.05.12.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 12:15:09 -0700 (PDT)
Message-ID: <c0b69719-980b-4a43-b918-007751e7e925@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 12:15:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table
 destroy
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260615112103.601982-1-jtornosm@redhat.com>
 <d0fd509f-760f-4632-b116-0b6494466f22@oss.qualcomm.com>
 <b25be5a2-bef6-4fda-b166-becca3d1d650@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b25be5a2-bef6-4fda-b166-becca3d1d650@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIwOCBTYWx0ZWRfXy2XSU8c/eqAR
 S40pjLLhgLurwp0htBozwh8awFiQfkETVHJFT8hqcNy1Lql54jjbxU4B2rUR3S2UbsOisgSEfCE
 svyRnQUCh+K3pIUVfBf3WGtAtKO+GHJDzwNLMttHBzTfP2UwC7g9eFkuvNSPt8akHhzfGPeFSI8
 DTM33l8loxS1Rvc9ZSS7RMy76Es1s3pkkAtW5qbvvSxhhiL+g3GreV2r+PzoXWWN8ObpJU5fvBu
 fgtq/uNbzjnvG5ihVm6dCm9QePYEiqxW43CbLrz3nL7p55LfG0uLiMLC6RWqE4y/ZPwGx7ZFdvm
 Xh1FNNUc1BHGqlxC3u7fFldFuI4Fpp0pmJsbEgJ11mySza2Wzf94ydI4afC60n1DYZ4aY6cZjcC
 O0IH7XSn9Th6/ff6gz6NdXa2e4EzwszAWS9FyUxJCxxqT3N4piRfI+8yKFbPwEiwA7CtB7tBGUx
 zyB32vJaoWIIYlAMuGg==
X-Proofpoint-ORIG-GUID: w3nkVxYfcuMQ1MyCtK3gGw7BuIZE0-KT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIwOCBTYWx0ZWRfX0n1CcXmuwQnZ
 4BKAQg3ENi+VJmxseVZz7cys3l5SwuQsP2Q516o+wAHJ8pjt1ckCFuLPbTrIcDe1DhZzVfERCYD
 TsXRUL/rjZ2JjD9sWmc7FzKpx1pzPYQ=
X-Proofpoint-GUID: w3nkVxYfcuMQ1MyCtK3gGw7BuIZE0-KT
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4aad3f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=i4k25I72rCCN9bAAQd7+Jg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=TRTaysboXGgomUBcWKUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050208
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38638-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:jtornosm@redhat.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66F6C70AF2D

On 7/5/2026 10:27 AM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 7/5/2026 10:53 PM, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 6/15/2026 4:51 PM, Jose Ignacio Tornos Martinez wrote:
>>> When unbinding the ath12k driver, kernel NULL pointer dereferences
>>> occur in irq_work_sync() called from rhashtable_destroy().
>>>
>>> Two hash tables are affected:
>>> 1. ath12k_link_sta hash table in ath12k_base
>>> 2. ath12k_dp_link_peer hash table in ath12k_dp
>>>
>>> The issue happens because the destroy functions are called unconditionally
>>> in cleanup paths, but the hash tables are only initialized late in their
>>> respective init functions. If the device was never fully started or if the
>>> init functions failed before initializing the hash tables, the pointers
>>> will be NULL. The issues are always reproducible from a VM because the MSI
>>> addressing initialization is failing.
>>>
>>> Call trace for ath12k_link_sta_rhash_tbl_destroy:
>>>   RIP: irq_work_sync+0x1e/0x70
>>>   rhashtable_destroy+0x12/0x60
>>>   ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
>>>   ath12k_core_stop+0xe/0x80 [ath12k]
>>>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>>>   ath12k_pci_remove+0x60/0x110 [ath12k]
>>>
>>> Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
>>>   RIP: irq_work_sync+0x1e/0x70
>>>   rhashtable_destroy+0x12/0x60
>>>   ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
>>>   ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
>>>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>>>   ath12k_pci_remove+0x60/0x110 [ath12k]
>>>
>>> Fix this by adding NULL checks before calling rhashtable_destroy() in
>>> both destroy functions.
>>>
>>> The NULL check approach was chosen because the rhashtable pointer
>>> serves as the initialization state indicator. The init can fail at
>>> various points, leaving some components uninitialized. Checking the
>>> pointer directly is simpler than adding separate state flags that
>>> would need synchronization.
>>>
>>> Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
>>> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>>
>> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
> 
> Missed to mention that pls add wifi prefix to the patch title.

I'll fix this in my pending branch.

/jeff



