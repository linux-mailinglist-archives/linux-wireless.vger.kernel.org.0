Return-Path: <linux-wireless+bounces-32721-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X5hLAq6nrWmE5gEAu9opvQ
	(envelope-from <linux-wireless+bounces-32721-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 17:45:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 908992311BC
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B61B300A319
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2026 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1033D502;
	Sun,  8 Mar 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flrF4yNa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275F332606
	for <linux-wireless@vger.kernel.org>; Sun,  8 Mar 2026 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772988329; cv=none; b=LNr91+TftSAH2/ZYwq9j++MTvlIaSTWHEQsDNLgPxjxPlYoNJeNjjN2TcYJfrYO27uiMcmboArignTCKrOI52gSiMPQr++h4eDenTco4iAZdfLWI5kCYzll8cvRlWA/gAp7IinHnB8pCOyf84V8jWjV95djTMsaacQY9qcCYoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772988329; c=relaxed/simple;
	bh=3ZsMukaIBQF8clZEQgBlk3fbZVydnmjSCHhfvXHBBzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tmN4wcAaoXsfRPIiRZIglRMNwHpHHhXNZQ4G/bM7dfkevyGA2Cmpij6uagcJY7p1s9Q6I47L6FHuVFttYtbk8ngmc8pRpkCw48DcTRheUSNIX4ODKSaqGDtrxwoCdsN4uxaoufUYfAg11neJt5Qt1H++Cz675d9XZhZ3IGKqI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flrF4yNa; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so4261659a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Mar 2026 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772988326; x=1773593126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSyQyBckY6yDa/40OyCVuQtNFVPo/rjnkS7c5eUMd0A=;
        b=flrF4yNaol2fc3hCgZhuzXrD2oED35/tBD7lf+Hl2XV0Ru4a9n0KjpZ5Rs5WozdQPo
         RTrUY4i5YosfJQzQdNgy/T6ZG+MCyLiE20blOtS7PySl5Iq8ZgDgXSnnRVSWrinXt6EY
         th4QmHamBW+AgUwQBcAEsCQ0JyC0Cgmb1DVUslgHfrTP+3RjRsuOg6GvaKA3mMTaDy8k
         WAvEizK7ltI7sKbuId4q734cVDWOX7Wh6FzWAzd7gXxg+7OCIj1Xz4sVOYQ2sFi34MsB
         murDuMa4HCXzGN2uiQCou7kWWjSrggk76lYPYhfSpSwVSd4d96sWJm3nVIm/Lttap/l5
         GnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772988326; x=1773593126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSyQyBckY6yDa/40OyCVuQtNFVPo/rjnkS7c5eUMd0A=;
        b=d8Rh5TZ7252HjVwUyZYs3T187yBbMBR1KiEV0JJt2scjl6d1ks/OM5QHnRS0gcZcC3
         AZ3jNexLPSHhe/dXf+E9GFaxTpmhksj8euwWCa+X+NLWNdJeB8wIJCVzgZ8WNzDurRSk
         07rFeohNkmRJG+8ePuNlHOLOmr/DQiCbh+7qRMAieW1sFWcn/xUh1bNedeK9cQFyVKN2
         5MTLt7JUtGPJfTf0FEeimeALr5SYirogzRHHM6AcYu+XHFOCe7nVIL11JoEuyW1eeRuK
         Y6aVQONPtQt7JYLoqMfiHSrt8rvH+oXzAC/19VUGIov4eHBEbq9j4VLHydmJqONrFvr1
         20/g==
X-Gm-Message-State: AOJu0YzK3OeVgW3ZIH0rTlGfG++P8kct+gdiHAMvWMjIpWKSJVQFs7fe
	sdG1s27Y4mCjGbwhRDA/X9+svb1Bq0cE0zSs8E+glwTxd0bjq1FAL5jD
X-Gm-Gg: ATEYQzxh9ZN8IFn47lDn0IaVEB3tuYcWB/1DSHqTc4GP3+Wc9U6sLmrM8yMCd+5lWYL
	eFRDeIeg17687f37qOG3k8/JQh5T6x7Bk8XZbNDJduf4wfX7ZMDyAQhdj8deWNrAWjVQbSEIwLV
	qwHmFCmRctsHZxa+jYtUojDq3sMJpLLz+4mqBDI2HVIdVzPLt8F7g5hWiYaTD9RexCuXwOdNqVe
	l6+D749Lojw5FfWU8ywXPYRY0wHn9rBR1yUiXtSZ+sodIprc22wTp5W4D1fXODIyhrg8H2v2lX3
	gLE7MtbA+YC+NLAwwpq1xpOwMah5DZNy6C6WZwfJY+zwR77dyvTgOP8kNQ13WlyVyermW47yNPC
	WcBOkibMuKAyJqLAEFRx9Qoyakjy7tzIV+BIXZNM9rB5hI0D/aiZDyVrGrmTTyl1pN0l26pUujw
	m9wWYprQvQ18bWNpECktp9WzcLOlQM9Y6FGTltEDA2s4szK3Ij
X-Received: by 2002:a17:90b:2b4e:b0:359:95c2:b3e with SMTP id 98e67ed59e1d1-359be390472mr7284097a91.30.1772988326156;
        Sun, 08 Mar 2026 09:45:26 -0700 (PDT)
Received: from localhost.localdomain ([112.10.226.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c0179a67sm8032737a91.13.2026.03.08.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 09:45:24 -0700 (PDT)
From: =?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
Subject: [PATCH] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Sun,  8 Mar 2026 16:45:10 +0000
Message-ID: <20260308164510.5927-1-fjhhz1997@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 908992311BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32721-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fjhhz1997@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.950];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Commit 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
removed the fallback path in ieee80211_monitor_start_xmit() for when
the monitor interface has no channel context assigned. This broke frame
capture and injection for drivers that implement real channel context
ops (as opposed to the ieee80211_emulate_* helpers), such as the mt76
family, when a monitor interface runs alongside another interface
(e.g. managed mode).

In that scenario the (virtual) monitor sdata does not get a chanctx of
its own, even though there is an active one from the other interface.
Before the simplification the code fell back to local->_oper_chandef;
after it, the code goes straight to fail_rcu and silently drops every
injected frame.

Commit d594cc6f2c58 ("wifi: mac80211: restore non-chanctx injection
behaviour") restored the fallback for drivers using emulate_chanctx,
but explicitly left real chanctx drivers unfixed.

Fix this by falling back to the first entry in local->chanctx_list
when the monitor vif has no chanctx and the driver uses real channel
contexts. This is analogous to how ieee80211_hw_conf_chan() already
uses the same pattern.

Tested on MT7921AU (mt76) USB adapter:
  - v6.13: managed + monitor coexistence restored (0 -> 37 frames/5s)
  - v6.19: managed + monitor coexistence restored (0 -> 39 frames/5s)
  - v7.0-rc2: managed + monitor coexistence restored (0 -> 33 frames/5s)

Cc: stable@vger.kernel.org
Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Link: https://github.com/morrownr/USB-WiFi/issues/682
Signed-off-by: 傅继晗 <fjhhz1997@gmail.com>
---
 net/mac80211/tx.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8cdbd41..56eaf9a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2396,12 +2396,28 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 				rcu_dereference(tmp_sdata->vif.bss_conf.chanctx_conf);
 	}
 
-	if (chanctx_conf)
+	if (chanctx_conf) {
 		chandef = &chanctx_conf->def;
-	else if (local->emulate_chanctx)
+	} else if (local->emulate_chanctx) {
 		chandef = &local->hw.conf.chandef;
-	else
-		goto fail_rcu;
+	} else {
+		/*
+		 * For real chanctx drivers (e.g. mt76), the monitor
+		 * interface may not have a chanctx assigned when running
+		 * concurrently with another interface. Fall back to any
+		 * active chanctx so that injection can still work on the
+		 * operating channel.
+		 */
+		struct ieee80211_chanctx *ctx;
+
+		ctx = list_first_entry_or_null(&local->chanctx_list,
+					       struct ieee80211_chanctx,
+					       list);
+		if (ctx)
+			chandef = &ctx->conf.def;
+		else
+			goto fail_rcu;
+	}
 
 	/*
 	 * If driver/HW supports IEEE80211_CHAN_CAN_MONITOR we still
-- 
2.43.0


