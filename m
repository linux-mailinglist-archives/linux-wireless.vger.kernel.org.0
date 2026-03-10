Return-Path: <linux-wireless+bounces-32823-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KQtA3vsr2nkdAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32823-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 11:03:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4624903F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7989830837D9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0D7251793;
	Tue, 10 Mar 2026 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK9cb3jW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6C35F173
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136590; cv=none; b=NRtn0WpM7/4i48ZEDMQ3khxGikwFZUKg1A6XkRTQVRNNQKRpN51uqnh7s0Wird9FBGGmDoqbnt18KVlIMMLpVIc4VwniHkqSbLAdiLWYQre021JX83pQ0giv3RY42/HD3wkZH1gfaXCvoGczk9aMcNMwjR/le91/sKkgc5VTu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136590; c=relaxed/simple;
	bh=GsAFYer1gPSRCtDYGGnHhpgi8TJ3073nKF2GR0SNX/c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LweQNObFRCJ989q6RLePGa691JHzW3aiLRc47iNQqIzLYRsOFve70+JS1TO0dY9lUxiNuVUmHV7P9xVx+8SMIjr1QuiDDVVtkquC7/lH0N4dL//v4esclVZ6bfFOqsel9efLRTw45u63daFBqndlUVFKjAYsMgA5lANjNJHkmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK9cb3jW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso10025139f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 02:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773136587; x=1773741387; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+QDzmjxHMtTeBXgcnvJGsDEHOK57cB0KyxE1y787/s=;
        b=AK9cb3jWcnKTP3t9V9W4Q9BtS7lnjQKQ6MnxWJY3dDMFbZXuSveaqnvV2SQsVoGrPZ
         UzwBjQ6V0D3LVsWwoVkg1zqFuPqe7MAI52fSGl10398qBgCyKm7o8Yrtp9aJBtlV8NNR
         jUe8/wwu19TqCSvTcFssO815op+nXzSEqCPlsEXttmXjHOYPH8DcI+ck9MOq1WeMe8rW
         vlW5sOxm+YYjfKesJ+Xd5ZZ1MWQXfmDacNQPIOEgq+qOO1huKnJBGjmm/5raKV7XEOjk
         9dEKZbjlIZXz7aVnsc0QkoZwk1NGcgxDi1OZvst9VBsFbdDG5y5cLS6gdGq3QI3tSR8M
         KGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773136587; x=1773741387;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+QDzmjxHMtTeBXgcnvJGsDEHOK57cB0KyxE1y787/s=;
        b=YgVUA4QJVBI2Ffbseut3MBW1WZVCvQmnOEP9w2Q8AlRav333JcMiWHLxMBh11fO/z2
         +b8+mlkoP2bB4m5t8T2Jq0QM+SqoAmiGMSqah+brckUvpZdPvAP1Mnf0WSoRzhBx6xbw
         95MJwD5lW2OR3nWHpmJP1Rzrt3TsJtBMWLPgip95ujBj31Y2Orfx5bK98bW42EGF3KqL
         IR2hsJZ5lYxszToNzCFfwWLzRgE/l+KM8eD4dACU5P5r+KUVO6iPDCEUTbUfNPDJeSrm
         mbkCKktS5AHyaq66rqwjreHrpgokVoX1HY5BSDHRLyOg1rAg1yLrWbtwUf11gw11MhZS
         MF9w==
X-Gm-Message-State: AOJu0YzGnYglZ6b6qnQ29EMN8XoyNgpjV6ht1bkAHVmqLvrKIhN+G3Yk
	NM25NhLMo3w+uwjjOR5VqxxnyzhALLAC3Bk8mKxHpG0mY5WKo/7+lGMO
X-Gm-Gg: ATEYQzxhSkpi7cG90H5FGYKxTmNUARCblwuhULaRcAD7gkAzL7Lnhnr/amtGJePM+o1
	+cJh69/XLZcNeaRDj7ctvpoL1b72NkmK9PWY7hNkhtdr5aaYf4mSlEZSop4hrIN+JGFb5igGpnq
	qzO3aZ/0mfsJrBW+AnwBcnIpllxlk42rcvF2wTH70lyCKcZnxrHbJk6bKZqgMMq5jW0RB1NTsYa
	yrQO+ju4LKqWIbv73ouWbDRNUjVALvhoZyoLClIGMWp3pEzSRYcxXql7VuO9rBIGM3yjfGEFVZ1
	W/CT3DrFNUei+NdM5VZFlr6P5tdKIiEKeT8Og2ji9BB3LrnBK68A8zp8D92krgZBxRomaV+FVNw
	7lDCtylpTHMWA2feOeufwrBJBIe4JonsaEFjDrPwLimdxGbzokncpqaFz3b8tRDUK/T/70xNwUh
	0zdkJjC0V6Bn7zp6asOurJqUgkLBICOLpq5NLLl2Qnpw==
