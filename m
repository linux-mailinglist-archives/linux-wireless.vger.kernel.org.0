Return-Path: <linux-wireless+bounces-34346-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vjLSG8Tr0GnCCAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34346-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Apr 2026 12:45:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD83C39ACF6
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Apr 2026 12:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65A293013B58
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2026 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75A6F2F2;
	Sat,  4 Apr 2026 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq34xwsb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138AC1A680B
	for <linux-wireless@vger.kernel.org>; Sat,  4 Apr 2026 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775299519; cv=pass; b=qVwSquKsS3aCCekzaSCwvZw9byKtb4QHboozRSoR3M3JViiTDk0zH49zBjNkoFnm7yyRY3Er3Qep9utB9Ci0bNIA+kWxPGpj1Kb6sImoPtOIgzA4Qg8I7tjGxHDwseLgzD3TybVVEv0yRL7rLrEXJwckKLu+NybJQewNOUrCZgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775299519; c=relaxed/simple;
	bh=e4PexwBtU7j/8ZR4ZJRjlDCOFNJuF2i2LiiU/X0Zpw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/WxZsRigdAcfkCGFumBCeAwstd9lsr1zUelGhYnDysB5Z3VQYqR44ggrG9pvt5ZNNraT/Pw3QXG7phApuO3V49hS/xLb6z4JygL2rmlYRYccD/bqbHMhEWAF7kuHoID9368woQcgEeHa7REe4c9WQMX4YdYOTcL2LDX1VUqTL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq34xwsb; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-46fc5b8a06bso711381b6e.0
        for <linux-wireless@vger.kernel.org>; Sat, 04 Apr 2026 03:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775299517; cv=none;
        d=google.com; s=arc-20240605;
        b=YpyKzP1cEXYU62kWeowXtOUaWjxSSF0Z0UCENSb7T7RYpopxRXckIwy+Z1u7APZVro
         ef/lPbpXue5z16bCkinJfndNiuvl885Ia6Kmhstr8IOoEtb8z69/juUj+fKQaL+CVinV
         bUXUqUkPHlIO1PRLer1R6Bljsah47u9OsWR2zX0TA+RsXeYh0maIOdNMR3M/W29OIspv
         jmrRq+qoOs67HerAxiVUW1uCW10Irsb2d00+iv5HDCQMNL1L/qtzySqiuyx+Zc6lbesm
         XoGb+Ym/EC9AMv3kFw+qtSsby0fsR8Ff7QFyY11yCC6Vk29TR+cQffIXkobZKtubaMP+
         DAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yR0ZpRejuvz5gM0y7y1VfR4618NeARhzVxhXtC+PLX8=;
        fh=tCxSTW3d760L/mcNUhWuDxffTyvq06F7eQHhWgrD6YM=;
        b=HFpTEYBOfsBgqtT+Wd3+tQxbPwjmsxhoeQolg5VU8BmSDmWgZCTdRSkEtjK5CUlLAx
         zVc3NtyplFApK41AwDpmzMrkUSGuiA/3SAJfNTrY7EiwfZp9/VUV1njIDsJeO0JqO4Tc
         stZniQ5jxDJEQChZ+1gNlMEyXRGWkqA3f6rywSxGooasPji25jg9l3Bsrs6yNXpzDS0y
         JzUATZ2a0J6DwGLyFAEusYtdOXZL39CxYvf/IpM9WtfHGu/5QTOuV3yWUbH944RpDBd2
         C2GKhcgm3rQDf8S+jh/y/dmVKDXJXzpejRoJoEDnSzyaz6Y4silbb5SLa08aQa5D/1XG
         1leQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775299517; x=1775904317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR0ZpRejuvz5gM0y7y1VfR4618NeARhzVxhXtC+PLX8=;
        b=mq34xwsbygdWooJOASu9DNa35Vfm0iPy+STGhQuDutl/nWCmGzgb40fkr+BbknwylY
         CwL2T8Ghh1GEm7DnsePPo9Qc/TI1regYSG50wtR9qXecBFPsu513lNJR6u3lJXlNrvuo
         p5xwItLroar8FrwGiiwFep+jvgDEyOla0ZHQU+RcrHCCyVQasE43yVzTI5LfPG4s+hQW
         5gGbkPvEcqdyKMX2I5H6F+4090NaiRlph8VL0/+aGkB8vfxKXcm6g0yfpFFlay9bn3KT
         lGxb0KlPUjbPfID0GTSD+pmezD839Wn1cT3rdonzPv/9zXbLif6lGJARWNaebsysPU/c
         458w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775299517; x=1775904317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yR0ZpRejuvz5gM0y7y1VfR4618NeARhzVxhXtC+PLX8=;
        b=JEDEHWXnE4+ZcadZ1ZMfo1FufJqVC/WNBgRD3LzoTDd0v7qDw6Ui/93GfZy92NWFUE
         8+YIjJnIilZWzF2kO+ATjz6ZohFm0XIij0MPLwqSmmpt4/hXIMaFitIo/Rs8jM0jV5T2
         yVtWy9KmX8/YFypNb7ni40fmjvjsUbSwkQnuIDiJ9SFF56wKnrKR0w35+w41kpJnHdDk
         KQxzeoII225pG41YjQIboc2eIwPyt2hcFcA3yoFdpWgN4gOv0aMhAn4oHDpCLEZ3JCoW
         7gmipT4T++y6VRbBBBTDfB+hjjqyP1X60BdCMFcRb5b9nrYb+2wL2enr8vIk+bT/jvFA
         sFGg==
