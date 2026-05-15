Return-Path: <linux-wireless+bounces-36495-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP22Ons7B2ottwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36495-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 17:27:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 674C85521F1
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E47E230B307A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85CF47279E;
	Fri, 15 May 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsg4sxkd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3A3CC320
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858261; cv=none; b=TibsRhVwBGzRLux13TuoOyja68Oc5mgUho3CviKpE//bDvGU6lks+5OwH9l9wZKRucNGJqR7OnuN29c7fFO8zpLohQ3X0zofSqJyPPXsolnsq0Z0Hfq9GF2MTZcnwAqyxpIX543hhkNQ3SgGaJpEBiVSUBLwFvFUlRe88V5UAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858261; c=relaxed/simple;
	bh=Z75usw3QhAEglguIEOhIGPUv3SaIuY5V+MKHcB1EJ3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSPqcKtZ9HJmpG/dCPF6SNYx0mronNln3n409hrAFGwc3e4DZFqgkSNaoLGTIyb0fzZPkCYLck62sjcMO3QZ0opCI6GxEhyeFd/7cf9OCDx4E4o5aO/duiad7BpLTTZgZHl2HAzTTIFfi5fVD2lHR2CQ/QE5k2KETWiAiofKYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hsg4sxkd; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-90fbf21d9d3so467415085a.1
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778858255; x=1779463055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4US3tDvikO40MDXGe3cYhe8E3tMaY5/koyKTZbuTHc=;
        b=Hsg4sxkdWwwrUtB1Ib8cLR1KujlWodqUpbGkmZ8ZhylsECTRmhYQRkOC24izLoqPd9
         4pqse742CYo4ca25dtjtm8DgSs2TZDM45CART5s3RIafwgnKLzkxR8GjXLEhqfHbvUre
         MznKv4CsIaEesrpc3x/TKCGxk1FORUpNiTdtBdd4yRXWjMfcgQoqYT+R3pfXpszNmJkL
         mvIvhSvhWFyhRFA7e99eqa9ioMD1vIL0qCRJ3dfTJW2gA13Z3ujm34WeG+r5XeMx2Gvd
         21sIGP3pmX6tGKiiqkiDq7V1c6akX0Fuy7hdY5/79jiye5SQYqPyoyNel6UD0YSpJBLx
         Uigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858255; x=1779463055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4US3tDvikO40MDXGe3cYhe8E3tMaY5/koyKTZbuTHc=;
        b=Rkol2/0wuSG9SUMjaeLbu2NucJTsKELq3gDPNQEminBDa+IVvSNZbnY3BE1NGnX9Rr
         a3+YDyDuBCUdNM/Zbv9UEHNbIAN2M2cf33LCG9iqgG9yuE4OAfN+9dce47l/CsV7gaS5
         JUJhw2e3A4YeQlRrpT2iiBkeZAeXZOm50YHoKG6bUUtv4imidGKv+erMLGKHMTqD4LxR
         q5fli2M3haTWx6YBmwWkajg5JH37xHiya8JQ3gbk07kYdZoofh5u8Pec+RgZBUHBb2r7
         cvqN3Z4Ja5AvMNF2ulT6rag5JCzEp2v3CGdo/4FjcZWzBT8pk9w1NBP7hbLn5wsfA3Hp
         nJcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8S5yCiLJbNCm319yUwmF55IP3UtEn3CCZJC3wSC9xLXid/RIyN63alw/aKfudRmNi4qltxAb7mH8gSapvHSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkW9uIUII904WeAVJ5s8qFUoV+uj1tcI3TayGgqEo6MmYgcd7N
	yK2FpNg9yMf7yb5MhrXonUlaBkefyzp6M1vCjUE48xj5l2IzC85iCLxHk3KS/A60
