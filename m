Return-Path: <linux-wireless+bounces-36405-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPCtMpxVBWqAVAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36405-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 06:54:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE553DC5E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 06:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DB973036EA1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 04:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA63B840F;
	Thu, 14 May 2026 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLXLvucV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CHeCZzGf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A01C5F39
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 04:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734489; cv=none; b=srjyYORI8yRUiTPe80I28FfMHTsSX7wEFQvv0rrq/j+fv71z6zaSC3DL4hC9CnB++z8N1tIsi07vUT+vPwupVnsvskqcBjHSPjPUok9f2kufYTdbr/e5S076rULgSAtvOW0koo6m9FkBK1GmNQGdndOnguHWyyXmBt9CBATq9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734489; c=relaxed/simple;
	bh=kej3RUhPAMLZrTvAxmEd3g12iVz//65laABXoswSdeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rejlv2KH1dacEHk6qsA1zK8V0ybrdLC+RauocdHTTUEVpFxCGWOKLCQf0K2LJFgwZVxfZnGEbkv60V0zpYfU+gw+hCiWrpdKce7ceTA6jNs7iaKWrmqBmSJc+k2G8YhoRF/t4+zRv3inbZY/jidSQH9zC3Yd0uqzFiVoYqpAimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZLXLvucV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CHeCZzGf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E35WJ91096610
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 04:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZuLPtwpcvWP+BVIoZY2D5pGrjRu1PqelS3IjJR6x5/I=; b=ZLXLvucVCuKvR2EA
	cfvmI3H96Hc4yjIkK/XsZUL93fR0yHnNMcWX/ovEdlcP/9mDz9cBP7uW2eRlTEGo
	krf1OeTikpI6HNfEjAtwtFfRf8+l8CMs/xDP5QC98PkBM1NN61M6ubCNa+X9aqdd
	dyYyMkUfLwWyS8oAozzl2BoHPUrnUWb3jVdaQVA3x3V616GfMDdO5yr9uUsrVXKb
	fyzuc6rgGJrnjzwygrJy2AnqlkptngTGsPi4zXxf2IQKqcWofbruxNislX/LAd2e
	g1n6JIbhTLX8e1z6hkCdP9zlgHU0yz/bEOalhdkH0kAl8untSBAL6Cm51779qXbH
	wut09g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e566bg9hb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 04:54:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2baf7378ad0so63320705ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 21:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778734486; x=1779339286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuLPtwpcvWP+BVIoZY2D5pGrjRu1PqelS3IjJR6x5/I=;
        b=CHeCZzGf1Bh3CF8WEEhw6PwYoM1pXhbsc5dQ6vWk2CEiwExUvHSJpJa9Sfo/JpKtcm
         MVNC5YAG101L8/1JI3pXffou8VfyGplGSFc6FnpPS+Pcd9EocqSW84WYEhcf0rhOV/xg
         d2TU1OK3bbG2Zwx0aT3zf7XJhFSvtOVzvP7ESO1xyOMsr1lUdV0eDSSsEWWFkd0J8d4n
         O0099+Z24Q2L2YoBQmIBqFfUQxYRU1vKk5uRWGw6X4zG0d9+NZexRS2cIwaryEI/KMNA
         UQ0XyoGhWe1Mvw5oMC7v2MiGLAoE6S97QV5ATre4O3LoebbiIv6Y4/h/G6TiVH9pQQIU
         RxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778734486; x=1779339286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuLPtwpcvWP+BVIoZY2D5pGrjRu1PqelS3IjJR6x5/I=;
        b=iwylc9mIGIU2exBzEGKhwqyygU9nAtdGlPHmUf5UIK42vSBeKjNfUG5/wNhHe77nCp
         L334nXYXTPGh57aaVzCck3krkWZVS2iNtsF4WHrOU9G0Q72zeqsR6QWZu8kp3ZbFQz5J
         xP049GhIuFJSoYH7dQ0wr9qbcBeGF4dlrItd8P/GSl3yOkm6XX7XxIWuzZRaWDryrtXq
         TeiUKURwN+wxOcULS80z7Q00BTFvbX2cmNfgG2tLMeHGTFuGio1mUOMoJRNadHAIYmrf
         9amdfyNfY7Qgv08PGlm/oJYzZkCNtZPXUhFOy7nSqn05EEHwNZ9x7QpdAyQnw6kVMDAR
         539w==
X-Forwarded-Encrypted: i=1; AFNElJ9tpUZi8ryHuIrDzvcNO7eMRLttFcaoYCkhpaPHFuqXoUKd/3mmRKdu8q8B6z7ojltNPHbDKoznyzMinV6iOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlH0v0wiL63Ks7pULC676MXInCmpwo4I0rJjceo5sZazojgg31
	kI9b8bmsVu/lS/LiHoRJeVCI2J3FXwpYZW6Ic7sCYZQtGqzhK/0McOOykhSKMS+sF+xolSO5cgH
	yc+P1rbqrHsDrZdVneHz8xCDXlXNHCUPX73GkvaX85MWzeLxxWQcypdEJ6+AeUUY2QhOYSg==
