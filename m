Return-Path: <linux-wireless+bounces-32907-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GU6DQAusGlHgwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32907-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:43:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4442524BF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A4F6303DA31
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AD82857EA;
	Tue, 10 Mar 2026 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y39o2Zcn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UnKGcnya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAC264A86
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153552; cv=none; b=XMdyRhSt4oh4f0gs1YOuuyISgv6D6YCABUFv5bzC4C5aj+OZILcMB+TNasaHimafSHs6/ObxMg2zTj1JfUZZ17uXIM3IJ/5QerzwltSWo6TrzZwGyTP3QM4D4cm7jHoUKqBPlisuyaWlv6LLWFVCQZONsnu6gzXczJqnBn5c4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153552; c=relaxed/simple;
	bh=+lC3KWiu1iiMqUS6cBHAE7jIPOO8hJXBMcE3fccmIdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBxWywuApL7meQZHSuWxPjZVoEkqvzarH73PFxiNOztkrR0mEYogmhaSY1KcVp5EckT/Jp9exKugS6BxI2fMOsG1HaxlahK6qktmbBdeCxogRJyoDbrX1+8nx3VBzT1JWSWCq9MO5Z7XD1sh7YlJcm0M05sMsw1ZkIB2rtlCOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y39o2Zcn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UnKGcnya; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACnWGT3892720
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 14:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/1BrqlpE4ZhHPUd6Grw7WJ1SPZG0SYXSJN4gOgLU8d8=; b=Y39o2ZcnCpGZRsqD
	SjwwJXi8CceLWJvmhgS9Pc0mNe3yRVFahm83VRfOJkdU0r3yH3sb2cTTIdvt9YxV
	kenP0z4zRxKe3nf4/2bqbF8+fMLqFf0JZggzM5lrZHBd5kzc3leNd68y9h7BZF5E
	YoPWD7qJcaBTEA/jRsKhmqVl6/pR8VhtozayqHaZsnODX3Mw039UVQ4RfEnK5e3p
	HkXL3ndrmZNkaJY/n4ECh0xxS1X5nwxVus+/YaV5h92CPwK/bIK9/j6ewYy1s+SY
	lfeO/gNAmVavHZVnckWuwNbqy0g4HpMvWfXF3ooSnB+HlYjN9cHlOd6VjlHh+aJL
	WwTFWA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmyrdx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 14:39:10 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c7afa9e0so119233172a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773153550; x=1773758350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1BrqlpE4ZhHPUd6Grw7WJ1SPZG0SYXSJN4gOgLU8d8=;
        b=UnKGcnyatlSvovdFyRpwKb27jrYZ3vEFToEQnz6nACKemr97vhA2K4l5O9w0rlbN3I
         BlfzefxgQ6NN37PJeXIntXI3FY0wwIPK5AaAHSq8DYZ56HD9bx1+uGvYFhFJlI5Ldg9i
         MKDk307eQXjhMvf86NT12CXAHZ/nUlkQ0EJ+p1/QQ8A/Epft3otEhokahPThkjUD1ZLB
         6cV8319S8mVzdS0JVdtoereISDRG4KBIh79ImOKKskE03aTsdOatine8PO2jIpEsKdZG
         5GGxNLQK4p3SGziyp/tPoZbzk1AmOFaArxqyXh3G1bpJ/q/hR/DROfuE3aJeTqTbV7qx
         1lWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153550; x=1773758350;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1BrqlpE4ZhHPUd6Grw7WJ1SPZG0SYXSJN4gOgLU8d8=;
        b=R42lea8AwTIUtYGUacxxxG7KL3tGSc965GehobNyIwyxURvZKndMynkGMjHqfqhIgs
         anDkqT7cuuJbWnrxptJnDaRryOMjuXVKMrQwiFGkEuEot90Hbmn63BRIriMRruQcRA3u
         MjIZqvoM4Fwjis/A4+h+Mcxsk3fI7tADnzvwMUYVgr3WnU4Hrhb+xImoSNkabPuHbRVu
         INlXo8ACIPuiC9PQKTiiu+fCePI6wWLp/6XLPdPhanz+z6UdijQDaxPXueBTX+Nrgy2i
         F/Ra1vgGQhMBOUvvcrKTvGMYEvswxs/h4p9ubvTbZFGrjfWIAttYd/u1xDorpq6/+Gfo
         3lhw==
X-Gm-Message-State: AOJu0YxrgNro0kpZkWXDSX3jqia4UraWyjhBzW4vdgfzVQayPhatTVYa
	tUf222YQ6O6+1QDjKbUZF+ct7001LcyPioYw/JZPKGdQ2JF/KaNz3Isy0u6JWBlRYP49XPBfTe/
	HykXlZ5NPIN/H2EP/60QA8PNH9CX1qW2jrygWWy1P3TNIyJPwDxKXpimjEln4eVp7DW4hm5pDqd
	s8WQ==
