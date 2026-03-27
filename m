Return-Path: <linux-wireless+bounces-34044-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMnaAzdQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34044-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:39:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E885D341D9F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 990253086699
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7123D349F;
	Fri, 27 Mar 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="seGVuxzt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5D3DCDA4
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604234; cv=none; b=eYkSTk9QMLSj59SaqUr57NoCNWswNTOa47a2ROWYoFoLsJt8L785U2vZasKrZfEa2hHBEK7K/Zw/9UyJpF6d5NC0m9ZXJYbCEDB257ovbiZvoICwioiSHaUMmrw51Bh+3GNE5e+m7FYg6rtPxqI2B/rBTgNiu/JSdnp2tRcw0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604234; c=relaxed/simple;
	bh=YV7VW7BRF9jky04S9x1EEczfhpwL+fMKZCiFvRcq/Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7SKHfI1VL5KfiakXRFxlW2NWsqs45cPn12H7zUTjq+GDvAqQZ6LmIsfBF7fE432chq7JI3KRI9OSHVh3tPQg7vM6Wrhkg4iSD4UGE9IbbrndGKsChCjAURuZtknXc3hKlAvqguUXJ1iSu8Dk6TVKFIwVuReA1s5VtAX7gIcgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=seGVuxzt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/8xCcKgIZXRife0H15BPNVyoqUUTOHc3lS1+mIrBA6E=;
	t=1774604233; x=1775813833; b=seGVuxzt7OoIWyiL3OCsTv8I32DuhajlXnSCTa7qcogL0RX
	UDotxFKaC/w28v/d6StXcQJnforXkBsXNdhYSg36Ldl2sAK+dVqo3itZyFpcAKKwch0nXi3sP4Xs2
	SrzC6swjNXDJ5LSJE3/t/FKhOn7TnBj1ycoxeI7WX7c4Ppig95aF6+RDiFQ7oEH3DwcIaEtWI9Dis
	qcSmbl6rKRSr/ro+uJ85NbAgbpvHPJHoaKXOgmTwiPr72YukCkCBWlel6ypcZrnB9XrfyzQ0PGGRs
	NUTwHd8J94q3T3jexpFVd2jaPN8KnPNiFxyem/vxd06wakIQ8HT32pffQCvt8VSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cn-0000000E83L-2E8e;
	Fri, 27 Mar 2026 10:37:05 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 06/19] wifi: nl80211: document channel opmode change channel width
Date: Fri, 27 Mar 2026 10:31:32 +0100
Message-ID: <20260327103659.8adf6dae2d31.Ia9a0769d52dcfe56f7b0dff903ed14db3ef04920@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327093659.711584-21-johannes@sipsolutions.net>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34044-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E885D341D9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

The opmode change notification is entirely unused by existing
userspace except for printing out the values. As such, there's
no need to keep it perfectly accurate, and the implementation
in mac80211 doesn't report it correctly today. Add a note in
the documentation that it may not differentiate 80+80 and 160.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/uapi/linux/nl80211.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3d55bf4be36f..072b383d7d3c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1204,10 +1204,12 @@
  *	user space through the connect result as the user space would have
  *	initiated the connection through the connect request.
  *
- * @NL80211_CMD_STA_OPMODE_CHANGED: An event that notify station's
- *	ht opmode or vht opmode changes using any of %NL80211_ATTR_SMPS_MODE,
- *	%NL80211_ATTR_CHANNEL_WIDTH,%NL80211_ATTR_NSS attributes with its
- *	address(specified in %NL80211_ATTR_MAC).
+ * @NL80211_CMD_STA_OPMODE_CHANGED: An event that notifies that a station's
+ *	HT opmode or VHT opmode changed using any of %NL80211_ATTR_SMPS_MODE,
+ *	%NL80211_ATTR_CHANNEL_WIDTH, %NL80211_ATTR_NSS attributes with its
+ *	address (specified in %NL80211_ATTR_MAC).
+ *	Note that 80+80 and 160 MHz might not be differentiated, i.e. may
+ *	report %NL80211_CHAN_WIDTH_160 instead of %NL80211_CHAN_WIDTH_80P80.
  *
  * @NL80211_CMD_GET_FTM_RESPONDER_STATS: Retrieve FTM responder statistics, in
  *	the %NL80211_ATTR_FTM_RESPONDER_STATS attribute.
-- 
2.53.0


