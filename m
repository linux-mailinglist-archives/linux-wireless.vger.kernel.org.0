Return-Path: <linux-wireless+bounces-31493-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPoEJOWQgWl/HAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31493-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 07:08:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4EFD504D
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 07:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69633302A6B7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3D1207A0B;
	Tue,  3 Feb 2026 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWJWqfEB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dlrvfjWT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DED2836B5
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098914; cv=none; b=OY8vR4xIC9dH5CbJvdtLrQm0SuO5yr2ONSvfZe81xC/cE2uuMYsobfq7+AmNKJdUyX4BDnszd8QhofcbzH4oxThS/r16FL9mllIUkKaLg/Kl4wlrBUmyVP9SHT2ITGO7/8xOXRaaCGtFuXDTPK55kDelU6uUN1N4nbSPUGRKgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098914; c=relaxed/simple;
	bh=LN2IPck5ov//X45fmqxY5ixODOZQWmsjo8+ZE9Gl6AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzcu26dQa7vvPEYu6lZjtQJ3jDjsc8imwM1IryL6+gBkV+VvPMDu7XTXnR1GEw5wekN0EG87JMMi+eqqoqOU/1hGmkLux6/Ns2/55p78YyVad1xJbx/b00a1tEZMwAMTEMOjmIMupRu8PRItzi1R8MSk9bmDdHP584WpyWk+3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWJWqfEB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dlrvfjWT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612LON0R2357296
	for <linux-wireless@vger.kernel.org>; Tue, 3 Feb 2026 06:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HtU0/hpdAIr+5h98ci3yTrohfWUAYAgRPyNrKyEhN+4=; b=LWJWqfEBUonRqOoB
	8bH319KfLWL1MlRAZhGcaLoW/qkZI7XRaLcaDj3lRQe5I7LHX57YZzdrUn4pNui4
	g9CXt4L6AgNXt6g+pIaTrZnP/LtQSXKORcLFJkGv8bgo+OgdOf8zQfyVapiA9s/i
	55EAsHQYv275LVyAzPXCwr3tV+iAcJmP/zshw5e5o+FX3jM/KGTbZPQnLbC4EEz3
	iBfbhZoJx/yGHQLpXUBrrSPYFpuiAFeq5hll3OLso3p30jy8EJKdzQUmAf0WMVK2
	xNBieaon/0FKUz1tkEy/tp0oDe0TdcP8hqWF7h0x/2wGU3llXV3KNbp1Ed3scZ/s
	xQ/mMw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2v0maur8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 06:08:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c56848e6f53so3320974a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 22:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770098911; x=1770703711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtU0/hpdAIr+5h98ci3yTrohfWUAYAgRPyNrKyEhN+4=;
        b=dlrvfjWTjoWqlx9CH5sRfsWUOm7WlqF3YD/3dHVkdXiZwwjtx5x3WxvriRedxi411j
         a57kG1zsrYu8PZ76EE+gfIYsWmbT9iZ+t12JnWO0HMscMDkywt5grY3+t2sbLo8p2DcL
         j+8eNEq8mOwc61wSoF7n3wpuZ0YY41ajbri/OAUJbs/8p+XBg7aPDl9Rl854tYRhTra7
         SdDhYrs/ZCcYy2tqX9OOYZ3qLcaugbwi33PbvM8qAJLtNvLyQ4eqN8ItTJ23nXzAE1oc
         OFCA76e5ZpEEORl2VtIpjv6t2L4hK2hyesVvYZpdjEWygfQofB1vwY8f6zt9+Ee9fbVw
         N3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770098911; x=1770703711;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtU0/hpdAIr+5h98ci3yTrohfWUAYAgRPyNrKyEhN+4=;
        b=pIdFPciT5Lf/P9B83MsjXPwTK8sAiwm379mao6NHkmadNE/iIxaGNBLIU43vfrCFDZ
         /ba3EJfJ5+d4fTkVRtNfeF5f0nA+zW2IPTgHmeXQjLAUGtIckgAPlBNnJ85pwSdDVrg3
         zj8sCIy1NAD0IDBY7NmHk6SxA1aikEG3BurKnsT8VNU0hJhWUHELDa7SGP6vdAZ0sW0/
         sgtMuQ1qBRM8RIU0i3wx1VPiaDHKoQeGaVLUn+rca7cKZwqFPq+RsVd82cNaR5YHsyVy
         ti3wo4G7Wgm5cthXf+EPi/g8D2mXwL70y7lldNhIpyArtGSq4bqd4exty9j5bv/M/6gq
         nauA==
