Return-Path: <linux-wireless+bounces-31025-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN0NMMf8b2mUUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31025-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 23:08:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E8D4CC20
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 23:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3C2B928D7E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79DD2E54D1;
	Tue, 20 Jan 2026 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2jLetvJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495D3A7855
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939848; cv=none; b=SPzlqPWhKI0VfZkNPQ6jTInOcM+PLSPcjjmZ6ZVEHmsfJ7pEFPrBnRwYZxLsWX9Swvfgo5Go4lpqhTcqGzIjHVXbezy2+hegKmPXk3pUf16vQSfVgW7XUdGc2W8/ZwIYKpntDCq2gX5WpK7TupvgiWdB54r1fZh8cZfHDOkMqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939848; c=relaxed/simple;
	bh=5Uz8Q2q6SpnaXy1nh7Cjsa+0KQQm8vY0C8p4Qg2pyWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJdeSkUPGmZMSwGuWyvJWsxgTaFAv4g1gnll72p2Y749Y00sWmYgIR8/xBG2xbL0YxuiatJAZm1me2gd7e+uNCS7TEwltYVAcvznOgnPZdrvJy4NVtT33/qwbtsM6TvwXYWIqQ6Jra9oz7baR0uOiQ0fANQgXc/+4qGzwJ2ox9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2jLetvJ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12332910300so9237996c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939846; x=1769544646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRIzu+6S6vBi95fXcSYAvUvufcVOFBJ3gUVr6PCcUOA=;
        b=J2jLetvJmQhx6O6JLkY6GP0fgtUhUU1t2O0+d+TxRL++6ptGkskWUsvroNSTiS+MwL
         aTuBXGjYi4Ns5kkxrZHcgGXj9fN45OmHKIZKdOQ6MEvNX0fJFGVtNAjO4B6u9JtqkdUb
         zUylgBo0R6wlRZDpLlNWeMqvuhvrETfrLNfI1geRALDlP8yLgy8/5zpttqtJp8DYyVJq
         hSWADxA2KJtd8Ur0V2Av/wzmrpmoJrwlexVnfSsFjlBw5+i7hksjN+bYZcyghEbwoGJO
         rRpD1aIT71MuhI0AbrlF0mVPj+vXIQxPwvC7aUgwxJRS75VoOBg6mP1daZkzF8d2EAth
         GNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939846; x=1769544646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRIzu+6S6vBi95fXcSYAvUvufcVOFBJ3gUVr6PCcUOA=;
        b=EOq4f2yVzgOLLDYBtLElMNOPCE24EU8qy9ZT/ATdqqWGiR5NaPc4R7rDbzbxWisZJ7
         KOh+mhgWdG954T5HGf1nG87zQhKfkcXyE4yWjIpOF/PYDye3zEO6ZzayyUxo+OxRWHSd
         xi3m12a7cIvYeds/v/gYMUGNmatBuPsSBiLF8NXTP50DV4hfmxHZ4zxLrHaCItb9Rps3
         xyFLXojRhJGXVVrUdJzVRma7KtKj6xJkVhV5EsmQ56yH2Wj0zl5cny7fgMDSaiXxizi+
         4nCiiAK1NBkaSjXcKwKRp+ZFeeqtuXQpTrl9TS8xeI257jfrkMQONsdJrC8GfYpwoHNq
         79SQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9gK7JJqu7h7sfa17QtsTw0UUvYHnABOf8B1Ft4HuexNgwS4+/J1mL6fepU8p15fGbBxmIeMWwgAIK4SjOlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuR5A9dLJVBXj3DAyTkkDFsxU5sFNT++9Qz7m9bafVMtwqtyou
	HDHUme2MTLotftxsnjk1lyLk+rZM4pkDWBkPOiO4jRKHk7mEViz40dqa
