Return-Path: <linux-wireless+bounces-35410-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h7nRJ/XS72l7GgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35410-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:19:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F04CA47A923
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73B6E30515E7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E560134F48C;
	Mon, 27 Apr 2026 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qr3/dw6p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93B35F603
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324785; cv=pass; b=Z1f0Bbl9CX9xMhiXZxpk3o51IS0KnvLeOLOYfRzC9bdpasnKIr3TnUqUBFEX3cSqCg4Ax3iRGFiltwsg2rTh0KHOqO/g7h7UTPD+CXQou9uQ3eL6QVWtI4AaQpAWEtVqQ+S3lkfVa2LNRfRh4IMsb8Ly1ZVj0W5G2hWBkiKUejw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324785; c=relaxed/simple;
	bh=2BllAnidD87wto2W5qLVWF5k/veO0cypHwEMVJ4aD4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZF8ygY0b/llkjRv5ZwRnwZRBs+y8SwPtl5cnV9TeCai7ca/XZhF3Gu0+fEEv5JdRREjMrZgQQjOk6VsSn9ZF+pvsgJLiq6I2KZafdazFXvwvD4T6eZWrgXU0ZSa5TF9olBf6wkJW5hzv9QIeGqXq08IiqQczA0ouKUor7UTsS0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qr3/dw6p; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40423dbe98bso4627989fac.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777324783; cv=none;
        d=google.com; s=arc-20240605;
        b=ECHmv+bu2o95NrDORymBeGKe28O4kA5lQs+uxY5Lkvwq1+ed/1+lKMgRqJez0IEPJb
         Sq8UlIOzMbLL4mRMpnb4YO9Y/l3NAnrophzVchmc8ArO4nkmTKzU9wEjk2ICJ0hQARkp
         cr21vfDa/9/E1YA+WhAvdrf/RMC3daxFYUTwgII7QZg2mhyO/j35eNyZ9di/9PKt/47x
         ej1ulVAQl90DXz85DAPkrP2Sfwol3XasqQsHFWDc4gdJO5PAOOmaetSc0d0XrBCkgZSj
         mqSe23+h3eIjGkcoGa5G4AA16hqiYicUN0c0geVNuiF1Yhb3lo1DflVo6uq9oV1n7q0s
         ILoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2BllAnidD87wto2W5qLVWF5k/veO0cypHwEMVJ4aD4M=;
        fh=TwbJP0L76GiTtKk5f4fkkqDTWBCdXvBY837Be+FR1MM=;
        b=INHjaPPDrmdy1h78e0gT1zTUuvCrdvf6lJDBgmxuucs3Zr/DDl6rEqkcGTT7dHFdmi
         6U6vQMze3zs+jX7bjvuvN3bGuDKLlenHlSE6LZ57DZPmspFcHwoLlcKvddUmcQRv5hOj
         21p3YqTGf+bJot+5IG5aInf/Ae8f27FJTwMH6SMK2gCtXso0deOo4zt57ACwym1GbRY5
         ox+HHd/1wvFU9en1nxzMggDfUvU52nk7P6aBTP1t+h4crcY+0xDGrMKjjxZRMVeu4p12
         Kj0NywnoytFeL6VnXIH6hM8jPI3EHmuOPyXLH4ejOY3oaCCZLmywrn8w51CYTVzMd31U
         +gTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777324783; x=1777929583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BllAnidD87wto2W5qLVWF5k/veO0cypHwEMVJ4aD4M=;
        b=qr3/dw6p343B3W+R/U5knkp9LLwbwbOWT4b+ClEXsTIwJBeY2sAuGBEcJE7dZkgySM
         EMNV6TNqLqtX5UIGOlIdokajB/J7ivp71n4ChXdES+myaHm8PZj3NUu16PUqS577ZFRx
         qreWV226LAd8hEi4PRiad1bGcmj6EOd3zBMGB3HtATQqkYDZR4WlJKPTcF3PMmHZazUB
         8xT7BLLvPmB+fY5jJCdQKSx8Eu0P+eKYP24KzlDStRzpfsrKRbKzzXZAdRBISk/BRC1E
         o8PgJaf7ID3DinVa0nBXQaAuocT8BrDWKcnuq5RvGPeWuXyo5hTlG3RNvjPQi43cu5JG
         maXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324783; x=1777929583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2BllAnidD87wto2W5qLVWF5k/veO0cypHwEMVJ4aD4M=;
        b=NFuEKdTO2BsgqW1g6NmgB9zQCTgZprcKCMj9u+7hrk8PiOMICvNixfweLzLtaPRUh7
         B+be03/urqa1x7Ixxk/w5VVp8ZfKflOvNInXEeDHHuGDAx1m+/Fybd3/DF0elU6YQPiG
         1JTPvk5t/3kgKPPudifu9XhVBFEIRMOiiD6DT3EIrGGlCA6nDaS/y7oIIuroq2rwDbNf
         CP0Z87zJ/p6ZZgi9tFyIyOr0B1SkhyPaB4Ki9GgRkxBBz3chKvksCJ3ec6Y0kFNhOdJp
         j3UL/44dEL/UAejoRuQ9VOaFYfbsrbqsaW57zfPnZtIbCNMD7L73qN210on4Ds7nIQJJ
         7rvg==
