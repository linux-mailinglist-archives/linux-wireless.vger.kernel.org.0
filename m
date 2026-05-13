Return-Path: <linux-wireless+bounces-36379-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBpKKJhABGopGQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36379-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 11:12:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC85305C3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 11:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 189113067401
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42093E63BE;
	Wed, 13 May 2026 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7ryPilF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA213E0C48
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663513; cv=pass; b=e/byuGLe/0/bfdQ7G7fBZ4ANx0j5Rs6sV5SinettF6vH0/PdtJbCRSJhxaxy7xboMql2/k3TrqTo0DkWEdOxfDedxosw/qlA9Oaj0Z7/D6EoL8ecAy+UMT6yMLKhFUuenEI1MZe26vHHsmxRag1wOU8b8YWDVZuv1d8E/j3u4qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663513; c=relaxed/simple;
	bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDp815g/T0LxDFMgAJlFSWw6PMd99yKJt5gwVu5vOYAWkBB1RZVhwUwjIsyb7U5mVOHPY7JO0MgDaFi0fbdXoa0ZQdJ88nuEx9EVgnj3lKiiYngdeAQSTuZdYEfosr/hv9pZbb0myMBYfPY5AuP8lM9OE4Y+4gZ6b2sngq7VU+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7ryPilF; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a86d384ca6so154e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 02:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778663508; cv=none;
        d=google.com; s=arc-20240605;
        b=c9uR9rvZasjkvdpoguGQLE3pkHkTF75JdjuhePzghrAplqkKKYdP6a2h47mYcVrDar
         u//nOqvByk60ng+hPpVjJrMZmfNMkxBAlQYcETOut8SSlipLsOlvrweOZGL0AibG8sn/
         7IgWANYi97A8AGRAhBSzwOLLI/XcjKJi1gV7COlhzFMBnaxAGX5SxNFMIUa5nUdfDrd/
         IPQRl0qZWJarjUu51Ygf9qkZxIiHz4os7xbAQoJmavmTPZHyoJ/32++F2CPBgk0phbGv
         Y7E/qyCER6ASd4R3veBYeyWOoZHHYAusHKPskrU4mT6orravWIlAFCXJJMHJLhmDHPtR
         rH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
        fh=duuVRguYiclAdu3ZclLZmvuLoHT1wZK+clyYHGB4a1U=;
        b=FKer5ucna/z6rGEDu7/9adqt9DlYq8nAUeej75J4TI+7leCLD84wjjo5qoTPqno/3w
         BOHBaMTM3GpkGUTE08iD9NSQMyPK75d9TNmdaX5lE/pYbQXQR/GFUEUyplpBUki4HTRr
         hbwsbzjSq/wmJIic+/1XchnfiroYnq/0boT3jVtnZnJ/rc0e0E+I95ce5wh1U30R2sQy
         Z1IniWCKJhqLonznbimj4bdwiKlYB4dNPN2ySioc1P3bJ+G621N6tbZR5yxyYK4T3tU4
         iJFKhxBWB29/lPzbcf30eHsW3XvPn2v9TVCtsnGbZrnAVmJ9JQ2tkmHvhPCvXCTrrWUp
         u+HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778663508; x=1779268308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
        b=S7ryPilFOx0/UAiSqx0Yhty3Eu8rBXOXDy1/PjJlDqDZuwVUEGoYZ+ahFB8pt0j/Te
         7xfUa6fnvFpSYRQdMCS6op4+ZOybEB/KRuEHUQQUHhYFhhjRcsE5mah2RQ4R8au2k3DR
         XPKOTL6TuzW70m4/k857B2eqS8UIalpaqeqV6WNNa/zidj/vIHNQVVFkYvVbh5AuX70E
         XeXTNiKZWZ30LvS8MerGab6bn6pQv+cAitV5TbIEgBgCHGl0WyJVB9U5iUoPenv5vZa0
         wM8z31ab0uzOyJuM7V4Wl8GUqYNEHuJhP2o776ADF9x3/uuD0pHkBHpY0ONYiY41iZs0
         055Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663508; x=1779268308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
        b=kJejIEezihyPcS/KNwmDUBN76isjKDQaP52BM5HsMyAnOJNLZ0EffDxEM7C663vzut
         yRKRwKYhUA8v9QYqdWLqgguvqg4E6/rKU3sFhCVaw6foXSxO1TMFpebM9uDwa//sY6YJ
         to1eNLe+nDhrhESF3BtA/F0sDYvkZm6LKJaradjVNwgoYl1cGxzk5tW74lCo5LJ74ys8
         Ws3MZzjdLpoLLyRMSWmkcP8UKllxHjNy0gZMMdEnXa1tWBxJ31Gw6pWHbcrTRNxyRYu2
         QOSEGgl+e79l4WajBvtFkLGWHdj3F0UjuS7gMuAd8lnppwbUrY7SQVacJ8y67gWHy9Cs
         69Ig==
