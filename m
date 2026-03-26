Return-Path: <linux-wireless+bounces-33921-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF/aA/DwxGnv5AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33921-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 09:40:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB9331803
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 09:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B71593086310
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 08:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4463B7763;
	Thu, 26 Mar 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3Qi70H3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF72346776
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514247; cv=none; b=M1dsbNqpE+w5MJImo5n+9EmVIczoqmVgdm3G3JMlbs/lx7jxmp8dwupb+UEysViAGLTW2pTfDEHRSoergr8zjBjyuz+R+gvVOK5NTWqQSfIGkVleaEU5LwT53fRSeZQop9Kk+2AmjeCXJRnF3fT6XyrP2iOH3LuLwArVJmW6ifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514247; c=relaxed/simple;
	bh=OW8dpdD5ph7MRv+ubT23o9wrynqhE1CeE5gPfMrm4IU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NMzfLHcVMwQ6Tlt6+PRosxcWmvVZwaHufLJMP+To8ix8g28BWcmXApSeolBRo6J2fERDko9MIfA1XnPq76doIYeIH/MUCN+JahXOoxaXezNSBRecXvyhOuoq74jvBi/P0jqyXNh/YFKAxwYSdWV9/BwHP/p6mRqt5PQaCagUo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3Qi70H3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b9b190easo430189f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774514244; x=1775119044; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV+/4YLQuUZVej4/BJJ/VK1qCWNO+yCpr5F0GFGmnXE=;
        b=r3Qi70H3O8gFh2GazprRU07w9bUc+mDrTZdOu9lFQ64EVpJMSPzfmaj9ShAPOUXvFo
         tKiZA1QypwE91ExPVAZmnzGw0Qli05liOFY9MQx9st8bIybv6AbuFcH+yb5FGNdlMEZQ
         NK0Jx3eAdqd1IQCmgtDiyOoS5t/vM036LIEjCakLawMYl2AyxkbQicxPo+cl8f+vo2RG
         nzvQVBEvT8Xy6l3R/53ig/vP29VeILUJSN8t0VlXJSnDEm7Gb6ta/iIKly7azo3OB41S
         YF5jSy1TiknTKGAG25PiOu90C1tvMegio/UvFCuzfSSbKb1z3a5LKQB35xbhdMH1BoqT
         WvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774514244; x=1775119044;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JV+/4YLQuUZVej4/BJJ/VK1qCWNO+yCpr5F0GFGmnXE=;
        b=emOWZoQNKEZCoqIuv65v//rc0vg4TpZtqVG9sO9+kGihQF/3KSLaFf7dBceS/9zxcs
         UVtTxlpFGwAq64qZA1XgLEiHPd12Txslkch0NoLGNDfi8pjjX6VYzWMBe/mmi585a3bT
         AQlVsD1w8ZOTtkzP7lmSg5jkc3t6XPRWxYcyE6pzKcTO7A9cgjtUiVQgXF5ECvcG7lKu
         JGdft14YXv9TOG7hc5bDt9E3sbJhvxhfborNfNC0dj7fYzATokLFgNf8dBsB1kwolJpz
         LuAXM4Vk/nDiVPncBQe2uqxoifXyADxWMBfVaHY5fG+gfqCH2j3ukP3o18HZZ72b8qDy
         FjbA==
X-Gm-Message-State: AOJu0YxjoInsgNZA7z0EvWcOu8cUuHnxAxWUdsUOYFLvzBZt2YDIX/pt
	g99B51twT+KFoFhFXO2MoA5NjAyDrC3I/KsB8xZZoKmzv+ve/iVtw3JH
