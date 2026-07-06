Return-Path: <linux-wireless+bounces-38685-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kML5B2a1S2rbYwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38685-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 16:02:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D5D711A8F
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 16:02:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qMi9Gsc1;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38685-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38685-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B211430B0D5A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3D93750AF;
	Mon,  6 Jul 2026 12:24:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910838F954
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 12:24:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340698; cv=pass; b=Na8e/YXrjGWcxfdZCedEKf1uti060lLQpnVwZmsnkeQweKL7LozkhouhN4Tm31STPBgWzhAAclTdDFzt8N37YTDHJV89oD8zhWA7+ME+zBQdOPnhpb/wmmbIs+07fWcvqb4ZmAMopZ1w0+eIUQvEFSDgtPiKZHWukXFagj0F+LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340698; c=relaxed/simple;
	bh=JMkneVkqCg6dM3WN1axyX578w5AXsuNJAdEyrTiHM5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYOOnrhAHpGQTOvWzbDs7ayDn6sa9DbSbUbxzpSeHQFT1/NMkgK/7tFYki1gYBmaxiv28VEU8fM3csjsHQboeslA3UQIxCtVx+p9hOhl9cf1RRta02uc8IrsIeiiPSAdw/0+d4mo7vGU3bZvtFi5EtbFStZyCYgugHiquKIyga4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMi9Gsc1; arc=pass smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80b9993928dso37792097b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 05:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783340696; cv=none;
        d=google.com; s=arc-20260327;
        b=o003ostY1apVpGHmn5ftNNJD+dVbZ/y5TuyhTy5wlQkTDFNydelD1bVimvUhi8tFmZ
         MOz9DpMxADN8T8O8OAMIe9c+viFcVCi4ZhFLiYnyKyQmppsfOoauM9lp3yi7/290fELW
         oLfkBfpCGlrPPWsmYpNdPyDggZymsWwAMxxy5q8MmT2kqitjDEFfX3mf7cJh1QM2aR3M
         Az+ldQdUgHF2iC+RDjTW3r3DG3fPyrs0BTY5rBorIZMKfJWmPNOPa2U95D71pYWXGaI2
         0PqAg8OS1ezXqj82vn6Jtp1lw/uJz999LAlnN/eco1ygUf/GXsFksO8ArMtTgq8zfHkz
         Mx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aSXZJlHX2BQWrJZ2Pl1KFw3K8osObwUXNLmoF92Klrs=;
        fh=gosypC5zA2rbq2qIIZgLbffsNTzYItMoXUG5Ppcg/x4=;
        b=F/jpAAGGyYIDAHdyvdLnyzVv6l2GxDOLiS4i0uUbP5e1qBQ3BuBgGI92bTeJ3kutBS
         alY97TgNmypSseVlFFZPyWF7jNgWTQIXrZIdVSJFh/3/f0YEkjHppgTQE31Y/vXAYtQP
         8wZvuqsgZVu2nrM/QTWJG1XuvvdYn3ENRx9TQqXqnEddm21ZLMq3D4LN/V1A1c9NGcd7
         59PCPZClqeCTfmrXphHS7yFEmJ1YSLWS6y0Mwn2qSTGI6m2pz80TWxU+4P77IskZvxi+
         rCjmpjTKfL4YJBM9sSsEh2J99zHEaocyyxb/6xltCKwu69d8/wxQxxrye6C3AaAcK6k/
         GyzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783340696; x=1783945496; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSXZJlHX2BQWrJZ2Pl1KFw3K8osObwUXNLmoF92Klrs=;
        b=qMi9Gsc18sRuzos32BQP1XeDW9QxjAqct43rCeepurtBEGa4EcmlDaRWlGP3bx0EYm
         zQnoU4IQ/VD9R+Q1JMam/D6d8497u0JIlFjajK04Ghtm0BKDKo6pYwkQYv06xteOq3Ik
         3PVRvkbmA/qzEOY2177YSBxBSAVhlulsGw8ORYA43G2RVr/ulOae7aNxXxsPriJgXEsT
         8V0xtzeH77V/L0/oWsUQMzCLu0X35Z7nyeNepW+IprAeyHCHbKG+pj2Q1AS4WUTG99m0
         S95MS4bkHHpCUnrueXuIfBsGUGI92UsW+F+PgIQoywV6YAJDiFjFdn9fTyLM5WCzM97d
         rPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783340696; x=1783945496;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aSXZJlHX2BQWrJZ2Pl1KFw3K8osObwUXNLmoF92Klrs=;
        b=N9KKB2HkwDFpf7ZRPhEAqk6rLFdk52gf+XimiLxJsDTRsDoQ7NmXDwvQ64c5dRGsty
         ZmhSEtMV3PDQl2FFHp+pN8hwHlXS1e/cywLsfwynKz8kOxoN/syt5DSAeP3ru1avVH9D
         aehHJUgZaqtyrAMlcI2T2WM/+RCOGMfgUgG4jTdwASJKoszEDHnsl+2skxEzlv8ejnFs
         WGVDXQAOl4USKKya8PuSbgWAptPQCBA0pf42obEvJMpVydQ0d9RXmqFfYFvltL3vUbXq
         ZyZdRrJMr0jWicBh7YVHSNYqXd7GpIdzY6BHL0UeiQ06zTDYEG6XJzVDkS/olzB+vCnn
         bYqw==
