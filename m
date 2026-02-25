Return-Path: <linux-wireless+bounces-32186-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHBbMDNnn2lRagQAu9opvQ
	(envelope-from <linux-wireless+bounces-32186-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 22:18:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B819DC38
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 22:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D10BC300C586
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 21:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968B2D5923;
	Wed, 25 Feb 2026 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKXScArS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="knCw/Hr/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593D2ED141
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054321; cv=none; b=iVkqGYjSpXtliL/n0DjptUqXfuQZXuBThjXqMQ2AnYwuUk+Wzt4sstqL3/UEfN5wnezVJun/Z3mk+39Puh/HLi1aCVaHHCYmRDoI0+7wDyzo5qIUkdrgkY4+9++uSIgnnkit16T9hlcIYw9Z+KLUS0xFztupws3V21XYL5GWfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054321; c=relaxed/simple;
	bh=eetd5QaChwQkV7OMMbUmc7jBc20x2aQp1QJ78jBLpb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PmJezSTUIjf4yeJvXd3ZPpmECl7Ihb+39CAK+8BStufZZUunl5B5AP87sZaRvDktrda1cZbcsox7aq47C1Ark4wxzUz1nMxUDhuGcuqCXPJ2idrwfGSQ2RYHa1SFZX22XR5o9DcRrIKN9wMm+gSy0ICfvAHUcaG8rSrWLtSxjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FKXScArS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=knCw/Hr/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PHIuSw806692
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 21:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7T5zLDhagcCAIRI9pi3rmzKQNKs3Uon4PgNL/C0CxKY=; b=FKXScArSQxI/tTTm
	pbK3lBTpN0c2GyZoA617mpK1xQa8/UFZ9FSd0wmO9HaVht6SQKZLuO9m72J1qTtF
	sApLUB+DeGdR2HLfP3cVgw7lmBm0IX3ykLj5pjsegqgQnxOmGyedmkvtZxOBVJkB
	KrMBoVUEsWW0hJAfm0fF5jFG1lYz2N/HeI90rxswWL6N6XTATQ8nvrv6vWcT/lS/
	TaLroIE/m2fI7g6+dhnPRr41FnZT1lMNKfLQAa95nK7iElXbVMdRhDgSS5Y3aX/H
	EyFY5s4cdbj1Ap7BAKOOVTeA+RYFPG/6npeaDDgkf7QkA6eWNonz6S2Av1903EX8
	aYvOcw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chr5pb833-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 21:18:38 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4beca8c53so174289a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 13:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772054318; x=1772659118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7T5zLDhagcCAIRI9pi3rmzKQNKs3Uon4PgNL/C0CxKY=;
        b=knCw/Hr/RuewW5illa9h3T3B1+NEGc5EYHcH2JXjjDeZlrSNI8WBkUQeVwQLV1HDvz
         9aBPCDmGkSMrDoVhwBtjRR7XbDLDEByoBsm1RwPDoJKND5O1y7bKyrm3rElPVQG9GK4L
         Sy/sz0ZnNM1XQZ1hISvpH+YC9xzqrcrcMiCgGOZns+/ii/NbRkiVzlFyP4zzJwDRe8u6
         jAKVYehYF9z2uJrYeaHlEkREJpkLXBLg9osNJV7Nd+0T2YCaEw0eOunsMZaCBPC4nlhV
         lLfOGWtFb6MMKIfT8iULuhd0iclVOVuFXHjy/4gBaq647nNJ4tBMeVKbJ+roLCDUqD5i
         +sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772054318; x=1772659118;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7T5zLDhagcCAIRI9pi3rmzKQNKs3Uon4PgNL/C0CxKY=;
        b=LHOZaPBmKDUStNpMSSKEAhqi6S4JTYP9X6JL3yojupnm+Z6uNYmMmQ6w5+FuG+aSep
         F4qwl96sX6o70wKQXJIF+RYr0n9SdPL7VQp8UVCS7R49qGAVAneN3X2kQ0BFX26rIc+w
         nBXFWyluT02vI7FzzrpEe7nVyvSubIadw8qaqPTioD0f+iHmO9rwNI+dklLeSsCDO/J7
         Q8VicbSyWYe3XpH5TBhvGT4NtgM7EjKV1Bv2BrOjmWvBaGRWBkRUnQagCg5gIz68jRZh
         kpPBBKVtB2zCj8qf3G7QpnxKItPhBoNskUHLWaGe/G5pD+cZ2dRdSb7jgAm3r+3IMkan
         5HyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTmU1XN0MUGeW27mlfTTxQ5GbYJfloObHaSgsgkAQy8UB4VmvpS3ubSyK0eaOxWR3B9pPMVCwe6sVaKJ5L2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVWKe6u6k5Z1oDlmNqycEw50M06Km6XFVT4iKyfbW0lSo8gwt
	do90qbHYSKazsuvFQG7scrPgkjxcN9QhpN6N5I2yQ0+Cp7qQJh7rxLDEMobYxYxxjaJBT0Z42u+
	DBWOd/cIXxdxykg9ie46l9WGvGsSAF+HIKnF7McLNsVhBfJpefgSxJ6DMCnyPQ2Y/WFQ61g==
X-Gm-Gg: ATEYQzyoL6VdNDJTnLg+Wgcv5s2Ktr8eb8ljIII857HmCDeOPl1xsSzIVFSFMNb3Tny
	0oong0Y4moGjafJmKXejOdgZJOlHw7AXLa3xWRVkDGhSSosWuzdfsPJaPW8AHDx6Um5FgJ2s5mH
	nOc1k5R24HksHHr5nEkKIj0Z/H/05YLHfdvgvsJOf+Dy3ydPyXE+eu3n9uWxw5t0zezNekoOPho
	tUiUaq1QOC3UmoMxI++WcLzjbIjFHTUgEcP4sddUQDksntXfvo1YBZLeZwMWYxE2UQakjXA/Tfw
	xLQunLjkkzRdzSxoHkhyX+z3KNoYAEuz99sEyRvO+f6LtoU0tKRM0z86GZO2xFSKtRF9S9LZUOY
	VRWoGz1jQXsyAgHkVCwwhit7L7G5ljmUCzgThD+/JXPytIe+0Ge+PHovhy3NiUQR923PjFc/WD+
	mRqQcu05SemGs2gA==
X-Received: by 2002:a05:6830:6210:b0:7d0:2e9e:396a with SMTP id 46e09a7af769-7d52bf1dc60mr11123226a34.22.1772054318141;
        Wed, 25 Feb 2026 13:18:38 -0800 (PST)
X-Received: by 2002:a05:6830:6210:b0:7d0:2e9e:396a with SMTP id 46e09a7af769-7d52bf1dc60mr11123207a34.22.1772054317756;
        Wed, 25 Feb 2026 13:18:37 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ea95sm80226a34.28.2026.02.25.13.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 13:18:37 -0800 (PST)
Message-ID: <a9caee5b-1698-49ae-bf07-77b417e6ff4d@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 13:18:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: move action code from per-type frame structs
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20260225175252.03c5c338a7b2.I9a24328e3ffcaae179466a935f1c3345029f9961@changeid>
 <4957d35e090d54f098d27f937da70770bc001397.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4957d35e090d54f098d27f937da70770bc001397.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIwMyBTYWx0ZWRfX6Ka8BCwBBDLw
 fS0SYd9asdD7Sq2E4oTt146MsGq0dfY1zq9T7BlK3OTgSKLzVKNojc2UAqo8Ltx2QUds2jVyNJY
 P8CSvPj8Iaxb+DRx30whUvjeaIfq2RUS65vQpHvDJ+p2lcogQVO2oSo6LZkLT9BUM4nndt6WqBP
 TjlMGfHkjxljKHelGBnof4vhabPsli2d7zHicTksVY4SR9o1tN88LEr/O5v51dwe2kjG8Pop1EA
 oajn/H7GV1NBZ4LWaM9TU4HOxO5IB13THEyXKmNzTSV8dAhlgbXs7PW/9nR3wmtNZdG7pDpgzzd
 HUJ5Wpn2Zxb46D27fnAHjqQ0dYdFExxo0idkgejEvx7J6k6eM6xuoDvcId6tzWD38QrpFZatslF
 hda3m/AGN8ieJrIBILX+2Qwqx5mQAoPMy1FaACvfkD2Y/ROp1fexLTU9OoWM2NNMqGKuKQU5A4L
 9BYk9mjL4F2RmIbd6tw==
X-Authority-Analysis: v=2.4 cv=GstPO01C c=1 sm=1 tr=0 ts=699f672e cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=IS_9aP8DG8Gw98Xe_50A:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: yXd7slgcJZ9QHi51hBsMXWXj2NnoIuQX
X-Proofpoint-ORIG-GUID: yXd7slgcJZ9QHi51hBsMXWXj2NnoIuQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250203
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32186-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A8B819DC38
X-Rspamd-Action: no action

On 2/25/2026 9:08 AM, Johannes Berg wrote:
> 
> And a couple of other notes:
> 
>>  				struct{
>> -					u8 action_code;
>> +					u8 no_fixed_fields[0];
>>  					u8 variable[];
>>  				} __packed chan_switch;
> 
> This thing in a couple of places isn't ideal, but I think it doesn't
> outweigh the benefits of this structural approach.

My fear is that "helpful" members of the community will refer to the
following, believing this is an old style variable array definition:

https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

So I personally feel that a /* no fixed fields */ comment would provide the
same benefit without bringing unwanted noise (unless the code just doesn't
build without the member being present).

But you're the boss :)

/jeff