X-Received: by 2002:a05:6000:40dc:b0:439:ba4d:bf40 with SMTP id ffacd0b85a97d-439da891a22mr26416182f8f.43.1773136586739;
        Tue, 10 Mar 2026 02:56:26 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3a20fsm33931715f8f.28.2026.03.10.02.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Mar 2026 10:56:25 +0100
Message-Id: <DGZ0GMD3VS8R.2ZZLQNJGDDFLZ@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid dynamic alloc when parsing
 wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260309152050.191820-1-nico.escande@gmail.com>
 <621ab5fd-206d-4cf9-b30d-cb9d6bc0459b@oss.qualcomm.com>
In-Reply-To: <621ab5fd-206d-4cf9-b30d-cb9d6bc0459b@oss.qualcomm.com>
X-Rspamd-Queue-Id: B6D4624903F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32823-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon Mar 9, 2026 at 9:16 PM CET, Jeff Johnson wrote:
> On 3/9/2026 8:20 AM, Nicolas Escande wrote:
>
> I have some nit comments...
>
>> On each WMI message received from the hardware, we alloc a temporary arr=
ay
>
> note that not every WMI message handler uses this pattern.

Technically yes indeed. Maybe if I rephrase with something in the lines of:

When we receive a WMI message, we need to extract the relevant data from th=
e
hardware depending on the event type. A common pattern is to alloc a temp
array of WMI_TAG_MAX entries of type void * in which we store pointers to
structs holding the actual data send by the chipset. Once it is no longer u=
sed
this array is then freed. This short lived allocation can fail when memory
pressure in the system is high enough.
>>=20
>> Given the fact that it is scheduled in softirq with the system_bh_wq, we
>> should not be able to parse more than one WMI message per CPU at any tim=
e
>
> add hard stop .

ok

>
>>=20
>> So instead lets move to a per cpu allocated array, stored in the struct
>> ath12k_base, that is reused accros calls. The ath12k_wmi_tlv_parse_alloc=
()
>
> s/accros/across/

ok

>
>> is also renamed into / merged with ath12k_wmi_tlv_parse() as it no longe=
r
>> allocs memory but returns the existing per-cpu one.
>
> note that imperative voice is preferred.

s/So instead lets move/Move/ ?

>
>>=20
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
>>=20
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>> ---
>> changes from RFC:
>>   - rebased on ath-next 8e0ab5b9adb7
>>   - converted missing call sites ath12k_wmi_obss_color_collision_event()
>>     & ath12k_wmi_pdev_temperature_event()
>>   - changed alloc order & cleanup path in ath12k_core_alloc() as it seem=
s
>>     it confused people
>>   - used sizeof(*tb) in ath12k_wmi_tlv_parse()
>>=20
>> Note I did try to move to a DEFINE_PER_CPU() allocated array but the mod=
ule
>> loader complained about the array size. So I stuck to the per ab alloc.=
=20
>> ---
>>  drivers/net/wireless/ath/ath12k/core.c |   7 +
>>  drivers/net/wireless/ath/ath12k/core.h |   2 +
>>  drivers/net/wireless/ath/ath12k/wmi.c  | 178 ++++++-------------------
>>  3 files changed, 51 insertions(+), 136 deletions(-)
> ...
>> @@ -3913,7 +3903,7 @@ ath12k_wmi_obss_color_collision_event(struct ath12=
k_base *ab, struct sk_buff *sk
>>  	u32 vdev_id, evt_type;
>>  	u64 bitmap;
>> =20
>> -	const void **tb __free(kfree) =3D ath12k_wmi_tlv_parse_alloc(ab, skb, =
GFP_ATOMIC);
>> +	const void **tb =3D ath12k_wmi_tlv_parse(ab, skb);
>
> checkpatch complains:
> Missing a blank line after declarations

Weird that my checkpatch (from yesterday's ath-next) did not catch this:
scripts/checkpatch.pl \
	mail/0001-wifi-ath12k-avoid-dynamic-alloc-when-parsing-wmi-tb.patch
total: 0 errors, 0 warnings, 0 checks, 807 lines checked

Is there additionnal flags or tools I should run ?

>
> Note that when __free() is used that this rule is not enforced since __fr=
ee()
> declarations should appear at first use
>
> So I'd separate the declaration of tb from the assignment to be aligned w=
ith
> all the other WMI functions

No problem I hesitated to be honest. And I think I prefer seperate declarat=
ion
anyway.

>
>>  	if (IS_ERR(tb)) {
>>  		ath12k_warn(ab, "failed to parse OBSS color collision tlv %ld\n",
>>  			    PTR_ERR(tb));
>
> that's it for the nits. the development is stress testing the functionali=
ty.

On that front, I can say that it has been running at scale in production on
around half a million devices for one mounth and so far so good. But there =
is
no need to rush this and we can gladly wait till you guys make the necessar=
y
checks so you feel confident enough with it.

>
> /jeff

