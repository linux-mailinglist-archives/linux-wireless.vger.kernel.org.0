Return-Path: <linux-wireless+bounces-32948-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CLbNpvtsGkaowIAu9opvQ
	(envelope-from <linux-wireless+bounces-32948-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 05:20:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2EC25BEA9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 05:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E96A30879FF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7228CF4A;
	Wed, 11 Mar 2026 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZfbicqF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CC7286891
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202835; cv=none; b=g1+FEO3APPYE8HDKqDNc7vHFvnNnDkAxi4ykR8QVVEh1FEkazQ4jnMnfzEKArbnLd/YNSEfLy8POoeJe4NJBfb7hWF7ambQzJF9+j+Y7M4omGGDJ1FNwwl5AcMMqxCoGy6Slc4A49uSVPQcWXMqEHEyBNVDgcGRDPmAy6MgoMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202835; c=relaxed/simple;
	bh=2ZsTp1IP1Pte0TzT345EUvC4QiGb9Wsf9k+EZZjlBiU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YEyBNJ1PrWMDiPehXE6GeailYha6CsN4b/tueOEHW331bpNVhcS00upMRe0dB445ghkXSyecxT7pSVqNbmQKfFPw+SQT40HiHdjGYayMGKKvjWdDcBEaaUZFLADluoNgjXCmO9kkuNtuIGnaehC4RfcUhCLTX6m+sglY9RfDM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZfbicqF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so44238455e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 21:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773202833; x=1773807633; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIUo63YLFVRvfaF5ty/1RRglNjaZo/S9cXK1lCXCSTg=;
        b=EZfbicqFdMnxmgQrsKvC4ZGT/YkJHE0m0772CQuL4qFVUr56uo2wd4lemPzLe2I2zR
         o8HklTgWX3xMOuUhZTKWAvt7+7qLEqziKg150SBM1z8xdCY+2ngUgY5sugreVXPzKF6U
         CbL0seqQr+fwJYCzhuzNV74a8ECTXiEZoiO9TKVGls/1bmo0+4ALX7jjVyoda5vorYb6
         K1A2shX8IwHAenEB3WzoeFcyrkUIsNYDg2fjoU7iPfLQcm21NkzYhi7+oEV7eD9gJcg3
         XeGyRnrVYExadyKEUa4YVQOwutLdSkivC0KCPCtmCJ+LyIQ19Ppa9ohdl+OqPl/akTrR
         Vodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773202833; x=1773807633;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIUo63YLFVRvfaF5ty/1RRglNjaZo/S9cXK1lCXCSTg=;
        b=P/zsFKlVhC32/i0S8ISDfc/IgxSCtRYKsGaYyg9ClmKIGHIKdN93ABFgkfXDFHKSgL
         iF64U6+CfgEcaXvzN91WFaqT2MpKPGmk/7BMJpLZ7g6FNR7V1a5g+eT/XFTZSVWvmCmz
         zh8zfeeoBlMNP6emkjEdv6lU//ZxRkNHjiVe5vhnrbppFCXZigZ6kVlE7ZmJ09A4iNoz
         JoKoSwFNXrCQqR45HtqUz6/4acV/DrDCFtAMFhBZHgo9SoObDRXn2KH1yxAFNMujVf4H
         iiHLFCmuNXPCx+mUK4bn3HPw3OFg9GG7S2yy0M2FErEpte27/LwDHiFXDJK+STGgeju7
         KLEA==
X-Forwarded-Encrypted: i=1; AJvYcCUwxZti+nyaSDdsf/3NZA7YcoLHITNfrF/tFpnYygrbhzo+br86rOQ/AmpitfZgxhftJgyj07bxYxvdkBxzQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/iP3F61617YRuWI4nmc5URgsmOIjDl0CUnSWlBmk7vk/rdDP
	SsWpVTr0J9w7UvOqtxFtMMhpZe06hqrzgcv2awIFH32vukKeqDOTu3WcbggSvite
X-Gm-Gg: ATEYQzwmecCgfqTnlaJwvrmps8kiFyrekTkdRVTQLd1DniTV+ij8XVjX+n5oE7LryoX
	G6WjJ29yJuQqgqazXHsyBloCAzPr2/bKreUaely49faPfeyjTRZPpFIdcplrOJELN85pUx68iPy
	CV1Clh+7Iy/92Xi8QuDVgBQSRju5Ss/VIyRWMaExocQOeU8XxS8RkEeWzzeGpzmn4USIX6DcLio
	hfZo7O7grPXy40MFgy+S9jG9T7jqPprY7iOgiyXnPF7DmYIreZo3y7s88LfgqOtEHG4weKgn1g/
	xs8zvsh4/p/e04aimXXA+gwGDtwqG4JFJ359C04gHMYp8fmbrzQ8KrVpZ6kABjqxIatKcC4sCVf
	pmL6wd8dEF5e5mtkbvbeljsHOvSZ9d85+9J7yDoQVDtOFaCN32JeDouszP6I5e7RnU65FjK1hMb
	6jQeDZ3og4KJbJxgTC7lnevvhg34lsxIeW
X-Received: by 2002:a05:600c:5249:b0:485:40c6:f528 with SMTP id 5b1f17b1804b1-4854b1573admr17945795e9.30.1773202832397;
        Tue, 10 Mar 2026 21:20:32 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6070acsm17046815e9.8.2026.03.10.21.20.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 21:20:31 -0700 (PDT)
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
In-Reply-To: <2ab692371ff94a3f960d41b04288a084@realtek.com>
Date: Wed, 11 Mar 2026 08:20:19 +0400
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9D5D4CC-0729-4867-AD1B-18D80D78841B@gmail.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <c751f9505a664f6895bacecb62bc534a@realtek.com>
 <E6E752BD-5F3D-4F30-9820-CB44FA767E69@gmail.com>
 <c764f16a880a400686c8c5f639fa98c3@realtek.com>
 <903C7E52-033F-455E-89DC-B78C67C0C732@gmail.com>
 <5ad1b7d20d1745bab0638d15731e7ccd@realtek.com>
 <CC1F2CDA-830F-4351-A855-8C921B148F8D@gmail.com>
 <2ab692371ff94a3f960d41b04288a084@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Rspamd-Queue-Id: 4B2EC25BEA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32948-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christianshewitt@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[libreelec.tv:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> On 11 Mar 2026, at 7:05=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>=20
>>> On 9 Mar 2026, at 6:35=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>>>=20
>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>=20
>>>>> On 2 Mar 2026, at 10:04=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>=20
>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>>> On 2 Mar 2026, at 9:47=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>>>=20
>>>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>>>> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
>>>>>>>> physical map dump intermittently fails with -EBUSY during =
probe.
>>>>>>>> The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
>>>>>>>> read_poll_timeout_atomic() times out waiting for the =
B_AX_EF_RDY
>>>>>>>> bit after 1 second.
>>>>>>>=20
>>>>>>> I'm checking internally how we handle this case.
>>>=20
>>> Sorry for the late.
>>>=20
>>> We encountered WiFi/BT reading efuse at the same time causing =
similar
>>> problem as yours. The workaround is like yours, which adds timeout
>>> time.
>>>=20
>>>>>>>=20
>>>>>>> [...]
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> For context, firmware also fails (and recovers) sometimes:
>>>>>>>=20
>>>>>>> Did you mean this doesn't always happen? sometimes?
>>>>>>=20
>>>>>> It=E2=80=99s another intermittent behaviour observed on this =
board (and not
>>>>>> related to the issue this patch targets). It occurs less =
frequently
>>>>>> than the efuse issue and the existing retry mechanism in the =
driver
>>>>>> ensures firmware load always succeeds.
>>>=20
>>> This might be the same cause due to reading efuse in firmware.
>>>=20
>>> Though we can add more timeout and retry times as workaround, I =
wonder
>>> if you can control loading time of WiFi and BT kernel modules?
>>>=20
>>> More, can you do experiment that you load BT module first, and then =
load
>>> WiFi module after 10 seconds (choose a large number intentionally, =
or
>>> even larger)?
>>=20
>> https://paste.libreelec.tv/charmed-turkey.sh
>>=20
>> I=E2=80=99ve run the above script ^ which removes the wifi and bt =
modules in
>> sequence then reloads them in the reverse order with a delay between
>> bt and wifi modules loading, then checks for error messages. Over 200
>> test cycles with a 10s delay all were clean (no errors). I also ran
>> cycles with a 2 second delay and 0 second delay before starting wifi
>> module load and those were clear too. I guess that proves sequencing
>> avoids the efuse contention issue? - although it=E2=80=99s not =
possible in
>> the real-world so not sure there=E2=80=99s huge value in knowing that =
:)
>=20
> Thanks for the experiments.=20
>=20
> Still want to know is it possible to change sequence/time of loading
> kernel modules at boot time from system level? I mean can you adjust
> the sequence in the Rock 5B board?

I=E2=80=99m not a kernel expert, but I=E2=80=99ve always understood =
module probe and
load ordering to not be guaranteed; as many things run in parallel and
are highly subjective to the specific hardware capabilities and kernel
config being used.

> In addition, did below messages not appear in these experiments?=20
>=20
> [    7.864148] rtw89_8852be 0002:21:00.0: fw security fail
> [    7.864154] rtw89_8852be 0002:21:00.0: download firmware fail

No, because even if we have a 0s delay between each group of modules
being loaded, they are loaded in series, so we workaround the issue.
Tweaking the script to background the module load loops so both run
in parallel would be closer to normal conditions, and I would expect
to start seeing failures and the retry mechanisms within the modules
(as added in this patch) being triggered.

Christian


