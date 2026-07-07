Return-Path: <linux-wireless+bounces-38744-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8BjGA0fHTGqDpgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38744-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:30:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6EC719CC2
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hfGwdAHo;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38744-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38744-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 332A53053E7E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C7A397B12;
	Tue,  7 Jul 2026 09:22:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F393955F5
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:22:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416179; cv=pass; b=r8DtuhXYqNmFtuCb5T6aA+SXmIi5erDxXgHHQ1BKtKWq4rCF4/FzBievFcPSj+VYQkmvowpGggJLxnEKO9JakS61msc5twlLEpmTLCI1Hqha6JibcDlQl8a1pXfjGcBLYSxEm20JbR4YOEVmI75YDiD/xZRk7bobphhYsosv4MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416179; c=relaxed/simple;
	bh=APBFi5wRuEGOKDTs2u+TQsFzU9wU2tBftpxmDi+WFuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7lCRPVr+N+jBcc8X4hTcjxW0Nc6HM2Vxy2oR3tFX9T4njh8PlAqI8D+ArTJCy4XgC53Kak1FFxi+eu29v3NtZEdQPp3MlYhEqLexO7l1ctw/syXrpnF0/VisEmmGElxIFCBgdx3kaMnG8wriXZRRH7IfII5jRw1E2T9yiR1V+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfGwdAHo; arc=pass smtp.client-ip=209.85.128.182
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8114a4542b2so59434377b3.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 02:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783416177; cv=none;
        d=google.com; s=arc-20260327;
        b=e2ow+AeicJbpLZQN1WNFNguI/R4qeKBOtA66GvI7pv7Z8zyFck5O3yoUnWsJf7Slsf
         Bv7mP8XWVcvmh+SPeTjYo3uFg9OcsXi9QuwNJL1pXtLszFdOJWqmW6xVOoeQSGWBJayA
         7b4rfl5W8M2ON5w7sW/m0HSC6I/1nK/NJjxhmvyDz4+4AfL34BLkBV0JatSUy8DmclHJ
         O7YPhqgzKQDHnwpmk9GZVOLNnBUE8Cei718vD9cyuZnCq5SeSMYSBLM5m7rvao5Sidt6
         Xg76YKv2Gaj7a+srjWnlrorhTcuJibyDAJE3H+7rO5LMdE+BkXe2d2egaPFHhW4pFGnF
         U9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=APBFi5wRuEGOKDTs2u+TQsFzU9wU2tBftpxmDi+WFuw=;
        fh=8IAy5qup0a2EY8QRGpBSpKR+Jn4fWjWAV5x6xozgXOQ=;
        b=RREMdigiF9f/cmjfEzz7AjDTBuwXyVLFoRQsPX6+ZT72MvG55lsTAxdxsvXc/Jo3fR
         xAksJ0YMag2ztmrLH9IOxLVl2COKOFs+iZ53aAYvIKtUIvluveRqpVpwmUwnxaRsK/Py
         by5dKlof64WT0pJ4vwf5sSJbe1cezKEgmA6Rm0naOevSksXSIPcv/2nmTgijOdUkUKYh
         ysRlB3TWzhCBojYWw/54le6Crl/sUAT4hm3s0/CaATjzsqBD+WIZSaFqVgAywFD23/Gj
         oPrF05PUYiat2UHvzpHmmHX4G3VOa5FCd+u0yZUzTCWd7la6tNGv52SJdfhPQIl2iW7F
         2o0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783416177; x=1784020977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=APBFi5wRuEGOKDTs2u+TQsFzU9wU2tBftpxmDi+WFuw=;
        b=hfGwdAHoON1n4Ryafh5cIinS0PbnhmT6z9ofJP1aDhgcNYuJXO/jSasLrnSFcDRlTh
         QDfMjhrZodpqjdv7LtfXDsSWxCwF17/QkVq4J4CjN9dcsT315q83xBeFHsfU+2PzEYt3
         FSFP2Q2WUgtTAWTeJweVAzalX7ehSxNC+Mx2Acuhlck442LTJEe6BxVN2TFWJ0eZyN7u
         t08P6wZsSM4EHJs80xxB9q5wO7plD+P/CaD7pdpIQBcRNnRCu71hEFkRZQm/Pc47VuTr
         5aIsRE0fAChJyQVOoGOxGYHrb6r1vAm5wGEMaIAHpgkdN6kDRYNdc8f6TVO8Ml4qaZ7c
         gJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416177; x=1784020977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APBFi5wRuEGOKDTs2u+TQsFzU9wU2tBftpxmDi+WFuw=;
        b=tKoFozhbX8nIAyoYyclwvAXxzsnepmGt6hv7nzSPspODf98vrkshoaj5dg3eCzkH99
         39DjH8eiXHHr9B2xDirjlSanNFZwzCpkC0HcCyArfMlhV8o72+ao+ZgZngVYBDaE0fhd
         JhW8GWrwlTuegceyiL7hoNvLDOBgq+3+aLTSce9EhyTYRV/XB6YQmf37If26L5q4qNUX
         BHU250RxaVtSnxQmQqByXp5Ep799PwuqG1t6arXvBaAnMD94wFKx3Gm5rMl1DEtsvpVl
         qy989u7JksKXAihwlrCZtTOePwOKi40qANRLB69faecNJUH7Itdsky/PUFu09EiKlX+B
         dXpg==
