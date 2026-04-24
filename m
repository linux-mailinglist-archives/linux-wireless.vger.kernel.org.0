Return-Path: <linux-wireless+bounces-35269-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFj1IWxd62lGLwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35269-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:09:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F086B45E32B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09630301DED9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637013C198A;
	Fri, 24 Apr 2026 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY1U2nHC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9613C2796
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032534; cv=none; b=fVoMm0trbMYC/YfR0N4QIfGuZTWn7Xd+QIhk1lnnnSUBo6cx1SeK12Zck+tfm1QZ3AqWrGIjVVHGs6Ot9sdHSNQzj9Xo+dwWSDW/WWXRj+UN/mwijkUYz9ogb7AKRTdVjXPZJ6XQZA3ZZRpywUZ1A7XFKXRzUdqIHjHpD/VmTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032534; c=relaxed/simple;
	bh=9tHrEWGdqU18BiORk7EDQHeASQCvb7/XtMslK0fwWng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jc+HtylPblOugB3yPDI2nFfM/Efu1JbssTbxQN6MTRo7I1kPLHJb7ZXfwngDnKL+Ro8n++rEhtXdpBiK+JmaXZxQMwltCQ9ZTCW2CRHfETnz7wAGeAWpF8aq1TKVY9tXT/Gmc9RnCwb34vbiATQisPg6Kg2a5DJUbwxUsv7Ne5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UY1U2nHC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-358ed696623so3559620a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777032531; x=1777637331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/Os3Uyzuv6K1kurOhm0rJphJVfq9iEefpjasR3TfPM=;
        b=UY1U2nHCF3MdNUF20o/oz4J77LFQscqiB+RU/Z2alZ71zCJ4oj3M1mrWBAnpzn4au7
         4grAaq12irb1XpOKw6hljYhnxXVqWwya6JAXxrp/LeYetirp6yiwhmGHSRzimm4ZtVME
         qPjxErMxvminvpejfh3FAvqBq+x2s/+CDa4BotNNOnW2WTaJsZbsqZN3YwvPsBGBWH1S
         qdJYeiRrT+ZA1L9yHP4uidYA1TOu0rmTTYJ8f9+Q5N+VVOGEkIfuwWDeGjB5TlZZ6G9E
         nfWXn3UDV/fGh7Lixkb4v5MaAPmpSW6QByM8wZv0veUIKhxdWp8diNnaczuRZeEskYzb
         DBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777032531; x=1777637331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/Os3Uyzuv6K1kurOhm0rJphJVfq9iEefpjasR3TfPM=;
        b=JVdQraogud1ATrZ3Gyw0THMAth7c/ot1pJoGxjTqTru5s/MHVWQKD6wyzmS0TyQyub
         zZnsKbiydp4vTUD/abG7UlR4jc23axZUi7gypIk0EaA91xJonzN9/tkM05bJquanfAiA
         63pnUqjplpZEjtLPhsSeFAFxGMkp1i3lQJh9tEEqf+fip+eXdGSg6PTAilI+luHwEBRD
         9X8cpzXNeuccVtJuF5p5W15PoRbtG1Of9mMJvfQR9biIyNDgH45VM7R5o0Q0ioWkZnVV
         q9mGNnFUt2gbdBf6iVeJdpbecHjMn5Jv3WIebP619DoACKPChLh+oxJ52kFWtvBGHV1V
         bJ0Q==
X-Gm-Message-State: AOJu0Yw8HuDBZvTAI+xTsjv/cWqJOuSzoEiuJzdTPH/ME6m+OsaDIjMs
	Mw+Up3VNMw7fZ0mcNyXH4eWIrHw8MRNqdsHbTU+Em7UmTSm9JcHbwRkD
X-Gm-Gg: AeBDiev1tW4YVlep2HXIoOieWQ/7KvnArTpx/Nlk8ldjKGOYsmVy1816ovxGWpZM682
	UgVbRmQ2oDUfQTCFQ8dUwtNdM0pR+Vk06athByROekzCaU6RHnsZ2XhS8ip2MwOCLjkOiSvbZ1C
	dk0etgh8kkzT4dCOcz/VbCMKrjBovaQJR44LVQfTpycYPzknYVDdbguroe/WPl5O36V/RXoKPdR
	BClxQ1j4rvnnI2N7nijcKmB55MAv53UXyX/bpjjvqYcpM20hzcZiOGvBUYwmeXcQ6Vmgmp6fl9q
	6NwBxIQvqjXa7+++P7wv0FD0EZKqPihdoicboQIEBFSn7ozqaU/HwpUaP0Y09+wYi0HKpzNxl/1
	nsTIL9JGImu5prKoREB4cBrqUt2jDWDp1lBaD5gAHJ2x6lwSO9emLwyE2gIBK57beQ3hpo9NGbo
	y4/0pOgOE9r+EfpWlZFpzfaZ2AR98xsIlSyYumCPDdYA==
