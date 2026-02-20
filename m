Return-Path: <linux-wireless+bounces-32061-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHRoI7NtmGn4IAMAu9opvQ
	(envelope-from <linux-wireless+bounces-32061-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 15:20:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0242168487
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 15:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A62B8301026F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E3834D91F;
	Fri, 20 Feb 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="j9o605Sn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B1227EB9
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597224; cv=none; b=mm1acQmmXsplm/Lcl2DCzzzvtbUbPviZQjAiTYprpCw9ySdaw0QL7DKtFnMEjQNM1l+AN7eQ3q0wdIxJx+L/oCgndmv0dRO+NCc6VHw0NZekQcNEudixyAJYjcxmVh7e5THvwiX4yPcqijFuY7eT8WH5G6AilsQW2BpclmSEC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597224; c=relaxed/simple;
	bh=1nPFUuY++WjasquNuwM7fh7uJ3Snnb5Kui/hBNGZ9t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDyiLkOhTgRrXHAWOuZpfWIfooUa89dzHIhBBK7n5KGgRXX7ZecjJRkDW7tbyo7AF156aldwKPidjL35lCRlvt19HN0JGyrfUz3IWMPYltmvQEqZQmBSPvZBsozNtXlhT73+//GkOYeCzvYrZcSNtvllXY+YjM5QxxiykoQ14BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=j9o605Sn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EjAF8gnQAcszfq1Efyp6PjtZqKe71kBRRa8iNVMrM70=;
	t=1771597223; x=1772806823; b=j9o605SnCW7BghDEYRhMMCzbJXfGxFagtFXJ60G2/asVSA2
	Gcbv29fDxEXD9eOoTjAiYQ3YKFY0WXun2Xz61OhQzEkfKpKYKCqxRiQn3yhV5nf2knQQHfXomGU0z
	0Y8TYo6M/35diSdSGm5QsFCdWVqnLJqBtUKRbJeacbZrBF6FmJZ+gR1/43FVBwp2PJj/vP1AppaQp
	0BBBVIlNUGhsak2fzoWRmpjymw5ZOI4ig+Mk3x6eCWEUtb2wS9sSc5TgP7zjiFQAnnZMXrg3uxVdj
	eYiNGr0G/9NHrIm9XAxcUqTho4DbFTORBbPcUjOx7Zz7uN7lj1TVRWmUGGvldOTQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vtRMc-0000000ECBC-2UaO;
	Fri, 20 Feb 2026 15:20:14 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 6/8] wifi: mac80211: report to cfg80211 when no STA is known for a frame
Date: Fri, 20 Feb 2026 15:19:36 +0100
Message-ID: <20260220151929.5d623731f020.I28d8146b9189c5961411ecb26b44588895de1b56@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220141929.206976-10-benjamin@sipsolutions.net>
References: <20260220141929.206976-10-benjamin@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32061-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: F0242168487
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

This is relevant for hostapd to know whether address translation was
done on a received management frame.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 net/mac80211/rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0afb67019da7..c547ad56a539 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3948,6 +3948,7 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 		.len = rx->skb->len,
 		.link_id = rx->link_id,
 		.have_link_id = rx->link_id >= 0,
+		.no_sta = !rx->sta,
 	};
 
 	/* skip known-bad action frames and return them in the next handler */
-- 
2.53.0


