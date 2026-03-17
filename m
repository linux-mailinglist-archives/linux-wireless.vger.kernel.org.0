Return-Path: <linux-wireless+bounces-33324-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BqFiEz/LuGkSjgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33324-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 04:32:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92162A33AC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 04:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DB5630094EC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 03:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CA2FD1D0;
	Tue, 17 Mar 2026 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KxGHS7Er";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/Ktab7T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF92C21C0
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718330; cv=none; b=sPoDid/if1EkFEFbbrVQGsjspL9H+TQPzl/GhV/mZEu4akoh2KHGmIgFMyVli9f66xW2ZkgdWwsgM2n4/h/qbr1jjPbjJbdWqzycW0/SRdQWA53IPnCg1WQfDheA6yWB9vibTB9cMi9MTW0hoZU/ePgJ3hhzlVfk5xkrq6Wollc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718330; c=relaxed/simple;
	bh=oxTRSDoMdq/mzlUnUw1ZrlN02txBqamdfEjr1nmc84I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfFuV3LkZp4dkgejEupWDuHy+2ZtzVFK7SoH3oxAOPMFD3bYBF1NxqYYAuiSpKPJcP92DZuiNbBt1+I2QtYu6YJANE7sT1iSkQdbOqbAdwfarf7ZrXf0hHG+sBW66IElTG0aNUC32S0hVUNS5EkvNLD5kRIcLevVT/E7Mua1gQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KxGHS7Er; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K/Ktab7T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H1QjsG1534048
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 03:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z5d7SpaThv2YlpB2AIVm1TAoC97B3vVdAG0MkkHD9h4=; b=KxGHS7EraghVe/vP
	GoIDcjYK4hu6Ag2Mg9EBwGAnBF9rcTt1T6sOX9VhNEpGMq+fJru0yBFZnWbNA4zx
	2ubqrTOHrCXgmaj7Z8NnUrfT0SLRsKHDmSZG5/VxZkrgwM9DcoTKs1z1FjNzjqN+
	MqNDsMrIKeRNilKwOBhnrNEn4wrtMpLl4MfbSX9OZ98amzaaFqBLXlPVrFh4G6G5
	SC7vciumpz6kiutwMkhPFd7OmUMGtTPkseub6UjgmvfbDZHcAy+ScK+2HEXTCSW1
	MNsXkbFSIwNKjOwSQ3FtpM/tftYe7vaCWF+eNz+g/nuaRwtNR/H+mveRD/WWMluc
	Ni9EXA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxm5k26u9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 03:32:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829942cf9deso4160006b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773718327; x=1774323127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5d7SpaThv2YlpB2AIVm1TAoC97B3vVdAG0MkkHD9h4=;
        b=K/Ktab7TcnmTmPbtvp7aOJKM5Rpq16Rd+Shl9EaGeN/uSFYwChfjHfKHvIRoEoVbYP
         a1MLXUWJcnIZnJhd4IiNs2fKc1UutkyMDtO/1SJc+LIXI1xcxcKdsBOVztJeStwGd18Z
         QC3w4IGdnyuYJmsf7OGPKHVTLKXl36LFxRp91xfsBuxUMJs5kKfpQOWPQYU1BZNfFcHu
         hcADoSxHPwk7AOzsu/mTA3j5IHsH2nIyTo92WLfBPTf61/NemZcMudQpUHhwWdrQC+GC
         34aYlNa3Cy46NT+O6uzLdlLrl2p1fOlWblGd8qjGKbT7peV/TiVYLef3O5H+gAV0TIVM
         LeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773718327; x=1774323127;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5d7SpaThv2YlpB2AIVm1TAoC97B3vVdAG0MkkHD9h4=;
        b=DL1HcwPpifITm+M+6E6AY9erzNYVbmtnbZ0w5NTquFowEtSnWoDOxkK6GxbjrOhOaT
         8++plPaF6f8SEVuJd1BUbdtlPj8WqUFLL/QZGc9WKD24o3m61y8oAby9Uy7oXVR5z0bO
         6Hp1lP+N84+GYnRh5YQnhHkbe9Bh49Usj4Zl8fArarN6SE6TkKt4luEhxL7qro1g9BV4
         SYF9ZUhpnFXl1SyjnVsuP3r+4xMBko+c/gBtXK8b46WG0jGOlYRytO5sUUDH7COjuqUs
         U2/MO6lsHomQg12oyZLJIrKbN+7apBS1qCxZXOOA6U1BEZ8sPsPc1NGK4tyfNwWVurRr
         IEBg==
X-Gm-Message-State: AOJu0Yxd3AvhQy+0ngZQ2oCKSS+bIHToljX3+AZJgZN/0CRHTGNSqG7G
	lvt7E8O1hVL07wnjmCSRwe2F2mcmO8HLsure51DRrqz8bV+PD6qX2jtp9A2jjmqr83s28sLnGXo
	Y/Re4UpWFvZuamrgwUGkOiD7EHwQN1nsiKBkTGMXWujIb/1KieLor3krPByDJQqZFY1ofoQ==
