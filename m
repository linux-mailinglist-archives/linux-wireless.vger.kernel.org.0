Return-Path: <linux-wireless+bounces-33967-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHVOLzcoxWkU7QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33967-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:36:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEAC335471
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0D0305C48C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F453909AC;
	Thu, 26 Mar 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbLsvBID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82E1A6832
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528352; cv=none; b=WLRagRia6M7vBXFtaDcBUthZScL24SW5OAcsYM5JHvS8YoqTCk+J0HV7qVDbNJz16JDoGguRejmiU4TmmuoZvWOLEokJJkF7kBldozK5g7B+cXVqVUcVCf2VWKHOu/METe5DjSc5KQg4qBs7uAdzYRXWP/5hE4ye1WuDa4Gpsa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528352; c=relaxed/simple;
	bh=douH9qPgfZloq1BlEbRSfMI4ANPK1C/tuJt1uzs7Z/Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ndBiu9yUM+AXD+BS67YSTGWSMk30kaCvV7gG1fg8Xz3RNXOeZkCdS4+PWXL/sUpTNhxu0HhLXKmTwnGKR/FLvbcKQeCD5kaUbBDn+bUcHUAAA28kc1HCghzEdsvp5cPUYRo7/C+9C391VH5iaaJ6icqprBo/jME3Bz+tcdXLpa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbLsvBID; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-487228341a8so3175575e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774528349; x=1775133149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yH9b1Z9LWNEOI2+GECgyejSXeUsvyBElCPTE9tOWLWY=;
        b=LbLsvBIDoVAhhmfqo7nPzwaphkXf2cSwbz9CTC36JVaS3JLOZDm+A0T6PEOgT3YvFR
         ljzxE8kb047cdr+TcJvPlGZYil4kHLZ4xV2J9QAbtTDVAaxu9EarhulZCCUqwggmZ0et
         CMdnQwn7r3oJKRITi1OgwTOGPf8hBJ1ay2UbbRaAH94gp+zyCS0zkg2BPlxPzvVp8HaC
         9vWV+fwMCSY5Q7kPZ1b+Sj84QM0pw8zCW8VcWON1yg9PJ2HsPPTcw86Z4HLenBsZlsUm
         WV5M1Xb0+KivJsqt0prtsNg12gmGipU4dzEcUUoniyJht9HikShqZJ1Wcas2a7fG8BAG
         Szxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528349; x=1775133149;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yH9b1Z9LWNEOI2+GECgyejSXeUsvyBElCPTE9tOWLWY=;
        b=Pl8T1aqvPDeaQIdY+9dTcTMLpxi/z6GfroEb20UH2kdiZcnzU9I10vcBIAPSpE/v1w
         mnDW6K/Fr4BWP6jladEdu451JkazZ4Xhf/Jc5EZq7LNdhnJCo6fACLbEs+mfOcpFUlhk
         X6IB1mgWI+lQ0JOTVZZNGvgyWo+lKiqKWt1mqQLvMnj+GOjLVc5iQ5hVPEYc4rSJmwjT
         Mxp44k3Sj5ssJn7s7pUXkRynbFpxM0lWxPltB82htSsZLruaeYI4hOHOTjUG2v2kAC9M
         ++RnUF23Uqqgn3zWlWhdGbmpm3+NqW8LcYK7477S69999s3/kZsLKHEqhJCpeOnY/Wlh
         U3lg==
X-Forwarded-Encrypted: i=1; AJvYcCV2GODRPx04IlDfGQ2VnhYa3L9WxiRhvt7Q41/cQiOTESd1ka17nziGI+NYL5I5WOnvT4D4budaiAsjK3qESQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMSSO0TRWuYcNBe1AvMpyo5dT9jnZLtDJyxUBjAennAGvy1dFZ
	VB44e6bQHniv96XEgze7gn2G5ODeqS3eQuQ3wKMVEiKwxKu9mqrU8aH6C3Np9Jsd23YSz6FOuvH
	viDxet6wAqKUIpw==
X-Received: from wmf21.prod.google.com ([2002:a05:600c:2295:b0:486:fc75:1429])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c177:b0:487:2e8:69c5 with SMTP id 5b1f17b1804b1-48715fe2aa7mr107288655e9.15.1774528349254;
 Thu, 26 Mar 2026 05:32:29 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:56 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADwnxWkC/13MQQ6DIBCF4auYWZcGkYh25T0aF4ADTtKKgYa0M
 dy91GWX/8vLd0DCSJjg1hwQMVOisNUQlwbsqjePjJbaILjoedeOzLu9l0zpUXE9cKMlQv3uER2 9T+c+114pvUL8nGxuf+u/kFvGmbCqM8MihVFu8iH4B15teMJcSvkCegKY1ZsAAAA=
X-Change-Id: 20260319-gfp64-7a970a80ba4e
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Subject: [PATCH v2 0/4] treewide: fixup gfp_t printks
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,google.com,linux-foundation.org,oracle.com,davemloft.net,redhat.com];
	TAGGED_FROM(0.00)[bounces-33967-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1FEAC335471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset used to be about switching gfp_t to unsigned long. That is
probably not gonna happen any more but while writing it I found these
cleanups that seem worthwhile regardless.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v2:
- Drop gfp_t changes
- Add correct CCs
- Add minor fixups to preexisting code spotted by AI review
- Link to v1: https://lore.kernel.org/r/20260319-gfp64-v1-0-2c73b8d42b7f@google.com

---
Brendan Jackman (4):
      drm/managed: Use special gfp_t format specifier
      iwlegacy: 3945-mac: Fixup allocation failure log
      mm/kfence: Use special gfp_t format specifier
      net/rds: Use special gfp_t format specifier

 drivers/gpu/drm/drm_managed.c                  | 4 ++--
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
 mm/kfence/kfence_test.c                        | 2 +-
 net/rds/tcp_recv.c                             | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260319-gfp64-7a970a80ba4e

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


