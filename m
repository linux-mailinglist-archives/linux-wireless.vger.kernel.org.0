Return-Path: <linux-wireless+bounces-30508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE5ACFE55F
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 017163046752
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D286F345CDA;
	Wed,  7 Jan 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GuE8tPf+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492BE345CC9
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795860; cv=none; b=jmnIeAuNSux8n4ATBga3V/ubfhzN1wzaKHEihZd4rczljQMqjwklaXSoAB5VNs3dj+oK7Hubpbipju20YcWWY2fZvNY4YIYN6gcS8a+t1niJ4e1UP974Tcm8GK4So2lwt8HNz35SBiNs55CsX60YrmM+FXacNh5ZNkeeKut39vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795860; c=relaxed/simple;
	bh=7N6YL+HDwvwfdAlrFAP1f2TXUddeyKCMKsoVjb1gOY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDFGQodXIIDYd+R638rERf/CxbcAWI5k2yAleeSYrhfod2ByFokjULSdTslB6KkIoykq1ITiKjdtU7y8g+D8srWilb24j3Rr4jV1Jk9vVenAEB9OB0Rd/iLZMwZOQIQub57zg+fqMOGFwDlSMAaDTFg2+tlMpBu+uQMRmHnPpKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GuE8tPf+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OX968JrXJin7oNm6k76Vhf1HigGeSeWQdPgBBa7Mwr0=;
	t=1767795859; x=1769005459; b=GuE8tPf+b6fYX0EDLcox4lU4Los0LxuH2djthuFk4lk4KfN
	22rGSPAdSswgR2OFSHu5iT9RnvG92HIlvFTW7MRypQ9K1f0yZhODvhBPgWpTxRwvNw56ohlkJ2V3y
	RNeiTtA2m1dX+S6t6bjYE7vfiL5UvxGLxMWSn33haoeTdMn05BLEzTMV7s4G6yPSpmpEWeC/yIqox
	CRc+JBC+4KcvudtkNZeq+diQlUvhGBVA66mfY9aa7tx0JKlpHa8lGxVIZ9i7jtgjjA5A621CALFp+
	37CmI/oNP5RpBIeCM5osnUQEB8euAHCftU03ICTkduScWzsDgxZCO8H8lGixuiGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSP-00000005agF-0L37;
	Wed, 07 Jan 2026 15:24:17 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 46/46] wifi: mac80211_hwsim: Declare support for secure NAN
Date: Wed,  7 Jan 2026 15:22:45 +0100
Message-ID: <20260107152325.3bac530ae023.I6993cc70c43579694ffd429f1afb971a73db2ae4@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Advertise NL80211_EXT_FEATURE_SECURE_NAN to indicate support for
NAN Pairing, enabling peer authentication and secure data path
establishment.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index ced1b4fd0dd7..45de6943fe08 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -5378,6 +5378,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
 			NAN_DEV_CAPA_NDPE_SUPPORTED;
 
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_SECURE_NAN);
+
 		hrtimer_setup(&data->nan.slot_timer,
 			      mac80211_hwsim_nan_slot_timer,
 			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
-- 
2.52.0


