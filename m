Return-Path: <linux-wireless+bounces-33968-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMhaFW4oxWkU7QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33968-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:37:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D733549E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12080309D3E8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7613F8804;
	Thu, 26 Mar 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmunPZa8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E034CFDF
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528353; cv=none; b=sKR7xwHu1JMmDlgRdI39Y0VqODGHhgxhN616Pth6WSHC3KJz3eHl3bhdVJCUzhxEQqx04YIifNodcJT7UUvGGG5x43nAgr4vc6M+hfdofLbgpifxA1abGAhVuNb5RMmXrjM0D1O8sDWSp1gl6vU5X9YqDV1BTyhNeX7hP2Bw0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528353; c=relaxed/simple;
	bh=F8oqCmkP/6+S3unZUrGJradusnHwYnXxZNdCp5PCplM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLW8X6v5vPut1XUN1QQHPepd3eoBpQhnHTWy0iJs8a7KcRAEEd/afgIPe9txPnTemqgj91h7nO3npZGuqWnvkEBFJVPwQv92TQQOiq85NmbJ2ibxwfFDzNQJ7YVyh5hGtdNgRLsWGV5rApowXWfP97roexfD+4xJIwh+pwa7wK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmunPZa8; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so12930965e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774528351; x=1775133151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW5D3P/yH7ZM4fd9U5FDHBCN6E6TiesVaLAHRbrJtkU=;
        b=hmunPZa8cT4ULUZRQI/sDcQFZ6qlbcECXWW8r2N/OEqIeNSVunjTssQAwywrNjehpz
         NyW4AlEcUOeopHPTb2KzICoTTKoI0meELd7OKrKWcLflRyAcg2R24WLKU5niAygyZcce
         9pKoUC0EdbQgO07c1h3hySyDWL6QQL1VAhBzv3t/T5vT1wIpUCMasnDdGy5YTQ0BKH2F
         QX16/WD4X3aKZsQ/6Z6vQoNoAjcBGR0vKyyVeqN43+x3SLXq4aU3q7NlHTmLq2SeqSQE
         MrMHxz32DpDUNu/g+jp+tN18aPx6jjZ5lbtVOAGf7mv8a3Hd9zRFdww4MpEgfsqk+2Qo
         z11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528351; x=1775133151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PW5D3P/yH7ZM4fd9U5FDHBCN6E6TiesVaLAHRbrJtkU=;
        b=Sk8Jc5YR3Y8OF77soOzs6XbVrwVQeAG4SXpf+mlfjwK5yrSw/dyekp4q+Ce8QHrPqX
         z3wLV1CYgSsuD+mPa/dd4PMbY6Wbwm5nX4ZUKixcSYw506IBcegqhinhMOgnKIdov+pX
         Ie90+K+3CT7v9By5MxOfg9RrB7cj5sBl/MNHgFMTaCMqzw+17S2spjhDlAKYpg58zGus
         /zI7Y3j95SqPXIKHYiR00Du8RM4FoWqkMAplmU8lz7S2zFqEWQYbuh3ziIgM4tQz2hLc
         CuZVRKvVYRjko+Z5ESFMmYeQDOnNR9umrzfdNf1EiYYIgZNVBksG0vi1Fp507ZNhqNkB
         /MOw==
X-Forwarded-Encrypted: i=1; AJvYcCVuBkmmsrllaPZw2BoBAV9sZ2t1AXrHirrC7ntGx/zyMBgsVKONJYKXm8AuuibFYB86vqgbrpZlx7Ic649iFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBH6cCQMad3EAybYEImKLZFSuTqG+Q+qZwE9PCNX0qnyXO6bF
	A9LiSsM/UcknDHeJXTxcJNwBH+MpiBgO6sB8GKGEG8+an29eME7Qap/pwawfBltCZUm7/fG2K8J
	fwIdiJ0bud4xITQ==
X-Received: from wmoq3.prod.google.com ([2002:a05:600c:46c3:b0:482:ef72:5793])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1394:b0:485:4388:348b with SMTP id 5b1f17b1804b1-48715f0389dmr114277655e9.0.1774528350455;
 Thu, 26 Mar 2026 05:32:30 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:57 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-1-d916021cecdf@google.com>
Subject: [PATCH v2 1/4] drm/managed: Use special gfp_t format specifier
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33968-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,google.com,linux-foundation.org,oracle.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E4D733549E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

%pGg produces nice readable output and decouples the format string from
the size of gfp_t.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 drivers/gpu/drm/drm_managed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
index 247f468731de0..a9da94319b052 100644
--- a/drivers/gpu/drm/drm_managed.c
+++ b/drivers/gpu/drm/drm_managed.c
@@ -232,8 +232,8 @@ void *drmm_kmalloc(struct drm_device *dev, size_t size, gfp_t gfp)
 
 	dr = alloc_dr(NULL, size, gfp, dev_to_node(dev->dev));
 	if (!dr) {
-		drm_dbg_drmres(dev, "failed to allocate %zu bytes, %u flags\n",
-			       size, gfp);
+		drm_dbg_drmres(dev, "failed to allocate %zu bytes, %pGg\n",
+			       size, &gfp);
 		return NULL;
 	}
 	dr->node.name = kstrdup_const("kmalloc", gfp);

-- 
2.51.2


