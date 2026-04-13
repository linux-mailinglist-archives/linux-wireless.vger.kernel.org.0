Return-Path: <linux-wireless+bounces-34697-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBYDESjj3GnBXwkAu9opvQ
	(envelope-from <linux-wireless+bounces-34697-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 14:35:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DE63EC074
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 14:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9F7B3004689
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D93BD224;
	Mon, 13 Apr 2026 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIrgmp8K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96A3BBA17
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083746; cv=pass; b=ifsrvM8HkpZz3GnOpEmf1/WkDpcAczEdfOOudxIYNgaBw0SQBvAdUoa+vQE4OwJ0dnQH/WFrpWHdHIvI+0zNn6EJ1x/TXdRjHKUXCC5fpmHdlrPttlaF0NkNA0AtSegA2tmg/kJTEQHIYmlTrg24qAFSoiDzFBtiTHQuGeQdsxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083746; c=relaxed/simple;
	bh=Ot3nyMzVrKGWoI2SgjQ3cEgVtxo2/lT4pgbrYEFAmH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4+fgg/TMbTAVxC7Qf63EPkoWJPXOP9Cnk1JEc+rdDmWKuDV3zwug8G3BVD7XG3U5PQNyMVq/DHGKDP2TyBzZ5//ioAxPVQ7IZRCb6sjKwpj4mwlmR4u9i0eCWpFRgNoR7xnGZJPD9MLqRNN3d9p5RGQUf4GQQkYd1Dr98nv5rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIrgmp8K; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so1983989a34.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 05:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776083744; cv=none;
        d=google.com; s=arc-20240605;
        b=g9VmfZOxTW2bJOImskYKhZntSlrsER61FL+gBggj8JUYPxTEajnGjY+BTHkK0i8s/+
         0U1gdUrjIoQtKE2nSHvCfYO5/SFhWkz+oNh2XyJWJ+zQibk+9E936WuI26BL0QXsyGPE
         uRBzbCDx0D0AgbmtnckSXzsdVLOZHX9AK5PAfkGxUGZ/x4eXX0fAvLV4/hXqdW1fhSun
         G6zFiFwF6759OZpMcNLHRVdTFZ7+zQBDAWibYrZitcoJ+EJZsjgcVjXOjzHnGJyQVhik
         RdqabO0JSKAMhsPxUjb2qoDwJesoVaJ0SjZ23fLfWcYfGfRCSgghwDemUS+RiGh2hQq1
         VxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ot3nyMzVrKGWoI2SgjQ3cEgVtxo2/lT4pgbrYEFAmH0=;
        fh=rKXnWmUXQwH24iM/tEIIEVSCoARKCG/7bLoy02KTkRM=;
        b=RA5pMjMinCaXRE6RJ6B1E/tLfsPN9SfKvTgiiz07sYzhSd4v3fs16UasTnVfoeRe2w
         lWHC05E8Du3vnBMQnTDN3NY2rLYqLn6HFC43n16856Q6IM1DNhZfjDOH0icIb4ZFCXhP
         11sm1QI85w5cLVn5Kx9vCSEYfMhi1r/0Lou4n3M2RWCeMtHk58nwLjpmmzkBAiDkdCpq
         UhjRIlFZkfcQcvbbR+FKM5mUOnwLc9p0Jd0893v8Ofev0zikc1BZmeR5w2FKhbUldaX7
         I0cc/lYATXd1UA1aAw55OGgXHou6LdeykP+GTY17TAkukE8hgyK25e0q3PvOmFnqmsmM
         nfKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083744; x=1776688544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot3nyMzVrKGWoI2SgjQ3cEgVtxo2/lT4pgbrYEFAmH0=;
        b=dIrgmp8KSgfD5haPCmlvglMhk2JwqlY/KF6cxfTj8lJ4+Mt8q5T89RbK6xXaet4qMS
         npsTGmnGahj2z6cDR+1j/2naplnNVO4nZl7GYb7J2itXTOfXMcczy96ioKv6ht29BJUJ
         bQFEvcowjYP2+PxucGul6US7AEpFC0RuBiMqw+VDMz7UYZ4TVERXJgRD3q0ONrskHTwt
         Lt+/uwp7HcYvxpZAo9nuDlh6RdP5ppzD6kshRiz59HM7JJZG5htil2qoAIRcqGa0B/LS
         qu5Dw9TwXLQKxEF4iyZ22RpctezyT2biUjTPxVDvRC+ipFfudsTcfI6KHU8DwffSZLjP
         FJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083744; x=1776688544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ot3nyMzVrKGWoI2SgjQ3cEgVtxo2/lT4pgbrYEFAmH0=;
        b=tKfg4rg96jw/DmPf34r9l6TYs/KQWOpAbp5K6yTPj2Px7xrBQavpgOrzpGzP4qrBvx
         ayksI5Xg+nRZ1yNBiZGxo4Mqf0xfxmiVvB2ECRK0u5+P1sO490qlfPHelnctlfi82h1r
         RFYKuCnK4dIocMxfD6m007ynAIY7VNpTVIihKcbrkXgkwR6DMaTQJx4CCm5Ci/S+1/Vv
         zYJi5wEA0VZZnlPYLTO48oOBcTKYBe8iAZT5fx36Gje3HG/yIOI6I+GBe4gaVhk9VRt6
         xQCo0xpG5DY80m2TIJ6S1glu7f9vHjfxleRYKnnjxVSLQZzTtSQy9eGtGLWwn3pw5cHB
         xnaA==
X-Forwarded-Encrypted: i=1; AFNElJ8ePBMoQ21e3EL3rVFHfKkqQfWIx1X3xU775yK5fIGm0v7ryVKCuK+R8+ZZgHCvRoL10HyoHKFbSFifbkbjnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNAH+b5zvPBeP0cTugnJuxljdozysiVmfR86rjJwFjZcieLgZg
	f6EUBKbYypJYATlJlbwL7DF/G/IKRVc5RwGULSTRp019igQj4MLv9gCdRqNSXfWugW6Ov6SUEd3
	yNfsKsTKsNF/ckxXxWmU2wBgveMyts24=
X-Gm-Gg: AeBDieteQYmPWwzZ+BZxSPc8hpLgK9z94MkXLp3ikQSaDDYxJKMFtDHSpIyrim+AS7R
	uVc1CVViHSMJEtz+46/ALnlr4+wIDBVpwAfCwaRKukxiZaOE34en6GkBxt2+nxJAuZS3vyPAenv
	419XVloY4aPBtSQQh0mYakTI/9EFpEwtKjQDLj+4iUhHp1x/qwP9RsYfMr88qelnKVceanyK3ig
	lCkqlt9beZjyv/xFxF/FNKuzKzOD4WGbicbCeRNzA6LT+Njy1SuDQN9oVxQ3hJfH9t06y/N3+7M
	vl3yyEBr9pm5R6dwP6c=
X-Received: by 2002:a05:6830:828c:b0:7d7:cb13:3fea with SMTP id
 46e09a7af769-7dc27db661bmr7953176a34.18.1776083744514; Mon, 13 Apr 2026
 05:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413100249.28618-1-npetrakopoulos2003@gmail.com>
In-Reply-To: <20260413100249.28618-1-npetrakopoulos2003@gmail.com>
From: LB F <goainwo@gmail.com>
Date: Mon, 13 Apr 2026 15:35:08 +0300
X-Gm-Features: AQROBzCe4kEuLMn4PP_BqkhdxKKY0laQ4nGzylN9jxLNecOi8GhcYAxEhkwG_rE
Message-ID: <CALdGYqRLsPs8+kyAYphmKxfN9qF=1aGgn0O1LaASmjkDSUup_A@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88: Add NULL check for chip->edcca_th
To: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Cc: pkshih@realtek.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34697-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47DE63EC074
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Panagiotis,

Thank you for your interest and for looking into this issue!

I appreciate the effort, but as I'm not a developer, I would prefer to
wait for a review and approval from the maintainer (Ping-Ke Shih)
before testing or applying any patch =E2=80=94 to make sure everything stay=
s
consistent with the official direction.

Ping-Ke, could you please take a look at this patch when you have a
chance? If you approve the approach, I'll be happy to test it and
provide a Tested-by.

Best regards, Oleksandr Havrylov