X-Received: by 2002:a17:903:17c5:b0:2b7:a08d:9e42 with SMTP id d9443c01a7336-2b7a08d9f73mr84877695ad.32.1777032531227;
        Fri, 24 Apr 2026 05:08:51 -0700 (PDT)
Received: from kali ([203.184.33.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff39csm228701225ad.4.2026.04.24.05.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:08:50 -0700 (PDT)
From: Brite <brite.airgeddon@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	fjhhz1997@gmail.com,
	oscar.alfonso.diaz@gmail.com,
	Brite <brite.airgeddon@gmail.com>
Subject: [PATCH] wifi: mac80211: restore monitor injection when coexisting with another VIF
Date: Sat, 25 Apr 2026 00:08:07 +1200
Message-ID: <20260424120807.25005-1-brite.airgeddon@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F086B45E32B
X-Rspamd-Action: no action
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35269-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briteairgeddon@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Monitor-mode packet injection is broken on drivers that implement
real channel context ops (mt76 and others) when the
monitor interface runs alongside another interface (typically AP).
The monitor VIF never gets a chanctx of its own in this case, so
ieee80211_monitor_start_xmit() finds vif.bss_conf.chanctx_conf ==
NULL and takes the fail_rcu path, silently dropping the skb. In
practice this breaks tooling like mdk4 and aireplay-ng on mt76
hardware, including airgeddon's evil-twin deauth flow, which runs
hostapd on an AP VIF and injects deauth frames from a coexisting
monitor VIF.

Earlier attempts on this thread addressed the same bug but had side
effects - notably full VM freezes during the airgeddon evil-twin flow,
reported by Óscar in the thread. This patch takes a different approach
and has not exhibited those side effects across the tested configurations.

Fix in two independent pieces:

1) Snapshot-based fallback. Maintain an RCU-published snapshot,
   local->sole_chandef, of the single active cfg80211_chan_def
   when exactly one non-transitional chanctx exists on the device,
   and NULL otherwise (MCC, mid-swap, idle, allocation failure).
   The snapshot is refreshed from four chanctx call sites
   (new/free/assign/change) under wiphy->mtx, and consumed
   lock-free by ieee80211_monitor_start_xmit() under rcu_read_lock().
   The wrapper struct carries an rcu_head so stale snapshots retire
   via kfree_rcu(). Fail-closed on ambiguous channel state rather
   than injecting on a guess.

   This restores AP+monitor coexistence injection on 2.4 GHz.

2) Surrogate sdata for the regulatory check on 5 GHz. Once the
   snapshot supplies a chandef, sdata is still the monitor
   interface (injection tools usually spoof the source MAC so the
   earlier addr2 match does not reassign sdata). On 5 GHz channels
   cfg80211_reg_can_beacon() then rejects the frame because
   NL80211_IFTYPE_MONITOR cannot satisfy the regulatory requirements
   for that band. In the coexistence scenario there is already a
   non-monitor VIF on the same channel that is authorised to operate
   there; locate a running non-monitor sdata with a matching chandef
   (cfg80211_chandef_identical: band, width, both center freqs) and
   use it for the regulatory check. An AP sdata satisfies the check,
   so the frame goes out on the correct channel instead of being
   dropped. If no such sdata exists the monitor interface is left in
   place and the existing code paths apply.

Tested on mt7921u (mt76) usb with mdk4 and aireplay-ng deauth on
2.4 GHz and 5 GHz while co-running an AP on the same channel.
Tested on 6.18.12, 6.19.12 and 7.0.0-rc5

Cc: stable@vger.kernel.org
Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Reported-by: Óscar Alfonso Díaz <oscar.alfonso.diaz@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218763
Link: https://github.com/morrownr/USB-WiFi/issues/682
Signed-off-by: Brite <brite.airgeddon@gmail.com>
---
 net/mac80211/chan.c        | 75 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h | 17 +++++++++
 net/mac80211/main.c        |  7 ++++
 net/mac80211/tx.c          | 69 +++++++++++++++++++++++++++++++++--
 4 files changed, 165 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 05f45e66999b..9efab86f57d0 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -12,6 +12,61 @@
 #include "driver-ops.h"
 #include "rate.h"
 