X-Forwarded-Encrypted: i=1; AFNElJ9ijPtvdu3cfFeP9ZRV0dDsMuT0WZ1zQs6oTQwiMf1V7Ll4y7ufqE+OdTHIDUlu6192N7uLVoPNtzf8Z4BZgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0xCPNtLgFn23UTI2czLbPZLVC83nrEgKEcDsf0FuN8Y/43SH
	sM5GP4rvby59yk5rozKJaH9EcdnJa9Hu5U1p3f7+QoGU1L5kgsr/gBDJLm/6mLh/EirpuBb3ggR
	chrHKi91gArU3C/1gQzHKpXMadCDB8GU=
X-Gm-Gg: AeBDiesffdkVTEDxrkea4IiKil8M/ZQK8ZJvFZBupSFLkZpH/xcQSdRfAYgqjOESJ4s
	ge3E1nwWsidIuHyh+AZG0AmQjgLZiigYdqITGCtz4P63VHHUE4vhCVaskAAdVTZVYhlvF1d6OCp
	MIs1ySrPOPG+z8DLpdK87bDOxGEAZeBr4B/L5GMRm3rHXJwfFNlp8AeWS4l1ZrRV3YHuRhluzBX
	QKa5V2i3xJM/J+Tv74+V8fK/Fc3w9pSTqk3P6gDOMg0Fsd2gu5+aFEu98wEz23XVbsW7/MW9Ii3
	kKiJ5fZxOl4nDMix24o=
X-Received: by 2002:a05:6870:16e9:b0:417:2b06:ffc3 with SMTP id
 586e51a60fabf-433f3abb2acmr76562fac.18.1777324783265; Mon, 27 Apr 2026
 14:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com> <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
 <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com> <CALdGYqQ+Syz+6weTChA=aXe=DBZSi1c0-7OYhJgkj7ahpR4EUA@mail.gmail.com>
 <CALdGYqSS1WXdqHi1rp+PznVOW9wCF3vDC6qkScUXNV5YHQ=Bjg@mail.gmail.com> <CALdGYqSS_4yrKn73UHR3zfgJN98wjR71V=pn+1C4pvg2UXGHyA@mail.gmail.com>
In-Reply-To: <CALdGYqSS_4yrKn73UHR3zfgJN98wjR71V=pn+1C4pvg2UXGHyA@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Tue, 28 Apr 2026 00:19:06 +0300
X-Gm-Features: AVHnY4LTfYxnkcQNu0IW9t2RnBaGJ4p3Rv4STTYbXP1KtayvquREOErnxplil2E
Message-ID: <CALdGYqRK+a7-7WEXgp1H-w-1AaQhhbTW9FTWtpmfGN_yXuDGSQ@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F04CA47A923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35410-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Bitterblue,

A follow-up after a full day of intensive stress testing with your RX
descriptor validation patch.

I ran seven automated test phases back-to-back, clearing dmesg before each =
run:

Power save rapid toggle (0.1s intervals) during heavy download.
Ping flood (10,000 packets) with simultaneous power save toggle.
RF kill flapping (15 rfkill block/unblock cycles).
MTU jitter (switching between 500 and 1500 bytes) under load.
NetworkManager disconnect/reconnect (8 cycles).
S3 suspend/resume (3 cycles via rtcwake, 10s each) under load.
Combined chaos: all of the above simultaneously with random MTU.
Additionally, I manually triggered S4 hibernation while running a
continuous power save toggle loop with a heavy download. The laptop
hibernated, powered off completely, and resumed without errors. I also
did a full reboot and verified the logs from a clean boot.

Result: zero anomalies across all phases. No "drv_info_sz" messages,
no mac80211 warnings, no oops or panics. The single occurrence of the
bug I reported earlier (at 02:59, before I began testing) remains the
only event for the entire day =E2=80=94 and it was cleanly handled by the
validation without any impact on stability.

I will continue monitoring over the next few days to confirm long-term
reliability.

Best regards, Oleksandr Havrylov

