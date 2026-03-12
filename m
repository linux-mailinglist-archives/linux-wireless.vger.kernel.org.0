Return-Path: <linux-wireless+bounces-33048-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEnVHDNWsmlvLwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33048-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:59:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD626D767
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E7B23021960
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C18E31F9BE;
	Thu, 12 Mar 2026 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REoL3Uhw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470ED31E846
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295153; cv=none; b=QxOyZPhsfXUu9OkoSO9Vc6aYkV/f/cqkc74jZkd6JJ2lejIWmpSf2cEQVojDGeE/90CkrF7V8+RXdovBk7KxcIephTGTLC3UnxZmV6gPnWi/0l7Zly2OZalDew8PDlWBRPo1KrF66msd1u75bH8BnHy0vxcHGm7p4iwLSvbMR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295153; c=relaxed/simple;
	bh=NLMMegbnQTHbmAF+7SbxSKcGy39ej+LeM8wtlSGWn4k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Z/DSkfFQJ91OnZRfQupdwTII+12r58szW9Um5GjcXgAz2ytgn+eX59TPWXUaxVUOKqFDUNrUUbVs1zuyWPRM+jqHvfyl0obL9JMaoWCZU2WcEva4MW3HYztUGN0ADGG0AE/vKSt2ekECWxnfDOcQmHsAE/rtHFKndwAu1nZSMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REoL3Uhw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439af7d77f0so510412f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773295150; x=1773899950; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MSnagWEumlAjQd4aKb/Z/ZIHp+uVB86nTpw0CtuMsU=;
        b=REoL3Uhwbsr6ma5LUE/BqQ/h9qH30yz12Mvrbd4mqAn+v+wdItZX2P/tc3dNkYqfnp
         O9ANvRbLhuo1pf7vAepChpfc/DDjZWCEU4DTAKOAZoBADYIah9ykg+lkN0MZN5i8PkaG
         p3vR40MCoHn4pMc0VdFVzzJAZx94USIYTIWOWdc3lsyZHjopi8vN7e5h+n1n/Gzm/JED
         v44YDGD171KzF37h06DSBYohMo6QVi3PCP5Rq/SS85dpeDHIzvDgQ6OtRU9n01c91zGq
         8ijvIscP4DVP81p6XorFj2tKs24LCrsD9X/EeD7PwbqiHrfB1nw+klIXT119/QU0nwYF
         /QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773295150; x=1773899950;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+MSnagWEumlAjQd4aKb/Z/ZIHp+uVB86nTpw0CtuMsU=;
        b=R+1B362WcKA5/4qQBbrdACgQOv/0AQra+gD4jOnJrHuNYg0N3MntEneVRBosIJzI3A
         k7XkDIDakTX7bmjk4pKYu7sWkZCKAPNpvgHtzatnz7i7XM40eXVBPsR/tsbkiunozgF9
         OBuQLjaV+kE2XIY1S1uCrQx0vmWt/QRlb9deuHE52qZtuEai3JuLfWNetmzCTBeFEkPD
         4OtEw6GucTHz00PMu2fcRntPUHC4L1gv7SNsxQUqXadZSawxLXWiCCLxC2m5BZiYuZz8
         vnvK13NFqurZqV993pCFrIBCNv5G88cNtA7VTq1iqgAy49NPdTHF2qjdnod+9TcY60A0
         G00g==
X-Forwarded-Encrypted: i=1; AJvYcCWdNNrDrfGC0er4sUb/ENj+nK+tCGfgRYzzB1NicxGdzYKKX30buW+AKkd/KRA4ND2vUY1rrxqyvJdP7tIVOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxloCR33Omf5ueyxuXBVHXrc45xeCxNqDjcpg7DJag8aFm3gVcM
	Fa6z4i4IcBFhg2jo5tbA716kjgH4HW8NrWF2e+J7DPzPDJnqHZV53WvT
X-Gm-Gg: ATEYQzwCSX3lhpaJpURYK7wcomXYxAH0NhIsbz8SlvnB5hE/zsO2vx8VZTOe5jzx/Wy
	QO5FkNaieAzZcHB13XBgNLqftpPxxd2IiqefpARuUs0s7pEOLwmmn4PToYm413Yk+vWru24+fpG
	c6p+nvpzyoNP1cK02SwLoN5rMP+03xrJz7Cr7awL8QVf/BKEDyTzlqLRSd4hi23Jx3tlPNvUhcJ
	fSZzHRzr6umR7gk16XdczFs9zvvx0y7LpdqGp4NZKd5e6dLoV+cO/8nfGwlhI8oQU34wM2HALg5
	0gkv6IaRu0mbilwGUTj6zNEMY7nN0r2aiuu6GeziZubNInSxCLfF+20j3YI1PLzcP33jxW9/4UK
	ZbOwGsvA9w4bxgpWj/tfiNkC/FScAykSrBh9KaIqy0F5sLom9GIEb2I7ahKt5JKYm2HVdyqSQjf
	Fd3IJXIfbxvgEwPLacaSsh3DBELUkbmRZtbqUe0X+ZlmmyPesf0Hhe