X-Gm-Gg: Acq92OFTF5VQI6I/aOleo2t/C+5qt2bxqW5VmdR2O6NNKIAjApINP6WvHOLLSy25Dvp
	tpHIXvsrzfTjhphOPdVlPheZidkP6jiIbD/NLP/5lny9lg/OL+iCppqHkKRUcetYbSvat3iOoLg
	O2HrP/LvxT3BWdEEz1xevBB3vWSTzg6Sy5Bo1jbrmBvSp9MCRyOY5B7ZZ9WIeG5f4OWwWYSHf1v
	AgpY1hrh+3w8J9ocG40EzOT0SHvI6a/QvoBrBQdAaJ0Od/o4gHbV/pTwFwwiUzjSBcHq+YanwF/
	J4z5kPwYeEyBUNuIoD/Hep+gZnEyhqPdejDEDxtNVPqZqM1aSkxcgavgiDtTKgM7LIeEROODe7n
	MFviPS4zOM+86vgm9oe27RaeLuTUBVAY2xRAtzkysn6d1DP7dEFm6gV73vWJWfOFA3ZSERN/xPq
	eQ7lBTPaLpQ8iq34Xn1+DAPiKwz65UZpFeWttIKfzQWs78NuM3ukNAFViLU64e94oJmYdtM/XIY
	AN1Rph1T+lBu357dHKdYUP8WR94uRDzuEKy8tjMhSw=
X-Received: by 2002:a05:620a:7112:b0:8f0:7516:da99 with SMTP id af79cd13be357-911ce90bc41mr703018185a.60.1778858254803;
        Fri, 15 May 2026 08:17:34 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e638sm569877385a.9.2026.05.15.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:17:34 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ayala Beker <ayala.beker@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless 2/2] wifi: mac80211: add KUnit coverage for negotiated TTLM parser
Date: Fri, 15 May 2026 11:17:19 -0400
Message-ID: <20260515151719.1317659-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515151719.1317659-1-michael.bommarito@gmail.com>
References: <20260515151719.1317659-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 674C85521F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36495-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add KUnit coverage for ieee80211_parse_neg_ttlm() to lock the sparse
link_map_presence layout against future regressions.

The sparse_presence_no_oob_read case crafts a negotiated TTLM element
with link_map_presence = BIT(0) | BIT(7) and bm_size = 2 in a buffer
sized exactly to the validated element length.  Without the parser
fix this would read 14 bytes past the buffer when processing TID 7;
under KASAN that is a slab-out-of-bounds report.

The dense_presence_baseline case crafts a fully populated
link_map_presence = 0xff element to confirm that the cursor-advance
fix does not regress the path that was already correct.

Export ieee80211_parse_neg_ttlm via VISIBLE_IF_MAC80211_KUNIT so the
test can call it directly.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/mac80211/ieee80211_i.h      |   4 +
 net/mac80211/mlme.c             |   3 +-
 net/mac80211/tests/.kunitconfig |   4 +
 net/mac80211/tests/Makefile     |   2 +-
 net/mac80211/tests/ttlm.c       | 175 ++++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+), 2 deletions(-)
 create mode 100644 net/mac80211/tests/.kunitconfig
 create mode 100644 net/mac80211/tests/ttlm.c

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2a693406294bc..aa9c9781db92e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2948,6 +2948,10 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_chan_req *chanreq,
 			      struct cfg80211_chan_def *ap_chandef,
 			      unsigned long *userspace_selectors);
+int ieee80211_parse_neg_ttlm(struct ieee80211_sub_if_data *sdata,
+			     const struct ieee80211_ttlm_elem *ttlm,
+			     struct ieee80211_neg_ttlm *neg_ttlm,
+			     u8 *direction);
 #else
 #define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym)
 #define VISIBLE_IF_MAC80211_KUNIT static
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c3a2844740a14..9a51870a818da 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8096,7 +8096,7 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx_skb(sdata, skb);
 }
 
-static int
+VISIBLE_IF_MAC80211_KUNIT int
 ieee80211_parse_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 			 const struct ieee80211_ttlm_elem *ttlm,
 			 struct ieee80211_neg_ttlm *neg_ttlm,
@@ -8177,6 +8177,7 @@ ieee80211_parse_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_parse_neg_ttlm);
 
 void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_mgmt *mgmt, size_t len)
diff --git a/net/mac80211/tests/.kunitconfig b/net/mac80211/tests/.kunitconfig
new file mode 100644
index 0000000000000..ab2cc5cfc1f5c
--- /dev/null
+++ b/net/mac80211/tests/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_CFG80211=y
+CONFIG_MAC80211=y
+CONFIG_MAC80211_KUNIT_TEST=y
diff --git a/net/mac80211/tests/Makefile b/net/mac80211/tests/Makefile
index 3c7f874e5c412..2e9ade90f7b63 100644
--- a/net/mac80211/tests/Makefile
+++ b/net/mac80211/tests/Makefile
@@ -1,3 +1,3 @@
-mac80211-tests-y += module.o util.o elems.o mfp.o tpe.o chan-mode.o s1g_tim.o
+mac80211-tests-y += module.o util.o elems.o mfp.o tpe.o chan-mode.o s1g_tim.o ttlm.o
 
 obj-$(CONFIG_MAC80211_KUNIT_TEST) += mac80211-tests.o