X-Gm-Gg: ATEYQzxACPleBJsibB60Cp+k4gBRuJJSkT54bLUqsGqxySL+DqFkxWfgjSDUNRfmgx7
	uTnMimooDObLwryjYx6jmTVeK1PUq4N1JUEKpAnyfSG8JHkM5kth7wmrEx/lfpfsPbRVdFiVL/W
	ooCk8KBiR4xnqUOldH54lK1N6/R+0afWO8QRqC1etqe5YMDdv8yydXFTqJQNl4h5jCEe7uIYspo
	x31bWB+uYIERBAEg4G9QtfxtRdauqtj5RGGGYCUTaLKcAjQ2nZ1gskPyuMc8ytYv5tYDGnE96qu
	jAihHsw1u6n8dUuXLmO+gDB9lkIwAr/A5dTMPfYohKYbVbc7Xq0fx+K07zETMyubj54t7FyYLEe
	s7XCf/y0zUhYfVqpHVz30MGDTnRnrainqpp5+HsPuQZPBufaWaPIZFzr6KBn/JhH30jDglF8+WI
	czhvyfvg==
X-Received: by 2002:a05:6830:67eb:b0:7d7:443b:5679 with SMTP id 46e09a7af769-7d7443b658fmr5354929a34.29.1773153549658;
        Tue, 10 Mar 2026 07:39:09 -0700 (PDT)
X-Received: by 2002:a05:6830:67eb:b0:7d7:443b:5679 with SMTP id 46e09a7af769-7d7443b658fmr5354918a34.29.1773153549254;
        Tue, 10 Mar 2026 07:39:09 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d75ad31186sm2198873a34.4.2026.03.10.07.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:39:07 -0700 (PDT)
Message-ID: <720953de-6015-4189-99c4-00833dee2acf@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 07:39:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid dynamic alloc when parsing
 wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260309152050.191820-1-nico.escande@gmail.com>
 <621ab5fd-206d-4cf9-b30d-cb9d6bc0459b@oss.qualcomm.com>
 <DGZ0GMD3VS8R.2ZZLQNJGDDFLZ@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <DGZ0GMD3VS8R.2ZZLQNJGDDFLZ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b02d0e cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=_hkKkB08e6F3NJ6brV4A:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: I5kb_ccTKMK3mClPflP5ySqfFlEVMfR2
X-Proofpoint-ORIG-GUID: I5kb_ccTKMK3mClPflP5ySqfFlEVMfR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyNiBTYWx0ZWRfX3hwhVNUHlz90
 sqoaUbqgQ2mbsitcx5LTV1+dv7TuUAh6Yr4raggA/pLafHmAivNSpxByINS2igU4Nug9zLhRQtW
 /vzaUHTXePWw0ObH7lxb9zeug4OgTCpMYaiTTE4b6EgwMANSQZKKienavBzChkUElv7zM/aLd7r
 UyAOLQS8bP9ZITE3s5J1NtXImhdyVz7+07ahiyTfcXFOxw5mpfLMnwDc1kKF8X8xHrgsSsG1HRS
 KIph8prCT8sCc0Fm46iwWhP3n6uf9PSYEuunYFCigeJHJPkXbb4wTzJh7KyyXUkJTDatcQ3tAP2
 CIcivJGjru2JoFJzaDfnwFhqLMZCuLn9A1k7gPjAC0SdMZXo4QGWWbIVyS2E3wInMmzEUAApdmQ
 rgzqSc3AZoaXmN6CLh3d9h3ZnNRbZZXEBz6tGCpz7WoBNPYEVPjQCQ2DGU51OtabfLRYhXCRfdS
 bKJFzU/OTf5szVFtDQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100126
X-Rspamd-Queue-Id: CA4442524BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32907-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/10/2026 2:56 AM, Nicolas Escande wrote:
> On Mon Mar 9, 2026 at 9:16 PM CET, Jeff Johnson wrote:
>> On 3/9/2026 8:20 AM, Nicolas Escande wrote:
>>> @@ -3913,7 +3903,7 @@ ath12k_wmi_obss_color_collision_event(struct ath12k_base *ab, struct sk_buff *sk
>>>  	u32 vdev_id, evt_type;
>>>  	u64 bitmap;
>>>  
>>> -	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
>>> +	const void **tb = ath12k_wmi_tlv_parse(ab, skb);
>>
>> checkpatch complains:
>> Missing a blank line after declarations
> 
> Weird that my checkpatch (from yesterday's ath-next) did not catch this:
> scripts/checkpatch.pl \
> 	mail/0001-wifi-ath12k-avoid-dynamic-alloc-when-parsing-wmi-tb.patch
> total: 0 errors, 0 warnings, 0 checks, 807 lines checked
> 
> Is there additionnal flags or tools I should run ?

The difference is I run it on the patches already merged in my workspace:
scripts/checkpatch.pl -g --codespell --ignore COMMIT_LOG_LONG_LINE,FILE_PATH_CHANGES,UNNECESSARY_PARENTHESES --terse --show-types $base..

