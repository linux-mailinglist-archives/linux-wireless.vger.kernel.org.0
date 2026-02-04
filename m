Return-Path: <linux-wireless+bounces-31532-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHmiJe84g2ngjwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31532-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:17:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB4E5B2F
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F62C300CE49
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409C3ED12F;
	Wed,  4 Feb 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzGYEtF0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF922359FB8
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207232; cv=none; b=LdZZOpVwIYtGavRsNpN6oGGTy9ssBumtq8PrcWGGXajYXC00sBo6CpWdYWQOA3OcRGjEQOFE1qxa7ZLadSQ0Q1sxzNhWPMd6flWuxf/jYn2HymTdhbVEdLcAA0cdXtcFijSgxvEGR4tNQ8/Q0pr+T5P4Xr2u0fX+TNWfemcdVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207232; c=relaxed/simple;
	bh=YDuYGR2s59gnV5oSP7EuOJHlwtdXFUDsVxrC4IWoavU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ho3nJr4YGE2zPzixcmgTpe5wbKXkXXmwWJoL3LF7iD+T/2lfDnUoCKlftUL7vYadmKAotuQZsmydOUNZ/l8/cV1SC8Si6F9okg3bjut6mRPuLeT92bvh6R4webiKKZ1GmMYg58B98qfy8zB4oi3bsAYgw5qFxjuqnLWlFbYpXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzGYEtF0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso48227865ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 04:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770207232; x=1770812032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TAPs/7IxdFq5Egj9dE9+KO4oxhGs17u5lohpCSnTk0=;
        b=OzGYEtF0LiWFrvB2SAsSPHShNDHqgK6XhwQMO8PjZaal0sXbR3kbpjZELgFjX4q4oQ
         CPzwHN6lwuwtfiGJcKa4EPecY1t7zaUBF5fy9ArjEavgMtKKpIRoZANPX7+Sj420n1Qx
         VnwS/ut3Kjjrw4/FN0ACDZpwX6vr/mvdImbMKYfZS2ESp2mYrlfRyv3VfUKam3X04Wru
         82EzdDCr9K1oQ6NK0Y8pnXg1yvsctRDI8UrB0fkST9mYjuuSpXWOqXTxPUGnzPUiU2mA
         k3uynKSiRufIK/jkF0C6Vh9BVpVQuH8OEUKNm05/A3uoEbZfxc48+mJ4dUHj3hwArm23
         dxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207232; x=1770812032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TAPs/7IxdFq5Egj9dE9+KO4oxhGs17u5lohpCSnTk0=;
        b=L45XBhoKTVr3DzowCmmXxUMc1FtHpa+gGmgiPGb3z+F0YP2W6/qcCEz8A/6MS76t+f
         OiwuiN9pS1Xz0kVnH9d9SWKFSSgBb13S5zlS6HMcCu+/SY0ktXGANsowL/d/Xz1NDY74
         +GCZynjAaQjgFYUULKCdinbjp3blebkYhRuI8gAgVDfibx+RcFRtiE2KNzrFnsRrGYYq
         YB+t3lXOLrYXJhd5XqOEw5Cf9m0w1DYsBHgc4v1br/KY2jDZSuNWBV5o2YwJ3AUNcNp4
         VtVRmJRUe5hz6e5saspGvGq2UFLWcHnFNXJw0XBkWcVTSlISFwD21B2o6jSz4XchdINW
         QRWg==
X-Gm-Message-State: AOJu0Yy/Fgh/yFHq/VWdvPqBQYJMknAr5+Vj7ZMkLDoHWQwkpMrhMfFY
	AlBxItlhSiWy0+nPZT7nlBncWFjmgU+Fay4sw9fVTRpEKjkF6nqyR6WEqLgaaUWx
X-Gm-Gg: AZuq6aLl+WKE42KtF75f5Wam6FYPBXum1jzeTMKF8oMaSyb4Z9A8hjgUlj0g+FTnFHC
	vOKqJy8wNwEV+URZOGEr7s6HYesOC68IyG0uq0UeoL0wgo1NvXV8+ud47WMoQRn0he5gqf7R+Ye
	HuZFtXmzn9N+WqcbMVByTzpK2OITH1ZieF70ee/qrD8gnU14lxObc4aPRYEZVFrM+5uluqpGSy+
	AwDJnLqyhnuwoUbzBoKranGDVUJz627A6G2l8JYERXRi5xm7a3SOObTnUPWVpM18xDM1aedVJnA
	DlV3DdnCIzKSScKtdQVe7sTeL9Skjv/AfHYC2jnQCvgthTa4EPhrRSBiY3REmcwqLZ3LxphLGwh
	5eUdspPcEPmKKNAdKkj9cRFvIPNits6UUi2Xvha3SufvYoIYpwWHXouun+yJBazdY1MvsxDnF+H
	wn1eYB7DwHxg==
X-Received: by 2002:a17:903:32c4:b0:2a9:4c2:e55 with SMTP id d9443c01a7336-2a933fdab70mr28185025ad.61.1770207232033;
        Wed, 04 Feb 2026 04:13:52 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:9794:b4e2:d5:4aa9:9038])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e37csm21299155ad.62.2026.02.04.04.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:13:51 -0800 (PST)
From: dhyaan19022009-hue <dhyan19022009@gmail.com>
X-Google-Original-From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
To: kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH] git commit --amend ```
Date: Wed,  4 Feb 2026 17:43:34 +0530
Message-ID: <20260204121337.4819-1-dhyaan19022009@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31532-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BFB4E5B2F
X-Rspamd-Action: no action

When the editor opens, replace EVERYTHING with this:
```
iwlwifi: dvm: fix NULL pointer dereference in rxon

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


