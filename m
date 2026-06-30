Return-Path: <linux-wireless+bounces-38310-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id giMWCZwPQ2q+OgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38310-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 02:36:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E2E6DF68C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 02:36:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=T9bKJsMu;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LOMyeyBH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38310-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38310-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA5C3010DBA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 00:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814D487BE;
	Tue, 30 Jun 2026 00:36:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1A1A9F97
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 00:36:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779789; cv=none; b=FnOzYi1XFANlAYXRkKTqBuIXp2zsez7KOpjXl1VRkY6JBA8X0IO7BeCljHrZmPcgkXAkUaYEBVQZ7PwHcNhOK2nn1Y6mLo5QVEST065ZWZeSgJdlVMFhjkbLkGpLS3ThiPbu+C1q5IrCGAXkYBCkAfFv1MuvC7TEIaa+wfqLqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779789; c=relaxed/simple;
	bh=iEwZxzPMbPz6l+nPMwX8wV4/WWm6fBUytWbAD+2SQnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B09aohv8XIGDPGTngjm1FalQHJ3F/cvR4a1A2+S4g6vx3EKu+Ff0lI43SMbCnNvjuYUClWTJj14QGR5f9JGtQ1JTF5KPvBNPcu+NCSF/7FHPJxK6rlLzWQKnINvF5u92TgjkYP13Baz+N1whO93siYw8nf56yNWoacGblkHYCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9bKJsMu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LOMyeyBH; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TKfSPw3993117
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 00:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JyXYxEG0ESVSIdsejQ3j2+rn1bSmGd9TW2F2ZPs62q4=; b=T9bKJsMu5LvJPBAW
	aQYCPIe5ij2B1zMvWDh/Ng6hV/ONpfzOZIIGqf/KmMnwfEckvxBR1I7Licdfct/M
	DbeVh7m9woBsIqR14IhYVPUGc7vLdJ275vkWQLW9gx/P82MJ0Iqjtc+u8nbhRH4H
	VltQS7zKIZ8rzMtwFLGPZohTQAx07d4lUdgA9Wpa6hLntUhD6JZfm0wfK68ja1X6
	GzLIRDqRvoW26RwZBJwGtcwlZdwqX8gN9tsWIwM/Uon+ZgCQj/a/BDTZWdzHV8MQ
	Owkwfy2xPomr1Pd8yOBnsGFZY6EQqkzxTaEESRxevmDqtN8BThukTOhXAArX7nea
	xwcYMQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnwbnsj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 00:36:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30ca81e05bfso3960135eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 17:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782779787; x=1783384587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyXYxEG0ESVSIdsejQ3j2+rn1bSmGd9TW2F2ZPs62q4=;
        b=LOMyeyBH762NVEY6UzkM4Jqp0p8gnqe6Tzn6Urb3VE/dtyKN4GTk66biYQH88U1rJP
         3mKodNzupoAsiieATLNi4+/OaF6olmKI+YqKJnOTEzBGLgY9Z8frH9qugkpJs1ZMk0GX
         kC7LNmhxP0tMra+2Wn2AtzS9qs8bH6+6tmlQLQKNkULEMsENtgPV3JdinJq0wDOYq/et
         QTpEsaauZWHpg/0+Sn8EIEiuq/L3pBScRxPO2WtoFNKsqJZ3v+UPeA4joo4paWoAK3Zx
         fVYJc1IT3Fzi3iEs4izIEPEjTg6p7Bvtri7Ri+5R/qVyS7w00LcfKMBsajD8xWUfkdax
         TclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782779787; x=1783384587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyXYxEG0ESVSIdsejQ3j2+rn1bSmGd9TW2F2ZPs62q4=;
        b=oB+/GPANzDEJJAob5FAuq6cLA2/QnyHyEuBrmxOQ+9tDsaNysZfxSbQVZK5NvJ2kR9
         Zjw9oRRRL5CC63prxT8K8mgnhXTImvKuJCjI59Kpa3C3LtsWfkYfr7iV7KxhX8ViyCLU
         miAPEgxCodQm1hiHCOb/oc69s536HaP67jIXUMplSyZea4Lijl1SolmsCn+Gjn1ptURy
         dN7qhQJe57DooUwCkIJvh6Zupquan2UKztiucerGIa/149f9P3fkUJHrGCo/U9HJ2AS8
         iKWDZV4/cA/EUQV4l5vw+2karaCkN56O7Ul9LwSbE2bN1Tmv54xt9u8tA8YhYsUxgkDU
         HJsg==
X-Gm-Message-State: AOJu0YxBoQt6EdF+8k6Chl2KcIijesuWFvOtRhgUsyYDSEuX9rvxZj5s
	y4BolXMh+HPasb4s9NtOxjwZJM3RHqN9N/72ALWxMZRcV28PW4ivL4UPqVefpZHLPr1DPEOsDNs
	Nb2wtS11uPskfbR9KDMKbABIz5c8dhYS3WvhG5dOkxxWic4yIvtqCh5gjLQpf32BPGtDCqQ==
