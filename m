Return-Path: <linux-wireless+bounces-37182-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6V1XDcatG2qmFQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37182-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 05:40:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E46144B9
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 05:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D127D302EED3
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 03:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2D1386C9;
	Sun, 31 May 2026 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BINYzo/G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8FD23EAA0
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780198848; cv=none; b=bXHkHe64C5uGPpGDXqUuSDpggLKrwERfxdWZlaMmYrQY6J88fh/+8ZNGuOsePLM3Lv9BSCD7oFBVf/GHhgR05HjhIgg7pliVCSEl+4B8slEanpx3mxRo5LRVB9Tp8dmVy9WmWYBmoCtwRYarRapgVYRjJvFn/D6Pwl3p0dnJEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780198848; c=relaxed/simple;
	bh=pYlgkGSoAYhQi9DFithVC/Vg6kOMVGMirE6j1+p/jt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q6QyjoQl+UaKX16R+rbee0Hy5kqC9fZ9Oq/6YZ34BQyz+uj9EyHdZsAZYLJ5mSUhHIKkGtbVAh3ECl1bs1VcV6dAKt8EAc14hwmwNECRkBFW506Plg90WXcABRs4tsNTlp62GML2sLXGpTFKfT6LswSw/+6RKDW+//HnyncsW+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BINYzo/G; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so457833a91.0
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 20:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780198847; x=1780803647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+Npoi6ZFojU6tLMvPXzyqpbbfL/J10IT/nIWCrIwY0=;
        b=BINYzo/Gbo9GKrXn+tnFBNAxuU/aCXDZss2K9TTpVxNXT9ejETv8pcucv6jT7L198W
         Ehafj2rSq0VbCTZb6vYVE1qYpnPyGLsgn2w6/Ry4uMn4RixdYYxmWlsHEByhiULoA1Ea
         Y3Vn+vvsl4MNWg4Ak/5kj9qRGT7o3Wa9TQ7S2mwyulPey25bAd0vg/tWib9W5X68VImF
         oz7oQj1gkUeEWRknEInFsUmUjNXuWdJelAUDcMoUUDAaS2Uy8lnKCNAOFpMq4Ihb38W7
         3rL/hRTFkxAGcwzVML4RcvPPpft81fST4tV7R+K1PPdiWjWUkw4OpQJmN23BkkiLJkp/
         Z/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780198847; x=1780803647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Npoi6ZFojU6tLMvPXzyqpbbfL/J10IT/nIWCrIwY0=;
        b=nZ2M4k6hKSwuKTSsEC9dIQD8JM1Atuaw7XNiPylvq3Pe3CVn/QOuw8V+MqpmM93SG1
         /nyLzXIhM5ZEl7H+jK51F9mgsc2NKLu0a9k5iNh1cv6mScSOsSc6lJhBKk1OwPUiydO3
         R5BvWQHUYF+UwDFJBHpe6dyDgZ2nAbpz/T1k8SYD5OuQzt+HIRIjG3OD6WS9pJssNAMZ
         ZcpGfFfkYfJI5xSLda/1xwirB9YtD78ThcXh0WQ+gYrJ7xyzu65+r748+hoFI7cLJ1+q
         sLhYSIRyWMpabNhqDISZZl+epGjgJB6KfEnLIPrZKNZVGFac2u7S4UFd4/6SBqOXjZvz
         FRhA==
X-Gm-Message-State: AOJu0YzpmeBAWVIW9Di/1XAQSlHISZA6T59uUsMRbA/37TXiGIf0Fc43
	DBAs2YAzyE3T6/m02DTI7p5ey0lqRCRseCL3SzlDUr1O/SWDVJ7cmMH/
X-Gm-Gg: Acq92OE+ryY9gKmc/KqkIwFbrShneDpT010iOqw8lu7eZ2futM4du6filWVcqnX/XBX
	FJ0JW2df3ns4I/eSorQUXAjHO5/AfrNNL4a9xZDpBXyEnV0v9w2eMwfRrkVfKhqdlSXv+1gKUFS
	sbbJTjfZKm7BNosAHuGwNvsfA4KOXvxZcR+7wb1UAFrvVtpR8+4/EbJORli4Cn7LiAntTzuXsCJ
	Q3XVnppLrCj0j6gDSRcCIRYw4LXUGX2Vcy2gM85mZ+iUcDBZgxKaUJaDbkpziiVfVdbPvCl1nJO
	0WoqV89Hv6vCsZgDKkw67uyxRP1knAfbqupWtdeYbaFd1gYS9puU+8DhGDFvzTtOXS6taTtQtOF
	qwondt0Mkl8KiQbS0KzWuDU3hK19LEjmSHr0t704BrtKBx3haWVKgVq6J8tFZ8X6aoPOpmjZhFF
	Fk6SPaUguI40ogoC48GIiJAZJpK9ewb7QPUK655duKel5C2NRLiXig0Hp3ja/+eiGCz6SWYu5Kz
	p9erMjR5MPpVNSpwvFU2SV6j/hAsEvmgLlE13J1yV8jW6psSPXp
X-Received: by 2002:a17:90b:2d4d:b0:367:cb53:7435 with SMTP id 98e67ed59e1d1-36c50211c27mr5333408a91.24.1780198846827;
        Sat, 30 May 2026 20:40:46 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1920:4670:4008:f5e4:8e02:25f0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772b9591sm5968282a12.22.2026.05.30.20.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 20:40:44 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	akpm@linux-foundation.org,
	axboe@kernel.dk
Cc: linux-wireless@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH 0/3] wifi: mt76: use __relay_write to avoid race issues.
Date: Sun, 31 May 2026 11:40:07 +0800
Message-Id: <20260531034010.85002-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,linux-foundation.org,kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37182-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: 7B2E46144B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

__relay_reserve() that is even though efficient has a disadvantage:
it's not easy to prevent the writer and reader race conditions since
readers can read incorrect data just after the offset is advanced at
which point where no data or only partial data has been written into
relayfs.

---
The series is only complied. I came across this caller and spotted
the issue when developing relayfs.


Jason Xing (3):
  relayfs: introduce relay_subbuf_avail()
  wifi: mt76: mt7915: use relay_subbuf_avail() to fix stale fwlog reads
  wifi: mt76: mt7996: use relay_subbuf_avail() to fix stale fwlog reads

 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 27 +++++++++----------
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 25 +++++++++--------
 include/linux/relay.h                         | 24 +++++++++++++++++
 3 files changed, 49 insertions(+), 27 deletions(-)

-- 
2.43.7


