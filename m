Return-Path: <linux-wireless+bounces-38025-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qaqkD077OmrPNggAu9opvQ
	(envelope-from <linux-wireless+bounces-38025-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 23:31:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A636BA446
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 23:31:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="lyDTt/G0";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38025-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38025-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A78AD30406BB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57E372680;
	Tue, 23 Jun 2026 21:31:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7882620DE
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 21:31:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250309; cv=pass; b=Hb6Lg7x29p5SXNqazlMPZE+WQO1jJvZHdoE3Gyfoc3aF6GGKJMWNQWLQ2nQ6bPz9MS91sjkHz/d73pP7p9deQ25GG1hOyYMcoBcI/US7CYKhE+YbHJNfXutEARwGVSMusECdzjcO3/Wg9lWTRkMVn/agqOCgWdyAdEPdEsBynIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250309; c=relaxed/simple;
	bh=6ODEb64AHYkG4aH6E49GGPoMMFMA/JlCjco+hXc83VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D96lPa1Ijkfb7iqIq6SiK7w84xqkC5//dE3zOg7SGX3CURR+XiI0JFvtcHRbIpWYSBvCV+KagGHzxLt+CZO3CFHCBVFBjxhiz7NqmTe+jEozq5f1ZntzexXERb1p2Mfe9tT/1yr+zqUi3ppBhTS7u0YSUlsIj9rJMM4I2chhMCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyDTt/G0; arc=pass smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6976b0b2c79so263608a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 14:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782250307; cv=none;
        d=google.com; s=arc-20240605;
        b=LLUHMsowSb/NhyOzSyGQhFbrVx52p4lhWg3YRVRLQyzgNWLCC3EYxKzOCHAOLLsoMj
         h+fKDehIL1k7QHOEW1pDTuXkMthzxokgX5aAok6FeZcsSUraB13+ZnlXVmrddDgM7lWC
         y7iQB/1Ue37BmKpa/KKjV/bPW/ybFWifVB6LQDhaPllbp9IVwSnSlwlB0Cb7khQ6/z+3
         FHbL7xvyelhPtXpvlZw1jisBSV0U7fB2+8y6WH/d+nIrlN8NWXjTIhQAZsc7YuK8F1M/
         DZ1NifvnhX3ilCaQ4o0tr146XoJsIlybsRRJohHF+ZBhR6x5dMz+/csMDHXQnJ+JkJmh
         kzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QkYPDWFuD/zA/v32w3fCffNtRlCkZzOhrXgNESmlFhE=;
        fh=K6TQ0ieQzbYcGx1rNlac8CcGXOwkRILvYvsgyajPNEk=;
        b=XFH+3Amgm+MtbuJq79qfLA6cfZOUl2CR3voc8+O0dWdOqDerCCcof/bp+AVlIqMxe2
         x8LuzdYfq+5UST79jx7qHW93bfkBHqrVYWThu5YbCd2df4mFCbiJtpErnXjJ5FWRguSP
         kPsOIvV0f8KfirP0ILMTUsJteyYIb2KM4j4KoobQN+lM745V2fM3rIsHnH0UpZzdzsSv
         u1OufBmrgAJhhutcM9WEm4/tluSnj0Hn88WN9D2yKk495PXiZ+4/HDCq+uHisRdkZ2YG
         bC9fb/3gwXQB+wmVRqNpdmYXvzh/f61F+5saQSQATT3a73TIgDkgk8mvUSL2W1jk+0EJ
         iIsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782250307; x=1782855107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkYPDWFuD/zA/v32w3fCffNtRlCkZzOhrXgNESmlFhE=;
        b=lyDTt/G080Xpfm4STpw7Ob3ygwmf0q2j/XzMhfHd77cI+Un4nFqadIWeayDt6Jwdoa
         tPYSSIkNZIAYBsG6HkhH1982qhfeh6SMp66LCa5B5OK7nu6FXZADVM08PlLE+NYUrh2b
         UIML3XfnGEQ5KS288/HI+rFzGReTA4I9kxq2kHN6u9C3ttdYHdpcISSbG9oiiktdS8i6
         EOzprihHYIAt0KgxWMvcKGkrrvq9VDf2XhO8Ko4X+ym61PEfMf8kqHdzNNRHgVHtKhTd
         fFMdld6r72SH7vY/6gek52uHSbNXWslpLvATGTVLgP0qVOtsOXpBLWTz9LDkZ+znCsYj
         r9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782250307; x=1782855107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QkYPDWFuD/zA/v32w3fCffNtRlCkZzOhrXgNESmlFhE=;
        b=sKcr2LoLf+/f1ViNjJeWLV/XvezoZjXMvyZABWrYRd9rcOr8blLPH9EKfFH9U7VOqJ
         I07QUXuuIdGTu8JaUdmfMMeQCpSI5ErBwJhSEjmL5uRgIVq9b5tws3xi0HVJkaSvjZ+w
         XR9/Una1UcromsYPf9D/5B4ZsZU1AK4cIPdZKq31rE3ILfP0CLW4ANu550skQ/b6ZHOE
         +/BdoaftpMZp7W1zlGtPJKMvnQoDxKI/3FrLHShfwyK9brH5p/U0vcKQCNp4GaOAb5zS
         sjWCOk0zYlwE3ijkD+yM1ojYevkKSrmhh92ckALFekhcwcc6NtkRIcaQwLjUDaa/90Np
         uUfg==
X-Gm-Message-State: AOJu0YzinA0aQLHsBwAB+55o+l0lcQp1o7E0kTHZos3QBpTQk0UyWTJ5
	a87W641S4IFKjC1GrRLodljtYfFsVql8rvGHvFVXwCGy1vXpS7BMMvliuNDucmEzRohiAD4mgm4
	k/OOUZGFgqCQne/PvEK93OruNXr+iQ4g=
X-Gm-Gg: AfdE7clhqXdI1blvD+1ZXI8IcFyvxDthaNh+5lC9ZOsGWQgC9SPEo36ggNXafKxY+pp
	n6okS91Mbxb+nM1NnKaGeolpmBGgJw2rI1uttaJcD3s3uzaJhdJiRdNb4E1uElAoP7bengOx45o
	i/u3/zvnwDQvaCl3VG4/n5YwRgM1r+qBECb4AQOQzQ6G72UCBbL1YZhHhIXxcx27qGBv/hzKdHI
	PDf7eqxFUAgq5zHHcBI6w+8mlUqBKoTnxnjVv1WQWY4gRcDvfzxWu2Pv5AlJyzNcURxlpIzSI61
	LaImjdHaH3/3tyXF8dT/RdHtU/ePuNCAS0F0w9dT0gU7M6nKz+97EJSFHzmhiH+legSwmm6vLBa
	hbSAygd2RDO0NsKqbL8Os6kmPMx58gtkikmrqS+ULs75zcg==
X-Received: by 2002:a05:6402:2794:b0:697:e36a:283c with SMTP id
 4fb4d7f45d1cf-697e36a294fmr1936759a12.5.1782250306684; Tue, 23 Jun 2026
 14:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619175210.5348-1-rosenp@gmail.com> <87se6eeqwn.fsf@toke.dk>
 <CAKxU2N-bku8uZJ2nqtXb5nMhaPpxYnHqefNBj=WWe6HeKRaBXA@mail.gmail.com> <871pdxe7ml.fsf@toke.dk>
In-Reply-To: <871pdxe7ml.fsf@toke.dk>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 23 Jun 2026 14:31:35 -0700
X-Gm-Features: AVVi8CfIfvPJfBZ_f8kVCPDusGnKmhsuoLIa7QUC53yvDE1cWpfn_O_giQg0N4A
Message-ID: <CAKxU2N9NZ5n_hEuABunDBDJS_1P299hxd3fQ1aSXNsAYRJ5UCg@mail.gmail.com>
Subject: Re: [PATCHv2 ath-next] wifi: ath9k: mark static arrays as const
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38025-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,toke.dk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4A636BA446

On Tue, Jun 23, 2026 at 5:58=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Rosen Penev <rosenp@gmail.com> writes:
>
> > On Mon, Jun 22, 2026 at 4:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@toke.dk> wrote:
> >>
> >> Rosen Penev <rosenp@gmail.com> writes:
> >>
> >> > PN9Data is a read-only lookup table and is never modified.  Adding c=
onst
> >> > lets the compiler place it in .rodata and prevents accidental writes=
.
> >> >
> >> > Use the same treatment for bits_per_symbol. It's not modified either=
.
> >> >
> >> > Assisted-by: opencode:big-pickle
> >> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>
> >> Again, which actual bug are you fixing here?
> > Patches are required to be bugfixes?
>
> Well, or at least have some concrete benefit? You're changing working
> code here, we've had to revert patches of this kind before because it
> broke things.
>
> For this patch specifically, there's one of two cases:
>
> - The array is never written to, in which case the patch has no
>   practical effect
>
> or
>
> - The array *is* actually written to somewhere, in which case the kernel
>   will now crash as soon as someone tries to run the code.
I believe the description addresses this.
>
> Either way, I don't see how the risk/benefit tradeoff comes off positive
> for this patch?
const makes the array easier to optimize for a compiler in general.
And because it's static, it goes in rodata.
>
> -Toke