X-Forwarded-Encrypted: i=1; AJvYcCVyfq54zkk0WdJ8WTi0wKIL1VUHElrMPRsteyzDagnPp4j2xuVgGUObE0QJNjMWhcKb8Z2nmN1adD61IcegtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5uHTl2uEWvwdsh6HF1zkcciSpDLcfj1BjinymrYPuj+Ncrco
	KiVOZdlWxvhZrzo0gsTmILPk2qwoWLLIw+07UChCJOmP3hD3uxHrYzH6TOthRrJeglfb9xtwrOr
	+UUkzYJ7eubbyov9hmVoyukX9PzFVaSWttENNjYCp4W7V
X-Gm-Gg: AeBDiesG6hqv6oCM85HscBJjUAcOtNuTfQWuIw5i+nMtbkIU4avjE+yRdoYBiy2+6Sn
	N++sBDR4yffjpOqSCJWCRmUcPjGPS+DkrUaI/7zjSzk2ZUO++cc0u5hWxwnPZBhSsk9M1WqknNf
	7pagndPPMVuUAI66snFbPt6P+KTgE4BNkgIZBfVGtZtOvnKzO+IeQommRlfgvJTHgj5GY5EuePK
	M5+/rki0w9ZDxSXV7AX9wH/BOZBEWWMopcySI6G1d84m4OJKBCrsf48RV8o4V3WhdJYREEt+kb4
	0UWN7rsq
X-Received: by 2002:a05:6808:1a29:b0:44d:9f05:7159 with SMTP id
 5614622812f47-46de2afe252mr4237502b6e.29.1775299516897; Sat, 04 Apr 2026
 03:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com> <CALdGYqThUD1DSAcsshC0y4Lm=uG=EDvBccMqkL=qr2+Jajp4tg@mail.gmail.com>
In-Reply-To: <CALdGYqThUD1DSAcsshC0y4Lm=uG=EDvBccMqkL=qr2+Jajp4tg@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Sat, 4 Apr 2026 13:44:40 +0300
X-Gm-Features: AQROBzD88v-7WEsdqWuWrIfZA2JSeDfZxeFMhosLlfS5WDYm4P42XHGst2frthQ
Message-ID: <CALdGYqQGJFJTMpQOhdJ4C0wTogrketjxmL7_KzEu20YbDGvkeQ@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34346-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: CD83C39ACF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bitterblue, Ping-Ke,

I need to correct an error in my previous message. I wrote that
Ping-Ke's rate validation v2 patch (DESC_RATE_MAX clamp in
rtw_rx_query_rx_desc) was applied during the crash =E2=80=94 it was not.
When I checked the source with `git diff`, rx.c turned out to be
completely unmodified. I sincerely apologize for the confusion.

At the time of the April 3rd crash, only two patches were active:
  - Ping-Ke's DMI quirk (ASPM + LPS Deep disabled)
  - Bitterblue's diagnostic hex dump in query_phy_status

The rate validation patch has now been re-applied and verified
in the running system.

That said, I believe this particular crash was not caused by the
missing rate validation. The mac80211 WARNING in the crash fires
at rx.c:896 (ieee80211_rx_list+0x1033), not at rx.c:5491 (the
VHT NSS=3D0 check that rate validation addresses). The system hang
itself was caused by the DMA tag mismatch loop in
rtw_pci_dma_check(), which is independent of rate handling.

Again, I am very sorry for the inaccuracy. I will be more careful
verifying applied patches before reporting in the future.

Best regards,
Oleksandr Havrylov

