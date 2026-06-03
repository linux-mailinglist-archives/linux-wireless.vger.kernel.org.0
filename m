Return-Path: <linux-wireless+bounces-37349-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kDvVJa4gIGoIwQAAu9opvQ
	(envelope-from <linux-wireless+bounces-37349-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:40:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22130637978
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:40:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=I2p2SLEm;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37349-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37349-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A4B430D522A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7933822BF;
	Wed,  3 Jun 2026 12:36:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827347D933
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 12:36:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490191; cv=none; b=hJVhucHLbVsngVJK7CklLVcUi0AWh1RG1gBacd9gcxQR+J1pIGd5hEBXfFnMAsJFKNlmJPycsynVYJ6f925VcxAfUaDxE7uhUmdiVekL2KEZF+vrDUqpnzzQL9cs0DB8lMkOoDRfiAl6nStKR8qqNViAMZE2lDw7RFSi+fu8CeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490191; c=relaxed/simple;
	bh=QBtH6fUIReqErdu7wV6vyMYB40y6HKLBr0zbOxU+/fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTIc+vdh0xtBh0DlagxWMKjZKMCBD4l9KXaJkDZfLd2z3tR1kDiWclZRKZtGV0SgpYSf3z5MJUSST9NW+lfO1/Yg8u3xuaP3oB+SnUIYaqJHKT5xu+vx3SWe/XVX7xPGqvyh6JD9M/rBj495Si+q0FwYDSqDsZF54gA92y1SkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=I2p2SLEm; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=VXNq8mYiLQZSLVxY+Ulawwo72Mxm9lg2zd9mT4enDkI=; t=1780490189; x=1781699789; 
	b=I2p2SLEmj+R69qg6s3M8zL0YLKAn21tSvvt0rXKrF6eCVi3guy1gKpwZYUXcT0rF1VVjpOuRpdM
	gfoVfBsGxVv3SV1SiCtWsj6zKUQ/ktODlajGkcFHplk88yeOhHYvEJRcWyTqDG1JR8405IGkGY9MH
	U4yfK+WKF1Bmgg48q6rpJq7ylbVvZLPMoL/ao+M5AN5ws7sJ+lVdCUStnen7tjGDZaBvSyQCxZvvL
	wuX3t6tP3lo+k1uTjvl7riAVgIlFlmfxPmrVzkmpoAu3F69KD57ZFdrzrFzFyOxtMwStOTJpS4ZwV
	fyVc7qv/JrAC8f4nw9sINnCa096F+O7DZnHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUkpe-0000000H7UU-1BzC;
	Wed, 03 Jun 2026 14:36:26 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: Free keys associated with NAN Device
Date: Wed,  3 Jun 2026 14:36:24 +0200
Message-ID: <20260603143624.c6c771885383.I929410cb8efec4fab2d42ead396bfefaf9f803f1@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:ilan.peer@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37349-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:from_mime,sipsolutions.net:dkim,intel.com:email,changeid:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22130637978

From: Ilan Peer <ilan.peer@intel.com>

A NAN Device interface can have keys associated with it, e.g.,
IGTK and BIGTK used for Tx. When a NAN Device interface is stopped,
we need to clear these keys.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 56400c22d8bc..086272c3ec08 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -648,6 +648,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 
 			spin_unlock_bh(&sdata->u.nan.de.func_lock);
 		}
+
+		/*
+		 * Free the remaining keys that might be associated with the
+		 * NAN interface, e.g., IGTK and BIGTK used for Tx.
+		 */
+		ieee80211_free_keys(sdata, true);
 		break;
 	case NL80211_IFTYPE_NAN_DATA:
 		RCU_INIT_POINTER(sdata->u.nan_data.nmi, NULL);
-- 
2.53.0


