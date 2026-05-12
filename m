Return-Path: <linux-wireless+bounces-36322-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCQIC0YmA2oF1AEAu9opvQ
	(envelope-from <linux-wireless+bounces-36322-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 15:08:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D45520CA7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 15:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4F2230BDE29
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8539E9B1;
	Tue, 12 May 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOIzxd8M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4EB39AD42
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590706; cv=none; b=Mt71FDxBKM/wiH81uBRcXYUej4ze+Zx5CqgvoQOEnXmbxOPRB/ZBNSba2HEuIy8frVZoHAYDjld6P7qTCbjV3jDi/awl/QAIKeVA3emJRu7offDPvklYnsRt6gNxdz/y/9SfxhwNAbVi35vL+E1nlsZXLwVp+ADnBA5Tle25Iwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590706; c=relaxed/simple;
	bh=pLY3GB/npkRWavBDYzVZGZTO+VbOpmmXpr9lI4mz4fA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mV9CeVPQQZCRWDM8s3a0Em+CO82t5xhLQg8Y5ZY2D8HmOLymKZXy/6E5bEEpJ8Ak5jdysoa8kYCPpNClFczC6FR/r+JELcAxCfY6NFx4frgeL44yS1OP9xObnCFSz64U9ZBNcD4mnPZyHpHfRbMf0P6xP3SWGRgyWNtzXOfFDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOIzxd8M; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48d144d3428so32077465e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778590702; x=1779195502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDWMnr041UI5ryil+k7XvoK/2F/EkGtTQwaeX0kDxi0=;
        b=MOIzxd8M06jLqZdVnSSn+fl9/YjNb4fjltt3R3ync0g1aVCwi8YsgnwqqEWpVN8yDC
         n+OZ7ayH7XM6XVwBPjR1+VLhNblCt+0q//YKBpjHER2l7IYfYuYOOxQ7f8ecykI7F02P
         qkpSKl184Vd6WqziVquto1rxJ8hyAXM56pR5oWegNIdo1wSO0nnxkzMeh/4dD3Wh1nVf
         nooc/ABS+gZVsfESPEkewzYXTezcopIVf1niMTLkEcyFxRmkfrARRbeksuYo94w0359A
         VfwaoWUawNdMkdyXjfVfZJEmZG/iFsEiRQH/30Eqo3ct21ffxyFsmlAAXOItNxt9+WeH
         W3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590702; x=1779195502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDWMnr041UI5ryil+k7XvoK/2F/EkGtTQwaeX0kDxi0=;
        b=jjr14QB8sJ6YYpD9mn8yaW0R4d/afRawVZI7topg6AD75Wx4t5y7GzA3WtyUQCVnpQ
         +SmT6oHL7fSOGaYFVh3kN27emwH3/yT29uoXTmuPNq751Oe2hgEXxdy6hnF8pl3b+gfw
         FT/tu/m3SocOXpNBza8988g0UjoMndL6H5EAEK7at/kLRaa/ec6zgZezFiPhreFz+X7b
         NTwAEqnpEIbgpmIlj8trsPPdpD8hbxzf0feXZ1wxFQecXGLvniD8vOgIhw9oU3A0QAN6
         QnjsZiyTkpgHbSvNdcCPQpNmq1VLhqb/uA/oKO01j0TVWESpU1H2TCTikPR/TBEFuuP0
         jOeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7h9um9ERXeapyMRdqy+6/BcVi8WrcM4ChnO5hLQb0tt2CTcu8Mwi4RSXWdDcnBR0Ucq9l6B00OzONlgXyQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO7uzt9Qs0ZQFRILNkaXOh236RefJ98mtY6fRj1lxqys/jZ0cQ
	Jn54CPT84vAcElRQ3hdazBMkvvg1RUmwwF2Z4juVKGtRcGtw/pwDupGXy+TjPP6+cPsle2LPpOZ
	I1Vy+8XzoveXiRg==
X-Received: from wmby19.prod.google.com ([2002:a05:600c:c053:b0:485:3aa2:da59])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8010:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48e70687eabmr216165565e9.3.1778590701567;
 Tue, 12 May 2026 05:58:21 -0700 (PDT)
Date: Tue, 12 May 2026 12:58:20 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Allison Henderson <allison.henderson@oracle.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, 
	<linux-wireless@vger.kernel.org>, <kasan-dev@googlegroups.com>, 
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, 
	<rds-devel@oss.oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E5D45520CA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36322-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,linux-foundation.org,oracle.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu Mar 26, 2026 at 12:31 PM UTC, Brendan Jackman wrote:
> This patchset used to be about switching gfp_t to unsigned long. That is
> probably not gonna happen any more but while writing it I found these
> cleanups that seem worthwhile regardless.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Changes in v2:
> - Drop gfp_t changes
> - Add correct CCs
> - Add minor fixups to preexisting code spotted by AI review
> - Link to v1: https://lore.kernel.org/r/20260319-gfp64-v1-0-2c73b8d42b7f@google.com
>
> ---
> Brendan Jackman (4):
>       drm/managed: Use special gfp_t format specifier
>       iwlegacy: 3945-mac: Fixup allocation failure log
>       mm/kfence: Use special gfp_t format specifier
>       net/rds: Use special gfp_t format specifier
>
>  drivers/gpu/drm/drm_managed.c                  | 4 ++--
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
>  mm/kfence/kfence_test.c                        | 2 +-
>  net/rds/tcp_recv.c                             | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260319-gfp64-7a970a80ba4e
>
> Best regards,

Hi all,

Any chance someone can take these?

