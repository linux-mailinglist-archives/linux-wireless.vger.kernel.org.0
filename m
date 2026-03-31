Return-Path: <linux-wireless+bounces-34211-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO+TM4Tay2k2MAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34211-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:30:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F91D36AFB5
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46CDE300CBDE
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF293DE424;
	Tue, 31 Mar 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cS/61qha";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TH7ddWZz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BFB375ABD
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967018; cv=none; b=WktJArmFL8TDDeo5k6tELjx8TstoyyApecpkYPSlSF/PbYxeb/AdtPGWdJN2Go27uHUf16Q9d69oiw2xtlPqQV76k+8qtZvKdMGCgN3fSVF9DANn21/1aNEplgH3azpgbb/MUANrVGQk5U5J3NQqswl98DIF+LJRbmapbfaJ7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967018; c=relaxed/simple;
	bh=KpnDzCGoxSMFjiulsyeuRWkhHv9HD5upRYyXs87ckes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2nYDXoedAWZErD528LDEKEh28YtUTZ8EE4kId9+UYz8fUhyCjWHsXQFLpu3aAW3Vx4zQKELJYL9MQQ20vDJRFJhpEPcvcVFE1rnUklrdpJJoPO0sWJqVSUwo+0XhLgOYhDTQ3y3Ivjai0daUvAGkQbjI4mjiSZr6DRWQKF3QCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cS/61qha; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TH7ddWZz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VCvWYf1306323
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	duNzVU+fWIW2eMrS9MZLuIgJmindhQKIlaRaLKEtYgw=; b=cS/61qhahBpznw2w
	0QHmxgVs99T5WU2CuzhFGCrnNcNvaS7cT7So0ybDqiStJ6ilogttCY780kzWCN7l
	30AxAHT0nSbZlf9VI1MZM83tg7BqPr4/gU6GB4xUq1b9KKCvqYdKR+pbzbCdg3sA
	yFlmfdPGzkA5el7lKvIsGXEeASWCeie/PNGtKiBtMEjWd+WQng9QdPl19+uh9q7t
	IQZr77MbHtssTUfi9fqkis9Uywiy3Hm2MS6561J2gt/YGNGHrBdFyvs3J9BoWJ4G
	0fz0Zft9J0dTkn8t6dsY+G9W7LZ2bGuteb+AnatJiOBb3A2Guo1lkFn1J6ZGlgNh
	krV5tA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8equ8gs6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:23:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c7130f88e3so13948451eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774967016; x=1775571816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=duNzVU+fWIW2eMrS9MZLuIgJmindhQKIlaRaLKEtYgw=;
        b=TH7ddWZzZmfM1gJF5llXg7yO2YZH31bsviQOc3aodO+PWkfKQR2HL/EUMUJptMK4B7
         /BDqj0Ty1sAxVVrSoZ3XUHBrg+FsAi03tuEx+VP9KIuL5kpYJ6bhWvOTnvRGxJ7X+mhB
         JRETPvRElE6OB2ktzkgT+Yq5nzYeW8HNClV+CswfOnAYgn3VM3skzBHRrVKjbJfKI8AM
         6qKd8daNin9TzYZq8pSP4fS+kH20wBRHwrMp9g2EBsPdXTqfOwj8av7TouhfcCQV7H4s
         nPAbv/FV8W2MEx2GTQ1eeXkK8JnhWlM0dGOIVSyMH8v69fubAvL/goE7cCCmDAfl0Sb1
         lwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967016; x=1775571816;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duNzVU+fWIW2eMrS9MZLuIgJmindhQKIlaRaLKEtYgw=;
        b=I7ybV2DBxf6sIIlYzWXQHG7r1prxxMKHfc0rmXdEb3K5ZF4bg7HEjAEpb0kRZ52vB/
         h8eT41DF2Qm1PQpu6C1DHC+VMztWnyDTNGouJD93FwiAa8SMd9PWKAgOPy1clLkKP30d
         brV5B75keHSmEoGdOXu8Vy+c9tggUNIkCxMNhPaagTQdELCHGyhhIXtBlpvfxjKa/oOk
         jjr5wZQCxABFpzjCJOtA+bE1cVH3oe01jXRaFS1BNebnmDqR2LDknEFK94pIqZmbjDLV
         GWGzrAmrxJQGnXsFOlHQdjDT/OzI8tfcFHzRNq11FBBQ1dm0ScWVBfTpMjsYBeuX64fS
         T21g==
X-Forwarded-Encrypted: i=1; AJvYcCVXGAMz9GKHzkMw6Kdxc3TjbZOUC3IXfBkM4ME8LSt37qzjk+buh3jQHnGVnOjXy0gYa7/lgJjN3pwZqWS3sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsoXZrqOESyHccfXTIb21NjyVgtASmNB4SWoIDgfhvC72pVh6p
	9b7ULbSQQxZ5lWdfnuBApUwhRhWGwuSJC6/T/61TCiHivpdECxNT8G5QSNm4ii0knQqEMszef24
	tavvMJlazJxpeBUVtSVZ6ZUQbO5lBTc1WG6r825BkOGltoRueTMS+F8zHMBl2H4n+n6Jhhw==
