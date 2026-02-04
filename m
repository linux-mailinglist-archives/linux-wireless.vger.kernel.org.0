Return-Path: <linux-wireless+bounces-31546-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIvYLIp9g2mHnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31546-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 18:10:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD79EADA9
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48757300C9A6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F2280A3B;
	Wed,  4 Feb 2026 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiQ3dAI2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29244318ECB
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224896; cv=pass; b=p1bkdIWvM+lKimiy9M0QkNx6Afsi4Eh660OCnok4zzhpfcBOll99Wz/fl6a7Sy8qNa/JZsgbWxUI0e/TnSbWcmYScf4JdEhn0gSUiXFrSddiCU2WY4G+X8UgEcuqpTG7Wrz1gNZl+vgETzC93QqtJXKbQ4eHrR53eoxJFa3QYPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224896; c=relaxed/simple;
	bh=zndhuxXn5RRFGAsb8aM7SRSuQn91tm1oLqi6LUxIess=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MulEOInEqU4qHTyD39wDGkmy5+1dAK7CwMVVWILJh4GiwjaUTbEC7pAhqXApfremWnhboJJCOYkXMJOk89srcisKg6WItirawaOSDWOXdjTCwn05WplSXgdlWVQVd4KCNl5WftG1RvvtBVrmkBwaReVdGWmn0KQEOkVfqfvy0o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiQ3dAI2; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b884cb1e717so176572566b.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 09:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770224894; cv=none;
        d=google.com; s=arc-20240605;
        b=bsP6yhJuuNLC6lkGssrP19GHnEF0dXA8cPsYMyOYFqfdOeXsJ4dKdSJzBmjP9fFWOJ
         axf+ygdjRf2SV7CRuFGI7+IaLVx1s5Fu8GhK0dyC7j+DzQ5Li9njyWr35snJF7ZzXEpo
         C7U72oYVOY4XESR8O3VwQCTuZhx6UURUxUK2sxADswZAXY1O6dnoAYohw4DZNCjntHrc
         SYIkyhxpMliln/J7bVQ8CQ+XX71gKr7VRRe5dvEsM8G8/kofyd2Kv7pJH2Kt8gOFwlSW
         5KrnhE120ebx7e+rq1mWyvGfjl5Km2hbJQ3jnJhXr0GCkFK22p6PRYka2LnL6wl0bRP1
         ZQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0PzTAQWwMUwtPAq7hCxWEoSaHHPGK/gE93BjWDtoULA=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=LfF7oMeBx4kAqhPtUpCGS90Uo6jaF0gk7Cc+HYXxoy3CfOXmaCLmaJgWWZLA/V3vbB
         Ymb87RdteNwRxzK6yLdou6gwvdCRdeCs/lFaaeuNiOCv5V+ZyYKG9JwIZQfV5Pscu8aX
         R/2259UHPJxwvUzZ74d6poWyurpD334D6K5UJf1IzIyRn2P1dHva/B+O5gDCPaLCrxTh
         0EXQqgQ5mLaioEZW6l8N2Vfk38OCrTrI3VE6LlNy8T+BvS1bcLgwfLtaHJhtwPrqTrDH
         j32xzXt7MYqNB4BY8ifMnmEescOlolEDt6sUeCS6csRagpwEg8iHsVcdFT2tqExvp8Z0
         PAsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770224894; x=1770829694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PzTAQWwMUwtPAq7hCxWEoSaHHPGK/gE93BjWDtoULA=;
        b=ZiQ3dAI2aFbx8RZqVa3oPp+/LuESOTxvyFtLWsGEcQg+cgeKbbg4wlLuT0hADpB3/x
         1VU0DVJg8Rxf1IxpkcsGg8/80vdH5P4Z89mwkwiva8uLL3rrgVYY6cb9sRJ2lI5cnjXH
         H1g8bQOZdKm+GfIrkPQEJOO/E3rTtKHrNNbNbEv6hkpTHHeWhAVKM9kVqt0GqPTWEf7e
         eti0G59rS4i50BAYOSSnnNCDPeMN00Kxs4MT/71Tmpp1IM0YpTW/PRmAh4sPfrAnXGx9
         ok8yFGcmqDBqHdMrO1p8rh2icXHBgCIuPmZIWx+y9Hl+pzGI24XgKbLvXOyg83M2MqoO
         bK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224894; x=1770829694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0PzTAQWwMUwtPAq7hCxWEoSaHHPGK/gE93BjWDtoULA=;
        b=Eabf3LTLgRPD4/Tu1sUfyNVICZND7QvMai/MacJ5AG/cxua9jw9EfIcYa5329ImxaC
         n5oJqSromnEu7tVx5tjkWK/Asbs6Vj1h8mmUZP4aEyIrwvHgA8VupDUmdZZ3jGTS9MKT
         G8v7sGTU0VL40UEwmyCzpeexaML3eb6/NIJFcd91BgZCZaGrVS3j+x2SUXjjxr1EShon
         fa5eEz4mcjRPfFcbBJhtiIP7fSamhYLzOMkuz8LpI3TN4/03R+AapgmLJi/6/tlTnEsD
         ufEdzlLx9aNWUOhRFzTNbzdH4Ves7/ZAlOQ2amdwoIi9YsBr43kO5XTJkqpF58LGtZdJ
         3KwQ==