X-Gm-Message-State: AOJu0Yyq3DyvpBNsQwHy9GEOmkN9SxWdZrBG19SSIiXXj4LjZx4mz1qy
	h4dc+gUyTnvF2paoZbA0clXKF2aLqLMit9PGyiLEeKSLa0PCC+gGnQLrqfmraQtiHILCIvN5npc
	vX0Zw2vIuM14gD8dDDhQ8lWGMB5XyYmk+NzG8ZLo=
X-Gm-Gg: AfdE7cklRJy+c7Ge1rf2R3BKE7tpNQ3knFG8H/XZ/46/2t7cPODAHXGBL4RSFZejVWH
	rJ4UxCEuaPbSLK64DkCq9nvUXRGdWD69T8vP6ryvWdHXq/l0mJBpvOaZ6C6hpDM+MXtuye8BpzI
	l/8OFzJibpiqaW94sXfbkvq4hWGBfxGoFLPUR9Sc/Iwz2C/7jSTVKgaZcrLs1pOT3GncjWRdpAz
	gTmOjXnpn1d6Fcq/w31qT1M4BZ6BKU42MztxzxtvxmhSm2PP1Ioki5X9EtmSTh4xJOTOXffgUw=
X-Received: by 2002:a05:690c:620f:b0:80c:aff6:9d47 with SMTP id
 00721157ae682-81be06433e8mr171057b3.4.1783340696084; Mon, 06 Jul 2026
 05:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619162500.3876325-1-zzzccc427@gmail.com> <4fc7e89b3203e9bc8843c848268519d34585a038.camel@sipsolutions.net>
In-Reply-To: <4fc7e89b3203e9bc8843c848268519d34585a038.camel@sipsolutions.net>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 6 Jul 2026 20:24:45 +0800
X-Gm-Features: AVVi8Cdea06VLYDYhA5FemAIFJQ9NmlQeeEbK8-7QTkyKqAd8O6fl398aRCZ7KA
Message-ID: <CAFRLqsXDDO=fzwwe5eNEkS=qUjf9=2X=NrX+LcZ+TNkMN+fF5Q@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: serialize socket owner release with netdev teardown
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38685-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74D5D711A8F

Hi Johannes,

Thanks for your review and comments.

> What's that supposed to mean? Of course there's ordering between those
> two things?

You're right, that wording was imprecise.

I didn't mean that NETDEV_GOING_DOWN and NETDEV_UNREGISTER are unordered with
respect to each other. What I meant is that the NETLINK_URELEASE notifier's
schedule_work() site is not ordered against the teardown-side
cancel_work_sync() for the same wdev.

> Yeah I guess that seems like it could happen.

Yes, that is the race I was trying to describe:

  notifier observes conn_owner_nlportid
  teardown clears the connection state and cancel_work_sync() returns
  notifier then queues disconnect_wk
  unregister/free can then happen before the queued work runs

> That seems a bit over the top vs. just moving the cancel - why is this
> the only correct fix?

Agreed, I should not have implied that RTNL is the only correct fix.

I chose RTNL because netdev notifier delivery is already serialized by RTNL,
so it orders the existing schedule_work() producer against the existing
cancel_work_sync() with a small change. But if you prefer moving the cancel,
I can rework v2 in that direction.

My only concern with simply moving a final cancel into
_cfg80211_unregister_wdev() is that this path is called with the wiphy mutex
held, while cfg80211_autodisconnect_wk() also takes the wiphy mutex. So I
think the final drain would need to happen after the RCU readers are gone,
but outside the wiphy lock and before the wdev/netdev lifetime can end.

Best regards,
Cen Zhang

