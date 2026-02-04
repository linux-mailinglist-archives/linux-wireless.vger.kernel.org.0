Return-Path: <linux-wireless+bounces-31538-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH6wAXFCg2kPkQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31538-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:58:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C377E6145
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E16C3037E5A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CAC3E9F61;
	Wed,  4 Feb 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABWejs8C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2039B48F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209641; cv=none; b=GfzqNrtub1SHk2rbWU/2T/ETkynyVnhAPen6rKgMJWUIZZvkVrPlxwsuiWfw8Os+BHlFHW63W15ysUGfw62kXNGL8M4Wde4eK9RFNWjlRgSQpUREDUanU/XRF2HgUugWb/WB24msfDDRIvGa6iljOHIxhAqs7DNAA8VQWZ6s++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209641; c=relaxed/simple;
	bh=xaajovc2ihacIZOWRlCZJlzkPnu56+PuxisN3FInz6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmS3ZHQL/zjO14R2trMHe9pMf+ZqDPhrlhyA4rpZYyWpmJnl2NwmuzI7DoGIuGhknTvgOJ1iQZgemJl4ltFIS3MHqIej95e/Fx36H047NnkiWIeTYLXAJphnQHncAeBq9WDG8VW0/QwuAacUsJlbGzAAgIqZEBT2LuddhuJ4HvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABWejs8C; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f39438187so4087723b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 04:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770209641; x=1770814441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7idRUtEf2mefu6jQtuOmE2mb9Kk3OZxsSWeJ5wnujU=;
        b=ABWejs8C7vY89EQYKGsHZFEyoHFyPeqahouj9SLCLmPOO2C962Kq6eu7r12A9ET8M/
         eSb4d3YL9AWmgWwZCBkwHQNpRICl6azlDJrDiOcRDoIN4hN2w/AhcLDd91Dir2An4t3S
         sKMCaegVPnUGRg10kyPirSMBTpdq1Fhev0PS4TlgPKQ9XQ64N3Mvok2z+NTavrjrpNVo
         YyEncohWD+ZbV+m1RPoqYbEPwpbt/FOY0D6w7KZ9EqJ3yddlyzTCi4A/v2pDys1Sy8OW
         Xqnwla1EWJCahOPQIv/0mqZKi859vgvkg6I5ON9kYz4izv7jnsPXlpk1YhWfJgBtzgrs
         XlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770209641; x=1770814441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7idRUtEf2mefu6jQtuOmE2mb9Kk3OZxsSWeJ5wnujU=;
        b=k1U95DvvyA1+3i81MD2MlqRmDy74MSPZZR5ljKv2USlkYXDgIu/2e5nwBPSQ2Y4GiI
         WRGIH/sXkSKAuK4CQLAHQZOKfKia46LpxSKoDaIEpM2JuDnkA5ytK2ZQjFG5iXXDdCNt
         T55oTMmQUEsOcvGLcywx+Nlokvz0hC5/FeTuCQMwItJCATTEZ1wtBGA4DOcSNtXtr3Rk
         +k44aK18O6R/c2I5KB/tHRNzzZm9TaFSxZm+CQjubYKuqEEHlUZQg6+GiEAXAstfAuZI
         UufZYFb4Wo4p6gb4q//jDLcg+Naw9t5zXxCTcSdSxDlfcbMArAbnVpIj0lileenLraYm
         WbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+J5vHfqUbHSWd/5brw+aPlDLSrPTgrVtU19slW2LpmtKjmgnth0g+KxW+jXXoRv5iVYfMf57Gu/nkEj4Tvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyijwmTlrg+PYvC9E+SEpsj7lVlMI7RI1k4FvA4+Lb6b/98vdO0
	R9nNAaUir2Guy4RNxIf3mbb7HrpW4zb5LOYeKW8Y9ZxTCJMVMaeosIw4
X-Gm-Gg: AZuq6aISXUcKb6S/tUJi2uaWPcND3l4AWIQ+GA9I5G0XgySqcwb5ao99vJ4SQaVQPxR
	HX5+E5elAstT2Br0tY0Yt22PEOu6MfUlc/JGSNrru6gXWV4ATlcdQ/d4gtsZgV1yq8D/HSQ5I6V
	8HvhI+XbGNTdFOlHr11Fcy/s7JpLPWqIGDLvT9x4rwKZNm7ltsl8qRdKitDWj/o5fB2aQmXPZPe
	AF6nU0isymuq/KrqzqYWK6P65E2yNH7BFM/qz3RIuMud9pe74TyqwmuTIm61wlyv2FXFRnhfCwM
	3dNLz4L3NliUnR8gHHe/BVcpqOGo5gqAFSW3XHjCJ+2sWdVJz4sGXvpxJK8Z1/FkyVdg1QjD6pT
	X0KFgqO/2EgcdjFJgd6YeI150xcPCSMWdqWK6G6mImvz1Vo7bWqpoVDe3dPHcDyyxuEWHzDG/xH
	Y1R+AI5vW0nDTBSf+6h4m1
X-Received: by 2002:a05:6a20:2447:b0:392:e5eb:f0b with SMTP id adf61e73a8af0-3937248b80fmr3080275637.64.1770209640755;
        Wed, 04 Feb 2026 04:54:00 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:9794:b4e2:d5:4aa9:9038])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933978141sm23572205ad.84.2026.02.04.04.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:54:00 -0800 (PST)
From: dhyaan19022009-hue <dhyan19022009@gmail.com>
X-Google-Original-From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
To: johannes@sipsolutions.net
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>,
	Dhyan K Prajapati <dhyan19022009@gmail.com>
Subject: [PATCH] iwlwifi: dvm: fix NULL pointer dereference in rxon
Date: Wed,  4 Feb 2026 18:23:45 +0530
Message-ID: <20260204125345.6072-1-dhyaan19022009@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-31538-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C377E6145
X-Rspamd-Action: no action

When bringing up the wireless interface via virtual monitor mode,
iwlagn_bss_info_changed() can be called with a vif that has no
associated rxon context. This occurs during the
ieee80211_add_virtual_monitor() -> ieee80211_do_open() sequence.

The function iwl_rxon_ctx_from_vif() returns NULL for virtual monitor
interfaces, causing a NULL pointer dereference when the code attempts
to access ctx fields at offset +0x10.

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

Add an early NULL check for ctx before accessing its members.

Hardware: Dell Latitude E6430
WiFi: Intel Centrino Advanced-N 6205 [8086:0085]
Kernel: 6.18.7-061807-generic

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dhyan K Prajapati <dhyan19022009@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index e08e44cae..91dcf18b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -1392,6 +1392,11 @@ void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_lock(&priv->mutex);
 
+
+        if (!ctx) {
+		mutex_unlock(&priv->mutex);
+		return;
+	}
 	if (changes & BSS_CHANGED_IDLE && vif->cfg.idle) {
 		/*
 		 * If we go idle, then clearly no "passive-no-rx"
-- 
2.43.0


