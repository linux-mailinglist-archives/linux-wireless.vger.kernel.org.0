Return-Path: <linux-wireless+bounces-31312-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAH2CAsze2lJCQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31312-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:14:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB35AE710
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8747D300D71D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83EC340A69;
	Thu, 29 Jan 2026 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBYlVikO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GYnEFJbo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697D37D124
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681672; cv=none; b=PgG+VQ3v7qNDxQ1G7vBFx7qRTbDb439WGcQm7op/pcNz2yqVZIhHF0ycGFpT/vX17uI0YLzCqsK4Rh5ox9R5oqiK4mICK9JuakGRxCR2XbSR9zGdfLK/49ByONmqB1vT67g2d+oNVIM4QY1NemEu6a/XRwZmjVwjyeNc0uslC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681672; c=relaxed/simple;
	bh=UpCPupWfKFtkl9A50kRxgYqTDfWVr4uibRdZ0r5FaTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNw8GVpvTcLofG84xSjWHlIJV+u1dWx98Eu5Cyit/eJkSkMELsxZOP1u312Z9CLCX6dEd42H+b1ZqdeL02TGDHT2owuoBK/l7Grfint3fyggoqfLN2qvpzSpEjC/r+K/oaQZCeWawCTGseF1DFtQzwt8PiTF60pbDn4NZw7UX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBYlVikO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GYnEFJbo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TA5K7R3144552
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 10:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UpCPupWfKFtkl9A50kRxgYqTDfWVr4uibRdZ0r5FaTo=; b=WBYlVikOfkW/GlGB
	mgJV3MHS3dWoCa52p5FtmD+QORChrtOyt6iGYedcc6gLwZI2arRq5kQKyengyjGH
	28EniGHDFyALGRaABm9OtNnUPBJIhDHBpG7GX8KH2SQGXEK/4Hdg6TnXy+4IWPKB
	RypFhrHi0DY2yaAOiuUKfKLxWOxmyGFXD7kfLBunawoyHNe3e8Uqa3+gPmUzx8d5
	u6MqNURX+Zvv7HOthI41D/EcA7NaFdgp8a5WTjFUh5ELOP2FhPNkgtoRuwM6XQgf
	jE5nHK2io4C424+LIDfMToygAKHobXrH+sObPDIxKmLUGFNg9bHj4Eqz6Yn1vOQm
	kI4zFQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byqpxjk02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 10:14:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a78c094ad6so9540255ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769681669; x=1770286469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpCPupWfKFtkl9A50kRxgYqTDfWVr4uibRdZ0r5FaTo=;
        b=GYnEFJbowTTxX/cb6efa1wbcYM60c7E48sg3MUdf5Rnbj2kJ8qafUlkIV6mTblvNin
         wjrmR0H3U9l4+48YXcU3iYwbK7WRdfFr8yhTUo1lf+GU5hVV0+uQkMhMwNWQCObyEzvB
         QRciCYMam3Xd9uxmZ6w31fn6XkoryjelBaVWKHkEh/uac1WB6QFuNNxw3Po5n9scds47
         xm6ed3jyC9nWjLPKHvVJ9o9linYM2OyJ/qnVwrP7InUo0Aut7jVA5XyYlRMiJFvOm/D7
         zp34QtEBQdBNUofauE3u5Y1yNvnk6hi3gMhJ78Q049ZxMbtj1NwHZmjGQN9jUkxvwe2Y
         XfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681669; x=1770286469;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpCPupWfKFtkl9A50kRxgYqTDfWVr4uibRdZ0r5FaTo=;
        b=vYV2UofO23fZuFj5HiYel5xIci4bGyGyy6r4GcL/DBO9svrydiBTRrBxE9RmXCWovU
         I1PAeGz+BVv9EVgXKH9/Gofi+pHw0i8J0vzeCmRfzCX5/D67Ai83yPIt8QhF1OwMPHsB
         cvjaGo8jFb/03q7RHy/VizxsBUw8wZk/iZwhUu30AeVCOKfrIubyzZeHWzf0doeg/lqF
         SigCAu3tI7NINfoRez4Q5b6FFH7JgUR51VkaVpo7Zx0N6XMGWM+DJUfbksP4BAkGZsQ0
         3I6uXfF+3ENgyVoGRyMOidAMkuIgapdyvksP5XlT4Usn8m3jvGJ0l5pal3zKGYJHJA3a
         zfbw==
X-Gm-Message-State: AOJu0YxD+ft/Fc5hyWX3bmAVyi0qIgNMlTcjhb60yX/2c/olhhUCcMhV
	ldZT/iXYtVOEfFkaHWpCwvW0fOAx5oJsoLmg1ZMUSJ0GuE1/7OVUcQPZAzOvvMpkBskamBa0ktm
	OhWZ8jj2wtqKZa9X4HBhAtSY+zqVD5s5mvJtgoVsOH2XeiMo+V/z4t/pR8Cde0BU8bOPUe85AAM
	s5CQ==
