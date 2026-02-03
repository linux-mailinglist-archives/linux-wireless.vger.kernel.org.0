Return-Path: <linux-wireless+bounces-31491-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF4aFziJgWnuGwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31491-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 06:35:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87325D4C18
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 06:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6526B300FEC5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 05:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC42836B5;
	Tue,  3 Feb 2026 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gcXOEEuS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gPLTLr0c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E1366833
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096662; cv=none; b=mScIAmYGQXHm6uVEvkQScLGDs4unNMk0ViYdNsIb7y714CEgmbr0Q9GxRGsURHALeuw3UYTYX+jBS3TW0IEsGPprfzxsdmigo9xlLz0pCcskqcNXyI7ErD7iAwPQ6H3QbYlrWSGxHo/qkJRulSSMZujUVMOfpJbBkDANN5RqRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096662; c=relaxed/simple;
	bh=n13A6SvlSo4cXb375w0SpOGbE+/SRmSY1zlFiEAJZqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9mXY/kOh5hTEH/qu+IqL3cwdoXiyaAsFPfXeP0SR/8XY5EdUyeokk1T9t29/NtP51WUAqLhRnw2XuwHeMao8I+66l8L7kY1q0DCHoC5FcDswIURmuvjqBTYrWU782+c/f3WjX+Vmk/DlESM0BJ0/qDE77Pr9Sejur1Ul8G5qQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gcXOEEuS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gPLTLr0c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612KD5Fd277307
	for <linux-wireless@vger.kernel.org>; Tue, 3 Feb 2026 05:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OvIfb3KtMhaK0URlCrLVgD5/o1KlZJAtMpEOkCsCeL8=; b=gcXOEEuSPOsR3bNq
	cMqdP+eTO8I9yJIFHlLF3sTCWYBfBLB4KEOu1boqT7y7Rt5SoDt5KbpvpKtIOsHX
	q3NeIEPLlhC9jU1ho3Pd5++rGjBDr4tlZHmjCxrOjxDAFnRW4Bnw9eJbizURFh4W
	ZOQTOh+VfYETHMDzo62wnQTJyOcdWapvISagRHYdy/zN0xFR4a2AElOtHxqc9tlk
	1itFqYzS4wlS7UoYHjWpblxWu8nNrSKRaFtXagxdvTi8kw6fsQ6JoBqH4PZ78d0g
	NzpPu8biVcRnLSmVXvfI93yiASNpCMr9iXHuvsZIOTiyhPi8qSGD810+A/Fhx+Gg
	gMD0aw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c32s39af9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 05:30:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81fdfafe6e9so2306698b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 21:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770096658; x=1770701458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvIfb3KtMhaK0URlCrLVgD5/o1KlZJAtMpEOkCsCeL8=;
        b=gPLTLr0c3JxEpK5t7uAYEMQRH9Z1IF57PdCxqEUT82vnoqdRskF9Hf7BgUpaOGhYXG
         a484vnBCtO3OxTQV/NrdCA5s8rH9GV73nNSgWLTBMT6jDAj9qApdgaH0pOlwA0T2+TNM
         F3o/PpyPtjCx/xM4YuJ9lvR+iq4lFaCxssUN7Mn9SwD5BR2o7g7Ou5ukUlM8LXx+l3bV
         4l73kMV6IUdTbEFjjvOFMftjMbP5Dl61emFuFWmAU+dlEKRv+LLdZ0JeA+jZtaz7+uG0
         w88cBsOueIU8cxdiWB8a9gpjAxy3baWefPgklMb8BJRQhUkj06Iaa6vjQ2wobjg2je8Q
         +fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770096658; x=1770701458;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvIfb3KtMhaK0URlCrLVgD5/o1KlZJAtMpEOkCsCeL8=;
        b=Hsl2JrotMA2zLIl7uBPP5iRm9C5J2oyyV3Mo9r6r8JD3w1lxnuwU2VV1USedYllH01
         lhmMRK7qgsfUz50mhxdhw/kO1vEvj+C4JMw62mGxtUDdd5P3wtbZcefwB+433ug/LmZf
         XxvW8pMpt/gbNHlqxpE5S6xNn/3HZB9/dbdLeWtT6/OUmopRqF0jVnUplMJ96J8vpFdq
         hmD8TtrRcmb6zTps74ZtQJI3WSg7HI34vBLSS+rxCMh7hKMG/JRUfugKNUIWMRtKuj60
         VNdIsM3xpV0eBrZgVPEBsdplxorGURyEiUvoWlksndz+HKGg2N5OwLY9BNX6iBskzC/e
         MZvA==
