Return-Path: <linux-wireless+bounces-4161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0B86AA95
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3497A1F225F1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFA73611F;
	Wed, 28 Feb 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aRbJdXhY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DF2D05C
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110649; cv=none; b=SN8qrHsygc1MfT40s8QXUFzHz/DIooosSnrkDnIoPr6jlNgMx/J+SF6R97+rBfaFbciXKCG3FfjIN9E1AJt+CFJmmCV30MoBEXKuDDGHRscnv8yma8v7pJSsXRp/8Z4t8NO2rdkQ/80CvsEL31sd5gQaDGdArYw99FxELKsZZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110649; c=relaxed/simple;
	bh=8RHkckFWdGbhyBvfkts8ED9rWyIzWT1Ig+VRNx+6wGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cY5UsEa/kGX7HH0rbCEUikK8dZr09rAPyLozfLtbhXsidlKOh5UITYQZCoUxrBCQp21klhZ1b+Cw1OUbDp+/ueM1hXa/ydLRgIHLfOyMucH3F4T99m9F81Nb1qmOFH2fWtJRrnsg/QAhCoqmP+q0iZeAanF2Yp6aYHrsE5Chxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aRbJdXhY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kQJYXoTBlV6CzEBIc1Psrki3Ou/72l6qW2/BPqtWqqI=;
	t=1709110647; x=1710320247; b=aRbJdXhYm87HLwTHeBCjBQWFrOuaxjZnXy87i/QIRQp9NGr
	oN3wRvsHFLtKj/ujM1iKhlkVuYETka4hR4yxaXa0yoK65tL1svzptW/L3MnIq1aVXerMdYAxOe3I/
	3yTaopC5tXcnLzELN78VVPl9xkkeSDfZe72u8FZAgcNSFMQ7yv/NQLPIZk6C6Vd6+gXynMRMUiJWS
	kG/oRxfhwzN6p5n0dPUxFrBGyad7PYkSNgYFUq8OAU1oCrDNk61g/BZlcVHgsdHzajibal4XuulqV
	dS9FO5byQrXraJ0g9iM8ikx7NfGZVsGpMQW6Ry+4C+qV/xR0hvguz26qmSgtko6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFkj-0000000C0hJ-0iwh;
	Wed, 28 Feb 2024 09:57:25 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 6/8] wifi: mac80211: mlme: unify CSA handling
Date: Wed, 28 Feb 2024 09:55:46 +0100
Message-ID: <20240228095719.e269c0e02905.I9dc68ff1e84d51349822bc7d3b33b578fcf8e360@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228085718.21171-10-johannes@sipsolutions.net>
References: <20240228085718.21171-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Unify all the CSA handling, including handling of a beacon
after the CSA, into ieee80211_sta_process_chanswitch().

The CRC of the beacon will change due to changes in the
CSA/ECSA elements, so there's really no need to have the
'beacon after CSA' handling before the CRC processing or
to change the beacon_crc_valid value here.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ce61e84d8130..563b001496ce 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1934,11 +1934,6 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 
 	link->conf->csa_active = false;
 	link->u.mgd.csa_waiting_bcn = false;
-	/*
-	 * If the CSA IE is still present on the beacon after the switch,
-	 * we need to consider it as a new CSA (possibly to self).
-	 */
-	link->u.mgd.beacon_crc_valid = false;
 
 	ret = drv_post_channel_switch(link);
 	if (ret) {
@@ -2053,18 +2048,32 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	if (res < 0)
 		goto drop_connection;
 
-	if (beacon && link->conf->csa_active &&
-	    !link->u.mgd.csa_waiting_bcn) {
-		if (res)
+	if (link->conf->csa_active) {
+		/* already processing - disregard action frames */
+		if (!beacon)
+			return;
+
+		if (link->u.mgd.csa_waiting_bcn) {
+			ieee80211_chswitch_post_beacon(link);
+			/*
+			 * If the CSA IE is still present in the beacon after
+			 * the switch, we need to consider it as a new CSA
+			 * (possibly to self) - this happens by not returning
+			 * here so we'll get to the check below.
+			 */
+		} else if (res) {
 			ieee80211_sta_abort_chanswitch(link);
-		else
+			return;
+		} else {
 			drv_channel_switch_rx_beacon(sdata, &ch_switch);
-		return;
-	} else if (link->conf->csa_active || res) {
-		/* disregard subsequent announcements if already processing */
-		return;
+			return;
+		}
 	}
 
+	/* nothing to do at all - no active CSA nor a new one */
+	if (res)
+		return;
+
 	if (link->conf->chanreq.oper.chan->band !=
 	    csa_ie.chanreq.oper.chan->band) {
 		sdata_info(sdata,
@@ -6293,9 +6302,6 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		}
 	}
 
-	if (link->u.mgd.csa_waiting_bcn)
-		ieee80211_chswitch_post_beacon(link);
-
 	/*
 	 * Update beacon timing and dtim count on every beacon appearance. This
 	 * will allow the driver to use the most updated values. Do it before
-- 
2.43.2


