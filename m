Return-Path: <linux-wireless+bounces-34405-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO8vOgpf1Gm6tQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34405-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 03:34:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA33A8B99
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 03:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BFD2300F159
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB3221FC6;
	Tue,  7 Apr 2026 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzSFHsS2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79D1C695
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525636; cv=pass; b=Pz8QRYMHVYz1hz+3NsdZEBLVokYBe5CCKQewCFkNM8+Xi9xbMR4SAgXVkG1CjnWemry6Xp+JoCnmVnbYBqeORYTabAqhjvAWLE5HSlfhoIM10BS/KIo76xnmg3Nh+8/YGJFtnDIFf4kc+SgfgLdry4eK0OEhIXVl89xYfcRr22I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525636; c=relaxed/simple;
	bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6hmKEvaA/SWVhbsTOee6MDcnIYrdjLcBnfLo26aRbgFMYbdsrKGhajA2243W4MTiEzEJVjzAHQQvuED4e5WYhW7YurQNpVcDFbtBDaVskR7NTBrlUgBf2E98be4dCZK7JqdfAz80XRILlfB479n6mI2jh8b0DGJtLlExKeJPP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzSFHsS2; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a56ca653ceso47691906d6.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 18:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775525634; cv=none;
        d=google.com; s=arc-20240605;
        b=JZUwhOTf1A9Rvkg7A4P3+mlBhdr5L1emXACDukuLVdey1PuQa05tNledeOjfV10jBj
         0lzYwzCTZLrpzgCMiKFPWSZRlSVTk1skp6Nwu+pRUPIm/aMx8X1ci2nT7NmK5DvvdlQm
         ZO7HsxSQHRovafSSd6bpdD/UFmPl141XcEbTanh4xlVVaiEWWEWPhEiRf7EiCa4c2fsP
         04Y6Aueqnb6LK8vGkmNQ/qhKMjhIwjixpMeL98cxN/YrBpxUJfroAB1gr1LNUA8fdbb+
         FljRR9VRDYaXH6S14WXbnyXKH5oDgteuyME7iXI8eqXSHj9LJRHIVIPlZ0/KVJ5mcI9I
         8wHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        fh=LOx37V/wSy0IeQtOztTTXoAlWY9vfN2Vg6DSDbx4w7Y=;
        b=XYlfHtya2AqmmBbvufLnxt1y3wNSuPFkUccS6C4EMyhCgY1ePXyIeAZMIcZobWH3Rw
         U0LE64I6kAfZCLSnc9VfVXCGOg3ynYOLCk1Lh1XJgKVrJhbyFAvDFOSBtqpasqLvRcKR
         XvnVi2nM00U5f+JTBUWNdYbkWBcpTicKMWNHYVpx6MYe8Fy5ngVJC7FKpiArp7xs9p4M
         FVKKvsc+d0Vq/7/HJ/UZWq4gXwUCnLtgwHpLmKoKjfzewTcG2nSzRAWe5ZdpF4hSXd8e
         p5xbEuiviy8S2xDkpY6t+Ac9o2b0bVUldiUhQ9PUHEIuWuBiacPhiNJGezmZmoNRT5qv
         YpDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775525634; x=1776130434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=gzSFHsS2+LSeEfAyisIiX+v7cGWf53UuxRdlaOdcV+g/gWJY3b7CpLck+aVvS3y5p2
         NP7AnnxXF1/JBg2rEaikZztKBvrGJtbm8oCzR8BcUR9jybpb6iMZVY0pwx1/GoKjfcMa
         yjRNc4FCItEziHOJI8F45l96CuR/3F84lWQDLSPndT0mOzA0kcty+vnejz8cZIKqIWCO
         M30N7623h1KWMOFYPj7KJCpT+K8U3/PY0g0fB1P3WUk80qoyY6Z3Lzgzt4MVzTDkuSiA
         ugvGFaqFJAbjvexFq04TTrMslgppALp/o54V4kWX0UFe1+BKPQTCvRZqyikgtlMy/7lo
         8r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525634; x=1776130434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=R8Fo6dgp8kUX9tnD7rmEPL+g5/uQy5oNcYL8zV8myd8U1AoyNCS4Twv3KovNHbFGQv
         cBjM+IKmydlzITuaNQP6CHgXse6Wn1m0qTvzYiRki4TSWOIiiQQ4ck/M/GBQKkUS2+Vn
         YO7GN8gkXieJ1GlYud3QSKv6gnTmM4g76v2czkuo38XY8z+oW3lYjMTAh1JBAwp8UFHe
         GeKepRER1S8nwYWFFXn05cQ2qtTnApn9Y154a7jJMlSyEZsblS6e8JSvXBRn5fAznsAz
         0K+2PnhjMIrseTm6iXWZ2va2oxnidkAqotC8SH6wTFFLcy6y+NB6OJEGCgljwe/gjoWZ
         4LfA==
X-Forwarded-Encrypted: i=1; AJvYcCWWl2tszuKTDEDTXbwAGhpWFjYNCwlqBU8cnV8DMVMH+uRLfvZX0zxhOpoIqFlbYK8NAQapF6/2Q31exFqvjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTPRlWkPaOCiwtzAcUfaz5FZRc0NvKFw89IRqhM763V6oaQIE
	0sqRL4qlXgli0xP4Jegas74Kdn+cilvGf/4VRTXrhzqcdRZo+P/v+ZfDyCGcxiPTttGWkSUchoZ
	hZkqSCI1G4RTPhDB7x81myJVSsoa/aQI=
X-Gm-Gg: AeBDievc4q0e71DxQXrqsb1FBJ1wp/Ut4XUP2ky4dGWIRhN81SzHOzQGo7A8/tw8Hle
	CYJ/K/veFBbY+VL/DvCwz8Dfp6EMXlgtiQgLdMOtbxljWX1PnBAVKLEUzJoJEKRD10KSkjbipVq
	2958XuJst/0aXJhDYC+eVk+qYkO4TjtxB4JeiHXN112vqXKImpy/smOtgiEwwRlNqS1arxgPQS8
	jK2X9lm8HIB9qz2N0tEEZX7k9jMaYkg3d760bW3I+FSFKUHHt3OxAIxyFQOTrix2of3r+1Vl7S1
	4+wuqTOw4Md7vhvkuJ1T
X-Received: by 2002:a05:6214:212b:b0:89c:5110:751a with SMTP id
 6a1803df08f44-8a704ac00f3mr250748606d6.44.1775525633467; Mon, 06 Apr 2026
 18:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com>
In-Reply-To: <20260405154816.4774-1-devnexen@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 7 Apr 2026 11:33:40 +1000
X-Gm-Features: AQROBzCkX2gE2vUcwz9Vh41Dy86vV6V6vedD5cjTTBBq9Q2y1TRb7sq-3zFQtYQ
Message-ID: <CAGRGNgUpknQi6PzBWQXeAP0Vh7XjntD_-O4QyjU5tAn8_71=eQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mptcp@lists.linux.dev, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34405-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juliancalaby@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACCA33A8B99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Mon, Apr 6, 2026 at 1:50=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
>
> Skipped sites writing into __be16 fields (netdevsim) where
> a direct assignment would trigger sparse endianness warnings.

I don't believe that endian swapping significantly affects the
randomness of the data returned, so either:

1. Do something to silence sparse (casts?)
2. Live with the endian swap overhead if they're not in the hot path.

Other than that,

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

