Return-Path: <linux-wireless+bounces-35320-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Gm7/Igna7WnGoAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35320-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 11:25:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA234693F2
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 11:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 581C83008E2C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0423218BA;
	Sun, 26 Apr 2026 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+xgjJRp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBE3B2AA
	for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195524; cv=pass; b=BchsawkNDH/OXDaEXTXoTw7+ofzCiMqz2uLsYcbco/rm/q33amlf5tkKROBeFByhSOyPnCR3fCR1bUx9oQ55/+/+jJgdUjXyoRE2gKNC6sJ1mezbt5+sTCh2E32YsFPXFa1o8dFoQICc7tlS9EiWi/6qOUDnX4yAefMdzu3Ruzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195524; c=relaxed/simple;
	bh=OU9pMu9yMcFKNjEMU9/GR/Rt6m46Naa/m1h3Wyhk0so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5aNDEGIKndI5jk6bs9gizvi1yATSRcudsqvY7nTwj36i6ykQoX7KNrHw4nNfEbVM8k5v4SeDaDdvyBo6GhcKGXm9gUIJ6ZhIXuOUtU2g5/fQ8oqjdhtkdBA9bpreGA7IypXBUpF2PZuygNNpZd990qXzBkMMJ1rcRNrYhHQIvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+xgjJRp; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-42321c8b8f5so7511609fac.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 02:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777195522; cv=none;
        d=google.com; s=arc-20240605;
        b=TIT6gkBjxCaqrDejtTubNKCJLStRi8rYeUQD3uwmJIssC8E/ObAVffZstOmNPtkFch
         7at5Pd59imhaM+MqsS51eU4afoWoatVN8SBB0mCM/APqNJ1NW6YJTrrpW1P1U5cuYu71
         raJbH/DhAOeP5IM+9jE//UxMMgHnpTTPOGzica/iZtJXI8Bqoq3iezLJnOmNXUIeruY2
         FjDu3IvGDqtd8uvgkC1KaQuAt0lasehoYo0gTWBj3+Y9TKGOs5hZLHsDwJaPHVcqjIt8
         nEMo5dZY0EoxNdDDWRSdxcZuJj2RyztKN+9ucufnFmyPX5p5Jm3x8o7TMrJ2b5/qMZ1G
         35FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OU9pMu9yMcFKNjEMU9/GR/Rt6m46Naa/m1h3Wyhk0so=;
        fh=paqnk+rpnT0LNUx3S08j45/FuNm/t1BljRUpIoadGP4=;
        b=S9W78zJ7JGS0eOflUwD9iCuDutv6OrK1HLxk+bQDrvBBhtUhuoWArFXz8dMDO0Z7PN
         V5M7bS477+eVOO4LerMm9r+mIMgsM4oB+RMtHIWpZTEeAd09OznsSW+/5zaRQurRjWCk
         wFtiE2T+PHPl6jQdEg4gJqoyQH7Co2vCiaB0OVmRlVJbS/qBZwb5AuYsCDfPD6th9d2K
         wG9b9SKR4G+x6Aqh/Ll/SmC6N8EpsgfIqvd7wFykKuBmkal2vX5lT1QcFlBVl3dD15kl
         pC2ZQiRuzcpsEIxZerEF2DJpXgV7xBaW6fIQrLBobQg/YHoESALwT7oPQNMu1q5IyuTy
         r5gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195522; x=1777800322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU9pMu9yMcFKNjEMU9/GR/Rt6m46Naa/m1h3Wyhk0so=;
        b=j+xgjJRpj03xxkRk/2CDiwYxgGDHImb1SUJf/QQ04oFbIDoX2sc0PgLE3JJz6oGAif
         qTfGNNWXy7YwP+n6WinPF8tzbYT67fAIYMH0xXBsKMukMbBgcn+COi8gnxaX/gjMS2kp
         aHuagDlsll9tqfDG0c03QRgiGOoFZYItFyJ4fBpEgfgll2seVE2CClJBmEem3BWSKFrG
         4Mf2XjlaGhCTA78gryB6JFo2rtt7SBTkUPaTxkowVYsk+ZSqRINj87npiPhNUUJV/fVD
         iktudDiea1/yQaMN/sFcF4qwl2PeSBVdqhyiLESbwmBLSjLyIfIgNs5CUCTuCYCbvqd8
         KQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195522; x=1777800322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OU9pMu9yMcFKNjEMU9/GR/Rt6m46Naa/m1h3Wyhk0so=;
        b=PCF14dn9P6p3zUS9rVd07mh9I6oB8IsHYUV8JPzyQKszaCNJqVG12IG5aenwSGAqQY
         rCQDYccLRFufYs2H52qcQ5jGWLcbXughvIyrumgYXpAzemaj3Ruq4vUcND7QYYSdLHYL
         2Qk70152ReS0gCGQBymlFcs9R/qR24KvrlnvY7UxBx9tsY4iwfUX0h2VT2HXsqk0G3ny
         yzq/ycjwWtu/E6jbxsoPZ0XxgpxTdPN6G/x/WSHwxj/ZNSFW/DenSh+mFa4gcEIkBcEt
         ca0bFooBHLPN8oJszno9kTIu/0tAJCz/QEsaA2vbZ/rBsbD1bCkKVKbjuYW7U3kG46L+
         d38w==
