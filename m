Return-Path: <linux-wireless+bounces-38317-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NUiYCkdXQ2pIXAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38317-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 07:42:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB86E081A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 07:42:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Q6pwMwCh;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GtGOXzYR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38317-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38317-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AEAB302BBFB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31A3C2B92;
	Tue, 30 Jun 2026 05:42:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A235AC27
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:42:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798147; cv=none; b=JXlt9JwYW4mj5f3xusKi/gtdixceYutjgGfNtAlMHNpZ5SsM7l3xNGrlwR1iS2PRTXKUjUXVXXIgfvgpjFR992k56ZTdeslxX95OC5yNsDZIFkKvEVpmvbIaCSCkhKqXaeuWrBUZTLE087aaMeRrIcynt2QKUcgfyBXwHPZcqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798147; c=relaxed/simple;
	bh=dATHzFjWz+Inz7lV+ptn40eW4BGrB6+zipj5+67uOAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+k5EocunAX44lzwag350ncj6ZGtahxG0ybVx4XNQVq+epllsTiLM7tjq6aLxx9fVaD0edtE1LG+uNfuNJ4m/N7kczUme8BENDGXW2G+sua+8749eQmZgbJ5dozIl/7VVKtLimaZfb+4UDnAx1mJ0i42bGWp2JxFwPAM5ky0ppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q6pwMwCh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GtGOXzYR; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5ca90923744
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xJwvAFHEK9s3I/8xFBiYMAEpBuQU4d5Kr8R3MMVnaSQ=; b=Q6pwMwCh54V0WWRp
	satFpdSIUvnKGDKrwBslw297/nd+XE51zFVJSo/w/HCg3xdYXHRxw0VlmrFcMMWO
	siFq6dOMgnt6kSyzmi/uBSjzOcepEvD+ENSYMEigJw/Xyjy4zCE4tcTu8GohMh07
	rnEG3MRpSQ0TDoLwgcx0gkc26PRIp4582QheR4Xwh0STxQYe8LvwEXBhwNR9buN3
	78c1Mi9EitCybEqJaXnO6JmE1N1MSsW1ZWbWzo0lOHCQDvAO4roP0G/TglYVPxKh
	FdIpW4a45o5BSdKioI6u6MhzTETnbB5UTgSAnDQopHOWL9qLOx3xWCs1izecR+2K
	IFyeaA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9j1pmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:42:25 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-137fc6f8e9fso7402409c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782798144; x=1783402944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJwvAFHEK9s3I/8xFBiYMAEpBuQU4d5Kr8R3MMVnaSQ=;
        b=GtGOXzYR7Z1U203TY7lCpwO2STKEG5pNA0AVBRuHfLvnIPrqpkeShFYQCoq9pqMaIA
         njbBXwJVTuFW+mhje64gu5lE3JHT2Ep6P2neLqmOv4uMNKH/LPzDUr4VDhQ2t3dtlNeM
         9GLlm0jnPr8QtjsxKUKav6U7EUd4nTDpcE7MMgwi7pKOmjcumU46Z5FUY8i0lKAXVB67
         ZVIM6c/tfS++XOVGF8wJjLulfgKvNK8WWMlkvr347RrmF8phTZc/Z+LzPMiOpOzYSdm9
         LMKbcLU0mlcYeZ7/dmvQJch2gtSozESqXZTdJESRhQJoOOnpA5Xo3y2g2G59PU0MeyCX
         cZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782798144; x=1783402944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJwvAFHEK9s3I/8xFBiYMAEpBuQU4d5Kr8R3MMVnaSQ=;
        b=tBPS2+68mTv6xDW/mm9B/aEfo7a033WHkTfATnGjPql+Ut0fqe2F0xnhUV8bK3sqxO
         7Qbb4857rwB7HD0fW6CpbjcWZfCpR6PR8STG+TCY4g+C/xWeCzGD4xCs1ry9u/OazabE
         cf0AtvKZSTRFFeynfddaX75/LR7HFtOJG1xvMpI0MdXdKLWLYD7fwdIyno/+2coghSsq
         ENkm8BnN/fIOomLh8fNSMQ5sXfExR1hE7qDpNW20Ap0AyBX/eab+gB1aC+PhckmqLOZX
         HDK9bqvLNowxiMMW6+ZAS7rbnBvWGU3uckzWHO4W8fI6RhPjE3XcEXUqfRS6s5p0DBPJ
         Tx/w==
X-Gm-Message-State: AOJu0YzDeF53/BRBXCgNeIv3cdJv6yz9zlwOd39AjqaDePjvpDjBd5kO
	V5nLrCz9JIAVujy/etBBL7e/Y4L7LMbvDz1Z4ArJnMff2vJ1Z9SrA4n9cQdLxorRpBQ55rAb3e+
	fXcyC4psxqF6aaF2A4ITbVXs6/KpkMzSH/+83GEJZzB6IihwTyGaizkjY7SO5l5pYD/bFjXr5MS
	cdMQ==
