Return-Path: <linux-wireless+bounces-32158-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NP7NIkZnmnATQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32158-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 22:35:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E10818CCE3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 22:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC5CE3020EAF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E05338904;
	Tue, 24 Feb 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzW0gJSp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S3j6mvtv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4854317D
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968903; cv=none; b=W8Sf/gtqLKjdELUYfmSCNYhA44R/FBxts/BbwRvRuPe8BUMi+52ikWUa7OydVUKzh/npEXY3tnMeBgolyh1k/LV3sn202OcQFNwKJnzLZ50cdFk28tVP3ydMjyWykgcFGJuOVEyxaK1xS7rIa/mqEm6eHTU/x/oukhbCOmfPzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968903; c=relaxed/simple;
	bh=fwlKTBuit/2ww9QpD/dEMI0cmd6OjaM7Z11W5k13Wts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2w2F7rmUklTv0VUIEp/in/1m5rUbsOax5deNhwFh5i1onTBB7AVm/hEdXZ5tpm1pkIVRO9Rw/QFDOlXxuKPtn8zatKvqRxqy6aJB6h9dK+PO9Ace344U0yIppJAArX69Jdjryh69p/oBJbxApa+KVdPKiOvkpsjcGwsP8RxLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzW0gJSp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S3j6mvtv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OHukIL057159
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 21:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Iq66GJRqdSWqFbAMj6HXpGKIOtpR5QPvlC6q6t2/fc=; b=UzW0gJSper/5vSUb
	OVcavDCz2vksvko7gsvz+WgT/+k8eWb8fAIdrjmvn3DM451LO8q1xFxeZwDYSfWM
	ZC1p1C5JeOmgZrHIj54by+DuHBrkQzEsWECo5sQnBBtpNRwAvGJgb6gwmWlJOlEV
	PGsHpZX5OH4+7wSMBxgYKcYkbrkNeqSLrFXbrGYiJ4tq6kXEEFeoCw26eZMU0X3U
	+hHgOizwQ5hy6XmnVAClHSJQQyVQZvgH0TnFHA1gNgrB2zzFXNGQ/5DLZRIPFL1+
	5+h/OsqcdgAZ4KwnHWITZ0mRdvxNRWx/WX8VUzV4XmxcDAVT79+ol9yzSV+TmUxF
	NRY/4A==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch9saa9v5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 21:35:01 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-463c4133ccaso61870622b6e.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 13:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771968900; x=1772573700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Iq66GJRqdSWqFbAMj6HXpGKIOtpR5QPvlC6q6t2/fc=;
        b=S3j6mvtv3qhf8W5lQluIqY0r0LX34K1WlwaXQLl7Qpo+1+8SNy6rpBrQ01gIw56QAT
         Yt+xfsicQkjk3thOY77lNaJPQ9Xu1KEIVEJ4FXbUZdkOXDslqw1EaXWsDyeqDo4PJTQq
         eEG1bsBdw3u0o+WTl7RuCy9LEM3wCw923RHnvxTDZDWJ2IlAC8Q7m2mkteHVBlbI6XJ3
         p0XCTQSt9Q/BEA8HywByl5SnYhmgNUOYQ4HyiiJFGqgai1yhcl1UZaWPS9Y0/HCIjb3Q
         LsuEACd4+qrc64/mkt8b8SC1uBjXLSEbNI8jeX9DvcNB2VirkdgqHWuQ+TNcIdiU9IJM
         AwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771968900; x=1772573700;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Iq66GJRqdSWqFbAMj6HXpGKIOtpR5QPvlC6q6t2/fc=;
        b=GqSNbpkDraZUZMn8F9RzzSiOsO530ASXVBh/elKrRuCgcTfkx9tu+q0goL9YQsgjKI
         9TRQ1K4nNxhMXQCTUn7fippBl2ALZlHkFW4x9KdMAVD5ZZ0KZSJBTMQY+e8B5NWbzwtJ
         n/Gg/J8PnVTLRKf+bgBJzRAyrZZxh4wN8wll9fL2Lz8wWqZNjrnP4w8g0rGC5t3XmgRq
         OH3ZUfD+XH4DZln9R0SJ8GDW/AcIu5h6W3zwHr04/LjEuM58LncYQM6wybz5BSb10Sch
         569+foyPPG6X2m/BB6MG+4SJZZsys1ugW481HpFWcDRceld3tVcLozfEKyLJ2th0e3jY
         fZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCUJbdx7sfPNtFOrNaePHg/KKWnIpxUF576mlrcC3UOSrfwhcuCJfGFTMGDGQixjV8CgFQd+EbbtWjOFMQTbiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQEG3Kn8qoZUbWZ4cBFFfSAep63hU/TOv0ZPxmq7n6FClgz6P
	z+tc0EMduDFSCaIYTIDGIfTJSYvMl8dTVLrOcCPOpePbatOgQRvaEOakwl6AJlLuY8nsQYyES2f
	8zCjUWkLx761yT+EgZNXBEHB+TsomTcJ9epNtfQx0RFABR7GSfwM2m9iZMrM/UgXurrVP8g==
