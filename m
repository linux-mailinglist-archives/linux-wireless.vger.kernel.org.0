Return-Path: <linux-wireless+bounces-31533-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLPUMDw5g2ngjwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31533-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:19:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30154E5B6F
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951DB30737C3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5021E3EDAB9;
	Wed,  4 Feb 2026 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF2EVZb+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1A3EDAB4
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207239; cv=none; b=aIH1+DEnJqLfJOGMQjwxOMv7dDPhaUfMB8RDoYV3iHxPsUuuqAIZIzItMKPgXzz0eheOV+gEpX9Yw5+rFHaLrst2wyBRn1ITFLBNzc8mpFY6sQBJ8X7qybzhka1wEtWpuhmYUDWtxfGY1IeET7HBDFglfJ1bk3MYjvbFO3KpZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207239; c=relaxed/simple;
	bh=bCpPfM7ykKvxLfHfv0iJ5vhkcUFaigqwr574dyuumv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqbvTQVftrA5lJaMHteRwUo3iPYJeyDdB5E6LFXCVNG95+baCjDoxMpi6b4eu+B+jcNbe8Ue15eZ3MqwWNLqHi3cQX7KGu0k461q0IBF/EFYqds9Ot1BfBWFCjEmCYLQg08Bdx+5h3e4AJmd+HgnaDjMAi/XZtJ119E/mCXPkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF2EVZb+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a93210fcc2so8207675ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 04:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770207238; x=1770812038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnCijYo2nTB4mdViNtuwKKK2tDAdE/JiCOA5O+bAT2I=;
        b=SF2EVZb+8r2eDXi/lpds0IWhS5QfhXRYsKuJqVOgYGaSMRck+FYLNJsnT9PtW92ui1
         f1Peh3D++WNO2hFFcFVfwSjZc5ZaYG5IplFo6udTWV2AQqg/gWevySpHcJAdTOO+C86F
         Vw1TnF5pA1KnqlH0TwbqjHyoi+NTzgP8KSxx+sDbk1TNcUEaC379mcM1kxdD0Iy2VX2p
         k2HBmfKopHNzkhSkYleNu2aNffrNVwoecmMm4o3imISIXPfn0tAFng7IP/Ed2L+AqFn0
         QPaOk6d6wBreZFz9IR4J/+zsnSImCZKCHQM+Rowm5GSHaRjtHUjYeb2CLr4MwDjuyh+I
         ur+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207238; x=1770812038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnCijYo2nTB4mdViNtuwKKK2tDAdE/JiCOA5O+bAT2I=;
        b=muoPb1rXhbFdt9QGwpuOloXOX0lyS78BzJ40NKYNUOtAGo5mCw9YikjIzr4YgJWfi7
         BV4CqE3E14+ccbURKKE/DEh1CPdWem6a6qf9GCKwCs2Kyh9noP6V83RMp1XCjK/9BG9y
         3CwfeZVJGJSwlJvQZ4B0h4867k1XMw5lka6QwZQmCOuLMsrIoJVlxigCRmHtwdXrKqVk
         JKNKt6b6SDXrAbYO+DDE/h8CAd5IbuMuxyZ0eWyGW+Jz5EFTyPQzKVbiUBJw1Ke1tGcj
         kWFlpA9Gb4uRoPnqZvP+ZCDl2EglWkfdAbp6cKOqmH2OwSfPK9M9BtBkW4m3wz0/fI1r
         dfTg==
X-Gm-Message-State: AOJu0YwFVxq7WOj4tSO6Cqohnlai8wU8vdio2AZaxTB9j6Ee7380dpJ2
	2pXaDgadSN4nachqw9OEEXagCFQ6D356CWmohu984pjXzsUx8una5s1D
X-Gm-Gg: AZuq6aJgZ9lUBbFa0E6EL7AIoq/m07KwaUj7wJryjT3NtRv+qQZ8XmflmkuTbiLTP+P
	N0CLwILQp8ZmZm8irvPJ1WFm76W/rSQntFcU5igbtCK+oQcNT0tfpGimYShmTV6MjQD5XdQzZl/
	tXiGv9mJ7Hy319EC4+HDnBUudcvM3mCv94w+Jla3VWmwWE4TfgxyTIue9z2wHv/mY/SiiDZSunn
	YXGtu6gXI31lBiMxizSRO1+TflRN1BwJOdfsS0SFyKXrwLIeEJou4BF3PpD3C3nqUfDzUt4mJZp
	akrQ5xhsFvqrWASpGXRuwKY4ZIFqXso4ToUuRoc1F/zoCg9nxlSd7inQImf8qC2PEsexuOaVpLd
	dDivbMwxA5XJZ7AQc7RM5eCwviVdONFsSRrl+QIX8T93qj43/IJkCYPp2KZVYULQxaAwmM9HWNN
	PA/jVpDWY3oQ==
X-Received: by 2002:a17:903:1ac3:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2a933bbe729mr30736685ad.3.1770207238312;
        Wed, 04 Feb 2026 04:13:58 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:9794:b4e2:d5:4aa9:9038])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e37csm21299155ad.62.2026.02.04.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:13:57 -0800 (PST)
From: dhyaan19022009-hue <dhyan19022009@gmail.com>
X-Google-Original-From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
To: kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH] iwlwifi: dvm: fix NULL pointer dereference in rxon
Date: Wed,  4 Feb 2026 17:43:35 +0530
Message-ID: <20260204121337.4819-2-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204121337.4819-1-dhyaan19022009@gmail.com>
References: <20260204121337.4819-1-dhyaan19022009@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31533-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 30154E5B6F
X-Rspamd-Action: no action

Signed-off-by: dhyaan19022009-hue <dhyaan19022009@gmail.com>
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


