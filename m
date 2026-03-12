Return-Path: <linux-wireless+bounces-33070-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIUiKHp1sml/MwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33070-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:12:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C3426EB57
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1828930055F4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5987133121D;
	Thu, 12 Mar 2026 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hodzst2i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB5314A7A
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303102; cv=none; b=R3fYdUPV5Y47/hCcBbcSxpPUCJCh4mAV0Vj1u672V1hU1eonxqepzWM4T6jVxB9JTSbc7bLjW9i9DRco9WRuje32vRKH2JQH8uX2JJZTY7p7GRD5VfUdwsxDdNzGeuqD7GvT2jstWiSLgKRQnsSarbGfb8OLXEuQYOlKRUoQXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303102; c=relaxed/simple;
	bh=aYP1Zk8ziXmo7It1ymihuYYGqI60lgoA+ejZjfkGNvs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Sp+JVg+nvzpne539WPkH8rjU/oNI9TIAglJMlbTkCV/2toOuIjxuC4RVzFNMSqaDBn6Ip66J30VL2gi6Y6uoDhEKE84Qcujh/8x6MYJeCZWs/5aK23/Z1kuplgh5VZr12GLv1aLghIoMQrRESbFWPGdp3UP5rnFy6atTWHAWF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hodzst2i; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso5571735e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303099; x=1773907899; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egv5yhqOwy4tUrlRNK/UI1RMs5MElmFcDPC+yXddIvY=;
        b=hodzst2i0//qYZGdjoR/VNKNOMySd6oAI3AkLuy5vO0gLOJXJ3gSp7xzxI1wexGneR
         70JnuZANp9dgzEqv0bU3YrDb20T7kGcEsO+4arZDLlTrLET+L9T4n2GeenQ2hArD/sZQ
         o396+1fkw8/aag44vG59/R8lCQJnnNlKbQyNXbZh8+FtIzzhYonLR2vW4ghtd84nCmsw
         +IMYocN1hr6c+3gPi8SFMIyuAj3jHp/zRB2wNePqlKAPXSnvzLpM6FMdCIuzxBnqKqxw
         77yoflKCbQAzhYdH7YlhUvuMQPbaovbdq+dtfOZyj45Y3YDlKHSmH2mapCt9g1hMyAgs
         0O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303099; x=1773907899;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egv5yhqOwy4tUrlRNK/UI1RMs5MElmFcDPC+yXddIvY=;
        b=ruzBDW3B+1dH2Vv6A0quFUi8Nw2T4fZWVQIkM4gxHxnQ8nNWSqe9VZwryFOGPIdmDz
         nde+A4gzOl4x0oPje1AFJNwDDUZ6qiU+19+TNty0kt5XUx8FLOlBJM+Vq4fubM/l9+h2
         AS95QFLp+9TluOeOTL8mNZzCQP/7G09OHVuIRKWyonI1Pwp1ntQx7qFlmtWBuWjq4UvF
         bQbGgtmeWEAL31En+g6m16zRYbBXPK08tdYF+59QU6YnUUAeWwQ9zJzmSCG+2yUlwRAV
         ph0yYIwQC1dnzz53BpxoQMj6L/KNIHQwFSeFtZW1W3v+fUVUzWF7q6yot7SyujMCrrkI
         Xh4g==
X-Forwarded-Encrypted: i=1; AJvYcCUohEg5nYGA+NFhZq7l74r+Rm6e8ATt979pVlFohf18ATb7rD2oBqKYpY6rhXCs2ThVmABRBallwH0ZRltYkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrWrMdUmHStwXALZJyIj+3nQiju+TC99qN4Gwg+ASFhKtCdZd8
	GSW9stbMW+JfkpOhPof4+o0EXq3DcuWprLk8lynQSybxdnydlKmVxrTi
X-Gm-Gg: ATEYQzy7nKc7Zqu0ZcUwgOhpSPPWe3vDZ0zsCeDFnfKn5YA9FEHyq7AyhzWowvI5P8d
	nlvI7Sx/77QlpcgPYCIWqQUOhZ6wJN3auAX/4NFPogmtZiq9uQ/drtFbvrsbLdAgOhFSL6aSgUM
	ooamPktbFFDqmobMmqMtHYPKqztn5zXFfyRKjZADtD0jmYJMpfkjfC03z8BAYj9jDeKP7SSHyzK
	oHMsxGASbf7qeoL7CIF4ziJq/w1Dt4WwTaaEFAxUd5TGY43P237GA0dxGxi683TeXiIHdPSGHiY
	j1pHoDlsqEtoJgoJAGXWV+g1/Uf338Erfs/CSaWgLHODhl/TZzzcR2zBXoX2fc2PIk9H93RBN3q
	/Wl/8SZKNmMoG7MG/jcaK6G7fpF+bWIsoAc5kO+jiRCNXR5OwUmBmYMh4b68JgZdnofQG2EGVGR
	tuqSbp7XUHQlwonxaFGwqsYw2Q/aKQK2MSiAk3jWfJDk5Us+mM28rYr5i5PkpvoL0=
