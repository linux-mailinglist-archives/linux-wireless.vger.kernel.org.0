Return-Path: <linux-wireless+bounces-33441-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJHqCwNCu2kRhwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33441-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 01:23:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F22C415D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 01:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56DF5302A55A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 00:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588281EF09B;
	Thu, 19 Mar 2026 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlWiLkA/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183661CDFCA
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773879808; cv=pass; b=OZk4Ub/4oUh2/vuMvfylFJmIVpdxtVF9ohXFzk6NxE/1xrSpOy9QKf5jv0AhyWygGpLlgUxOFIFno2A5//J/7lj1PbsMFDKNv9ZH473qD0phpO/VPl7tfJ2QhxexwCU9yfnCFsVcjw0Xjh4qnLIueZ4k6nzkk9ZMYes/sXlZdMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773879808; c=relaxed/simple;
	bh=mCiKIXEijOdDbp7F849hqfvCIaOAfZMqRjizq119EIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J73CHIx/9QWW0WyWFfKujUFw71hED2sbIMQbyR3WfRhoR5Mr3l+6gZ5O5E0RG5IioN3Wba5u7IvZC0CcJiyg7Btg8QvEvQWCSNDkHaxI0rwgT3iXhV88+0nZY5cmLJQ7+8fh47Ydz/bPYfVw7FaHbBbNhyWbp4XiJYp6+4cWLbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlWiLkA/; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4171451e89aso324449fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 17:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773879806; cv=none;
        d=google.com; s=arc-20240605;
        b=Un/FL8cGOo7ukne2OyMTJk9K2T4kA7n3Km6fihpZvEDo/iUxmSk64BhCmgLoMdLOTV
         uOj6Bd4+euPX8HkHtf0d4AagdMtSBQkVmoKeu6ZYl4UxCfSw+tmMHTMibUZtD2HeCXYm
         bwdooYiG/hZkTvJMEH/0MJ73d0HiYSvyupLKKZ/DEKs0WER/+j3D6uyG0Ic0iz90ocKb
         LsDXAhQWignSLvaZdsLBPZhI7RU0huAo9rSBQWrKyn8cda38VtjbUTQxjXLMsiO/B7fL
         wOG4KFdwiRYnO6uRRrqntfFMg9aX6APOobzYmqC2gCgT+V3Ga0m3SGrJli6n2Hor552g
         +w9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g8nAB55/gJq0BnlHo2iUddxoc7et9oJlwrH3053qdhM=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=JYroYlNgTlz4XfgeQSh0gNh4B8cdf5Z3M5hfMoERXLWcn97aUS4EMSFseuAgvK89gL
         gm5FLXA8FsbHUfF44redETsEBx6uib1Jd515KoaPdIXk21OkJ2sfl6mKYHl+GvgqqzWy
         uxHEGAKC9QISpsnah2tBe3DVHAIFXKChmU4tyFlwqsrf9uTqkH6d7SfQsvxpesCOpQDs
         yZd0aX0F+Rg08gRzJm/+F1xgkNpJprC1sytefcOdtkMWrFRxabFgS1Uf0ImqQV0q9uTK
         3pb67VJvZXIUeQNJphwpPxZen3jscxKv5hayRDsPFqmTivoOFZm/MzTG+68ls1v20YPh
         Ny0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773879806; x=1774484606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g8nAB55/gJq0BnlHo2iUddxoc7et9oJlwrH3053qdhM=;
        b=NlWiLkA/x2x5wPIS/R2r44MGy5OujQrss4YmU7YB/PmgQM8khq+IMNSHjMudmENGh5
         Op30LBg3T00k5IxMKEBrELBN/2DJhysvZLQDttz/NYiuOPT8EXUsusVr6KO9P3wVVDqk
         GziVslOeVv2CsNW/jHi5MAfXHngse7jgfJ5jJemp8s4/gD1N1u72tmLAX5c89Zay00Lk
         Utk23xUfYbsgegJ85RXoQstQViahi8zu5NdbK6KS3yAqiuPP3/9BSsmrkZTS4oYFhyeM
         Tje+ZlO4zeEhw6HIvQ2xUj79qsUtBAnxLsrau2+NjdQEA5c9XZuRedubQCZgc+h5um27
         Q12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773879806; x=1774484606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8nAB55/gJq0BnlHo2iUddxoc7et9oJlwrH3053qdhM=;
        b=Agf1CNmhUsM0u7tFWRLiAC82z8BwLdGNesHu1ZPk2Dd4gfoWu6bsyXyiYvpFAoeUwM
         AsssWvyPFdTWkNxSIOD5S9tqJ21RcVKZ9Q/RBncM5v24Mfl1qdNlEwsJP9VUSpAMwprS
         lGS4nHiiEtQBGQq+Uuj0QwPuJ+Zl8H9d2beMO0NdgmFsRMKyQTUcQ8CokKmn02PPOS11
         XD9adQATRdbDLQvbDmNEtW4MYvRsMSX/HytiARF4MDdKk3Mkkvqp1ct0Hjyd+GYbLgEt
         Uu3Mya+4+bV20HV5cJ6SWe/dy2xG6tbvh05vK6a4oRGYVordwRVZTH/v3ObpLfpdn/Hm
         S+/A==
