Return-Path: <linux-wireless+bounces-30496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1573BCFE5CB
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A2F5308A424
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F332344033;
	Wed,  7 Jan 2026 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cnRggrKX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C4344025
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795848; cv=none; b=Mfm75zYVF0j2WBRHkz5ihWqwsIjwpgbqJF9+FZH58aowUgNfrbwRfdpHRfVQTmfhwsQhJqoga9r6Ly0SSQR+nknJ7sALN3h3dW+th7wt9qNhfttBVuD9r1+wMI6L0/JmZUESoLptGTVM9fGzwwln96k26Gq/suQALbogVyDrND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795848; c=relaxed/simple;
	bh=acCj7N7VriyV64hJgoGzDS2f0ppNkmMfROLZheD64EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlNonSAJNr5iXnHdO9NKukTT/GXaHTKiN7Sas7/FT4WBrhOoKR9T56a0JcYCGXQotxMrYOd/4TaqncwC05USa9m6yXZ2L4Tu3NYJGZYBs5Q+H8dZa1UG42jxjH7oztifE1tdt/t1y03yZwEjVpTEFT80jNDw9Y7rSCLQ0257K7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cnRggrKX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oqRDxtUBm9bzobnJE83CdAfW4hzvBK6RNR8k6DP68Kg=;
	t=1767795847; x=1769005447; b=cnRggrKXbXOcHJUZEO/yhIvTR/+gLJo8cV0djKyLDncUEdW
	w998+XHo3iCzqsNCA6aC3rCq3+jJub2UFV0h28Yq+MyGFFyqfhLZd1pxqT20jrPspC8/FldwnuU94
	h5+RmA2UCZdeh2FRUSN+nqVr1QYzQnji5CD7GN4SJzW6SZfD92fsuwlzCZEC2ly1sYiTK3C7Ljwe/
	5Kw5+skCuHBq1c4+MfWJpQo1SRo/HiP6eg+aFwUJfBp7WYvuLYDK+O/vAy7m1NNjQzmBgz/jyfijj
	BRAUkgcx+RLTr9rLG4mtwirFVwcSPI2jTCjkkuGHet2u0AXvW3cxv23RYCKbs+Ow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSD-00000005agF-0EY5;
	Wed, 07 Jan 2026 15:24:05 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 34/46] wifi: mac80211: add support for TX over NAN_DATA interfaces
Date: Wed,  7 Jan 2026 15:22:33 +0100
Message-ID: <20260107152325.717de87c776c.I04b27d9727f7a553fa80520cf6e532683ac03690@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

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
index 3382c8f12a5e..8a1778e11595 100644
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
2.52.0


