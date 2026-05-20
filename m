Return-Path: <linux-wireless+bounces-36715-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O9LGfvdDWqh4QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36715-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 18:14:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9130591A9A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB1F031ADDBA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6730EF92;
	Wed, 20 May 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YpPcgl8/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qa2QS8Ip"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C27324B16
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292816; cv=none; b=OWByAZJCEJFOYW04CLjuJGeIF2IaH+EMW5xyCGK17zT2MOzTqcKxuOMaJSM9sgTBReQ7UIv/V3kFSkPIzm2bcALgi8uzdRm9gGnCzmBq0bcZwdYZbkafJiEXcKr+9M09HGRL4RhJPCvTbWz51vm2GNsgtyeJrMmiQ36haG0cdHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292816; c=relaxed/simple;
	bh=ZpxcAUJPd5tJIWKRY98uiW6dSb/caAHCDpNqrV6zEnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfKycybFnWxuGF3DX50DSXYNoIah1gU3izijMqZu5kLr+eJDqjHEvmcXLMSz88CbDFWHOOGNdsMZeNdaNNbqUNmyWJHhVrtCAO8+dp8/Hm45woEMjPQeFyVxNvze1kK2EhekrSEqXd24at2xxZi5qnmELDmprPrL2jB2LvrjfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YpPcgl8/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qa2QS8Ip; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9oVKX1178167
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 16:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3v0ddjTLFWHRUmSNG386fenlZAxbP9sRhkIsLs/UysM=; b=YpPcgl8/59Ft9wWj
	bSXO1rr2pxi6VmVrbC0AJFj7WP3govC6hvlgkkk2H4DnFM7+95QC8nNZefvspzkc
	eHkDX/jvG7nQOJeAOv8Ps7LihXv8xS9Vo7gXWvSE84YmIIupNf4qzT14QX0wOfn+
	I9RAbZA/dOoV9Uk3SJZaBH7dshAgXKUfS3dbFNY0xKN8TTRGGLa9vb88Agn4oeIA
	TAFrxmQG38LFSnEhn/8s0JdEDUN8AosMMPT0FKPNcBskKIe7osieVZDb5oj3xu+b
	zeL8eAXNySNUHZhAP2dNHwibezZKdgXPFBN/q7K2UjclCPMH0wHpXNNnUiYeo/wQ
	e6VS9Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6sd6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 16:00:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2f525565b33so6267629eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779292814; x=1779897614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3v0ddjTLFWHRUmSNG386fenlZAxbP9sRhkIsLs/UysM=;
        b=Qa2QS8Ip1fbfHpvuDyAEn2kqBTJoO/hE+GhrUmSI5nn4gvq7mZ1aZJe+oTs0Tt4TUR
         u3ZXfna9oPiQxQRjrBp3lY4k2/YlnlfBtwj4DH2J3KLCqqJLfVkYLhk5wNvEtytzx/pF
         oEA/tBsOD+WoOC6FyzNrvPB08teTOfZkHoiQQgkFYGdzjMqqY1taMxykh1nkiVsJkAn4
         ct23Zss4YBKID7HBmpCl3NGkONdv8cNM9EjrgufDGGo2oDG4ASaCQIRpAp81RmQmMu7d
         H0hZIy1xtmWfn7o6xfxy3SlhttHkx9JZRBUVu7pGRw+Mw4IKy7+1MBIuEgFmX6qYnVDu
         xyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292814; x=1779897614;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3v0ddjTLFWHRUmSNG386fenlZAxbP9sRhkIsLs/UysM=;
        b=LfyXoeYYQnFtHJKwh0BFpzNx/o+YOiS6inZQ2Rkq1f7K1B7U3SnJ+wWuY1p2V+d3xV
         ljkGNXILx7S7Ht4+2bQstvB2ZaH4X50CzL3HVVq9mvjvUEoJdPTFSwzA0wdqEtarpvtx
         qbzhwbkWhCQdag3uT2pijoLuxryR3/g5yfhC340N+LRgxgalI0QGyHhpN0ZO0AQa/en5
         deqpQe7w/cBWp/qQBdXt8/AJhLaENiNnocJ+tsLTA5nN1xKByFIVTbl9wXNzTgkbGyo+
         vPvKl582AFQX5dOGFgTxWyuV+HSeZIfwGfX3gpv7MYWQ6J5knURTgR6nUFT0HJOJ6zDV
         vXVA==
X-Gm-Message-State: AOJu0Ywa+17yp4L49k3dXC2wtzzjuVddZpC6ejfggK26CODy3xOxbCWE
	I/QMkhe2qmzQigiBCo4H3StInJNVwGC8lmWfqzJooVi139xhcmGyWZDU56ZDGnd/FVy6F9rbGvn
	CJZ9QBoHMA0MyPPfAi1OhMu0ERdNTW8aJ3QDtoCTOQL9k6p2CDvIA05ZbF5E+u5DAQwcHLA==