X-Gm-Gg: ATEYQzxPU3h/Iov3arQA7zZ38dzm8XEICK8xsWKlp5gwquJy9sP6J+A4I6hdYtsOT1W
	5Uu8z/aNpZlq3epkJgAivjU4CK5kY5P63ollgj0AVoqtihm3ZyaViv3OQH7XdOlABeB3xwULKSJ
	g/EP3rl7D1q2MPCe+gYdLWCojVnbCw4P7vHA9J6oj6fsZNDXuCpassz91+l1MDEtfbs5wNVMUMS
	yrDTOi/LnlKcVvQ0fYQCcsAe719jexbAjQA4P5IC/R/cgYbwYtc9aQYph9YoWpPCFb/ifd7J/hR
	DvRbCWSOhfZAW46tbFvNxVQ7aH1IjtJrTmdSKNeXoM72/+Iz/scpLb5Z3pUFpt80mUHTFcNDh8V
	gOhMOUUNHzN3yerepuih65zxhVLQeolCZqtYOEisj/1PF5o7WzWfgiiFfF6XJjjmmTqeBNVA5Qa
	KdRO4Fhw==
X-Received: by 2002:a05:7022:6884:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-12ab291304amr10304084c88.26.1774967015762;
        Tue, 31 Mar 2026 07:23:35 -0700 (PDT)
X-Received: by 2002:a05:7022:6884:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-12ab291304amr10304043c88.26.1774967015009;
        Tue, 31 Mar 2026 07:23:35 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b399bsm9941111eec.17.2026.03.31.07.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 07:23:34 -0700 (PDT)
Message-ID: <b1194bdb-75fa-4f2e-b4a3-9565b11bb3e9@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 07:23:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3 1/6] dt-bindings: net: wireless: add ath12k
 wifi device IPQ5424
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org
References: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
 <20260331-ath12k-ipq5424-v3-1-1455b9cae29c@oss.qualcomm.com>
 <20260331-fanatic-elegant-wallaby-913e35@quoll>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260331-fanatic-elegant-wallaby-913e35@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzOSBTYWx0ZWRfX5AfWkOqbwZTL
 wcMG3vNbdgtYDm/PB7oCgAnrk0wwfAlMt1NDvZnUFt4eoxZhjewCvJz7ea5lmHLbDPweqnN6XN0
 oatz2WTp73wTGWEcO/uyBaCPeGumS3De6WKsTD1+AgeE6peRXBcEh6qDSdksFkpdBfzl967eRBW
 0Th3C5gWr9Pd0P9XF6N+ix5XqPjpcxb6P8FqlaIb5M4PpWmHs2MP+H6nPq2qyMi/OYbvEsp9uRL
 EZghIzAf957/HxoJz+gT0dwqiDx8Pm7diLTw5V6oM7TrCS9HPsEZClQEyJp2bmEKyxNDGeF9N3j
 TsruyycdR8wEwh2pC5hk39XE+eQmboddAJHtwteOuKmCw6+ppvhV6eDvODReIuwAXQL+9atcpuI
 95k+tUV22gExSoGBoq3zByHDGoeYWTJMnsqGzID8jwX0c0jblBcwAprbF0ggXC9LM0WI3KDVESZ
 PKAu/4LLdx+jXLoScWw==
X-Proofpoint-GUID: v0tr2asgFSo0-IDDI-AN5mRdLZAb9LeQ
X-Proofpoint-ORIG-GUID: v0tr2asgFSo0-IDDI-AN5mRdLZAb9LeQ
X-Authority-Analysis: v=2.4 cv=YMOSCBGx c=1 sm=1 tr=0 ts=69cbd8e8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=fnTOxYT96DSTlMw0mmMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310139
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34211-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5F91D36AFB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/2026 12:24 AM, Krzysztof Kozlowski wrote:
> On Tue, Mar 31, 2026 at 02:09:06AM +0530, Raj Kumar Bhagat wrote:
>>  $id: http://devicetree.org/schemas/net/wireless/qcom,ipq5332-wifi.yaml#
>> @@ -17,6 +17,7 @@ properties:
>>    compatible:
>>      enum:
>>        - qcom,ipq5332-wifi
>> +      - qcom,ipq5424-wifi
> 
> No, use previous patch.
> 
> I am annoyed that you keep making changes even for such trivialities and
> require re-review from the community.  Previous patch was correct. This
> one doing whatever you want to do in copyrights is too much. You don't
> change copyrights just because you wrote one device model.

Krzysztof,

FYI here is the guidance I received from Qualcomm legal (links to internal
documentation, removed -- I've forwarded the entire e-mail to your Qualcomm
mailbox):

... Repos under copyleft license [...] QTI copyright must be added when we
make significant changes.

... Repos under friendly license (BSD, Apache, MIT, ...) [...] QTI copyright
must be added for any changes, not just significant ones.

... under the regular QUIC to QTI open-source copyright transitioning [...]
all QUIC Copyright instances should be replaced with year-less QTI OSS Copyright.

I'll follow up with them on this case where there is a dual-license file.

/jeff