X-Gm-Gg: AfdE7cnaOmwSGa8Ybhbck30AjBSV1zaKQANOSz9c5csMA4BgSlZPMi5Idldzi1QAhey
	D55QButKwhx7ayQ7TYO5UMk6p+XIYJkWGAvwiIIchW9xO2aPsTslgA4caGqY9l314RP1ffubpJZ
	6mRIluYhxLTNVz5NDhV8qKzzBEHZQvrLs8/iO1sNOoAyxNblPrNSM7h1o7S8q5sEDLrKYrcHoax
	lQbSy+P0VK3EqjmRX42OfET2WEpvyNs0xz0CJXLWMGPGehhFmSm0xk9ItOnlokQVt2vnnvihLDr
	C6q/a/o4eFQEAQld/39sAni0SpG9eXO7WLttGpJ5quYqAWk9Lfen6Og1oY7pgNeSxppZEQ73pX1
	j6DnLJrcC+o6kZ64HBOMyafS7YKzZx6Sx2RpuRouocQdsqiyksp+4XZQBrG70qdrICx0C
X-Received: by 2002:a05:7300:d0f:b0:30c:f84c:b2af with SMTP id 5a478bee46e88-30ee1489960mr1055476eec.33.1782779786661;
        Mon, 29 Jun 2026 17:36:26 -0700 (PDT)
X-Received: by 2002:a05:7300:d0f:b0:30c:f84c:b2af with SMTP id 5a478bee46e88-30ee1489960mr1055457eec.33.1782779786077;
        Mon, 29 Jun 2026 17:36:26 -0700 (PDT)
Received: from [192.168.1.11] (222.sub-97-215-84.myvzw.com. [97.215.84.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300e4a7sm1842892eec.13.2026.06.29.17.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 17:36:25 -0700 (PDT)
Message-ID: <2d776c69-51d0-429f-b716-b5302d657047@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 17:36:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 3/3] wifi: ath12k: allocate HOST_DDR and BDF
 regions after Q6 RO region
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
 <20260611033314.2330-4-aaradhana.sahu@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260611033314.2330-4-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAwMyBTYWx0ZWRfXxEN0ecVsTi80
 +/5nxjyVFFYWPeOWR6Jer1Ewrlt+t0vr3JNNNMevhd9rBk/EhzBO0kHkl7V8Wdda2soVBK0Z+bl
 PkrXNn6RuKe/n3hrLKfBA9pm3Ez6cj8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAwMyBTYWx0ZWRfX/zg3p4uKXIAa
 zDoXlGlJT5KYuZtvMQ4mmAp1UmYVgmbd5sPuuOBKeSCdf19Tavfhn5/1ZOPrYXIe/MDy7xaggaY
 yHNaAvVs5h9J5pAqiSPIDCC7FgFxMoURCLSwpYQLxB/TQfv5QGETXpkr9rF7BHZOqyUkjg9W+IE
 G9OUd5NvvLAiSQPZjx9jCm4xt5oplZ1mjovJ+CqZF3nPwnCGdeCMNw/FOa/n0vf8X1c1Fj3wZBF
 v7mLV8tHM0qkE6UrsyicNq+u4xUVU2ngqZnPX1z1vYTMDq5Kp+XTBpL/7qom0i3+v9lYpR5uiBO
 3PEsg8Fzo1ATN/yOmhf2o4YPe75nsYwD2k4Letx7cwOXcxKEU5ZS1918BWooxTCMiDtcT4nNwYq
 MsODAG9jW6+hDpT8c8aUJnn6LmGqpqiqbKZPewRbnaFDe+ZX0i6VIZVD7Yg+Wm06vFlDyt4P5F2
 h3eMX+aNS2z4W/rxT/A==
X-Proofpoint-GUID: THaEkkgYcJSGVjioOdeOtfVQwslXBf9e
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a430f8b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=i4k25I72rCCN9bAAQd7+Jg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=4hV1t40Bmhtoe2JT2JwA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: THaEkkgYcJSGVjioOdeOtfVQwslXBf9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300003
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38310-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70E2E6DF68C

On 6/10/2026 8:33 PM, Aaradhana Sahu wrote:
> @@ -2781,9 +2781,12 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
>  			goto out;
>  
>  		avail_rmem_size = resource_size(&res);
> -		if (chunk->type == BDF_MEM_REGION_TYPE) {
> +		if (chunk->type == BDF_MEM_REGION_TYPE ||
> +		    chunk->type == HOST_DDR_REGION_TYPE) {
>  			avail_rmem_size -= ab->hw_params->bdf_addr_offset;
> -			res.start += ab->hw_params->bdf_addr_offset;
> +			avail_rmem_size -= offset;
> +			res.start += ab->hw_params->bdf_addr_offset + offset;
> +			offset += chunk->size;

avail_rmem_size is size_t (unsigned).
If bdf_addr_offset + offset >= resource_size(&res) (e.g., DT
misconfiguration), the subtraction silently wraps to a huge value, the
avail_rmem_size < chunk->size guard passes incorrectly, and ioremap proceeds
out-of-bounds.

So seems there should be a test to sanitize the DT values.

>  		}
>  
>  		if (avail_rmem_size < chunk->size) {


