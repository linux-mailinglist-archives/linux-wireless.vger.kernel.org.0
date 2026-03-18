Return-Path: <linux-wireless+bounces-33440-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIFJD6M7u2k4hQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33440-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 00:56:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994B42C3F2D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 00:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA9C13029A6A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 23:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5028239280D;
	Wed, 18 Mar 2026 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0gBOUzd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9804594A
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773878173; cv=pass; b=qXR2vtldcwMAmPffXvbTHx8FixotIFNiXCHt/n1reUSQJFpjkyLYSOOexgYy4n59vEC6OOOdwDJaBNAtanhVRHj9AkPfnz0D8fRtDLqXWnOnEDiT31eZsPcln8uloRTWamGg1lrdgayP96erJFRpavMTG9c/ZERo7z1SXAXGZSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773878173; c=relaxed/simple;
	bh=pFdnqXilhweD/hhxuoZs+u8+AjyIuiTKRszxIf0VJD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/yUwgxsRH1s7/ufDVpzR8aTSzZWC9OEYiQeDqphurAY29RvNabqxFynttj1IzsB909D13/lE1z0l0gjAqNS9X2bRaziEjXi+9a8vMMMU5mevn58z9+Z0osVudFgZe6Bw2taBy95QLi8KPr+pT7wkqmJy94yqwrHPNVLEVclvy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0gBOUzd; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-41706b23543so253444fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 16:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773878171; cv=none;
        d=google.com; s=arc-20240605;
        b=AqdVxRfdb2lBNsLwrLDn8mSXyEHkJjcMfsZEJRKGdfSz8U2qv2MBHrPNnlEqLLvdRB
         E4Uqmt4diUdJwk26RJXpFA9Jybpmcn1rGwwwIE0Txg/NdPnkmwAROU2b9gRcV+rH17vo
         PXaeWCdUphXcaJvr4gvm9umfuRlOyeAlodmoGEawyI+YHNby4n86ZVe02GSemKfn0PvE
         qEnnolWFIzDUrhDmH3pF55iK/DQNSjDuwCHSN7xWg0/Sp3MJIsWYmHozOC5CdXa/lYnZ
         wliI6S/C2vFmmV66QFqGWdgSpNlHK7Xy0Dun9KE/kskHF4ytKBtGMGLEE9ViYVQ82PgO
         8a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fMkU+GFHjmKwrcj5sBlqXJK16/ufaGfvqFOWv+NjsR0=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=ESuKEUBfvstOAU2dct/dogAiyTkMzlnoZ9s4be4oChJa7vTBHeFNsE9o3M6QDXyD6E
         e4ZVl7Qy9uHw0AN3b7fzr2572+mJXQaMH5RLD4v9U8z85wEChO31UDWJIJARvY/tF6IX
         Y0l4rzzQu2pLTXzOnp5ib0zDnL0J3IQ8JFBkO5CdIypL5ihzxgGw6PMxAkYlp5cOyTTN
         LLLPcYAwdN9Kxj/z8WbH4b1nOFq1Q8MNqq1czdZioR3QTcqoC/MstZw5NOQLwFJ3EIZ9
         6ulniR3xHC5oejNqPdfoD3TKHEq4TtFwPnFFSTtP+0t9yJ/YlIOaZVLXYwXv/z8BOnHt
         GfEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773878171; x=1774482971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMkU+GFHjmKwrcj5sBlqXJK16/ufaGfvqFOWv+NjsR0=;
        b=R0gBOUzdiHr0aFq7RlJ1X7NTxyjqjEfo7vRHxrvFlMQeHsJfAT9ZnCko/dhGhGJh2c
         TaDOn9EL0SfIoPCqtR8P01EpDclRArt08jNtWPnMT4pPIwYgEc89iV0lZjRJm+KjPXsq
         Hb8WVVWfkBdL0RL+DamGLocKS4rUFWJPh16k8LrZnvxmJJH/hW+Sk7Y1FIzmxfKvaCyq
         I50vUs5GKgz64pNQ1reh4sw6G2nOAYLgfPriRC7IX6j2I76DPhnUEUW0M7UOIE8VTucZ
         J/mWXX3Q8IgvryvbHkpCSHubHlvroRZyboXY9RXdBG+VjZOm0CAi0h9e/gwVbXjp//jD
         PX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773878171; x=1774482971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMkU+GFHjmKwrcj5sBlqXJK16/ufaGfvqFOWv+NjsR0=;
        b=K+18PppHPI+JdVjGrXenNvUF9EsTrrIXy0gyzg73s+LDTeHZ5QLClDtfpW0P3MuISS
         TFVK0jEfvlvDiwSDUV+6hzeQsSZSDbRarDKCa3k5K40FukgOyREK+35qJ9N24hZk8js+
         43PYYwGwV4/RE0Mf7qF0XkKa46PPC7g7SqXyc85uDO2wi9ZLFtBfr3RGLhleHMRKDOQA
         v/qjcbzYCuk72uJFO+cTRFDJchm0TFlkN+E+irsFbqa0BV140oDrzdCLaWjaJaG/B+l+
         O+ApUcmkH813Ty6sY+AhMlp70wtMU/6j0ZgPQkOJ9MXOpchK6QwbKXBWhBTRvjPl0/dC
         cTnA==
