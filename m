Return-Path: <linux-wireless+bounces-33298-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAe+Jh/rt2mzWwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33298-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 12:35:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F6298C3E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 12:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F49F30063BA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C928C869;
	Mon, 16 Mar 2026 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vK3ZbW6s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DC29AAFD
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660656; cv=none; b=MeLIDFIM2PCm26spIZS+ntTVMQb1HWmaiEZxF6q9CiwGu1syA306gDxAmRDWgRUfph+5/XUaaqjtlN/tG7eOIc6ixpGNz9oADOGpjmahOoX7pDOHF6+8vx3LQdMDw5qJ4LhYW/64dCM0D6di/oS4mWXUlcDna0ZqPE+WBk0uJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660656; c=relaxed/simple;
	bh=rvgJj2gzzgMNs+Yh1ztMNasfXbRMpB9K2USA6V9tIgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzrF/p6xPMKti5qR2P8o7QtInSG4h3gLAXUze+ulG+OwvQEEFSM2wArd5MAxhzRW8d8zFOG+WQR8oPcwnfbtbkaJci5ovI2Bb4JDIX+Yre6mdY8VeWSrgB25gaLHLGso0xPmwGQrbrzWCxWgCwI/YsaUo1beci006QMS5BO407E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vK3ZbW6s; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=in3s5crRB9X7DdZLaZsJhaumB7p7VhdXjvbdMqZX9ZQ=; t=1773660655; x=1774870255; 
	b=vK3ZbW6s8bgx+dzWgavvANjVrbYu0Dp6dRhj1Y1kp8zegm5l6vbh9ERRPnjpfDtkZ8+QEEyr9QC
	0H9I1RIzSi6YbaWNi40f8/4IB9EFjwGQIwrCDnZ67FgNZTzAIPEPZn2NkZ/cDd+/t6UE+33u+6z8p
	yKmWsFNmLKN3WVE0loeooQjmnFK2t8xVYsmR5ruUd7JVzFQaanJdi33EjPPBmOsHl2IJ17Qz+lu6t
	SEZhzN4bpo0TEzmA9ELPCMsd9sws11lx4o+01mJ26w8P4ccSVQChF3L/Z19E3raJuUEqtTuDoZ+ch
	+BC4UwJvkPWwVMICT03ll9/GCtweaMx/AxlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w269s-00000002AgY-2f6K;
	Mon, 16 Mar 2026 12:30:52 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: nl80211: use int for band coming from netlink
Date: Mon, 16 Mar 2026 12:30:50 +0100
Message-ID: <20260316123050.8c2d9f3426a0.I86acfa785982993fbffd148cc59049991bd6158f@changeid>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33298-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0A9F6298C3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This was pointed out before, but there are issues with just
removing the <0 check since enum representation isn't fixed,
nla_type() returns int but really can only return small
non-negative values, etc. Now newer versions of sparse are
also starting to warn on it. Just use int for the band var.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d2ef13ab1a20..e15cd26f3a79 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5843,7 +5843,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 	 */
 	BUILD_BUG_ON(NL80211_MAX_SUPP_HT_RATES > IEEE80211_HT_MCS_MASK_LEN * 8);
 	nla_for_each_nested(tx_rates, attrs[attr], rem) {
-		enum nl80211_band band = nla_type(tx_rates);
+		int band = nla_type(tx_rates);
 		int err;
 
 		if (band < 0 || band >= NUM_NL80211_BANDS)
@@ -10705,7 +10705,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		nla_for_each_nested(attr,
 				    info->attrs[NL80211_ATTR_SCAN_SUPP_RATES],
 				    tmp) {
-			enum nl80211_band band = nla_type(attr);
+			int band = nla_type(attr);
 
 			if (band < 0 || band >= NUM_NL80211_BANDS) {
 				err = -EINVAL;
-- 
2.53.0


