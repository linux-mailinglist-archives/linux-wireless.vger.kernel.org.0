Return-Path: <linux-wireless+bounces-28613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8886C3625F
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF589623FAC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4B32E13B;
	Wed,  5 Nov 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="q4POW0lX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0E330B07
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353607; cv=none; b=fba2gWtVK0fuTMBArMUZplQGQOka9UiaKClwxc085wqLtL4Yw+Y8bHcpkOIvJjYCsrEY3cpHnlF0UutuDs30ZbNwyqd46x/SVsryd9vMJia8eg9bAh6yOIDqkMDwB2wxx6GgzIU1W1+jZpFe/D7xpghsJ0BpLxSFomIP2FYOMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353607; c=relaxed/simple;
	bh=Ny2yLzxI9Advxmq7vCqVruhXaVdNkPt4AhH57K7PzLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQyCdnVlu5y1zmkArHAOm+jRHgiC1zJlEbNuBFo5yBXD6+Pm5wcMAWFDM14vtUyQIjGtpZOTzA6RiW5MoWQ+HKjwH+gYItOzgsd5ZHE4XCDj2jalpp9nc5XiPRXoJaPPa7xvuyH7cjNSxdrhydv/v4y+QUZB5qf2vyb+g6+FB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=q4POW0lX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=c3JfYGcke94voZKdC3XvySlG7+P6Y0qvY/sx3SENKH0=; t=1762353605; x=1763563205; 
	b=q4POW0lXPgNlzL7N2Acxqt0kfdNYIoL6wp6CiLvoMzLy0fM8zMdfmwM+gGbIfI2YTjRrnRylxd2
	B3LkrAmc/MBVRYb9gUj6AbyZ249JzAICZ0uN8WHOV/ysq4qBzOLiAVEmfM+vwTxpuQBLU3x+C/wW3
	dijAVyL9/kNYKbGyt9Nuv6fqRTafv/7hx1+yK9Ft6ydL51WXVooD6ITRVZUCgz0W1YDUYrckh7n5n
	fshE9HyoQJ7/4LhWcd01P5XPSeCol0hlMnMV6wS5c2UhqpKoNn/t+Mq1o0rEDZUXebF6ZS9cdxouD
	+NcS10E9c7W07XYIdbygG6d42Ym01+RH86nA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGeg6-0000000FDrI-1O8E;
	Wed, 05 Nov 2025 15:40:02 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: fix EHT typo
Date: Wed,  5 Nov 2025 15:39:57 +0100
Message-ID: <20251105153958.e9d4af3b768e.I5f3378326837e3f62928a2f1fd3403f29cea069b@changeid>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is clearly EHT, not ETH, fix the typo.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 53490eb04e87..f1294bd9a618 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -685,7 +685,7 @@ ieee80211_get_he_6ghz_capa(const struct ieee80211_supported_band *sband,
 }
 
 /**
- * ieee80211_get_eht_iftype_cap - return ETH capabilities for an sband's iftype
+ * ieee80211_get_eht_iftype_cap - return EHT capabilities for an sband's iftype
  * @sband: the sband to search for the iftype on
  * @iftype: enum nl80211_iftype
  *
-- 
2.51.1


