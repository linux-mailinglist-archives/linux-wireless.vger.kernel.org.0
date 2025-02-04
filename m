Return-Path: <linux-wireless+bounces-18412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D7A26F73
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 11:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4087B16744D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 10:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD26620125D;
	Tue,  4 Feb 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah/bp4rS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38820ADEE;
	Tue,  4 Feb 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665849; cv=none; b=KbFiVRsF+Ni5w8OhdK/ks157pyepu0cf3k20wARZzl1M7ueGYqtQ0TL49JnCpkeZeialdNbH9yTYc+/sV3nKh8+oNDJYwY1/95iD7xxIpmsQMZk0jgE8aCzwYPTlfsoJ+6ufjyYCKW2ylBRafmMB4OPb6oEL2U+ktJ4J4uoPZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665849; c=relaxed/simple;
	bh=FnlSQ301/+be7sD0TFrmBFg3fr5i6FZe2auLZGNlS0U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=m3rID64yurslEkpWABLv6F5BKMCGlFi6ehh4IBBk1Mgu9wVoR+vZR2ZjXmijoYxpb06vXK8Z0Plk7N15jtIgfNNbVN5Xwoz+1MdqU3Gtd25agGPb+oPtO1Kdcpacjvt44QTPji6hSvMkrZix3MGZz7zWyFNfU79+hGrfZSsaZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah/bp4rS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso33202435e9.1;
        Tue, 04 Feb 2025 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738665846; x=1739270646; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMArTWxNFUp4PQzCQD8slqPHvp/31eRbyPGy6SkB2WA=;
        b=Ah/bp4rSwp16VIdyt9FPsAODI1p7FIfEX39Ni3tABULuDYhnjrsGvKF4Je8t4YzzkF
         z4tikf1lTDHlkZ18JkrZ2kzE2lB/RqEwdT6aUeLgkSVqFoCoEk81D4IOcVs5NgUR92yv
         fXZFnqJDGJGbx6wdQEpjIyVBszgC3JWS47FbRiZvLdYdFNbf8lQnzwhy0mn0IkbSGKUf
         MN8Ts2k/B1Tq4ri/Rl9R3W+JKCC8DfKjznQR2pJXIhjbuNZDbT1Pe8rBpXcGsWeaA36S
         P6Mek6nXbrn3au+3fSm/te4+SPlIYIPNs5paxb3f73KjBb2HToWt1DSKfTkHAKtoUf9h
         Nunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738665846; x=1739270646;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lMArTWxNFUp4PQzCQD8slqPHvp/31eRbyPGy6SkB2WA=;
        b=JX39Mv9AqqT8RjwK35DeOhg0JIuzS8JIVdURTYZf1LS+Bb2ZwkEdoaDuxwd8X8l/JZ
         y4bI4s+MeLlJjJoTNoP9/q4HqbtSCiv8DIO8+cDo5UkIbH6VJxgsZY1LqiJeYtiynea7
         eEvGdP5SyZplt9B8eANwecqldbSjCtjWCrZ03hNzFWFQaFcqMbGlB1oEOmZPPajCyUid
         +wExdSbqmiHnoFfqpicognOsltuCVs3pNZ0WELpKzcobR9MRbZHqoWQrtovS3Ph90PZ/
         GhKQQbfHtVxuWY8PsGBbAakBGmq1YSkgQDcvfHV1yz5c27Th15TOH7kNNPrNPGKkTjyu
         /GUg==
X-Forwarded-Encrypted: i=1; AJvYcCV8f/hUcxb2PYG8wC3dTwPp7N37hlRZp/+QmLj2TiN5le92/7uXC2w4P58acogMZwdEWMcHd9d4MCg4FAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+FuFMyHAd9K4t/Q6l3ZzDjlUeMMPAcMiF/KB5C+xKUx8fI5l
	l/VIhHs9sgxdgoQWvvVwO2HmTAfPE9UyD3qbnZ1oHK6UGbg8fMpM
