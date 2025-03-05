Return-Path: <linux-wireless+bounces-19802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169F0A5023C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C1A7A4A1C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0602E3396;
	Wed,  5 Mar 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/NAKztO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDF24C668
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185400; cv=none; b=jX3lc1Ovs1f7eaSg7nhZbAZDyaDrjsatbuyV1emkDzBS7Xjm0rHI0y0cmA9+XfLtcsOdy4uNhLayUgiMAIH9aFRQuUOyD5eJnWhXf0ClVp+qS6NPHchWDRnVZAgWZ++wslEheWwXYNSuajfSBkfFc4X6jc2Wmq/OuV05ByTz+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185400; c=relaxed/simple;
	bh=5IgaVZTlZg7HUMMetQLK8DMimxZYly0RajaV4mNkN0o=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVIzWs46fs1VFRMpeGFo2Vk4ETlN6BsH0uWL00+L7NecQ8SiGN4ttWeGJY8NBadC3OnpZnsEx70h9h6wjmQ+K7FN8wUukGpYcVipKUl/JJsh3bBpRjAUtZy0Ajt4RPlrzJoovVQ6eMcw8o3fEpK6SYAgtBJuVE7bqrtOFkZ+ymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/NAKztO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390cf7458f5so6373855f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 06:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741185396; x=1741790196; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i7jjDoZNjQDRce1jkyEJk/NjJu1KreQImrPOlxFDeYY=;
        b=B/NAKztODF6P8rk304ukYHmNaVYeX+4W4bmtujjneddcC/c7r8Faqij1aYzK2qVK1o
         mrZSXOuY81C9Qid4Z31zkHwCWMnuGVvw0E0P+b5F/DXKpOzEJTFq7R+isVOUkgbaGS/g
         pqID4vhWRY7xItHZ+OOvx2oaLFLf/9XmnNvfqb9YwZQKl92Jd7qA7dtNSzr7M5LACqoz
         IA8EyRHHC66+M222HNpA9ISOUBqpqseWuKTd9eQ6PEZd5+kyZ9aaYC/1H+WmDLYqbwlh
         b/FF0LbHoskXIRudUYamQXUNuA4ZnS8TuC7w/qEpnsXnZfaNsSBDHgls80sVGbYJVrYF
         HwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185396; x=1741790196;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7jjDoZNjQDRce1jkyEJk/NjJu1KreQImrPOlxFDeYY=;
        b=RF5s4BSzhnZkjQRiihJbEfiiqtw2xjV0mhKwDYxYYL5SDjysQkwB2vGSKCi6FRfunA
         ea0ZPuefJMDI57q5ad17+qBh3iCWM201P4leB1GTcubwJVYeDizRWB/q+OCMCVbHGibt
         UTDJoW9suWOOLNHd9wbRfC2+gD3IaH+zkyhuFAn+1DapWGO8ZtJTt9Io7NdgUNnamlD4
         euwLIQxAoajXnbUavmE3076pP8znlVPPHMYulDeTgmqhwOf2zCOA62FK6FvFjJQM2+g/
         IWITFOZfrj/FwztoHwn4wSPtrgHoxJrdAlAX1f+ZjVtkjqEXDmvkZXKxHHCEU+iCrxYW
         8ZJw==
X-Forwarded-Encrypted: i=1; AJvYcCXAIVIctf91AcH03Rk7unJRqHvEakmhDt2Xsi/Ly1g9QMLcdr6CwamnEBj1ic0AeGZnFlXRe2/nTWdSovGUpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfyoPRHLPnJxpcRILmvZtWf73qTqfVqTfFG+W/2ogDEYrcOU9
	ChfSmQ1WA5HdBUIP4jyTkfXN5g/p7/rOgfn1KrphY+3ja/lzgJA=
X-Gm-Gg: ASbGncuVGo0mlvJ8BcL38tx4gL5H++UUMbzESDBZQ3WNhr7zWJL+Z7JGgLxcSs84R4P
	qCOp+nap9SmF3I2MRXc2kiPa9tcaL59waYeKCoQe34ijLTaNNGfKoam6PQ7e5gcKuD0faExFJ3d
	mu8kZ/CuHQzjUEqaMTDCe090DdBZrBH2kr2nxuA7mtYqglb7ENZoeQXCp/O6ATb18ztGrtidnlq
	sHP16L76w4ptgxK3W2ivHOYpZ0igTVs1LCJhZTMKl7V6+7Hp/wOmyDx0iCrIUMs8bCewHpuIqW0
	GXzpbp74rt41oEUu3qBN8TFedvZrFbkhZjx7MPmSisRS29L33+KB0zNLs5Zjv9wue5bVWpsaxX8
	rkNJpJJqux4niRhVs5iBv2kt8d+JAoJU=
