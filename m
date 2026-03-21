Return-Path: <linux-wireless+bounces-33625-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GhzLEaKvmkOSQMAu9opvQ
	(envelope-from <linux-wireless+bounces-33625-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 13:08:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A25B92E5373
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 13:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 036CD3008479
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2028184524;
	Sat, 21 Mar 2026 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2NKUt4I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB91F4180
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094912; cv=pass; b=iEgifYeET6yvCoOLK9WVxHDX30s5VWPumVgAZHhBBarCMYo8MK2+TPXql+2g5izeQwG8z+uFlxMpSY21vJlbfOZvIW1HlpqSpqluxIdPnKaO5u/1KjUecZtSzEBEQu6sAZhXDOt3v6rR+zk/Z7h7UzobdBdmQwugSx3/CTRQDWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094912; c=relaxed/simple;
	bh=ucpRTDc1OpVHXx4HwXgEkt1OGInzKMEQb+WFjOgVNrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPQ8vghTJ86Kl/3z2CN6eStfob9SCviVRPx3U4JaIXnqYd1gBO+CZYk9omO6cV/a7vysABoRcIHEfLyVf2GP59/SOkPGk0b7EzwRl8c6UMCiBCvzanu4W53vnWO/C7WFXSai/ahtRitvuVXcfMIV8wEhzv0v6kN/sxg1mpea+gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2NKUt4I; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40f387a688dso2269187fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 05:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774094910; cv=none;
        d=google.com; s=arc-20240605;
        b=fkrs5PuC6cT506im695hhZhDfAJZCRXVZ7BIQtBAgTlwcPCFEmUo0CQ28yPwi6k3Lt
         C3zBuUaH/tTMtcvT+kxCdCDMqOGf6UsuoIlZ1sNK8qbKwJMVe9EbGHvkEtfuX0N85FWO
         k+4e/5qR3dG42j/h8iZ/7HkgUg1tY1o7PrPOYfv9UR+kklqCIosCJ+KrXcu6x/txZPWL
         fXJXU+x4BR9hbWrb/XLmn4YSkDeIboJ3zTT1tmwbACsCEQNxz3mZBXvsnApc1IPPbRkf
         qQug9hJY+bIqhdVJRzpSb2eMVDsUCUgdo9EMxR3ai6gEKjQmRAmsJj73AV6NjB1oU34L
         WQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e7zgwa373GYQXe9uQjQs7ga5wzUR6UFZdSJHxPzU3cA=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=OkkWKHGpUZZ83bCFTuVE8xhcS2i89QFNoR1ksJAbq3rBIFuYcBsExF/eUw8UqfYSzz
         wKzOQ0tDw0wE6AqCISJ4E9+iabWjACp/Eqiyws9V4A+aA4Wf76qvDcRgIifpB1To01O3
         7+BunnADEGhdJQTaRJ68fN+LPZDhvYdLMUE9zuc6LlTdHZrq/1df1H19Lrf28clbrBhT
         28dyU0w0AATFxfrCXwUHOhco59OTGuKMReaWaWCojZSmvi7EiDN8QY2+prBZWNDus+V4
         hMwRY5y86EeXJH8+2QQTOozItGP2vYhtJb9mFAY8OnOvT6K6lGLqfc5cIJwsj35hm8JL
         yM0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774094910; x=1774699710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e7zgwa373GYQXe9uQjQs7ga5wzUR6UFZdSJHxPzU3cA=;
        b=V2NKUt4INeIP4blTUsV+syoFHRMNUR15ZV4IFMjWn8R0a3XBZ2JcDyQxz6Bp5PSAdj
         jUliDs1r/daE8gUen2/vjfC5Q9uad1FAs9qcTW2VgAnX8GqRA3j+xVCDri8G6m2PPYML
         c82d6nVUHaX0FtBhyNGaOSLkwlGj5AKuHbwyndharuSdzlOk/S9tUCgMQzTvJm2/bLNc
         rxku6ncvbS9bkSY6MQmocPCqrWPn1PPwfXCvgWr0257Zt39cR37k7/lsHBMYK+Np76Nc
         PMyy1t00QOW9Uwo/x7mWtorHXl5IJb2dbGsnkA9lbamBgnOM4fax1n+PQZ2l1XJ07InF
         yAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774094910; x=1774699710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7zgwa373GYQXe9uQjQs7ga5wzUR6UFZdSJHxPzU3cA=;
        b=dJkYlFxBgsTdtCKeMgMRBV4BGANfVg+wCHzCTRvphEa4M9IICaS4VM18P+NV/p97kE
         vtS3LINg7ypRW+Ln2zHmc1CDnWjBqrMT8DywANprRzK9VEbEErUyrmIhmruYg/tPP//q
         t5/UCgPYQ4cunO+9ksfaigrzkbG0ROY07ph11x3hA+LbzKK987OIDSUeE2tI/57UMCnt
         /smZAZtxn0+EtdJ7XkNfUMQasQuQ4sFO+I2RvF72T5L3hiM5v7Idw0qisZIyyrI0SsJk
         6RIF5ejV9U3APyB4j9DKHx7uckwbDgQod5ijfakRultvWYDTVkpFSEIZPwE5oNRCjmyL
         PoaA==
X-Gm-Message-State: AOJu0YycUMyZZGDwmjdl3dWyb8c3PHG+PU13AVa9xgu/vik4OErckaxR
	VmiIuOm7fmcQeVWAU4iJjPk83K5L0Z+heDYmO9qG22+eMYIZdV4RAArt9niKq5oIu+bvpsDuwd/
	T8LXHGcZuM3sVXeC4mUpwl7aFc+VCHRla8SHG+Z/nONRc
X-Gm-Gg: ATEYQzxWXHxALeF2S3aYs4fqzwknWnvlbqGtGLKviqegdRDhXaHBqcRddzbVpjmmQpV
	XavwbdPKagiMFsSyA+rN8fBjbUSoEQ3XWkDaUHm6UCIwAgsdkkJMHuw32cke8zEDAAA/UgNPvKs
	Sb98hNRdIBqETrt2he0AFwPKEcMo8htG5J1eu8GKW7Vy5bbkzMdfQkhDGOf2gHeUDGutPAkJYdx
	6pNbt1blZl0w77fDkPh/T77sQSdbXKWWyVgmUVTiiKTNCilzVkMMBXyNIbjNWAIlUEYOiWsqjNv
	awh9GWMz
X-Received: by 2002:a05:6870:250:b0:417:5c29:acdb with SMTP id
 586e51a60fabf-41c10f8dd32mr4168642fac.4.1774094910329; Sat, 21 Mar 2026
 05:08:30 -0700 (PDT)
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
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
In-Reply-To: <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Sat, 21 Mar 2026 14:07:52 +0200
X-Gm-Features: AaiRm51xBFFKYQ1sskEx2nwx9ntUVYAxNbfAI5q6ac0vUMvkXCOP0HcuU8biicE
Message-ID: <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33625-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A25B92E5373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> I'll send formal patch (Cc you) for the invalid VHT NSS=0, but not
> to handle "unused phy status page". Please give me Tested-by tag on
> the patch after I send it.

Hi Ping-Ke,

Just a quick update to keep you informed -- no rush on anything.

My kernel updated from 6.19.7 to 6.19.9, which wiped the previously
installed out-of-tree modules. I rebuilt and reinstalled both patches:

  1. The v2 DMI quirk (main.h + pci.c) disabling ASPM and LPS Deep
     Mode for the HP P3S95EA#ACB SKU.
  2. The rate validation patch (rx.c) clamping out-of-bounds rate
     values before they reach mac80211.

Both patches apply cleanly and the system remains fully stable on
6.19.9. The DMI quirk is confirmed active via sysfs (disable_aspm=Y,
disable_lps_deep=Y) with no manual modprobe overrides.

I am looking forward to your formal patch for the VHT NSS=0 issue and
will provide a Tested-by tag as soon as it arrives. Thank you again
for all your work and patience throughout this process.

Best regards,
Oleksandr Havrylov