X-Received: by 2002:a05:600c:8b0a:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-4854b12cf85mr88377465e9.31.1773303098508;
        Thu, 12 Mar 2026 01:11:38 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b899sm6339423f8f.23.2026.03.12.01.11.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 01:11:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <3f072307ed634e878c7d9da152801aec@realtek.com>
Date: Thu, 12 Mar 2026 12:11:25 +0400
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70E90B9D-4C33-46B0-92B7-46969F6AF7B0@gmail.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <c751f9505a664f6895bacecb62bc534a@realtek.com>
 <E6E752BD-5F3D-4F30-9820-CB44FA767E69@gmail.com>
 <c764f16a880a400686c8c5f639fa98c3@realtek.com>
 <903C7E52-033F-455E-89DC-B78C67C0C732@gmail.com>
 <5ad1b7d20d1745bab0638d15731e7ccd@realtek.com>
 <CC1F2CDA-830F-4351-A855-8C921B148F8D@gmail.com>
 <2ab692371ff94a3f960d41b04288a084@realtek.com>
 <B9D5D4CC-0729-4867-AD1B-18D80D78841B@gmail.com>
 <bac9b823342141bb9ed561ac5ccfd71d@realtek.com>
 <62487266-6846-4E3D-9947-33CB6FE408BF@gmail.com>
 <3f072307ed634e878c7d9da152801aec@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33070-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christianshewitt@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,libreelec.tv:url,realtek.com:email]
X-Rspamd-Queue-Id: A3C3426EB57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On 12 Mar 2026, at 11:39=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>> On 12 Mar 2026, at 6:22=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>=20
>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>> On 11 Mar 2026, at 7:05=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>=20
>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>>=20
>>>>>>> On 9 Mar 2026, at 6:35=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>>>=20
>>>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>>>>=20
>>>>>>>>> On 2 Mar 2026, at 10:04=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>>>>>=20
>>>>>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>>>>>>> On 2 Mar 2026, at 9:47=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>>>>>>>=20
>>>>>>>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>>>>>>>> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the =
efuse
>>>>>>>>>>>> physical map dump intermittently fails with -EBUSY during =
probe.
>>>>>>>>>>>> The failure occurs in rtw89_dump_physical_efuse_map_ddv() =
where
>>>>>>>>>>>> read_poll_timeout_atomic() times out waiting for the =
B_AX_EF_RDY
>>>>>>>>>>>> bit after 1 second.
>>>>>>>>>>>=20
>>>>>>>>>>> I'm checking internally how we handle this case.
>>>>>>>=20
>>>>>>> Sorry for the late.
>>>>>>>=20
>>>>>>> We encountered WiFi/BT reading efuse at the same time causing =
similar
>>>>>>> problem as yours. The workaround is like yours, which adds =
timeout
>>>>>>> time.
>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> [...]
>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> For context, firmware also fails (and recovers) sometimes:
>>>>>>>>>>>=20
>>>>>>>>>>> Did you mean this doesn't always happen? sometimes?
>>>>>>>>>>=20
>>>>>>>>>> It=E2=80=99s another intermittent behaviour observed on this =
board (and not
>>>>>>>>>> related to the issue this patch targets). It occurs less =
frequently
>>>>>>>>>> than the efuse issue and the existing retry mechanism in the =
driver
>>>>>>>>>> ensures firmware load always succeeds.
>>>>>>>=20
>>>>>>> This might be the same cause due to reading efuse in firmware.
>>>>>>>=20
>>>>>>> Though we can add more timeout and retry times as workaround, I =
wonder
>>>>>>> if you can control loading time of WiFi and BT kernel modules?
>>>>>>>=20
>>>>>>> More, can you do experiment that you load BT module first, and =
then load
>>>>>>> WiFi module after 10 seconds (choose a large number =
intentionally, or
>>>>>>> even larger)?
>>>>>>=20
>>>>>> https://paste.libreelec.tv/charmed-turkey.sh
>>>>>>=20
>>>>>> I=E2=80=99ve run the above script ^ which removes the wifi and bt =
modules in
>>>>>> sequence then reloads them in the reverse order with a delay =
between
>>>>>> bt and wifi modules loading, then checks for error messages. Over =
200
>>>>>> test cycles with a 10s delay all were clean (no errors). I also =
ran
>>>>>> cycles with a 2 second delay and 0 second delay before starting =
wifi
>>>>>> module load and those were clear too. I guess that proves =
sequencing
>>>>>> avoids the efuse contention issue? - although it=E2=80=99s not =
possible in
>>>>>> the real-world so not sure there=E2=80=99s huge value in knowing =
that :)
>>>>>=20
>>>>> Thanks for the experiments.
>>>>>=20
>>>>> Still want to know is it possible to change sequence/time of =
loading
>>>>> kernel modules at boot time from system level? I mean can you =
adjust
>>>>> the sequence in the Rock 5B board?
>>>>=20
>>>> I=E2=80=99m not a kernel expert, but I=E2=80=99ve always understood =
module probe and
>>>> load ordering to not be guaranteed; as many things run in parallel =
and
>>>> are highly subjective to the specific hardware capabilities and =
kernel
>>>> config being used.
>>>=20
>>> I have heard people about changing sequence/time of kernel modules, =
so
>>> I'd like you can try this method.
>>>=20
>>> I did ask AI, it said it is possible to create a .conf file under
>>> /etc/modprobe.d/ and use `softdep` syntax to ensure loading =
sequence.
>>> Could you try this?
>>=20
>> I can test this, but even if it works it=E2=80=99s not a fix because =
modprobe
>> confs configured in userspace are only used with loadable modules =
that
>> have been compiled with =3Dm, not build-in modules that are resident =
in
>> kernel memory and compiled with =3Dy; and distros are free to choose =
how
>> their kernel is configured. NB: I=E2=80=99m not sure if there are any =
general
>> kernel rules for this, but I=E2=80=99d expect there to be general =
principle of
>> modules being resilient to transient host states and not depending on
>> userspace packaging to load correctly?
>=20
> I think built-in modules will be loaded sequentially (not in parallel)
> by device_initicall(), so BT and WiFi drivers will not read efuse=20
> at the same time.

