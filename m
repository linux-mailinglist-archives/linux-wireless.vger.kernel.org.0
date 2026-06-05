Return-Path: <linux-wireless+bounces-37445-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wx2EAjZDI2q0mgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37445-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 23:44:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 550CE64B784
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 23:44:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=edVgx9Rs;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UjhV6PcT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37445-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37445-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A177930071CF
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 21:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437713CC7CD;
	Fri,  5 Jun 2026 21:38:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15A3D1CB5
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 21:38:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695497; cv=none; b=bvJYWExskUFJGQ/M5FVejSoO3ZLB3+Xls1qNlxidmMJonkdSJJrRty8E4viU3DG2fWLdRG8TiddkQqnKokxjSzsxfEAbYRbQJ8NUR/bOChxQwMZDKQVl9/NfSYPslJ+HEIjwd+NM6wL9O/c0JnZAFxCYpFl6ujpngfXSkWp6e54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695497; c=relaxed/simple;
	bh=0K+AB5PFn5WtjF58FEP1dz9JYY/PUeZjSdj2LWZwEHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2f1/gbyZGWNUjbfipYk0Jti7W5Do9kotz8M36eKtYch70w6oedO0NobUNJ/2AXKaorj/XEyYKRftl3diusEezChJQKazPG813uhb/eX07Gn/pcsvAADiGcp32oUCD9pomoAk4I2dJoGIy+SbZFxtYp63fLzzwd9OMR3w+NCL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=edVgx9Rs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UjhV6PcT; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655HKD4u1462276
	for <linux-wireless@vger.kernel.org>; Fri, 5 Jun 2026 21:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TB4d3r9Pj0Fp86vFxmIbfo1mhpILa0hZWacGVLUflYc=; b=edVgx9RsXwz8YitE
	T+bCnJfkuG9FvD8Enx4rHZ8xs5Ib7nXHjOaqSaXpiAmt0H/KeBNTGt6xwO4w4Yk+
	NTkfPrMaXOGPaYP1AOk5Yk0pwOhLZ3NYww2trLNqrITPPANLU7nYWrqzMZijmmVn
	ou/YhRBSR5ICDOij9HQ737IiiorDKGWoSRkVI/YKFBWV6lA+4dH4Bbapw03niaLx
	ZFv5avzL/5Lk/2eQaYDKhyvfSfTvOE4zfCOPBgsTvYq1+PZLcwuSykPliESXjTNf
	1nZ51hn5aBMS4Ae1kJkxioMtDxtKZFmMT/QvyzcrxIS0SBuqoBp1Xj8jnEDkJIEi
	ItIFlA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em2rvh4ch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2026 21:38:14 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1365eb2a74aso1316790c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2026 14:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780695493; x=1781300293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TB4d3r9Pj0Fp86vFxmIbfo1mhpILa0hZWacGVLUflYc=;
        b=UjhV6PcTsQBseOox0suF0pjOddnnTVLUAv55VxHDSAEF6w9roOrBjuPTlVftVjV4wt
         PP+usD1OrezlKpQHHrDJODVrzMwhAbVOQ3RD/lopdzBiHTBF2Vh+2BhX6FbtmqYj5k1C
         B/4FxAHALqzu0FLS1N1UobZBU7bvUJeK7itIxrrzq177rL6FQQgwJ/gxTa4+8kuCgTl3
         iVIYwtaZrNeW23YsyfhOJSP5PNPr4lK8gzltiNaav02PMXPh6M8epAQht4fv2Q6/kgjX
         2xMy4bT0aFJXY/B1JkJPE0zS9qTTj17tmkLy+W11oVGb04Dp8Kg6//LU8JOZ9otjAEY4
         /5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780695493; x=1781300293;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TB4d3r9Pj0Fp86vFxmIbfo1mhpILa0hZWacGVLUflYc=;
        b=TAcDadwzY+BTP6kBvlbK9JmXxVj80YcmBK0Dx6f+MeEk682GRDVyZ81qR/4T5dgzJi
         yssq3FoaZp+uY/4jc4MAw7VQx2VEqKn7K15r9jti2+yuRTODaz4ccGwCqaN/D98DEKtd
         pQ0P2sNa9cvroY1IslbG+n1OB7w/p93JakW/4x65aNxdIYUX2ATwGoMipQDRqCGkYYcu
         hvC3eak5fyMtU8s0q99cwgWk1eZPT+E5lXxrALEDoAav69kqrLfdfJwnzsTsmoIlvPKu
         mCuIh7y0OsMGSWkMFSd4j72lHdsHhQbJWZkoge1CtNdvtfh2k5LSyI3uQkEGtcJ0OGCv
         ZSAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jLm7IpQJmUNEikG5fdgSMeT7nVHLoAWWEIjbMB36HKX/mVfLhO4sD4Wz0Z2cV7lUVgPbZCF5tKcChjW2abA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yziynxv1EoHmofHYVs4MjArCSUKQFJPpjKP2awCDsjKFICuVp/D
	F+NmI5QkuO+wOK8col1ZPpBpMT6pcgZAuh2kH+p9qu8Ofl+M1nbDNVw6Y8brKenTXsZLOGQPFm1
	Fq4/hp311OvGWDCrv9PfqRRq2pJKkMCBcuQITzMD6RP7TtZWRVIGsCDO7b09H1/PtdEyLJw==