X-Forwarded-Encrypted: i=1; AFNElJ+NJc9L3CveIS+NGW/KPklD8JQxKaNR+wpQU5se4xS+ghdVlkxRLuI8/JtqqpzdPaFqzD6Y7bupsAWb//K0tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNPF78Tl1gdCvyEhUyIqYtty5r2m4yChetcX+aNVIoSbVBJyn
	SQHP4VbVVvGfwdh1pjgm2Wk8ehXVi0susP3AI+jJ6ItTi9BPsk2XBMmRo4yv0OB5WHQq9cHrqqI
	od76mzmMUHq5TOxGxNZ9SO6GD8+9Q8lE=
X-Gm-Gg: AeBDietPo+NITHe0b0p0u0GAOCu/Xx3y0ceCIZvbmzHThM/bE0kNw/W7C/BUCgGVj4V
	vz8BmcpTvoyIOZxDXrw3XY6iTw2YRQboj6R1utDwDwnaiNBsqiy3U6hSH2iXfkXqC6pNeuL78Ym
	I7yvz8e8yp2c0pJHRry0VNAY8iBD5D3HXFI1+X9SPRswShW75hksr+2p8bHxWQ7eOFTCrQRt01J
	dISaeA2GrCzH1aCfWUXExdsDuk8x8AlDhinV5ScqLyNtezGL44edcYCm+jo1NnY7JoMTzdPMRTF
	x+IZqVyljkSMPhiUDb8=
X-Received: by 2002:a05:6870:c08e:b0:41c:6bae:2307 with SMTP id
 586e51a60fabf-42a99a40fbdmr19580513fac.12.1777195521904; Sun, 26 Apr 2026
 02:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
 <20260424120807.25005-1-brite.airgeddon@gmail.com> <4i5nyqdrtpgm575dd3swyp7662wjdxu3hky7ucgwnuwigx5ge4@tc474ip5qxtc>
 <6EC55EE4-4534-4832-9FB2-393182829B22@gmail.com>
In-Reply-To: <6EC55EE4-4534-4832-9FB2-393182829B22@gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Sun, 26 Apr 2026 11:25:11 +0200
X-Gm-Features: AVHnY4KqgaG-hAOLwBLZCuzhJyDZb8Oil6TE5flQ_BooOGSihaJa6kKsVVzSk8A
Message-ID: <CA+bbHrVUjD+rm+Tk-WzroOiTvufp-aHHbDs7M9s4GwV=RnJrtA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: restore monitor injection when coexisting
 with another VIF
To: Brite <brite.airgeddon@gmail.com>
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, fjhhz1997@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EDA234693F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35320-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[morsemicro.com,sipsolutions.net,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]

Hello. I've tested as well the johannes v2 patch + the 5ghz fix and it
works very well. I've tested normal DoS, 5ghz DoS and VIF+DoS using a
MediaTek chipset and also a Ralink chipset. Everything worked like a
charm.

I must say this patch is pretty simple... just modifying one file
(tx.c) and it is a minimum change (not done by LLM). I think this is
the best approach. What do you think Johannes?

Regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El s=C3=A1b, 25 abr 2026 a las 4:43, Brite (<brite.airgeddon@gmail.com>) es=
cribi=C3=B3:
>
>
>
> On April 25, 2026 1:47:28 PM GMT+12:00, Lachlan Hodges <lachlan.hodges@mo=
rsemicro.com> wrote:
> >Hi,
> >
> >I will leave implementation discussion to Johannes, but I have some
> >generic feedback;
> >
> Thanks for the feedback and now i know why the code was flagged as llm cr=
eated. My approach to finding the vm freeze issue followed by the 5ghz deau=
th not working, was done using debug prints everywhere possible, with added=
 delays between function calls(the delay was added because the vm froze oth=
erwise, without any dmesg logs). Since I didn't have the proper knowledge, =
the fixes i tried initially (spread across 6 or 7 files) led to other issue=
s, intermittent failures etc. Everything was done inside a kali VM with no =
comments, full of messy code, not using git commits to revert etc. i had to=
 start from scratch but then i added comments alongside. Even though the in=
itial patch fixed every issue, being too invasive, I tried to trim down as =
much as I could which landed the sole chandef and then the 5ghz patch. I di=
dn't pay attention to improving the comments when removing code sections. I=
 also had very limited time to spare for this and my intention as I said in=
 the airgeddon discord channel was to send a cleaned up code to the kernel =
devs so that they could get a hint at what the issue is and come up with a =
proper fix. The commit message is what i summed up from doing all my resear=
ch and testing. I didn't know the format to submit a patch, so i used infor=
mation from AI, Google, previous threads/replies etc here to submit an emai=
l. I didn't check if AI changed any comments.
> As I mentioned earlier, a community had been waiting for so long to have =
this issue fixed. My sole intention was to find anything that helps with re=
solving this. I've also packaged 6.18, 6.19 and 7.0 with the patch and uplo=
aded it for the users now but as Oscar said the proper way would be a fix i=
n the upstream and backporting it.
> If v2 patch by Johannes(no need for sole_chandef) + 5ghz patch from me fi=
xes the whole issue(I've tested this today) please look into improving it a=
nd providing a fix.
> Thanks

