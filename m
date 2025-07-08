Return-Path: <linux-wireless+bounces-24927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D72AFC90F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A963118877FB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39E27147B;
	Tue,  8 Jul 2025 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="To0bE3kj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B82D8397
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972336; cv=none; b=mmKIx6mxGwNADbitPVU1g8l1LqxjJ0P30qwsreeY66/r/HBBTG9wp74lK/WvZ54iKBAn2BzjA/zPC3lev8Vq/PE6xkW9fWXQW3lB9J9CsTO4yrnoctPdcOMAEHnTtxoPUnRg3KQRlTsA1OrjauJZC36fvjFb0ryysZSaEYO0zDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972336; c=relaxed/simple;
	bh=1+IpfC6ITXd7qMgZs1P4pOEKRY0rE4yUOMpP/gCtGHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMuaHwQojCTeQDvIlXm33lqQjtACGye5JoJVPwl7XMEQ/mDPLKvRZgspiK5doxEan8qFuQY5TZiBCkb0gVkKJFJISpAMdObQPTtq6/GbOke51+wKkKfYnaiE+GgnfF8VJjwHPtyYsWRR+8/++bSbaYjdG2vbTwH46q+P4nl2blo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=To0bE3kj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=qF43EIlpWS++XsdyI85kU1GWmGUZ6gMBdusP7Y9MUiY=; t=1751972334; x=1753181934; 
	b=To0bE3kjnfHFwX0y/ZgwDW9Qwgsx2TzxSvK4BICkbNPBbGoFgeLIAJZlvMHWHWjKqBW9Krb+22g
	pjU6X+xcV+xAOtnNMHMnmP6b5nqUUo6oq6ztvpYvylxacIicuoGIRVqkrLcaVguh1BaqzDb5gGtRB
	FCFgE9g6A4aF51tdywLSkxpJ9tTT74aqPVQUkeggwsM+S/24EuNT9gmDzCHJZoDqUj+OHfnH9HcwM
	EvhNFAI3n3Ubxal8H1IW4CE54IVjvabT/+/kMKg73DB7q3AVuLuYfbe0DWqWt+evXD3E1AWJyPDWQ
	/S5xGp0LPdt4RCLd2IVFx4cD7MFY1PZNbIIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ62F-0000000BpWa-3PXu;
	Tue, 08 Jul 2025 12:58:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] wifi: mac80211: make VHT opmode NSS ignore a debug message
Date: Tue,  8 Jul 2025 12:58:49 +0200
Message-ID: <20250708105849.22448-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to always print it, it's only useful for
debugging specific client issues. Make it a debug message.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Link: https://lore.kernel.org/linux-wireless/20250529070922.3467-1-pmenzel@molgen.mpg.de/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/vht.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index c5c5d16ed6c8..b099d79e8fbb 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -672,8 +672,9 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 				sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
 			}
 		} else {
-			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d",
-					    link_sta->pub->addr, nss);
+			sdata_dbg(sdata,
+				  "Ignore NSS change to invalid %d in VHT opmode notif from %pM",
+				  nss, link_sta->pub->addr);
 		}
 	}
 
-- 
2.50.0


