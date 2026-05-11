Return-Path: <linux-wireless+bounces-36269-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA/gHN1ZAmosrgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36269-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 00:36:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE4516FC3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 00:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F3F13020AB8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 22:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB02383305;
	Mon, 11 May 2026 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbVL+L4E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFED383326
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538366; cv=pass; b=ISzQWonTcDKY89/onExd8Q7jYGe8ROKNhs1+2N8GMnrBpxBfES3V62e/ZAI/5/8uYrP0JbRsfeI3ebOp2LXxj0CDh7fLKKekdVSV40ms5pcg/ODlFp1qyRkib8sVR7N06lrS0OR68Y/BE/JtvJ4qZNQ4xgVCLPEjzGZtndRCWZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538366; c=relaxed/simple;
	bh=l/s3TIkqEL+5WLPIuBaC7pUXbyWhgdR0ZeoA66dq1RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/mGwXQRSlwyo31ys9yJIz5SsLeydLCCHSM7SwXjBC4Syr6ysWBsf/kkyaViRh1p4MUche8ZxNVlW/c6vA2MX6v7Smuov0lVJ+Lyrcy8ioc3H9WlU6ExCHx5FVwZ5wbWE4fSSAklo0ajMwXHswWwbUQOYELMA0xeavCNLeJwSSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbVL+L4E; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso42352515e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778538363; cv=none;
        d=google.com; s=arc-20240605;
        b=i9T7UHkpgkhauYxbFWJN3Ne86jxVt2MJB6e4EaR2pCAIyJzvaCUfRNZzGlGtGoiYuv
         ofHpSMxCZAPrNT+hh0WLrwb0iitGnsMiIwekkeFOBwdvyYUeJuoM4ZY2TBnGO/+oEu3C
         vS3GEXrKA4mrReK5YoOpLGM5fo6S2MNDNX8NMcxO6UtgfzIyYksrXC48pjy82K0AsxMw
         A+v0BbvJLOunNCdU0LpB11QuBrRZbXn4oAM8mNkJ39mT7Q+2Dkj/wOdbxqDSzeGtENtC
         jKYI25psxgamIrPYVXHB2/EgSsi3xHcn60Waw0afCRqSQGgXHhzQnka+LAV+13L6PR8b
         B83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/s3TIkqEL+5WLPIuBaC7pUXbyWhgdR0ZeoA66dq1RU=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=GMI1nibUMuyRJndBgkLEJ40F8vKimQKsoGGA4i59GBGljrdvzspH0HKXmgPNVnB8TP
         ukjIq8o9zxN6y877DKFosDb4e8WZ/OYJYmY0I8cwZrRV3FSrxViGrqPrAcJgO059c8e2
         bTWodWs0dArJTkVegHSQ5GaZmlj6HWI8Ill8Y6pBBw13MdbVEWAr/kVs9k8nWjlPnH2O
         Krkn9fAGGrOC2FHkIucyEWmazxji4/4AQjYGABMnR5r5/pOh6Z/xgxc01CsNKqjR4vPc
         Ad8LMFZfRe2K9BDtIan6oWhtVpXafz3EDZI5zVEp1FL01LE7lPoTUoEy1S8UfNs6ok9S
         BNxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778538363; x=1779143163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/s3TIkqEL+5WLPIuBaC7pUXbyWhgdR0ZeoA66dq1RU=;
        b=BbVL+L4E3qoXCnBe5R7p9CfloFOePp/WNCQyUuK2MKMrSoTTBhGimQZzPjlTJTlxIf
         JCpr7xMTFm/QozxpaCfVlo7bGccOCEfgcrf9dFBrbSyni5Wpffv0ivoPFRJ96fm+wcC9
         y9Z5CeJQov+FSSqM0qUGh1x+iv/gFLBGmdWtYaP2jQ9JGZjkH8jhpHAXyOq9Vq3EPOsv
         rlYjcIsk95FG7o3R9MDXVKOJV+TdQGI9hWJdM/PT2SwExC2Pk4J3+49/CiQzauJMBAPt
         vWeQ76LDZBplVnd36Bu387y1wKkRdq3dQ0HFExcRW2/NEzve9hxcP61qLlR3n0TNE+ue
         4RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538363; x=1779143163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/s3TIkqEL+5WLPIuBaC7pUXbyWhgdR0ZeoA66dq1RU=;
        b=ccXgVevr1zoiK1lJ4FEtEm++ztMEPCMbDRZHZK9UCL1Jd6yY/KPoZH4ObU6zzbwizZ
         jcGMV2mbqNQw5Oz/y6Ex2w7IpWXozX7LsiV+04K38ipJV4w+WSYHRekNcfqfqMoDtJj8
         r1wT4bvYwedzrDI6Odz/5njoML9kYGtjAItnDZl//zpSenfZ5bhu9J9orIq9bAlsKM0o
         ylaEUqnPuUi14dGbyvzuU1VBgH7SAHqMbwdmzApFZDmd86VJnEeUgZ2vCYQKhSd9GRew
         3WjS9bRrqcO8ISlSR+h6A3OrzpCUk45SJd8knKSrBaOP61MI+zt+doycQsurDY/cKnjy
         tCpA==