+/**
+ * ieee80211_update_sole_chandef - refresh the sole-chanctx snapshot
+ * @local: the mac80211 device
+ *
+ * Walk chanctx_list.  If exactly one non-transitional, valid chanctx
+ * is present, kmalloc a snapshot of its chandef and RCU-publish it on
+ * local->sole_chandef.  If zero or more than one chanctx are active,
+ * publish NULL (fail-closed; injection disabled for MCC or idle).
+ *
+ * The prior snapshot is freed via kfree_rcu after all RCU readers that
+ * hold a reference to it complete.
+ *
+ * Context: Must be called with wiphy->mtx held.
+ *          Always process context - GFP_KERNEL is safe and appropriate.
+ */
+void ieee80211_update_sole_chandef(struct ieee80211_local *local)
+{
+	struct ieee80211_chanctx      *ctx, *found = NULL;
+	struct ieee80211_sole_chandef *snap = NULL;
+	struct ieee80211_sole_chandef *old;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		/*
+		 * REPLACES_OTHER: this entry is the incoming side of a
+		 * swap; the outgoing context is still live.  Skip it to
+		 * avoid counting a context that is not yet active.
+		 */
+		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
+			continue;
+		if (!cfg80211_chandef_valid(&ctx->conf.def))
+			continue;
+
+		if (found) {
+			/* MCC or unexpected multi-channel state. */
+			found = NULL;
+			break;
+		}
+		found = ctx;
+	}
+
+	if (found) {
+		snap = kmalloc(sizeof(*snap), GFP_KERNEL);
+		if (snap)
+			snap->def = found->conf.def;
+		/* alloc failure -> snap == NULL -> publish NULL below */
+	}
+
+	old = rcu_replace_pointer(local->sole_chandef, snap,
+				  lockdep_is_held(&local->hw.wiphy->mtx));
+	if (old)
+		kfree_rcu(old, rcu_head);
+}
+
 struct ieee80211_chanctx_user_iter {
 	struct ieee80211_chan_req *chanreq;
 	struct ieee80211_sub_if_data *sdata;
@@ -729,6 +784,9 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 				     const struct ieee80211_chan_req *chanreq)
 {
 	_ieee80211_change_chanctx(local, ctx, old_ctx, chanreq, NULL);
+
+	/* Hook 4/4: channel parameters changed; refresh snapshot */
+	ieee80211_update_sole_chandef(local);
 }
 
 /* Note: if successful, the returned chanctx is reserved for the link */
@@ -902,6 +960,13 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 	WARN_ON_ONCE(err && !local->in_reconfig);
 
 	list_add_rcu(&ctx->list, &local->chanctx_list);
+	/*
+	 * Hook 1/4: new context is now on the list.
+	 * Publish a fresh snapshot so monitor injection can use this
+	 * channel immediately.
+	 */
+	ieee80211_update_sole_chandef(local);
+
 	return ctx;
 }
 
@@ -928,6 +993,13 @@ static void ieee80211_free_chanctx(struct ieee80211_local *local,
 	WARN_ON_ONCE(ieee80211_chanctx_refcount(local, ctx) != 0);
 
 	list_del_rcu(&ctx->list);
+	/*
+	 * Hook 2/4: context is now off the list.
+	 * Republish so that a context removed during AP teardown is no
+	 * longer visible to the monitor injection fallback.
+	 */
+	ieee80211_update_sole_chandef(local);
+
 	ieee80211_del_chanctx(local, ctx, skip_idle_recalc);
 	kfree_rcu(ctx, rcu_head);
 }
@@ -1061,6 +1133,9 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 		ieee80211_recalc_chanctx_min_def(local, new_ctx);
 	}
 