X-Gm-Gg: AfdE7clQl4PgFYeItoq1OE6Gbvq++81pkwe86swlrprA1r9ENEIa1Wa1YLB+/Abi/Bk
	G5sEquoyAxFYKgIIzRGfghtXKuVSQ3msJys2lwkD04nCq/Oo3shpgACQn7FbCfS3YRb/yDRTXn8
	hzxZ8e1p/sjYx+0NmlxHgSCQBtP+mlzRxyqzyD//TGt6gaVTRiriAYerCU+DI9IWQ6wIg6cwXO2
	ieV6hFIT52iNYd6IUliaNbjbng05i9G7Js+E7CtY1zoNlxaCD1Z+/hDuGn+RdWfOtiviO/o6jrQ
	MyYkEP/01euS1wRWYRXleBn9TE1x2LQGjY7wFk5pzjrR7iJM+r+EhMj2YiQRe0JzqwjQ7WfMTHn
	3GuN6+jeJzNMAmEjpVfjDITtYQCkfmhg8WfJ/aH+g1/NS
X-Received: by 2002:a05:7022:ec2:b0:13a:f1bc:b0fd with SMTP id a92af1059eb24-13b2a1a6073mr1391873c88.25.1782798144431;
        Mon, 29 Jun 2026 22:42:24 -0700 (PDT)
X-Received: by 2002:a05:7022:ec2:b0:13a:f1bc:b0fd with SMTP id a92af1059eb24-13b2a1a6073mr1391850c88.25.1782798143850;
        Mon, 29 Jun 2026 22:42:23 -0700 (PDT)
Received: from [10.152.193.243] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba8008sm3121437c88.11.2026.06.29.22.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 22:42:23 -0700 (PDT)
Message-ID: <4b5e5931-7bd9-42ec-9d02-cc60ba5b3425@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 11:12:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/3] wifi: ath12k: switch to name-based reserved
 memory lookup
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
 <20260611033314.2330-2-aaradhana.sahu@oss.qualcomm.com>
 <7fd9e186-fce6-4c81-8aa5-f0de961fdefe@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
In-Reply-To: <7fd9e186-fce6-4c81-8aa5-f0de961fdefe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qC2RZ-BONrVac0ja41FpIF0TkZw62RCa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0MiBTYWx0ZWRfX2s50Vqw6k6QX
 m6KnzNL9zmMM0/O0Wi/tY9NIfPie7bXEd+Wy4hNQ48KMr8EC2SMH/ZQ7GtFBYwCYsdBb3/VbQzz
 +ClE0qrYNUbVQK93tPyGskvrwzNuRLqnYuOAYzmI4ph5s7q8+sI9PwgrLU8DYJ5tek56ldxHR/8
 LHMysE5CsQcO7HWBkYq77k++ZU8GjzdShMTHXgqLO+uLbp+iU203xuxRte+41/Mw8JP3iMhHvJe
 pRtNc5euMXdlcBOR72gsckQ0KXEXTZgr4VoE1bc/8z5aHPf63OdPmrmZRoqgDS74JzzuSTI+TdB
 d2PPLiVGosypnom1rV//0hmfmtqzqRUkULrY4BfarUamfxn06+GTuwdQEg8Zo68A8EFEaqkF3yQ
 tvje0iA82orPorYOfzx9wZuN+FyUjYtOrO9b1LAiSNlTILhxBxZo8L4hZEb5hD6q8xb2m79qN2C
 mjwHbj+qnoWXX99xtSA==
X-Proofpoint-GUID: qC2RZ-BONrVac0ja41FpIF0TkZw62RCa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0MiBTYWx0ZWRfX1YRzpJSx3k1e
 +tJpTpQ/nkrzbzR7U7xZOVMoSiiMrOlsP0S5EAfiAfWIIV3Um1/j/LeKIh1i99NFSQo06jMEfC7
 3YWgqRIww/Sp65iD+GuQ8K6XnNjz3X0=
X-Authority-Analysis: v=2.4 cv=SINykuvH c=1 sm=1 tr=0 ts=6a435741 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=EpDD1ZJ3bB9NxIIftg4A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300042
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38317-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82FB86E081A



On 6/30/2026 6:00 AM, Jeff Johnson wrote:
> On 6/10/2026 8:33 PM, Aaradhana Sahu wrote:
>> The driver currently retrieves reserved memory regions using index-based
>> lookup, which depends on the ordering of reserved-memory nodes in the
>> device tree. Since different platforms define these regions in varying
>> orders and combinations, this approach is not compatible and can result
>> in incorrect memory region access.
>>
>> Switch to looking up memory regions by name instead of index so it does
>> not depend on node order.
>>
>> Use names already defined in qcom,ipq5332-wifi.yaml, so there are no
>> backward compatibility issues.
>>
>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/ahb.c  | 18 ++++++------
>>  drivers/net/wireless/ath/ath12k/core.c | 25 -----------------
>>  drivers/net/wireless/ath/ath12k/core.h |  2 --
>>  drivers/net/wireless/ath/ath12k/qmi.c  | 38 +++++++++++++-------------
>>  4 files changed, 29 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
>> index 30733a244454..695b605a92fd 100644
>> --- a/drivers/net/wireless/ath/ath12k/ahb.c
>> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
>> @@ -15,6 +15,7 @@
>>  #include "ahb.h"
>>  #include "debug.h"
>>  #include "hif.h"
>> +#include <linux/of_reserved_mem.h>
> 
> system includes should come before the local includes. I'd fix this in my tree
> except there is another issue in the 3/3 patch so I'll want a v2 for the
> entire series.
> 

Sure, I will fix this and the 3/3 patch review comments and send the next version
of the series. 

