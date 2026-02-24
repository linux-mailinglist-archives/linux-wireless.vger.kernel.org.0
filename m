Return-Path: <linux-wireless+bounces-32162-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIIMOPgvnmk/UAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32162-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:10:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F51518E154
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B2F33037895
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 23:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C41DD0D4;
	Tue, 24 Feb 2026 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P4HlBcw3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O5fjVi9Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138728C854
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974435; cv=none; b=VaFvgIEni+JhuU8qZAsLnpLyozLll3sSnoWZ0bCmIa01AyijiEkkuvhmaNZ5mPF7irZKs6HcOOILG0/a+BkZ0/BmISKJEthi184sv7myrkiyUN77+wgfJrI8x/IPih2+yXiofMGqbjL4lHirbfSYJNjvF6fCtVQR6l/qQ63NqY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974435; c=relaxed/simple;
	bh=qD6yT/PNtacohCP/Eq1ysliGbDyYArpaUr9Ruw9dUic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqXqASHOqYecPqS69Z7LVbQEPpz56QDWvewAVDcpue1mUBidzj8Om1NPETDzWHSvgt1NPxBmSSLFAKoczjH/5ESJeXnfuNvfz+fit6vLY4Fm0xyXJ0DUArrqy+7Fm2ysIXTLBHdl5G7AXcbV0WbEXJcoQzF41mXpqRAoaiNIG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P4HlBcw3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O5fjVi9Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OHOhlR057136
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 23:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A9fRHxsfvOaSlDHlKSPLbv4Lj9V01cj7IJwMLcuhXUA=; b=P4HlBcw33tbm/AEC
	QWReif2NP9XNnwJKhWpg9nEbO9E/EJCM/GofOUkScCLDchx144R0T7u+tC5CofIx
	MbIdhT8KeBLGiqp4Jhs6F9F+FiNDrbnlsd5+hdZ3IcqZ29xlO25eC5x5LJYCnJJ9
	UdZqyULplGKaYcIE1VZFiScbENdeCaCiWszY/a+gG1loJ/cicswZs9cwHmJfr3Un
	xli3ByHlAUJXluuAVzp6KtAAN7qeUE+8Iotoho3Yo/86V8t95eXfXzCZI6+jVzS9
	XO4vV0ZSyYMyXVbdqdJfHoHoIuDEPJwlLXrfEzOhBMX7UNHbScnZOklqCmpxbx1i
	BhUtNg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch9saagju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 23:07:13 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4bd29099eso74222989a34.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771974433; x=1772579233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9fRHxsfvOaSlDHlKSPLbv4Lj9V01cj7IJwMLcuhXUA=;
        b=O5fjVi9Qnp4W2faEGFVzKXXb04q9yxFxL0waLjj6qBdngm4hCLiij6F3LckHOYFG/i
         FVEuL6Ee4vjrdTpbVa3UoUeywdvuKkF2rc4LIdUrKgFr8GyXzDFRfPyjumjcoKgsBZ8T
         flhJxKpgsrfnFwN+pC9ixdk9sWPJObI99Qkl+dri1Xu4AkAY4gFp6HiG4ECGPFR1yZzy
         2N+ZDn2caHxLRJg9dHoJXLp6s8yooQhlMsD+0R3ONiqFikCwUaeraEi47jYwxRvEJGYh
         r0LhCFZ1eZT/OV+RHgwHYflA2o7aqSZDIpx8V6gPpaEg93gnWQ0gXgq2hbqarOvNIbLd
         Ve2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771974433; x=1772579233;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9fRHxsfvOaSlDHlKSPLbv4Lj9V01cj7IJwMLcuhXUA=;
        b=k+597pJMVw+oqJ7IDGdB0qxAotGCutXYnrlsbSo5gJdenSuilo4ZD0NsaiDZ/wkD8X
         lFFFmPj7sJoHXoWsEl5+mYcv6CT9RswYIfOza7FsEs3KCs2SpIG7vtIdqLM3gCTHN7Xw
         ekgY13WhYmzmZkSeuN8hhqZdSFzpy/XXtuxBIw8xMHv51SO47ZB/HeFI95G9XakZJJhN
         S6IHNW0AMXCVzK1McUm3ho6qqI56k64yN07MMmajLU3Iy+qD6RHQuOucwTBkfA6PXez7
         /Zw+DMhFImfMPnNuUbUPQ6HTV9R3tAfgqTQNSKsZPwOnkBEOhZAfDxO2yOR+7jcNcbbJ
         AUJw==
