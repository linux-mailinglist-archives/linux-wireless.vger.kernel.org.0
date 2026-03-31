Return-Path: <linux-wireless+bounces-34220-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MTvHoPwy2m5MgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34220-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:04:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0AB36C519
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B580F313EA7F
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DA64279E7;
	Tue, 31 Mar 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HbOlMG+g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fL1DbZpz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E1421EEC
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971900; cv=none; b=naSW7whVKKnaBo+jC3ewJcUp8T7dNpL3tuRVBO39yas9PHhuSeZc5SE+5fOY4Dgg5bOKn0bs4sxYjvbTjfhzeyf3HosHrQdYjr+K99zO8CXOPtSemvaUg4c0WAmHU9K9MGx0YLlJvPjqvO8f7OkFqsaPjS5mPtvJqaFuv8hLSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971900; c=relaxed/simple;
	bh=zsWxXgcpZkumhChwixLQ08Fep1SFTO6kUnz48gaC8yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ni/m28JDcYv0erCf1/HVPbN0kkGjvjW4ADeK5JXBaS1gbnSyjNq3oJAXfT9l4UANCLCnw5UrE13gJ1aKeSdybANE4LF4jApGCOSYXLxdS0XasDfRlT6YhOWZ7/79CwAo2S4tt63br62QpD+eDuqXT4BcEAh1D7xL9sT8aS+//mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HbOlMG+g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fL1DbZpz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VBupPq2164257
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 15:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hMxnpJ2ojtNB4SMJzye1+MLh767fll1nF+AZ7c5dMu0=; b=HbOlMG+gxXt03AxM
	91Qu+18NcxLUuEcu9ukfrA+u2WB9DYL0OMTvFNtpSmifhbzE74vJSvrXXEw86ZS6
	8UMwDfeJ6QrtnnPESSKWQc494tNO+99j3hR9tFDHH2MeVM8r+Xhunj4DTgQqptpX
	CLSA/zMNHZ7VAySZPVbR9HwSwX5V+MyUvxMP19FbjRT7tS2Mdze8jpbws2TyyEib
	Nk6OqqUYNXqJfDYwmqznrhSUfie+zrxpTMGkaNnUXYCAQzdipAF+MolKocQ5897a
	xYn8ZwYW8rTqk0+AIiALYV330oCLxuaUNYfRHBWk61dzFAX8jZ9nlGVHYyFkOoB3
	NTDMaw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d89ga2bwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 15:44:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c895e7de52so2962866eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774971897; x=1775576697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMxnpJ2ojtNB4SMJzye1+MLh767fll1nF+AZ7c5dMu0=;
        b=fL1DbZpzjL0grxjsdFNnuGauAe5hvA1U2hDA5R0NCNSNVn+iqYNQNJfhtnJosfx1Pm
         yz55iLP/Q1bx+Mo05EUw6Iuudh8O5iNnbaXUGigyNYuVgVCHr2gFqt5Xr5XCRyFVxwzV
         uuNR4TWd5MHJZ9BDxuUdSAuH7fpYgLFarmkBj3gXXNxhAI3BVgJYm+YoCYO/GtMK9OcR
         D4eEx2YiSH7ze0gwQcvxBatTsCClRtNqNXJgiFx44w2hDIplwOILxoNntrfmq/pVXAHa
         10juRXxrzeu7PYVVa+/IkloZ/CCd6s/JMoQxHHyukONs9GWR6G+EPJy0RU34MX4k8epx
         l+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971897; x=1775576697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMxnpJ2ojtNB4SMJzye1+MLh767fll1nF+AZ7c5dMu0=;
        b=TbtDgyZHnYjCTyJ+MwXsRdQyawiKXciCpTet1jyqGDLDTsRM/oGoO+5lm7BJk1nLXv
         uvZ5pMAsNuTFNrUWX2vxsAsMRqhTYpqAWjnBjXNwMAFZBCGlYC1v5CNrGIL8XQslSbO2
         pbLkMZyLOlGClWJAsJw0NyKWuApRFtxgRzDtbkHgSoodtnJRf6ev8NpRTcIkS6nHnm+x
         dAegMMuhcfvZoR2LZIbWldr1pch4NrnZdWf7LfpOZYnimEPd3OHq9fdlR1nwnARVAZv9
         fgeRJrVKBKO+6zlcVQnfnKG21ixxN5qiEhDoPYmvoMHhdoW9L1VkzqQrO4xN1Ur0tGTz
         PgPA==
X-Forwarded-Encrypted: i=1; AJvYcCVHgP0kZcVxjp4248myMIrrhQK0J/jpeh+J2LFg7/B9qZyxW5QVZ7fs2IPxrjj4y03+QRfreE/ScAU8Efbapg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzasqb8nALDOehhFfrtYMkc1QLIsBopZwcK1RwVUSffHYWCy130
	9e/SMuKyi1yCdcw/++9l4+dlSeNywAfc4w0aBeWu6Q3/ZkePcTybUFj/ixWBq24HIHAvcZ5tJHj
	uyfg2g6dTwi27taTKL+ad8/CKWg9179aDcAXPWTvoELlwAhqbJ34xoSoYrQN6mQn1UttLfg==
