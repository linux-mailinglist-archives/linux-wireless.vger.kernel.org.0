Return-Path: <linux-wireless+bounces-31611-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFYGGgpPhWn5/gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31611-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 03:16:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E40E9F92E6
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 03:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E9D9301A7E0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 02:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D251B1E5205;
	Fri,  6 Feb 2026 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNCb/NpW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E81C860B
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344178; cv=pass; b=SqMcd2rcL17AkVQA0+Gml4uoCCy3125y5FHGCZyPBgqri81GHtwcDfvQ1MyIp71vtNRoRBeXpr9LiNvuG7PM83euo7LUtVpqcc9ADRVOwhmQbxXHKwAG+6p2T6ECWgfi4o7WZO7m2Bw/Z2YV7+SY3dGGDQe33e89UBxGobE+U68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344178; c=relaxed/simple;
	bh=ddiQxtiOpyGjrrRfZq1sfDLEMb2IDQpqd9TxK0XO9E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsT9Uh3fx5qEJ+IywjMmyus41+1STNWGi3Q0xoe7j4KI9WdwrdeX7zHl1lLoai6CCzpE0dxRJXFPhvmzNSY/K1TH9yuisP5s5zF/Rk6Eg0NYqU0nhTwjsemgulIlrOA7VJmH21NrUYdLyaM49ZwXTDw1tFhl9vFi+GZjFsx60uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNCb/NpW; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7945838691aso36222457b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 18:16:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770344177; cv=none;
        d=google.com; s=arc-20240605;
        b=DaLwXPCum/hVUtJWSgk0CdfI4dqh78Yi82TlxFnXRC5TigWD0tfp6iZV/xmjLrikKb
         2o3HS3yt1f8XxpZ/fwMYhNPPViJo6GjVGmt5mo2M2W/quW52urLYtxIZc9qxiiib4grr
         ptEVhKwr3sHtPb7/2F/qZL08B+guCQCvmgNiV7v4DyNPOE0oAnXPz8SpeFDH+kxHJuTp
         IisPuYcOnuEYYXem5LAKXdIaNnUeeXUUql8n+ivJF5G3zr9MU3HKAaFH+c0NSA5hsrXO
         9VBFR09XyqELNUB4u+DnrhlLZcYhtlBF/X+RNCuxtT2c1gMOh3um5L/8ET6pdoWxuSQE
         hzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ddiQxtiOpyGjrrRfZq1sfDLEMb2IDQpqd9TxK0XO9E0=;
        fh=exgzW08My6ITAR3OUK8Ab8dIagt0mim4T1cA/09Ks4Y=;
        b=Hw2ROA1PmkUGRaWXSgqg4dI94dDrookXpr0Piqq+XHgihEwqdCcyh5qtpW1N0dXTZy
         3OlMbu+aJLxoPh5wott0/Z+DRLzwfc98UayjCe+GC9qvtzVGe49mHPkJzKIorEpW1bEZ
         DGB0xuv+XcfzBgBPMc9AvmwJiouCBFKCvb3cxYF2z7am6qiuhV4M+nCj7skH1+Scxr/X
         oxgChAaWPMlvK88ZW6Zah5IfhEXiooXduvEBMa1xrYK8qmAmWQn5E+kBitWl1WbabP0d
         GSWPjfkYwfXOyxXO8CVBMDidOLZr8oLIyzVrZlrrRWK8HK0ZcKECWX0fLCwSEvwjYji6
         KZGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770344177; x=1770948977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddiQxtiOpyGjrrRfZq1sfDLEMb2IDQpqd9TxK0XO9E0=;
        b=VNCb/NpWzzVesI5G8LZ2Z9J6s2IHnLGW+5ob98OM3mR/0I/relK3p0bUcAR/7jL6Ru
         Em3ukvKUWadOEPheU5TnFG2YX38Zc6ubaa7zxEJLyJrrbZERVAZQ7r9S7YGbdF4ztGeQ
         jGa5wbqwJrE5h12C38KXJd6xStgjmvU26GqdG3/LWYzPENBBx05iJMOmm1DYWQap5oah
         /s6e6NxVbnmxjPVSGOvIIXdjISQicHlR9poUbQQToGXYu4OeLoAx7/Qi2JVEoTNGxMSf
         w2+q+7Wzxcg3a8naFIao5kAw5j/V3V+NJgmhM37VzUjMSSBczmgF5XQ2E8uMVpukoUkv
         dTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770344177; x=1770948977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ddiQxtiOpyGjrrRfZq1sfDLEMb2IDQpqd9TxK0XO9E0=;
        b=kkzGHjsfkpJyrK8QG9SZrKn1Dhn1FDI9HtyST56WMu8pPsSZvQoAYbbuAeE3fD+2Iz
         ajgD0BCs3HneryCaSO1uncB3bUaaPDrH2x63d1OIWxEUs/AJdiQR8NDAhRNee0Tyc9GG
         5GemDybTtwQatteyN3WpRpSFVEfXiTVPakmHog8cmH4QeDaX6hVXRwkOZ/+1zVGYauuV
         0LAfURBybeHpiq9FNsR7SLYHk/7pyejc+UpGYp7EK55cWxDxC6Zifzs7tuGXmaXl+fH5
         Gjtio48XDji0AL9nA1grNHgMelO8rl0QQ9aF8Aes4RRg39IlVETuQtuwFYT5ML3WAqi6
         jOvA==