X-Google-Smtp-Source: AGHT+IE3Qs9Bs5kmWpTS/4yoK37XKbCf3KtKCoYRap05OEUrWsdZOfwFNkdjZXY6TMgJl4GUAkx6bQ==
X-Received: by 2002:a05:6000:2a86:b0:391:253b:4050 with SMTP id ffacd0b85a97d-391253b435amr1582874f8f.51.1741185396137;
        Wed, 05 Mar 2025 06:36:36 -0800 (PST)
Received: from winhome (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net. [86.18.22.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c55f2sm19111485e9.20.2025.03.05.06.36.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:36:34 -0800 (PST)
From: <rmandrad@gmail.com>
To: "'Nicolas Cavallari'" <nicolas.cavallari@green-communications.fr>,
	<wens@kernel.org>
Cc: "'Dennis Bland'" <dennis@dbperformance.com>,
	"'Ping-Ke Shih'" <pkshih@realtek.com>,
	<linux-wireless@vger.kernel.org>,
	<wireless-regdb@lists.infradead.org>
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com> <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com> <ff6ad414457e4b1cb68e834978a553c3@realtek.com> <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com> <002d01db8da7$daf2ed50$90d8c7f0$@gmail.com> <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com> <319c9de5-e26f-45c0-9200-747c86bce303@green-communications.fr>
In-Reply-To: <319c9de5-e26f-45c0-9200-747c86bce303@green-communications.fr>
Subject: RE: wireless-regdb: Allow 6ghz in the US
Date: Wed, 5 Mar 2025 14:36:38 -0000
Message-ID: <001a01db8ddc$019e8890$04db99b0$@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQMUrzCf8XdNoAU6+fu4ECJnDc0awgHIktuQAg9ms7MCOQTCTwHce3oJAeRkceYB16Yw4bCVC4QA

See below


[1] Beacon Hints
" cfg80211 has a feature called beacon hinting to assist cfg80211 in =
allowing a card to lift passive-scan and no-beaconing flags. =
Passive-scan flags are used on channels to ensure that an interface will =
not issue a probe request out. The no-ir flag exists to allow regulatory =
domain definitions to disallow a device from initiating radiation of any =
kind and that includes using beacons, so for example AP/IBSS/Mesh/GO =
interfaces would not be able to initiate communication on these channels =
unless the channel does not have this flag. If either of these flags are =
present on a channel a device is prohibited from initiating =
communication on cfg80211."

...

" It is also important to note that the Linux kernel beacon hint =
mechanism only trusts beacons from 802.11 APs, not Mesh or IBSS."

[1[  =
https://wireless.docs.kernel.org/en/latest/en/developers/regulatory/proce=
ssing_rules.html

My experience is with Openwrt and APs. We have users in the US =
complaining that they can't use 6GHz due to NO-IR


-----Original Message-----
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>=20
Sent: 05 March 2025 12:19
To: wens@kernel.org; rmandrad@gmail.com
Cc: Dennis Bland <dennis@dbperformance.com>; Ping-Ke Shih =
<pkshih@realtek.com>; linux-wireless@vger.kernel.org; =
wireless-regdb@lists.infradead.org
Subject: Re: wireless-regdb: Allow 6ghz in the US

On 05/03/2025 09:58, Chen-Yu Tsai wrote:
> On Wed, Mar 5, 2025 at 4:23=E2=80=AFPM <rmandrad@gmail.com> wrote:
>>
>> That is not specifying NO-IR which basically is denying any 6Ghz in=20
>> the US what it means in my opinion is
>>
>>
>>
>> Client devices (like phones, tablets, laptops) need to find Wi-Fi =
networks before they can join them.
>>
>> One-way devices do this is by sending out probe requests. These are =
little "Are you there?" signals that ask nearby access points (routers) =
to respond, so the device knows which networks are available.
>=20
> Section 122 says: The Commission therefore only permits a client=20
> device to send a probe request to an access point after it has=20
> detected a transmission from the access point. The client device will=20
> be required to send the probe request on the same frequency as the=20
> access point's transmission.
>=20
> I think this translates to "passive scanning only", which is what=20
> NO_IR is meant to specify. NO-IR was previously called PASSIVE-SCAN,=20
> and was renamed when it was merged with NO-IBSS.
>=20
> Maybe the kernel's implementation needs work? I'm not a WiFi person so =

> I really don't know all the details.
>=20
>> That is why drivers use the non 6Ghz for allowing clients to identify =

>> the router has 6ghz capabilities=E2=80=A6 I don=E2=80=99t think is =
for wireless-regdb=20
>> to take over the HW router compliance and certification which is =20
>> what 122.  is about
>=20
> No, section 122 is definitely about client devices, which is what=20
> Linux devices are.

No, Linux also supports access point, IBSS, OBSS and mesh, not to =
mention monitor injection.

If you remove NO-IR, you are allowing Linux to create access points, =
ad-hoc and mesh networks on the channel without conditions.


