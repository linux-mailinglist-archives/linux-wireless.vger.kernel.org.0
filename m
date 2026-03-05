Return-Path: <linux-wireless+bounces-32544-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDS3DMyiqWl5BQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32544-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:35:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54E2149F0
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA3E300BC9B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A43815C3;
	Thu,  5 Mar 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KIm6YOY6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H+L2MxLn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11993845BF
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724890; cv=none; b=PPbEqa8mtRALQ+VsV2o/myYukE/gi6dVpmoZEPWBUcfuI22QkUIQS79kVsEEytePrrkvxwuhmcW1/87DxbbwIYIf6OxMSGBZww6TJ2ZgkhiY9jdHg7TQCC+BmxBf0JfIl7H54hU18B3rdC96QulCLkmwq++9E/S+Wu3RjxsT/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724890; c=relaxed/simple;
	bh=rboQOZBucpU0VJlAaJ/ZK3Xc+1IIPTmbKaD+bWIab/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jO4lHPTy9j5RMwEqilx/q/tBN6ZLXakxOvkBhbF6/N510tTsDGZUZ4p1UnhlbHZGlVbgpQPh14E9Y4Oyvc4Uu3ehFKg59911WBUdv6sSw6JClImBcm9hNXbj0XbgVCdU94AOtuFzbc5UQNqwH/2VUODez6rAtKZzX7PLxrCIt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KIm6YOY6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H+L2MxLn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AVKia2399260
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 15:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eok6K6av3Ttk9ELdX00DspVCZeEb6nDyTOtHK8ISqDU=; b=KIm6YOY61FSguIGc
	Ti8qM7JSKDcETXrnQGdJqzjz9e2CScrlz3269/ANwoOmK7+wZYNpOZOF/Bk/1xZB
	RR5iS6wQDR0MoAJNWYgvcNvtXx3FuHL8Kqe9hYnTRSeBRapxyG3jB1qRR4mL/x9Y
	OsRkemhNHmRuWnoK34ido7olWgOEuGmVueeQXIzkaiForfu18WUw5zDCEx7NPzy9
	BsjEIkAJs89j6kpGWOf0kYe1iBvSflUkyf+tmqbMVkBcs6HReIi9ZarXH9y56b6v
	pQg+nBbhFyosTF6lDtxin4c9Qfq6s+EUPD54P7HRy+wcquXj5a8HSYb7Xiw/t24U
	TCkZMg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq85dgw9k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 15:34:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adc527eaf5so45443585ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 07:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772724887; x=1773329687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eok6K6av3Ttk9ELdX00DspVCZeEb6nDyTOtHK8ISqDU=;
        b=H+L2MxLnrrbv1KvOrQEo7uLzGcczc7xFwY1eufocXLrikHh/Va5BcFfxj7Ona/hHnS
         6Fc6D/DarOmj9WcwnPCf7O7yjTtRzCHVzr/mtCr4AsfOdq5TmOhPE6eudaPufzdtFhHr
         WJlXxDsZWnKqqxOcxJKuunZskwd3+oInwSfEKj1bJymFLaNZ5cI0m/RWYdYb3eIG7yax
         iC5wwUUdPZjjP3Z6F/AvOGovHfFghoSEeNXTKCjhEf9uUKa1hFDHnZq6xQ3w12+TcqAD
         F54JW05Clun5lXZuU7RiSDeF7XOtH2d30q74sOIyFJ/DDVeXUgftSNAkk4Yyk9mQa3mi
         kuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772724887; x=1773329687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eok6K6av3Ttk9ELdX00DspVCZeEb6nDyTOtHK8ISqDU=;
        b=TIhLqTgPrN2gjs9wLIEGXR+IFFi1RqzeVdN4z5gRU+CsNSXRJFR1pfMoeDf8R45513
         Ev1klin5kXVS73wRI+BXhUkBXaGnPBhY5h7ugJ9ltABInCT/QQ/9wFsKi8MUhNCHIXbq
         tkEhVA1gPFZMtb3sRDAJQS4qhHp4XuhUNZODSZpQ+JdU9/mmVDi4dMsOpCiXYPpn1L9y
         FRLN22cdITYx3KHW9UJpSQTnWQaacufI+a8rHG4soxkP8HQi88fe++bKaC8CjDwWvOtQ
         6BU2BVPR2HkVvq7p4gtZaAY99Lbq1Foss9JX9iu8qCUor0QEOYijypHsMo6UwXoqe6e8
         moAQ==
X-Gm-Message-State: AOJu0YzO7VSRz0QCsfDsQyOpoaMtXicpAl+mtDzWieF+dNIj9+NiScuk
	3KRu43tZqgea5DQBDg9VdebuXiMHpQkKfLObsJ8+bG1YZSMzfvnowgAO4pmPSYKTBzutT+jKvxX
	b+UCITAVynqT+G1u8OFp4HhgJjbCoSC9cm5WW+gqxSxypYLiRKddalyWP1CU9rWGn1oIT9GA/nh
	VB