X-Forwarded-Encrypted: i=1; AJvYcCVzPZkbu2eBKxJEmIVz8hmrnrNfakiQ7a8DQgEtvgSAv+AdrR0NJKKn8x3HMcqXpab9qrhPR4s7szFTaZ6DjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQKZO7bmHEcwv8VhH0EwDtrnwWNF/3pINy+h8mFwzOk71L7oA
	9Rgxk4kWWsJ0uFIrKoU/0KY6fmvywgp97DUMD/nrqtEXhddAH5+aEv2y6tLH4BLx/yWiQa9t5QN
	uMuH6+D2MWcyV33JjjMwtpRJDCirfqNs59F1Gn3B43fQ/m2irLcOLbJklx/Q++5yG6UaUsg==
X-Gm-Gg: AZuq6aLnmDpkeEhkoEW34x0qEtSqCUb43Q2IhWkNm+vDr3mbugRIYn0TjA98kO8G0IM
	QTDBiMnCfsw3hBEBY8P7zIZ9893+ZVIAC/BglrEBbMLhWTiB3FRs4plFD/7qCGATPxqWz9jaAB7
	DMHHnLilrN/4COnQxmcdmEn4q6xNVj/RUT1oeIfxCjlo7EgcbHxucEUZ1DQqmMaks4PbFcGzT/x
	XFdUV7Tmd1TimTzSV1DNFGTPX2rLad4bMu+05HYiWkIPxM+UHdon/7lnXpT/pmDr7GZg269tXmA
	vwEBV91hq7IIRtD42QfcVBr+kiN9ZAiq+hgvDB20f/cdDxVZWOSbZjcf0JXpte2wRx9DAHr6USU
	PkKSuXUky+yBp5L4fsIFiGqjpYL0A/+curTV6arlSvU/VQ5SkA9XyUHO0qLFbL8tpvs9EsOii9C
	gXX3f5Y5Pza3fqTw==
X-Received: by 2002:a05:6830:2b23:b0:7d4:4d3c:c601 with SMTP id 46e09a7af769-7d52bdf6f79mr9043198a34.5.1771974432763;
        Tue, 24 Feb 2026 15:07:12 -0800 (PST)
X-Received: by 2002:a05:6830:2b23:b0:7d4:4d3c:c601 with SMTP id 46e09a7af769-7d52bdf6f79mr9043185a34.5.1771974432405;
        Tue, 24 Feb 2026 15:07:12 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d038dcdsm10876058a34.16.2026.02.24.15.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 15:07:11 -0800 (PST)
