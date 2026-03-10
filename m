Return-Path: <linux-wireless+bounces-32923-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMFhNRBSsGmBiAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32923-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 18:17:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5472555B4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE3F9300C311
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2C3BFE5D;
	Tue, 10 Mar 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl65igSA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00153AC0E3
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163021; cv=none; b=EDRZKBdNibql8YN61PGEWd3zvSo92JW9Bz+yFXdB0CTjFVAB721ytTJ8Mb2h/5Rkt8l+W2sckBMDmIpF0ICfQIx4/UEg4WC7elaMlNrPDYYlSu41leh6BPCq14keu4j40uq7hPYBDsboCgSUbGhRecDmz4BNs9XS75IG4pxbgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163021; c=relaxed/simple;
	bh=aCSyyV2iTqdMRSEHHjAXiBWhc4+vtopz4y/kIpZ9G0w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sHGlG4i0/ntDH2hKjhJ/L82rYdhqTMEuNkMEAaHC4dqgo3W4lqWqjZH/X9dy42hEl+2AljJ24u/p5QbjFGwz0Ct4W/ptP0d8s0O451NL31DwoP/msxRGokiotNs4yOFamt4CLerptdGsoPixVc6u257a/Q/fZxEkknS7Fplc/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl65igSA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48538c5956bso1092605e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773163018; x=1773767818; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCSyyV2iTqdMRSEHHjAXiBWhc4+vtopz4y/kIpZ9G0w=;
        b=Gl65igSAWpSB1gwbxXhTvObokWMjO9oeg1RpBDe5CpWI05xdeRk41LfK9fdUkvxtDp
         5vWtfb3E6MiLH7SiQnOzuRmENVrQPKQhsLtazlavNbxmkI2tPrbbeIfVEhRC2M+7+fcX
         U779q0oiAqXi2AYhjmRsU3nIvoqotTdmDMzUKm3ykiFfODSeEKSQRHvzbDQXQ8MlW2iA
         KATM9aqG8Qpq1LKrpkmVRqUDOyKetwuZ4GHuk8UWRkM4urjiMmq4VqrNd3X6uZQoZGcz
         0Yo59oE687UDqAEyLG8rA+MtSJbwaSXtpn5B2r44w9qgJya1oEvf1MKJSMFKCbug0+rx
         1e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773163018; x=1773767818;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCSyyV2iTqdMRSEHHjAXiBWhc4+vtopz4y/kIpZ9G0w=;
        b=f1mKpz+aEJURkffZrKyM+QAHwBtLSgbZG+1YDjrq9FcMnT06Ce3FR4a1RYb70m87fR
         hQr8vbfJnfT0gun43chCX6Ppg9wlvPi68ZiYj2aVo7GoGCujI5EPpKDd79LCYcHSQLn+
         GlA1tJespwGVsVpvCZWEvk6gWXeR4ZuxZzQm8BXuSCIwLdPYB8qauysraUVUED7ShYbH
         MS48Kn142pk03BH3TdND6in43lwh5mBTQ3XouVkgIzGDwSHznc/H8lky8FEjkR52h2hh
         12AW17KA+DdpsOrjpGgGJlhfGn19gTgI8zZD/i8hDllYMIgpx6HdR1gwUpFfb3tVwV/T
         5QMA==
X-Forwarded-Encrypted: i=1; AJvYcCX+ySuxFS4GQkrzSqh1LFVKpPMsDVzt9i3Nl8s2PtLtjQk6/+34rDY6cPTI3sA5X4mkmE+GQNk0U0N5RL5z9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwV7SbvVYCg20XYfq+JKXivRxA1LVx3cF2rJqYrzodRStPbE7
	uru8PuWXIjSkP0gkqLMOlwcAOEOLnBILkb4oGd4KUHRnJNVHt35N40gq