diff --git a/net/mac80211/tests/ttlm.c b/net/mac80211/tests/ttlm.c
new file mode 100644
index 0000000000000..18d0592b13d9e
--- /dev/null
+++ b/net/mac80211/tests/ttlm.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for negotiated TTLM (TID-To-Link Mapping) parsing
+ *
+ * Copyright (C) 2026 Michael Bommarito <michael.bommarito@gmail.com>
+ */
+#include <kunit/test.h>
+#include <linux/ieee80211.h>
+#include "../ieee80211_i.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+/*
+ * Build a negotiated TTLM element in caller-supplied buffer.
+ *
+ * @buf:       destination buffer (must be at least elem_size bytes)
+ * @elem_size: sizeof(ttlm_elem) + 1 (presence byte) + npresent * bm_size
+ * @presence:  link_map_presence bitmask; each set bit => one map follows
+ * @bm_size:   bytes per map (1 or 2); 2 => LINK_MAP_SIZE bit clear
+ * @maps:      array of npresent u16 maps, one per set bit in presence
+ *
+ * Control field encodes direction=BOTH; no switch-time, no expected-dur,
+ * no DEF_LINK_MAP.  LINK_MAP_SIZE bit is set iff bm_size==1.
+ *
+ * Returns pointer to the ieee80211_ttlm_elem at buf.
+ */
+static const struct ieee80211_ttlm_elem *
+build_neg_ttlm_elem(u8 *buf, size_t elem_size,
+		    u8 presence, u8 bm_size, const u16 *maps)
+{
+	struct ieee80211_ttlm_elem *t = (void *)buf;
+	u8 control;
+	u8 *pos;
+	int i, tid;
+
+	memset(buf, 0, elem_size);
+
+	control = IEEE80211_TTLM_DIRECTION_BOTH; /* bits [1:0] = 2 */
+	if (bm_size == 1)
+		control |= IEEE80211_TTLM_CONTROL_LINK_MAP_SIZE;
+
+	t->control = control;
+
+	pos = (u8 *)t->optional;
+	*pos++ = presence;
+
+	i = 0;
+	for (tid = 0; tid < IEEE80211_TTLM_NUM_TIDS; tid++) {
+		if (!(presence & BIT(tid)))
+			continue;
+		if (bm_size == 1)
+			*pos = (u8)maps[i];
+		else
+			put_unaligned_le16(maps[i], pos);
+		pos += bm_size;
+		i++;
+	}
+
+	return t;
+}
+
+/*
+ * sparse_presence_no_oob_read - BIT(0)|BIT(7) presence, bm_size=2
+ *
+ * Only TID 0 and TID 7 have maps; TIDs 1-6 are absent.  Element length
+ * is exactly 6 bytes (1 control + 1 presence + 2 * 2-byte maps).
+ *
+ * Pre-fix the parser advanced pos by bm_size AFTER the switch() block
+ * (i.e. unconditionally for every TID), so when processing TID 7 it
+ * had already advanced 6 * bm_size = 12 bytes past the presence byte
+ * for the absent TIDs before reading the TID-7 map - 14 bytes past the
+ * end of the 2-byte TID-7 map.  Under KASAN that is a slab-out-of-bounds.
+ *
+ * After the fix pos is advanced only inside the presence-bit branch so
+ * the cursor lands exactly at end-of-element after processing TID 7.
+ */
+static void sparse_presence_no_oob_read(struct kunit *test)
+{
+	/*
+	 * presence = BIT(0)|BIT(7): 2 maps present.
+	 * elem_size = sizeof(ttlm_elem) + 1 (presence) + 2*2 (maps) = 6.
+	 */
+	const u8 presence = BIT(0) | BIT(7);
+	const u8 bm_size = 2;
+	const int npresent = 2;
+	const size_t elem_size = sizeof(struct ieee80211_ttlm_elem)
+				 + 1 + npresent * bm_size;
+	/*
+	 * Allocate exact-size buffer so a pre-fix OOB read walks into the
+	 * KASAN red zone immediately after the allocation.
+	 */
+	u8 *buf = kunit_kzalloc(test, elem_size, GFP_KERNEL);
+	const struct ieee80211_ttlm_elem *ttlm;
+	struct ieee80211_neg_ttlm neg_ttlm = {};
+	/* Non-zero maps so the parser does not reject with -EINVAL. */
+	const u16 maps[2] = { 0x0001, 0x0001 };
+	u8 direction = 0;
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+
+	ttlm = build_neg_ttlm_elem(buf, elem_size, presence, bm_size, maps);
+
+	/*
+	 * Pass NULL for sdata: the only sdata dereference in this code path
+	 * is inside mlme_dbg() on error returns, which are guarded by
+	 * MAC80211_MLME_DEBUG == 0 in non-debug builds and by the dead-code
+	 * eliminator in KUnit builds.  The success path does not touch sdata.
+	 */
+	ret = ieee80211_parse_neg_ttlm(NULL, ttlm, &neg_ttlm, &direction);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)direction, IEEE80211_TTLM_DIRECTION_BOTH);
+	/* TID 0: map present */
+	KUNIT_EXPECT_EQ(test, (int)neg_ttlm.downlink[0], 0x0001);
+	KUNIT_EXPECT_EQ(test, (int)neg_ttlm.uplink[0],   0x0001);
+	/* TID 3: absent => map should be 0 */
+	KUNIT_EXPECT_EQ(test, (int)neg_ttlm.downlink[3], 0);
+	KUNIT_EXPECT_EQ(test, (int)neg_ttlm.uplink[3],   0);
+	/* TID 7: map present */
+	KUNIT_EXPECT_EQ(test, (int)neg_ttlm.downlink[7], 0x0001);
+	KUNIT_EXPECT_EQ(test, (int)neg_ttlm.uplink[7],   0x0001);
+}
+
+/*
+ * dense_presence_baseline - presence=0xff (all 8 TIDs), bm_size=2
+ *
+ * Every TID has a map; this is the dense layout the parser handled
+ * correctly even before the fix.  Confirms the cursor-advance fix
+ * does not regress the already-correct path.
+ */
+static void dense_presence_baseline(struct kunit *test)
+{
+	const u8 presence = 0xff;
+	const u8 bm_size = 2;
+	const int npresent = 8;
+	const size_t elem_size = sizeof(struct ieee80211_ttlm_elem)
+				 + 1 + npresent * bm_size;
+	u8 *buf = kunit_kzalloc(test, elem_size, GFP_KERNEL);
+	const struct ieee80211_ttlm_elem *ttlm;
+	struct ieee80211_neg_ttlm neg_ttlm = {};
+	const u16 maps[8] = {
+		0x0003, 0x0003, 0x0003, 0x0003,
+		0x0003, 0x0003, 0x0003, 0x0003,
+	};
+	u8 direction = 0;
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+
+	ttlm = build_neg_ttlm_elem(buf, elem_size, presence, bm_size, maps);
+
+	ret = ieee80211_parse_neg_ttlm(NULL, ttlm, &neg_ttlm, &direction);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)direction, IEEE80211_TTLM_DIRECTION_BOTH);
+	/* All TIDs present: every downlink/uplink entry must be 0x0003. */
+	for (int tid = 0; tid < IEEE80211_TTLM_NUM_TIDS; tid++) {
+		KUNIT_EXPECT_EQ(test, (int)neg_ttlm.downlink[tid], 0x0003);
+		KUNIT_EXPECT_EQ(test, (int)neg_ttlm.uplink[tid],   0x0003);
+	}
+}
+
+static struct kunit_case mac80211_ttlm_test_cases[] = {
+	KUNIT_CASE(sparse_presence_no_oob_read),
+	KUNIT_CASE(dense_presence_baseline),
+	{}
+};
+
+static struct kunit_suite mac80211_ttlm = {
+	.name = "mac80211-ttlm",
+	.test_cases = mac80211_ttlm_test_cases,
+};
+
+kunit_test_suite(mac80211_ttlm);
-- 
2.53.0


