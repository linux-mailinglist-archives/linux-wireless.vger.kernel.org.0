Return-Path: <linux-wireless+bounces-35251-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MGqDzBz6mlAzgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35251-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 21:29:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3EA456CE0
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 21:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5FAA30022C9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E813921DC;
	Thu, 23 Apr 2026 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlZ/SWG6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OdPxlzuz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2C37E2EA
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972589; cv=none; b=VA8RS6BV1+fbg0zUr/EWty+M5mmRBEFo8olukhjRc0jMQHOoAMpg/+HKUaCQVejkn5CAti9DQ54U8Tr/ytwDUFfUQvlxRFFBkU8fRYSO5emDFJFUC6Elbal0AHaqNj9ZtbYf3+dhYGQEJFfgx3JjNIazAR4FcfWp9gh9VKzVNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972589; c=relaxed/simple;
	bh=3tHACTJZAzdeGKBXy/U//ydKgcIv9FwVSHpxmsFpwYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNMPlpkZxtj4Wcn+cyDt7nKtNIO1hjsZnleAITVmNDPNraSMXPZ9qzzRzMqHmracBFQeBJM1Y3hnxDWbRyQd09zQSkwq8ywvRbhRb1Z0Kj6qsJkxrPKn8yEwxbXkFNR3pFJ+oaFM24KKEJUHMf/3ZhZKdYOBd6fA3/jAIB0MIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlZ/SWG6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OdPxlzuz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NHkOxf756616
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 19:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rhUGLFEdF20n9DaJ8aZw4RB32vvaxXdfN6hRM3OazJE=; b=hlZ/SWG6O3ZcNqys
	irXSSd5Nsc1rTwlS6ndkeZXLDO+hDNYHVrlXnSLBFLPu3Y/UqE/gcMVJJrsxaa4e
	Yr9cw3EWMUBVuj5tG1mUzfzYHg0cKXhIBmpN95DCNnTqeoOKL2E3EF9Sm9PTRV4C
	kDzZELJXxKFfQH+nOfeRkZfIT5FvcTFpM5lzGPL3frF49LlvxlJcBMKAAJqHRCzX
	CpmNLogKI2xBF0uEz36d6ttLVeqCXZaMnoZGYhl/K58SiBvlg+eHhe771H2bSfAX
	Ji3KU0BHLgq/tUXlET4dv6ggqStuKVQnY0DjEUIQbDOA3DS1vCoCuJ9KVOjaKWYb
	eoDXiw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr4bgf11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 19:29:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c16233ee11so9682510eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776972585; x=1777577385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhUGLFEdF20n9DaJ8aZw4RB32vvaxXdfN6hRM3OazJE=;
        b=OdPxlzuzVTWopOX8kXY8HaJQBiuBfVbFtaVrlHXeA01IxxEMKDP2Ducm2AsXFREIUL
         dPvP5Gip1PYKASLQfdZeW9JpT6aaEy487X+0HaXqXba6570cDGTGobVZogHGVSRgHFyU
         WOCBcLc72jpl8qeXyR9dwe2h65XvuIyZgbeBGGMg+o5ofmWnr1CSpZ9NVAAZ0/tUqZ1m
         9hhlIJEgBz5LRVaCvCxUrJKFw4hJvdNzA/mHn+49nMpKf/h84PuCpYqwliR9HVpdAVTE
         LCoEuH6b/y+B779Tu4opFzRcequPgs5I1jdqroqmz25bIo0HpozAf65+LxU0969q4+VD
         NIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776972585; x=1777577385;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhUGLFEdF20n9DaJ8aZw4RB32vvaxXdfN6hRM3OazJE=;
        b=lKddiQtOCle2TVqqCzHr98++xFiFtorrmFe/6SPzZ78gRhQgtZJFO7KogOcQHqQYvm
         iddjA1Az/C768idzmkWwfcY1aNkXu04tljuM5NqjIomyMCLGcQ8MDa8qqtOVviBdZNFG
         pEBokMxQoByz+KHxlGS0mYEfqXi8D7woBxgslwlNp3V2JbS6h90xk+H2r1KdNc4+x5F+
         JPNI7Ob8UhL6DO3DyXdevlwViLrPgMZN4dVYRqJRJf44g7SF/k+Umk6lC33YD92sCgFC
         AyCYqjeVldX4ET3AC2cRNsUVeWdwqFarAM74GIKSBTcsTdhyyp7TgGBofgkCxftZgIN4
         +utA==
