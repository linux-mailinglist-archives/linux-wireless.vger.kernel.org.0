Return-Path: <linux-wireless+bounces-36682-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIW4GKUfDWoutgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36682-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 04:42:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510D586E9E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 04:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 489B8304A15D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 02:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570D330B51E;
	Wed, 20 May 2026 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XzAcdbzK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="axeYmIV1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF31A9F97
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244963; cv=none; b=YeV1eZcQAjjUG6q0hSV28Sa8plf4ynxPDkELLe0bMrRc38fejniNgFPj7w4Z3BtwwgYzmV7MsGydpYLpPzia9p1DWKW9HGyJv/d6lSCwvqxE3ruFmYUsyOe9bjliPmIA9um0az5OaTQISp8Y9V2CITy/bd0/TmFjzzLqPQDCBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244963; c=relaxed/simple;
	bh=e0t+yEDY7apJ2M7lCjNB0JiHDCl6lCw65TngYUkig1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbdOfFZWOnf1wI84nlCPTKmqf8es/qOeJlSypNQ4r+2UinsiwudUh2Fa2vqHUrvDWBmx7/mt50H2rwlxUhvqC9nQNERxADpYeSPwrUn/A9jr6n1gj8NMrZ2MRUFnL8KbKJdmgeQlauf43AWTt2OGoV9G6lzmvfBwdKPLJ16VAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XzAcdbzK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=axeYmIV1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JM1Tnr1725496
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e0t+yEDY7apJ2M7lCjNB0JiHDCl6lCw65TngYUkig1U=; b=XzAcdbzKgPtPP8NY
	fX+0iJCbDYpURWPY/d1AKI5otFKLSNF+Yb2JbkY8nykDHRxNeDU5rGTt9Km16ekY
	2sdKJS7Lk9xnJ1dik9vVjnkEnVGrpQt/6ePJqJ7WD3ZP+o4yb0GjRPt3VX2QT6Ha
	cSqhW/byukPsIawWGwez46qNkiHza7OeWmFqunSEPJblCk0E+M+ikV9RGs6bW08q
	O56qjX5eVNAXO7nEIueLd+txZOkH36dTyk7W7JT+hIHymHkBKmeNTiGSZapWjNlp
	SoqD53s0VfYDBShfekT+KjDDs2oveUzSHMEQP2m0SqqXQEB18AUPLR5QUELanWNd
	4MGFyQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qjjy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:42:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f1383b7439so3892364eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779244961; x=1779849761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0t+yEDY7apJ2M7lCjNB0JiHDCl6lCw65TngYUkig1U=;
        b=axeYmIV135nGwoGUe8xd1Jj0TF9LpRAM3X9n8lr5AbaUzZQ7UNpKfXuzLuFUpigXR5
         qq0bz0kLtRH1nN6G3AyvRgPxQc1F54e0GDsI8bsEHoSeqImkoIaeFM1jWqqctPRcBiUO
         UyLhY1jH47qrZ54ysMv3c2wsY2Wg9jJfWnEuVIQ8IlnbN5Fq/FJJHgyYkwLAbClMJnyD
         ihvmscG0fZ1F9lzFwM1IF+vgd2gxmnd9/mGyGXTuSP1LeOOjWtsqGfznD++te2Vuq5b9
         w2HMNM49Y6SDRQ8CADgKebNusRPSKEZgDQsQkI91p2X/0YsE2fk43IasSJkPUTJOYGcG
         pLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779244961; x=1779849761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0t+yEDY7apJ2M7lCjNB0JiHDCl6lCw65TngYUkig1U=;
        b=FvdOyFDt8inRJeTAsNYCsCzSVTC8wsowsMZOVf12QRP6LkZSg7Kl8YxHmDCOQ6vXrn
         IIROQxqXQ+A/NEKqkm+hi3ZO/on+04XcrXRkzzpm/NftmLuRqoJV1e7U6NovLwS6Ov0M
         yqyV+6hJSrYNhRyKMbfzQoigPhojOKaMKcTlWoAgYZepa6nb4hZhmjp5aTZDDePNToWa
         KBpXCLdcu/ugBUAIbH4Da4gmKT7w3/xuuEN6DZo13z3LaKtYo48F8D/I1cmCy9nnUVhH
         L0ivjvGJFbasegRKJEXEd6qCGGMcmstZxk+++KiEyhn2I8J84bstM6m0cEwObxSia4cI
         WIYQ==
X-Gm-Message-State: AOJu0YyKPM8+HZNHoD1mbij6JsKDgoI094VKbjxgrAyHSX9b2CAveNFl
	apS5+WV5XQBWjCoVMFJgNy2iaQ/JpCLIii2e7TwY+80nc7MVydlzw516izsJyQ/gP+la7FDuhSX
	hOobpmalSgMKUdqct1oE6nSx5/udnJtfS9dMlHn6ygtjNBZDzW41klSUfLmYRTNh3SAu6KA==