X-Gm-Gg: ATEYQzy7vy2n64KtdlPN0q21hXlKyfZCHrHFMXAjPyzSNddRz2xk3sja0IufFSdHoHn
	ERxbIHlk26HXdrl9SKxS4AKdxt91Df4rShg9+JiuDhqwdEyUSzqC2sGfhlP1Gu8mkXtJmjTfdaC
	vEP443+I8pOF6oDXzCHORWFKcRlV1ufq0HMfUgCtp9DACOHTQGUa3kTh+MbWsMXoKb0p5LS5Hin
	yT+uV1AQT9Wfta4wc3z00sOsWs997l/NrrR6mJsndrxvEAyfPUJZEQJV9zPsJadd+sQqSHDVk5N
	htvyzWRu68x3R+vIsQY235WFZ0l8+hgHyuRMhdPeqqJt/Y84XyPqbGCYBKa4QFnsc0vYtSBxgzf
	TpXLeR0XxJztJ+lmwoZp5cwguEOrq1M4g28fO1u2T8Hc+Cj6DRqSAwI1dLQUeS1J6EqZHMUhpMX
	0cRY9bFA5/8fAVRwHFJQR3FFUNkoVCT0ua5xPvNU5s+CTRzna3CV4/VGQNjrnhwPpByypWpDBqL
	U9Ea5UF5tVMbC31Qk4X7jRULCI=
X-Received: by 2002:a05:600c:3f0c:b0:485:3c11:de84 with SMTP id 5b1f17b1804b1-48541a123f0mr61669425e9.14.1773163017742;
        Tue, 10 Mar 2026 10:16:57 -0700 (PDT)
Received: from smtpclient.apple (static.253.36.98.91.clients.your-server.de. [91.98.36.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485354f96fesm75106185e9.30.2026.03.10.10.16.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 10:16:57 -0700 (PDT)
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
In-Reply-To: <5ad1b7d20d1745bab0638d15731e7ccd@realtek.com>
Date: Tue, 10 Mar 2026 21:16:44 +0400
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC1F2CDA-830F-4351-A855-8C921B148F8D@gmail.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <c751f9505a664f6895bacecb62bc534a@realtek.com>
 <E6E752BD-5F3D-4F30-9820-CB44FA767E69@gmail.com>
 <c764f16a880a400686c8c5f639fa98c3@realtek.com>
 <903C7E52-033F-455E-89DC-B78C67C0C732@gmail.com>
 <5ad1b7d20d1745bab0638d15731e7ccd@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Rspamd-Queue-Id: 9B5472555B4
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32923-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,libreelec.tv:url,realtek.com:email]
X-Rspamd-Action: no action

> On 9 Mar 2026, at 6:35=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>=20
>>> On 2 Mar 2026, at 10:04=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>=20
>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>> On 2 Mar 2026, at 9:47=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>>>=20
>>>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>>> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
>>>>>> physical map dump intermittently fails with -EBUSY during probe.
>>>>>> The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
>>>>>> read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
>>>>>> bit after 1 second.
>>>>>=20
>>>>> I'm checking internally how we handle this case.
>=20
> Sorry for the late.=20
>=20
> We encountered WiFi/BT reading efuse at the same time causing similar
> problem as yours. The workaround is like yours, which adds timeout=20
> time.
>=20
>>>>>=20
>>>>> [...]
>>>>>=20
>>>>>>=20
>>>>>> For context, firmware also fails (and recovers) sometimes:
>>>>>=20
>>>>> Did you mean this doesn't always happen? sometimes?
>>>>=20
>>>> It=E2=80=99s another intermittent behaviour observed on this board =
(and not
>>>> related to the issue this patch targets). It occurs less frequently
>>>> than the efuse issue and the existing retry mechanism in the driver
>>>> ensures firmware load always succeeds.
>=20
> This might be the same cause due to reading efuse in firmware.=20
>=20
> Though we can add more timeout and retry times as workaround, I wonder
> if you can control loading time of WiFi and BT kernel modules?=20
>=20
> More, can you do experiment that you load BT module first, and then =
load
> WiFi module after 10 seconds (choose a large number intentionally, or
> even larger)?

https://paste.libreelec.tv/charmed-turkey.sh

I=E2=80=99ve run the above script ^ which removes the wifi and bt =
modules in
sequence then reloads them in the reverse order with a delay between
bt and wifi modules loading, then checks for error messages. Over 200
test cycles with a 10s delay all were clean (no errors). I also ran
cycles with a 2 second delay and 0 second delay before starting wifi
module load and those were clear too. I guess that proves sequencing
avoids the efuse contention issue? - although it=E2=80=99s not possible =
in
the real-world so not sure there=E2=80=99s huge value in knowing that :)

Christian