X-Gm-Gg: ATEYQzzoRz0SRc/Y2XyGM5U61Y9MtTf60tMabY1TQVsOOenkPBpX4YviHSzVkAGCutb
	h3V+CYZ7d0dDFRmTeFgt9fGrpu8nOHwJJNc6rXkCFxI735YHlVgZc75cm9kaLGIvR+28QWSVlVf
	mYAUVPJYEnnIUUSNISg6tTf6bBoiRgJKze3ycfex4tt+4HtSrj1EeXng5nxLZahPXDfiXoepx4l
	zTDEsKJGFiRnQ8gRK2zUKF13D7PI/e7vrkSZ5R/U0jUz/4eQxgm/esN86H+aLWKTdreaIeIFvAZ
	YXWTGK/SQcw6x/Zvo14iX3APAe54E3zjvWMx7nhfDGM5sjmotONFApqswMUjtKkbIo1K0uMgd6e
	XLD35/jgc0sf1/p3xkwPq4yf7+rrswJSq27opNGr6RDCex5GJAS+mwj5D45/YM0KDyI0XrlSlO6
	XVq9RhNA==
X-Received: by 2002:a05:7300:ef82:b0:2c5:ed1b:cb3 with SMTP id 5a478bee46e88-2c5ed1b10d5mr4986310eec.6.1774971897075;
        Tue, 31 Mar 2026 08:44:57 -0700 (PDT)
X-Received: by 2002:a05:7300:ef82:b0:2c5:ed1b:cb3 with SMTP id 5a478bee46e88-2c5ed1b10d5mr4986280eec.6.1774971896516;
        Tue, 31 Mar 2026 08:44:56 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9bd48sm9935249eec.20.2026.03.31.08.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 08:44:55 -0700 (PDT)
Message-ID: <cf1d8b38-a5d0-46c6-8016-b366637d6c72@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 08:44:54 -0700
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
 <b1194bdb-75fa-4f2e-b4a3-9565b11bb3e9@oss.qualcomm.com>
 <0de0574a-04ce-45d0-946d-5fdc1a7b8181@kernel.org>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <0de0574a-04ce-45d0-946d-5fdc1a7b8181@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KJpXzVFo c=1 sm=1 tr=0 ts=69cbebf9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=I2QDpBo2NW-_l7N_WEoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: l2sXnbuL4WR28dWJe6KVWlnO_4Dd1Ski
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1MSBTYWx0ZWRfXwHhv6Z/gEuTC
 Tc+Rl+JFN1ci3l5QXBIRyVRb2ULdNgkT21wRhNct+cLAq27YuvCSji75dcRSbOgIMImTJ50j2fh
 Fcp3FdNGz5HgbvWgykwYKVzU1pXNf8YQUZ6oOX9Siy87bBxixx11tX/1BPg/oYYj9IrAK6ts+wL
 71vmTdw2AiIjMH4Ne8KrEchfnNUnwGOudICynwFWstMeiqtGe5YUOPOqwCjiyfDQGThD2Z4353H
 m+G9OwC03eATP7CVOkocI700nn1ygFYia7sIRM0n/LN3/pEr0iyGm2DE5W+EW4TzsZ+tstWCmOn
 Ci4dhBRohzYVCg+SC3mX6XC1VWic88W7P2f1TPpPEJ3ryr6JGXKXUnzmA4mp/FrHfk2PvRqB86S
 F8otETN6JzRBCBdPBxMWH5cLMIN5l1951IRTzYzAz/rDQTa3y5o33YvJdemAhbLHwcfWjlPbMn8
 7zOSXc7Qq7bqTxIB+nA==
X-Proofpoint-ORIG-GUID: l2sXnbuL4WR28dWJe6KVWlnO_4Dd1Ski
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310151
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,devicetree.org:url,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34220-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0F0AB36C519
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/2026 7:42 AM, Krzysztof Kozlowski wrote:
> On 31/03/2026 16:23, Jeff Johnson wrote:
>> On 3/31/2026 12:24 AM, Krzysztof Kozlowski wrote:
>>> On Tue, Mar 31, 2026 at 02:09:06AM +0530, Raj Kumar Bhagat wrote:
>>>>  $id: http://devicetree.org/schemas/net/wireless/qcom,ipq5332-wifi.yaml#
>>>> @@ -17,6 +17,7 @@ properties:
>>>>    compatible:
>>>>      enum:
>>>>        - qcom,ipq5332-wifi
>>>> +      - qcom,ipq5424-wifi
>>>
>>> No, use previous patch.
>>>
>>> I am annoyed that you keep making changes even for such trivialities and
>>> require re-review from the community.  Previous patch was correct. This
>>> one doing whatever you want to do in copyrights is too much. You don't
>>> change copyrights just because you wrote one device model.
>>
>> Krzysztof,
>>
>> FYI here is the guidance I received from Qualcomm legal (links to internal
>> documentation, removed -- I've forwarded the entire e-mail to your Qualcomm
>> mailbox):
> 
> As I explained already more than once, legal can engage in open source
> discussions directly. I am not going to discuss with them via proxies.
> 
>>
>> ... Repos under copyleft license [...] QTI copyright must be added when we
>> make significant changes.
>>
>> ... Repos under friendly license (BSD, Apache, MIT, ...) [...] QTI copyright
>> must be added for any changes, not just significant ones.
>>
>> ... under the regular QUIC to QTI open-source copyright transitioning [...]
>> all QUIC Copyright instances should be replaced with year-less QTI OSS Copyright.
>>
>> I'll follow up with them on this case where there is a dual-license file.
> 
> You nicely removed the quote where they ask to follow what the upstream
> maintainer asks for. So as one of the maintainers I ask not to change
> it, because it is churn and pointless waste of my time.

Although I feel the latest patch correctly represents Qualcomm legal guidance,
I'm not going to insist upon the copyright change.

/jeff