X-Gm-Gg: AZuq6aKLsAOI+rA7fsFp/4OjBDocyVnTbml5tSLx0UJwB8QPE/eIvRWkHKMc/1937Sp
	4TPX2I+mJgGszgRDzNW8tNZMQ6ehE4TkW2LVOImBedk6xJG6dccBY/6Hqjd2BcsCgAGsYldyPrQ
	KJs7DCTTzT875F2Uur7ADMuacaPWtsYp3WlqFtBy+CW5t1iOULjq/Aa14/+GWIIgiY82WzAQUAI
	oS2UJFCwiczhFE0nQpoWSCsfU2pUNzgBm95XTEs6w7z/km+ahl3w4ONlz1/xs9lwvSil/PqYtKp
	yo3i0Vj5W6ptxRilAIaxRZFF8T+IsclcJq3O/YTylo3U51B1+DcXRN5mko3Xvc04IcUYwefTtVE
	Vz4iAeRM3Je4A5ox0eLdyFwlhZxnWfiXlb/9ckA3xhmrjx4amE6RVEncJYKWsanfyIbXXNraX63
	QglPJo5OxA/MXxsQ==
X-Received: by 2002:a05:6808:308d:b0:464:5a7:8324 with SMTP id 5614622812f47-46446343d82mr7437642b6e.40.1771968900249;
        Tue, 24 Feb 2026 13:35:00 -0800 (PST)
X-Received: by 2002:a05:6808:308d:b0:464:5a7:8324 with SMTP id 5614622812f47-46446343d82mr7437625b6e.40.1771968899820;
        Tue, 24 Feb 2026 13:34:59 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cd5e168sm11094158fac.4.2026.02.24.13.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 13:34:59 -0800 (PST)
Message-ID: <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 13:34:57 -0800
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
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aZ4Wq6h-nMt-G3pC@devuan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE4OCBTYWx0ZWRfX5RxLpv5D/tas
 ds+EbACbwFhgvafa+A9Uh+OqSMfQlCfsVzXPDs+0ZAm9vUG25tcf8eboIYcIlB3w5eew+onfGVN
 xZNny09B+XUBDc/17N0lI0cON31TdjRSwpEVWmFM0HqMmpUuGPDtyhCGiHjPvFDeQllnRQxUubc
 I9ltzlHXAU9mUJYlZlPTdYSSTa1zZH7XixQy7S2Dsx7DhJeTPVLMImUj7lJp+WpBMfX06x89sf4
 hMM5m0Z79wTEbB6EE8goVl5Ir8fvlgujp/7gTYddz2H9FFn95001hiclWfscfnwizieAnR3fQh/
 BgxqxKPs+jTLXO29sOQyj29AIDi9b9j4xoogcwjpLgi7hlbSpXmQ3bbpu/+z1dO3KFqnPJHFF63
 euawsTd7ycMWTwKEMv61EzO7bNiCQZ6BUtuk0ol9f2Ph9VromEJTTxIUp/cRHr+66IX8urdawFX
 huhVltkPuWBQO51y1Hg==
X-Proofpoint-ORIG-GUID: VWMDVoFN_oLiWF5JChEvNfcS6JgU7hCq
X-Authority-Analysis: v=2.4 cv=e7ELiKp/ c=1 sm=1 tr=0 ts=699e1985 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=cNouaG3HbW4SopQ8NDkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: VWMDVoFN_oLiWF5JChEvNfcS6JgU7hCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32158-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E10818CCE3
X-Rspamd-Action: no action

On 2/24/2026 1:27 PM, Alejandro Colomar wrote:
> Hi Jeff,
> 
> On 2026-02-24T10:45:02-0800, Jeff Johnson wrote:
>> On 2/23/2026 7:17 AM, Toke Høiland-Jørgensen wrote:
>>> Alejandro Colomar <alx@kernel.org> writes:
>>>
>>>> This only worked by chance, because all callers of this macro used the
>>>> same identifiers that were expected by the macro.
>>>>
>>>> 	$ grep -rn ath_for_each_chanctx
>>>> 	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc, ctx)
>>>> 	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc, ctx) {
>>>> 	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(sc, ctx) {
>>>> 	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(sc, ctx) {
>>>> 	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(sc, ctx) {
>>>> 	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc, ctx) {
>>>> 	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_chanctx(_sc, _ctx)                               \
>>>>
>>>> Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating channel context")
>>
>> I'm dropping the Fixes tag since the existing code actually works and hence
>> there is no need to backport to LTS kernels.
> 
> Sounds reasonable.  Alternatively, a line next to it saying
> 
> 	[Do not backport]
> 
> would work, I guess.
> 
> Greg, I've seen this situation already a few times.  A Fixes tag getting
> removed to avoid triggering a stable backport.  But I think keeping the
> Fixes tag could be useful.  Should we have a standard way to document
> that a patch fixes an old commit without meaning that it should be
> backported?  Maybe something like this?:
> 
> 	[Do not backport to stable]
> 	Fixes: ...
> 
> In any case, feel free to remove it.

Looks like we have this:
There furthermore is a variant of the stable tag you can use to make the
stable team’s backporting tools (e.g AUTOSEL or scripts that look for commits
containing a ‘Fixes:’ tag) ignore a change:
Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Do you want to re-spin with that?

/jeff

