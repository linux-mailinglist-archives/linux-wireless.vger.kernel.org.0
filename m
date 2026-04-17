Return-Path: <linux-wireless+bounces-34912-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lHr+OnR44WmntgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34912-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 02:01:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A465415C40
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 02:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25B503019F05
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 00:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E72A1CF;
	Fri, 17 Apr 2026 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a54d/KcR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PBTbb/k/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8F41760
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776384113; cv=none; b=kSg4LCovCpnPmL+ls3EGQTq+QoLmJ2k0T0hNW9A1Te6pHYw4LKZnpCIQqViiZF7eB7eE1EZc6Q+GSHSq96espYW5Itb0S4NLEkxNhGGG/sUcF5ksXZ2oHeLYpm4oiFrm+XxKOV1glOAWfFpvE5rwFUjy2Ef5n+f7rdsO7zaZZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776384113; c=relaxed/simple;
	bh=KJ3g6NEUcAc/bs1o7tNfHlHLj6KQyqifXgf7nP76tjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FF+5wglPVWFJ5P8jgmzj/LvM09Az0LcwQ1xCZ/Tiro5Q+528BUPDoMWaD4vPpHG68pB7WanCZ3dZ4EFYqHTjHFpz1wyPKfa8zPBPe4GEx892CHYk5z4gO/AxFZ1joqyZDv5feqbl8CcM7ifhUTDk1I4aDVAGL7fGKrdawszQmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a54d/KcR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PBTbb/k/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GNhLsw4028059
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 00:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UCOikrYDNBQYTXi4Vwk8iEGod0NEg9iU4aH3u210YBU=; b=a54d/KcRIkPtaZcz
	ZvTPLKYlBZoMx6VxKN3M2F9eArvqYV0rUcYu04+b3zUYjyyVmC9EtEdOXG/HLHNy
	uspWPxkEcZ8krn0+wLcBFQbS+DXpFTLFZm4MJ9LwjL2210AYSwD6T5b2e3rgntHo
	oeS1KzF7LG6kf4zk/Vat0mM7QVU1pzBTLeCFMkVe3bS7OaonQopDb2sCdi1lZcsp
	otiTbUWEGuAe+R6eWjUDqebbJqXhvjWrUG8ICB6HrTRoDY9LPC01dtmUHrnr0aMa
	BKUpTAAKkg5EMSB/GlhJklxoHSWg6wTcYiz6FhLdOUlj+1ACCoIvHbByccQnPz48
	hyjg0Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk227ssbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 00:01:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdd327d970so125098eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 17:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776384110; x=1776988910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCOikrYDNBQYTXi4Vwk8iEGod0NEg9iU4aH3u210YBU=;
        b=PBTbb/k/qXKznpJTQWSAjXe0QiXWj4heLdTC/KUydI8wf4iuKN646WLBAsKgW6z5uF
         MpyBI/gw8iEb9/4Jc1TJL8fpa9kOWHheUp7T3Nhy12UO62jFoXA+8LN7eFoFPGSaMnoc
         wHJbvUtljNJT5Wr+16Vvpm2L8YSaEoGaxkWWYQjyuLdccKlcPACOhPlU5iWnsoUL60tp
         cfPe2rH9jDgpQ+87zdUlCD+C/B2TYDdYTnbdn5DJviM6OnyjjsL5Z60J4NxClZFC9HJB
         RAwcyUD54rqR/QcW41CygDDDtkL6VjIQtweEKlqUBO1aYxDVmX6cpXmfWKlGpGrw/Y8Q
         1E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776384110; x=1776988910;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCOikrYDNBQYTXi4Vwk8iEGod0NEg9iU4aH3u210YBU=;
        b=T7ySmhvNk+toc6ZIKEBu0U7TjdUoAOBnXdE/6AFA0oG1gGIsQZu+vuan7Zu0agGva9
         sj1iTy+4lrSeHMSZ7lYTbTHQtGABeX/UXHP5Fg0mSLaFBxjrDJcRv7KYoZpqS7xO3ZLR
         EISX/E6iGAtNuXV2hmr6YLicd+XaHHpHCT1PvBbPCGLa9HcP9Ayctt6xxpSeLHnekm2X
         Upuxgxe6j2gm+i9IC/bYLorFKK/sDUTYSo8h3t32+Fsg5ufiH5T4iNHODZWj5UE4ulCt
         4VL2rbnwluLBxN+IdilB7oAexZ98IT9FHBaC5WrU9Q1L+QXs3l6PtcUULIaIdVvEFMQT
         I2Ww==
X-Forwarded-Encrypted: i=1; AFNElJ9wh6TM7DbMH/2IROvjchcxyghmIOrLffZFwhY8gcy0BbkkBvRSk6qfYV/VfKEwWr7UgPckxPIo67swUgl9ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44ZwYEcyB/Q+MgGb8tfdbUaahD2SlTq7+YOLyJCLJFxohL1zT
	BPM/Xq6XSdWcEQAmzPTRzPnmjpTtuoI7bVe/qKjB8vhtQ78fmVV8a+Sw81K6Ep+1e5IJMDhhDvu
	vlQAXVr6e3fDeTKSL6DA6UZrvSAAGv0l7SufD0zyrGzYF+DJwWGHfIvBuH0+IrGZj+uwEOg==