X-Gm-Message-State: AOJu0YxUt8NbNcvAdRiC9H4WID2sMv8NsGGEw5JvqR+/xYUS4vITYp+1
	SMbIREHud0ohOzsD4Voi4WqztFK/1/6xBml4pf8tbnjl/3nSZjFbEdBsPlbtHF4GntKP5liumWp
	dmJasMaXK+98ALcKbXucEbXNnYeMVR2LsVrnwd+c0i3zk7z3dt6JDDfFKMKsE9uoMjSzkMQ==
X-Gm-Gg: AZuq6aJf7ZpEcsXFVtSoGD7iTqPMCDM07wpZYnCiWzsNuRLPmeQW3mlvDzBGckwq91f
	te8jvxfrzsRYVwacjk5+FXSixUa3qt0Xjj/cyGVdcp3MwaHZaO/E6DBpeyRySyEygQaW7Q8q0T8
	fwi0U6jevkMeiUtjPueYWtgkYnjZdCFUhwcWu6NPwm7hDFP3nnJwwQlq0vxgB0DBn700a1taEsz
	tkOpzK7bdulMnpAcO5aWF8GCiikkIgRsNf/eg28JcYKwrGLSEpIsTkvmHluvkdmnMeabSn3XxWa
	NBF1nx9KSUm5feh9Pb5iZ2SsS3hX1lgfUC+kFFqKGlWfoH9wfL4mJLIbiYRCvx1W0X4UHOj0xDI
	JtpNUU02Gj6w/CGLkephFPVlW45bqJNMhHtK3sjsri7J/hzXAsB5fPlrS9F/7aXQvRbEhy33jhy
	viD5dv4g==
X-Received: by 2002:a05:6a20:a122:b0:38b:e944:3e98 with SMTP id adf61e73a8af0-392e0000568mr13670090637.5.1770098911303;
        Mon, 02 Feb 2026 22:08:31 -0800 (PST)
X-Received: by 2002:a05:6a20:a122:b0:38b:e944:3e98 with SMTP id adf61e73a8af0-392e0000568mr13670071637.5.1770098910836;
        Mon, 02 Feb 2026 22:08:30 -0800 (PST)
Received: from [10.133.33.43] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm15788615a12.22.2026.02.02.22.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 22:08:30 -0800 (PST)
Message-ID: <547a2c5c-fa11-4110-ae6f-17c12d6809f2@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 14:08:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix CMA error and MHI state mismatch during
 resume
To: Jayasaikiran Banigallapati <bjsaikiran@gmail.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>, jjohnson@kernel.org,
        kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260202151720.49904-1-bjsaikiran@gmail.com>
 <125f0ecb-79a5-4806-aa93-aecaf937885e@oss.qualcomm.com>
 <399d4ea0-5f70-4678-b0d6-9a80c3399ceb@gmail.com>
 <eda602b5-6d6c-4ef1-b07a-53af4b226549@oss.qualcomm.com>
 <aa252da5-a9fc-4c86-ae78-1de1f7c34bb2@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aa252da5-a9fc-4c86-ae78-1de1f7c34bb2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dceNHHXe c=1 sm=1 tr=0 ts=698190e0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2ZLfKyb1yGKDWJBy5BIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: NNDg9rhX5iVYROv3PrBEP81c48sB8t-_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA0NyBTYWx0ZWRfX8GnnJI8Enca2
 XOG/4UuzPO4D1o21nFZCq0w0u545yTNrEJUB4pHeFAD8aPyzuhAgrq6Rm0SQ/vf26j1DkzANGoV
 AJvW+ukQJ+LBItaW7OajXRDYvrF3HLMlxU55Dr2QtLEkK/QRUSAw32G4SpYx9BSJIOoiRBv3jrv
 Sk2ltrCeMi2oGjuZpg9I7dSI2CSW0xD9SXbLqCLkLUor8UTy+OWn877cAg6c3jJy+usUaamCjwV
 mYHIeWkmjTcjSV8+zBxrP7qN4BtdSJpROtGxIsdXiMuQZ6jXPcNdtcxqyWw7w0aEko+xNcu/xFk
 otVX0WmsSdUCsob2D9D7J60O1oKe/TvPYGOqkddW7U6kQ0Udj4ckFRlfZ07fWfBC4HqKgcZtgJ6
 QEIvxUoEbZHYCMe07JHvCRHv/XKM++ch6BRovzBF7ds0VtolGReA2HVVjln+sm9uvipZL4xbo0d
 PFcP0tWtHNAcKvOEjtQ==
X-Proofpoint-ORIG-GUID: NNDg9rhX5iVYROv3PrBEP81c48sB8t-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_01,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030047
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31493-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA4EFD504D
X-Rspamd-Action: no action



