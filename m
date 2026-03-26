Return-Path: <linux-wireless+bounces-33971-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGI7Co4oxWkU7QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33971-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:37:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7E3354DB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6AFC30CBB90
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E40C3F9F30;
	Thu, 26 Mar 2026 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnn8Szsa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723763C3440
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528358; cv=none; b=rWLNEVqNq4LwP2HzB4sQLYAVXb3CWGGuNSROm7IkAlwGUJp5LW+o7GvbUhdNtc/4EpcgXRLJ/vNsM/L4GOd44Jz3ItJ/ZqiCOPSY7Hd9iTz9nX4EIVhnOH2jd4iz2Z9t/FJC1+Vpt8jBeQTovd6jlhOFtUVddSQ3y7syjLa3wfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528358; c=relaxed/simple;
	bh=ZEGAUcvooReaJ1XmRJnQfzG/aLY4zKJA94CADfSupZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IsVa+f6D4FU0fi6AVuGSUj2pFGqcmb0v737gSbxN1qm3Fw3k/YprRyK4+1nKqE6j5uK4xooK0h7PokY+v/+dcyuj+F3swQncuwr7+wkVFKZ5IyrARBDh/vH/As7wJiBzGQ+lUuS93YIgeqTWLwZUCnIooBXr9o2fZVcdj5UAnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnn8Szsa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso17724885e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774528353; x=1775133153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCR1+XiCejEoTZukOGzTXx300luMCdEPMVOduAGAhwQ=;
        b=pnn8SzsaxWdT1Xg7bun4HelpBTaPt2xL5Ka6sp5j8DTsXSpU2WAsbA3TELSLbYAFdy
         BmzQBUatwrqo8rObW4ddm8mkrjc6kCFuj8a5R2gtQYVh4CCL64Rn2oy4IY2ymGebHjhi
         zlHCpFB5KCjkTlB3bfEc7elT9nYuQ9i6LPIdmgJJscO+ZNk1k35WIJulubbfe8NggxLP
         3zQy7tNjXAYOqqhnUrp74tJMbjLjNusJcK0aGeLbuIotj4vjeVTVliRpWff/V7q/tbIB
         efq5L5NgfqARFrJu9d1DymS2RHzbowq5/Z1wD8jTqIRK/jbSJTSNidRzOuhm17wZDkuG
         gWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528353; x=1775133153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCR1+XiCejEoTZukOGzTXx300luMCdEPMVOduAGAhwQ=;
        b=Rqma0S6L9w5RYLj5pX8amtRB3KQaHUIPW6qt1mQHsrMGg4TJ90ZcT9Gscg7qO4gl9A
         SwE2wz7WQJRdei+xs0EUAqHWIS63La+idH1fgxmz8FH9yt85yVL97PX/XRdNnrTW2KCQ
         u4eatqVd6K64a4Qdd7fxCIk9sn8654BhbXIStDJvX3B7unB8laUGAVIgz+1ZEmwj/wNe
         aEOziGLDvlTiCp5B4Zs0xXb44wzvKo92qpGa9mPjY3pnN134wRDp+FzQ+2r5LXEc3oAm
         hJp409B3u1FU0cfGX3t7YrI3zK5xkBIpK0njmwsshuFf5B+bDC2XfKdIsnR6Yhib/1ig
         OBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJNspr7jfEirTRPDy1gfV3TbWtdS1NtoeUIRSHoop40Z7qQoBDHa/5AxN8bHaDWQHzFVISJXLXGTEQ554y0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK5/i3AZYlk1cOyhPl64h8/z0n7QiDXyn8uLZh4Bo1M4+fakso
	XlxInjMpUo8gXH5/DEbGHSHecRzG27E5kcJ87CCMSY1Q2fJEqFxtxX8WqRcyt/Lh1ke+m+0Jzkl
	kSDFBH2GCO/mKPg==
X-Received: from wmoo19.prod.google.com ([2002:a05:600d:113:b0:487:238e:327b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1d:b0:486:ffa3:592 with SMTP id 5b1f17b1804b1-48716071b2amr111318865e9.24.1774528352832;
 Thu, 26 Mar 2026 05:32:32 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:59 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-3-d916021cecdf@google.com>
Subject: [PATCH v2 3/4] mm/kfence: Use special gfp_t format specifier
From: Brendan Jackman <jackmanb@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Stanislaw Gruszka <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Allison Henderson <allison.henderson@oracle.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33971-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,google.com,linux-foundation.org,oracle.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFA7E3354DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

%pGg produces nice readable output and decouples the format string from
the size of gfp_t.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/kfence/kfence_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 5725a367246d9..10424cd25e5a6 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -263,7 +263,7 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 		break;
 	}
 
-	kunit_info(test, "%s: size=%zu, gfp=%x, policy=%s, cache=%i\n", __func__, size, gfp,
+	kunit_info(test, "%s: size=%zu, gfp=%pGg, policy=%s, cache=%i\n", __func__, size, &gfp,
 		   policy_name, !!test_cache);
 
 	/*

-- 
2.51.2