Message-ID: <0b9635b8-05ee-4ae4-b4eb-9b83188a0917@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 15:07:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
To: Alejandro Colomar <alx@kernel.org>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@qti.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>, Greg KH <greg@kroah.com>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
 <aZ4r6OUVCiHE-hhZ@devuan>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aZ4r6OUVCiHE-hhZ@devuan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDIwNCBTYWx0ZWRfX57VVHbdgeWuy
 w4Ho1Rn8u+q56wMe34WcBLSKAeAlix02pIi0EVK5mAdITWJWlE+s8GLerHoTtEQmud5xsCm5rhF
 LSg4XqF9+PAmed8rdPUwSi+Rpq/Vy7MChsVCnkDEF0257MHYqhxCsfRLE542KMWgKTJHb9Hr/o7
 /g0p9tA4w0Fz+UKVkLDpb6KbSBsyDE5vN2OKj3MgkhsQol3ojY2YVhwjOGBHD1rddD1BBwX90nB
 JQX/AiJYyDMRe/DwxxtBYXTfxFn3325MyqLN2zwi28vMnqRm7f2bWPwI3vcYWr0A8TXd2AaLjQA
 ogbm+LYYm7wkNW4xxI2OMn8KPt7WcYmL6zdg75rShwxdKin8Jb79sXsxf39z+dplflwTgZIFmzv
 /+R0JLj5IwJDz/mUFrM1K1VEYPqAl1B6TZrR/Tf7aOL5WH8pj11x1sEosEmIvq6mwe/rqeJHnQ8
 lI2IIp264/T+s1REfPw==
X-Proofpoint-ORIG-GUID: LfnYhPUmwUzDdRL0UwWaV5GDuWIu2n25
X-Authority-Analysis: v=2.4 cv=e7ELiKp/ c=1 sm=1 tr=0 ts=699e2f21 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=DfixdPDBt5U34GzurFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: LfnYhPUmwUzDdRL0UwWaV5GDuWIu2n25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240204
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32162-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3F51518E154
X-Rspamd-Action: no action

On 2/24/2026 2:55 PM, Alejandro Colomar wrote:
> Hi Jeff,
> 
> On 2026-02-24T13:34:57-0800, Jeff Johnson wrote:
>> On 2/24/2026 1:27 PM, Alejandro Colomar wrote:
>>> Hi Jeff,
>>>
>>> On 2026-02-24T10:45:02-0800, Jeff Johnson wrote:
>>>> On 2/23/2026 7:17 AM, Toke Høiland-Jørgensen wrote:
>>>>> Alejandro Colomar <alx@kernel.org> writes:
>>>>>
>>>>>> This only worked by chance, because all callers of this macro used the
>>>>>> same identifiers that were expected by the macro.
>>>>>>
>>>>>> 	$ grep -rn ath_for_each_chanctx
>>>>>> 	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc, ctx)
>>>>>> 	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc, ctx) {
>>>>>> 	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(sc, ctx) {
>>>>>> 	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(sc, ctx) {
>>>>>> 	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(sc, ctx) {
>>>>>> 	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc, ctx) {
>>>>>> 	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_chanctx(_sc, _ctx)                               \
>>>>>>
>>>>>> Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating channel context")
>>>>
>>>> I'm dropping the Fixes tag since the existing code actually works and hence
>>>> there is no need to backport to LTS kernels.
>>>
>>> Sounds reasonable.  Alternatively, a line next to it saying
>>>
>>> 	[Do not backport]
>>>
>>> would work, I guess.
>>>
>>> Greg, I've seen this situation already a few times.  A Fixes tag getting
>>> removed to avoid triggering a stable backport.  But I think keeping the
>>> Fixes tag could be useful.  Should we have a standard way to document
>>> that a patch fixes an old commit without meaning that it should be
>>> backported?  Maybe something like this?:
>>>
>>> 	[Do not backport to stable]
>>> 	Fixes: ...
>>>
>>> In any case, feel free to remove it.
>>
>> Looks like we have this:
>> There furthermore is a variant of the stable tag you can use to make the
>> stable team’s backporting tools (e.g AUTOSEL or scripts that look for commits
>> containing a ‘Fixes:’ tag) ignore a change:
>> Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present
>>
>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
>>
>> Do you want to re-spin with that?
> 
> Would you mind amending to include the following tag?:
> 
> 	Cc: <stable+noautosel@kernel.org> # the code worked by chance
> 
> I don't know where I keep the patch, so I'd have to apply it from the
> email to resend.  Could you amend it yourself?

sure, I'll amend the patch in my pending branch

/jeff

