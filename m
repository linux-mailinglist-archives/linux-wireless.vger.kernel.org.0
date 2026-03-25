Return-Path: <linux-wireless+bounces-33851-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLXPI6UFxGnOvQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33851-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 16:56:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30317328865
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 16:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FEA93004601
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86A7395254;
	Wed, 25 Mar 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aVFOsaBK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jG/x2NFq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6592BE7D1
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454093; cv=none; b=fDec+USKYGZMN3JaxVkZC+DhsWrABXX088+4uHkE6CvsRwarBRdTtyfw3mPQGcKnnvfJcN29U6RTgoxn/ZstJbqKxIjJMxb1MHy/7MiQf3e99xAg4h5RERthVM85GnprQHVFitI7KkxFq2IBv3QFGs4mhoqqrZOq8MrLQwQaj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454093; c=relaxed/simple;
	bh=Bo+agfUwS1r6XwF0/b/31N5Qy4SqfkL1GN4VufH+cDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmg8RUOX/6JbQsSXPz9NVytqkwZpBjzQmZPePHi/rvYmXrIR5nGVRrJcR7M/g4U2dfwj6NnxO6U+lAtJjQh4TC5TEaEBV3B+frqCXr4Pi9ehYI09kFg+8PLh/bSloHgk36ylni6q58sibupdCZ7lExDe+FoeA2ZydhENnK1lmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aVFOsaBK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jG/x2NFq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFH9Qa2737603
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uNu/oNFvJ4yY5PKefhD2ZpTBxLo9FCQs91M6mIqi41s=; b=aVFOsaBK3aXYntQk
	twmk48Sg4Bbr/4rPWrmaKB4AixBdXMPTVFRiE9W26iT4UNbzRpLBj5TTB2NxRM26
	3gGEWyzes4Ez8drMvRq7krt8kirbfeY6bSEq6oXtLgRm52twyCv6y8qAfXkJKLCC
	G+OcHoq0IqY59UzP9HHMwZQBzCS3Go5wcDeauofmX58zuPKMHtzqHbFP/eY/44p5
	+nu4eo7NO0w5/z1d53c0x+5Urttf1VQ9BLEu6X4Y0aBpUHT+zFyaouhxqXTXCJ3w
	070DRbYEm1WZDplePWbDYaPQuTo2ccdIWuR5G6A4qTnnlVaPfFgJ31O062EvLqFw
	CXXtXw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4859ahx6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:54:51 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12776bebeb3so6860147c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774454090; x=1775058890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNu/oNFvJ4yY5PKefhD2ZpTBxLo9FCQs91M6mIqi41s=;
        b=jG/x2NFqky/WKgOAKE8m69bbTK0XbIASH7WwrmSQMAekrsX8UDIb/6YNkexsJ/9o2n
         RIzgMqfa+lhrf9IvoM8c8vfK+nnS6robdXxNfsD4/GhodP3m+PosH+tWRCfKLQVrjpV8
         5P+yquNEISuoBgRcPz4kcACoPu5eX7gZnn+7zr+IIxBfwZizD2SKU6VFT7/+dUKdcbEK
         PiN+wzd3yiRXYUekOqdBkAsXe0hNUvCnbA6L5ya/iqTehdI88LWBya5UoLlUHSl1xrHm
         RLb1Q3suWb4kCvZCdHMmyKjUvhzGlkyhZPguAiZLNBb2mv5oRCtQKiiiRLm6Bwf+9OQL
         3g1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774454090; x=1775058890;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNu/oNFvJ4yY5PKefhD2ZpTBxLo9FCQs91M6mIqi41s=;
        b=SeQN+XAr+rbEhEl6hTW573zToFusCbctNVLiYkTLdkXgEjDPIyW5xoJmFuMdfQYlwH
         BCl6TV2gFAw3pmq+vdIZly+oOJNEp8KF/ohmAFu8WTUOzmidiJwpOGNLMiejZWCxNrcj
         es+e0lOMT93PENmdvWr6ZVVMd0X5+OQX7GNHT+ND65MbBJ1GH33gnFMIbLbhWbJoiPJP
         StCwltHkVxA98HP1tmvTAp8su0z51JAobExEPp5EfwZB4t8dWCnX26q3VAmEihwz0Kr2
         p1Fs1vcw6ocdWzLO2aUjmJedKOK8giAUy4W1SWaatJ2+bDl77BmyoH83bZUweMPnnFxm
         TCQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXddUaBQSfGzMkkbyKiQv4+316kJkiuDg1fmNP7yNlstursO0+4t8aUJdA6RJS+7Y/YFDerfxLOZ73WnpN+nA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2iCxprwHY5nQRx1hBv6JccxjQ92CMIoeaHR8NuOfHiHZ1AAJA
	Ql4cVb4Jm/C39KJhtybhikAcQWFmYWtwkHBIR7WxM8Cj7C6dB68aHVQB+xXxt5SKlFoSC83zy11
	r23gYq1dJEda/r68BQ72Abfvd/kkgtUCUdnsg9ODQaoXIBbFVxfNrIIJYgatuMukEmOubXA==