X-Gm-Gg: ATEYQzznX8rm/0hJzA4dGHPLpntyz+xdaQ9oylPs7M75I4he+m4AK9gftZClhfPS/z+
	V442mSG9I2F7WxoKu0YFKXiVnkVqsU4asLrNtDS8XuTz202L/1b1iJPWqzKxHRY3g6pFTr4Tmtk
	tHZSCEozx1u2PvQCfcPxZz14ScGZHi6enFcjMzUgavajEji+Ewap4JJR3BuSLpLl3jiARDR8JvB
	yHtSrK8iTwmhD2dlvEn4q0Ta1pDsqIVTAjywGHLTfG6flcjes/GedWFS4TChwiXMqqMuPnSDxZj
	D9Rm39TQizdtAzWE6qzUqoL166im003CIHroVnW7IA7Y2ePP9ghh0FxiiwhX1fKBfWiggRqu+UL
	qJSHFYqWIAI61WPqz2dpKusdbh7j24xYgg1C+SeKLe4wbvgDJktdn
X-Received: by 2002:a17:903:198b:b0:2a9:622e:fd3e with SMTP id d9443c01a7336-2ae8012e62dmr1061775ad.4.1772724887190;
        Thu, 05 Mar 2026 07:34:47 -0800 (PST)
X-Received: by 2002:a17:903:198b:b0:2a9:622e:fd3e with SMTP id d9443c01a7336-2ae8012e62dmr1061535ad.4.1772724886704;
        Thu, 05 Mar 2026 07:34:46 -0800 (PST)
Received: from [10.206.98.136] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f277sm305139845ad.55.2026.03.05.07.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 07:34:46 -0800 (PST)
Message-ID: <a2d7593f-c6cf-4960-b36e-71134656bd06@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 21:04:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 06/16] wifi: cfg80211: add proximity
 detection capabilities to PMSR
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
 <20260304071538.3833062-7-peddolla.reddy@oss.qualcomm.com>
 <f30b49f1dca7c9529bbcf6fdad72bf8ca2c0b0c3.camel@sipsolutions.net>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <f30b49f1dca7c9529bbcf6fdad72bf8ca2c0b0c3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QXi1qveubqQvug05mXl0zRp9dg2FWrm7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyNSBTYWx0ZWRfX6qN78I0FxDL3
 M7AFv+I7cXkbdaMNpsWKf+agEEq2jKBQLmBD0EF4phMRZHIoCZdzHyrESKgsIo9ecT+y62e6X6p
 ayv+ISvrppk/pee9xRsdRxrXqV4uDldTvLxE43cLyHHjMBdVODba+aBv8yPhDghSUcNKC/xuEgb
 FLQejgkGaJSck3HJlc2/P4HMFhICbrwMCF3PVPYRI3FRTOV8M1D8qGEIi/ixyDZs9EJOhKUqQpA
 rdZhh0U3aZmvaPTShP2CW1KEbVEJRRtWO4PnvhYjPAco7omcgBr9g8xD+Pxtgx4a1N0TbwVWHHU
 l6YHMi2CS2b+d5Iq4CrN9qQmH6lLRluWxPn+TekgvMcjbA/08xP3Y7u4EkfAtIyo1nOl8+qX4tp
 +pDLTsP2V2+TwtReoHNAVpmgk2EIRo1Rtc95Q0NI5D2jAbS7++s7eNVsIFFokseeHagr/mocXZO
 upQzdWfEvjMM36kjTCQ==
X-Authority-Analysis: v=2.4 cv=aOb9aL9m c=1 sm=1 tr=0 ts=69a9a298 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=DjivCYocDyhZXhbMh9kA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: QXi1qveubqQvug05mXl0zRp9dg2FWrm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603050125
X-Rspamd-Queue-Id: 8A54E2149F0
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32544-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 04-Mar-26 5:20 PM, Johannes Berg wrote:
> On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
>> +++ b/net/wireless/nl80211.c
>> @@ -404,6 +404,10 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
>>  	[NL80211_PMSR_ATTR_TYPE_CAPA] = { .type = NLA_REJECT },
>>  	[NL80211_PMSR_ATTR_PEERS] =
>>  		NLA_POLICY_NESTED_ARRAY(nl80211_pmsr_peer_attr_policy),
>> +	[NL80211_PMSR_ATTR_PD_SUPPORT] = { .type = NLA_REJECT },
>> +	[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT] = {
>> +		.type = NLA_REJECT
>> +	},
>
> Probably should use something like the global policy, with
>          [0] = { .strict_start_type = NL80211_PMSR_ATTR_PD_SUPPORT },
>
> instead of listing them? That way, unlisted ones become reject
> automatically, I think. It's been a while ...
>
> johannes

Sure, will follow this format. Thanks.