X-Forwarded-Encrypted: i=1; AFNElJ87O2gEfPezd4E9mtsrIK042BZqRXcj59P18yyuxhFDPje+mLe7UetqAry4D7IhmPCan/7KZs/aW5tTqyDxfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwivzJZ1y2v65wbMzfMkO/ZQFNaCbTG3f5LmrLkLAeLyx2fmCHo
	6LiWtI+SGGLkjpx2JOaWBxxLHs3QZ8R2g8gNfUto+xG9i8od/UpF15JE8YDMUwWLGUoi/K4gzRw
	cKP1YM0vm0zO27ACo2d7FQE7uBFn60H4CQB6/PVE3
X-Gm-Gg: Acq92OGCt/59VltNjeqbcpwJr6JnlH7e+uh/yVD6oEHMXi3mLOOJWBQnBjpCI03S5F9
	AZpu92h5zq24Au2YQy20lmbxhXG/Qf6nEiNHAiur0Xyz8AEwyFnf2bB/XLoxpJNuJbfFXcpixUx
	GqJ+b+6fx0RBCFLINEZ9pvvul7kr0eubagLMFJXvQQlUGMNN/pJhAWLcn6Q615UPVlDghHFzO4S
	Oi6W3d+HtnFTmuLspeFnuBLmz7qHKdcHdRjC7UffGoSAAqzrin4uWiKFm22zFizoYZ984n4XWyH
	AAmbLc+t14bgFSdFa/+v3JO5/VjY2uL5yqsC8HOxVa+Erdrk
X-Received: by 2002:a05:6512:1146:b0:5a4:462:a470 with SMTP id
 2adb3069b0e04-5a8f1a27ed7mr127165e87.7.1778663507927; Wed, 13 May 2026
 02:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com> <DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
 <20260512140532.f16379be75ab006f2cca4747@linux-foundation.org>
In-Reply-To: <20260512140532.f16379be75ab006f2cca4747@linux-foundation.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 13 May 2026 11:11:34 +0200
X-Gm-Features: AVHnY4JkYKmjfMjoxQK2Kv5dUgGHN1tiwBYPl837ha0neUHazremeoJt4lAaHiI
Message-ID: <CA+i-1C0pUX33A6zPFzk-2UtiQgAZG3hss3-aNcf1RYauUuQUWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Stanislaw Gruszka <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Allison Henderson <allison.henderson@oracle.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 41AC85305C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36379-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,google.com,oracle.com,davemloft.net,redhat.com,lists.freedesktop.org,vger.kernel.org,googlegroups.com,kvack.org,oss.oracle.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 at 23:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 12 May 2026 12:58:20 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>
> > On Thu Mar 26, 2026 at 12:31 PM UTC, Brendan Jackman wrote:
> > > This patchset used to be about switching gfp_t to unsigned long. That is
> > > probably not gonna happen any more but while writing it I found these
> > > cleanups that seem worthwhile regardless.
> > >
> >
> > ...
> >
> > Any chance someone can take these?
>
> [2/4] is merged into the wireless tree (I assume) and the other three
> are in mm.git's mm-unstable branch.

Oh sorry, I just checked and I did actually receive the notification
when you queued it, I guess I just didn't parse it mentally.