X-Gm-Gg: Acq92OGdFH7a/AzCLDH16KN//cJyJdlkhbjXbN/BV3sTyzzjNlZxT5JAovrSe6Af9nP
	bKouZp7pNBrJHI89uEpJlkAypE5M7rm1WTLJ6k0jWiKaozraF3bMAwiMVdlGFFY1/p1ZCuF5g93
	pdnTADBl3b0cK9+H2eo8wiunKAPcmQCvhXHQ0HT30OQWaOmzcetjlsX1XOWx+I+fUWVEo5K11kw
	VJVIcJZO1qsxYBY3S6Rkor4u9jnd5ZsIBw9iKWdSrG/hpg8GlLhV0ICQFKlF/qa+a+UpoLjwbaf
	4/ydEZOJdJxgJWKG/Tn721TSUfWjjQosRRAyS5OjjePeW1aComTboh+gWm7hZ7BN0MByxO+7l/j
	ODoYxF5MMA/TdEm4dz8+3u2EIw7Hv3opcs3VAALJYvqN/vjxtmgeI6LgfOBMWDFj9SBAEz439
X-Received: by 2002:a17:903:9cf:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2bd2f4cc122mr55750065ad.2.1778734485576;
        Wed, 13 May 2026 21:54:45 -0700 (PDT)
X-Received: by 2002:a17:903:9cf:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2bd2f4cc122mr55749805ad.2.1778734484963;
        Wed, 13 May 2026 21:54:44 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6512sm9094395ad.52.2026.05.13.21.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 21:54:44 -0700 (PDT)
Message-ID: <324401b9-f6c2-4d2c-92ba-659f78b4ef6c@oss.qualcomm.com>
Date: Thu, 14 May 2026 10:24:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        rameshkumar.sundaram@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
References: <336655c6-4dac-46e9-a783-549f0a9cccea@oss.qualcomm.com>
 <20260508103202.456865-1-jtornosm@redhat.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260508103202.456865-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wDTadi5MaeObQh0M1xkVUZJAQ1brUBVg
X-Authority-Analysis: v=2.4 cv=WsMb99fv c=1 sm=1 tr=0 ts=6a055596 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=M0CKB0vJUJO0TNvbIsAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA0NSBTYWx0ZWRfX2uZfz4IYhu2d
 cUC4yAh4sfNAFIMB8+n74DXRdWX6QcyrN/M6JnfIv+kMR/FQWYMi+Vy90MUC7J/bFJzZMQgW9CD
 Q03la98Dg8gIZnw41Vrq02e/mr55uL4jDfWrgT4Iylrr6CwctthGUejPMvaJ+1e5qvDy4etYSSb
 YuxP3hb8spW7bLkUgh4pKBkGkG/3fkMksB5SkHRn98LT9BiTEqKNudJVHO1ffzhNdeEZ3/UbNyu
 icjk22zzPbJf4TViBhNtgh84yrnyY4rmVsxhQTvbpVIgJJ6mYUqj/CsV1C+0yc8/EqTpXJ0LOBL
 pFze6kzBruf5ecMo6yPpfHeJtrCZAcSAoWgN2QNa9x2mriAZoNx5narQEB8yYNOJeEvzgsK2q/H
 ErRj5hNHUl4/DMjf97M95SVLlYhbDIheqYc872eEs0zgb9Y9eno1+8cC+a9f60Q5c9kFdj3/id0
 aIY2S6ri4GzDF2AwnPQ==
X-Proofpoint-GUID: wDTadi5MaeObQh0M1xkVUZJAQ1brUBVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140045
X-Rspamd-Queue-Id: 3FCE553DC5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36405-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/8/2026 4:01 PM, Jose Ignacio Tornos Martinez wrote:
> Hello Rameshkumar,
> 
>> What is the exact failure? Do you see any driver error logs when it occurs?
> No error log, just the warning.
> 
>> Got it. I was just thinking along with the proposed fix — whether we
>> might also need to handle the sequencing on QMI failure.
>> In other words, do you think the issue(double free) would still be
>> reproducible if we include a change like below ?
> Yes, I think so and in addition the code is more robust.
> 

I agree that setting tx_status to NULL makes ath11k_dp_free() more
defensive, and it matches the ath12k fix.

However, i am still wondering how the second ath11k_dp_free() is reached 
if ATH11K_FLAG_QMI_FAIL is set.

In ath11k_pci_remove(), when ATH11K_FLAG_QMI_FAIL is set, we take the
qmi_fail path and skip ath11k_core_deinit(). So the normal remove path:

     ath11k_pci_remove()
       ath11k_core_deinit()
         ath11k_core_soc_destroy()
           ath11k_dp_free()

should not run.

So if the double free is still reproducible with QMI_FAIL set (with the 
change i proposed), either the flag is not actually set in this failure 
case, or there is another path calling ath11k_dp_free() ?


--
Ramesh


