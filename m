Return-Path: <linux-wireless+bounces-32547-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG65FfaoqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32547-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:01:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0899D215126
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA8D130C4B77
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C6F3BA23C;
	Thu,  5 Mar 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBwDU7Kc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BTHVRrh1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502EA3C196C
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725364; cv=none; b=NluAln/ygYAUXt549+3IUN42y46ChzGz6KIQk/AfTwfnyUnxeTl4CK4Xu8fspFa+1KswJgFfjj7sSspqBww3jeTn2rQ6pQLPO1N/3xc4Wu3Lauf97NfS03e4La6zmotl0LUk9ScUb2um11au5k2mIdBPgU/mOmFnyPzSKFG4Ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725364; c=relaxed/simple;
	bh=dzzwm19beGLhfRMrQZHZ8tJUUUOObwZhlHeK/pFzySc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6gQmG4krLemN32N6OklVF32v1w1Rf1zaFGbaKcHkJvOOrA9bLm+JQi9paY6PjUSjE6l+tM61YbVHBrL7JjvxIdhUm7OxZabAOTxec6304OGLeTOt+Q9FnkQL4X6Ozse6+sUtIVLv6KBwramY/y/PZ+x3eSQXnN6xRD53RAh5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GBwDU7Kc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BTHVRrh1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFp4X1517938
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 15:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dzzwm19beGLhfRMrQZHZ8tJUUUOObwZhlHeK/pFzySc=; b=GBwDU7Kc7eCJhuLF
	NFyv49H6gxH/bYYEC38zNyqcYVLtNDDkwJlgRj+yjBTaocXwNqENl56GbAy88+eY
	QjODJ+kNg0CoUgCqw8S/Ee+0HXuDj60Iw+mi2pVgKv3dp2gwbb4IYYUO5gD1jLBw
	u1/OvhmxSQqU1BLkvOhZ0UEHDISNAIf65+8O9gnSYKJCXbk+2VTSKDmJa04FHSDW
	CA1DOE66VnpA2gF2pAPB6UVqoAFJVdIfnA2UcvUuWcYIWNQ0fifUJIieNUJAtdz8
	+KLmfk9eAmadDSJST8meMyCiz3YP1gfLcH1Pl16z/aaVEAWOD1Z+PUS1YJM0uEi1
	PTRM5w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuptkbjj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 15:42:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae3e462daeso26343785ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772725362; x=1773330162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzzwm19beGLhfRMrQZHZ8tJUUUOObwZhlHeK/pFzySc=;
        b=BTHVRrh1B0miQnXTx/PAQpow4OZvzJmCDTxxj3e6nuXBI5UJc2Nljkj2wSjVl9PK/7
         zpmDhQzrAUB4h0/EvfOTHQukmHS3Pxbk3A632bu4xeumKXTz+n+PGuM6SuqZpttSuX/O
         kjX9lrN6QxyWvEji2+sdgSOKFyiSD5Jj39TAO69rXQBMJ0H5dBwK459h+5lT50zHAa9X
         8tlaPbqBWpzslQbUt4SCDus/ai/0WgWEEp57bvht8Qtzat+6huothcZwtn2ci4NIhV7S
         9blQ61y+6oZY+QU9JH3xO/nu8TOkhu1BnMMY1pigwhxqv4Yk+LNSMtR0vuMwj6CP3cNp
         Eung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772725362; x=1773330162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzzwm19beGLhfRMrQZHZ8tJUUUOObwZhlHeK/pFzySc=;
        b=JfNHnDRp2viHmj3E4CaF8fryfJDPWOwOHT0LiGQzvooAAt+BBr5XG8wdXQr7pj1nm5
         gshMnyKZvu22DEchcSg0YpO5v053lssWkm9lTngrNGUt0hY2V8auB7UFHkZf2GBZPu9i
         B9dtq5XVu0aGgknSWLnFYkXkM35nLbpTFW7cIVRi+Ob3gPTKv0MYnQPDa3xKiScJYnv3
         VRw342v1TtRDhbXX2y74zaYZLwfU9mWqqAvrQyK3aFN/s2OHYwqS0Ua3uYnCuVJvvnQe
         pW52sQwK//nP3frVR3Cgiwu3ihXldRX0dMKuq64XV+xeQi0T+pIPlTbvhFPrR3SCJgB4
         QDqA==
X-Gm-Message-State: AOJu0Yz1w7aYIX9F/q1Eml9J9rXsyH4NQLoLdv7ET8yETxvFJZNCKWWR
	bnZeHknGj3BxrC1Sh1ocmZzfVfj/pm6WevOY32CEj7rxjlieWRqL8mBEZv1SDWT2cRe6VGboNdk
	kYo+HTtOpuS19RTxc2thmbjeDHZm2/OI0Spf/GhtgsQ2SRm0/H018F5LvF/XVw7WgoCN3UEFvB2
	G5