X-Gm-Gg: Acq92OHe8C0tQOX5fKJAZUvmodcBgNrOD0OQ/EyGIcYKjcjXLfPvp/z8aSFFJqcHKOn
	cfFYzFUXIReYhtD5fIKSf5OxUMtuXs51tF6E9WDJJgViUqGhl+sMWFt3FfJedOiX8amVkjFgaUm
	kYXH/LHK6/wcUqUMxSWUpnIly4wDMpvKkafj+TPPj5cqlzEIZEDkXR7KJoEQ/3pcMKWniJy3w2m
	0Vow+fUhQu5rGeSUQ5OyFTC084iurnYms+2Ee1YihIL1JcHAGf7wGFmoJLx8Dl/Cp6Xo/Qkrtyk
	qoKEy1UyG3tfnc3dAyGcxCS9JZ2cX9+por4KSIV9eyNgQi3y9N/OvHWh8sDxILkGWx3IuyhDC2Y
	e3dqBFg16oy4Z4bHpNda3g1ohCn2rTMBBVUYNq3Apx1Fimpk2WjI4i6Ry5k/ODf28+14N3hVTzL
	Tlqfv4W1w1DIGLNZLm23DVkeV6
X-Received: by 2002:a05:7022:ef07:b0:132:133f:63a7 with SMTP id a92af1059eb24-13807d24ed3mr1736885c88.8.1780695493401;
        Fri, 05 Jun 2026 14:38:13 -0700 (PDT)
X-Received: by 2002:a05:7022:ef07:b0:132:133f:63a7 with SMTP id a92af1059eb24-13807d24ed3mr1736865c88.8.1780695492934;
        Fri, 05 Jun 2026 14:38:12 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f548ade9sm6423011c88.2.2026.06.05.14.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 14:38:12 -0700 (PDT)
Message-ID: <fc3b0008-2e97-4fbc-a9d6-c2095e6ed6b0@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 14:38:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] wifi: wcn36xx: fix OOB read from firmware count in
 PRINT_REG_INFO indication
To: Tristan Madani <tristmd@gmail.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
References: <20260421135018.352774-1-tristmd@gmail.com>
 <20260421135018.352774-3-tristmd@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421135018.352774-3-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: k8C6H0O6pPjOqM-b6pYj4U2bCoLPuav0
X-Authority-Analysis: v=2.4 cv=BOGDalQG c=1 sm=1 tr=0 ts=6a2341c6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=J_-Nd1mkAAAA:8 a=EUspDBNiAAAA:8 a=XIB30I8Fq4NfyXnsoAUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: k8C6H0O6pPjOqM-b6pYj4U2bCoLPuav0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDIxMyBTYWx0ZWRfXxbzfr9twF6OR
 YIWXb3TRrmfbmrYMQnoKMY6k9raj5o+8cRPKt21gi9Lkn0Df4Hg4qU8DQDr1/3x/jwMgWFJ0wX0
 y+DJHgL8HpaLRkjOahKeZD58MLL9rwETYaXG8+7dPWvLOzLjhhFvvTpRk8kdc2axQ97e1/+ocr/
 1J9/mp3cRL/TJOgb19WFvu4sT2SCSgjDjn6/f+WB6qfxGgMd7FSVIN9cnqsy2nTQJ5ufpGG1ry+
 eFDLQk1s1jwK3IdiZLZw8IeuIljxg9ounnRtmDTZ7Xv43WNQB4GPYF46bJUn1I2+8NjIxijR28N
 eftKHKQtyk6S0fSooq07X+Diy5hfPmo8j6PyxneoWuTE0b7AygLzI+/HXRUGQnxRaUyyoApY3w/
 J5Ox6MGrgjjYDNmnX6fNc+hjj8cshkGnXuq0jMZTF2KpaWnOxgGkd8dSi9jyY/TDm0vXxUBvozU
 EOY2iRGcdXhrHDrCGbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050213
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37445-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:loic.poulain@oss.qualcomm.com,m:johannes@sipsolutions.net,m:wcn36xx@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 550CE64B784

On 4/21/2026 6:50 AM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The firmware-controlled rsp->count field is used as the loop bound for
> indexing into the flexible rsp->regs[] array without validation against
> the message length. A count exceeding the actual data causes out-of-
> bounds reads from the heap-allocated message buffer.
> 
> Add a check that count fits within the received message.
> 
> Fixes: 43efa3c0f241 ("wcn36xx: Implement print_reg indication")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Propagating from v2 so that b4 will pick it up...

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