X-Gm-Gg: AY/fxX6Tl1+9uHhu9wxdmUbg6sOcUNxaHyySoQqWhZYA5OKDwYmSPJxwPGP7K8pEP5p
	4iVY7enTDGSsCTrccU1mPryaRbEcyzDeyqgHvZfCjeqQ3ItJ7nGs2kEKEcJEJsAEY2xnwmuv8aX
	qwfdXiEiN6hAmj/v24ehJ4a/db/mb8uUAJNflmE365HSqv41gYX+KZ1VwyCDzH17oj57NbB9JwE
	JQb7oGV11yAjAq2msd3x2VhL3nvje3ojmZCHNNOtPpiW0UJC+8y+B1NPv0Rz5oqMl6SL7CKk/VP
	1kKmo/U9g+n80LSVTS2747AGaxevN4LfWyTt4oeFilO1K3h3i2aIZdlU8BT4+DWHvw/jVAOp165
	lcx7MJqWwtZPpGBKwpSHjX56n4g+hh92GjbJc6oPkDNFiX4m++NZNj8WSyPT5fVf8aKUwo6NLTT
	WRA4aNumQEsKXNcLk+prDUt/yRwS4i1K1dZjgmrziePEvgj/3SoXPMGGOGDm4QbcOamXRWEhga
X-Received: by 2002:a05:7022:a82:b0:11b:9386:a3c8 with SMTP id a92af1059eb24-1244a7690f2mr13531760c88.41.1768939845915;
        Tue, 20 Jan 2026 12:10:45 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:10:44 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH v6 00/13] wifi: mt76: stability fixes for deadlocks, NULL derefs, and race conditions
Date: Tue, 20 Jan 2026 12:10:30 -0800
Message-ID: <20260120201043.38225-1-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31025-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,zacbowling.com:email,zacbowling.com:mid]
X-Rspamd-Queue-Id: 52E8D4CC20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

TLDR: This series addresses stability issues in both the MT7921 and MT7925 
WiFi drivers that cause kernel panics, deadlocks, and system hangs 
on various systems using these drivers.

This v6 series is rebased on Sean Wang's upstream deadlock fix already sent
which is now included as patch 01/13. The remaining 12 patches are my stability
fixes.

Changes since v5:
- Rebased on Sean Wang's fix for mt7925_roc_abort_sync deadlock (now patch 1)
  and removed my work around for the same issue as Sean's fix is better.
- Fixed format string warning in patch 12: %lu -> %u for jiffies_to_msecs()
  return type (caught by kernel test robot)
- Added patch 13: fix double wcid initialization race condition - removes
  duplicate mt76_wcid_init() call that occurred after rcu_assign_pointer(),
  which could cause list corruption, memory leaks, and race conditions
  (this is a pre-existing bug in upstream, not introduced by this series)

Zac Bowling (12):
  wifi: mt76: fix list corruption in mt76_wcid_cleanup
  wifi: mt76: mt792x: fix NULL pointer and firmware reload issues
  wifi: mt76: mt7921: add mutex protection in critical paths
  wifi: mt76: mt7921: fix deadlock in sta removal and suspend ROC abort
  wifi: mt76: mt7925: add comprehensive NULL pointer protection for MLO
  wifi: mt76: mt7925: add mutex protection in critical paths
  wifi: mt76: mt7925: add MCU command error handling
  wifi: mt76: mt7925: add lockdep assertions for mutex verification
  wifi: mt76: mt7925: fix MLO roaming and ROC setup issues
  wifi: mt76: mt7925: fix BA session teardown during beacon loss
  wifi: mt76: mt7925: fix ROC deadlocks and race conditions
  wifi: mt76: mt7925: fix double wcid initialization race condition

Sean Wang (1):
  wifi: mt76: mt7925: fix potential deadlock in mt7925_roc_abort_sync

 drivers/net/wireless/mediatek/mt76/mac80211.c    |  10 +
 drivers/net/wireless/mediatek/mt76/mt76.h        |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  |   2 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  28 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |   8 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 303 ++++++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  48 +++-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  |   2 +
 drivers/net/wireless/mediatek/mt76/mt792x.h      |   7 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c |  27 +-
 10 files changed, 390 insertions(+), 46 deletions(-)

--
2.52.0