X-Forwarded-Encrypted: i=1; AJvYcCVhZ5zJzXyGjyf/KUBSp5u5k2SqwT/FGKv5Az+yytb2WPvJj9BHFT9JfwhnpDrDzvSagPiwYjkVEuEfH8JvtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XMU/daxYXyUjBc0wSKLfFxxJa6/Z1mmu2G7dDgzvaD8SsSP+
	MTjlbjI6GJQDHZCSj4Lhbx+6+yXruV/zDM7Fdu6Hj35S+Qwxs+nu2qqL64ov70sg8i4XUgpC12j
	5oE1AkHckM5ZuMT7KzUqaMUyHjHVtXG0=
X-Gm-Gg: AZuq6aL+BpAOVZ9TdNpU2MA20EPMJUlZ6C/rBMjTh3UZlQtOCTIrhPBF/OQPGgbBoyN
	7O3ByC5pUKwjdj3qnKdmaMa4AX2m6OO4M1RfYlRAj1pac4L82bGZSRbLo4MHMBIYIzlngCazTY9
	U2cAvcBaP1NQ+01Tta1wawzE8sYk17hkd7GBGBcHjgvgazjwk2DWgU2WM4nihMJMFFD7xOCEQwP
	Jyg99uI+RnGIJH/mCUFxCD/sH2h2K4JYlK9qvNO+3+6UML+OPtfh3oHUHEamon3L00sBi9V
X-Received: by 2002:a05:690e:151a:b0:649:dbdc:c219 with SMTP id
 956f58d0204a3-649e87d9195mr3868068d50.38.1770344177581; Thu, 05 Feb 2026
 18:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204081821.730673-1-sun.jian.kdev@gmail.com>
 <bc92582d5de175ec325ae53ed3fe18a5e073438b.camel@sipsolutions.net>
 <CABFUUZEiMFoGg4r+9q1FabbwD1Pfd0oZZeNxFqnM22nA1xn8UQ@mail.gmail.com>
 <074b66ab3d63e6640ecd6962c074702225fba19e.camel@sipsolutions.net>
 <CABFUUZFxH1noKq-=zSTrqpirJtTQ2AA6anb7Pk=BDGC3aTs+Og@mail.gmail.com>
 <a1989402f65d0a9a696eb85925db98f6b722fc11.camel@sipsolutions.net>
 <CABFUUZG2pNxwgJzw1hiCj8OL988Ed=2xBhsFuNo09rRLTUF9aw@mail.gmail.com> <9f3b472d-a8d1-4c51-9eed-6ef0ec5b28a3@oss.qualcomm.com>
In-Reply-To: <9f3b472d-a8d1-4c51-9eed-6ef0ec5b28a3@oss.qualcomm.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 6 Feb 2026 10:16:07 +0800
X-Gm-Features: AZwV_Qiw5BQVISmYplBHkAkvaWCagI_GhfKuif42iVbJR_j-3s9jZBWznG6FZ74
Message-ID: <CABFUUZHqA=vyCUdDxwK6PTU9KNj_jv9SCj93MTHd39uaOBHfsg@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: drop impossible negative band check
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-31611-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: E40E9F92E6
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 12:20=E2=80=AFAM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> For future reference, if you are fixing a warning, then your commit text
> should include that information. That way someone else who has that warni=
ng
> can search the archives for that warning and then find your fix.
>
Ack, thanks, I will include the exact warning text in future
warning-fix commits.

sun jian