X-Gm-Gg: Acq92OEAqPwEmnB8S9+yeTVa0+kx7VYmQpqi+2sih0LPRASFKFzMesDaLv90skMr0mS
	u3sY7sAyElhPV+FNpJD5aX5NLnqiQ7lIsRlOdccX5sbDUcxYZQ9R5U/gyEW1aS13fW/s4EieWoY
	rGRHTBB7lX3ycMkYXxRol8izZTmHQToBqTKfrq7Yu70Pkgy2mL0cYZWtDcUUvd5rpUPb8q9DtEV
	jOvTihN6Sb5QIAMMzQqSdUveBT7plbGFDS9IXvR1Dck5dXIPbdfcNeOVOejaNN/eM74OPuSAnRp
	gDLmS5nmUBlALNNuEoR2FT9AuEnjX3CQ+A2jtYLUFfVJHKnMzDrFU3w+avQiKvod2z7cDxqZ9YM
	/oOknkvyCGR2MAMLTwz6sPvpxsqg7b8J90PH5ymc1Cib3MC4ViBW4v7e+GAEk7PiK+RlxBotgim
	pBouYbzw==
X-Received: by 2002:a05:7300:8b24:b0:304:29dd:70b6 with SMTP id 5a478bee46e88-30429dd8193mr280392eec.13.1779292814073;
        Wed, 20 May 2026 09:00:14 -0700 (PDT)
X-Received: by 2002:a05:7300:8b24:b0:304:29dd:70b6 with SMTP id 5a478bee46e88-30429dd8193mr280342eec.13.1779292813299;
        Wed, 20 May 2026 09:00:13 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3041e267d8esm1655453eec.14.2026.05.20.09.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 09:00:12 -0700 (PDT)
Message-ID: <a6619f65-7c84-43bb-9eff-4172ab16417f@oss.qualcomm.com>
Date: Wed, 20 May 2026 09:00:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] genirq: export irq_can_set_affinity() for
 module drivers
To: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>,
        Thomas Gleixner <tglx@kernel.org>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
 <20260519011627.713068-2-hangtian.zhu@oss.qualcomm.com> <875x4jxyht.ffs@tglx>
 <b5870d83-6cc6-4b9e-bb4c-ee812d8b7727@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b5870d83-6cc6-4b9e-bb4c-ee812d8b7727@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eVw6wLwo4wnzkldzHineIFLbjSHm8Nwk
X-Proofpoint-ORIG-GUID: eVw6wLwo4wnzkldzHineIFLbjSHm8Nwk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NSBTYWx0ZWRfX5NFAixOlwBw/
 W1i+2WhWQTA+w0y2hgSguBzbHy5nUVYB4kg88EZHI+zyBqOlZ6uddmJD5n8HvPF9ZhTQTu5h/U6
 cLufv7aFNjakpt9F/3mrjwXakn9OJDQHvjchxPpewSugPGjzo+tXLIIIQSfMgdSBmzZRUHCxB7W
 J3P6yhcP86TONGtVqpSstwdoJXvLxogPVwJzHnNXnnrvp1P8YlirmO0JwgzzvZ9jPzhy6kGmE8R
 RIkeMBPhzFWtRvg1WcNzsQ6C4RPJ6yaijbANgNn4YkHLmROZJQi5OuwebZLU+/Y3RDv7CcG4ud5
 9n7aiAH33nLCsc/tApMX7jLfvdZPk+o5boz1o71nbi9/OKybWIxlW/CHvD9wuYjDuJH8nCXuDZd
 jjA4d14z4e17waCCX/OzRAcVfz8a0t7KAwiZDRpwV+9rild8BTga6326FoP7mvAaBZZJxtln9Zd
 LJfcgO5/sGgObzAr1KQ==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0dda8e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gARxiiPYBd9Ydj06ge4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200155
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36715-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D9130591A9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/2026 7:42 PM, Hangtian Zhu wrote:
> 
> 
> On 5/19/2026 22:30, Thomas Gleixner wrote:
>> eviewed-by: Thomas Gleixner <tglx@kernel.org>
>> On Tue, May 19 2026 at 09:16, Hangtian Zhu wrote:
>>> Export irq_can_set_affinity() for loadable drivers that need a runtime
>>> check for IRQ affinity capability.
>>>
>>> In hierarchical IRQ setups where the effective irqchip path lacks
>>> .irq_set_affinity(), drivers may need to switch to a fallback policy.
>>> Without this export, module drivers cannot use the core helper and have
>>> to open-code equivalent checks.
>>>
>>> Signed-off-by: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
>> Assuming this goes through the wireless tree:
> yes, it's wireless tree.
>> Acked-by: Thomas Gleixner <tglx@kernel.org>
>>
>> If not, please let me know and I pick it up.
> 

Technically, it will first go into my ath tree, but yes, I'll pick it up.
Thanks for the Ack!

/jeff