X-Gm-Gg: AZuq6aJlc64+aX6jZSj9aibig/rEsl7h4bVCkVJAfdAqmv9pO008brZt7Ii9SxPgqcI
	KDDy1xvIdOmAJt1MMpQweP+1Pi7jFr6dh8yuo7qQi1sq10ztQQYZRZtrp6Ch5ao+TZhJqA7jVTS
	bFmW5y/mD+a4/uYttrocK36oTeqkgjMgnIn0pPkKyithyGUzKddyuL/+TMEwKBAXdJ/SX/Utvst
	IvwQmB9ak8GxOGaAiAjwM8vLOLTkjqQap9JCcHpQzjGOxEWRf4c4LVW6vShPtYgQdBqq5TLYHpS
	hj/r+0PgM73NLUWBSn94OGso2ZxZxqB+Umu1I8fuKB99VvllnoUvYEllpgxV5IchRTSKC5rgPe7
	QcVm4aA431xsQ4O62EO2229zvidHqVY9yCvGYnCrsj39tIUMvCNnU+THhpv1p5La4FYn9uSnJ1t
	y/ItUwcSGm8kO3yqYv+vMY
X-Received: by 2002:a17:903:1b10:b0:2a0:d05c:7dde with SMTP id d9443c01a7336-2a870dde886mr84958975ad.44.1769681669158;
        Thu, 29 Jan 2026 02:14:29 -0800 (PST)
X-Received: by 2002:a17:903:1b10:b0:2a0:d05c:7dde with SMTP id d9443c01a7336-2a870dde886mr84958695ad.44.1769681668608;
        Thu, 29 Jan 2026 02:14:28 -0800 (PST)
Received: from [10.79.197.176] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c32944sm5287076b3a.57.2026.01.29.02.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:14:28 -0800 (PST)
Message-ID: <6df512ad-272e-4b45-bffe-507b7df4e450@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 15:43:37 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: use wiphy_hrtimer_work for
 CAC timeout
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260128064856.3667270-1-amith.a@oss.qualcomm.com>
 <048f0d8d0686cea35267bff16f824105cfa81936.camel@sipsolutions.net>
From: Amith A <amith.a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <048f0d8d0686cea35267bff16f824105cfa81936.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Wz5vEeu5VLsCdlTjPW6scX3P_CrZIIjv
X-Proofpoint-ORIG-GUID: Wz5vEeu5VLsCdlTjPW6scX3P_CrZIIjv
X-Authority-Analysis: v=2.4 cv=dfSNHHXe c=1 sm=1 tr=0 ts=697b3306 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u0xWyViqGBD8SAJgJUEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA2NiBTYWx0ZWRfXztqbbNrV0gF/
 7C1br+ASjD4bzclRKzR37EgBlq8CGhSzP2PVZzfn7lXSnYQRsyn+P5l3lzgptrJ0mPJMw4xcSSx
 cxnrv3+2BsR+4IJZdme3c5qUqXCscRI7u8cvSHiu/K99OredBgCOQp41gZfCEOSVCK196sxOnP6
 mUX0jDHz5om6CaIZyHv5adOx9iAWy0ZO8fmT6uxXLK5CQsge8i0HysVLm645A+R4j4ajncLgcv5
 6Pf00fsGUHAn6LtIRv3Yp1OW6GfgXSixWxB0vER4A7ePFPlw1aZ9TXUcxx/F+I0cClssdarUG+f
 Rw7RIj15ig48N4+Jq/fsK70mpm2ZuJ4kiyJGhCFkY7AB++mkadhaILbhumQ3LBYPcCDF82bJuHS
 1xQ/GXDGMTzd6TeGRitNDE486ZkLxMtT/rlhdbVE9vgbVvoGGXnWqX5daoHbltBleaWLmHXTKIQ
 pVRnTJ6PlhqlYtmPbpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290066
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31312-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8DB35AE710
X-Rspamd-Action: no action



On 1/29/2026 2:02 PM, Johannes Berg wrote:
> On Wed, 2026-01-28 at 12:18 +0530, Amith A wrote:
>> Prior initiating communication in a DFS channel, there should be a
>> monitoring of RADAR in that channel for a minimum of 600 seconds if it
>> is a Weather RADAR channel and 60 seconds for other DFS channels. This
>> Channel Availability Check(CAC) is currently implemented by scheduling
>> a work item for execution with a delay equal to an appropriate timeout.
>> But this work item is observed to take more delay than specified
>> (4-5 seconds in regular DFS channels and 25-30 seconds in Weather RADAR
>> channels). Even though this delay is expected in case of delayed work
>> queue as there is no guarantee that the work will be scheduled exactly
>> after the specified delay, a delay of more than 20 seconds is too much
>> for the AP to be in non-operational state.
>>
>> Recently commit 7ceba45a6658 ("wifi: cfg80211: add an hrtimer based
>> delayed work item") added an infrastructure to overcome this issue by
>> supporting high resolution timers for mac80211 delayed work, which do not
>> have this timeout latency. The other patches in that series converted some
>> mac80211 work items to use the new infrastructure.
>>
>> Unfortunately the CAC timeout work was not addressed as part of that series,
>> so address it now.
> This is ... a pretty grossly wrong characterisation. The previous work
> fixed a bunch of *correctness* issues. This fixes a performance thing at
> best, and you seem to be complaining those are the same and therefore it
> should've been fixed before. The other patches also went to wireless for
> being fixes, this really wouldn't, I'd argue, those two things really
> aren't the same.
>
> Please rewrite this commit message.
Will rewrite the commit message and send the next version.
>
> johannes


