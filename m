Return-Path: <linux-wireless+bounces-31667-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB1dFSwcimmtHAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31667-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 18:41:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B3C113218
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 18:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99806302268B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B662E62C4;
	Mon,  9 Feb 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="alpr/+2d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951931C7012
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658693; cv=none; b=IRfhxov3ofM91Bi1UB6Y/7Dz8242ivdXgtWWsGY+DtnrNVx9aPVwPaDUU6W5d1xOkgTElRkHZyQHqe46zg+AuE+o7gHMU5uABzrWWaMHeS5EQAQFTumD2J9M2534hAKQ8WvImAaKDtdq5i1WxeGohEYgYqq2FTBCsi2xO7K9eZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658693; c=relaxed/simple;
	bh=MClIVHTLQ9zg5qht5GhOLgcf8lU6Zqx4tNBIny26+qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hCU9b+6toya67ez+IihXZNaXiL3BOLCjFk7j3vaQaAvWPi+OvQvu4bqgSa4Pz5mHHTBBBuRcVzpPEHvdyLby2DkwH6y9KkRGyUAlfYaGIgl8HvlqlDDf63mC4Ee5p8ontohprtvN1KVCW/F0LzAjivtvlIWb21wwTWyvP3fCPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=alpr/+2d; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=yLnAuAThzrd21mMR4sVEsL/MU80HNjV0Ujv/0WnfAXc=; t=1770658693; x=1771868293; 
	b=alpr/+2dm6jNCWlxZMLSBcJraFAM2rCUkNhuVoFea4W0z1xJ3Ln15S1DRt9hHGt+i1yoiO2vCOr
	2YLeilbO+8yAc/kAocRYN2O96X6YbNy7nVbVK9URoL9yF5Gt4+GcLWhZdHJiofsfQrIcsNfK6hE8p
	SpXrihaoc5eIg9W6WNXKtB3V1T8qH70dI1hZSV7nfVtCoJ/toc+pA4JiAw+tzw49gN3jxMWeGABYG
	gms/PVdD3cP5ZlsfnsW1Dzq2/2jfnSdJxLpBqnsfMv6/5wXrf63fen0DHjDOkuRyd8dcaqjq/l80T
	J61EtCqUW+0KCbzhH/PHipdZ4085+ZFtC7DA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vpVD8-000000037bs-1H7Y;
	Mon, 09 Feb 2026 18:38:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Jouni Malinen <j@w1.fi>
Subject: [PATCH wireless] wifi: cfg80211: wext: fix IGTK key ID off-by-one
Date: Mon,  9 Feb 2026 18:38:08 +0100
Message-ID: <20260209183808.aed18534f049.I8131f7a14278fa06df5dec019427cfc952a3a8a6@changeid>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-31667-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92B3C113218
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The IGTK key ID must be 4 or 5, but the code checks against
key ID + 1, so must check against 5/6 rather than 4/5. Fix
that.

Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/wext-compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 1241fda78a68..680500fa57cf 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -684,7 +684,7 @@ static int cfg80211_wext_siwencodeext(struct net_device *dev,
 
 	idx = erq->flags & IW_ENCODE_INDEX;
 	if (cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
-		if (idx < 4 || idx > 5) {
+		if (idx < 5 || idx > 6) {
 			idx = wdev->wext.default_mgmt_key;
 			if (idx < 0)
 				return -EINVAL;
-- 
2.53.0