X-Gm-Message-State: AOJu0YyUNLUGSbwsLuYsxyluRMNaVKACBalv7xvfLnT6SqX8dCr4kDey
	+H0qokmDnurpwG7q++w3lW/sEdR18zDxez/VJDshrZ5grSZP/LDriazBjqvZ2Xt2K5nEbP6bpZL
	yy2N17xhK8zQnCAgc8Q/+l0jCQI+MVF3uSlQM1XsWSjWm
X-Gm-Gg: ATEYQzx0QDuGbLdESinW09IMYNhRGXV92bgqLOnXc/Yz0jCPsvT0JXKxMUrgXSAlnvo
	5uSKA1cfFHD2cYiVvBf9zY+VLUmlwGdXgMG7f7yJ/1t8RCiUbWtHnxI3X+swI2lfi+yMrKxSx34
	DcJagWF5kV9XeAleyfVC7pszuYR/xzK9Qb2f4k52kO38RORfhaw+GerqwlcdbWoL9g4K0pCsBAI
	9PX9cIzqH6OLl6ffR4XSKc8hl+KpRWUjYAwbAXHckxMgrpQYrCln2t3bnMCoPU8e3tAaCuv5ezF
	Ei2Zjow=
X-Received: by 2002:a05:6870:a1a1:b0:409:54ac:12ae with SMTP id
 586e51a60fabf-41bd3cf1be8mr3533834fac.8.1773879805773; Wed, 18 Mar 2026
 17:23:25 -0700 (PDT)
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
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com> <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
In-Reply-To: <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Thu, 19 Mar 2026 02:22:49 +0200
X-Gm-Features: AaiRm52IrXU1qDXCnMGcr9BBuBs4M9KvDOWMJJk4HqPu9QV0ZekaxAFUx0FjqAA
Message-ID: <CALdGYqS-wYLsH8zuW-Kbd6OqEuwXOaBWLTupMD8tpekagj=jjA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33441-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.946];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A23F22C415D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ping-Ke,

I successfully collected the output with your diagnostic printk.

Here is the exact log entry triggered when the warning fires:

[  180.424146] VHT NSS=0 pkt_stat->rate=0x65 rx_status->band=1
rx_status->rate_idx=0
[  180.424157] WARNING: net/mac80211/rx.c:5491 at
ieee80211_rx_list+0x177/0x1020 [mac80211]

Looking at the rtw88 source code, this perfectly explains why `nss` is 0:
1. The hardware/firmware reports `pkt_stat->rate = 0x65` (101 in decimal).
2. `rtw_rx_fill_rx_status()` checks if `pkt_stat->rate >=
DESC_RATEVHT1SS_MCS0` (which is `0x2c`). Since `0x65 >= 0x2c`, it
correctly sets `rx_status->encoding = RX_ENC_VHT`.
3. It then calls `rtw_desc_to_mcsrate(pkt_stat->rate,
&rx_status->rate_idx, &rx_status->nss)`.
4. Inside `rtw_desc_to_mcsrate()`, the value `0x65` falls completely
outside any known bounds. The highest defined rate in `enum
rtw_trx_desc_rate` is `DESC_RATEVHT4SS_MCS9` (`0x53`). The HT range
(`DESC_RATEMCS0` to `DESC_RATEMCS31`) ends at `0x2b`.
5. Because `0x65` matches absolutely none of the `if/else` brackets in
`rtw_desc_to_mcsrate()`, the function simply returns without mutating
`mcs` and `nss`.
6. Since `rx_status` was initialized with `memset(rx_status, 0, ...)`
at the beginning of the function, `rx_status->nss` remains `0`.

So mac80211 complains because the rtw88 driver doesn't know what rate
`0x65` means, leaves NSS at 0, but still flags it as a VHT packet.

Any idea what `0x65` represents from the hardware's perspective? Is it
a firmware bug or a proprietary control/management frame rate index?

Looking forward to your thoughts!

Best regards,
Oleksandr

