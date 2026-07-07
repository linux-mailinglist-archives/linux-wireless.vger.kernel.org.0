Return-Path: <linux-wireless+bounces-38718-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zMczMTtqTGq6kAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38718-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 04:53:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A74716E78
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 04:53:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Moc1Mk7z;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38718-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38718-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB43430166E0
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 02:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F573793CE;
	Tue,  7 Jul 2026 02:53:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F027A462
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 02:53:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392825; cv=none; b=GsLkHlv/yXXZMQeYvor8ZbYhz50A/5Gmw999oFsNVuWtfRDa/BuO3l5EaRE5pEq8KVjZ/2rQfAdp3PPyweIxI1A1YhHvSm1qEv4eTKXoXUHAtytTmBKL6LsGbuqFfjncZxdpASSdG+GlkyR+S1qwFmeFjdKdYncqNXJT9qteOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392825; c=relaxed/simple;
	bh=wBQCGIlMSX0+SapW0H7597cvHjPKicaL0wn5F9iUIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X137+pL348e8FClVoKJLZzalQWGs6LI/h1SDt+2UBIE9s5vTE8fK9hLzAWTo3iEB4DslMiH42wVjJkkgGH+Frdalj02xb+GqdyAZ0UNrj2lThDSFMQ2z66UKhmkmJzB+MfNPfR4b/4y6/52OZ39wiAs5o0HW7SORFjKCQ1zb1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Moc1Mk7z; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38426d04bb4so130384a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 19:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783392823; x=1783997623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkYiBAxPySXA7WrKbqpbNXghxMcAtJ80CfcZ89BeEpY=;
        b=Moc1Mk7zs2J17CMG9BCfQOvwPBMuWvsXf63dd5f24CzFLCcQ8uE7H09GDu4MZAZ/6I
         9BuEUPzQMfMEW1fjpxdavr0FFxn9E7Y36Dh7HGJgxJ2LhB4hQZedqo4L7rwU5mhThNCG
         GxwsrmOyFUWZKtHhKZgx/M+kClyWQKPRzcc2l5M9MrzswgLZbvmNI4EB2E32aObrQcoT
         kdVojcU/hKTnubKRPJGRJtQaUvu6ZBgh5ZaqT7MmB8gl16bWsjZ2f9auFS8Gvai5wrS6
         1F2tNTuuPnukEJk3urormD2OgNtJtOP8G1IXJPoEhfgGFrhgJcJit8SHlcU2mZk2H3nb
         oyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783392823; x=1783997623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kkYiBAxPySXA7WrKbqpbNXghxMcAtJ80CfcZ89BeEpY=;
        b=ZLAjainPkU2/sXSg+/PYDT4sp8FAOvV9UfMhhibzzpnESS/8eZnjiNMHFRGG/O+rVm
         CQDywFWDBxuybzwD/DJSPrta+oQnSAL0zQ9aXq5DhqOzBnZed4P1+C91OeVkp4X6Pi0E
         lvDSVDvV3Cex0U2U2lyANWZOjduFvTPqOAQeCibFxBdjRAACPgKDIiEw6N5h+J9Umv/d
         koroOuC7hWVcnmw5VpCeGDr739GlHhtaS8qP3RpPqumjhIZJqHFbehSaUs8+Lb0uRb8g
         VFtU7oS7ZKVqUO00wB3G1VDMuoDYovcm7ke1w8u9pMfIdvpQt/vuDYXRExaJqqQzxkCQ
         FHwQ==
X-Gm-Message-State: AOJu0YwifPDrmUXkoo/3Xh7iO2QC/8rFibKsaP8wN4Hu3aMpVD6Og2dV
	68GWAyveNH5TOjco9jlyNmZJxu/3mhGg22XXWCKgmchApsN78eX/ZX1i/QKMw76arJ0KKw==
X-Gm-Gg: AfdE7cmy/nDah+zkytBgaTrvUdA9ETIdaB7SOUWVLdAKSBDkLAMhFtena/oEbSa7fWF
	fW0rRkGXrhdJpWz6qxAvrNr/OHlq+TYgo+YHe2bDZPFWQDvcHhtsTVcvisnmCPDcrZ725vKKhYn
	os8QGDJOuGacx0Ng3g5ZB5UKSCtTsaBAoro72FQ8nZbF6swTWI8IFVhRP7hJSrz7jf41z+Uu2Hz
	lydVwO/0fNVGh/YLvNgLrFpOLfGb9Mv5DqYtL8xjztoE2ghXWjZhjDS1Yz8eTwzwxZMgq5RmSKr
	7395bF3uwv1jE4TYxoazlNx+MGd4taKM2cdUfoxTkrFdIC2HigqI1LPfstr9tyT+eahlZOF9QxC
	UqwOUvC1VhszrUMLCDLm0XSYeFHobXRn6ZJsi7mMyFY2YOLGGbD+EEtDr1E0G/6Ci55QzYOwuud
	Y/oNPPs+vnuWriM8Sjid1Xy3qm11R27CMg2GFaq38=