X-Forwarded-Encrypted: i=1; AFNElJ9hqaTHMEXxettpZr29mK749KfsqztSk7eZEaTaGTSvuuiDFI/f4q+9G+lVAKiyS1NpykeIoWvZQNBpSaRwKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycB+YzbWZzpjdak1ssyZTcAYyuim/B/uPsi2wbKVjwPKF6YrBH
	PrBrel4yvO94C+GduKSCqWg1UtDafb0BZ7ltpESLlCkhdgeNcUSJF4fNQVE35m1IAxGik9auRKk
	UxOCE7Y3tvGbDHAjYq1EAM4hQWsf2LwgV1unJJCs6WCiJzVBMxluf7Jc4UsU6mYjHLAEVrhOKEW
	xhQw==
X-Gm-Gg: AeBDieuVdXzVApSaIut5BbLmK0ZlQDt1CoYmirdOmlgXZpyvhHvLKomslFnvXda8DUE
	0c6sc1FAZsILOhnX2u2J3pM2iIbOrBJonhaZ73VlLm4awtN6YA3JPuCeMd73hDn5CG1Z+yJ/Z/e
	oWnmnWUUDyvHGymxGxpDhVXdi7uzr5vPzw+nIR53xCNlnJjuikDBjECyqrb7nwz3tg6II8vfnX8
	xXJxpKsk5u99d0lDrlzYAeW7PeS1fzAJVf67AWdw2c82jcKT2sUhIjcLTMia7fhlT0cSJMVEt7S
	sFyfaMxQXe2JuraJZ3m8EC5iufhA8RvKmzAnmpjDRtDw/XoGzVBF2ta84ZGwMwQSWNOnoZTHy+M
	QTK4mjWK1aabHOMAKDaJRAuB6K247hzFSVZcNTBP1JsEmH38iOY0xhdqKwyknHP2OwtakzhPeMa
	RSeD5/zhMbgF/ntwgXtWQmJbLr
X-Received: by 2002:a05:693c:2c84:b0:2da:44ac:6d17 with SMTP id 5a478bee46e88-2e47873bd2cmr16853347eec.17.1776972584729;
        Thu, 23 Apr 2026 12:29:44 -0700 (PDT)
X-Received: by 2002:a05:693c:2c84:b0:2da:44ac:6d17 with SMTP id 5a478bee46e88-2e47873bd2cmr16853325eec.17.1776972584191;
        Thu, 23 Apr 2026 12:29:44 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm36583105eec.8.2026.04.23.12.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 12:29:42 -0700 (PDT)
Message-ID: <6de7ecef-5fbf-456d-bb5e-2a6fcd9b1a75@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 12:29:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] wifi: wcn36xx: fix OOB reads and heap overflow
 from firmware responses
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Tristan Madani <tristmd@gmail.com>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20260415223710.1616925-1-tristmd@gmail.com>
 <9fa651dd-6004-42c6-8c03-95247d5807fd@oss.qualcomm.com>
 <c29bf32b7f1195a69d86b4f728ab02523675b41b.camel@sipsolutions.net>
 <01831aaf-f6cc-4ea0-af73-83344698de63@oss.qualcomm.com>
 <CAFEp6-2jAe+-1xyZtMKzmrJ83yW+sZNMEjSCY1dYstn_=azqdw@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEp6-2jAe+-1xyZtMKzmrJ83yW+sZNMEjSCY1dYstn_=azqdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE4OSBTYWx0ZWRfX6DWgP0wb42GU
 2dZXhlVLrvotAygXwAAwsKsxKoVieKjXJm36pwhtS2woqOQyPB4lnPMbYmHMO0vHCXCA9xNkxmu
 /VQgg7DGnZFeMDda3ptNceTRroKM2TlqN8e+3fLDODY1G77V6NC4HLGNVpBotcp641/tKrjRlfl
 TkNy1jiSBYXSzOreXWZ/I0+WVIWC/BgdvaZVc4BS5rUr41O7oN1OBbR6TwC2A2QFqei5nhV/uNv
 V2lYnLifsitvqB/QSw4iGW5XqFQ0EnhTMA+S6ZHvfWAUiiXIHrVP2QmiyF0FtZN37kR+2t4Hk0F
 Y1aYS2n1xAPydjTtALx6E1l47YuhKUjo+c0IbnbVdckF9iRQotA7TY5YhshJRKzKj95I4tIb20r
 FUVG1M8RDP00SDo0+cYIq/+5nBuvY4OUoIeTc1L1LSZE3BGK/NDTY+vVg6LRl9No/BP7Z+MEMsq
 +LxIiOd9bMOkV16DqDw==