X-Gm-Gg: ATEYQzwBUN/KrlVWyMl7w7aoKvaDiNhwjuZ4lNTnoRYQ3pM4P0fH/qBuen6r5cvFsPq
	FGD8/IdMY7xUU8ni0xqJzRRdhO6GM2WHWaw8gEB0WXLIyZLpoxoMOT3nakcOkMqphuvs0pCifrk
	z2ZItcNqg8bPjhRwEMreJ2DZYhblCM9/PT1KQI07WI4OsEIO1kUwnmvTBTyMmAXFZWz+kLeM0xj
	DjGXIiZCy3r5p9bVTXaoQjfzsZqdIUn8/z1zoaWfBd4M/IbTM9t4zQdRDSR48aV3lfmm2WxubyS
	y98BMq9+m6ILB2thcfy3imfRFJWh1CPIlIugXl1zoew30aJMPQZT3aJ0APwXxy/uVDYxPbKAKMN
	TBNT6qp+tEfQw3x0MK6R53D8fZ3PRor0osApWn5jM1YDOkoo7lP7nT6SsiGoxD1qMXijU4gXisl
	qP1jJ2Q+PyieMR9kZ7pdE=
X-Received: by 2002:a05:6a00:7704:b0:827:2891:c17b with SMTP id d2e1a72fcca58-82a196d723cmr10511209b3a.17.1773718327360;
        Mon, 16 Mar 2026 20:32:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:7704:b0:827:2891:c17b with SMTP id d2e1a72fcca58-82a196d723cmr10511189b3a.17.1773718326726;
        Mon, 16 Mar 2026 20:32:06 -0700 (PDT)
Received: from [10.133.33.128] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a06fe211csm15255762b3a.0.2026.03.16.20.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 20:32:06 -0700 (PDT)
Message-ID: <bf6b4377-1673-4273-8d7d-6163f0109e33@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 11:32:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260316103248.3042158-1-nico.escande@gmail.com>
 <d38acb9f-60dc-4d37-a3b5-8cd09f76939e@oss.qualcomm.com>
 <DH45I9X47H77.74AIOL6V8R49@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <DH45I9X47H77.74AIOL6V8R49@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fJ00HJae c=1 sm=1 tr=0 ts=69b8cb38 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=ByHDnCq9wcmhMw9lLjoA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAyNyBTYWx0ZWRfX2uO0SM9Yai+B
 YFzqV5wGczmuPznLHKGDWO56FRWxJ/RwsA0HOVj7sEKjRuG+iQQITSgcl3irp/XswtvDUiwCU3l
 YpZBMrSbBCHJGRZJ78S46aDBAgVxkElTgpHnzr6sZFDLCI+PLz/aszoQxASSys74qgNEBxZ4NxS
 DlagVSr9tCvDHRq+ieX4S/Eaz8rujxWJZ6mIgZGCrS1RtmQc5nCj/5Gxb7eraY5RbN6+WKf4K3g
 3DXfkXJ9pF1BWUu0e4hb9yEwTnozDlmzIKuF0utx7aAOcnK9ud0g0APw//AafcRsddBwYIS29kZ
 MhQ33X57enpklk1IvNDg3H7nNWr/uVjl/nwDo74LCCCpr+6tRRn9r9n635pp62DN4ZbCoBtSHHL
 0Xbk4lDWPhgtieInLa1usyiexmFh50G9j1+7OIkVQEj+2Zf6VKUoMnmqXxWJUo53dENVdV9AeJf
 V6/GS2yvdlJIMQrruwA==
X-Proofpoint-GUID: IR3f9JOuekCedi4Kc39A-Vt6YnHMDH7e
X-Proofpoint-ORIG-GUID: IR3f9JOuekCedi4Kc39A-Vt6YnHMDH7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170027
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33324-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A92162A33AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/16/2026 6:57 PM, Nicolas Escande wrote:
> On Mon Mar 16, 2026 at 11:42 AM CET, Baochen Qiang wrote:
> [...]
>>> --- a/drivers/net/wireless/ath/ath12k/core.c
>>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>>> @@ -2321,5 +2321,24 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>>>  	return NULL;
>>>  }
>>>  
>>> +static int ath12k_init(void)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = ath12k_wmi_alloc();
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>
>> nit: you can simply
>>
>> 	return ath12k_wmi_alloc();
> 
> Yes we can, but I did this in case we need to add more stuff in that function at
> some later point. It would generate less code chrun. But I'm ok with a direct
> return statement if you think that's better. Just tell me and I'll send the v4.

I would prefer a direct return for now. After all We can always change to your style if
necessary in the future.

> 
>>
>>> +}
>>> +
>>> +static void ath12k_exit(void)
>>> +{
>>> +	ath12k_wmi_free();
>>> +}
>>> +
>>> +module_init(ath12k_init);
>>> +module_exit(ath12k_exit);
>>> +
>>>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies WLAN devices");
>>>  MODULE_LICENSE("Dual BSD/GPL");
>>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>>> index 59c193b24764..02ee6c718621 100644
>>> --- a/drivers/net/wireless/ath/ath12k/core.h
>>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>>> @@ -19,6 +19,7 @@
>>>  #include <linux/average.h>
>>>  #include <linux/of.h>
>>>  #include <linux/rhashtable.h>
>>> +#include <linux/percpu.h>
>>
>> does it make more sense to add this to wmi.c instead?
> 
> Indeed it does. I'll fix it.


