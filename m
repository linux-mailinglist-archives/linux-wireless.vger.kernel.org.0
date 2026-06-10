Return-Path: <linux-wireless+bounces-37608-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PSX7HQ3nKGo+MwMAu9opvQ
	(envelope-from <linux-wireless+bounces-37608-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 06:24:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBB6665BCA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 06:24:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=p+XKtFEf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37608-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37608-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E9133015D11
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 04:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D3346E7E;
	Wed, 10 Jun 2026 04:24:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770623624DB
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 04:24:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065475; cv=none; b=OKdQ3D/6h88iBrzkHX6HgvYkXB3Muy4en1z/MiL1DF7sE+cPvHNs21tZtSToi3hYtO4CjeRDhjw2hnT1g1erdOtMaWZxRLVGGLU/3m7ob21pV+fJpMrSuW/dfexPckUpkbpISQlhEu0jKWpZEzqlxsDVLPuSdgCjVaLewUwLNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065475; c=relaxed/simple;
	bh=O1GcbMvbHB0320Ja/7VIA0LvS6+Y3a22bqy4E1jVfR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsKsTuaZ27fa3D6WT4ZRl5BxkX2VpNu8C86Xv/DHUQpVOagfEQGSLhIc0RIjV/3ekuita4zAXH//QDjmgmqEEMmZI3lbeGF8g2lOF9sH3/zWHkUR+ZIUBHiSP++wMflU/OzRDCSWdxy70SnsXAMDDuh5EAaOlD0TD9EfWGU5CB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+XKtFEf; arc=none smtp.client-ip=74.125.82.66
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-13832028e9fso1578836c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 21:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781065474; x=1781670274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qu/9+fnio8QpinF+JYYv1QMNKnqWQMwM+l8E/sYNsEI=;
        b=p+XKtFEf5w7HRJfpPak38PQpt6jNbIX+NMDiLDzprNXNvn8CvqBtM7XiAwcedXwou7
         Tpd4n5ryzJRg/YV5ycJnNG4nJj+SyLeuN7DN5OxA34W+C399Wyf7YsHZOF4JGza86fLE
         daAXcDlqVxJkwCO8V8uco9Rl4SMimR+Y7lPcN+XHJed9p8zLqeFPHZUeXOi/WZqn/sII
         4Gg6NCR6cb5WzpeNLHaK5i2tVtITRBOAQjOsK/QV0MjdOIMUzXYTk91R79A1DnWTrjm3
         dJ6hD6LfuXeooT4dVpFsJCPsHczLs98du6kVM4ZUu3T9JhVK65Cwlq4KrkvGBqR9SrrN
         fMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781065474; x=1781670274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qu/9+fnio8QpinF+JYYv1QMNKnqWQMwM+l8E/sYNsEI=;
        b=NI7nPK37FoBE5KmGwKRmVmjXcGeDueq0WujbIFAAJbQ02TMVJjFHTAAXHvVzvQ0Qdz
         sbJSuNNoeBeNZnfGd95ckk0pVeqPmL1kMgIIfGfNiE4fSQmvwKGkmsIDL5VZnW9EOe7J
         8lOfv585Ap+fgtthEVR9dfHDU7CMRpbw3yeywZgsCuOlUk0zGqLYeePLVTZRyvP9QwBp
         +zpHPcDow0krr793+surWd5m8HNDqsHWmQKYGeI94/nard9dFDXGgUNPPP/8lrHBYNWp
         7n2EpEg61QhqRSr+nv/QCbjGpPSjpoYjrvUfdUyBDf80N2fuy8EAQW0S3Kkegws8CZbw
         3z6Q==
X-Gm-Message-State: AOJu0Yy4wZlyJue2LEtssMsMkDna5exxawTeTfG6toaQ/bCRFokqyJoI
	mNGhHflhzRGYvfu2ltmVrfjKMd0b9BS0n5F5Rhgh9BzNg8aBgxGeK5H6AmebjgNG
X-Gm-Gg: Acq92OEtJqaNjUNj0TpCzjjg0xJizlvBgg3DLqFJVGjeukMzWbWE14OzXQh4DJ5sbTi
	mO4+DpStmrZ0T0nv3OFOQPL9n9c3qXn6MkMwsZr9rao1q23g4rTJtXNYyKNSSFR6CY/h9eZ5xw6
	kf0ya5LMvMeTPf5WLGfE6KwwdZkUvuEwwkxli8dcce3zqM9deyFrvVMSfERoYz/Rf3gC6oyHNDN
	euWOtwEFyvkwh1deRwZGSsYNPJzmt1wZgWvx8GI4wuaHZRPuMG2fbfnf6SYMDtA8/zEWzy37gTz
	QgSqRY9EGCEYwD60jjztPKcZG7L1lM1jZ7pTviGvtwzoxgKYZYcKSkhY7ygDzR76lg3rGwmphS0
	Z+iBrF9E/JFFiSZ3NvNw7vwbddjCcLY/rM0/NZfygOgLN8bnxlUIk1FN0EVYtASgF+IMqSKiOo0
	UCcpubw8V9e6rdK5L1BvyHxgJ1h7soMwPiIhx0cvaYhccUJ0zyxAbEOv7pKJx0auCmHochNNLlT
	SWolElPyl+OSx+crqZp2jMpMKg7ihL2Qmg1kbsOiFtBsrYOVtBT6HHVgn1ht6O4pE9M+YFyQR10
	PMh0nENWbzfSrzFeBai5cCxHfIIJ
X-Received: by 2002:a05:7022:60a8:b0:137:ec94:b487 with SMTP id a92af1059eb24-1380670b8b5mr11957996c88.30.1781065473538;
        Tue, 09 Jun 2026 21:24:33 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138063de4a5sm13466715c88.13.2026.06.09.21.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:24:32 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: remove code guarded by nonexistent config option
Date: Tue,  9 Jun 2026 21:24:26 -0700
Message-ID: <20260610042429.222717-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nbd.name,kernel.org,mediatek.com,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37608-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:enelsonmoore@gmail.com,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:mingyen.hsieh@mediatek.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DBB6665BCA

A small piece of code in mt7925/regs.h depends on CONFIG_MT76_DEV, which
has never been defined in the kernel. Remove this dead code.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 24985bba1b90..ea04e477a67c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -74,11 +74,7 @@
 #define MT_HIF_REMAP_BASE_L1		0x130000
 
 #define MT_HIF_REMAP_L2			0x0120
-#if IS_ENABLED(CONFIG_MT76_DEV)
-#define MT_HIF_REMAP_BASE_L2		(0x7c500000 - (0x7c000000 - 0x18000000))
-#else
 #define MT_HIF_REMAP_BASE_L2		0x18500000
-#endif
 
 #define MT_WFSYS_SW_RST_B		0x7c000140
 
-- 
2.43.0