X-Forwarded-Encrypted: i=1; AJvYcCXTXppxAcWPsS8iy1cYvsLagQZ/OoQQANKmTS2I8Jmgc9Ok3hvGeqMwCbbRAI4uUs05fbCym6F+uoh9LyGeBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8hiC1l6sOVRHIlQVHsuJxjxjsnNbgNgUhA3zOHzeb85dVULX
	QwITRtyH0Lsjs1vGSVC7A7/3bdSjHFnUEhImFz1OexWNtgqc+yByTvShBuoExuJ0r8uVboe6ToO
	5JqIrfmbykKlGMl0LRmzbHdlAgTK2BRxSIlAUHJ3rHbWoCvHmyO9ssZr0wipES6Uikw9axg==
X-Gm-Gg: AZuq6aLxlEmbRiZ3tgniBM20M4IMyFrh7ULvLEvzuwjLwPMiDtEjPebznRSJXfwKmow
	9yx898GIwPg9qvvruuafJm4/erKSLEP7TGn4i3DZ+GHczMtQK/dhEkjCTAkViA2gqI2zDIMpvHS
	vk2IE6ju9TP3hShbwFZeanRWZSndl1FMbLoOcqKeoY05D8nYJ8MxPAgCyGoq8k0TvvX8YyFLwcL
	ecDVyh/pg9QSlfpWeuMEOW0uTLq+nMOhu4pgKK6WAyExULIsvg571PG1uBSz+1Pf/LN9P1LYx6f
	JZRFvYXLWWqBTSu2IRdTdxpUw4a5x4Pn73ln2HnIxDsQr5DR8szhSQ48eH3FPTJjy1SltMM6ULr
	O+ttGxT21e5l8wHoRuGuVpmzKq8gvymNsud1mkYw/omlJI6Lp1WHyFyOLY6V3oQbd2gp1AslP5S
	Bji3FaUw==
X-Received: by 2002:a05:6a00:3cd4:b0:81f:99cd:faf8 with SMTP id d2e1a72fcca58-823ab643e3emr14879802b3a.8.1770096658161;
        Mon, 02 Feb 2026 21:30:58 -0800 (PST)
X-Received: by 2002:a05:6a00:3cd4:b0:81f:99cd:faf8 with SMTP id d2e1a72fcca58-823ab643e3emr14879784b3a.8.1770096657696;
        Mon, 02 Feb 2026 21:30:57 -0800 (PST)
Received: from [10.133.33.50] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bff93esm20880164b3a.41.2026.02.02.21.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 21:30:57 -0800 (PST)
Message-ID: <eda602b5-6d6c-4ef1-b07a-53af4b226549@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:30:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix CMA error and MHI state mismatch during
 resume
To: Jayasaikiran Banigallapati <bjsaikiran@gmail.com>, jjohnson@kernel.org,
        kvalo@kernel.org