X-Gm-Gg: ATEYQzwZm2TtEdW0NC09fVlGvECVIFERGsHHkK06fkvH/HrWV7aSeIf8Nr0KTANclc+
	vdsfXiVkzCJcHQxew6SidG7xs2yvzAXbkW2ChFsxMkzdZTyQO7B5Y50886tBC0rVwd/yePxN6Up
	TeqOXQhDX5vWwrs3AaEEsrbkiK9FViZNsTTMTHV3QmYTnY9lWOq9XCpIC6x0ibs5uIYAOVuSYYi
	DXIvc1ixfJbkPgEY9IYeDs9eoumgS5Wyqf3LH2G6+7jrxAD7OzuLUZulI6jb3VbQWxgjg8htArN
	aDesdJuTDEUiohWYP/TyaUGFeqzGBDd8nqEKmbOiXvU95pHbHwUeUjn7Ji90iVReFQ57EFbb3PV
	KNtOdtYz8fXOvBQyZexQnj6/gfRE7hHBLM2Tzgfjx30HDPhZxyizYIXjSIaim/CS/e9xLkxTdDQ
	54HS9T8Eg1t2HzVKUsanWYmcmllM1rSIdtvqxH2jElow==
X-Received: by 2002:a05:6000:2c0e:b0:43b:3e40:222c with SMTP id ffacd0b85a97d-43b88a0ff9fmr10481303f8f.26.1774514244238;
        Thu, 26 Mar 2026 01:37:24 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e35esm5942229f8f.6.2026.03.26.01.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 09:37:23 +0100
Message-Id: <DHCKSTJAAL99.V5V5D17RLHD@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next v4] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Rameshkumar Sundaram"
 <rameshkumar.sundaram@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317084740.3756880-1-nico.escande@gmail.com>
 <36c1cae8-d6c0-4432-bc8e-57216c5ea3fd@oss.qualcomm.com>
 <DH6U1JMUQXVM.287BFERLLK9KK@gmail.com>
 <40756be1-6a9a-4821-8c90-34f37db01e8b@oss.qualcomm.com>
 <ec266bec-c371-4ec8-a60f-21ebb810d38e@oss.qualcomm.com>
 <edf86c6a-fb09-4524-9b47-3061c3d6e68f@oss.qualcomm.com>
In-Reply-To: <edf86c6a-fb09-4524-9b47-3061c3d6e68f@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33921-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4EB9331803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 24, 2026 at 5:55 PM CET, Jeff Johnson wrote:
> On 3/23/2026 5:40 AM, Rameshkumar Sundaram wrote:
>> On 3/19/2026 9:29 PM, Jeff Johnson wrote:
>>> On 3/19/2026 7:35 AM, Nicolas Escande wrote:
>>>> On Thu Mar 19, 2026 at 12:08 PM CET, Rameshkumar Sundaram wrote:
>>>>> Or may be have this allocated on first device probe and free it on la=
st
>>>>> device deinit ?
>>>>
>>>> That seems even more involved. It would be easier to go back to the pr=
evious
>>>> version and simply, alloc it once per ath12k_base
>>>>
>>>> What do you guys think ?
>>>>
>>>
>>> Going back to that may be the better solution. It isn't nice that this =
current
>>> solution may allocate memory when the driver isn't actually used. But I=
'll let
>>> others on the team weigh in as well.
>>>
>>=20
>> Yeah, allocating once per ath12k_base is definitely the simpler=20
>> ownership model.
>> I was only wondering whether sharing it across devices might be worth a=
=20
>> look, since this is per-CPU scratch space and the table itself is fairly=
=20
>> large.
>
> The other alternative is to still have a single global allocation, but al=
so
> keep a reference count that starts at 0. when each ar starts it calls a s=
ingle
> api to alloc the memory and when it stops it calls another api to dealloc=
 the
> memory
>
> when the first ar starts and calls the alloc api, the refcount will be 0 =
so it
> will allocate the memory and increment the refcount to 1. when any subseq=
uent
> ars start and call the alloc api, it will just increment the ref count. o=
n
> deinit each ar will call the dealloc api. this api will just decrement th=
e
> refcount until it reaches 0 at which time the memory is freed.

We can do that, but we'll need a lock to protect this shared ressource:

  - The clean way would mean adding yet another lock to protect this, but i=
t
    feels like there are already enough locks in ath12k.
  - The other way would be to piggy back another existing one.
     ath12k_hw_group_mutex would be a good candidate to be honest

What do you prefer ?

