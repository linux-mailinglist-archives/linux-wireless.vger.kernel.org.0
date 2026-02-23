Return-Path: <linux-wireless+bounces-32114-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHRWOMRMnGnYDQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32114-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:49:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECA4176707
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B407030D9264
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33FE366545;
	Mon, 23 Feb 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K7p03O6U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2D365A1C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850455; cv=none; b=FjIUmghUnKDMj9G0zrbGS+AWI33RDnf8GGCLoXMylopBo3/oY3DDc6kFJhrUMejWtJy1FeuRPpviLTwSedTR0p2HEF57RjRblwgXQg1uJm7EpgzIRTV6u0iehBlVf1FCKVFrFKtwIbn/WhXmZaIxWhGUCCaLVdT34o4bmrrrIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850455; c=relaxed/simple;
	bh=YaZtf2zllswHx3JLm3J5iz2HsMgvjozeB5/RSr66jtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lirnp6cm5W1O08wlbzaEbmUUn3K0PCY+Xrj3jNDJ79YkqD3mBGFOjYq+N87Dwlz6xQl29SPlQOaI0Tc4ywid7EKYbsOh0oMfP/iQcN3Y79qGoJ2edcjgNFE48lDULiAJHJPsS5AifK2vknhU3xMi7MCs2F7/yG5ETC225TnB690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K7p03O6U; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=B/FCtQJqLGakX0AAYKaj2JwN1Ou1pzOlq1l+LfNFWOM=;
	t=1771850454; x=1773060054; b=K7p03O6U7I+q313TJxzIRunWS6V9s2cs+sg3rfQLuEkzLAp
	+63+pu5+9zQkTci8jb/W32kaRbCJLwr6T5pd/qBZWgRY9Px2Ma2RGSHMGrVsdLjCdL7bJdGkBIQHu
	3dm5PWg+0BJcpUBbjVTgKZWeamnTEpUPwRFvJGH8W+kAQ49R7wjyjeZIjgKgovdCU6A1unDhhqO9p
	LEm08qvM6bKTKhBYpWDNz6uEGxmuj9ZvfDq4jE5y/aXDeKLMbNAAWOYScByo8yntyRQQkFGXgCeyy
	vgwOsgENj497PB/LL+Ji/H8dQdHqqG93YfZkuMqQkapL0i36cLL+WXZPoJyVRPtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vuVF5-0000000H2xI-1sm4;
	Mon, 23 Feb 2026 13:40:51 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH v2 8/8] wifi: mac80211: pass error station if non-STA transmit was requested
Date: Mon, 23 Feb 2026 13:38:27 +0100
Message-ID: <20260223133818.00346f27a7d3.I5ffe7bc0d4ccefca5c1e506d5d3d482e13989cda@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223123818.384184-10-benjamin@sipsolutions.net>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32114-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 6ECA4176707
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

When cfg80211 requested a transmit without a station, pass an error
station to ieee80211_tx_skb_tid instead of the correct one.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 net/mac80211/offchannel.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 0a8b4c5e8c12..24a55186b87f 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -857,8 +857,10 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 			need_offchan = true;
 
 		rcu_read_lock();
-		sta = sta_info_get_bss(sdata, mgmt->da);
-		mlo_sta = sta && sta->sta.mlo;
+		if (!params->no_sta) {
+			sta = sta_info_get_bss(sdata, mgmt->da);
+			mlo_sta = sta && sta->sta.mlo;
+		}
 
 		if (!ieee80211_is_action(mgmt->frame_control) ||
 		    mgmt->u.action.category == WLAN_CATEGORY_PUBLIC ||
@@ -887,7 +889,8 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		     local->ops->remain_on_channel &&
 		     memcmp(sdata->vif.cfg.ap_addr, mgmt->bssid, ETH_ALEN))) {
 			need_offchan = true;
-		} else if (sdata->u.mgd.associated &&
+		} else if (!params->no_sta &&
+			   sdata->u.mgd.associated &&
 			   ether_addr_equal(sdata->vif.cfg.ap_addr, mgmt->da)) {
 			sta = sta_info_get_bss(sdata, mgmt->da);
 			mlo_sta = sta && sta->sta.mlo;
@@ -1026,7 +1029,9 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	}
 
 	if (!need_offchan) {
-		ieee80211_tx_skb_tid(sdata, skb, NULL, 7, link_id);
+		ieee80211_tx_skb_tid(sdata, skb,
+				     sta ? sta : ERR_PTR(-ENOENT),
+				     7, link_id);
 		ret = 0;
 		goto out_unlock;
 	}
-- 
2.53.0


