Return-Path: <linux-wireless+bounces-33882-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDl8N/FQxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33882-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41632C557
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DED02305C306
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0973815C5;
	Wed, 25 Mar 2026 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROv9MCMO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2237D10A
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473366; cv=none; b=IblsvrQxF5oNaG6vUehVwUG8BSCbrKG6j+HvVpoez6g9t12QW54WX+/+ZXRPLoBmP/0JgEHe4xZEfzAr5aKv/R6GEnpVURvLsN1c5O0Y5q0vrA1qLhz3cKBKakgoSfl5lDGvP/TNLUI+VKQJ0ObE5wMtxW4vEVZicXg38TVCTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473366; c=relaxed/simple;
	bh=s5t5hSNEVXaYt5tUwljP56A4IdOV05tF7Yb9eQcRn5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pjs6oih/blR4QNxXUHfgZiPazOWehBYI87JK+EtKTdYd/RR81FO6rk653kym5+HD+popEey5vgeYTmuV0gHDuSbjXS0QJvjeXV2iLQIfRjrt13ukCwil9TSb3vW50vY4VERnNhJtgx05mug9nnXAp4oKsqOFiuRoWP2lZAQyz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROv9MCMO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473366; x=1806009366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s5t5hSNEVXaYt5tUwljP56A4IdOV05tF7Yb9eQcRn5w=;
  b=ROv9MCMOYft+5W+U1zb1W3QBqQLRDY3efqtTirgZtwkM8tOF58kzyj4z
   60Bm6E2aJ4GN4j60WaJCH/pLfhvXw5ldGVDCjpX1MZ5SeyrxvKhAsfRlL
   Cocqt+5pH9cJf/f9/BNuYgu1KKFayJ9F+uOiL1eyI5LSTBwiagw16y9oj
   Zkxwz+Yfhlt7nUPiCFZvCrvHm/kvuJZ5eEqmWUUrI3xSreMTzdycEVjBW
   JZebyMisXBNQDLssQy0habuqOjIhUz0pupfd5jZAtEbd6YYphEgJeQTnX
   GN8bM7SpX324erVVZrgJIsHtDAS+mu2nvo9kzBOm7FgKQacOEUByErWOT
   w==;
X-CSE-ConnectionGUID: TimiU3SYQnCw62PZOg2mtA==
X-CSE-MsgGUID: 2GMXIkNeR4u6s+yGteSSaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485380"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485380"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:06 -0700
X-CSE-ConnectionGUID: 4EUkcDBPThe/C8+oILO3hg==
X-CSE-MsgGUID: /ptptnd2SeqR5HUG1JNVIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747535"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 11/15] wifi: mac80211: add support for TX over NAN_DATA interfaces
Date: Wed, 25 Mar 2026 23:15:32 +0200
Message-Id: <20260325230443.352775179763.I04b27d9727f7a553fa80520cf6e532683ac03690@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
References: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33882-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: AA41632C557
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for TXing frames over NAN_DATA interfaces:
- find the NDI station
- populoate the addresses fields
- use NUM_NL80211_BANDS for the band, similar to NAN interfaces.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 730c208c3bdf..b0eacab6763d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2541,6 +2541,13 @@ int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 		if (!sta)
 			return -ENOLINK;
 		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		if (is_multicast_ether_addr(skb->data)) {
+			*sta_out = ERR_PTR(-ENOENT);
+			return 0;
+		}
+		sta = sta_info_get(sdata, skb->data);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2834,18 +2841,37 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		memcpy(hdr.addr3, sdata->u.ibss.bssid, ETH_ALEN);
 		hdrlen = 24;
 		break;
+	case NL80211_IFTYPE_NAN_DATA: {
+		struct ieee80211_sub_if_data *nmi;
+
+		/* DA SA Cluster ID */
+		memcpy(hdr.addr1, skb->data, ETH_ALEN);
+		memcpy(hdr.addr2, skb->data + ETH_ALEN, ETH_ALEN);
+		nmi = rcu_dereference(sdata->u.nan_data.nmi);
+		if (!nmi) {
+			ret = -ENOTCONN;
+			goto free;
+		}
+		memcpy(hdr.addr3, nmi->wdev.u.nan.cluster_id, ETH_ALEN);
+		hdrlen = 24;
+		break;
+	}
 	default:
 		ret = -EINVAL;
 		goto free;
 	}
 
 	if (!chanctx_conf) {
-		if (!ieee80211_vif_is_mld(&sdata->vif)) {
+		if (sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
+			 /* NAN operates on multiple bands */
+			band = NUM_NL80211_BANDS;
+		} else if (!ieee80211_vif_is_mld(&sdata->vif)) {
 			ret = -ENOTCONN;
 			goto free;
+		} else {
+			/* MLD transmissions must not rely on the band */
+			band = 0;
 		}
-		/* MLD transmissions must not rely on the band */
-		band = 0;
 	} else {
 		band = chanctx_conf->def.chan->band;
 	}
-- 
2.34.1