On 2/3/2026 1:51 PM, Jayasaikiran Banigallapati wrote:
> 
> On 2/3/26 11:00, Baochen Qiang wrote:
>>
>> On 2/3/2026 1:02 PM, Jayasaikiran Banigallapati wrote:
>>> On 2/3/26 08:21, Baochen Qiang wrote:
>>>> On 2/2/2026 11:17 PM, Saikiran wrote:
>>>>> Commit 8d5f4da8d70b ("wifi: ath12k: support suspend/resume") introduced
>>>>> system suspend/resume support but caused a critical regression where
>>>>> CMA pages are corrupted during resume.
>>>>>
>>>>> 1. CMA page corruption:
>>>>>      Calling mhi_unprepare_after_power_down() during suspend (via
>>>>>      ATH12K_MHI_DEINIT) prematurely frees the fbc_image and rddm_image
>>>>>      DMA buffers. When these pages are accessed during resume, the kernel
>>>>>      detects corruption (Bad page state).
>>>> How, FBC image and RDDM image get re-allocated at resume, no?
>>>>
>>>> To clarify, the BUG: Bad page state crash actually occurs during the suspend phase,
>>>> specifically when ath12k_mhi_stop() calls mhi_unprepare_after_power_down().
>>>>
>>>> The stack trace shows the panic happens inside mhi_free_bhie_table() while trying to
>>>> free the pages:
>>>>
>>>>   mhi_free_bhie_table+0x50/0xa0 [mhi]
>>>>   mhi_unprepare_after_power_down+0x30/0x70 [mhi]
>>>>   ath12k_mhi_stop+0xf8/0x210 [ath12k]
>>>>   ath12k_core_suspend_late+0x94/0xc0 [ath12k]
>>>>
>>>> The kernel reports nonzero _refcount when attempting to free the CMA pages (fbc_image/
>>>> rddm_image). This suggests that something is still holding a reference to these pages
>>>> when DEINIT attempts to free them, causing the kernel to panic before we reach the
>>>> resume stage.
>> this seems like a bug either in MHI stack or in kernel DMA/MM subsystems, rather than in
>> ath12k
>>
>>>> Since the pages cannot be safely freed during suspend, skipping DEINIT (and using
>>>> MHI_POWER_OFF_KEEP_DEV) avoids this invalid free operation. This also aligns with the
>>>> existing comment in ath12k_mhi_stop which suggests using mhi_power_down_keep_dev() for
>>>> suspend.
>> first of all, this is a workaround rather than fix. Ideally we should try to root cause
>> the issue and fix it in the right way.
> 
> 
> The original comment in existing code:
> 
> 
> /* During suspend we need to use mhi_power_down_keep_dev()
>  * workaround, otherwise ath12k_core_resume() will timeout
>  * during resume.
>  */
> 
> This patch aligns the code with this existing intent. The driver was previously
> 
> calling DEINIT (and freeing resources) despite the comment advising to use keep_dev.
> 
> If the intention of the driver authors was to use keep_dev for suspend,
> 
> then my understanding is DEINIT is incorrect here (Correct me if I am wrong)
> 
> regardless of the underlying MM behavior.

keep_dev means not to destroy the mhi_device instance while going to suspend. The purpose
is to get rid of the PROBE_DEFER problem in MHI during resume. You may want to check the
upstream discussion to learn about the history.

> 
>>
>> Secondly the workaround here seems problematic: you skip INIT druing resume. However note
>> several hardware registers need to be re-programmed during this stage, how could the
>> target work if its power is cutoff during suspend and the register context is not restored
>> during resume?
> 
> 
> In my testing, WiFi functionality was fully restored after resume.
> 
> The device associates and passes traffic immediately.

I can imagine two reasons: either WLAN target's power is not cutoff during suspend, or you
did not get into the issue scenario. For the latter, I mean you may need to trigger a
firmware crash to see if RDDM works normally, since you skip RDDM register context restore
during resume.

> 
> My understanding is that:
> 
> ATH12K_MHI_INIT primarily handles host memory allocation (which we preserved by skipping
> DEINIT).

In addition to memory allocation, there is also register programming. See
mhi_prepare_for_power_up() and mhi_rddm_prepare().

> 
> ATH12K_MHI_POWER_ON calls mhi_sync_power_up(). This function triggers the MHI state machine,
> 
> which handles the necessary BHI/BHIE programming and firmware download (SBL) sequence.
> 
> Since mhi_sync_power_up() is still called during resume, the target is correctly re-
> initialized and
> 
> registers are programmed, even if we skip the redundant host memory allocation step (INIT).
> 
> Thanks & Regards,
> Saikiran
> 


