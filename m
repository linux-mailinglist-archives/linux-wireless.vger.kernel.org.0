Return-Path: <linux-wireless+bounces-34431-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHeZIqmY1GmkvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34431-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:39:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0623AA01F
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46768301226A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A935272617;
	Tue,  7 Apr 2026 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyiQHxBz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E38231832
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540349; cv=none; b=lvOHr6QrxNu7vDsWKFAt4pZHUtxQsNiX+Kw6Dy6zURIgsMgjNeWlpE74XkOyk4iuYBmtLadnxW4EownD+s2lSxkzia4wMIinhgK+79zKEQQjFrWagVhbsTYiwwnFuJvGnFSgYKv7vjjPGbz18KmYFhn19HnN2iWzYUseMT0xwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540349; c=relaxed/simple;
	bh=lBZHvpA0M4t2ck8c/qnmojYMF43u425u3XMX5wCaCaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5s+sBHZDm88Cgm6GD9UwQkT8pp2q3lhW2CdsuGWKfkKRQC/cRXLii42Zq5fkyyij4FAFSIum8fQEDav6yfVHD+wqneqyoc81JUTm2DkrfDxN9Py/fkBd/V/eOjxDELYZEQCOGOXE5r50bNlNhys5P0qIWJU3TcNQ7DMRMAKcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyiQHxBz; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7a299d84b7dso32942997b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540347; x=1776145147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjqLACq3FFcZvCh310/B2plvPLomAdkWK/1ph8IzzIA=;
        b=DyiQHxBzSf95OZmQeHP3xhlhh6bT4Tk1U0u83YYC9bAvDtuDfK8Xe/c0AFUXjY+CA1
         qdp7c0DjYjyNJkEarg+BnDQDIa/F2B/YXqlcYyQmezsOMlOOaqjgTkCguiAgKfkm+l2E
         CpgfxpyjditR3Pr5+75JRyMwW4jtapibOFnzk302Vouk7LkpovDdRM71LYE3k+3FCmdj
         wVQTIxFBIKIIaoDN1Y1ciJlqZAEmMmRagWj2JTK88wPPlUN6QfmkLPy4opc2TTc01FXi
         MyU3bwc62YYQUbh3gl01ylNlVPV2BlN/WcgOGkWAGSQg1s7ql7+62EhQZWY7S9iFVU8W
         BtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540347; x=1776145147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjqLACq3FFcZvCh310/B2plvPLomAdkWK/1ph8IzzIA=;
        b=JVFDolJ4MfN1txwBk2rV147BSVkW7bcHkanGvhGYyVc8JxgkeEsbVP/0uPCH1jXYS0
         ybfuacwL14XZ1y9Ob2uRuir1x98+IUyg/U7fxxdz3aKrrK6C1Bg7jsZxA5vO+ai4Gjd/
         gYjZDwHnfmglZOOf4mvOGLgYUSdWsqySCOlrJOQrhLmxiB969gNCjkGxf5tYr6aX4fbd
         eN5xsWXi1b9ldJle6+msw2ejLAAVKZHNsAGQAydG2JgYUFoxnbuTXOoZI5np3ppDHp76
         HIMaKaVP8BOas/RBHFn+EzOBJjw+jXR9hyWAPL2D+XIDrR1kkPoScvXEq0bOZH7UYGAG
         bpOg==
X-Gm-Message-State: AOJu0YwZGHigqckYowqN8IvZ3qgs+F1pEnvXGRPNvGIquEwvPWu6J6cP
	qqUi5OWL593BZRxE4uxth8YZjDxInPOO9C26JTcplC/brP8FqNl5YVOOPAerVhnC
X-Gm-Gg: AeBDieu6b4qymRgYFBO+b2SWHlCpbxzclCVjN8JedQGYbaH1wRRr+ZPw6ZtB9eojnug
	nt6fKMaKyQAkjwooLxtb11Kdy6GXYY4bdUh0ml/JKvJBHQqh9EwCDUIRYeWr4sdePmXGupbn+WE
	7AcrxtipXW2+4LmIfji94mvNdbmUQNazcNzCMvAHBkPa5+3lh7sS6JAJqIlHkdFEbXtvpgRcki/
	vaZv9tQhzHyGaV4JkmiCQVbFENI7JAWpxu3Gb6PbaLCfZEhZZhDr7PumFdJIvN3/OtL2yR3z5ld
	l3rU4/ARDu+R1yZSAZLqtx8HmBQneNSHoaBBwWNp+BxTf0iVF9EgSCYIJEQjThvjCQNa7OwPkHy
	srixgk8rp55pD4IgJqSJS24WsiQ4i0i35kLaERcto1dymcij24FWNLIvb9hja+aXcOeBRqrucOR
	Zn0j060XQYx4GkPfy9xb3zYJqwnFM5yEMhw4of4I7b2a/ilcVSr3fo6GD1Znrz
X-Received: by 2002:a05:690c:6987:b0:79a:6d65:c333 with SMTP id 00721157ae682-7a4d5c57a59mr158491327b3.40.1775540347251;
        Mon, 06 Apr 2026 22:39:07 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df16aasm62717857b3.40.2026.04.06.22.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:07 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless v2 0/2] wifi: mt76: validate WCID index before WTBL lookup
Date: Tue,  7 Apr 2026 01:39:01 -0400
Message-ID: <20260407053903.75861-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34431-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE0623AA01F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Validate WCID indices from TX free events and TX status reports
before WTBL lookups in mt7915 and mt7996, matching the bounds
checks already present in mt7615/mt7921/mt7925 drivers.

Changes since v1:
- When a pair lookup fails (out-of-range or non-station WCID),
  also clear the carried wcid/sta/link_sta state so that
  subsequent non-pair MSDU and header entries in the same TX free
  event do not attribute statistics or pass a stale station
  pointer to mt76_connac2_txwi_free().

Joshua Klinesmith (2):
  wifi: mt76: mt7915: validate WCID index before WTBL lookup
  wifi: mt76: mt7996: validate WCID index before WTBL lookup

 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 14 +++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 10 ++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.43.0