Cc: quic_bqiang@quicinc.com, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260202151720.49904-1-bjsaikiran@gmail.com>
 <125f0ecb-79a5-4806-aa93-aecaf937885e@oss.qualcomm.com>
 <399d4ea0-5f70-4678-b0d6-9a80c3399ceb@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <399d4ea0-5f70-4678-b0d6-9a80c3399ceb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Zc4Q98VA c=1 sm=1 tr=0 ts=69818812 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VjulNiziwJIgjV26a9wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: -MNjIE8nOG500kKzq5h7gLDF5A5sCOLi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA0MiBTYWx0ZWRfX7r84rf+ax3nl
 50s8Z2Y7qAD52sOkQqJtMKjUEH8mxScPUQmL/JGCYvAtX/dnR63qZHrkV2G97f7S2rU0n+joSUM
 EWKdaO5K22w5X4B255YYKFCvz2Sh8Aw5agsuTNVPnDrzWyjWdlcVG5gY1BXqvVPiOQ2Novz+rPq
 geeGe0Q/DeXTcpViYfY2ILpfbz/AnXMqZsVEKNb8MhcvbkM65hJRq9TU6hukvdIvk4WLZUlEvLn
 7j5cK569eWHPy8K4LD/2VAZJPLWhUav2WjPZR9AWe+BCQrWGiHUdAEM93xOVGjbCYGGVXIbOnYu
 Ycp5YK1WN9KXzV3IdKZtNgXu+hiiS9sDgg9sgEPLoxnEOvzSFO+ps7nO7NnNKsxsYfYQl61OOYT
 QR5SGvptmynH8Y87tQB9/8OF1h5jbRCywD/9LooEXmiqtVMNerXl4hafpZ/SnjmXP5cMh6mbL1U
 llQQSAY6A9AFIXiU2VA==
X-Proofpoint-GUID: -MNjIE8nOG500kKzq5h7gLDF5A5sCOLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_01,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030042
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31491-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 87325D4C18
X-Rspamd-Action: no action



On 2/3/2026 1:02 PM, Jayasaikiran Banigallapati wrote:
> 
> On 2/3/26 08:21, Baochen Qiang wrote:
>>
>> On 2/2/2026 11:17 PM, Saikiran wrote:
>>> Commit 8d5f4da8d70b ("wifi: ath12k: support suspend/resume") introduced
>>> system suspend/resume support but caused a critical regression where
>>> CMA pages are corrupted during resume.
>>>
>>> 1. CMA page corruption:
>>>     Calling mhi_unprepare_after_power_down() during suspend (via
>>>     ATH12K_MHI_DEINIT) prematurely frees the fbc_image and rddm_image
>>>     DMA buffers. When these pages are accessed during resume, the kernel
>>>     detects corruption (Bad page state).
>> How, FBC image and RDDM image get re-allocated at resume, no?
>>
>> To clarify, the BUG: Bad page state crash actually occurs during the suspend phase,
>> specifically when ath12k_mhi_stop() calls mhi_unprepare_after_power_down().
>>
>> The stack trace shows the panic happens inside mhi_free_bhie_table() while trying to
>> free the pages:
>>
>>  mhi_free_bhie_table+0x50/0xa0 [mhi]
>>  mhi_unprepare_after_power_down+0x30/0x70 [mhi]
>>  ath12k_mhi_stop+0xf8/0x210 [ath12k]
>>  ath12k_core_suspend_late+0x94/0xc0 [ath12k]
>>
>> The kernel reports nonzero _refcount when attempting to free the CMA pages (fbc_image/
>> rddm_image). This suggests that something is still holding a reference to these pages
>> when DEINIT attempts to free them, causing the kernel to panic before we reach the
>> resume stage.

this seems like a bug either in MHI stack or in kernel DMA/MM subsystems, rather than in
ath12k

>>
>> Since the pages cannot be safely freed during suspend, skipping DEINIT (and using
>> MHI_POWER_OFF_KEEP_DEV) avoids this invalid free operation. This also aligns with the
>> existing comment in ath12k_mhi_stop which suggests using mhi_power_down_keep_dev() for
>> suspend.

first of all, this is a workaround rather than fix. Ideally we should try to root cause
the issue and fix it in the right way.

Secondly the workaround here seems problematic: you skip INIT druing resume. However note
several hardware registers need to be re-programmed during this stage, how could the
target work if its power is cutoff during suspend and the register context is not restored
during resume?

>>
>> Thanks & Regards,
>> Saikiran