X-Gm-Gg: ATEYQzz4+v5v8FfWkjipjk2LO7ekgKwM+/wkWtRA6uFGO3ifk3oYCO5xfw88IRjEh2Y
	w3K2Xsbks/KhMfqqRK/BwPT0ZfarLqqK70vG5xRWxrN4Kat14jS74v2+EjG/8B/6qqQ6/04cKQW
	jrUhDXX++5nsGJSwGOMR608Zb1UslcgSQ9P9Q0V9YopJ1d6a9uZO2ZX+Zzr7mRx8m+8xDgLE1GE
	ufo7bXIlqB8m39DXf9vIfCDxHLuqWKLywx9OteDsQqvEjiCdtJixFTNXrZy+M2z+Vk/h3IrUCyV
	U8o8bZc0aVqUpFjddpOCAjOJvogW4/FUHDble7FLJ/XmQc+AebjXD5E0KkkeGfEkt2b8/bw/eFr
	UDII3cqS46CpszCBrPEvuqiKSqQyMI6fqDGiIs1NDCPoBXF8+DueccdSFy+QxIVs8E+06lvHCic
	7FqIKIdA==
X-Received: by 2002:a05:7022:6191:b0:127:1492:e370 with SMTP id a92af1059eb24-12a96e42235mr1847752c88.5.1774454090431;
        Wed, 25 Mar 2026 08:54:50 -0700 (PDT)
X-Received: by 2002:a05:7022:6191:b0:127:1492:e370 with SMTP id a92af1059eb24-12a96e42235mr1847728c88.5.1774454089844;
        Wed, 25 Mar 2026 08:54:49 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa7827e02sm175255c88.12.2026.03.25.08.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 08:54:49 -0700 (PDT)
Message-ID: <e799a763-125b-4a5f-af5d-2a3437dbf1a6@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 08:54:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ath10k: WCN3990 firmware workarounds for WLAN.HL.3.2
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Malte Schababerle <m.schababerle@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20260322124822.230492-1-m.schababerle@gmail.com>
 <CAFEp6-0xShGtpWEhmYmqs0156GHZDsF4Q7E5HOrMbnGSAb56wA@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEp6-0xShGtpWEhmYmqs0156GHZDsF4Q7E5HOrMbnGSAb56wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDExNCBTYWx0ZWRfX5Y9z3stqUliG
 v43b7LExREKolF/CsfboOxdK+bqXTOGqsMf2UrfjOpMF6L3EtnESaVSL84+SzwJ5gLVcbkdjb+Q
 UZDH7DeOU1Lvc2Wp34nHH7EgkemWcg/oEK7blSDIw612KjA8mzBPU6diBiP9n3SXPELDqLXAnq9
 lbCGVGHxsSQxQPnfKvAfnHeEYXbMH8vHjB/hn8tYi1p5BZPurMiaWJJts4472zU3o2w0Mxu5HQe
 3DO029npIkiPYMyPilUzuxVU6IJzfixZP9lyNWIH+4jnZx9X4qlHkOLZcg3Tc/aye2UKI5F9Bzc
 3UgF6rgpXoQhPN+OnBHoyqzK2266d8YCj6cCgegkBHhKQCA8q7VZKTQiYIJ75BOkkfvTIUpSyrZ
 Bf+76zMQ5mTPQCLSXiw+Sxh194n2kds1KcHIxUri+9N6nZuU9TbuW5W9yn4DNylNVDmSlaSwRUp
 PvsxRMth7KXMoS3/gug==
X-Authority-Analysis: v=2.4 cv=VODQXtPX c=1 sm=1 tr=0 ts=69c4054b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=B4GIT9JVp03-19iSf3EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: wlsWVdgcxglWMfT36YEqOKtNlpRQydxD
X-Proofpoint-ORIG-GUID: wlsWVdgcxglWMfT36YEqOKtNlpRQydxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-33851-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 30317328865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/2026 1:41 AM, Loic Poulain wrote:
> Hi Jeff, Malte.
> 
> On Sun, Mar 22, 2026 at 2:49 PM Malte Schababerle
> <m.schababerle@gmail.com> wrote:
>>
>> Two firmware workarounds for WCN3990 (QCA6174 integrated variant on
>> Qualcomm SM8150/SDM845 platforms) running WLAN.HL.3.2 firmware.
>>
>> Both issues are firmware bugs where WCN3990 advertises capabilities it
>> cannot handle correctly. Tested on OnePlus 7T (SM8150) with
>> WLAN.HL.3.2.0.c2-00006 and WLAN.HL.3.2.0.c2-00011.
>>
>> Patch 1 fixes a deterministic firmware crash caused by the quiet mode
>> WMI command. The existing guard from commit 53884577fbcef relied on
>> THERM_THROT not being advertised, but HL3.2 now advertises it despite
>> still crashing on the command.
>>
>> Patch 2 works around a bug where active scan does not tune the radio
>> on 5GHz non-DFS channels, making 5GHz networks invisible. Forcing
>> passive scan mode restores 5GHz discovery.
>>
>> Malte Schababerle (2):
>>   ath10k: skip quiet mode for WCN3990 to prevent firmware crash
>>   ath10k: force passive scan on 5GHz for WCN3990
> 
> Jeff, is this something that could be addressed or worked around
> through the firmware or NV configuration? Applying this workaround to
> all WCN3990 devices feels a bit excessive if the issue is limited to
> specific variants.

+Baochen, can you look at this with the firmware team?