X-Received: by 2002:a5d:5d84:0:b0:439:b6bd:558d with SMTP id ffacd0b85a97d-439f842aab9mr9896146f8f.30.1773295149402;
        Wed, 11 Mar 2026 22:59:09 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c0b4sm5848964f8f.25.2026.03.11.22.59.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2026 22:59:08 -0700 (PDT)
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
In-Reply-To: <bac9b823342141bb9ed561ac5ccfd71d@realtek.com>
Date: Thu, 12 Mar 2026 09:58:55 +0400
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <62487266-6846-4E3D-9947-33CB6FE408BF@gmail.com>
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
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33048-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 15FD626D767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On 12 Mar 2026, at 6:22=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>> On 11 Mar 2026, at 7:05=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>=20
>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>=20
>>>>> On 9 Mar 2026, at 6:35=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>=20
>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>>=20
>>>>>>> On 2 Mar 2026, at 10:04=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>>>=20
>>>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>>>>> On 2 Mar 2026, at 9:47=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>>>>>=20
>>>>>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>>>>>> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the =
efuse
>>>>>>>>>> physical map dump intermittently fails with -EBUSY during =
probe.
>>>>>>>>>> The failure occurs in rtw89_dump_physical_efuse_map_ddv() =
where
>>>>>>>>>> read_poll_timeout_atomic() times out waiting for the =
B_AX_EF_RDY
>>>>>>>>>> bit after 1 second.
>>>>>>>>>=20
>>>>>>>>> I'm checking internally how we handle this case.
>>>>>=20
>>>>> Sorry for the late.
>>>>>=20
>>>>> We encountered WiFi/BT reading efuse at the same time causing =
similar
>>>>> problem as yours. The workaround is like yours, which adds timeout
>>>>> time.
>>>>>=20
>>>>>>>>>=20
>>>>>>>>> [...]
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> For context, firmware also fails (and recovers) sometimes:
>>>>>>>>>=20
>>>>>>>>> Did you mean this doesn't always happen? sometimes?
>>>>>>>>=20
>>>>>>>> It=E2=80=99s another intermittent behaviour observed on this =
board (and not
>>>>>>>> related to the issue this patch targets). It occurs less =
frequently
>>>>>>>> than the efuse issue and the existing retry mechanism in the =
driver
>>>>>>>> ensures firmware load always succeeds.
>>>>>=20
>>>>> This might be the same cause due to reading efuse in firmware.
>>>>>=20
>>>>> Though we can add more timeout and retry times as workaround, I =
wonder
>>>>> if you can control loading time of WiFi and BT kernel modules?
>>>>>=20
>>>>> More, can you do experiment that you load BT module first, and =
then load
>>>>> WiFi module after 10 seconds (choose a large number intentionally, =
or
>>>>> even larger)?
>>>>=20
>>>> https://paste.libreelec.tv/charmed-turkey.sh
>>>>=20
>>>> I=E2=80=99ve run the above script ^ which removes the wifi and bt =
modules in
>>>> sequence then reloads them in the reverse order with a delay =
between
>>>> bt and wifi modules loading, then checks for error messages. Over =
200
>>>> test cycles with a 10s delay all were clean (no errors). I also ran
>>>> cycles with a 2 second delay and 0 second delay before starting =
wifi
>>>> module load and those were clear too. I guess that proves =
sequencing
>>>> avoids the efuse contention issue? - although it=E2=80=99s not =
possible in
>>>> the real-world so not sure there=E2=80=99s huge value in knowing =
that :)
>>>=20
>>> Thanks for the experiments.
>>>=20
>>> Still want to know is it possible to change sequence/time of loading
>>> kernel modules at boot time from system level? I mean can you adjust
>>> the sequence in the Rock 5B board?
>>=20
>> I=E2=80=99m not a kernel expert, but I=E2=80=99ve always understood =
module probe and
>> load ordering to not be guaranteed; as many things run in parallel =
and
>> are highly subjective to the specific hardware capabilities and =
kernel
>> config being used.
>=20
> I have heard people about changing sequence/time of kernel modules, so
> I'd like you can try this method.=20
>=20
> I did ask AI, it said it is possible to create a .conf file under
> /etc/modprobe.d/ and use `softdep` syntax to ensure loading sequence.
> Could you try this?

I can test this, but even if it works it=E2=80=99s not a fix because =
modprobe
confs configured in userspace are only used with loadable modules that
have been compiled with =3Dm, not build-in modules that are resident in
kernel memory and compiled with =3Dy; and distros are free to choose how
their kernel is configured. NB: I=E2=80=99m not sure if there are any =
general
kernel rules for this, but I=E2=80=99d expect there to be general =
principle of
modules being resilient to transient host states and not depending on
userspace packaging to load correctly?

>> In addition, did below messages not appear in these experiments?
>>>=20
>>> [    7.864148] rtw89_8852be 0002:21:00.0: fw security fail
>>> [    7.864154] rtw89_8852be 0002:21:00.0: download firmware fail
>>=20
>> No, because even if we have a 0s delay between each group of modules
>> being loaded, they are loaded in series, so we workaround the issue.
>> Tweaking the script to background the module load loops so both run
>> in parallel would be closer to normal conditions, and I would expect
>> to start seeing failures and the retry mechanisms within the modules
>> (as added in this patch) being triggered.
>=20
> Additional question for downloading firmware. As you reported this
> issue initially (load modules at boot time in parallel), it seems=20
> appear this message by chance. Since this driver will retry to =
download
> firmware, will it successfully downloads firmware finally? Or it still
> fails to download after 5 times retry?

I have only seen firmware load fail a handful of times in many hundreds
of boots and each time one retry attempt resulted in success. To be
clear; I have am not reporting firwmare loading as a problem, it is not
an issue for me. I=E2=80=99ve mentioned it only for context, i.e. it =
shows that
a simple retry mechanism is effective at handling the similar issue with
efuse map.

Christian


