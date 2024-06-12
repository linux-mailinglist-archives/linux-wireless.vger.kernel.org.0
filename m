Return-Path: <linux-wireless+bounces-8877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4839052A3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E653D1F23D46
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676B516F904;
	Wed, 12 Jun 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mRbM0o9I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557C16F29C
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195896; cv=none; b=OLruJahHt4O8CpfBgiuLXZmYFT+PzjaFNCHo2UKegVePY0dfdXAGQvobMP5BSl0smCNKHUfH8ECZKhxKDJhbT88924qrg2iUZ1ALNzCqnxm/oFNek7mI594e4nSA/wy7M25GF7BB+clGT6LaQGTYqkXneX6+fSJ6kT7Ela5sBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195896; c=relaxed/simple;
	bh=k7CFfyKRu5Cq53ohUFP3M+KVUJJJF7DzWumrspjwV+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHhAbAIjmyocE68hYOjr5rxMgB91VmcCsz8+vFycuOhx6LAUposPfF6A16+/ttLTzKrV2BS59GrGVufrMRdNMhTGSZJVjmm0lUjqvT+PlDEwY1RayVxLDM3h592mNo+5upZ4JMOTEB7aLq3M8b4G9+GhsYQWpt4SxOfu2CdKNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mRbM0o9I; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=tCgEKvw0cPmvBlFtaVhYIHHtQAEVyBLgpngYvIzz5yY=; t=1718195895; x=1719405495; 
	b=mRbM0o9ICR2GWv5a82RgMG+vhO3TJmbRQ85Odz1m7gaticL6Umlt/KA5sImnwScw8HHRr/3Y8Yf
	OHFX/sSKGnNjTZ3Lzyo2xZWQmK0U8mCKwOp0aNYvFrp4BYd6LQY30qYiz3N/ujnrC/eAok68NmTFz
	C5SYG0KTH7pFpfHV0tvEfa6JjDDqH3atNeJr25s7LaSdMvG9ok/3KA7YPCTmevuIYUkfrz2tnf1eB
	AniyYqBXq8jMuhGEMVonHM3Qc0Gl0bwpuM6viGHyjRORFPxHvv1snD/t3EH/DYSflo/riP1CS3Oqo
	O2TYEbbH26CKNLoFR66qrZ2pVXeDt1NRTaQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHNEy-0000000AH8F-0qts;
	Wed, 12 Jun 2024 14:38:12 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: check SSID in beacon
Date: Wed, 12 Jun 2024 14:38:10 +0200
Message-ID: <20240612143809.8b24a3d26a3d.I3e3ef31dbd2ec606be74d502a9d00dd9514c6885@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Check that the SSID in beacons is correct, if it's not hidden
and beacon protection is enabled (otherwise there's no value).
If it doesn't match, disconnect.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ef3280fafbe9..df0978ce69de 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6654,6 +6654,29 @@ ieee80211_mgd_check_cross_link_csa(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
+static bool ieee80211_mgd_ssid_mismatch(struct ieee80211_sub_if_data *sdata,
+					const struct ieee802_11_elems *elems)
+{
+	struct ieee80211_vif_cfg *cfg = &sdata->vif.cfg;
+	static u8 zero_ssid[IEEE80211_MAX_SSID_LEN];
+
+	if (!elems->ssid)
+		return false;
+
+	/* hidden SSID: zero length */
+	if (elems->ssid_len == 0)
+		return false;
+
+	if (elems->ssid_len != cfg->ssid_len)
+		return true;
+
+	/* hidden SSID: zeroed out */
+	if (memcmp(elems->ssid, zero_ssid, elems->ssid_len))
+		return false;
+
+	return memcmp(elems->ssid, cfg->ssid, cfg->ssid_len);
+}
+
 static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 				     struct ieee80211_hdr *hdr, size_t len,
 				     struct ieee80211_rx_status *rx_status)
@@ -6795,6 +6818,15 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	elems = ieee802_11_parse_elems_full(&parse_params);
 	if (!elems)
 		return;
+
+	if (rx_status->flag & RX_FLAG_DECRYPTED &&
+	    ieee80211_mgd_ssid_mismatch(sdata, elems)) {
+		sdata_info(sdata, "SSID mismatch for AP %pM, disconnect\n",
+			   sdata->vif.cfg.ap_addr);
+		__ieee80211_disconnect(sdata);
+		return;
+	}
+
 	ncrc = elems->crc;
 
 	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
-- 
2.45.2