X-Gm-Message-State: AOJu0Yz2QDyHdyLW+xZ+F6KzG1Pv3zSeWiYIY03TuHkUL3RczceB46Hy
	pLbjXLIezznUYSa6AkSoUiTjqkJeRSzZyL5ze4RmSpRZO6r9XqHvcXcb8pdOLOSLyOcM4zPj57T
	io+NBA5fwoTtOaBj3ZGQmRaFCqamXzmTNJF+v0ug=
X-Gm-Gg: AZuq6aJcAHkhUiFMZmu2WnIX6gQ3gdATntQBIeQrTmUOMMgijCvlNS8hrsoMzDh2eH8
	QxKs2BxSLcNHJHmmUQtihHvE0w42k6MsbirTrYTUFLVX/2Ik/mdgQ49X4lV8s5KEg/ku/q6Fu0+
	SdvGMrktiuAWdcyiv4QVPuN0B/flTQeYBRArCWuOhv1RVQ43Bb4sc5IRm4dKkgqDNA9zE9rUYX8
	lmFMEG9GqI7D1aMmjbs2x7tAn/fqfaAW1zsPLxO8/Nc6z5F/8bPbj6MIOQ7wtyD+dJiuvVzVQ==
X-Received: by 2002:a17:907:86a4:b0:b88:5b72:ec39 with SMTP id
 a640c23a62f3a-b8eba0ad89dmr2813866b.5.1770224894096; Wed, 04 Feb 2026
 09:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203185717.103810-1-janusz.dziedzic@gmail.com> <6c4341040006e667e0bda79aa8a46111c6ca9ae3.camel@sipsolutions.net>
In-Reply-To: <6c4341040006e667e0bda79aa8a46111c6ca9ae3.camel@sipsolutions.net>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Wed, 4 Feb 2026 18:08:02 +0100
X-Gm-Features: AZwV_Qi9-ms6wG-ITn_bthE1-1whw8Zmg3IsIxzMEvrm9guB-Jv_39HDpxkrE6A
Message-ID: <CAFED-j=jC=Czf37TqeKqJy15on1pdDM3bxG4WCDbMWV2jrXxug@mail.gmail.com>
Subject: Re: [PATCH wireless-next 0/4] DFS/CAC changes
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31546-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4CD79EADA9
X-Rspamd-Action: no action

=C5=9Br., 4 lut 2026 o 13:05 Johannes Berg <johannes@sipsolutions.net> napi=
sa=C5=82(a):
>
> Hmm.
>
> This patchset causes dfs_cac_restart_on_enable and
> dfs_us_chan_switch_precac tests from upstream hostap to fail for me, so
> I'm dropping it for now.
>

Doing smth wrong (hostap/main)?

janusz@hp:~/github/hostap/tests/hwsim$ sudo ./run-tests.py --long
dfs_us_chan_switch_precac
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dfs_us_chan_switch_precac 1/1
Test: DFS channel switch pre CAC - FCC domain
Starting AP wlan3 on DFS channel
Starting AP wlan3
Country code at the end: 00
PASS dfs_us_chan_switch_precac 63.1016 2026-02-04 17:20:00.697138
passed all 1 test case(s)
janusz@hp:~/github/hostap/tests/hwsim$


janusz@hp:~/github/hostap/tests/hwsim$ sudo ./run-tests.py --long -f dfs
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
....
PASS dfs_us_chan_switch_precac 63.095247 2026-02-04 17:54:42.043840
passed all 22 test case(s)
janusz@hp:~/github/hostap/tests/hwsim$


janusz@hp:~/github/hostap/tests/hwsim$ uname -a
Linux hp 6.19.0-rc7+ #58 SMP PREEMPT_DYNAMIC Wed Feb  4 16:03:27 CET
2026 x86_64 x86_64 x86_64 GNU/Linux
janusz@hp:~/github/hostap/tests/hwsim$

janusz@hp:~/github/hostap/tests/hwsim$ sudo ls
/sys/kernel/debug/ieee80211/phy15/hwsim/
dfs_background_cac  dfs_simulate_radar  group  ps  rx_rssi

janusz@hp:~/github/hostap/tests/hwsim$ iw phy15 info |grep BACKG
               * [ RADAR_BACKGROUND ]: Radar background support
janusz@hp:~/github/hostap/tests/hwsim$

Seems today hostapd DFS test cases don't touch background cac.
Any idea?

BR
Janusz

