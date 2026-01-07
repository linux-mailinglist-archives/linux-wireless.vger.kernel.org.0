Return-Path: <linux-wireless+bounces-30503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B195BCFE592
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EBD5301FC3E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03843451A7;
	Wed,  7 Jan 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vUbKC2fL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0694344053
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795854; cv=none; b=RydN9PXYSdPm/7fpASxWvEBo4oaQRekfB7PZ/7co0zI58oTZUsk/g/vV+l+jSu5ztO6oZmt4ux7rOfcuKr9+PmwR6F7cR0U9sbGdMxui9FgR+5lfOdPxmtxPX72z1Zuv4skYGDShOzxbRFuGQP/cqG4RpsLVKIpRbnwMCy765/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795854; c=relaxed/simple;
	bh=kr9LvhbPREKEFUfRQ3GefmdA3YL5MCShvr0iFXT/aO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBajHj0ur6sXa+DO6GWgJyBlb1rVaTKu6HPE/AemJBu4FodMHvPgpv205qdc6OSEPgDpCFah7FhgWXHBqUJYzDIZGByZzcTjfVotAUL5sIIkOtxFtp6uONx76XR9m2RG9AXhMdtHsWZBvWMxKPkAUFdtM7LEXAhA64PyMXyU+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vUbKC2fL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5Yq5uACBjHOTnACO3OmY9DJFgpcd0DI6SjSl5spVvH4=;
	t=1767795853; x=1769005453; b=vUbKC2fLdGfSfcXkT9WzImtb3QqQLRqJ3w/vSwB8OuLiqBP
	4BCr2+4lqau0HOZEw/Dg8CqXq6INdNqeq2vFE7s0PIw3KRuLqLjF2zY+JgzQrlQQQyuc9bsX1OqWb
	AZY7XvI67qDyAGILmKqoyqu4Nbcc6BvXsyLgTAOMHa+OsYrJ7qWWv/k2do5vGNSfaSxXJVZg0iI5i
	CNRnv8LD+vzZRrS82zWmr2RdYJoZSLQaoZM/q+82NVPRjMGQSovW4Fn/SIaK0BzorKbXbB/Wkxiho
	qSe1j4x9xE6qKJB3VHb3TCLUNm7k7DM29jUj6s7NlEHSWeLSlWSK9l+q96MPmKsw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSI-00000005agF-3A62;
	Wed, 07 Jan 2026 15:24:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 41/46] wifi: mac80211: allow add_key on NAN interfaces
Date: Wed,  7 Jan 2026 15:22:40 +0100
Message-ID: <20260107152325.e37a9e7f03d6.I5b7c646c456d4112e5ab8663026153ace9b6b7d6@changeid>
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

From: Avraham Stern <avraham.stern@intel.com>

Keys may be added to the NAN interfaces to protect
NAN management frames and data, allow that.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index def6b89b8db9..b703a604e6bb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -702,6 +702,8 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* Keys without a station are used for TX only */
 		if (sta && test_sta_flag(sta, WLAN_STA_MFP))
 			key->conf.flags |= IEEE80211_KEY_FLAG_RX_MGMT;
@@ -718,13 +720,11 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_P2P_DEVICE:
-	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_OCB:
-	case NL80211_IFTYPE_NAN_DATA:
 		/* shouldn't happen */
 		WARN_ON_ONCE(1);
 		break;
-- 
2.52.0


