Return-Path: <linux-wireless+bounces-28614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18919C361C6
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05AE1A22E09
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62226330B29;
	Wed,  5 Nov 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iqH5RSl2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD29330B0E
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353607; cv=none; b=Adw3Gi+l6gTzIJsraufFuha0TJ+ZTFFHRL4ot8vt6AlFT/ej/36rC+Fxkw09FhMhyBIM+mledqtCadCn0rZBrHqECx8Rom9QsKQpQ7KiGxdu/T8WWRrM/nWL+uoHSxBkdvvwtW+wJEloN4LCWJ7d7ipxzYTz8Lqv6WA6SaB6PGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353607; c=relaxed/simple;
	bh=ikaNAfSwSaBhKdYt7bC6Y13hhk8Rxf+w/Ol3wWlKoQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5XiQmXfZfP2ub/jvSILa/rQ2C/xZfLHySp6faN5T8fZpiKiI/Av+Hgcx/jmBPWSszJ2Sb4JQKXQVabSoDwsqehakjeZShE4WvcQBOnAtmLXgHdNEKX+TkjfuLhoer6tt+GLAii8dlQ0MfOwVhUfxr/RKjkIvwnQaPcaAGxJNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iqH5RSl2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qzRBAVbtVFv+OzjglWbRXX8UqYkA+u7NzUDXa+BJx+8=;
	t=1762353605; x=1763563205; b=iqH5RSl2AtH7dlc+/CgUr+i2HpI5dHZiiQvHsCy56cQGykq
	eLD2NZQ7BcxSXnbpDT5dlrUk0Us+qQdDXCvLN+JiQTRmszw8T94ZOKgoZFDPadDytNU9pVmg89eDv
	jEFTlBR6aePsFQzu7mjXGdUlyO3JoNVQcJSRS0kGcXQQjlMb/i+OCPGS8K+JM5ScaNSNqEi1MzWew
	NxftDuf6i0i+maP5fdtoxaxS0TTIM/MXjZAZMdAAQ3CSyQ734h0mH7+QOBsYS+WI6I9pB2c3Yd/Wp
	zxA+puzxC/jpSo8vu7Tx3vW6SD0q+duAL1LzgEZFcaV2oCxMjgBYfSrrmgPXOesA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGeg7-0000000FDrI-1ZmC;
	Wed, 05 Nov 2025 15:40:03 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/2] wifi: mac80211: fix EHT typo
Date: Wed,  5 Nov 2025 15:39:58 +0100
Message-ID: <20251105153958.12a04517f7ec.Idcf800817fa30605b1002c3d2287cad016e7aea7@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105153958.e9d4af3b768e.I5f3378326837e3f62928a2f1fd3403f29cea069b@changeid>
References: <20251105153958.e9d4af3b768e.I5f3378326837e3f62928a2f1fd3403f29cea069b@changeid>
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
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c326243e1f01..c2e49542626c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7223,7 +7223,7 @@ ieee80211_get_he_6ghz_capa_vif(const struct ieee80211_supported_band *sband,
 }
 
 /**
- * ieee80211_get_eht_iftype_cap_vif - return ETH capabilities for sband/vif
+ * ieee80211_get_eht_iftype_cap_vif - return EHT capabilities for sband/vif
  * @sband: the sband to search for the iftype on
  * @vif: the vif to get the iftype from
  *
-- 
2.51.1


