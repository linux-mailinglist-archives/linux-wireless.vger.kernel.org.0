Return-Path: <linux-wireless+bounces-31714-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEmxIucXjGlGggAAu9opvQ
	(envelope-from <linux-wireless+bounces-31714-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 06:47:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3356012177C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 06:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3093230E1A57
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 05:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFFB34DCEB;
	Wed, 11 Feb 2026 05:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VMHpELkT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i1oNJ235"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3234CFCF
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770788616; cv=none; b=o9ndhOzV+RY+5lmnHdWt5bsMnDLRmpgvehPEBJq37XuRWI01AQeYipw3ejpE4BPv8FifQRQO1IITUNJnxDPpwMawnmuxb8TbuuXHqbYFjqdQq2jAEUhDOY+b3CAcTQhVcrx7EVpcJDbnCIqhipcjUO7d1gryfcQ2f9W9taDa9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770788616; c=relaxed/simple;
	bh=2SvnXPa7nj7+Hg0SRs6TvDzTICsTawLZgum5pNQvcLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nftxHcrN4VrIYmoyr1Q+W1SDav85HOVKnQ6ob/LlUdf7xPuCW2P1Dg5Adyb/C6C2GhemaV+78IDVLNjqE+w5MugiV/jn88x9li8jvQZh2peoWB4j349h12fo8aIlwRYsYbdBB5rHpPXf7I/VF1TzSohfBrY/bfKO3bMUHVyb2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VMHpELkT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i1oNJ235; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B57eKp4013766
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 05:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7xaWScmkE2/GPwlOezPX08W6gzrXt1tL77aq5PNLWnQ=; b=VMHpELkT4iqagep7
	YdozS7l70bC/XT0HgFA+NpozBWsZ5/Ppf3ggGHahYgZIzILG+BOf5rm0kqYCszgv
	9/egTBMBm/EwhpHh8VB0uTsmS7vLzfk/FXMcOVRrsEEXJ258/38XUFTLexJ5HBJP
	Fx3LG0lE6c7iLFmwu+AntH3HEeacwhHstVkiIK+Nn5vz/4q7rzp93Vz9viregNOk
	Er5wPH5DpaGkUKbhsQW+gxc+9D2lg7XVQ7K8vuMgo2q4nGIfZIrEmeEyPR2H5STD
	gEGc8A3xxAER7XAs7ihq1liOzND2wO0ue5V5zudds/EpilkQpXBzMtFF467LpmR4
	iRDl6w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8aad9ry2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 05:43:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c7a38429so386629a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 21:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770788613; x=1771393413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xaWScmkE2/GPwlOezPX08W6gzrXt1tL77aq5PNLWnQ=;
        b=i1oNJ2356jDbd047qqUawAczMPAJR4eARD0JX+E6F5TTYUHUzY7jy3KNrYo8DuIk3M
         RsPr/y/cqYPuZjUrTpQMAmc2TTlOkU/yonCz5eUFUVemT6xPHi0p2KoTffDJHGBipA9L
         sEw/j7HmB1Eow96QHgnBmS5Yghz5e+vE7QMQ/YbTtbOp3ppqU6HEIs3vT4CYXwvjqDj1
         E32qGZi/y9Q/pjEeAAwGv1jaVKEGH8K3tkH4XxLlB/ODE73YRHYWFMDwoqSrJK+pjv41
         ZPrkuaHs2xo4CvOjeOnFndcmZQrIimq22EdlcSqEQmZmPt5xPQeO8U/zBcGnozqv+55H
         qCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770788613; x=1771393413;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xaWScmkE2/GPwlOezPX08W6gzrXt1tL77aq5PNLWnQ=;
        b=YhBQBRAnEUXmHpI+zjxUMuEWA7g+dOGgiVyjf9vW1quDEu+UEkRoXt+8MIf8CVXRXC
         pBi3i5Lv11GwR+txMnLIUGRpJ1BISFkjhHO6lHp83HkzXksxwEWaFL2xlVeIfe1CKp05
         sSi0mnQ5aKo5m+oNIZn7EqZRKyuWxB1q+va3Cs61lsXbXA7APn4MLQwu2wcU4ytj8BAC
         w2CL4rdPAHDXy7PAYSOf9XsbRyo+eqKGJBLT9l5B7ejoHLOIuSdDvEiwJSU3ukGt8Yqq
         jFBHGr3j4VaRl/gZl2S36tI9WfWYSGI3EdCzlMX4G2Zfx+iHMND3qvM38nQDk1M4mheg
         kgNA==
X-Gm-Message-State: AOJu0YyDhv6d+EjynTTGJiebIk+lk3sqdq7XfhjqGpGBFE2jqXbNm8Vj
	Bm1zITwK5mvX9WWS8WMe8gHzIHrkrVNXfdrsk08O2WQzuWmv9Hu6J2d6J0fUD4vK+yrtIaJGVjj
	2c1NUKxehGKFjYj+dXO2SAiAV2/XeoHCF+uo2P2SxDzNEjaVE3jeuduOgMj2B+okvkOsNdQ==
X-Gm-Gg: AZuq6aIRApUyYQuKMEMNb+LALY1N+uGrnhXDA5eMQArtdb9rV41HZNmUKy85t7fzN1n
	vbvogUWqW9Qk8YEGylWzLC4cO4MKkO/6lNFV1MGNqH5RzdSwYNzFLMk376WwaRue+JyUrepZehH
	fReftqTwixfMunsTXfqLhGQeC64MvRiH4+nj58YOaIj5gcHg6qaonRDtZJijsdkBeKAgH9S3XLP
	a6mo10bMoaY3DGWiwMp1RgwZae5DYJ12cDrJteox/yliGuVpUDV1BwAInGVmPjNA5jRUVyL5uT1
	+EmU2t2JJj+dOcoazQWT1L65UF9gvhDd09TVgxzkmGx/wMZNdB1z/9lm8tgMFzxk94TGQtWz8UQ
	UJCmmP7+8Dx573rn8MLpA0fNk5dYQcyxL/k/emXsYqFskIh0j0jstnAJRFJ+OtZUUrq5xC26VS1
	zXERQyTUWqzkeL7Ly6rA==
X-Received: by 2002:a05:6a21:6194:b0:38e:cac8:f997 with SMTP id adf61e73a8af0-39415c9330emr4244346637.25.1770788612891;
        Tue, 10 Feb 2026 21:43:32 -0800 (PST)
X-Received: by 2002:a05:6a21:6194:b0:38e:cac8:f997 with SMTP id adf61e73a8af0-39415c9330emr4244317637.25.1770788612397;
        Tue, 10 Feb 2026 21:43:32 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567eba9b2esm890465a91.9.2026.02.10.21.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 21:43:32 -0800 (PST)
Message-ID: <badaf39e-6ab7-4be7-944a-cfc9d6757db2@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 13:43:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New warning `ath10k_pci 0000:3a:00.0: not found station for peer
 stats`
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de>
 <6a83fd12-edd8-4559-b7ba-75b074fa889f@molgen.mpg.de>
 <5c152304-853d-4142-8553-55cd8907f271@oss.qualcomm.com>
 <2c722676-98c6-4162-96cb-9bea06672153@molgen.mpg.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2c722676-98c6-4162-96cb-9bea06672153@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TMjpm4mqKA7TD6iJRRn9XOZYIJFwmPNH
X-Proofpoint-GUID: TMjpm4mqKA7TD6iJRRn9XOZYIJFwmPNH
X-Authority-Analysis: v=2.4 cv=OoVCCi/t c=1 sm=1 tr=0 ts=698c1705 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=cYQjjqCy0I3-0vQ9vjcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NCBTYWx0ZWRfX1LxjDJDOuiBq
 GkV2WiYt0AjF1xK4nwpMSy3VrI8F6rXAK3vmPFuZiTAPgEeQXLF6hxTsa7TRsFbsxBn7Lui7eol
 aF8PmyAzRScbUCzj1GNcARcEO3zlygOmHPQJHPa2mdUOPyJDf0m7d86LX/8akZLfACJGceLvMxj
 2Ld4OYqT8KaNc168iMNTj305LNmYx1YZl7Ap5ESfjzNQVlnPWE44KbGK9L4Ix6NkbLTtUjex++x
 uQhqRBy29+YIqRxL3ud79Ox0lv1CJK6zeeRu0MifksRJp1o9JOmmQAkMlkwbkPaGw+XzaWHt+rt
 84S0TntWrUcNn4C0kLlp6EmVCkrvtS91xg/ozmAv8Jw41LGsB8s9UIihi4mR/JWYiUPb2vDYgX9
 CnUPRgT1qo1gZJY+iC0D7v4m8Efvl0lBtdsBPq0Xp36Wgq/ApQMkY8El6/EF4Uuu9ePAHUEE7RZ
 xz0eF8ZpZ3fmwsIS1zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31714-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3356012177C
X-Rspamd-Action: no action



On 2/10/2026 6:31 AM, Paul Menzel wrote:
> Dear Baochen,
> 
> 
> Am 09.02.26 um 03:44 schrieb Baochen Qiang:
> 
>> On 2/7/2026 1:55 PM, Paul Menzel wrote:
> 
>>> Am 19.01.26 um 17:41 schrieb Paul Menzel:
>>>
>>>> Since January 10th, I have started seeing the warning below in
>>>> my Linux logs, that reach back to September 24th, 2025:
>>>>
>>>>       [   37.108902] ath10k_pci 0000:3a:00.0: not found station for peer stats
>>>>       [   37.108906] ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
>>>>
>>>> It started appearing with 6.19.0-rc4-00282-gb6151c4e60e5, the
>>>> version running before is 6.19.0-rc4-00003-g3609fa95fb0f, but I
>>>> do not see anything related in the commit list:>>>
>>>>       git log --oneline 3609fa95fb0f...b6151c4e60e5
>>>>
>>>> The warning log from `drivers/net/wireless/ath/ath10k/wmi-tlv.c` has also been there
>>>> since 2021.
>>>>
>>>> Do you have an idea? Please find the output of `dmesg` attached.
>>>
>>> Looking through the commit list from above again, commit
>>> a203dbeeca15 (wifi: mac80211: collect station statistics earlier
>>> when disconnect) probably introduced the new behavior.
>>
>> is this error seen when disconnecting from AP?
> 
> I attached the logs in my first message. But yes, it looks like this:

sorry, didn't notice there was an attachment.

> 
>     Feb 07 06:32:52 abreu kernel: wlp58s0: deauthenticating from 74:1a:e0:e7:b4:c8 by
> local choice (Reason: 3=DEAUTH_LEAVING)
>     Feb 07 06:32:52 abreu kernel: ath10k_pci 0000:3a:00.0: not found station for peer stats
>     Feb 07 06:32:52 abreu kernel: ath10k_pci 0000:3a:00.0: failed to parse stats info tlv:
> -22
>     Feb 07 06:32:52 abreu wpa_supplicant[846]: wlp58s0: CTRL-EVENT-DISCONNECTED
> bssid=74:1a:e0:e7:b4:c8 reason=3 locally_generated=1
>     Feb 07 06:32:52 abreu wpa_supplicant[846]: BSSID 74:1a:e0:e7:b4:c8 ignore list count
> incremented to 2, ignoring for 10 seconds
> 
>> did you try with that commit reverted?
> Yes, I tried it now with Linux 6.19 and reverting the commit. The warnings are gone now.
> 
> Are you able to reproduce the issue? What devices are you testing with?

I managed to reproduce this issue locally. Will submit a patch fixing it.

> 
> 
> Kind regards,
> 
> Paul