+	/* Hook 3/4: VIF assigned or unassigned; refresh snapshot */
+	ieee80211_update_sole_chandef(local);
+
 	if (conf) {
 		new_idle = false;
 	} else {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e60b814dd89e..14c412a18868 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -40,6 +40,22 @@ extern const struct cfg80211_ops mac80211_config_ops;
 
 struct ieee80211_local;
 struct ieee80211_mesh_fast_tx;
+/**
+ * struct ieee80211_sole_chandef - kfree_rcu-capable chandef snapshot
+ *
+ * cfg80211_chan_def has no embedded rcu_head so it cannot be freed
+ * with kfree_rcu() directly.  This wrapper adds one.
+ *
+ * @rcu_head: for kfree_rcu() deferred freeing
+ * @def:      point-in-time copy of the active cfg80211_chan_def
+ */
+struct ieee80211_sole_chandef {
+	struct rcu_head          rcu_head;
+	struct cfg80211_chan_def def;
+};
+
+/* Defined in chan.c */
+void ieee80211_update_sole_chandef(struct ieee80211_local *local);
 
 /* Maximum number of broadcast/multicast frames to buffer when some of the
  * associated stations are using power saving. */
@@ -1586,6 +1602,7 @@ struct ieee80211_local {
 
 	/* channel contexts */
 	struct list_head chanctx_list;
+	struct ieee80211_sole_chandef __rcu *sole_chandef;
 
 #ifdef CONFIG_MAC80211_LEDS
 	struct led_trigger tx_led, rx_led, assoc_led, radio_led;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 616f86b1a7e4..387ed2786b32 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1745,6 +1745,13 @@ void ieee80211_free_hw(struct ieee80211_hw *hw)
 		kfree(local->hw.wiphy->bands[band]);
 	}
 
+	/*
+	 * All interfaces are gone by this point, so every chanctx has been
+	 * freed and ieee80211_update_sole_chandef() has already published
+	 * NULL. Assert the invariant.
+	 */
+	WARN_ON_ONCE(rcu_access_pointer(local->sole_chandef));
+
 	wiphy_free(local->hw.wiphy);
 }
 EXPORT_SYMBOL(ieee80211_free_hw);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b90c0537d0c5..54d06cfb670c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2398,10 +2398,73 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 				rcu_dereference(tmp_sdata->vif.bss_conf.chanctx_conf);
 	}
 
-	if (chanctx_conf)
+	if (chanctx_conf) {
 		chandef = &chanctx_conf->def;
-	else
-		goto fail_rcu;
+	} else {
+		/*
+		 * Real-chanctx drivers (e.g. mt76) do not assign a chanctx to
+		 * the monitor VIF, so vif.bss_conf.chanctx_conf is NULL here.
+		 * Fall back to the sole_chandef snapshot maintained by
+		 * ieee80211_update_sole_chandef(). NULL means MCC or no active
+		 * channel - drop the frame.
+		 *
+		 * The snapshot is valid for this whole function: it is freed
+		 * via kfree_rcu() after a full grace period, and we are inside
+		 * rcu_read_lock() throughout.
+		 */
+		struct ieee80211_sole_chandef *sole =
+			rcu_dereference(local->sole_chandef);
+		chandef = sole ? &sole->def : NULL;
+		if (!chandef)
+			goto fail_rcu;
+	}
+
+	/*
+	 * If sdata is still the monitor interface, addr2 did not match any
+	 * local non-monitor interface - the normal case for injection tools
+	 * (mdk4, aireplay-ng) that spoof the source MAC.
+	 *
+	 * On 5 GHz, cfg80211_reg_can_beacon() below commonly rejects
+	 * NL80211_IFTYPE_MONITOR because a monitor interface cannot
+	 * satisfy the regulatory requirements for the band (NO_IR on
+	 * many channels; radar-detection responsibility on DFS channels).
+	 * Pick a running non-monitor sdata operating on the same channel
+	 * (identical band, width and both center frequencies) and use
+	 * that for the check: an AP sdata is already authorised for the
+	 * channel, so the check passes and the frame goes out on the
+	 * correct channel instead of being dropped.
+	 *
+	 * If no such sdata exists, leave sdata as the monitor interface and
+	 * let the existing code paths handle the MONITOR case (CHAN_CAN_MONITOR
+	 * branch, or fail_rcu if regulatory does not permit).
+	 */
+	if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
+		struct ieee80211_sub_if_data *picked = NULL;
+
+		list_for_each_entry_rcu(tmp_sdata, &local->interfaces, list) {
+			struct ieee80211_chanctx_conf *tx_conf;
+
+			if (!ieee80211_sdata_running(tmp_sdata))
+				continue;
+			if (tmp_sdata->vif.type == NL80211_IFTYPE_MONITOR ||
+			    tmp_sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+				continue;
+
+			tx_conf = rcu_dereference(tmp_sdata->vif.bss_conf.chanctx_conf);
+
+			if (!tx_conf)
+				continue;
+
+			if (!cfg80211_chandef_identical(&tx_conf->def, chandef))
+				continue;
+
+			picked = tmp_sdata;
+			break;
+		}
+
+		if (picked)
+			sdata = picked;
+	}
 
 	/*
 	 * If driver/HW supports IEEE80211_CHAN_CAN_MONITOR we still
-- 
2.53.0