X-Gm-Gg: AeBDievgwZjDe63KyZad1j2YxNPeO/N9y1o4LlxTRtumAdBhAVb7/33B2q9gd5erVi+
	oduuY/KIOTAR2QeW1pUTPVj2jwxqFirJDU7Ufi2ssFZZFGqC1LBGx6dJJKrxxjv8R2ZqddFCND6
	6VsvX1p7xAcLTHU2hoy6DOEPh6P0QgT5Os9FpHrX3mjEx/jX/3GPF4hMGrpWAppTXZXJjDE8HWm
	c8PkLM0SIGRvRaqO5z/UH1N+DBgyqheZgyO0sI5e2yBhOsVLiHi1x2Zh/oq4tutrwkGX/pmn1HR
	R3wiK8t7b0i3ZHhdhSn/1XCZ/xSeXkyP4dU5973HZRJTx92z4/VWHVLg0ul2hyVJm7bZXmRFnqx
	t37x9UwLgr6H52ROP0ujQehEqYVyx0PyugW0eEqe6bs0EwgCtfEdSQqm4ip7rcWoYmxAe0BrfeY
	1xZyDcImX9ddtOCJId+ziyPAwl
X-Received: by 2002:a05:7301:3d19:b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2e41a1e3fb6mr263777eec.0.1776384109562;
        Thu, 16 Apr 2026 17:01:49 -0700 (PDT)
X-Received: by 2002:a05:7301:3d19:b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2e41a1e3fb6mr263752eec.0.1776384108836;
        Thu, 16 Apr 2026 17:01:48 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e4d58e3fc4sm236806eec.17.2026.04.16.17.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 17:01:47 -0700 (PDT)
Message-ID: <01831aaf-f6cc-4ea0-af73-83344698de63@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 17:01:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] wifi: wcn36xx: fix OOB reads and heap overflow
 from firmware responses
To: Johannes Berg <johannes@sipsolutions.net>,
        Tristan Madani <tristmd@gmail.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20260415223710.1616925-1-tristmd@gmail.com>
 <9fa651dd-6004-42c6-8c03-95247d5807fd@oss.qualcomm.com>
 <c29bf32b7f1195a69d86b4f728ab02523675b41b.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c29bf32b7f1195a69d86b4f728ab02523675b41b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIyOCBTYWx0ZWRfXyUHV0d+/WYxf
 BLYc/XKrduZueElj9kP7MIy1w9ilbWlujgyE4tXvGuxZgfSxg5zZ0wVtBlRDMNdzDlNHv8wJ24w
 X5J3gyc2D/iUH4cZUKa5yeHoR4Y4wKaw4iJ1Q1PlERt4W+ZJ9TlFII6fmwoK6YfdzpsKlQPsV1z
 gKT4pOz7AORNthEg9RU9apQbHI3uYwbtu2+Oz4C55tG+YHNELY93sF6FifITqJ+C9mAMUZub0np
 IimnlkV/eLegMGTCGaWMo3nskIe8NEqNUmGG/VOti8tDQvRPruEHHMoWeFR6r1LfS2MLEazV1Rt
 6Jd7qzTUkhsMG82/FfClI2iqWKfCMvoD0hwp8ifDk4SvjBVuhYTELAhiqCYuYnlBx7/W+gK8LrS
 7+nbaL41zczPMiLbBLhNfyurbEUZ0V3dxAicONqQM5jnAW2xLaxzxPT6yYOG6bF/qdaB/Xdswxb
 JfUklDrdBe8LHmrltxQ==
X-Proofpoint-ORIG-GUID: c-0brRFAUxTFaCmejgenxJNsXb0oCJE7
X-Proofpoint-GUID: c-0brRFAUxTFaCmejgenxJNsXb0oCJE7
X-Authority-Analysis: v=2.4 cv=Iuoutr/g c=1 sm=1 tr=0 ts=69e1786e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=J_-Nd1mkAAAA:8 a=iTnIYPRuOBLnaQmyNHoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160228
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34912-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3A465415C40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/2026 11:39 AM, Johannes Berg wrote:
> On Thu, 2026-04-16 at 09:25 -0700, Jeff Johnson wrote:
>> On 4/15/2026 3:37 PM, Tristan Madani wrote:
>>> From: Tristan Madani <tristan@talencesecurity.com>
>>>
>>> Hi Loic,
>>>
>>> Note: this is a v2 resubmission. The original was sent via Gmail which
>>> caused HTML rendering issues. This version uses git send-email for
>>> proper plain-text formatting.
>>>
>>> Three issues in wcn36xx HAL firmware response handling, including a heap
>>> overflow in the main response dispatcher:
>>>
>>> Proposed fixes in the following patches.
>>>
>>> Thanks,
>>> Tristan
>>
>> Are you able to cause these issues to occur?
>> My expectation is that this is testing things that firmware will never do, and
>> hence this adds code and processing with no actual benefit.
> 
> We're not really supposed to completely trust firmware though, right? :)

Like everything else in software there are tradeoffs. You have to mostly trust
firmware since everything it it is doing is on behalf of the driver. So that
is why I'm curious if these issues are actually exploitable, or if this is
just preventative for the sake of being preventative.

/jeff