X-Gm-Message-State: AOJu0YwLn6VtsvxB5xhYWfYw8CCi/34EEVkkJ7ypX4D0JdNoMahlyvq4
	GYOwDAxqobfLZwZHNeQbZxGGNnLvZgR7G+vGpB0eqs7YPCnnHr6dGr2fBL/bOEoOxkJaqkEw+I6
	SIDG3IBsKXclFbWHvpLScJXfteavCYrM=
X-Gm-Gg: Acq92OGP5rtnWrmMlKp/tIXJ69TKsXvYJeWDbhpVkuC3BB0H+V06gnmVUPXHqEA8um+
	0Gd5ZYR5K7YZrdEoxEZCrWdnf3DRE4LvIh2PVpvcHBtNFNYXPjijxWLRqrMCcqkdi3i/mpfPL9e
	gQ3m5ndD+FPWil4Z0UPYw+SHHkT5K4K8BzHUwmFDRwsjeUHfwGuat/Pdotz0GvNayR4SoN7oQLo
	t7Lhg8WapCHwyLzsro/SUwPjKRSzquDWnytdis1nxt+uNgh9Ar612aKqvZn9bhsYGn2pb+twOF/
	f451oGBeb7wSgTWTE7LY
X-Received: by 2002:a05:600c:8706:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-48e70696dfdmr197141135e9.12.1778538362782; Mon, 11 May 2026
 15:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db11380dfbe7fff538a1a052fdfc5905202981a4.camel@sipsolutions.net>
 <20260509234143.101237-1-masashi.honma@gmail.com> <ecb7aef2f18cc7c04817be155017a54a45fa579e.camel@sipsolutions.net>
 <CAFk-A4mD=tKHMp8qqAvrsFZjmJHsA1sBe9Wmmn=qEacNMxTH_A@mail.gmail.com> <725b56f42b5fec58196e4055bccb74236145986b.camel@sipsolutions.net>
In-Reply-To: <725b56f42b5fec58196e4055bccb74236145986b.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Tue, 12 May 2026 07:25:51 +0900
X-Gm-Features: AVHnY4Kfid5P-syOqVCpHvlN3AgM8hXXhwzuD5HZEc_QPjFzdGjWlVUbfBSQst0
Message-ID: <CAFk-A4kwASJL4Hdb0TAkyQ38ZGx2Mom1Pn6cbDR7gL_c_x_4Sg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Fix overread in PREQ frame processing
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D8AE4516FC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36269-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

> Oh sure, as far as I'm concerned there's no urgency, I just didn't want
> to keep asking you to make changes too much.

No problem. The code is getting better and better, so your reviews are very
welcome.

> Oh OK :) Maybe we need that as a kind of Reported-by? Hmm.
> Or you could send a separate bug report email, say there Claude found
> it, and then do a Closes: link :-p

Ha ha, no problem. I am happy to tag Claude because I wouldn't have even be=
en
able to find this issue if I hadn't used an LLM.

2026=E5=B9=B45=E6=9C=8811=E6=97=A5(=E6=9C=88) 18:01 Johannes Berg <johannes=
@sipsolutions.net>:
>
> On Mon, 2026-05-11 at 17:58 +0900, Masashi Honma wrote:
> > > This isn't really right since u32_field_get() exists only within
> > > mesh_hwmp.c ... it's probably better to modernise all this while at i=
t:
> >
> > Ah, yes. Both the build and tests passed, so I overlooked it.
>
> Yes, it would, but it's basically not self-contained. More of a code
> hygiene issue I guess than a real problem right now.
>
> > > and restructure the code accordingly?
> > > Anyway, I dunno. Maybe we should just go with your original patch for
> > > now. Maybe I'm also asking more of you than others because you have a=
n
> > > LLM to help ;-)
> >
> > If it is not urgent, I would like to proceed with the requested restruc=
turing.
>
> Oh sure, as far as I'm concerned there's no urgency, I just didn't want
> to keep asking you to make changes too much.
>
> > Actually, I only used the LLM to find potential vulnerabilities, and I =
wrote
> > the code myself :)
>
> Oh OK :) Maybe we need that as a kind of Reported-by? Hmm.
>
> Or you could send a separate bug report email, say there Claude found
> it, and then do a Closes: link :-p
>
> johannes

