Return-Path: <linux-wireless+bounces-31528-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEsJN9Mvg2kwjAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31528-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:38:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7020AE5387
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A19E13013AAB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9BF3D523B;
	Wed,  4 Feb 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjLFzDH3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5453AE6F5
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205114; cv=none; b=C3TmwrdeGb0dWPZ7+Mi3Vmff6aB1KjVyCYd0HHEQbamD9nD3fsN6PFrA3L0PdlZ6rkA905ffy55ltyKfKZRlHEGgyeiTDhnI9qYJGb4aFsht81+eu/+iHs156nRU2CMLdsz26Vcyn575rRdgesPFNy1VLiNbTmIoEEMwmZbCp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205114; c=relaxed/simple;
	bh=bCpPfM7ykKvxLfHfv0iJ5vhkcUFaigqwr574dyuumv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdslwwmiWK0J1iIx8Dov0S4+cs5gJK0LS/ZCyBvo7hWxN9mUAo/ylyoTFJVYpjF2KjrRjx5euW2dA88W3/mpfDk+h5b3hkg87y/En9dczTkK9a2Oh1DTBCHXXZ/NoUW69f9MY7NN0/32NhQOcHgmA9O/5LagPtYz8XaP2lb46BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjLFzDH3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823c56765fdso2549605b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 03:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770205114; x=1770809914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vnCijYo2nTB4mdViNtuwKKK2tDAdE/JiCOA5O+bAT2I=;
        b=OjLFzDH3OPqP0Jf8x8Xld2rz9TPHwA2UPExIMHfN7NmLRoibBFuyhFuInjX3ARFdE4
         NiqqTRppwinqd8DKOT41mERV3TNgARceV1r877wyxM+LAJ1mjOOk+JCf1ePYKYklOvgu
         PNh+akE1EJJDR3Ut/Gn38bvmaZemQ1A6dTymB8uR/y9/9tcY4FIX5dCKD4pgo7/RLfLi
         saMlD0GONkbzPu+fj3zx9JmTDtI/c7wtVwaMRieZ2hVYyEILIqHqWAyIImM1l5GkjU+4
         v4lkOr8gyJz7g/gPIh7+R5F0V5GAXE8YGw8iY9z4k/9gbNMHb4tDS4xWppGHKaIBoXsW
         P5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770205114; x=1770809914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnCijYo2nTB4mdViNtuwKKK2tDAdE/JiCOA5O+bAT2I=;
        b=HZ3Rd0FP4aJQC2YWFQPQh+xKJpBvmLatBItI9/tSlMxc+yrC2JkBO7YpXHWtnZBWJB
         tvlJb+Gmdc9bjdDic2n/GEw7knlrvYwSY4HP+75/T/rm3iF5txrx1pm4JfrwDN0hiMBK
         HivYB/KlhxjLsdqGr3hc2kgJRLRdJ8zK1zM6Vx+oaX5YIHr0HRgNOePkjOz+NHHZW4q3
         53jtQjZUkP9qwsjlUsn3w8MlvwLtj1CrpN+mrWkicy2Bv4untRkoHa985yt2lbrYiHBV
         8spZy4V+iNgnZOwff1AQ0ZTfRgxK/t/ZbEa9QS9e/AkATfEvYsAnLErhx5+g2ZWjPndU
         P+eg==
X-Gm-Message-State: AOJu0YyREK8K929hQRHgNlfSs45HoqLLG0+jn0sOC7koC1/QFE40Yh20
	M4IuSFTwEA/mxGaluFuNZCNThDPWe4gjolNiggXRVr6KH2CSlPWywucjzFTVe6Yr
X-Gm-Gg: AZuq6aIWul6mHjAOY4vqY5MRNBI8FoQJMtWO3UWo4wjNB0+ZIHUKaPKzDTrgBgjbfrc
	lVQjkwjZztLpkz/yHoWxJw3U52AbVmGdlf1BBkr/6C4JDqAa1NjvOpFgJx4E6ZkfUj/Y7f2hI2E
	PDHrANs0jlJDerh3R1U7GJykh3nHdbsK1OjNPKy6sig6mVES8BhE8/bolaHi1pSK/cH3lNj3fGN
	Sn6wdbbFGCTFxOX1GNFhGm/cZm/L0yvKxkHr4wWTascwgUn7mRD1aA3HqWxNNJq5p2drV0KZT85
	N11J3+YfUgK8iUMiPdkDxwak7sEWiB4UiNtZfJLZAq7dTh+y5NEat3gsdd4guYYu1AOLinRdtKv
	OyJyMJFSIf8KMqD5UB8Bv5F29fSNvD8ce11BArrX4mTm62jts8rmqZ5y4dbpMuNKHjt9KG0po1U
	kVLKRx5S9U0Zjd
X-Received: by 2002:a05:6a00:1a90:b0:81f:852b:a925 with SMTP id d2e1a72fcca58-8241c19da84mr2647345b3a.1.1770205113856;
        Wed, 04 Feb 2026 03:38:33 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:9794:3431:2323:a200:80a3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1bd466sm2263296b3a.20.2026.02.04.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:38:33 -0800 (PST)
From: dhyaan19022009-hue <dhyan19022009@gmail.com>
X-Google-Original-From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH] iwlwifi: dvm: fix NULL pointer dereference in rxon
Date: Wed,  4 Feb 2026 17:08:20 +0530
Message-ID: <20260204113820.4410-1-dhyaan19022009@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31528-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 7020AE5387
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


