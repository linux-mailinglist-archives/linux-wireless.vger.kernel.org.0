Return-Path: <linux-wireless+bounces-23487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2D0AC7970
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 09:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46D57A370D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 07:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102B256C73;
	Thu, 29 May 2025 07:09:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4CC8EB;
	Thu, 29 May 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502590; cv=none; b=k5/omI6eFqEWiOdOyXCOQfFaxKua1wezCwOHumtXIasa8dg4J4AcV/mgP1L1nlhrFTZ8LplhdvheGI5NGHRrtCWIKqwhPbCiIdyAdvIf/WScW//1R9+AEQ5QerjMvSl1nuiECGZPPFzklDbyemP1DJVR1wyEYkEtWv7Mm7OgL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502590; c=relaxed/simple;
	bh=G4YvY3SQ8tcvLemW64/aRMAXZ2jVYiNApaFxOCAEwng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O2GieaNlXNCnpQx5nop95tp+OipQJp4Z9bwmlUo9DouQDjXcSwfqSvfantPHHhhdIaQEoa7pNgrq9AAd1xZfM+Hq+DJdSlUblyXhXW5ir6cv4B7C+bzXYlYAx6DJrLDYL20mjdC2jdmsBw/cq4XZKH1a8g8JX7BxHFZF7Co6CU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.speedport.ip (p5dc5559d.dip0.t-ipconnect.de [93.197.85.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E7E8B601EBE89;
	Thu, 29 May 2025 09:09:33 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Add limit to ignore NSS change warning
Date: Thu, 29 May 2025 09:09:21 +0200
Message-ID: <20250529070922.3467-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, Linux warns as below:

    Ignoring NSS change in VHT Operating Mode Notification from cc:d4:2e:bb:59:f4 with invalid nss 4

For the ignorant reader, it’s unclear, why it’s invalid. Checking the
code, valid means it’s smaller or equal to `link_sta->op_mode_nss,` so
add that to the warning.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 net/mac80211/vht.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index c5c5d16ed6c8..9f7938ac4031 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -672,8 +672,8 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 				sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
 			}
 		} else {
-			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d",
-					    link_sta->pub->addr, nss);
+			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d > %d",
+					    link_sta->pub->addr, nss, link_sta->op_mode_nss);
 		}
 	}
 
-- 
2.49.0