X-Received: by 2002:a17:90b:1801:b0:387:d9cc:7dc1 with SMTP id 98e67ed59e1d1-387d9cc8dd9mr1002230a91.19.1783392823161;
        Mon, 06 Jul 2026 19:53:43 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([2407:cdc0:606d:ba36:a6c6:36ae:a290:5cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f598dsm2755235eec.6.2026.07.06.19.53.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 19:53:42 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] wifi: cfg80211: validate rx/tx MLME callback frame lengths before access
Date: Tue,  7 Jul 2026 10:53:34 +0800
Message-ID: <20260707025336.22557-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <488ed9862d5196b8f5ecf23f037fa6725fbe9a52.camel@sipsolutions.net>
References: <488ed9862d5196b8f5ecf23f037fa6725fbe9a52.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38718-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26A74716E78

cfg80211_rx_mlme_mgmt() and cfg80211_tx_mlme_mgmt() call tracepoints
before rejecting frames shorter than the frame-control field. After
that, they only require len >= 2 before dispatching into subtype
handlers that assume their fixed fields are present.

The frames that trip this are not shorter than 2 bytes; they are short
relative to their subtype. mwifiex is a concrete in-tree example on the
length side: mwifiex_process_mgmt_packet() only requires a 4-address
ieee80211_hdr plus the 2-byte firmware length prefix before handing the
frame to cfg80211_rx_mlme_mgmt(). After stripping the length prefix and
removing addr4, pkt_len can be exactly 24: a bare 3-address management
header with no reason-code body. The existing WARN_ON(len < 2) does not
fire on such a frame, and cfg80211_process_deauth() then reads
u.deauth.reason_code as a two-byte access starting at offset 24,
immediately past the 24-byte buffer.

Add a frame-control length gate, then validate each subtype's minimum
frame size in an if/else-if chain that mirrors the dispatch logic. Trace
only after the frame is known to be well-formed.

Side effects of this change:
 - The WARN_ON(len < 2) is dropped. It only guarded the frame_control
   read, never the subtype fixed fields, and it does not fire on the
   frames that actually trigger the out-of-bounds read (which are >= 2).
   The len >= 2 check is kept as the guard before dereferencing
   frame_control, but without the warning: these are exported callbacks
   and a malformed frame from a driver should be dropped silently rather
   than backtraced.
 - cfg80211_tx_mlme_mgmt() previously routed every non-deauth subtype
   through disassociation handling; it now silently ignores unrecognised
   subtypes.

Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
v2: Rewrite the commit message. Drop the inaccurate claim that these
    callbacks "legitimately receive short frames" (< 2) from drivers;
    no in-tree caller passes len < 2. Document the concrete mwifiex
    header-only deauth/disassoc path that reaches the callback below the
    subtype minimum, and clarify why the WARN is dropped while the
    len >= 2 guard is kept. Per Johannes' review. No code change.

 net/wireless/mlme.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index bd72317c4964e..a0f7b08bfcc9c 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -150,19 +150,35 @@ void cfg80211_rx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct ieee80211_mgmt *mgmt = (void *)buf;
+	__le16 fc;
 
 	lockdep_assert_wiphy(wdev->wiphy);
 
-	trace_cfg80211_rx_mlme_mgmt(dev, buf, len);
+	if (len < sizeof(fc))
+		return;
+
+	fc = mgmt->frame_control;
 
-	if (WARN_ON(len < 2))
+	if (ieee80211_is_auth(fc)) {
+		if (len < offsetofend(struct ieee80211_mgmt, u.auth.status_code))
+			return;
+	} else if (ieee80211_is_deauth(fc)) {
+		if (len < offsetofend(struct ieee80211_mgmt, u.deauth.reason_code))
+			return;
+	} else if (ieee80211_is_disassoc(fc)) {
+		if (len < offsetofend(struct ieee80211_mgmt, u.disassoc.reason_code))
+			return;
+	} else {
 		return;
+	}
+
+	trace_cfg80211_rx_mlme_mgmt(dev, buf, len);
 
-	if (ieee80211_is_auth(mgmt->frame_control))
+	if (ieee80211_is_auth(fc))
 		cfg80211_process_auth(wdev, buf, len);
-	else if (ieee80211_is_deauth(mgmt->frame_control))
+	else if (ieee80211_is_deauth(fc))
 		cfg80211_process_deauth(wdev, buf, len, false);
-	else if (ieee80211_is_disassoc(mgmt->frame_control))
+	else
 		cfg80211_process_disassoc(wdev, buf, len, false);
 }
 EXPORT_SYMBOL(cfg80211_rx_mlme_mgmt);
@@ -215,15 +231,28 @@ void cfg80211_tx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len,
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct ieee80211_mgmt *mgmt = (void *)buf;
+	__le16 fc;
 
 	lockdep_assert_wiphy(wdev->wiphy);
 
-	trace_cfg80211_tx_mlme_mgmt(dev, buf, len, reconnect);
+	if (len < sizeof(fc))
+		return;
 
-	if (WARN_ON(len < 2))
+	fc = mgmt->frame_control;
+
+	if (ieee80211_is_deauth(fc)) {
+		if (len < offsetofend(struct ieee80211_mgmt, u.deauth.reason_code))
+			return;
+	} else if (ieee80211_is_disassoc(fc)) {
+		if (len < offsetofend(struct ieee80211_mgmt, u.disassoc.reason_code))
+			return;
+	} else {
 		return;
+	}
+
+	trace_cfg80211_tx_mlme_mgmt(dev, buf, len, reconnect);
 
-	if (ieee80211_is_deauth(mgmt->frame_control))
+	if (ieee80211_is_deauth(fc))
 		cfg80211_process_deauth(wdev, buf, len, reconnect);
 	else
 		cfg80211_process_disassoc(wdev, buf, len, reconnect);
-- 
2.50.1 (Apple Git-155)

