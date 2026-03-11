Return-Path: <linux-wireless+bounces-32951-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NxgHAKoBsWkzpwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32951-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 06:46:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F22F25C85A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 06:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13D64310F88B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 05:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B3625;
	Wed, 11 Mar 2026 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NyfZoP0R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O+77RQ+U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE919CCF5
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 05:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207975; cv=none; b=njIgBsr34M7HCDuiLxIr3Lm4gcametZPV5AEiPWbk+t8ZEDWMvm2w71o6zBPLbk7iwC5k3TpHz/p55uq7sss44Hvcuc7QQ274UTR5QYAUf0iuj4SF1Hw6zOM0ZOFdPHcEZyTUU1/tsczb12j84qt+/oPsIGccdog+N+3pXHy7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207975; c=relaxed/simple;
	bh=7ohjqDptkz8KkOdB4OSb92/OGB149f76ryU1SIpPftI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgTaaybVMx6f8b+gtOJGWNEYE7NngcyBesj7QPeV4XGt30F40t9vtTA6KA7ffTPXns5YR5hWYlPcearN9/Fb2uelrXIllHcXnpEh6TvR0PtBEqQG6w7kp0ODGzltZ5+CCi0fLeSpsX37t6ubh5o8Oq+bw1CcZQIzBxdm1ekLPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NyfZoP0R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O+77RQ+U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B4lb1q3417119
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 05:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7UUAg6t7pUhxYhtcm7b3DP+uRZEpBNBYRgazfpFcLas=; b=NyfZoP0Rlzuwzcud
	UUXFFfCYLQXewvKpkf9kzm0S/zc9j1zYYRyePHAstfL8RO1HNQTnrNz+ADi1N+6i
	Vf6EoryfibxrPOfx8+fGBY/1KVA7bMiVaeM/6v5dhXdY1bvTY6C80MJ7RUUdLUPO
	NfCV3IN+3YboCLnozCNLJD+LrOPFYd82taTCfHMT3ilEx1VXVA1QQnjeU1fx/d6C
	vTy0gBkCoNg8wZgzvnEGyXVZPJ2XK3Mysvh3j4x4WY4fVETE188G1a7QoM0e5NPR
	AfPpg6cJgOAAd9y05j+lQc1Qe+4U+zqRBpBSQbjm7Za3Okf15CsWXbQIr7SEBCWa
	YrlUow==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2bjdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 05:46:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829ba0e63e8so1475582b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773207972; x=1773812772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UUAg6t7pUhxYhtcm7b3DP+uRZEpBNBYRgazfpFcLas=;
        b=O+77RQ+U751lMqSXFuK2paZKKZSN7zQxpkv9KvWVc1J7m6XIyJuT+QHdin2WTx+86o
         CBxz58xfGoTXtyFVUzaHMXwruHBhDndPXggokKGBRVAJL52lKDGzhpt81D+yQcoNpqg/
         /4VZeaNn66BJKEUzWCDveLpIIyrGbPgcsU0zVHnSP893NFwisL7AADgaUSuwVRylBvyK
         PFmAOZDoaeH4UiUXqNHT9PmAajUBuOCMc2m1dL0E2dU41ABR2WtXS8Xf3bmvjpIQ88hS
         AUTsRblznAiYkKpgEMZ4rPX5mr6ScYdjddKAM2mGkjIsy06klMNICb/ajyiViz5IKZIl
         lXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773207972; x=1773812772;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UUAg6t7pUhxYhtcm7b3DP+uRZEpBNBYRgazfpFcLas=;
        b=qR6dEUq19vObVgMnoxmi7lkl5Kp+2bLh1xen0mHTmz+QSK2RcApGrhB7dyXjQgXYLj
         ML8O6P22078nqOrf0PDiua80w1LGhLy1PtvhecQ09pL3iSW8AgW1Z/Xpv4uku5HGR9TK
         AF9zekFnzKwAZS1SeeHVHiviJEOwhR2gO7lQwBBSOyyBcEU/XdWRIApOps5Typtmdgrp
         QNZzIKL2lFSW57NL+eIePRXuDh+dj2qjevCyw7oqbKkJGEQCXmMMXSz/0Li9541wrpqi
         uoEarGOrvYPTHpODISwue2wHCGM3Z0/EexmQn5V1ohVziKYURnm5XXb9LDHLR8Db7n8J
         Sudg==
X-Gm-Message-State: AOJu0Yz/6GbaEnVUEgS8bCnemIPZ43lDTaYJFDZG1uZObnFa4W+VIhJN
	6xSvxYI0ECtJgIrwRCeKLxEIxL4Hn/xdonFsSdmfKBYCm3YVKiYVhI89U34jCcuFziyUuioD+cc
	vKvyc1mk4hzCYVAT/l8rGUXu6FZ9qMbr7y2FjT8qwokGpp+20n7IiTMyHYJLtvOHw3vs0dA==
X-Gm-Gg: ATEYQzxJmPk3LY0LuPWL0KA8rB4ffTABYa7MTtLo88E130JIGrJajS+zBoDetw8ydop
	+SHwvXxPkIpoCocxFwTG/kqkx/AUQoG4678/6xomOkDfXNPwstd6EG3laGAFkIZz96ynWHJvFhJ
	CMGo5aaUmei30srOwgYyJNohviDqPKy8T9qWpJ0a712/ZrWlX3AwQRoyQNxE4ErunvLgTK1vNeO
	NroEnJ0SwXJkm+Z2jKmmENU2cTm+039HDloHL8pyQjCCVk+vXhHDf8oZCLcJj2BRQkaL2gg+Ypk
	1Z249kyb8rPNKXVD+mvTb90wMsU5CpqKPwOkWOmDTm38epoYlgLutZEUUBJlfPX8NULns83kg8k
	FnSOE8RS4PX/awUR+OMImSYs5HNZ7yyhqzpqN0eoL/QJUQMmjD2lLjdaEhzTRWhubxqCdgEa4S9
	or56hZxgKWZH3xkjyAAw==
