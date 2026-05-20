Return-Path: <linux-wireless+bounces-36692-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD4LOCuEDWoTygUAu9opvQ
	(envelope-from <linux-wireless+bounces-36692-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:51:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1AB58B1CC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF1E9303030E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3F3D1CCF;
	Wed, 20 May 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5pZCmDG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7063D1715
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270676; cv=pass; b=sSt1mcp4Ns2pDQYRkVnKEg7seXhvxcRMhjyIe5DWJtPTvUKx1k3tvYF9CXQ7aq1j58ZiQKoAD5bglMPHwjFPp3tn9lA+LXLnbaXTQkDt4zyYmseTM+0l5I6or3XJngPeiANUF4xGgJ7e1PXJJ0eJueCxQLfcDW8HfWe1EvRW/0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270676; c=relaxed/simple;
	bh=2Eft/LCNyTaq855jfgYvAJS34v9zNa2hjVZWhbopFbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjJRBXE+M2x2Dji/wyC/hE10gJ+fFuqpBDAX5wttJc7t42jidqA9NW6cDgckthO/LJ911QllB4cjiikeoVZt8kJN523VCy8n5/woBHnp2mgHa0eBcw3yJcxvcYBUnfBOEa1oYMQz9Z5Sz3CjkMotqJkOlWcshx0TmL7PmDyCvu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5pZCmDG; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-47cbd445021so3210881b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779270674; cv=none;
        d=google.com; s=arc-20240605;
        b=N2kH5TNYse8SKBQIJwk/XxmNo+A14+PrZKivKfeGNi39z2LePSCGfip8b8//8HQ3TH
         OVJZTe8XoDrrUOZvOBL6u94gksoCq9PrzCbDpX+EneBI9SYXfN2hhytrRweGEqXXRgIu
         PQi8EdGdC4uh86e4+vHI/PnwHu8PYZufbVXFhcFgxR3L4xmiA+75Iid7VVZgX3mX+dt3
         sQxonfhNLxgKAOubpdRimd0MY+K115H921xPutbQcmaw2JS9sQAJ8+noNzv/Zml1zKLT
         HrQANIuPi7/oO/mB87k2huIUVxssXjUwlwoe97GoGUaKPEEmUrVgZl/Gw3ATIU8M83ol
         RscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MZlXLFzzeId8tlIqW5oSoFq5M2aS9QNPvTSGjdbnVzw=;
        fh=aABBu2N4+LMsh4YJhayTNgX0pAMuwgQYTlRqgr71QkQ=;
        b=Xz+jyReGBBYwvFCd6TtLgc4Hd5eGyEoJlVi0xIJM5f8z+RfEZclBPqOqbrWEEwO5LV
         Kl/te0OQLsPs9tiUxpECNTyjevv5c0LncSdyOELBFd29Xv6tO71VzAcE0kh3Z1xtlYDP
         SxEVTn39Ow3mth+LWfChPhtA/fiwethwXMcLUMWiFPe4h7t6DjmhLQ+IBwGzSonymqmx
         TkNm8FmB8QgfGsuMZAh8RmKQt9pH9ybgPUDGtrn8UAcqoLeOv4XnmkKa/irUyIjKk1pR
         EouN3IHUkHKEycjvK3Sn+Fj+vzFRERbQmvxXMPVFfOiKjQ6sw3TWDtNvPASFMR13Awea
         Yw/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779270674; x=1779875474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZlXLFzzeId8tlIqW5oSoFq5M2aS9QNPvTSGjdbnVzw=;
        b=a5pZCmDG3sM5KQzvnDCbhPwbrRoNdIEZpAsldNL9N8ymI0mJHAvZO++lM9ag2QjKWq
         Y/mpAvZ+Wg4Y5HqOA0ScdpahfU80hONu22jV3u7c+bwcu7p29ctvwmR1E8a+do9Dwwdg
         1oELqIizPqyMQU+dJAyzWHYeU1vgRYeLXuFEGKuXNYVryphtZBYB491lduCg4SweOF8v
         jlHJ72PA/trt9dT88isqHhKd8Miou2bd/aPIkeVKEigu5CRKcXZ+kyjrSEUBH/yRF1kS
         KjscsXgPKLT7piRCv3XAR/tLjqaeSRNpjcVC++ydr5Z2QcmBuQ3Of42ZbewLQFP7gSgn
         7hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779270674; x=1779875474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZlXLFzzeId8tlIqW5oSoFq5M2aS9QNPvTSGjdbnVzw=;
        b=P7OUN6c1hTw7Ppk1pMya4tg/c7ie3IwVbizIwXRS7hU+pIUTHd6uFgNNKkM+jvXEda
         h486H4jDYbm08nIeYCLksTjrJwQ2to4oNEhfFXRo0VkOHaZb6kcYdpPPF7I/yb4gMchL
         +hUs1t++kiuWrzrykjatamOsOqW0iiGhbmJxnVQV1FsKBDvRGoCNcEP6DJSOl2vtRRvD
         pKPeA1V1G1OKgGc1c63HVtUP8YvQPlhQ+GVsIHj/WmHAX8Ra/GL/OQ4qUAd2i9BUQed0
         Ot5vQmLjP+/wgXpmLb1BdPUFQ8X70jeeYi/wHlvMayZf2UwavAtDIto7yAU8rXM2H7/p
         nARA==
X-Forwarded-Encrypted: i=1; AFNElJ9pQSOpr+8fSaTfjNFVLtMeZaUL7kuzz19fZp2Ovbj6oymSxQmTvtKCf7Qb2AnJrgkmi0tUxB7Wu6SudClEKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8U2N8qOTtAdOlzOuhScqgG9CCwbIpfXiKcsUU6+KcZuKGkn9
	uIabrCGBJffaYw2DLzSLmyuhFnhjcj2XEsMRrLwb1O3Ofueq4whkZlv9vhsU300gvm0DC0guqn0
	a8OpUjykJd5uZ0zQxObNhjEIZRIOYKHY=
X-Gm-Gg: Acq92OGPUkN3fr6HAEDAqCp9mx9ByFjiSUt3DZDqEzVn0dl/SAtLbMXfou0VYGxAuwH
	jkROwVfovplz5riD0nQd8lQ2lAEdpA+aF7MxBB+5RZZD11PTnHjMUN9WBBW9pZmFZOwODV3nQ70
	wWYH5wed4xx36/Wh15HLgLpaRlk6L1bFA37wsl6iMno5phH53u0h9M3Ba3RJZ27iSyvVTXaDJoE
	1JfV/FxnLOxyXn3Oys5oJNgAenM30m6TId1lOXDrMi+VA6FZ5rsOmJhSxbBeUfjYWZKt4KxKaZs
	yu6Z9MRb
X-Received: by 2002:a05:6808:3029:b0:462:aa0f:4375 with SMTP id
 5614622812f47-482e5789699mr14575015b6e.39.1779270673811; Wed, 20 May 2026
 02:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
 <20260519235713.49109-1-lucid_duck@justthetip.ca> <20260519235713.49109-2-lucid_duck@justthetip.ca>
 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
 <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
 <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com> <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
In-Reply-To: <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Wed, 20 May 2026 11:51:03 +0200
X-Gm-Features: AVHnY4KURUo3g9b9wuzddRfCmeBmlTt3UJPt-BOHJwYs63Ib6XGnntkDentAHQQ
Message-ID: <CA+bbHrUqh+nu_eKBMVaPH6Q8YxuKS=S0kON2Zsb+gRZHU=SBPA@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, 
	Brite <brite.airgeddon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36692-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,nbd.name,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8B1AB58B1CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ok, let me do one final test using Johannes=E2=80=99 v2 patch. The expected
behavior is as follows:

6.18 or lower: no need to test, it will not work. It=E2=80=99s clear now th=
at
this does not matter, since the goal is only to fix newer kernel
versions.

6.19: some versions of the 6.19 will crash and others will not. The
crash was fixed at some point between 6.18.12 and 6.19.12. No need to
test.

7.0, or 7.1: the expected result is that there will be no crash, and
VIF + deauth will work only on 2.4 GHz. It will not work on 5 GHz
(I'll test both, normal DoS and VIF+DoS). There should be no crash,
but it will not work.

So I'll focus my testing on 7.0 and 7.1 and I'll get back to you with
the results. I'll be testing this patch (v2):
https://patchwork.kernel.org/project/linux-wireless/patch/20251216111909.25=
076-2-johannes@sipsolutions.net/

Give me some time to do these tests. I'll test it on both 7.0 and 7.1 kerne=
ls.

Thanks and regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El mi=C3=A9, 20 may 2026 a las 10:58, Johannes Berg
(<johannes@sipsolutions.net>) escribi=C3=B3:
>
> On Wed, 2026-05-20 at 10:02 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> > I tested it on 6.18.12
> >
> > Let me know if you need me to test it again or whatever. I remember
> > during my testing with the Brite's different patches that is not the
> > same testing it on 6.18.x than 6.19 . Some stuff changed and the patch
> > needed to be different. I've added Brite to the thread, he can add
> > more useful data for you.
>
> I guess I don't really care about 6.18.x or 6.19.x, only about 7.1-rcX
> at this point. We'll want to explicitly _not_ backport this fix to older
> kernel versions since it caused driver crashes.
>
> > Regarding the approach of fixing the bug on the driver side... I've
> > emailed and contacted by IRC to Lorenzo explaining the problem... but
> > I got no response. So if we feel yet like this is something that needs
> > to be fixed from the "driver side"... how to say it softly... we are
> > f***ed up :) . Maybe the "hack" way dealing with the vif null var is
> > not bad idea after all as it seems the only way to move forward.
>
> I feel I've tried to say this before, but maybe it helps if I summarise:
>
> There's one feature and one (possible) bug here.
>
> The feature is:
>  - monitor mode injection works for chanctx drivers.
>
> The bug is:
>  - monitor mode injection with the feature patch crashes at least some
>    mt76 devices, which you reported, which I consider to be a bug in the
>    driver that needs to be fixed there.
>
> To me, the trade-off is crystal clear - as long as the bug exists, I'm
> not going to apply this or a similar patch to enable the feature.
>
> I'm also not going to apply a patch like proposed before that hacks it
> by redirecting the vif pointer to a (more or less random) other vif,
> that's a lazy hack that happens to fix the problem in your _specific_
> use case, but will almost certainly still expose the crash in other use
> cases.
>
> I do think there's a chance that between 6.18/6.19 and 7.1-rcX the bug
> in the driver has already been fixed, that's why I keep asking about
> versions etc. But I also think there's a chance you're just testing
> different subdrivers of mt76 with different devices, so I'm also asking
> you to compare the specific devices.
>
> I'm happy to apply this patch if the people who previously reported it
> to crash (i.e. mostly you, not sure about others) are saying that
> against a more recent kernel it no longer causes the test to crash
> (rather than just not work, which is clearly better than crashing.)
>
> You could always just claim you've tested this patch without the crash
> and I'll apply it, but then if someone still finds a crash I'm just
> going to have to revert it, and we'd be back to square one.
>
> I hope this explains what I'm thinking and going to do (and not do),
> make of it what you will.
>
> johannes