X-Gm-Gg: ATEYQzzYAcNGrklKEcVPbPaFnIb/2V8jiRFJtHmRpV4jmRUU8yHqlJB+beukgqRi5kn
	Qtq76il3JqQz1Z2ytv5T+P7Kfhgw4a6HveQjJx8izLiAX+8pOZxkWVWy21xHsD0WYaAd+clroHs
	y2A+hvmutJT5f4dQQnHvCNLDMWqXk87Srubk/L9UtjgY9/RfQDsgHUMvo6e82653Z8hu/FyUsC4
	4fOF5zmVJ/UErrnKeHe0ifuBFvLFB0jmYwUNXClBxAoFp8cI1ilsZ80pd9CoeHTJWykllyDzlzo
	K/OnOqaX6JASVtTbCGlfhlp1Y2QDwJWbzO/BnF+SCCpvst4V0ZgN2Z1AysfyiQtrbRxcg43I+Ie
	1D4WceFiKxkMuKuRlwJofcOOzr5JUOkDYJx5KqZ6jo0jQmQQcsc2X
X-Received: by 2002:a17:902:f68a:b0:2a7:d42f:7065 with SMTP id d9443c01a7336-2ae6aab139emr62298605ad.27.1772725361716;
        Thu, 05 Mar 2026 07:42:41 -0800 (PST)
X-Received: by 2002:a17:902:f68a:b0:2a7:d42f:7065 with SMTP id d9443c01a7336-2ae6aab139emr62298295ad.27.1772725361147;
        Thu, 05 Mar 2026 07:42:41 -0800 (PST)
Received: from [10.206.98.136] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d19559csm157429885ad.5.2026.03.05.07.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 07:42:40 -0800 (PST)
Message-ID: <0d395b07-c287-4c5f-9b81-1e0327d52983@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 21:12:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 14/16] wifi: cfg80211: add MAC
 randomization support for PD requests
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
 <20260304071538.3833062-15-peddolla.reddy@oss.qualcomm.com>
 <6800d54f38355fe2df248dab3da40dba4f892643.camel@sipsolutions.net>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <6800d54f38355fe2df248dab3da40dba4f892643.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyNSBTYWx0ZWRfX9euBq+jTdc6q
 eU/VSJXYD9Q2GFP3W2a78Qo+8piITQies/HEpdRDGrSIGaUJdoqah3YJvTbBVeXub4vJ1OJJ9hk
 HWsIVuCfVFV/IZOImuGNf4C37TLmjrlXcc1ohZofpetLgfMUKgO/PLMDUOYQfQ8iX68nORLC0Y9
 ol0jHoGXu/SGwU+/Ati1/MSIh+xoeMm18GXycLBB3eyfuu3aI6cAhD/f7cfm7PZ144OmKRWInrw
 rf4iZxzsdpZOVNR2/9qwPuZa44XMzX8Cq4PoYtzAkyQVF0lFssrh9Ajk+Au2Ks4XthfVg+mJabB
 NcOVYiRz/EYA8AaKuYXGCCnh96u1gw5rlkCbn8COrWy7bk1KUCU10WFmwPgTeqUkk4L2mgdOdm4
 ByYrILtKUSLGU6+XndxKx5RcFnR0CnaKuZilRzvcDvwYIikDObO0iy7V6nWVUDdv/1z0NAY/vnH
 CEqvYVv86wirHgfUpsA==
X-Proofpoint-ORIG-GUID: EaT5f6VbyXvKS6b2hH0UESm3e-f0HGSu
X-Authority-Analysis: v=2.4 cv=Ddsaa/tW c=1 sm=1 tr=0 ts=69a9a472 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=yNKpYDn4_r0tI9ySjcwA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: EaT5f6VbyXvKS6b2hH0UESm3e-f0HGSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050125
X-Rspamd-Queue-Id: 0899D215126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32547-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 04-Mar-26 5:26 PM, Johannes Berg wrote:
> On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
>> Enable MAC address randomization for proximity detection requests to
>> maintain privacy throughout the entire PD session workflow. When
>> enabled, use the same randomized MAC address for discovery,
>> authentication, and ranging measurements, ensuring consistent identity
>> protection across all phases.
>>
>> Add a capability flag for devices to advertise PD MAC randomization
>> support and validate that randomization is only requested when the
>> device supports it. This ensures consistent MAC address usage across
>> all phases of proximity detection while preventing invalid
>> configurations where randomization is requested but not supported by
>> hardware.
> Doesn't this basically also require NL80211_EXT_FEATURE_ROC_ADDR_FILTER
> for the setup? If so, maybe some check (core.c?) should validate that
> you don't have PD MAC randomization without it?
>
> johannes

Will drop this patch as we would be creating a new wdev of PD type with a valid random mac address anyway.