X-Received: by 2002:a05:6a00:4104:b0:829:8942:2ca1 with SMTP id d2e1a72fcca58-829f70a6ba8mr1274217b3a.44.1773207971997;
        Tue, 10 Mar 2026 22:46:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:4104:b0:829:8942:2ca1 with SMTP id d2e1a72fcca58-829f70a6ba8mr1274194b3a.44.1773207971426;
        Tue, 10 Mar 2026 22:46:11 -0700 (PDT)
Received: from [10.133.33.46] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc15a1sm1073789b3a.11.2026.03.10.22.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 22:46:11 -0700 (PDT)
Message-ID: <adcb0245-6514-42f7-a47d-f6d8b3f79dff@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 13:46:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid dynamic alloc when parsing
 wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260309152050.191820-1-nico.escande@gmail.com>
 <04d268a7-8f6e-4aa4-b366-0dc38c355de7@oss.qualcomm.com>
 <DGZ17385SNYX.3149KUG92UUU1@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <DGZ17385SNYX.3149KUG92UUU1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b101a4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=TeFbt6PBOGW2pFLE-ZcA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: gweUK0BAuZwbXpt-YTPXU798d-SIpsJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA0NiBTYWx0ZWRfXy56USU8aqUmm
 nfWQMWembp7803vXHf1QLahsV3iyBGjwWWqRcjbhex14EfCLUFBIhXgzOq0z/Ak8gXy7rjaMEqS
 QkBnKt29Za7PDwMK2c1pu+9mcUz0qsJMH1AzjZR4IPfQNeKWsHzUKBI6h6BU6k7VOlk3AyAloQv
 aL0H+IhjIbB6TsoJXRIhpAJTqyxZCWJgU13hc5IP76LJdW2xNQ2FAtjPyT6Dl6k0zZUUJzgkFTJ
 70dsro3/F8AKrOkrJuVQiJ5J1LoiogKKrsqELmZamTgfeGgrEGTUROtbd154eMIvdetbUQw0AFn
 oQuzhDq7/DcenIlMnswG7XNFqMwvdm6TXPZ/WrYaxY+fiHi/0KiB3jzLNNkp6/DovthkljDXX4z
 stTcKDMknJTgLJDHnfIfsqD8vo+6FY/7abeg83DvLZZ8YeT1kANa55V91enyINKxf0eooWtaugn
 oqaB1bkIlRjfe2htiIw==
X-Proofpoint-GUID: gweUK0BAuZwbXpt-YTPXU798d-SIpsJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110046
X-Rspamd-Queue-Id: 4F22F25C85A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32951-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 3/10/2026 6:31 PM, Nicolas Escande wrote:
> On Tue Mar 10, 2026 at 3:05 AM CET, Baochen Qiang wrote:
> [...]
>>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>>> index 59c193b24764..ebe7b94fd712 100644
>>> --- a/drivers/net/wireless/ath/ath12k/core.h
>>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>>> @@ -19,6 +19,7 @@
>>>  #include <linux/average.h>
>>>  #include <linux/of.h>
>>>  #include <linux/rhashtable.h>
>>> +#include <linux/percpu.h>
>>>  #include "qmi.h"
>>>  #include "htc.h"
>>>  #include "wmi.h"
>>> @@ -937,6 +938,7 @@ struct ath12k_base {
>>>  	struct device *dev;
>>>  	struct ath12k_qmi qmi;
>>>  	struct ath12k_wmi_base wmi_ab;
>>> +	void __percpu *wmi_tb;
>>
>> any reason why my v1 suggestion is not considered?
>>
> 
> I considered it but I for sure did not write enough about it in the changelog.
> Sorry about that, see my thoughts bellow.
> 
>> instead of allocating it per device, how about making it global and define/allocate once
>> when loading driver. This way we may save some memory in case where more than one devices
>> get probed?
> 
> So what I did try first is to use DEFINE_PER_CPU() directly in wmi.c to have
> this as a static array, directly in the compilation unit where it is used.
> But this failled at runtime as the allocated size it too big and it would have

hmm, I didn't expect that.

> needed modifying the max alloc size that the module loader would allow. 

Let's not do this.

> 
> My second option was to add something in the module_init so ath12k_wifi7_init().
> But as there is no ath12k 'global' struct, it meant adding a global variable to
> hold the per cpu array, that would be alloced in wifi7/core.c and used in wmi.c.
> And that felt weird too, the wifi version specific part of it at least.

Agree.

> 
> So I stayed with the per ath12k_base, which as relatively low overhead for a
> clean consistant interface.
> 
> But if you guys don't want it that way, I can rework it. Just tell me in more
> details what you think is the right way and I can modify it.

then how about adding module init path to ath12k module and do percpu allocation there:

in ath12k/core.c

+void __percpu *wmi_tb;
+
+static int ath12k_core_module_init(void)
+{
+       wmi_tb  = __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
+                             __alignof__(void *));
+       if (!wmi_tb)
+               return -ENOMEM;
+
+       return 0;
+}
+
+static void ath12k_core_module_exit(void)
+{
+       free_percpu(wmi_tb);
+}
+
+module_init(ath12k_core_module_init);
+module_exit(ath12k_core_module_exit);


> 
> Thanks


