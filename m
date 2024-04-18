Return-Path: <linux-wireless+bounces-6513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1998A9565
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 10:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98651F218F3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D815B0FD;
	Thu, 18 Apr 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Kf/fw8kZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22E15AD91
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430358; cv=none; b=G8VyNCH6I5jubSt88+hdSbGeOa5DcGJuDNxXwlqj6FRC9C97F94r9oUhUyrUPUkZfcO9aPQgAwA+/ARuSyroqXUOdFzFMFZquhfPr/bti+3gt0+JOzs6yKq6TYmQYeMDWLWfJnJi/PRXYJ/JePGCWZlkiOptB8fY+ZI72qYUXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430358; c=relaxed/simple;
	bh=r4OOmK+HKCtlholLfoyxeLt/X195g3BwwO4SDytNI3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB16EuGTRNy1KjD1pSSAmVfU/b6vdxV8AdgcKCrKbOQmQmHrOGtShF2bt/K0H8EFyV1Kes/odqltuq4zC3VYi/7FYnD1ppwYq6Bej7YGdyYVWUYUXqn1kaCY+nVmCrrCwsF1SEKm7Ap9dHwLf3zVug00oaq159Yo4o/6ZMEd0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Kf/fw8kZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kFcmn48v4nLQKI+zj5YVOA1rasu4U5g2/A5yyErjaDw=;
	t=1713430357; x=1714639957; b=Kf/fw8kZJFzkAwMzp1p2vErioOmzifT/fopgXzkETiLTE54
	6yRn7SEcbBRyJ2B08lpUrxCCMt9yq28jnwR0KNcBEn6nC29Bs7s83iyB5sdg3Osh0SW3m39KHmp8C
	0jm0REuVdP8DPUAgH/VTW/1cYvjkkdWFxs5WvYvmAiafLsS3NGFXP/WrA4srrp0pT8ySWRZXLsHCj
	aOOAlaQ+oygNnwXsHXITo1XwQCoqWmU0XZgfLw6F5HsSEkzIIlIoW+V3tRxIftfAb32oOBIAoVAHR
	HrEUzn8Gzqti/PgZyTlBez4XUzHV/kIC629TirS3XXHED93emC0v/YJIvwSFDdTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxNVN-0000000CIvO-0Gsz;
	Thu, 18 Apr 2024 10:52:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 8/8] wifi: mac80211: fix unaligned le16 access
Date: Thu, 18 Apr 2024 10:52:26 +0200
Message-ID: <20240418105220.356788ba0045.I2b3cdb3644e205d5bb10322c345c0499171cf5d2@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
References: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The AP removal timer field need not be aligned, so the
code shouldn't access it directly, but use unaligned
loads. Use get_unaligned_le16(), which even is shorter
than the current code since it doesn't need a cast.

Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfiguration ML element")
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6f0880ec89da..3bbb216a0fc8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5819,7 +5819,7 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 		 */
 		if (control &
 		    IEEE80211_MLE_STA_RECONF_CONTROL_AP_REM_TIMER_PRESENT)
-			link_removal_timeout[link_id] = le16_to_cpu(*(__le16 *)pos);
+			link_removal_timeout[link_id] = get_unaligned_le16(pos);
 	}
 
 	removed_links &= sdata->vif.valid_links;
-- 
2.44.0