X-Authority-Analysis: v=2.4 cv=TtnWQjXh c=1 sm=1 tr=0 ts=69ea732b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=J_-Nd1mkAAAA:8 a=lRFVsVZUUDNXc1M4TOYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: OWeC9XBDpEGVTWX0iSpY5xmCELwUivKQ
X-Proofpoint-GUID: OWeC9XBDpEGVTWX0iSpY5xmCELwUivKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230189
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35251-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9B3EA456CE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/2026 1:24 AM, Loic Poulain wrote:
> Hi Jeff,
> 
> On Fri, Apr 17, 2026 at 2:01 AM Jeff Johnson
> <jeff.johnson@oss.qualcomm.com> wrote:
>>
>> On 4/16/2026 11:39 AM, Johannes Berg wrote:
>>> On Thu, 2026-04-16 at 09:25 -0700, Jeff Johnson wrote:
>>>> On 4/15/2026 3:37 PM, Tristan Madani wrote:
>>>>> From: Tristan Madani <tristan@talencesecurity.com>
>>>>>
>>>>> Hi Loic,
>>>>>
>>>>> Note: this is a v2 resubmission. The original was sent via Gmail which
>>>>> caused HTML rendering issues. This version uses git send-email for
>>>>> proper plain-text formatting.
>>>>>
>>>>> Three issues in wcn36xx HAL firmware response handling, including a heap
>>>>> overflow in the main response dispatcher:
>>>>>
>>>>> Proposed fixes in the following patches.
>>>>>
>>>>> Thanks,
>>>>> Tristan
>>>>
>>>> Are you able to cause these issues to occur?
>>>> My expectation is that this is testing things that firmware will never do, and
>>>> hence this adds code and processing with no actual benefit.
>>>
>>> We're not really supposed to completely trust firmware though, right? :)
>>
>> Like everything else in software there are tradeoffs. You have to mostly trust
>> firmware since everything it it is doing is on behalf of the driver. So that
>> is why I'm curious if these issues are actually exploitable, or if this is
>> just preventative for the sake of being preventative.
> 
> I agree that some degree of trust in vendor firmware is unavoidable,
> as its internal behavior cannot be fully controlled or inspected.
> Nevertheless, the kernel and its drivers are expected to strictly
> validate and constrain all interactions with firmware, so that any
> faulty or compromised behavior is contained within its intended scope
> (network/wireless).
> 
> So, it is the driver’s responsibility to control the firmware
> interface and ensure that firmware misbehavior, whether deliberate or
> the result of an exploited firmware bug, cannot lead to such kernel
> memory corruption, which could otherwise be exploited well beyond the
> driver’s original functional domain.
> 
> While this issue may be largely theoretical, it has now been reported
> and a fix is available. In this context, addressing it seems to be the
> responsible course of action.
> 
> With the increasing use of AI, we may indeed see more fixes proposed
> for issues that are theoretical or unlikely to occur in practice. I
> understand the concern about avoiding an influx of low‑value commits
> and the need for some level of filtering. That said, in this particular case,
> I believe the fix is legitimate.

Sounds reasonable to me. We do actually take this approach with the Qualcomm
downstream Android driver.

So if you ack these I'll take them :)

/jeff

/jeff