Even if built-in modules are loaded sequentially, the kernel still has
many dynamically loaded modules; and distros can configure that mix as
they like, so you still cannot predict or guarantee the outcome. That
could be changed by requiring rtw89 modules to be =3Dy, but that goes
against the principles of a modular kernel and I=E2=80=99d expect =
appropriately
rude comments to the idea if submitted :)

>>>> In addition, did below messages not appear in these experiments?
>>>>>=20
>>>>> [    7.864148] rtw89_8852be 0002:21:00.0: fw security fail
>>>>> [    7.864154] rtw89_8852be 0002:21:00.0: download firmware fail
>>>>=20
>>>> No, because even if we have a 0s delay between each group of =
modules
>>>> being loaded, they are loaded in series, so we workaround the =
issue.
>>>> Tweaking the script to background the module load loops so both run
>>>> in parallel would be closer to normal conditions, and I would =
expect
>>>> to start seeing failures and the retry mechanisms within the =
modules
>>>> (as added in this patch) being triggered.
>>>=20
>>> Additional question for downloading firmware. As you reported this
>>> issue initially (load modules at boot time in parallel), it seems
>>> appear this message by chance. Since this driver will retry to =
download
>>> firmware, will it successfully downloads firmware finally? Or it =
still
>>> fails to download after 5 times retry?
>>=20
>> I have only seen firmware load fail a handful of times in many =
hundreds
>> of boots and each time one retry attempt resulted in success. To be
>> clear; I have am not reporting firwmare loading as a problem, it is =
not
>> an issue for me. I=E2=80=99ve mentioned it only for context, i.e. it =
shows that
>> a simple retry mechanism is effective at handling the similar issue =
with
>> efuse map.
>=20
> I have this question because I wonder downloading firmware issue might =
be
> also a reading efuse issue. If so, retry might resolve as well.

Hard to know, but it's an infrequent event and the existing retry =
mechanism appears to work fine.

> As your results, it looks like to retry reading efuse can resolve all
> issues you found. What do you think?

The patch submitted resolves the efuse map dump for me. If there are =
more
efuse accesses that need to be addressed I haven=E2=80=99t seen them in =
tests. If
you are hinting to abstract things further I=E2=80=99d ask you to please =
propose
an alternative patch that I can test for you; I=E2=80=99m firmly at the =
novice end
of kernel contributors and unlikely to spot where changes might be =
needed
without being spoon-fed rather explicit instructions :)

Christian


