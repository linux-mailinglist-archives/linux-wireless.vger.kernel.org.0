Return-Path: <linux-wireless+bounces-31536-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIcIM4A6g2ngjwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31536-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:24:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33113E5BE0
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8BE93018BE1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686E7352C34;
	Wed,  4 Feb 2026 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtHxwfdl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9A33344B
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207855; cv=none; b=kQ7odtGYYuOq5UmWX/9xdvB+6wVUygxhec2MAgR2fGykijwyf8CWsLO4h7ewMhnVEWliutGdraM4RgwPMHlhaUUqNe4xpC1gMJuv2Fuke20RcRdso8Cr32/JXSYTkTR8maRnuZ3DKuQWhoG73irke/+jgk7aTnbF03HjXCsQhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207855; c=relaxed/simple;
	bh=YEqdGKJFnp54IoaSIGE3WThwrCBglKpoqMSk1ypDeWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlgPC+isGeJbXC2cNLONDE9dpWwyCQiAmhGk1fyF+KJlXRdDXq0MQ072O4Cz3tNxKM3eZspmfB7wmqPUWpS0OiivROB6h/adpN6DE5mBlRI5cpT/foBYzmTwwYrZM0VZqTp0PzK6L4gBz+OiU44A0o8sTkhlnEl2LABWPdXBpR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtHxwfdl; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6788f3db37so1856845a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 04:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770207854; x=1770812654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1BzUH0tFAEz3TfMMaMh2o3Cl6pjkhdKbgQUMVa0AOZk=;
        b=ZtHxwfdlm7VolOmGbI9nn2QBNhIkeZ3TgCdgAxtTyI/Bfo4qowwQt3Eige8a8ea/pA
         /Yl7gCglv5+fYYZtydoxZRhSmipuVXp4EVWWjdAq92+1v7ezR//n8kyHeDlwLC1Mjdv6
         2BXGPWFnmrVEALv6tR1R5fy+g9zSkQ8tVE7hHKkut52MDd5FRAnuw6fa4uOPaI+1ou7z
         6Y7JsGxD0cpNc5d83XFJ0oVdMcl5uvdVW1cHIpW8OgVVxLvFxj2qHl4pO9GBO91nVOaO
         1yhxhv8KNyMXZYT31huH8VuVkbz35tJXDFTE/mhT1oZfyx2cFSAAtadHNuoz44LDCeQy
         S8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207854; x=1770812654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BzUH0tFAEz3TfMMaMh2o3Cl6pjkhdKbgQUMVa0AOZk=;
        b=ADGz0LdyOKeP3GLCbQRyp5/DDlr1HyAIW+tM+nvZNfI6D8MRY7ft3ySZfuR02TzyKW
         7n1hKRNFQM9RbtV7YAZWuCzNPXMTB1ScaNoZL867q+bLzqZF+4SEH9aVZWlqrkpNGS75
         CI3Rpp2MnvY2DQMvvOzKkoNB0EsPZyHgy002dQuYhyciFlE+DYWUgH2AnsCytXD1/cwR
         6V8jKhP/VB6j15CX17LezZwiNoDxsDtIPWHL5RYZsucpsSgsJN+Qneccoc+KRY+H7btr
         4BpO5FhKMGycpsw61RBsr6/uRTEfOH3DYA8ZOU8QpxJ44V/Ir2Uy3+u/wR6MGBe6/uHL
         Xizw==
X-Gm-Message-State: AOJu0Yw4XamcRYMshu4vihsw9xDu6eDrK82bezB3UiuzXxwumcp1IzGI
	41vDO6vx3DwYmTXUo/gPGEB9B9HsD1aLmaLc5SXp/ifYpJTHs6GMtEyc
X-Gm-Gg: AZuq6aKtOcDDr7qmB0ooenYndag90np0Be2/iSKA/OfJ+pLl5OLx4xfEzTZMH8uGFVW
	BemZ11mO7obncB1i7VWS5OJVpXLyTUIgzc0CfI4nmo1rQuKXcgUGH2hxM9wBvzLC2v/j8dKtHxD
	IgGA0Bpuq7t3As7COG5uQCntofL+TxNhPiE/nZUWdXg2KHkbKw9ob+ekgFD1OAeOJKjVJ2+N7dd
	+Tku3VxCYzceiy1mNWvbbso5XOckJVBqWVGm+PidLjR5oncupXep7pzxs6SvZUo+vDv4Avg4U1U
	KGUxWZVUZoiidzvNCvZ6eQhwQHETAKlH/iaQhntxCu0Yv1TVkHnQpw/4Ch/5givzVazRqlP4RzS
	NiDdZBlpj/8y7TmY+nDuBTnyjTGYe/57IrmDK9Q/2vW+vb9wGcj71HZ00y+4ZttcWi3SZjY7nSq
	c569VReEQsfw==
X-Received: by 2002:a17:903:3bcc:b0:2a0:8859:3722 with SMTP id d9443c01a7336-2a933e547abmr25404245ad.25.1770207854470;
        Wed, 04 Feb 2026 04:24:14 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:9794:b4e2:d5:4aa9:9038])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d49cabdsm2207045b3a.60.2026.02.04.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:24:13 -0800 (PST)
From: dhyaan19022009-hue <dhyan19022009@gmail.com>
X-Google-Original-From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
To: kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH] iwlwifi: dvm: fix NULL pointer dereference in rxon
Date: Wed,  4 Feb 2026 17:53:59 +0530
Message-ID: <20260204122359.5042-1-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31536-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33113E5BE0
X-Rspamd-Action: no action

When bringing up the wireless interface via virtual monitor mode,
iwlagn_bss_info_changed() can be called with a NULL bss_conf pointer
during ieee80211_add_virtual_monitor() -> ieee80211_do_open() sequence.

This causes a NULL pointer dereference when the function attempts to
access bss_conf fields at offset +0x10.

Crash signature:
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]
  Call Trace:
   drv_link_info_changed+0x2b5/0x2c0 [mac80211]
   ieee80211_link_info_change_notify+0x13d/0x160 [mac80211]
   ieee80211_recalc_txpower+0x5c/0x60 [mac80211]
   ieee80211_assign_link_chanctx+0x182/0x410 [mac80211]
   ieee80211_add_virtual_monitor+0x17c/0x2b0 [mac80211]
   ieee80211_do_open+0x6d8/0x740 [mac80211]

Add an early NULL check for bss_conf before accessing its members.

Hardware: Dell Latitude E6430
WiFi: Intel Centrino Advanced-N 6205 [8086:0085]
Kernel: 6.18.7-061807-generic

Signed-off-by: Dhyan K Prajapati <dhyaan19022009@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index e08e44cae..2d480b1d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -1392,6 +1392,11 @@ void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_lock(&priv->mutex);
 
+
+        if (!bss_conf) {
+		mutex_unlock(&priv->mutex);
+		return;
+	}
 	if (changes & BSS_CHANGED_IDLE && vif->cfg.idle) {
 		/*
 		 * If we go idle, then clearly no "passive-no-rx"
-- 
2.43.0