X-Gm-Gg: ASbGncuxipUFDtmaim0XDvn0noMJNhUKRF2L2J0pJ6mxvu+XxgenW0pRP5/EJnPfjB3
	RbIX9kEIALCo9QxU9FlB5Sg5kdNFnS4+k6uRVZOLu3LN6kqil+O1lfcTuhehJhQgvLdUUUoZHUG
	8IekLj9Wr7YxONvcG8rIxVV/e4m8f3cwbERqHaE7WYHaSKrH0n+/eRiP9wMWjKEkFmv6hWZ2xTa
	JqYtzgPZIFWcNPai+F5EXa71smaQv5gjh9so/tZJiX6NQQBZ9Rz4AW/fMFWNG0YP5ze5NMyG1NJ
	maSQzGYUv7OjggjKccMboJoYYSBetHSCjA==
X-Google-Smtp-Source: AGHT+IHsN8HTcCwIdZM+oqcLS8cPH93vMIT74gEgvRL+nbc/qsns8TrvV+nm1LCTJCegyuOBJuh5tA==
X-Received: by 2002:a05:600c:1f8e:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-43905f743f5mr19708595e9.9.1738665845748;
        Tue, 04 Feb 2025 02:44:05 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2e3a6sm228450075e9.20.2025.02.04.02.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 02:44:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Feb 2025 11:44:04 +0100
Message-Id: <D7JLLQ79FP2Z.2Z7VYLSC52A2U@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] wifi: ath12k: handle change_vif_links() callback
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Aditya Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>, "Kalle Valo"
 <kvalo@kernel.org>, "Jeff Johnson" <jjohnson@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com> <D7JKQ60C6EZA.24H639LLIG2U7@gmail.com> <076014d2-eaaa-44be-81fc-a8f1eb0c2ac9@oss.qualcomm.com>
In-Reply-To: <076014d2-eaaa-44be-81fc-a8f1eb0c2ac9@oss.qualcomm.com>

On Tue Feb 4, 2025 at 11:23 AM CET, Aditya Kumar Singh wrote:
> On 2/4/25 15:32, Nicolas Escande wrote:
>> Hello,
>>=20
>> When applying this series I am no longer able to start an AP on a DFS ch=
annel.
>> (I don't know specifically which patch though)
>>=20
>
> Thanks for reporting this. I think non-DFS channel should be working=20
> fine right?
Right non DFS channels are ok, only DFS ones, and not from the get go but a=
fter
the initial CAC, when they switch to operational mode.
>
> Anyways, I'm able to repro the issue locally. Let me investigate further=
=20
> and come back.
I'll happily test what you can throw at me.
>
>> After the initial CAC period I get the following kernel message:
>> 	[   45.248441] ath12k_pci 0003:01:00.0: cannot install key for non-exis=
tent peer 3a:07:16:d8:00:08
>> And then hostapd goes in failed state:
>> 	wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
>> 	ACS: Automatic channel selection started, this may take a bit
>> 	wlan0: interface state COUNTRY_UPDATE->ACS
>> 	wlan0: ACS-STARTED
>> 	wlan0: ACS-COMPLETED freq=3D5620 channel=3D124
>> 	wlan0: interface state ACS->DFS
>> 	wlan0: DFS-CAC-START freq=3D5620 chan=3D124 sec_chan=3D1, width=3D2, se=
g0=3D114, seg1=3D0, cac_time=3D5s
>> 	wlan0: DFS-CAC-COMPLETED success=3D1 freq=3D5620 ht_enabled=3D0 chan_of=
fset=3D0 chan_width=3D5 cf1=3D5570 cf2=3D0 radar_detected=3D0
>> 	wlan0: nl80211: kernel reports: key addition failed
>> 	Interface initialization failed
>> 	wlan0: interface state DFS->DISABLED
>> 	wlan0: AP-DISABLED
>>=20
>> Maybe I missed something ? Is there another series this one depends upon=
 that I
>> should have applied before ?
>
> No known dependency as such.
Good, as I have a few other series applied in my tree I was affraid it migh=
t be
something on my side.