X-Gm-Message-State: AOJu0YzUzgfvPLTaRs42cJaPGBlQRzY2BmSb0hRwnObiHoaMVzHtYPVm
	I1KA9iLo0QDVzl1zkhHZsG9rLcDU+N8LRDdy8xjPXGRZInQC9qys285b68btamTSi0xAMhT9wnV
	+/228wIRvkDL5TC3BfwCeU7Zsh9mb/rA4Z7qqBOWzWQ==
X-Gm-Gg: AfdE7cmSt1SvwPMokV+mKp1TMvyFaiHrMAqi6LENwK+SgmnO4QcjBZgox4xXssC1OZi
	rFChC/N/yg2RO+/f/bQw9WZucabVZEmfBTrjWPLOM3WnxoHoqWuSyHMLxOjIgioKQFnOBA80zAZ
	EEr/4gXNIH/JCg4oQcSD3Z3XiZ9bnGs81Ogt8HnzN+imDt48kCkItHSsq1+C8tjzZO4fBQA5NMH
	jjCGJ3ECSbyFOEQXQ/9SB6/jV0JakJGHdsdMzcYsccyMr0880ne4t4mLG4+DyQ9GAMulLShrg9l
	SycXWGIkPs4GDkXp
X-Received: by 2002:a05:690c:6f05:b0:81c:e8ab:c4f5 with SMTP id
 00721157ae682-81ce8abd14bmr2966837b3.13.1783416176991; Tue, 07 Jul 2026
 02:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626144543.5034-1-skyexpoc@gmail.com> <b4129a5d4d11080726c460955579851198c879f5.camel@sipsolutions.net>
In-Reply-To: <b4129a5d4d11080726c460955579851198c879f5.camel@sipsolutions.net>
From: =?UTF-8?B?SEUgV0VJ77yI44Ku44Kr44Kv77yJ?= <skyexpoc@gmail.com>
Date: Tue, 7 Jul 2026 18:22:45 +0900
X-Gm-Features: AVVi8Ce7Hk-z7o4kekBOGVsY8aF_hhmQk0xIppr6yTxO6wPhTEhKw97QHRTQPgI
Message-ID: <CAOC0qyJCoLa8FZmYyxdkEKn775+V6TELbneseRNELu3PfY-ZQA@mail.gmail.com>
Subject: Re: [PATCH] wifi: cfg80211: bound element ID read when checking non-inheritance
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38744-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C6EC719CC2

Hi Johannes,

I'm sorry, that was my oversight. After reconfirmation, I found that
cfg80211_is_element_inherited() was introduced in commit f7dacfb11475b
("cfg80211: support non-inheritance element"), not dfd9aa3e7a45.

The bug existed from the initial implementation of this function in 2019.
I will send v2 with the correct Fixes tag.

Thank you for catching this!

Best regards,
HE WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89

Johannes Berg <johannes@sipsolutions.net> =E4=BA=8E2026=E5=B9=B47=E6=9C=886=
=E6=97=A5=E5=91=A8=E4=B8=80 20:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2026-06-26 at 23:45 +0900, HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF) w=
rote:
>
> >
> > Fixes: dfd9aa3e7a45 ("wifi: cfg80211: rewrite merging of inherited elem=
ents")
>
> This doesn't seem right at all?
>
> johannes