X-Gm-Message-State: AOJu0YykIiHm0ZtwB15N84jO/SZjTP/j8/tGqeZOU1qt6fMcFZFApCQ1
	yRO5FERoba/24O24NbHrjp9hkzq4tRj9Mr/sNHJMrPeP+0dbO8No90hTqeST0oxXIxLMtR+cCm3
	yEEnFc/lFEgRShZ+O/Vu+dkw0VY6/m9c=
X-Gm-Gg: ATEYQzzWWoZpxZ79cN0BRrrTigYW7jckQincQaHAM7pLg7TvvlenZJE8rKGOizCT8aq
	wNINh6Bz4KRcAv56KVW/7hvEJgbO4rRN0h1v7v5I9wqMfZemnHZ2DWgqIP9ardrrPi6sB/Ewwnz
	e2ifDXE5dmNSNf0waEbMLKr+utq55xXQHvAq27aO/QT9EMnOe6HZ1OHST/Htd/dfRMIU4MjUGIt
	VhlFFURGT7A0T8JkLSxcGdfdlgDm2JcuMbOTOUg510HMcNSw2a+b+lI13hlroFc+Xz9ohI5bu46
	5CsdHww=
X-Received: by 2002:a05:6871:3605:b0:417:9ac1:cd51 with SMTP id
 586e51a60fabf-41bef7e38f8mr1118390fac.0.1773878170794; Wed, 18 Mar 2026
 16:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com> <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
 <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
 <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
 <1bd495ffe57c47eb827eec084729afa2@realtek.com> <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com> <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com>
In-Reply-To: <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Thu, 19 Mar 2026 01:55:34 +0200
X-Gm-Features: AaiRm52a0Eg_kcOzB6_OxFTRlx4wAJ6ahFmE6eAsq05i7v3GTH8o8uwbBDra6IQ
Message-ID: <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33440-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 994B42C3F2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> I add a printk to show the case VHT and NSS==0 as below. Please help to
> collect the output, and then I can see what it happened.

Hi Ping-Ke,

I applied your diagnostic patch (using pr_err for maximum log
visibility) and spent the last couple of days testing it on the
affected hardware. The results answer both open questions cleanly.

---

Regarding your earlier question:
> Not sure if this is because PCIE bridge has no ASPM capability?

You were correct. The very beginning of the boot log shows:

  [0.177872] ACPI FADT declares the system doesn't support PCIe ASPM,
              so disable it
  [15.157752] r8169 0000:07:00.0: can't disable ASPM; OS doesn't have
               ASPM control

The BIOS on this HP laptop uses the ACPI FADT table to globally revoke
OS control over PCIe ASPM before Linux even takes over. This has an
important implication: since ASPM is already disabled at the hardware
level by firmware, the instability on this specific SKU is caused
entirely by LPS Deep Mode, not ASPM itself.

This explains why the ASPM-only quirk (v1 patch) did not stop the h2c
timeouts -- ASPM was never actually active on this machine to begin
with. Disabling LPS Deep Mode via the v2 quirk is what eliminates the
firmware timeout loop entirely.

---

Regarding the VHT NSS=0 diagnostic patch:

During normal idle, active pinging, and heavy VHT throughput
(175.5 Mb/s), the pr_err condition never triggered -- no
"VHT NSS=0" lines appeared in dmesg during active use.

However, the standard WARNING at mac80211/rx.c:5491 does reliably
appear exactly once after a fresh full stack reload (including
mac80211.ko and cfg80211.ko) or after resume from suspend:

  [167.708201] WARNING: net/mac80211/rx.c:5491 at
               ieee80211_rx_list+0x177/0x1020 [mac80211]

This suggests the hardware reports a malformed nss=0 VHT rate only
during initial link establishment. Since mac80211 uses WARN_ONCE, it
is suppressed on all subsequent packets.

The diagnostic module remains installed. I will report back
immediately if the pr_err condition is caught, or if any other
relevant symptoms appear.

Best regards,
Oleksandr Havrylov