X-Gm-Gg: Acq92OFZZmyxzCrrkbtkVDOOgcuOd/ko3ZsOmTosCATZjzhpcbaoeiy0jk/lNC1bqa5
	NUOQXUCXujNpTHaFChaLK/iGoRghGhuakksfaYq0fdf6OiE3dxx7+pBXRVYaPmjSnS80P2/1b6+
	fFWvPjfsyOPoGZtUXpBumcjPYZVoORLDanSslv+c7HIPAVMT/A3f+5PfBu0lSG9zYMeTwKsQXl1
	gTkKFmfUrSYh6sGCgvV3/uiWH9uwx8r88zTLut+jCTYEhoA9t/kp+yR/Dn6wxF0VBN2lFVX32MT
	oEsZxvBFQjaynmRjyZ5NhFhyhnPOdo/hkjEVzkJgWgvrVv/kMjRELT4I4lo0YPmT3RfBDf8lqCP
	gLadLSxSOy64dpg345P1rBcoZMAZFzzF1yfoXEUaHAScIoLV6qgRaEFVctYVlOfo8rZIOo1pgvg
	rhBQk=
X-Received: by 2002:a05:7022:f96:b0:12c:9037:5115 with SMTP id a92af1059eb24-134ffe9529bmr7832776c88.13.1779244960667;
        Tue, 19 May 2026 19:42:40 -0700 (PDT)
X-Received: by 2002:a05:7022:f96:b0:12c:9037:5115 with SMTP id a92af1059eb24-134ffe9529bmr7832767c88.13.1779244960123;
        Tue, 19 May 2026 19:42:40 -0700 (PDT)
Received: from [10.110.23.100] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm25554404c88.5.2026.05.19.19.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 19:42:39 -0700 (PDT)
Message-ID: <b5870d83-6cc6-4b9e-bb4c-ee812d8b7727@oss.qualcomm.com>
Date: Wed, 20 May 2026 10:42:36 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] genirq: export irq_can_set_affinity() for
 module drivers
Content-Language: en-GB
To: Thomas Gleixner <tglx@kernel.org>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
 <20260519011627.713068-2-hangtian.zhu@oss.qualcomm.com> <875x4jxyht.ffs@tglx>
From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
In-Reply-To: <875x4jxyht.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAyMyBTYWx0ZWRfX+2HeMRdjDSAl
 kIrV5TmtM1g4Nrk4uPwptQIi+vm1hQCibgGj4ithbZ6QOC477pxCP1juSSnncYpnNGPHGBCc9bd
 uxwb6kD4OHLRr7jmM6848c5L/bOq5di3bJNJjRWc5ctFPnAqhSB4lEcx0NBoTLsFDXkNCoRrVlV
 1j4m4TgTDwpADbyIkx2FEJGHxOz78frL4/5/bLspUrrSlXMEwVSyRSKjA/D7E02Rv4iecOXI9wR
 x7Tjc8x6LzeAiJ871xCj8wbkpsbyvD5QY3ViL/eYCFdGgOXKJQ71ysug95D1iBmfygMrCv3dJnM
 1NllIMHoDZJr8Wx78QJ7mCwf0DT7UkLPkiLjx/XkSkZZeuSRyWQXVkElpKnVGU4lL/73H8fgaaI
 +UUWYee91lgDUDRRtIpN0G86bLRcI4YBBQ+rgFOKpWo9ZTYD7ZBCODPn5EFxx6eCFBDimngVDqq
 vkGhH/9ruwDGen8tgeA==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0d1fa1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lnQDW5h3hmdP-kpHZ14A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 6byi95_T5iT6G8hMGwmNeURSBCrvTZIx
X-Proofpoint-ORIG-GUID: 6byi95_T5iT6G8hMGwmNeURSBCrvTZIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200023
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36682-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hangtian.zhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0510D586E9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/19/2026 22:30, Thomas Gleixner wrote:
> eviewed-by: Thomas Gleixner <tglx@kernel.org>
> On Tue, May 19 2026 at 09:16, Hangtian Zhu wrote:
>> Export irq_can_set_affinity() for loadable drivers that need a runtime
>> check for IRQ affinity capability.
>>
>> In hierarchical IRQ setups where the effective irqchip path lacks
>> .irq_set_affinity(), drivers may need to switch to a fallback policy.
>> Without this export, module drivers cannot use the core helper and have
>> to open-code equivalent checks.
>>
>> Signed-off-by: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
> Assuming this goes through the wireless tree:
yes, it's wireless tree.
> Acked-by: Thomas Gleixner <tglx@kernel.org>
>
> If not, please let me know and I pick it up.


