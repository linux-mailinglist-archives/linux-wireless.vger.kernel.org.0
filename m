Return-Path: <linux-wireless+bounces-37752-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1h38Ig1VLGozPgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37752-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 20:50:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D7267BDA1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 20:50:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hXspp3xM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37752-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37752-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1003830258AE
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6269D38F25C;
	Fri, 12 Jun 2026 18:50:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF24306764
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 18:50:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290251; cv=none; b=n1/UmpAtKeXBFVCTuS9UXpmslKMrklx82F8AqZ6tAVXhWzL/BkFFVEOj/4UaLnIK9IMEzh9RQFRtGrUyaS6zAL6ph0jGbHj41ELbsBbeo0SPSTNVtbJksUlcSpBUt0AOIak7dV8huHFd/OTQY32AYyxWJC6eh0DzEzOrV/nSihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290251; c=relaxed/simple;
	bh=RjeRbOoTrbF/XF54IQipgRWnwRaic6eqrpvCZmcfN+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPhQPWI0qJxK9KzJebejRY12ZHSC11dHaZP4Oiuu0WzAraRXXrVBEvR16p6t6H+kT75hmu3JBQ/pDHgB+sgcfmj6GmL5kdBJQ8hrCj5SZP3CDjfj1skQPMC1/77wbJ15P1kC6A21YUeAgwjCWtzdOw7lLPcnwisUFZZr+/jWn88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXspp3xM; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf3781ca51so12364545ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781290249; x=1781895049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOencamB6yi9xd79O30glimQGbgQqojfsGSOnEGLv5g=;
        b=hXspp3xM+hHiTicyJDI/V/d0rS08L2jhoqKgkBvvkSIJhZojqZC+puKuksoqEDgoMg
         gBDZipV886UHj9JvaaeakJoQRtu0o6f4mPFCjqTsA5ayCieEEXma6/h2aZMFHRYmVmSU
         jnSQbEIRGbaV4hKDIH2/NzvzOqBMF0cwFKw53bhWUT3BP7XXUehuLg2z+YqSJv8ql9Z1
         gcHRhTNmM3XU1aUTB3qgU/BmzNBnBnKnd9vJGrRi30SYXaXjg7s1hwCmDYl2AqH3HbyI
         9NheI0hq9N9qLeN4OAUEmPlyt6ra4ohCXbpPhNbxW8Bh0r4eXek3LL3t0LFn7vWQR3nh
         AYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290249; x=1781895049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOencamB6yi9xd79O30glimQGbgQqojfsGSOnEGLv5g=;
        b=UP71TFXVcGLTQ5kYpcbIxa/R3129vLrK/SZrugBvztEzusV7bxNosWhss+nY+5Szr/
         kCIAicfctDESpPPzxFVIely3QhfeIHFHeRQpftVf/31N8X0qNAbAvluoSu9DZkpA+M+A
         /6d0kHE4tvz6EIaLsCtVt7MI/lqzuuJRhrEqsDLJeY5pOGcf7ZnUbPCbnNGd+hdmzkUY
         GDU5CQUSr+/XurjrfsKaz/WmcUPttxPzHqrJGvjlUXxRY6MntKSApEXP60lb80b4oNcn
         CBUpM/T8oaaDSX4O7UHvUdnIJa5wdYdMA5Si9jTLQ9MpsPzYZRrrsWzh9d/k57vlwUa5
         Xe1w==
X-Gm-Message-State: AOJu0Yz/sRfw8xiwp0xiXvy8hRAyPqin3rRgoZqkR32Epe5XjeeNqFMw
	0TQiDcH1kXb8yrwMsgMM4JW9SSgVeqbzQGACs9fSvwjholwyv/OOZYqv
X-Gm-Gg: Acq92OHwKqrEbiMsBliYTyIahrReSEzS3/YnKaCB6dXMQlVVrwhYVvHrPx+GARFz7jy
	bbYz23k9uYjTlOwPrqKQTFPBGv5B+9J/x5qCfYUZc55wP4nfB+w7jmtmqnEPDt9g+T9jI6xl6V3
	1myokdNmOulFYDwVeyrwbhuvt9o9YuqZfoiM038quvp4Ve3tZAuTXWeGKXu4PLa31TwYD7PXxLA
	7U2YS8EasC38JoVG7bgqkoANJa7f3YcCyeBd55PiAi3klKS97CspeOU9AAsyWHKJLx1CSk/Xd4e
	FPkw6zipB5arf8OyKHUVH6gb8ziriJQwHRRKah5CkCv1QGAebSDVLQ6q93CH8rRiYFwqxA6kH6m
	ukiBIPIASQrYj8EuYLCQSukcu/7+YQBOb8EqqXWjXzgAUYhG/BWnesksIIqyZXUi9osV8VcsTBS
	qw1+/M5Z7sjLMzpeEOl9pOHoyt6XfnitINaEMOjx1ySerd6KQp1uos2y+cARdyj/I=
X-Received: by 2002:a17:902:e551:b0:2bd:907:2cf0 with SMTP id d9443c01a7336-2c664292bd1mr8957965ad.32.1781290249317;
        Fri, 12 Jun 2026 11:50:49 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432d8a039sm28464465ad.62.2026.06.12.11.50.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 11:50:49 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] wifi: cfg80211: validate rx/tx MLME callback frame lengths before access
Date: Sat, 13 Jun 2026 02:50:43 +0800
Message-ID: <20260612185042.66260-4-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37752-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05D7267BDA1

cfg80211_rx_mlme_mgmt() and cfg80211_tx_mlme_mgmt() read the frame
control field without first checking len >= 2, then dispatch into
subtype handlers that assume their fixed fields are present.

Add a frame-control length gate, then validate each subtype's minimum
frame size in an if/else-if chain that mirrors the dispatch logic.
Trace only after the frame is known to be well-formed.

Side effects of this change:
 - The WARN_ON(len < 2) is replaced by a silent early return, since
   these cfg80211 callbacks can legitimately receive short frames from
   drivers.
 - cfg80211_tx_mlme_mgmt() previously routed every non-deauth subtype
   through disassociation handling; it now silently ignores unrecognised
   subtypes.

Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
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

